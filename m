Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023E57F879F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 02:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjKYBwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 20:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKYBw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 20:52:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CDF172E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 17:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700877153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhfO96FpBSwc0gssKbBJzT8GzmdBygFpNFQZ/ti3+ds=;
        b=IIkHw+MhOzEFLTYe0XRYlUQtkX3Ev0aUBHez7cngvFvJNqq96DGuxLuoJ+1TIcIWXiTwn7
        wKvnUbAE0LBCqm2SoBW+vjcjMPlOLD+bPo+k5OFf2F6kgi61VtZ+Qmv4WXRnyc2VjjTkBK
        WF8iZe5taEqskJBXPo3FEzkBV8KhBKo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-u7P5NPanNdG15jA2xHoYRw-1; Fri, 24 Nov 2023 20:52:32 -0500
X-MC-Unique: u7P5NPanNdG15jA2xHoYRw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9fa63374410so194991966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 17:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700877151; x=1701481951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhfO96FpBSwc0gssKbBJzT8GzmdBygFpNFQZ/ti3+ds=;
        b=gjZQ/rWWpYwTHdG4SdLfUmIiS3C5ZkEKy8PanGJGjginZMe7bhycttnKWwiamgxB7n
         WxbsSDU/od/LHCUP/I6NwX8eso0IepfwhpnscVve/KFuo0Vl6GtvehHvwn6nrxK04Rhn
         2chdpmTtAOxMQMsd/CFFb2Onwj6KpRXvfLZ/gzEuGzXmr0bbNsKJvAJmfdPEgnh2oKbM
         fQxNpPIuPiXZ4aBNB4m/gY+sj6rMrEs+glWfsqw6zCQz88+ht/vzA7c4e04cCTS7nAA2
         yC9pp+zQlis0jgWnvoKzJ+TIy0LniRqeS9J+FGBVRSOsCA0jXgDRzziuXJSGhOgOJYP1
         HSpg==
X-Gm-Message-State: AOJu0Yz46U5v2hTVhp3S9UG1QqN1K/6yi/QQ4I8SBHFZ/M5hIe+aKDtg
        RVcvpy/7FjUE6XMW/5ETMJAQYqM7dal1qwfZv/pZjfFfrr7+i+pMClpaQ4gdGu0cUSFIhVVraPL
        FVPVfk7g/W+93Epv0Gd5YlMI/WnVXTTbuhJRU4GX+
X-Received: by 2002:a17:906:1d2:b0:a08:e229:5659 with SMTP id 18-20020a17090601d200b00a08e2295659mr2884179ejj.17.1700877150902;
        Fri, 24 Nov 2023 17:52:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpaumkiVhGjy6q5Lg+IAR3YB6YC/o9RAyzGvDIOF4RxVoQfB0mk7GhCn0E8GqU1ws0gjXF2jPSd0lm4zyMSq8=
X-Received: by 2002:a17:906:1d2:b0:a08:e229:5659 with SMTP id
 18-20020a17090601d200b00a08e2295659mr2884167ejj.17.1700877150590; Fri, 24 Nov
 2023 17:52:30 -0800 (PST)
MIME-Version: 1.0
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
In-Reply-To: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
From:   Tao Liu <ltao@redhat.com>
Date:   Sat, 25 Nov 2023 09:51:54 +0800
Message-ID: <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
To:     Jiri Bohac <jbohac@suse.cz>
Cc:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, mhocko@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Sat, Nov 25, 2023 at 3:55=E2=80=AFAM Jiri Bohac <jbohac@suse.cz> wrote:
>
> Hi,
>
> this series implements a new way to reserve additional crash kernel
> memory using CMA.
>
> Currently, all the memory for the crash kernel is not usable by
> the 1st (production) kernel. It is also unmapped so that it can't
> be corrupted by the fault that will eventually trigger the crash.
> This makes sense for the memory actually used by the kexec-loaded
> crash kernel image and initrd and the data prepared during the
> load (vmcoreinfo, ...). However, the reserved space needs to be
> much larger than that to provide enough run-time memory for the
> crash kernel and the kdump userspace. Estimating the amount of
> memory to reserve is difficult. Being too careful makes kdump
> likely to end in OOM, being too generous takes even more memory
> from the production system. Also, the reservation only allows
> reserving a single contiguous block (or two with the "low"
> suffix). I've seen systems where this fails because the physical
> memory is fragmented.
>
> By reserving additional crashkernel memory from CMA, the main
> crashkernel reservation can be just small enough to fit the
> kernel and initrd image, minimizing the memory taken away from
> the production system. Most of the run-time memory for the crash
> kernel will be memory previously available to userspace in the
> production system. As this memory is no longer wasted, the
> reservation can be done with a generous margin, making kdump more
> reliable. Kernel memory that we need to preserve for dumping is
> never allocated from CMA. User data is typically not dumped by
> makedumpfile. When dumping of user data is intended this new CMA
> reservation cannot be used.
>

Thanks for the idea of using CMA as part of memory for the 2nd kernel.
However I have a question:

What if there is on-going DMA/RDMA access on the CMA range when 1st
kernel crash? There might be data corruption when 2nd kernel and
DMA/RDMA write to the same place, how to address such an issue?

Thanks,
Tao Liu

> There are four patches in this series:
>
> The first adds a new ",cma" suffix to the recenly introduced generic
> crashkernel parsing code. parse_crashkernel() takes one more
> argument to store the cma reservation size.
>
> The second patch implements reserve_crashkernel_cma() which
> performs the reservation. If the requested size is not available
> in a single range, multiple smaller ranges will be reserved.
>
> The third patch enables the functionality for x86 as a proof of
> concept. There are just three things every arch needs to do:
> - call reserve_crashkernel_cma()
> - include the CMA-reserved ranges in the physical memory map
> - exclude the CMA-reserved ranges from the memory available
>   through /proc/vmcore by excluding them from the vmcoreinfo
>   PT_LOAD ranges.
> Adding other architectures is easy and I can do that as soon as
> this series is merged.
>
> The fourth patch just updates Documentation/
>
> Now, specifying
>         crashkernel=3D100M craskhernel=3D1G,cma
> on the command line will make a standard crashkernel reservation
> of 100M, where kexec will load the kernel and initrd.
>
> An additional 1G will be reserved from CMA, still usable by the
> production system. The crash kernel will have 1.1G memory
> available. The 100M can be reliably predicted based on the size
> of the kernel and initrd.
>
> When no crashkernel=3Dsize,cma is specified, everything works as
> before.
>
> --
> Jiri Bohac <jbohac@suse.cz>
> SUSE Labs, Prague, Czechia
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

