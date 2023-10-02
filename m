Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DD77B4A6E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 02:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbjJBAM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 20:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJBAMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 20:12:24 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F326DD7
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 17:12:21 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c4bf619b57so8549656a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 17:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1696205541; x=1696810341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GFCHGpbpyraI/3FGZPNhIjojebHHdCoO8NPiTDHixqM=;
        b=SdpX0qTJVPglBn4VJyQ2MkeQfCYdZtn1FyJ/Jit1oy4bDYa/zl3CdPEZwlkPmtTwd2
         KHErJ1vjsIyAxm7cnyLeeK+rAA9bfBZBE0KQRFlMK52g+PAiIVxNElvLobu3bDX1UPbV
         sn175PvGnCK5k+imave748x2q0omvFoi4ONUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696205541; x=1696810341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFCHGpbpyraI/3FGZPNhIjojebHHdCoO8NPiTDHixqM=;
        b=PEA1p5JegUqM+ZI5jt4W5LX5WisJktmOlHWMrd/PQqgljtX3gzqPdkIysu+hDTZCPo
         vo1jEcvFl/rBWvcYgJtei3cunWP7HGrOZ38yNEvspzM7j1F5lrfvgQ5UnJ/cftgvHGQX
         +FJ6jG/vBxzYkrFZkP5eIK3b/6S/U34KbrWKRNExHDcVe60cRP4mIGAa0N/ObVjIwj0F
         XIVfeHvC6P/fomnJ/qKMtjoLwmNyipMb7nVVyFhtHs1ns2kA6u1+3ip6nT9N3gPi4shI
         o3guNeubiDJtsOrNpxSogUMv7ZWGkvdo6zVvLQXYZGXdLpqod6dyzfNu2XPrtUirCEzE
         4gvg==
X-Gm-Message-State: AOJu0YyY/bpUEQGvpUB09jKPhKSHkS14J/XVzCiPVFt0B71iQjaygdMH
        TMLsZyfIxazJ9gY0MnNCw5WACdULse9MkaKlwvxkI55hxxZNtmTrrbq6Vg==
X-Google-Smtp-Source: AGHT+IHGsZm62WWO4Snv2PQvtIfISUWnk/mWHvXfJC7YDU3eKhOk+Wj3mHp6dQoESefI2pcpUzsTPaPQQhevaW02ogM=
X-Received: by 2002:a05:6808:1495:b0:3ab:7f46:ecc5 with SMTP id
 e21-20020a056808149500b003ab7f46ecc5mr13517982oiw.35.1696205541085; Sun, 01
 Oct 2023 17:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAO9zADy4b1XkD_ZaEF+XkDCXePJLD4Lev3g7HAEGYsCHgeM+KQ@mail.gmail.com>
 <ZRoIGhMesKtmNkAM@debian.me>
In-Reply-To: <ZRoIGhMesKtmNkAM@debian.me>
From:   Justin Piszcz <jpiszcz@lucidpixels.com>
Date:   Sun, 1 Oct 2023 20:12:08 -0400
Message-ID: <CAO9zADyfaLRWB-0rdojnbFD6SUsqX+zb9JZSZUkgTC7VJN=c1A@mail.gmail.com>
Subject: Re: 6.5.5: UBSAN: radeon_atombios.c: index 1 is out of range for type
 'UCHAR [1]'
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > ================================================================================
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
> > ================================================================================
> > [Sun Oct  1 15:59:04 2023] [drm] radeon: dpm initialized
> > [Sun Oct  1 15:59:04 2023] [drm] GART: num cpu pages 262144, num gpu
> > pages 262144
> > [Sun Oct  1 15:59:04 2023] [drm] enabling PCIE gen 2 link speeds,
> > disable with radeon.pcie_gen2=0
> > [Sun Oct  1 15:59:04 2023] [drm] PCIE GART of 1024M enabled (table at
> > 0x000000000014C000).
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: WB enabled
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 0
> > use gpu addr 0x0000000040000c00
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 3
> > use gpu addr 0x0000000040000c0c
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 5
> > use gpu addr 0x000000000005c418
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: MSI limited to 32-bit
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: using MSI.
> > [Sun Oct  1 15:59:04 2023] [drm] radeon: irq initialized.
> >
>
> Please also open an issue on freedesktop tracker [1].
>
> Thanks.
>
> [1]: https://gitlab.freedesktop.org/drm/amd/-/issues

Issue opened: https://gitlab.freedesktop.org/drm/amd/-/issues/2894

Regards,
Justin
