Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ABA755F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjGQJnZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 05:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjGQJm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:42:59 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8A6268E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:42:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B488D616B2E8;
        Mon, 17 Jul 2023 11:42:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HPnfUx2MTxpI; Mon, 17 Jul 2023 11:42:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 08E15634202B;
        Mon, 17 Jul 2023 11:42:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XleJAkaNmrIj; Mon, 17 Jul 2023 11:42:30 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D5C67613AFCD;
        Mon, 17 Jul 2023 11:42:30 +0200 (CEST)
Date:   Mon, 17 Jul 2023 11:42:30 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Stephan Wurm <stephan.wurm@a-eberle.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Eigner <johannes.eigner@a-eberle.de>
Message-ID: <736980270.3262.1689586950735.JavaMail.zimbra@nod.at>
In-Reply-To: <ZLT2qEYjaWgSpRD6@PC-LX-Wurm>
References: <ZLT2qEYjaWgSpRD6@PC-LX-Wurm>
Subject: Re: ubiblock: null pointer dereference using scatterlist in
 work_queue
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubiblock: null pointer dereference using scatterlist in work_queue
Thread-Index: tNcc3p9ZHZOB0zRab8u9CVTUQRyacw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan,

----- Ursprüngliche Mail -----
> Von: "Stephan Wurm" <stephan.wurm@a-eberle.de>
>  [   26.127460] 8<--- cut here ---
>  [   26.130689] Unable to handle kernel NULL pointer dereference at virtual
>  address 00000000
>  [   26.138886] [00000000] *pgd=00000000
>  [   26.142523] Internal error: Oops: 5 [#1] ARM
>  [   26.146804] Modules linked in:
>  [   26.149868] CPU: 0 PID: 18 Comm: kworker/0:3 Not tainted 6.1.38 #1
>  [   26.156060] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>  [   26.162592] Workqueue: ubiblock0_2 ubiblock_do_work
>  [   26.167498] PC is at ubi_io_read+0x78/0x2fc
>  [   26.171693] LR is at ubi_eba_read_leb+0xe8/0x4a4
>  [   26.176320] pc : [<c075f508>]    lr : [<c075cd0c>]    psr: 60070013
>  [   26.182591] sp : f0961dc8  ip : 00000000  fp : 00002000
>  [   26.187819] r10: c81c6000  r9 : 00000000  r8 : c81c7000
>  [   26.193046] r7 : 00000200  r6 : 000008e0  r5 : 00002000  r4 : 00000000
>  [   26.199578] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : c81c6000
>  [   26.206108] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>  [   26.213250] Control: 10c53c7d  Table: 1824c059  DAC: 00000051
>  [   26.218998] Register r0 information: slab kmalloc-8k start c81c6000 pointer
>  offset 0 size 8192
>  [   26.227638] Register r1 information: NULL pointer
>  [   26.232352] Register r2 information: NULL pointer
>  [   26.237062] Register r3 information: NULL pointer
>  [   26.241772] Register r4 information: NULL pointer
>  [   26.246481] Register r5 information: non-paged memory
>  [   26.251537] Register r6 information: non-paged memory
>  [   26.256594] Register r7 information: non-paged memory
>  [   26.261651] Register r8 information: slab kmalloc-8k start c81c6000 pointer
>  offset 4096 size 8192
>  [   26.270545] Register r9 information: NULL pointer
>  [   26.275254] Register r10 information: slab kmalloc-8k start c81c6000 pointer
>  offset 0 size 8192
>  [   26.283977] Register r11 information: non-paged memory
>  [   26.289120] Register r12 information: NULL pointer
>  [   26.293916] Process kworker/0:3 (pid: 18, stack limit = 0x1a047662)
>  [   26.300194] Stack: (0xf0961dc8 to 0xf0962000)
>  [   26.304559] 1dc0:                   c1d50ec0 c075cc64 00000001 00000000
>  00000000 c1d50ec0
>  [   26.312744] 1de0: 00000001 24c676fe c075cc64 00000000 000008e0 c81c6000
>  c80c4000 00000000
>  [   26.320928] 1e00: c1d50ec0 00000002 c81c7000 c075cd0c 00000200 c01d3930
>  60070013 00000000
>  [   26.329111] 1e20: 60070013 c1b43208 000008e0 24c676fe 00000000 c830f5cc
>  c830f5cc 00000200
>  [   26.337294] 1e40: 00000000 00000001 00000200 c80c4000 00000000 c075d124
>  00000000 00000200
>  [   26.345477] 1e60: 00000000 c13e0ec0 c81c6000 c1d50ec0 00000000 00000000
>  00000000 c80c4000
>  [   26.353661] 1e80: c830f5cc c1e52c00 00000200 c81c6000 00000002 c075b748
>  00000000 00000200
>  [   26.361844] 1ea0: 00000000 c1312e58 ef7d3c00 0003e000 00000000 00000200
>  ef7d3c00 c1e52c00
>  [   26.370027] 1ec0: c830f5a8 c830f5cc 00000000 c076b228 00000200 00000000
>  c830f500 c1d50ec0
>  [   26.378211] 1ee0: c830f5d4 24c676fe c0c0e608 c830f5a8 c1ed3800 c1312e58
>  ef7d3c00 c1d50ec0
>  [   26.386394] 1f00: 00000000 c14e59c0 ef7d3c05 c013c06c 00000001 00000000
>  c013bff4 00000000
>  [   26.394577] 1f20: c1312e68 24c676fe c1b5f698 c19642b8 00000000 c101b390
>  00000000 24c676fe
>  [   26.402760] 1f40: c1d50ec0 c1ed3800 c1312e58 c1ed3818 c1312e94 c13dfc30
>  c1d50ec0 00000008
>  [   26.410944] 1f60: c1312e58 c013c3f0 00000000 c1f16880 c1d50ec0 c013c3b0
>  c1ed3800 c1ed3880
>  [   26.419126] 1f80: f095de9c 00000000 00000000 c0143654 c1f16880 c0143588
>  00000000 00000000
>  [   26.427309] 1fa0: 00000000 00000000 00000000 c0100128 00000000 00000000
>  00000000 00000000
>  [   26.435491] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000
>  00000000 00000000
>  [   26.443673] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  00000000 00000000
>  [   26.451855]  ubi_io_read from ubi_eba_read_leb+0xe8/0x4a4
>  [   26.457277]  ubi_eba_read_leb from ubi_eba_read_leb_sg+0x5c/0x154
>  [   26.463390]  ubi_eba_read_leb_sg from ubi_leb_read_sg+0x70/0xb0
>  [   26.469325]  ubi_leb_read_sg from ubiblock_do_work+0x104/0x238
>  [   26.475180]  ubiblock_do_work from process_one_work+0x238/0x57c
>  [   26.481130]  process_one_work from worker_thread+0x40/0x4f8
>  [   26.486724]  worker_thread from kthread+0xcc/0xf0
>  [   26.491449]  kthread from ret_from_fork+0x14/0x2c
>  [   26.496168] Exception stack(0xf0961fb0 to 0xf0961ff8)
>  [   26.501225] 1fa0:                                     00000000 00000000
>  00000000 00000000
>  [   26.509410] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000
>  00000000 00000000
>  [   26.517592] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  [   26.524215] Code: 1a000041 e59d2010 e1a09fc5 e1a0b005 (e5d23000)
>  [   26.530367] ---[ end trace 0000000000000000 ]---
> 
> This kernel Oops happens both on patched or vanilla kernels, of which we tried
> several releases in 5.15.y and 6.1.y branches. We also tried with several of
> our devices.
> Upgrading to the latest mainline kernel did not work out-of-the-box, hence we
> did not follow that track (yet).
> 
> We tried with full debugging output for the whole ubi driver and used several
> additional printks. That way we were able to see, that the first scatterlist
> entry already pointed to virtual address zero when the first read request
> caused by cryptsetup was added to ubiblock's work_queue.
> 
>  sg_virt(pdu->usgl.sg[0]) => page_address(sg) => 0x0000000
> 
> We also tried to use hw_breakpoints to gather more information on (maybe)
> another module interfering, but did not succeed (yet).
> 
> But we were not able to narrow down the root cause until now.
> 
> 
> As an additional twist, the system is able to boot when we mount the ubiblock
> root filesystem without calling cryptsetup, hence skipping the dm-verity hash
> verification. And we can verify the root filesystem with cryptsetup once the
> system boot is finished.
> 
> It is also possible to boot the same system image, including dm-verity, when
> using a sdcard instead of the nand flash. Loading the FIT from sdcard but
> calling cryptsetup on the ubiblock device again leads to the described oops.
> 
> 
> Is there something we have overlooked?
> Do you have further ideas to get behind this issue?

So reading from ubiblock works as long you don't access it via dm-verity?
How about other stacked devices such as dmcrypt?

Did you print the LEB number, read length and offset in ubiblock_read()?
Maybe there is a bug related to setting up the correct device geometry
and the read request is off.

Thanks,
//richard
