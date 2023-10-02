Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A16C7B5509
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbjJBOVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237787AbjJBOU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:20:59 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84220CC4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:20:54 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1dcdfeb7e44so7979750fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696256453; x=1696861253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUOlzv+UFv92EjRw2MpN+xguuKwzgQuyeoPrL+fOaqA=;
        b=gob8W6Xq8op4c2YO27Jvj/XUlYo1P2kM8ZzkkYh8rlzXpQg8uz+ObcD4omfxH8m4P8
         w56opWUnnFI4KDsF6HISoELgpr292sKBcdhyPC6al4BbWI3DL3Y5HFR8l0vAfCzLHoIm
         bYQvLBTITLZUWj8CoSL3JGas6IHMlJnpoVrxzQ3lQ6A+hXbW5btDWQCEPeD2GaQhC68i
         lBcN86iixa6QylRtdsA08yT7StrEqO+js/z6499yL4AJDRPPvtEIH039UTAzmdh6kF8I
         l8Wiu0cV948G3+ilHy1KXjlEm+9OI9VLhUIUf5Kufw9IUnKScpPy9VGDXFiwDo5wL+cw
         prJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696256453; x=1696861253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUOlzv+UFv92EjRw2MpN+xguuKwzgQuyeoPrL+fOaqA=;
        b=ByaGWpWtyAHTOxUXKDFHOtb/wp/CeTpyM0uCV34ZPXrirp/9YS4uBwl3ZoK33Q0Seu
         XiW8Fj5D8mtQ4VxmoeJ9iN8WH7Qv1OLm+yPSxTVqiySAQethFfv1dJCV7JxLm3AtADos
         k+ZkSt6612cwjNV3ygkWNHeEZ3X+U8kMDlYWMmoOB07D2W73+es2fDN3cnwGaWHcrVBq
         bJnZ4OPhsBU6U/6GVuJOmHvDJHza5X6GUeE6ZZ5PFM3x4Xw49LfsRdBU8b3xN4KYQt9B
         euHlx+MnI5YMZBcUvItHv+U3KMEHrvSSM5bhndUoKg0nYEa12ZD8YKMWibGx6D00q7w+
         x/fg==
X-Gm-Message-State: AOJu0YyVfs7oElTA1pd/t26lvURScWvPc1SxiN6KpMNP+Bt0Y6YRvzyJ
        q2cY5xVPP2pA6BBoKyeFm2bMZpGqX/t3rj/uBvkcyvN2I/k=
X-Google-Smtp-Source: AGHT+IH/31AOMMoNa1PznWx4AqPqP41PY3lJbTGBZgZhfJX8r58BHRpOT8Xbm/9DYz6e040gDuQnL+2xiLkGQkes3SI=
X-Received: by 2002:a05:6870:a454:b0:1dc:8191:8aa with SMTP id
 n20-20020a056870a45400b001dc819108aamr13317859oal.44.1696256453364; Mon, 02
 Oct 2023 07:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAO9zADy4b1XkD_ZaEF+XkDCXePJLD4Lev3g7HAEGYsCHgeM+KQ@mail.gmail.com>
 <ZRoIGhMesKtmNkAM@debian.me>
In-Reply-To: <ZRoIGhMesKtmNkAM@debian.me>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 2 Oct 2023 10:20:42 -0400
Message-ID: <CADnq5_Nxtuu-cO+5DNaF+anD9_7J9Ahpr3+4JGfYEmzdM1Kw_w@mail.gmail.com>
Subject: Re: 6.5.5: UBSAN: radeon_atombios.c: index 1 is out of range for type
 'UCHAR [1]'
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Justin Piszcz <jpiszcz@lucidpixels.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 3:40=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com>=
 wrote:
>
> On Sun, Oct 01, 2023 at 07:05:11PM -0400, Justin Piszcz wrote:
> > Hello,
> >
> > Kernel: 6.5.5
> > Arch: x86_64
> > Distribution: Debian testing
> >
> > Recently, I enabled UBSAN and noticed the following at boot time with
> > an older AMD graphics card, is this considered normal when using the
> > AMD firmware-linux-nonfree package?

This is actually a variable sized array we are indexing:

typedef struct _ATOM_PPLIB_STATE
{
    UCHAR ucNonClockStateIndex;
    UCHAR ucClockStateIndices[1]; // variable-sized
} ATOM_PPLIB_STATE;

So it's a false positive.  I guess it should be converted to variable
sized array changes others have been working on.

Alex

> >
> > [ .. ]
> > [Sun Oct  1 15:59:04 2023] ACPI: bus type drm_connector registered
> > [Sun Oct  1 15:59:04 2023] [drm] radeon kernel modesetting enabled.
> > [Sun Oct  1 15:59:04 2023] [drm] initializing kernel modesetting
> > (CEDAR 0x1002:0x68E1 0x1787:0x3000 0x00).
> > [Sun Oct  1 15:59:04 2023] ATOM BIOS: PARK
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: VRAM: 1024M
> > 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: GTT: 1024M
> > 0x0000000040000000 - 0x000000007FFFFFFF
> > [Sun Oct  1 15:59:04 2023] [drm] Detected VRAM RAM=3D1024M, BAR=3D256M
> > [Sun Oct  1 15:59:04 2023] [drm] RAM width 64bits DDR
> > [Sun Oct  1 15:59:04 2023] [drm] radeon: 1024M of VRAM memory ready
> > [Sun Oct  1 15:59:04 2023] [drm] radeon: 1024M of GTT memory ready.
> > [Sun Oct  1 15:59:04 2023] [drm] Loading CEDAR Microcode
> > [Sun Oct  1 15:59:04 2023] [drm] Internal thermal controller with fan c=
ontrol
> > [Sun Oct  1 15:59:04 2023]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > [Sun Oct  1 15:59:04 2023] UBSAN: array-index-out-of-bounds in
> > drivers/gpu/drm/radeon/radeon_atombios.c:2620:43
> > [Sun Oct  1 15:59:04 2023] index 1 is out of range for type 'UCHAR [1]'
> > [Sun Oct  1 15:59:04 2023] CPU: 5 PID: 1 Comm: swapper/0 Tainted: G
> >             T  6.5.5 #13 55df8de52754ef95effc50a55e9206abdea304ac
> > [Sun Oct  1 15:59:04 2023] Hardware name: Supermicro X9SRL-F/X9SRL-F,
> > BIOS 3.3 11/13/2018
> > [Sun Oct  1 15:59:04 2023] Call Trace:
> > [Sun Oct  1 15:59:04 2023]  <TASK>
> > [Sun Oct  1 15:59:04 2023]  dump_stack_lvl+0x36/0x50
> > [Sun Oct  1 15:59:04 2023]  __ubsan_handle_out_of_bounds+0xc7/0x110
> > [Sun Oct  1 15:59:04 2023]  radeon_atombios_get_power_modes+0x87a/0x8f0
> > [Sun Oct  1 15:59:04 2023]  radeon_pm_init+0x13a/0x7e0
> > [Sun Oct  1 15:59:04 2023]  evergreen_init+0x13d/0x3d0
> > [Sun Oct  1 15:59:04 2023]  radeon_device_init+0x60a/0xbf0
> > [Sun Oct  1 15:59:04 2023]  radeon_driver_load_kms+0xb1/0x250
> > [Sun Oct  1 15:59:04 2023]  drm_dev_register+0xfc/0x250
> > [Sun Oct  1 15:59:04 2023]  radeon_pci_probe+0xd0/0x150
> > [Sun Oct  1 15:59:04 2023]  pci_device_probe+0x97/0x130
> > [Sun Oct  1 15:59:04 2023]  really_probe+0xbe/0x2f0
> > [Sun Oct  1 15:59:04 2023]  ? __pfx___driver_attach+0x10/0x10
> > [Sun Oct  1 15:59:04 2023]  __driver_probe_device+0x6e/0x120
> > [Sun Oct  1 15:59:04 2023]  driver_probe_device+0x1a/0x90
> > [Sun Oct  1 15:59:04 2023]  __driver_attach+0xd4/0x170
> > [Sun Oct  1 15:59:04 2023]  bus_for_each_dev+0x87/0xe0
> > [Sun Oct  1 15:59:04 2023]  bus_add_driver+0xf3/0x1f0
> > [Sun Oct  1 15:59:04 2023]  driver_register+0x58/0x120
> > [Sun Oct  1 15:59:04 2023]  ? __pfx_radeon_module_init+0x10/0x10
> > [Sun Oct  1 15:59:04 2023]  do_one_initcall+0x93/0x4a0
> > [Sun Oct  1 15:59:04 2023]  kernel_init_freeable+0x301/0x580
> > [Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
> > [Sun Oct  1 15:59:04 2023]  kernel_init+0x15/0x1b0
> > [Sun Oct  1 15:59:04 2023]  ret_from_fork+0x2f/0x50
> > [Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
> > [Sun Oct  1 15:59:04 2023]  ret_from_fork_asm+0x1b/0x30
> > [Sun Oct  1 15:59:04 2023]  </TASK>
> > [Sun Oct  1 15:59:04 2023]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > [Sun Oct  1 15:59:04 2023] [drm] radeon: dpm initialized
> > [Sun Oct  1 15:59:04 2023] [drm] GART: num cpu pages 262144, num gpu
> > pages 262144
> > [Sun Oct  1 15:59:04 2023] [drm] enabling PCIE gen 2 link speeds,
> > disable with radeon.pcie_gen2=3D0
> > [Sun Oct  1 15:59:04 2023] [drm] PCIE GART of 1024M enabled (table at
> > 0x000000000014C000).
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: WB enabled
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 0
> > use gpu addr 0x0000000040000c00
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 3
> > use gpu addr 0x0000000040000c0c
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 5
> > use gpu addr 0x000000000005c418
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: MSI limited to =
32-bit
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: using MSI.
> > [Sun Oct  1 15:59:04 2023] [drm] radeon: irq initialized.
> >
>
> Please also open an issue on freedesktop tracker [1].
>
> Thanks.
>
> [1]: https://gitlab.freedesktop.org/drm/amd/-/issues
>
> --
> An old man doll... just what I always wanted! - Clara
