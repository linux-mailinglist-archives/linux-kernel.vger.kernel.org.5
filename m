Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609D67D81AD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344787AbjJZLRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjJZLRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:17:30 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF451A1;
        Thu, 26 Oct 2023 04:17:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2345A32009A7;
        Thu, 26 Oct 2023 07:17:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 26 Oct 2023 07:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1698319044; x=1698405444; bh=/eSh6GLx0x
        VUp5Uw7zt4E32bW1gxzbh6zIHn5k0o4pY=; b=Mvkttc01XaJjVhDCzuYJsrUhls
        il5h9rnFh0BFtIa4yH/kO4CfTDKO82pc5C4a4+eED2LKCWPX9AC4W5MACDuPJgQj
        lRhHBKiQVpNOPeLetWK1ztFcBHeanhoDWXs8v20Ei4xF3OvnwDXSiLDj7FRXAvJj
        KbZWgMOwVo1R/CVr8cAhnnGz0FaktuycoooyJwQN03MTSRHCtvV6SBXCP6zm2Qfb
        TSC7aAW1eaNu53c3hCjAzAGiu7wRSg/5kfzA+wxq8UePE1dqn60JsSxoWMvwW1ES
        bO+qA6+cnf06b50T5+72sxb5XReh/YdFl6SmyOfIq/nVAznUaJEnN5fOcn0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698319044; x=1698405444; bh=/eSh6GLx0xVUp
        5Uw7zt4E32bW1gxzbh6zIHn5k0o4pY=; b=TzH3XF6roUFu+66cNsJY/lDGTFJaf
        UXAKEGAHhrxMQ6hVEO+oBA2E78lCi4mkRZc9BN4w1IidnMvbft6pd3RYaEq5Lpcv
        qHpB4iMK0uJn7fZS3gkuF5fl8rLLv9oHGf7aTjJWUfNTH49YhoGfKTT29QI5A9iA
        cKHJZ8kyeAAQB+kvlSg7HMB0Kex3B26EVrLXviKCmDoJVJyZLAf/xvdKvIFOTX7p
        3J/6KyH8eueafP2StHn2pn0D3P2lVsfB8d9eE83Uy4iDOsy1QAP/CoDGXT4dHWJX
        cx+rUSoDyTtDGdNl9Z58Yif7RKKZ7wK70BQv43Tc895cnGwEHvlVae+nw==
X-ME-Sender: <xms:xEo6ZTsHbV2yl7yqfHr-uyPN1gV-00kP_wOdCR-fHCQzd_Rspp7wrA>
    <xme:xEo6ZUcyRdh571tlJ6Zokj9CJqEPrn0OM55SlttjM2GzoaCgmvwUHZU9E8r1EdVPc
    P3JqXsZ8SiFUgPgXNs>
X-ME-Received: <xmr:xEo6ZWyKdiOWmv7JZZPRZUldpP4OkuHImVncbxz0vnpybWLVF-xyLogautmFu65NUXjWtHzBo1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflihgrgihunhcu
    jggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecuggftrf
    grthhtvghrnhephfetuddtudevieeljeejteffheeujeduhefgffejudfhueelleduffef
    gfffveeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:xEo6ZSNkSSJGgFF_oRxxQUb3wJhBn_QCQJPPNuztAa6CuJ-2v4g54Q>
    <xmx:xEo6ZT_Zvm9HerqM_YHORsytWJe6UpBGQkXx7XBzMkT6suOEq9Kh4A>
    <xmx:xEo6ZSW2a3RzgwQ0xeF_cr6PXV0NX0JugwrmwLc7KeAE5g9nXtB5tA>
    <xmx:xEo6ZekLqLqqRwBeh_JcDOij5kzGXEfBLrJ2QNsURhV2yRRoRhZuPw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 07:17:23 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        syq@debian.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        stable@vger.kernel.org, Aurelien Jarno <aurel32@debian.org>
Subject: [PATCH] MIPS: process: Remove lazy context flags for new kernel thread
Date:   Thu, 26 Oct 2023 12:17:15 +0100
Message-Id: <20231026111715.1281728-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We received a report from debian infra team, says their build machine
crashes regularly with:

[ 4066.698500] do_cpu invoked from kernel context![#1]:
[ 4066.703455] CPU: 1 PID: 76608 Comm: iou-sqp-76326 Not tainted 5.10.0-21-loongson-3 #1 Debian 5.10.162-1
[ 4066.712793] Hardware name: Loongson Lemote-3A4000-7A-1w-V1.00-A1901/Lemote-3A4000-7A-1w-V1.00-A1901, BIOS Loongson-PMON-V3.3-20201222 12/22/2020
[ 4066.725672] $ 0   : 0000000000000000 ffffffff80bf2e48 0000000000000001 9800000200804000
[ 4066.733642] $ 4   : 9800000105115280 ffffffff80db4728 0000000000000008 0000020080000200
[ 4066.741607] $ 8   : 0000000000000001 0000000000000001 0000000000000000 0000000002e85400
[ 4066.749571] $12   : 000000005400cce0 ffffffff80199c00 000000000000036f 000000000000036f
[ 4066.757536] $16   : 980000010025c080 ffffffff80ec4740 0000000000000000 980000000234b8c0
[ 4066.765501] $20   : ffffffff80ec5ce0 9800000105115280 98000001051158a0 0000000000000000
[ 4066.773466] $24   : 0000000000000028 9800000200807e58
[ 4066.781431] $28   : 9800000200804000 9800000200807d40 980000000234b8c0 ffffffff80bf3074
[ 4066.789395] Hi    : 00000000000002fb
[ 4066.792943] Lo    : 00000000428f6816
[ 4066.796500] epc   : ffffffff802177c0 _save_fp+0x10/0xa0
[ 4066.801695] ra    : ffffffff80bf3074 __schedule+0x804/0xe08
[ 4066.807230] Status: 5400cce2 KX SX UX KERNEL EXL
[ 4066.811917] Cause : 1000002c (ExcCode 0b)
[ 4066.815899] PrId  : 0014c004 (ICT Loongson-3)
[ 4066.820228] Modules linked in: asix usbnet mii sg ip6t_REJECT nf_reject_ipv6 ip6table_filter ip6_tables nfnetlink_log nfnetlink xt_hashlimit ipt_REJECT nf_reject_ipv4 xt_NFLOG xt_multiport xt_tcpudp xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter sch_fq tcp_bbr fuse drm drm_panel_orientation_quirks configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic ohci_pci dm_mod r8169 realtek mdio_devres ohci_hcd ehci_pci of_mdio xhci_pci fixed_phy xhci_hcd ehci_hcd libphy usbcore usb_common
[ 4066.868085] Process iou-sqp-76326 (pid: 76608, threadinfo=0000000056dd346c, task=000000001209ac62, tls=000000fff18298e0)
[ 4066.878897] Stack : ffffffff80ec0000 0000000000000000 ffffffff80ec0000 980000010db34100
[ 4066.886867]         9800000100000004 d253a55201683fdc 9800000105115280 0000000000000000
[ 4066.894832]         0000000000000000 0000000000000001 980000010db340e8 0000000000000001
[ 4066.902796]         0000000000000004 0000000000000000 980000010db33d28 ffffffff80bf36d0
[ 4066.910761]         980000010db340e8 980000010db34100 980000010db340c8 ffffffff8070d740
[ 4066.918726]         980000010946cc80 9800000104b56c80 980000010db340c0 0000000000000000
[ 4066.926690]         ffffffff80ec0000 980000010db340c8 980000010025c080 ffffffff80ec5ce0
[ 4066.934654]         0000000000000000 9800000105115280 ffffffff802c59b8 980000010db34108
[ 4066.942619]         980000010db34108 2d7071732d756f69 ffff003632333637 d253a55201683fdc
[ 4066.950585]         ffffffff8070d1c8 980000010db340c0 98000001092276c8 000000007400cce0
[ 4066.958552]         ...
[ 4066.960981] Call Trace:
[ 4066.963414] [<ffffffff802177c0>] _save_fp+0x10/0xa0
[ 4066.968270] [<ffffffff80bf3074>] __schedule+0x804/0xe08
[ 4066.973462] [<ffffffff80bf36d0>] schedule+0x58/0x150
[ 4066.978397] [<ffffffff8070d740>] io_sq_thread+0x578/0x5a0
[ 4066.983764] [<ffffffff8020518c>] ret_from_kernel_thread+0x14/0x1c
[ 4066.989823]
[ 4066.991297] Code: 000c6940  05a10011  00000000 <f4810af0> f4830b10  f4850b30  f4870b50  f4890b70  f48b0b90

It seems like kernel is trying to save a FP context for a kthread.
Since we don't use FPU in kernel for now, TIF_USEDFPU must be set
accidentally for that kthread.

Inspecting the code it seems like create_io_thread may be invoked
from threads that have FP context alive, causing TIF_USEDFPU to be
copied from that context to kthread unexpectedly.

Move around code blocks to ensure flags regarding lazy hardware
context get cleared for kernel threads as well.

Cc: stable@vger.kernel.org
Reported-by: Aurelien Jarno <aurel32@debian.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Folks, it might be helpful to check ST0_CU1 in is_fpu_owner
to catch this kind of problem in future, what's your opinion?
---
 arch/mips/kernel/process.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 5387ed0a5186..fecffa32f3e0 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -136,24 +136,26 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		status |= ST0_EXL;
 #endif
 		childregs->cp0_status = status;
-		return 0;
-	}
+	} else {
+		/* user thread */
+		*childregs = *regs;
+		childregs->regs[7] = 0; /* Clear error flag */
+		childregs->regs[2] = 0; /* Child gets zero as return value */
+		if (usp)
+			childregs->regs[29] = usp;
 
-	/* user thread */
-	*childregs = *regs;
-	childregs->regs[7] = 0; /* Clear error flag */
-	childregs->regs[2] = 0; /* Child gets zero as return value */
-	if (usp)
-		childregs->regs[29] = usp;
+		p->thread.reg29 = (unsigned long) childregs;
+		p->thread.reg31 = (unsigned long) ret_from_fork;
 
-	p->thread.reg29 = (unsigned long) childregs;
-	p->thread.reg31 = (unsigned long) ret_from_fork;
+		/*
+		 * New tasks lose permission to use the fpu. This accelerates context
+		 * switching for most programs since they don't use the fpu.
+		 */
+		childregs->cp0_status &= ~(ST0_CU2|ST0_CU1);
 
-	/*
-	 * New tasks lose permission to use the fpu. This accelerates context
-	 * switching for most programs since they don't use the fpu.
-	 */
-	childregs->cp0_status &= ~(ST0_CU2|ST0_CU1);
+		if (clone_flags & CLONE_SETTLS)
+			ti->tp_value = tls;
+	}
 
 	clear_tsk_thread_flag(p, TIF_USEDFPU);
 	clear_tsk_thread_flag(p, TIF_USEDMSA);
@@ -167,9 +169,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	atomic_set(&p->thread.bd_emu_frame, BD_EMUFRAME_NONE);
 #endif
 
-	if (clone_flags & CLONE_SETTLS)
-		ti->tp_value = tls;
-
 	return 0;
 }
 
-- 
2.34.1

