Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5951E77E46A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343917AbjHPO6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343957AbjHPO6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:58:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D531B2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692197863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yk77+UL4rkIMHcGRM0KHSL7Wr7OhKG9eO6qnc5jbyxA=;
        b=ZMinz6WraQmvE3Xxg+C2YFgJq2PZMjuDq4Ol3r0XDslaH/vQy35fvF7D6Wi2oo+9xBnsbW
        qARNdXs93/AeTx9yG4dvLD3rLgDtEP0vrcyPDqWLDeQBxFJBfAkxOXf7qf0WyBOov7EWWH
        MR4RVisS6TeyA85hlWRNQDOo6OhCjU8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-Qb21A0eeNvmakkmf_ZKM8w-1; Wed, 16 Aug 2023 10:57:41 -0400
X-MC-Unique: Qb21A0eeNvmakkmf_ZKM8w-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ba5464f9fcso12018041fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692197860; x=1692802660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yk77+UL4rkIMHcGRM0KHSL7Wr7OhKG9eO6qnc5jbyxA=;
        b=ViHlX+Eg5Cu7epx/tNs8J/R7uFOVHDMNnqdG7XjZ8ezQvvQiuL/wK+5TNOShe+wkJI
         PBz+VOfXiF5dJ3sShIy+SG9Lt4nDduDQaYxQdfvr+8j5OQEd1BkxU8cwWTvJ+yHBBkRy
         LSwtt3csaPOmxm9kbr7hKc8XZwjZrwpMWfWTiesIAhD1c+0coCgRVlzDuRmO/7FXSODB
         SvgLokETLhBzIkxGjUDGa7wZBeZT/+HbD8Ydny+562YwFiu6JJjxdUcER//PQEfPJVyA
         /e5CJHU3fkFCMpUrrX1t+gT0fk8XefevYzWjGr3LODpooB5zKz3a8hZE120Boag0FBE8
         KxMQ==
X-Gm-Message-State: AOJu0Yxp6GB+GF3H9VfHIBoss177j4ZDvOH0MLduNuCjrJRqoBI/frfX
        c2fYaVQwu83k9hYHvxdEIosLKy3Jvg9Fol/vqpsY0mTeMWLBLWslDekdEuiL+gTiXqqGGAivEIp
        50TTky/6/V3Nb7EFZ1OqqOjxavVNfcxzInWUk9m0a
X-Received: by 2002:a2e:9044:0:b0:2b6:120a:af65 with SMTP id n4-20020a2e9044000000b002b6120aaf65mr1677655ljg.3.1692197859985;
        Wed, 16 Aug 2023 07:57:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtXtNqg21X9ZOSLzbXnEOEcUIWB02GorJnwoMjXv3h8rzLDe9xXToWb6sVF3Vcn+RVHqVwlCLFO47V5NdG1ws=
X-Received: by 2002:a2e:9044:0:b0:2b6:120a:af65 with SMTP id
 n4-20020a2e9044000000b002b6120aaf65mr1677636ljg.3.1692197859612; Wed, 16 Aug
 2023 07:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230814144933.3956959-1-kherbst@redhat.com> <20230816093015.GDZNyXJ28y9uspb4Mr@fat_crate.local>
 <CACO55tu8ab-rxCzxFXbUh4Z=W9E-1f8sH6BVd=P+16dQ9PQNjg@mail.gmail.com> <20230816145338.GIZNzi8o3d9x9bcPzX@fat_crate.local>
In-Reply-To: <20230816145338.GIZNzi8o3d9x9bcPzX@fat_crate.local>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 16 Aug 2023 16:57:28 +0200
Message-ID: <CACO55ttasKLxBTmZjN-XBOuJFC7rng2PbLgxCT8WT6ukOZNGzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/disp: fix use-after-free in error handling of nouveau_connector_create
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 4:54=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Wed, Aug 16, 2023 at 11:51:50AM +0200, Karol Herbst wrote:
> > Mind sharing your kernel logs with that patch applied? I suspect your
> > system boots up but you might just not have the connector available or
> > something? It could be that you have one of those GPUs affected by the
> > original change and then we'd have to figure out what to do with that.
>
> Close. With your patch applied, the machine is up and I can log in and
> use it. However, the output on the connected monitor stops after...
>
> [    6.815167] ACPI: \_PR_.CP05: Found 4 idle states
> [    6.825438] ACPI: \_PR_.CP06: Found 4 idle states
> [    6.835661] ACPI: \_PR_.CP07: Found 4 idle states
> [    7.280093] Freeing initrd memory: 8328K
> [    7.601986] tsc: Refined TSC clocksource calibration: 3591.346 MHz
> [    7.608360] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x3=
3c46403b59, max_idle_ns: 440795293818 ns
> [    7.620254] clocksource: Switched to clocksource tsc
> [    8.337724] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    8.350553] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200=
) is a 16550A
> [    8.375311] serial 0000:00:16.3: enabling device (0000 -> 0003)
> [    8.403681] 0000:00:16.3: ttyS1 at I/O 0xf0a0 (irq =3D 17, base_baud =
=3D 115200) is a 16550A
> [    8.424951] Linux agpgart interface v0.103
> [    8.432456] ACPI: bus type drm_connector registered
>
> ... this line here above. It is the last one output. What you see here
> below what I'm catching from serial.
>
> [    8.456734] Console: switching to colour dummy device 80x25
> [    8.464414] nouveau 0000:03:00.0: vgaarb: deactivate vga console
> [    8.473063] nouveau 0000:03:00.0: NVIDIA GT218 (0a8c00b1)
> [    8.594096] nouveau 0000:03:00.0: bios: version 70.18.83.00.08
> [    8.607906] nouveau 0000:03:00.0: fb: 512 MiB DDR3
> [    8.926721] nouveau 0000:03:00.0: DRM: VRAM: 512 MiB
> [    8.931763] nouveau 0000:03:00.0: DRM: GART: 1048576 MiB
> [    8.937156] nouveau 0000:03:00.0: DRM: TMDS table version 2.0
> [    8.942969] nouveau 0000:03:00.0: DRM: DCB version 4.0
> [    8.948173] nouveau 0000:03:00.0: DRM: DCB outp 00: 02000360 00000000
> [    8.954696] nouveau 0000:03:00.0: DRM: DCB outp 01: 02000362 00020010
> [    8.961211] nouveau 0000:03:00.0: DRM: DCB outp 02: 028003a6 0f220010
> [    8.967739] nouveau 0000:03:00.0: DRM: DCB outp 03: 01011380 00000000
> [    8.974261] nouveau 0000:03:00.0: DRM: DCB outp 04: 08011382 00020010
> [    8.980769] nouveau 0000:03:00.0: DRM: DCB outp 05: 088113c6 0f220010
> [    8.987293] nouveau 0000:03:00.0: DRM: DCB conn 00: 00101064
> [    8.993015] nouveau 0000:03:00.0: DRM: DCB conn 01: 00202165
> [    9.005724] nouveau 0000:03:00.0: DRM: MM: using COPY for buffer copie=
s
> [    9.023889] [drm] Initialized nouveau 1.3.1 20120801 for 0000:03:00.0 =
on minor 0
> [    9.032044] nouveau 0000:03:00.0: [drm] Cannot find any crtc or sizes
> [    9.162909] megasas: 07.725.01.00-rc1
> [    9.167537] st: Version 20160209, fixed bufsize 32768, s/g segs 256
> [    9.176058] ahci 0000:00:1f.2: version 3.0
> [    9.194078] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps =
0x3 impl SATA mode
> [    9.202487] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio sl=
um part ems apst
> [    9.243154] scsi host0: ahci
> [    9.252090] scsi host1: ahci
> [    9.260389] scsi host2: ahci
> [    9.268061] scsi host3: ahci
> [    9.273542] scsi host4: ahci
> [    9.279071] scsi host5: ahci
> ...
>
> and so on until full boot.
>

okay, so the patch at least fixes the memory corruption, which is
good, so I'd go ahead and push it out as it might also fix other
unrelated crashes.

Do you have any connectors listed in "/sys/class/drm"? Also, mind
sharing your vbios.rom file from "/sys/kernel/debug/dri/0/vbios.rom"?

Thanks

> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

