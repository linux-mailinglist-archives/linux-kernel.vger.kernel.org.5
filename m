Return-Path: <linux-kernel+bounces-72911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 263D685BAA7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDE51C21730
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E113966B4D;
	Tue, 20 Feb 2024 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Dnza6CPq"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA6664D9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428855; cv=none; b=FVQJ0NTaDNPn5R61/60Wzms1UYqgrwgIWo5esBCFvsKH7347T17o6qinfKslH1ZR6UrrUO2Vv8NmTGmEZsHwdNFgh+OVp/sldPedwXNLVcI18raOhKBaD2Vks2qBZnK6FD8lAfrZMWfIO3R/JLq/0w3aD44WoPz/h4LcLCAluO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428855; c=relaxed/simple;
	bh=aqLKz7ll/vFXZER5pb0xG/NOCiZwX9kGU18zx+/eers=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uJi/EdeO76LbGlgRVW3Sh4VIYmnl1IIzaGZPLIj3ci3WnzUFJRnfgPuXe4AJg3tgoSxanOlY3KZf/ijG1ZoZ5zSWfRYzFAJL3A3octuh9vQYgYrg5N4rW9T6QT28Sfg+lpx6j6/T/5OHn6/qpHgRtR8fCIbcqUFxIzUHKtl8+Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Dnza6CPq; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f1b38770cfe311eea2298b7352fd921d-20240220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+QxxzZLK77uop3c9oawidI46vMLzFAmM3R/Jc/f/t6g=;
	b=Dnza6CPqJjywHPFra5TqQTJQ1LeG6/ImxaeVwOUAh7wP87eFzF4Tz3anfYMVuNjphik1hM59YfOkGPsPflxDu7r9J4yZNydDuIhJe4uaCkteKxra66Ih4M7/gRVwvbUcsNt+92DN3FK9yCA/GpR5LZ3Qrt8Spgwaj+oafP8Tk/w=;
X-CID-CACHE: Type:Local,Time:202402201927+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:0ad5cc61-dd10-45ff-ad85-603d6cc5703b,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:c25a1a84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f1b38770cfe311eea2298b7352fd921d-20240220
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <haibo.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1033553566; Tue, 20 Feb 2024 19:34:01 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Feb 2024 19:33:59 +0800
Received: from mszsdtlt102.gcn.mediatek.inc (10.16.4.142) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 20 Feb 2024 19:33:59 +0800
From: Haibo Li <haibo.li@mediatek.com>
To: <linux-kernel@vger.kernel.org>
CC: Russell King <linux@armlinux.org.uk>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>, 'Russell King '
	<rmk+kernel@armlinux.org.uk>, Haibo Li <haibo.li@mediatek.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<xiaoming.yu@mediatek.com>
Subject: [PATCH] arm:dump the stack usage after stack overflows
Date: Tue, 20 Feb 2024 19:33:41 +0800
Message-ID: <20240220113341.24523-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.259300-8.000000
X-TMASE-MatchedRID: 8+gsAlLbNEF+7Gr2hULRCqKa0xB73sAA+XUEs7n10vKJPgzJn7/hAGb6
	PphVtfZgGeqWAcGRXwp6n3hIvN5dLfJMF6pylZNWvbFZsqMF9Y+7nrAU9KQxUWHZ+cd7VyKXDZ/
	b5zl6q6ZvvvRcuB/rD3QeHo/CecVW4En2Lqvhr2JIcJTn2HkqsRQc4z1hNYyAIGcJoOzI5aejxY
	yRBa/qJcFwgTvxipFa9xS3mVzWUuCgZHIBpyeFpsZXc7x4uVfJF6jjf600DUaQhh+9h/pw1sXZP
	5r1GmcmftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.259300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0DD9B401C1862381109C0AAE87F93DB93AFC9C71464106ED3F9A0360F3580B692000:8
X-MTK: N

With the help of vmap stack,it is able to detect stack overflow.

To make it easy to debug stack overflow,dump the stack usage of
each frame by walking the stack.

After this patch,the log after stack overflows like below:

Insufficient stack space to handle exception!
Task stack:     [0xf4a70000..0xf4a72000]
IRQ stack:      [0xf0800000..0xf0802000]
Overflow stack: [0x818c1000..0x818c2000]
Depth   usage   size   Location
  0      8232     96   _prb_read_valid
  1      8136     24   prb_read_valid
  2      8112    200   printk_get_next_message
  3      7912    104   console_flush_all
  4      7808     64   console_unlock
  5      7744     40   vprintk_emit
  6      7704     16   vprintk_default
  7      7688     32   _printk
  8      7656   1048   do_circle_loop
  9      6608   1048   do_circle_loop
 10      5560   1048   do_circle_loop
 11      4512   1048   do_circle_loop
 12      3464   1048   do_circle_loop
 13      2416   1048   do_circle_loop
 14      1368   1048   do_circle_loop
 15       320      8   stack_ovf_selftest
 16       312     24   param_attr_store
 17       288     40   kernfs_fop_write_iter
 18       248    112   vfs_write
 19       136     48   ksys_write
-----    -----  -----   ------
Internal error: kernel stack overflow: 0 [#1] SMP ARM
..

Signed-off-by: Haibo Li <haibo.li@mediatek.com>
---
 arch/arm/kernel/traps.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 3bad79db5d6e..641ca68b44ba 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -921,6 +921,33 @@ static int __init allocate_overflow_stacks(void)
 }
 early_initcall(allocate_overflow_stacks);
 
+static void dump_stack_usage(struct pt_regs *regs)
+{
+	struct stackframe frame;
+	unsigned int depth = 0;
+	unsigned long prev_pc;
+	unsigned long prev_sp;
+	unsigned long stack_high = (unsigned long)current->stack + THREAD_SIZE;
+
+	arm_get_current_stackframe(regs, &frame);
+	pr_emerg("Depth   usage   size   Location\n");
+	while (1) {
+		prev_pc = frame.pc;
+		prev_sp = frame.sp;
+#if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND)
+		//meet the requirement of frame_pointer_check
+		if (frame.sp < (unsigned long)current->stack)
+			frame.sp = (unsigned long)current->stack + 4;
+#endif
+		if (unwind_frame(&frame) < 0)
+			break;
+		pr_emerg("%3d     %5ld  %5ld   %ps\n",
+			 depth++, stack_high - prev_sp,
+			 frame.sp - prev_sp, (void *)prev_pc);
+	}
+	pr_emerg("-----    -----  -----   ------\n");
+}
+
 asmlinkage void handle_bad_stack(struct pt_regs *regs)
 {
 	unsigned long tsk_stk = (unsigned long)current->stack;
@@ -940,6 +967,7 @@ asmlinkage void handle_bad_stack(struct pt_regs *regs)
 #endif
 	pr_emerg("Overflow stack: [0x%08lx..0x%08lx]\n",
 		 ovf_stk - OVERFLOW_STACK_SIZE, ovf_stk);
+	dump_stack_usage(regs);
 
 	die("kernel stack overflow", regs, 0);
 }
-- 
2.18.0


