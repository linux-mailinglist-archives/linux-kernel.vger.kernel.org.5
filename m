Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391687BE757
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377353AbjJIRGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377233AbjJIRGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:06:19 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC91B0;
        Mon,  9 Oct 2023 10:06:17 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-58d26cfe863so593618a12.2;
        Mon, 09 Oct 2023 10:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696871176; x=1697475976; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=alAM6VWvT7w5zEUZ/EOiNWxb+e/a+sG0fmbQb63mpTg=;
        b=XzOEWQrSyyQgDG6RibL9RbtzFZ/GgxFcXLdL82l2fAFWNyd52gsnRnHLieMFVOOu57
         EWCxNS8AzG+Dfi2Ljy14q0ZStcB/uhHDGoi+UpaIdv4eRzpczhC0TMr5ufewokxghbMj
         MmLo1mhs+kL6dmqJncTJgnajc2iWMgSzYaAy1k0TpBZANItuewYnrXq6AyVT0LeCK37w
         HE6RV3fR5AZxv/dIIgWt0Fzc+qtZN4Eur20ZILyj7O3IAv6In9xKvCN+kLF4ftZLsggq
         mW6CZUfqtUdPpUI3rK4qhmh6kXJ4BAY7rvJUrWDFU5xcily7tw2y/8nUAjQR6t0To96k
         lnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696871176; x=1697475976;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=alAM6VWvT7w5zEUZ/EOiNWxb+e/a+sG0fmbQb63mpTg=;
        b=urfzjYtctYIRziXx/6p0w04fB4mYRHuGh5UQ91z+sXVYmUXigR6zjVyQONiQluR08w
         yiBx3CIe7DPopT0Od12t35YeVFUut3Ofb+GMMkt4+CwF2qUAOwqZIrer8WUA8Tbn1DN5
         q2XtPMnjQRoh8yTRlng1NmFHq0GON94ludI7jSfUTBQXnbM2V9JO8KnRaYwyVd9Z2i1K
         wMgzV0JmGJWorC6huO2kF6qiB744mrDHkyhcPo7m//dgBUc9t/KiX0IXfU6Q7Ne9uiIv
         Dka8NWwFvmWq0BGIUmMCc9dOXNZBFOiBT606K+Fu2LhSgmo8iu4lHwaIUj3ok/QRCjpW
         ET+A==
X-Gm-Message-State: AOJu0YzvqzRCPiDjvpgl/DhvcMoOJ8TD+cGVYCUB2m6kReBRXNYRIzxa
        /+obHPfhkkG5M/2yIc21Nyl+1UOSOZKSu15MoyE6YMnGDek=
X-Google-Smtp-Source: AGHT+IH6QxZ3mx0DIzoTCEKf3EGXdsoPVbvKtwcSvIpq93komXDs8RQpUCraup1ygBbMl1MwougJSd3FlV2lcEsIxKw=
X-Received: by 2002:a17:90a:fb83:b0:262:ded7:63d with SMTP id
 cp3-20020a17090afb8300b00262ded7063dmr13683164pjb.17.1696871176124; Mon, 09
 Oct 2023 10:06:16 -0700 (PDT)
MIME-Version: 1.0
From:   Manish Shakya <manishshakya.nd@gmail.com>
Date:   Mon, 9 Oct 2023 13:06:04 -0400
Message-ID: <CAAPJt9JsAE6Q7ce8fRraw6-AcZm=_4tdfPaCBMSrSLJp+G=J4w@mail.gmail.com>
Subject: zynq7k: boot failure at internal_create_group
To:     kernel-testers@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a zynq 7020 embedded board running openwrt with 5.15.118
kernel. When I do a power cycle test, the board generally boots up but
occasionally fails with following logs.

[    0.730000] 8<--- cut here ---
[    0.740000] Unable to handle kernel paging request at virtual
address ffffffff
[    0.740000] pgd = (ptrval)
[    0.750000] [ffffffff] *pgd=200f6861, *pte=00000000, *ppte=00000000
[    0.750000] Internal error: Oops: 37 [#1] SMP ARM
[    0.750000] Modules linked in:
[    0.750000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.118 #0
[    0.750000] Hardware name: Xilinx Zynq Platform
[    0.750000] PC is at internal_create_group+0x94/0x3ac
[    0.750000] LR is at internal_create_group+0x78/0x3ac
[    0.750000] pc : [<c02b68f0>]    lr : [<c02b68d4>]    psr: a0000053
[    0.750000] sp : c0055e30  ip : 00000000  fp : 00000000
[    0.750000] r10: c083efe0  r9 : c0f88d68  r8 : c0fc0044
[    0.750000] r7 : 00000000  r6 : c097d3f4  r5 : ffffffff  r4 : c0fc0000
[    0.750000] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : c0f88d68
[    0.750000] Flags: NzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM
Segment none
[    0.750000] Control: 18c5387d  Table: 0020404a  DAC: 00000051
[    0.750000] Register r0 information: slab kernfs_node_cache start
c0f88d68 pointer offset 0
[    0.750000] Register r1 information: NULL pointer
[    0.750000] Register r2 information: NULL pointer
[    0.750000] Register r3 information: NULL pointer
[    0.750000] Register r4 information: slab request_queue start
c0fc0000 pointer offset 0
[    0.750000] Register r5 information: non-paged memory
[    0.750000] Register r6 information: non-slab/vmalloc memory
[    0.750000] Register r7 information: NULL pointer
[    0.750000] Register r8 information: slab request_queue start
c0fc0000 pointer offset 68
[    0.750000] Register r9 information: slab kernfs_node_cache start
c0f88d68 pointer offset 0
[    0.750000] Register r10 information: non-slab/vmalloc memory
[    0.750000] Register r11 information: NULL pointer
[    0.750000] Register r12 information: NULL pointer
[    0.750000] Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
[    0.750000] Stack: (0xc0055e30 to 0xc0056000)
[    0.750000] 5e20:                                     c097e580
c097e580 c0fc0044 00000000
[    0.750000] 5e40: 00000000 00000000 00000000 00000000 c0a40368
c0fc0000 00000000 c0a40368
[    0.750000] 5e60: c0fc0044 c0fc0470 c0a40368 c083efe0 00000000
c0368e58 c0f55240 c0a40340
[    0.750000] 5e80: c0a40340 c09c58d0 00000000 c0a40368 c083efe0
c037a9e4 c0f55240 00000004
[    0.750000] 5ea0: c0f5f5c0 00000000 c0f5524c c0995020 c083efe0
c043ffcc c0a10b28 306d6172
[    0.750000] 5ec0: c0753000 c0253348 c0a12220 c0a10b28 c0a12220
c0334360 c0995008 7450f831
[    0.750000] 5ee0: c0983f70 c09c6e68 00000001 c0983f78 c083701c
c081eec8 c0995008 c081edf8
[    0.750000] 5f00: ffffe000 00000000 c083701c c01017ec c01751d0
00000000 00000081 00000000
[    0.750000] 5f20: c003f2e0 c003f2e6 c07c305c 00000080 00000081
c013ca18 c0761f90 00000000
[    0.750000] 5f40: 00000006 00000006 c003f2e6 00000000 c083ec44
00000081 c003f280 7450f831
[    0.750000] 5f60: 00000006 00000081 c003f280 c083703c 00000006
c08013d0 00000006 00000006
[    0.750000] 5f80: 00000000 c0800524 00000000 c0669474 00000000
00000000 00000000 00000000
[    0.750000] 5fa0: 00000000 c0669488 00000000 c0100130 00000000
00000000 00000000 00000000
[    0.750000] 5fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    0.750000] 5fe0: 00000000 00000000 00000000 00000000 00000013
00000000 00000000 00000000
[    0.750000] [<c02b68f0>] (internal_create_group) from [<c0368e58>]
(blk_register_queue+0x5c/0x194)
[    0.750000] [<c0368e58>] (blk_register_queue) from [<c037a9e4>]
(device_add_disk+0x1a4/0x3f0)
[    0.750000] [<c037a9e4>] (device_add_disk) from [<c043ffcc>]
(brd_alloc+0x220/0x2a8)
[    0.750000] [<c043ffcc>] (brd_alloc) from [<c081eec8>] (brd_init+0xd0/0x150)
[    0.750000] [<c081eec8>] (brd_init) from [<c01017ec>]
(do_one_initcall+0x54/0x1f4)
[    0.750000] [<c01017ec>] (do_one_initcall) from [<c08013d0>]
(kernel_init_freeable+0x228/0x27c)
[    0.750000] [<c08013d0>] (kernel_init_freeable) from [<c0669488>]
(kernel_init+0x14/0x124)
[    0.750000] [<c0669488>] (kernel_init) from [<c0100130>]
(ret_from_fork+0x14/0x24)
[    0.750000] Exception stack(0xc0055fb0 to 0xc0055ff8)
[    0.750000] 5fa0:                                     00000000
00000000 00000000 00000000
[    0.750000] 5fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    0.750000] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.750000] Code: e3550000 e59d301c e58d3010 0a000042 (e5953000)
[    0.760000] ---[ end trace a4ae197d2ac7d4bd ]---
[    0.770000] Kernel panic - not syncing: Fatal exception
[    0.770000] Rebooting in 1 seconds..
[    0.770000] Reboot failed -- System halted

 If I move to the 6.1.55 kernel, I have a similar failure  at
internal_create_group but the path is a bit different.

[    0.790000]  internal_create_group from internal_create_groups+0x48/0x8c
[    0.790000]  internal_create_groups from device_add+0x2a0/0x7a8
[    0.790000]  device_add from __mdiobus_register+0xb8/0x340
[    0.790000]  __mdiobus_register from fixed_mdio_bus_init+0xc0/0xec
[    0.790000]  fixed_mdio_bus_init from do_one_initcall+0x48/0x244
[    0.790000]  do_one_initcall from kernel_init_freeable+0x208/0x25c
[    0.790000]  kernel_init_freeable from kernel_init+0x1c/0x12c
[    0.790000]  kernel_init from ret_from_fork+0x14/0x28
[    0.790000] Exception stack(0xc005bfb0 to 0xc005bff8)

What might be the issue?
