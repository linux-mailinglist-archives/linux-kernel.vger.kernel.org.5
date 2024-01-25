Return-Path: <linux-kernel+bounces-38157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C88A83BBB0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF141F219AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0D0175B6;
	Thu, 25 Jan 2024 08:19:19 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38D617581
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170758; cv=none; b=AIIFbG4kSP8TlyfCzkf+xYboX9YDZMR4ub1KnLuLNeUNFZywJzhfS+OndiFXLKNVWallE9P7fcwetu5MCZlzyHXHYZxSAweG9mb19wois9t5lxi3/8QpfuRxgbZ5TXhz8sLNHapqTwScw3Pg3ov2J7W/xEfaw7md0CP1AKi/Z1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170758; c=relaxed/simple;
	bh=Pe3+Z5TprG1MCm3XH/wvYQEymtq4W+JtGYVqdZcG9Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ViddstdiiwRG/NA7SYhb6eF4YoTGTo1TypxD9S75M6XoIrs8x0A5JEnvIBq+bJIg7HnoYytQrbII/kmN1zgZoNxKCXkjLk0k6QSgdPFSbQk1k0oD0xXkm8AelCETKV7QNu3IGXiaubMlCPm+L9tMMlqmsHeSZdpVCCg0XxRUaa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 875a5205a7694e01b70b9770baae8f36-20240125
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:5b8963f5-aa20-446f-84e2-6c7c914ac904,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:15
X-CID-INFO: VERSION:1.1.35,REQID:5b8963f5-aa20-446f-84e2-6c7c914ac904,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-META: VersionHash:5d391d7,CLOUDID:1a2f23fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:240125161904AS2NEWQO,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 875a5205a7694e01b70b9770baae8f36-20240125
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1220097995; Thu, 25 Jan 2024 16:19:04 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1361EE000EBA;
	Thu, 25 Jan 2024 16:19:04 +0800 (CST)
X-ns-mid: postfix-65B21977-817775418
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 7AF92E000EB9;
	Thu, 25 Jan 2024 16:19:01 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] ARM: riscpc: Code cleanup for parse_tag_acorn
Date: Thu, 25 Jan 2024 16:18:56 +0800
Message-Id: <20240125081856.531595-1-chentao@kylinos.cn>
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
 arch/arm/mach-rpc/riscpc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-rpc/riscpc.c b/arch/arm/mach-rpc/riscpc.c
index f70fb9c4b0cb..947c88950518 100644
--- a/arch/arm/mach-rpc/riscpc.c
+++ b/arch/arm/mach-rpc/riscpc.c
@@ -53,12 +53,6 @@ static int __init parse_tag_acorn(const struct tag *ta=
g)
 	default:
 		break;
 	}
-#if 0
-	if (vram_size) {
-		desc->video_start =3D 0x02000000;
-		desc->video_end   =3D 0x02000000 + vram_size;
-	}
-#endif
 	return 0;
 }
=20
--=20
2.39.2


