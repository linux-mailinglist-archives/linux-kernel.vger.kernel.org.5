Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D167B4A47
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 01:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjJAXF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 19:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjJAXF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 19:05:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0759A9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 16:05:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27751ac0653so8634061a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 16:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1696201524; x=1696806324; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kxd89DWQG02eogtUo0gNrxnzVrzAlQJ+6Isrfbr7rX8=;
        b=GW5TN0zjgG+8q/G7KKvJhZ5Tm3Rex/QU1ty0IOWUSLAU+r+RmM0KRF8hv2bOne/Imv
         LLcSxKMHSfXAWaRrJudZ2/Ysv0pE16E3hGJQdGjeeZU8pUHs+kZowcdjaySbEWtW69Yw
         R2aBX5Y6gn2Vz/If1NSR9IqnK7VHuP2E1hq8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696201524; x=1696806324;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kxd89DWQG02eogtUo0gNrxnzVrzAlQJ+6Isrfbr7rX8=;
        b=VGWqS8wJkyGC1rXrygiiUd1LR4hvISi+KPCTb8CLDwwDDL4y8dl58Gm6z5ZSWuG5yI
         xvekVqmzzqpLqXeyixNSRdJva0wXJypeAO+aKdvPDRk4Y1515KZqVEgOi4WeQgr5FRAn
         g9G+suwaDn5wBk8ncS+D/EJt/uCMgv+icxcJAdv7/eC+mGNJOAE0cbT0a9cVd0Go5Kqk
         2665fw0Z/Y7tQwqrntwzm521KeU2Za6HzQvvD3qvGEog4zoxR1VTaY5Wo0/2yycJO6n5
         UpZCD4/WzT4027f42lKOK+PboyvB+QslMzDvz7Fo/gOvqPGJX4wHYycbcFRwIICtOaxp
         +Xmg==
X-Gm-Message-State: AOJu0YzE/tpBx2/7sqEqkKFfbXxFjtuWqzPYdZ8K1Wn3kh/zRqH2Ucsf
        asz+ydGjew/R797Cuy8My4RU5JTwKuYXey7l4QSb7L7Du1RthnjkIJUfTg==
X-Google-Smtp-Source: AGHT+IHO5LxRExh4wl0Z7cCfjevdnuCYcjK7FOgVrx26qNssIFDL2iCopALImgZcj+JEwnshlmv9TTK/mWZRfzlDHmU=
X-Received: by 2002:a17:90a:f409:b0:26b:9e2:1298 with SMTP id
 ch9-20020a17090af40900b0026b09e21298mr7511680pjb.11.1696201523799; Sun, 01
 Oct 2023 16:05:23 -0700 (PDT)
MIME-Version: 1.0
From:   Justin Piszcz <jpiszcz@lucidpixels.com>
Date:   Sun, 1 Oct 2023 19:05:11 -0400
Message-ID: <CAO9zADy4b1XkD_ZaEF+XkDCXePJLD4Lev3g7HAEGYsCHgeM+KQ@mail.gmail.com>
Subject: 6.5.5: UBSAN: radeon_atombios.c: index 1 is out of range for type
 'UCHAR [1]'
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Kernel: 6.5.5
Arch: x86_64
Distribution: Debian testing

Recently, I enabled UBSAN and noticed the following at boot time with
an older AMD graphics card, is this considered normal when using the
AMD firmware-linux-nonfree package?

[ .. ]
[Sun Oct  1 15:59:04 2023] ACPI: bus type drm_connector registered
[Sun Oct  1 15:59:04 2023] [drm] radeon kernel modesetting enabled.
[Sun Oct  1 15:59:04 2023] [drm] initializing kernel modesetting
(CEDAR 0x1002:0x68E1 0x1787:0x3000 0x00).
[Sun Oct  1 15:59:04 2023] ATOM BIOS: PARK
[Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: VRAM: 1024M
0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: GTT: 1024M
0x0000000040000000 - 0x000000007FFFFFFF
[Sun Oct  1 15:59:04 2023] [drm] Detected VRAM RAM=1024M, BAR=256M
[Sun Oct  1 15:59:04 2023] [drm] RAM width 64bits DDR
[Sun Oct  1 15:59:04 2023] [drm] radeon: 1024M of VRAM memory ready
[Sun Oct  1 15:59:04 2023] [drm] radeon: 1024M of GTT memory ready.
[Sun Oct  1 15:59:04 2023] [drm] Loading CEDAR Microcode
[Sun Oct  1 15:59:04 2023] [drm] Internal thermal controller with fan control
[Sun Oct  1 15:59:04 2023]
================================================================================
[Sun Oct  1 15:59:04 2023] UBSAN: array-index-out-of-bounds in
drivers/gpu/drm/radeon/radeon_atombios.c:2620:43
[Sun Oct  1 15:59:04 2023] index 1 is out of range for type 'UCHAR [1]'
[Sun Oct  1 15:59:04 2023] CPU: 5 PID: 1 Comm: swapper/0 Tainted: G
            T  6.5.5 #13 55df8de52754ef95effc50a55e9206abdea304ac
[Sun Oct  1 15:59:04 2023] Hardware name: Supermicro X9SRL-F/X9SRL-F,
BIOS 3.3 11/13/2018
[Sun Oct  1 15:59:04 2023] Call Trace:
[Sun Oct  1 15:59:04 2023]  <TASK>
[Sun Oct  1 15:59:04 2023]  dump_stack_lvl+0x36/0x50
[Sun Oct  1 15:59:04 2023]  __ubsan_handle_out_of_bounds+0xc7/0x110
[Sun Oct  1 15:59:04 2023]  radeon_atombios_get_power_modes+0x87a/0x8f0
[Sun Oct  1 15:59:04 2023]  radeon_pm_init+0x13a/0x7e0
[Sun Oct  1 15:59:04 2023]  evergreen_init+0x13d/0x3d0
[Sun Oct  1 15:59:04 2023]  radeon_device_init+0x60a/0xbf0
[Sun Oct  1 15:59:04 2023]  radeon_driver_load_kms+0xb1/0x250
[Sun Oct  1 15:59:04 2023]  drm_dev_register+0xfc/0x250
[Sun Oct  1 15:59:04 2023]  radeon_pci_probe+0xd0/0x150
[Sun Oct  1 15:59:04 2023]  pci_device_probe+0x97/0x130
[Sun Oct  1 15:59:04 2023]  really_probe+0xbe/0x2f0
[Sun Oct  1 15:59:04 2023]  ? __pfx___driver_attach+0x10/0x10
[Sun Oct  1 15:59:04 2023]  __driver_probe_device+0x6e/0x120
[Sun Oct  1 15:59:04 2023]  driver_probe_device+0x1a/0x90
[Sun Oct  1 15:59:04 2023]  __driver_attach+0xd4/0x170
[Sun Oct  1 15:59:04 2023]  bus_for_each_dev+0x87/0xe0
[Sun Oct  1 15:59:04 2023]  bus_add_driver+0xf3/0x1f0
[Sun Oct  1 15:59:04 2023]  driver_register+0x58/0x120
[Sun Oct  1 15:59:04 2023]  ? __pfx_radeon_module_init+0x10/0x10
[Sun Oct  1 15:59:04 2023]  do_one_initcall+0x93/0x4a0
[Sun Oct  1 15:59:04 2023]  kernel_init_freeable+0x301/0x580
[Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
[Sun Oct  1 15:59:04 2023]  kernel_init+0x15/0x1b0
[Sun Oct  1 15:59:04 2023]  ret_from_fork+0x2f/0x50
[Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
[Sun Oct  1 15:59:04 2023]  ret_from_fork_asm+0x1b/0x30
[Sun Oct  1 15:59:04 2023]  </TASK>
[Sun Oct  1 15:59:04 2023]
================================================================================
[Sun Oct  1 15:59:04 2023] [drm] radeon: dpm initialized
[Sun Oct  1 15:59:04 2023] [drm] GART: num cpu pages 262144, num gpu
pages 262144
[Sun Oct  1 15:59:04 2023] [drm] enabling PCIE gen 2 link speeds,
disable with radeon.pcie_gen2=0
[Sun Oct  1 15:59:04 2023] [drm] PCIE GART of 1024M enabled (table at
0x000000000014C000).
[Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: WB enabled
[Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 0
use gpu addr 0x0000000040000c00
[Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 3
use gpu addr 0x0000000040000c0c
[Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 5
use gpu addr 0x000000000005c418
[Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: MSI limited to 32-bit
[Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: using MSI.
[Sun Oct  1 15:59:04 2023] [drm] radeon: irq initialized.

Regards,
Justin
