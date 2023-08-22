Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDD57837CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjHVCSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjHVCSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:18:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CA9FD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:18:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so6991148a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692670719; x=1693275519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJXlFOteHKVLHeYr+snSmPCLP+Kkg8KkznNpC4Ohn2U=;
        b=oyUKrebEodO8eBe4eCBxrUam8TTXfzWLUqr66grKvJs9PiENIqlWPsskUJe4z1lPJ6
         mOFcED65FYHXQBDOWPofmMxVwVz1fqIf2qVTqBlQqeGuJ5wIIW/FK+0vHbN+MEHFgh+n
         eKV9M/auehk+ks1yMzfz4OPj3r8tDMkruzCGkAru7f6EJBcNYBNAVILDqWoL6Y2xXHKX
         e1BCgNwk4l2o5DjpmaAH7oKVvuDtpUFAy8MgzQMCgSFAhClSxYW4C/M/1QDJighZJxEf
         gtESioQKo9ZmBNUu600/Zj71S8AQTjVATYNWJdNX2L8rYYdPf5qWGiB8CjQvOT58mzh1
         kfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692670719; x=1693275519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJXlFOteHKVLHeYr+snSmPCLP+Kkg8KkznNpC4Ohn2U=;
        b=H23TGAPxZXHdj7eDp87SwVFU6EyB/T0vz5dvugVMSutW5YJvR1ZUCvFwGzdtTvEEyy
         +Q1RItyUMSN/8d32dv/vG5PyjSt+EHts3qHTEx91aHkEPKRh/gsgamOjEdTNHoHVqpmc
         yHBwKleGb7ptwsYDD5zhTBw1jX3G6LVhM7D6KOJT3/pA5Yww8Uh4XB218mjWjzXONkSh
         d31Nqa+FuSPJ2g+cyD4o/kWgM6nstS23rTyC44Iavxq25+1+xHZ4KlWgN+0P2DboOCV2
         mVq/lz9ABq+KE/q2Pta5p1pJSKiLSblwXxp+tZURaGVIdJWxdlfNBbYVdyYgbGZVtmrd
         GPSw==
X-Gm-Message-State: AOJu0YwIVanEtALaZ9Yk2aW40wM+fLVseHrZxgoCsdZwZRM1lGMJY0mh
        p9I3SpuuZOB+4jKRKk3Cw3ca2s24QwmpkWZlKJM=
X-Google-Smtp-Source: AGHT+IFNkRjoVyAheSXa8tJIeWpkCBCCqwGPsvgGJf4WYdFivvJtkgK/J6KHVOYP+1GwpwtquHU31CzzdIB+p4tKbCQ=
X-Received: by 2002:aa7:d058:0:b0:522:18b6:c01f with SMTP id
 n24-20020aa7d058000000b0052218b6c01fmr9447384edo.3.1692670719483; Mon, 21 Aug
 2023 19:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <CADXzsigVPkgkx4vmaKnhGuMdjt_3w0Fo3eFqDNSwyoH9JCrRQw@mail.gmail.com>
 <46e286cb-ca1a-4b5a-153f-0e0cade22bb9@metux.net>
In-Reply-To: <46e286cb-ca1a-4b5a-153f-0e0cade22bb9@metux.net>
From:   Raj J Putari <jmaharaj2013@gmail.com>
Date:   Mon, 21 Aug 2023 19:18:28 -0700
Message-ID: <CADXzsihPteW5_gjg94AVd=Fa1fgAsdAR7rvz+4VK_fZMHUtjfw@mail.gmail.com>
Subject: Re: using gpu's to accelerate the linux kernel
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nice read!

i was thinking of a kernel module that does stuff like offload some
work to the gpu.. like we can have like gpuaccel.ko that does stuff
like wrap gpu calls to stuff like compiles or low level stuff like
heavy computes, just looked up a few apis and it looks like opencl and
cuda are meant for 3d computation, so some way to access the gpus
compute internals would take some hacking, not sure if its possible

it would be awesome if we can offload some compilation from stuff like
cc and c++ to the gpu, if the technology is available (maybe with
amd?)


On Mon, Aug 21, 2023 at 7:21=E2=80=AFAM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> On 27.04.23 12:51, Raj J Putari wrote:
>
> > id write it but im an amatuer and i dont have time to read the kernel
> > source and experiment, we're talking about nvidia and amd video cards
> > assisting in processing heavy data.
>
> obviously not w/ NVidia (except for some old, already reverse-engineered
> gpus), since Nvidia is doing all they can hiding the necessary specs
> to write drivers from us.
>
> Forget about Nvidia. Never ever waste a single penny on that.
>
> > lets say youre compiling a kernel, you can write optimizations into
> > the kernel through a cuda module and offload cpu data directly to the
> > gpu using opencl or cuda or what amd supplies,
>
> cuda, opencl, etc, are *userland* *library* APIs. They don't work inside
> the kernel. One had to write something similar *inside* the kernel
> (which is working very differently from userland). Also consider that
> the most complex stuff (eg. creating command streams) is done in
> userland (eg. mesa's pipe drivers, ...), the kernel is just responsible
> for some more lowlevel things like buffer management, modesetting, etc.
>
>
> If you wanna go that route, you'd have to create something like Mesa's
> Gallium inside the kernel. Besides that this is a pretty huge task
> (and you'd have to reimplement lots of drivers), you'd also have to
> find a way to get a good performance when calling from userland (note
> that syscalls, even ioctls, etc, are much more expensive than just
> plain library function calls inside the same process). Probably comes
> down to using some bytecode (tgsi ?) and loading it somewhat similar
> to bpf.
>
>
> Assuming that's really up and running one day, it indeed could solve
> other problems, eg. clear separation between containers and hosts
> (for now, containers still needs the userland parts of gpu drivers
> for the corresponding host hardware).
>
> But be warned: this is a huge endavour, *a lot* work to do and hard
> to get it right.
>
>
> OTOH, I'm yet sceptical whether there's much practical use cases for
> using GPUs by the kernel *itself*. What exactly do you have in mind
> here ?
>
>
> --mtx
>
> --
> ---
> Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt u=
nd manipuliert
> werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren
> GPG/PGP-Schl=C3=BCssel zu.
> ---
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
