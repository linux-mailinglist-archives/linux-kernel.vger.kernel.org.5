Return-Path: <linux-kernel+bounces-38134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B287783BB4C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E232EB2176B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D1B1756B;
	Thu, 25 Jan 2024 08:09:56 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CB513FF2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170196; cv=none; b=Q0rw8ftUwvHKtW2wZ/+UTLPWeq0MwaO6xhCjZp0Qqxlu+Kbe3XXLbhDHF3HFRckOGMbvBM+slLjZAx0AhbcefyJWdNeGOPSkljDcDeSjQKwPGt6M+tWRPHN3NmKYuYirt0iu3QO5osOtwbhEQepzw84H/1t9pBQ5pV2lmWVDHew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170196; c=relaxed/simple;
	bh=c1qasNC4nq5/aorD9VgvyK1m+RV8WpcPerre5AzHjVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LYIM1FOxfTw3H7Zqx6Z8+vupzIqYX0vbSLY6dbYdqKhTUo2Zwm+e1hk9TjlUy2SVVEEknZYjVkgpch85e73zD4IwFs+7KJUdZlJrEVNpFzo/V72OugiF0oXSl5VQ1rrpL87Rjig5hkL15nf3bawt7Ejs6QUjZu+zqbyNA9ZQUAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 474cc0b33d384cde842e788ea6b7954d-20240125
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:b9247630-6fee-4aec-bd03-ba7e527c3d61,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.35,REQID:b9247630-6fee-4aec-bd03-ba7e527c3d61,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:5d391d7,CLOUDID:1bf6a48e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:2401251609461KQZS52G,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 474cc0b33d384cde842e788ea6b7954d-20240125
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1900835898; Thu, 25 Jan 2024 16:09:44 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1F139E000EB9;
	Thu, 25 Jan 2024 16:09:44 +0800 (CST)
X-ns-mid: postfix-65B21747-919059179
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 69B38E000EB9;
	Thu, 25 Jan 2024 16:09:41 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] ARM: riscpc: dma: code cleanup
Date: Thu, 25 Jan 2024 16:09:39 +0800
Message-Id: <20240125080939.530750-1-chentao@kylinos.cn>
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
 arch/arm/mach-rpc/dma.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-rpc/dma.c b/arch/arm/mach-rpc/dma.c
index 50e0f97afd75..caed10f5b394 100644
--- a/arch/arm/mach-rpc/dma.c
+++ b/arch/arm/mach-rpc/dma.c
@@ -33,15 +33,6 @@ struct iomd_dma {
 	unsigned int		dma_len;
 };
=20
-#if 0
-typedef enum {
-	dma_size_8	=3D 1,
-	dma_size_16	=3D 2,
-	dma_size_32	=3D 4,
-	dma_size_128	=3D 16
-} dma_size_t;
-#endif
-
 #define TRANSFER_SIZE	2
=20
 #define CURA	(0)
--=20
2.39.2


