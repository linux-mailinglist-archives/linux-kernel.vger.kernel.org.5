Return-Path: <linux-kernel+bounces-138076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F115B89EC16
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20BD71C2115F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFDB13D276;
	Wed, 10 Apr 2024 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HgIK9aLy"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A7A13D277
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734286; cv=none; b=NFJ/n00hUptBWlI++nl7XiB3GXQxkR2ZV25vjUtFSJznUFumWL4Hs9I3wLAWtwrH0DqHF+inPm0gO/OAa8WEFqdjax58oWAGTlayiE1XfOEeod9BhZsdqzLJGQqCBr51Kc6sEYFzJHzV+Cu55fCrG+9yYIrIr2cpfw0zzCK3ivk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734286; c=relaxed/simple;
	bh=AVH/Rz9TLLK15PO+m06dpmtNJvDP6sTug+ZXoS5aYK8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ik59sPGfdAia5AYFpzcFNbUhLP8Z/MLwyse6Z70HLpmaC3wWc36WGfBdbEqau1hzFrgMZoci5fvzf0aDFhx/N9ldKpPtZUGiz+eKfxXHLJiz/ZfSYFZjf6MiRpeMqbtvEVGmq+Yrl3PAmSeSNX79QKqUEqmUyYxAyvEwnZfqoxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HgIK9aLy; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4f3e4fe8f70c11ee935d6952f98a51a9-20240410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hirxOWkyWCim2+ODFEmbXTRJuf23a8yt89BscoqEckY=;
	b=HgIK9aLyJ3uqGJxu/9wSgapOMrAZG7XQd5WT6pNm0Yzd1VCWEBAJFoA6cjhB/K3qHg/7fILNyFjcDX6h4Hd1+1miHJT6KAnbyMW5x6ECsIKDXCJPxgAfQzw33TwHrcV0P+G7F24GNFbxEyE+LUjbY8w91jbMu9VkpwfN/R0B/T8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f5891a29-3ac3-4a25-8710-5d4487c60482,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:bbb58082-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4f3e4fe8f70c11ee935d6952f98a51a9-20240410
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1938894362; Wed, 10 Apr 2024 15:31:13 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Apr 2024 00:31:12 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Apr 2024 15:31:12 +0800
From: boy.wu <boy.wu@mediatek.com>
To: Mark Rutland <mark.rutland@arm.com>, Andrey Ryabinin
	<ryabinin.a.a@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
CC: Alexander Potapenko <glider@google.com>, Andrey Konovalov
	<andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino
	<vincenzo.frascino@arm.com>, <kasan-dev@googlegroups.com>, Russell King
	<linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Boy Wu
	<boy.wu@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>, Iverlin
 Wang <iverlin.wang@mediatek.com>, Light Chen <light.chen@mediatek.com>
Subject: [PATCH v2] arm: kasan: clear stale stack poison
Date: Wed, 10 Apr 2024 15:30:44 +0800
Message-ID: <20240410073044.23294-1-boy.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Boy Wu <boy.wu@mediatek.com>

We found below OOB crash:

[   33.452494] ==================================================================
[   33.453513] BUG: KASAN: stack-out-of-bounds in refresh_cpu_vm_stats.constprop.0+0xcc/0x2ec
[   33.454660] Write of size 164 at addr c1d03d30 by task swapper/0/0
[   33.455515]
[   33.455767] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O       6.1.25-mainline #1
[   33.456880] Hardware name: Generic DT based system
[   33.457555]  unwind_backtrace from show_stack+0x18/0x1c
[   33.458326]  show_stack from dump_stack_lvl+0x40/0x4c
[   33.459072]  dump_stack_lvl from print_report+0x158/0x4a4
[   33.459863]  print_report from kasan_report+0x9c/0x148
[   33.460616]  kasan_report from kasan_check_range+0x94/0x1a0
[   33.461424]  kasan_check_range from memset+0x20/0x3c
[   33.462157]  memset from refresh_cpu_vm_stats.constprop.0+0xcc/0x2ec
[   33.463064]  refresh_cpu_vm_stats.constprop.0 from tick_nohz_idle_stop_tick+0x180/0x53c
[   33.464181]  tick_nohz_idle_stop_tick from do_idle+0x264/0x354
[   33.465029]  do_idle from cpu_startup_entry+0x20/0x24
[   33.465769]  cpu_startup_entry from rest_init+0xf0/0xf4
[   33.466528]  rest_init from arch_post_acpi_subsys_init+0x0/0x18
[   33.467397]
[   33.467644] The buggy address belongs to stack of task swapper/0/0
[   33.468493]  and is located at offset 112 in frame:
[   33.469172]  refresh_cpu_vm_stats.constprop.0+0x0/0x2ec
[   33.469917]
[   33.470165] This frame has 2 objects:
[   33.470696]  [32, 76) 'global_zone_diff'
[   33.470729]  [112, 276) 'global_node_diff'
[   33.471294]
[   33.472095] The buggy address belongs to the physical page:
[   33.472862] page:3cd72da8 refcount:1 mapcount:0 mapping:00000000 index:0x0 pfn:0x41d03
[   33.473944] flags: 0x1000(reserved|zone=0)
[   33.474565] raw: 00001000 ed741470 ed741470 00000000 00000000 00000000 ffffffff 00000001
[   33.475656] raw: 00000000
[   33.476050] page dumped because: kasan: bad access detected
[   33.476816]
[   33.477061] Memory state around the buggy address:
[   33.477732]  c1d03c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   33.478630]  c1d03c80: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00
[   33.479526] >c1d03d00: 00 04 f2 f2 f2 f2 00 00 00 00 00 00 f1 f1 f1 f1
[   33.480415]                                                ^
[   33.481195]  c1d03d80: 00 00 00 00 00 00 00 00 00 00 04 f3 f3 f3 f3 f3
[   33.482088]  c1d03e00: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
[   33.482978] ==================================================================

We find the root cause of this OOB is that arm does not clear stale stack
poison in the case of cpuidle.

This patch refer to arch/arm64/kernel/sleep.S to resolve this issue.

From cited commit [1] that explain the problem

Functions which the compiler has instrumented for KASAN place poison on
the stack shadow upon entry and remove this poison prior to returning.

In the case of cpuidle, CPUs exit the kernel a number of levels deep in
C code.  Any instrumented functions on this critical path will leave
portions of the stack shadow poisoned.

If CPUs lose context and return to the kernel via a cold path, we
restore a prior context saved in __cpu_suspend_enter are forgotten, and
we never remove the poison they placed in the stack shadow area by
functions calls between this and the actual exit of the kernel.

Thus, (depending on stackframe layout) subsequent calls to instrumented
functions may hit this stale poison, resulting in (spurious) KASAN
splats to the console.

To avoid this, clear any stale poison from the idle thread for a CPU
prior to bringing a CPU online.

From cited commit [2]

Extend to check for CONFIG_KASAN_STACK

[1] commit 0d97e6d8024c ("arm64: kasan: clear stale stack poison")
[2] commit d56a9ef84bd0 ("kasan, arm64: unpoison stack only with CONFIG_KASAN_STACK")

Signed-off-by: Boy Wu <boy.wu@mediatek.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v2 - Add commit message that reviewer mention
---
 arch/arm/kernel/sleep.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index a86a1d4f3461..93afd1005b43 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -127,6 +127,10 @@ cpu_resume_after_mmu:
 	instr_sync
 #endif
 	bl	cpu_init		@ restore the und/abt/irq banked regs
+#if defined(CONFIG_KASAN) && defined(CONFIG_KASAN_STACK)
+	mov	r0, sp
+	bl	kasan_unpoison_task_stack_below
+#endif
 	mov	r0, #0			@ return zero on success
 	ldmfd	sp!, {r4 - r11, pc}
 ENDPROC(cpu_resume_after_mmu)
-- 
2.18.0


