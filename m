Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD585784AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjHVTzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHVTzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:55:31 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9954193
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:55:29 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-410915344aeso18784131cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1692734129; x=1693338929;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Q9PzSJsZpgiOu1CVR72fJVbG7GMfY5u21uosrtHcwo=;
        b=e3zMTcqZjXEoGwBVWslC3ZpORwORyOL8dxtzfaTXF0oqIPtpxkjNbFkGpNXZCbEG6V
         p3l8wskGUPtH5zQuvFZd4rieO5HZAaAumQFvuhWH0dIwYKcQ86kSCVyGCr0XFT08LPPx
         Hrh/+4VQmxmbCoo0AH+lCdwcW2FXaVSuYhf4JHrSxYSw0cEqa2WqgdzUKn5Re66+AGop
         JBPDgHVp3djIAPe+8R9TapVgrTkconhjvsKcU+lFzcU9j3914mj1Dq10kAno3MvAcKQe
         JrFrZ34MWWkV6OShu8/9uWHsOoaCynSGhgZFOMp+y6Cd8gT5+O/7IdZtqX+dS1WD0BBF
         eBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692734129; x=1693338929;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Q9PzSJsZpgiOu1CVR72fJVbG7GMfY5u21uosrtHcwo=;
        b=l476fk4O6GEb3yvKyWXNdnY8dXghcIJSDJMa2VGO+z7Lm7VYNXhYQksfGwfFCGsAnp
         t5gy2dIsbp96xN4lleyqZBi39HXnJspG9YFJGMtzlLV+Mk7GGNxi4Hpo2wowXTBU7jYJ
         Zugnq6yB8MwpgDqRlwEtarjOYW1jC3Y54kr/7/NvavLHo+cV281Tpy8Q38z9sQWcsGOg
         z4wPos5otZ2830RxDhV8Ldfnrq6bvEa6InTnTvyD0iIsaQWsHOcM+TOlR7kmlrfEn0va
         4t28ptJu1xZCP1vq/9hl9a6/mF2ezMk1jZMY44AoNo9RIh4jKYdZgaSTl0I7t4otWvEp
         Qxiw==
X-Gm-Message-State: AOJu0YwQIlTjV6UQnzDgQn/P+XoYbRTfpxBJiasjQeCCpmbqm6MHx/VO
        2/Iv+h+6IKhuhSK/zXil7+hMOvjFGwVqIMhVqNI=
X-Google-Smtp-Source: AGHT+IEObsx+c/lJX6FbQ9Yn/pe9TNRfUYz1pwlmVs/i9iXFeO8P55SdRnWrfg6NgJo4SUTzH6qpmw==
X-Received: by 2002:a05:622a:1907:b0:3e4:e2ce:526f with SMTP id w7-20020a05622a190700b003e4e2ce526fmr15163657qtc.39.1692734128793;
        Tue, 22 Aug 2023 12:55:28 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:bae9::7a9])
        by smtp.gmail.com with ESMTPSA id e19-20020ac86713000000b00407ffb2c24dsm3227005qtp.63.2023.08.22.12.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:55:28 -0700 (PDT)
Message-ID: <9e3c7a11ed1d50c4afdf4f181aae7d4a6a425329.camel@ndufresne.ca>
Subject: Re: [RFC]: shmem fd for non-DMA buffer sharing cross drivers
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hsia-Jun Li <Randy.Li@synaptics.com>, linux-mm@kvack.org
Cc:     dri-devel@lists.freedesktop.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        hughd@google.com, akpm@linux-foundation.org,
        Simon Ser <contact@emersion.fr>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>, daniels@collabora.com,
        ayaka <ayaka@soulik.info>, linux-kernel@vger.kernel.org
Date:   Tue, 22 Aug 2023 15:55:27 -0400
In-Reply-To: <029b982f-da62-4fa8-66c4-ab11a515574a@synaptics.com>
References: <029b982f-da62-4fa8-66c4-ab11a515574a@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mardi 22 ao=C3=BBt 2023 =C3=A0 19:14 +0800, Hsia-Jun Li a =C3=A9crit=C2=
=A0:
> Hello
>=20
> I would like to introduce a usage of SHMEM slimier to DMA-buf, the major=
=20
> purpose of that is sharing metadata or just a pure container for cross=
=20
> drivers.
>=20
> We need to exchange some sort of metadata between drivers, likes dynamic=
=20
> HDR data between video4linux2 and DRM. Or the graphics frame buffer is=
=20
> too complex to be described with plain plane's DMA-buf fd.
> An issue between DRM and V4L2 is that DRM could only support 4 planes=20
> while it is 8 for V4L2. It would be pretty hard for DRM to expend its=20
> interface to support that 4 more planes which would lead to revision of=
=20
> many standard likes Vulkan, EGL.
>=20
> Also, there is no reason to consume a device's memory for the content=20
> that device can't read it, or wasting an entry of IOMMU for such data.
> Usually, such a metadata would be the value should be written to a=20
> hardware's registers, a 4KiB page would be 1024 items of 32 bits register=
s.
>=20
> Still, I have some problems with SHMEM:
> 1. I don't want thhe userspace modify the context of the SHMEM allocated=
=20
> by the kernel, is there a way to do so?
> 2. Should I create a helper function for installing the SHMEM file as a f=
d?

Please have a look at memfd and the seal feature, it does cover the reason =
why
unsealed shared memory require full trust. For controls, the SEAL_WRITE is =
even
needed, as with appropriate timing, a malicous process can modify the data =
in-
between validation and allocation, causing possible memory overflow.

https://man7.org/linux/man-pages/man2/memfd_create.2.html
File sealing
       In the absence of file sealing, processes that communicate via
       shared memory must either trust each other, or take measures to
       deal with the possibility that an untrusted peer may manipulate
       the shared memory region in problematic ways.  For example, an
       untrusted peer might modify the contents of the shared memory at
       any time, or shrink the shared memory region.  The former
       possibility leaves the local process vulnerable to time-of-check-
       to-time-of-use race conditions (typically dealt with by copying
       data from the shared memory region before checking and using it).
       The latter possibility leaves the local process vulnerable to
       SIGBUS signals when an attempt is made to access a now-
       nonexistent location in the shared memory region.  (Dealing with
       this possibility necessitates the use of a handler for the SIGBUS
       signal.)

       Dealing with untrusted peers imposes extra complexity on code
       that employs shared memory.  Memory sealing enables that extra
       complexity to be eliminated, by allowing a process to operate
       secure in the knowledge that its peer can't modify the shared
       memory in an undesired fashion.

       [...]

regards,
Nicolas
