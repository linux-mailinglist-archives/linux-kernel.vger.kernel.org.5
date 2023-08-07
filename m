Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D281477230E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjHGLuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjHGLuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33832A6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691408996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mG2NhYzfplbmKkIE00bPnzpUVGRPUtJTepr1bHxlmZQ=;
        b=HZuvuYTWxEWMgLqUnD4rEOCmMWeBhj+xa5QW8a94UxF/Pva1jTv74/1q7Ub5RgvypK7bpL
        lmIFjxMepWhkG0r1zYR8nzJiKHcjFx9lyP4lQfaPnrtuJiXSSRJX5mnVJzpMQGoSYwAZNB
        8SbeGM4MSoJKRs0ngmMImu0MaJB0Bzs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-LhjAc0kWPW2YdV4Pshkx1Q-1; Mon, 07 Aug 2023 07:49:55 -0400
X-MC-Unique: LhjAc0kWPW2YdV4Pshkx1Q-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9cca3c395so10103891fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 04:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691408993; x=1692013793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mG2NhYzfplbmKkIE00bPnzpUVGRPUtJTepr1bHxlmZQ=;
        b=Os57Ruu4asw+JKYEtKGpBgip/o3qjJvWzTNS6m0D1vsxq2nmW1OlVhil46phGEiuZv
         46/6NF/gKWFLLQ+/pWaBz1fncCFxVHCbIEQIY5xuzGPAPqCsxbxdWTgxE29CLr2sGiVN
         3iRq4+W0Aunkx4y3ruK6G6AEMXVEHWBT0XfE0jyASWX79VHCIDjXFkr6APMK8Ble1b1+
         1/NiiCqjeClPp5L7YE1/C2mbM4SSXVonvBixz85bOq01ZCpUNbyLtHcD9W7QctM+og3N
         rzd7KcbI2iokClP0NarfUHynjSYko6AfdWAkOtKi6Fa+VfNjYG2B6VnzX9RMQ8bpKd1l
         C5sQ==
X-Gm-Message-State: ABy/qLa3subCKotkpyTJ4fOqQ6xfb9+L9J6q2o/PKpqXsiduoncKf4jg
        CyAZPng3lmcra03mQ57wjWGpbQ4B0OMQTpccy8qpooFZOM95C14QdBdrOtAwZ05Fq67thm825P2
        gB1sr8cBgiaQ6rylsUrMNVFbmnVQ8PNMrG34LoVnf
X-Received: by 2002:a2e:bc84:0:b0:2b9:54bd:caed with SMTP id h4-20020a2ebc84000000b002b954bdcaedmr16712868ljf.1.1691408993631;
        Mon, 07 Aug 2023 04:49:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlExSUWhNJ81vX6HUXFUR8xlxXCSIw/e9zk4mzsUV+6UFWXVLC8jYx4RugJwmDvEGeGD4TpgCL5L3Us+HicSNVQ=
X-Received: by 2002:a2e:bc84:0:b0:2b9:54bd:caed with SMTP id
 h4-20020a2ebc84000000b002b954bdcaedmr16712862ljf.1.1691408993345; Mon, 07 Aug
 2023 04:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230806213107.GFZNARG6moWpFuSJ9W@fat_crate.local>
In-Reply-To: <20230806213107.GFZNARG6moWpFuSJ9W@fat_crate.local>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 7 Aug 2023 13:49:42 +0200
Message-ID: <CACO55tvZD5U4J8DawFTRVnV-dLYLngfhuqO29_sWNEGofKfnBg@mail.gmail.com>
Subject: Re: 2b5d1c29f6c4 ("drm/nouveau/disp: PIOR DP uses GPIO for HPD, not
 PMGR AUX interrupts")
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ben Skeggs <bskeggs@redhat.com>, regressions@leemhuis.info,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 6, 2023 at 11:40=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> Hi folks,
>
> the patch in $Subject breaks booting here on one of my test boxes, see
> below.
>
> Reverting it ontop of -rc4 fixes the issue.
>
> Thx.
>
> [    3.580535] ACPI: \_PR_.CP04: Found 4 idle states
> [    3.585694] ACPI: \_PR_.CP05: Found 4 idle states
> [    3.590852] ACPI: \_PR_.CP06: Found 4 idle states
> [    3.596037] ACPI: \_PR_.CP07: Found 4 idle states
> [    3.644065] Freeing initrd memory: 6740K
> [    3.742932] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    3.750409] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200=
) is a 16550A
> [    3.762111] serial 0000:00:16.3: enabling device (0000 -> 0003)
> [    3.771589] 0000:00:16.3: ttyS1 at I/O 0xf0a0 (irq =3D 17, base_baud =
=3D 115200) is a 16550A
> [    3.782503] Linux agpgart interface v0.103
> [    3.787805] ACPI: bus type drm_connector registered
>
> <--- boot stops here.
>

in what way does it stop? Just not progressing? That would be kinda
concerning. Mind tracing with what arguments `nvkm_uevent_add` is
called with and without that patch?

Also a boot log with `nouveau.debug=3Dtrace` might be helpful here.

> It should continue with this:
>
> [    3.795491] Console: switching to colour dummy device 80x25
> [    3.801933] nouveau 0000:03:00.0: vgaarb: deactivate vga console
> [    3.808303] nouveau 0000:03:00.0: NVIDIA GT218 (0a8c00b1)
> [    3.931002] nouveau 0000:03:00.0: bios: version 70.18.83.00.08
> [    3.941731] nouveau 0000:03:00.0: fb: 512 MiB DDR3
> [    4.110348] tsc: Refined TSC clocksource calibration: 3591.349 MHz
> [    4.116627] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x3=
3c466a1ab5, max_idle_ns: 440795209767 ns
> [    4.126871] clocksource: Switched to clocksource tsc
> [    4.252013] nouveau 0000:03:00.0: DRM: VRAM: 512 MiB
> [    4.257088] nouveau 0000:03:00.0: DRM: GART: 1048576 MiB
> [    4.262501] nouveau 0000:03:00.0: DRM: TMDS table version 2.0
> [    4.268333] nouveau 0000:03:00.0: DRM: DCB version 4.0
> [    4.273561] nouveau 0000:03:00.0: DRM: DCB outp 00: 02000360 00000000
> [    4.280104] nouveau 0000:03:00.0: DRM: DCB outp 01: 02000362 00020010
> [    4.286630] nouveau 0000:03:00.0: DRM: DCB outp 02: 028003a6 0f220010
> [    4.293176] nouveau 0000:03:00.0: DRM: DCB outp 03: 01011380 00000000
> [    4.299711] nouveau 0000:03:00.0: DRM: DCB outp 04: 08011382 00020010
> [    4.306243] nouveau 0000:03:00.0: DRM: DCB outp 05: 088113c6 0f220010
> [    4.312772] nouveau 0000:03:00.0: DRM: DCB conn 00: 00101064
> [    4.318520] nouveau 0000:03:00.0: DRM: DCB conn 01: 00202165
> [    4.329488] nouveau 0000:03:00.0: DRM: MM: using COPY for buffer copie=
s
> [    4.336261] stackdepot: allocating hash table of 1048576 entries via k=
vcalloc
> ...
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

