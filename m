Return-Path: <linux-kernel+bounces-38223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B51F83BCB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29AF1F2D40B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF511BF29;
	Thu, 25 Jan 2024 09:00:31 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00EB1BF24
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173231; cv=none; b=b0Y5Zq9JIt8c0fxKRId2kUr2rk7JulQvzuu4j5czoIdQjJlTKBWlcbVEPT4/6l/qlUCGiFTBbRlVfJv5036TUDVgY4oAgUOqrUIREJgjq+m2NBEpF3S47GhbkWPZvjfLQkoi6XIaJInVXsJJcT/GHhAMRkJ8HBOLpStMv4wdb6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173231; c=relaxed/simple;
	bh=yFIcOvnlYTCrUO5xbKup55uq7NaX8OnUUTiF+MaKEvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TSq5h0cAQz77zkv8i++wm6M5WFh2kSduIqEvsToZyXT7s5FvDZUnO1EZBUEDtWhJ04YR2HUW/mr4Mdrdkjm2k/JFwWiOxWtosG/5QeYMfdW+Oj9SOmPpZtkb7HrPYDUAf+PNFJm9xtgqw05yyb4GusycgJNPX3FJzeYBm2gh2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6cebea452a1842fabfae3d893bc41698-20240125
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:17b24cbb-1cba-4b9a-9edc-8b194eb99ba0,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.35,REQID:17b24cbb-1cba-4b9a-9edc-8b194eb99ba0,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:5d391d7,CLOUDID:f888a58e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240125170020J0U1LXW0,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 6cebea452a1842fabfae3d893bc41698-20240125
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 659315200; Thu, 25 Jan 2024 17:00:19 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 08A03E000EB9;
	Thu, 25 Jan 2024 17:00:19 +0800 (CST)
X-ns-mid: postfix-65B22322-586871580
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 50E73E000EB9;
	Thu, 25 Jan 2024 17:00:18 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: oleg@redhat.com,
	linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] ARM: ptrace: Code cleanup
Date: Thu, 25 Jan 2024 17:00:16 +0800
Message-Id: <20240125090016.536043-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This part was commented in about 19 years before.

If there are no plans to enable this part code in the future,
we can remove this dead code.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 arch/arm/kernel/ptrace.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index c421a899fc84..71c0b2233f56 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -37,13 +37,6 @@
  * in exit.c or in signal.c.
  */
=20
-#if 0
-/*
- * Breakpoint SWI instruction: SWI &9F0001
- */
-#define BREAKINST_ARM	0xef9f0001
-#define BREAKINST_THUMB	0xdf00		/* fill this in later */
-#else
 /*
  * New breakpoints - use an undefined instruction.  The ARM architecture
  * reference manual guarantees that the following instruction space
@@ -54,7 +47,6 @@
  */
 #define BREAKINST_ARM	0xe7f001f0
 #define BREAKINST_THUMB	0xde01
-#endif
=20
 struct pt_regs_offset {
 	const char *name;
--=20
2.39.2


