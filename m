Return-Path: <linux-kernel+bounces-7761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850B181ACC3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40ACC28709E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1096E442B;
	Thu, 21 Dec 2023 02:49:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2526F1C0F;
	Thu, 21 Dec 2023 02:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 982c4c5a22ac48ea8abed9de3d9fdca2-20231221
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:0321cf1c-2ad6-48ea-bda4-9f7169347a7a,IP:25,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:40
X-CID-INFO: VERSION:1.1.33,REQID:0321cf1c-2ad6-48ea-bda4-9f7169347a7a,IP:25,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-META: VersionHash:364b77b,CLOUDID:69bf0082-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:231221104845KXBYRE2V,BulkQuantity:0,Recheck:0,SF:72|19|44|66|24|102,
	TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 982c4c5a22ac48ea8abed9de3d9fdca2-20231221
Received: from node4.com.cn [(39.156.73.12)] by mailgw
	(envelope-from <liyouhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 823144486; Thu, 21 Dec 2023 10:48:42 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 925D116001CD7;
	Thu, 21 Dec 2023 10:48:42 +0800 (CST)
X-ns-mid: postfix-6583A78A-30290443
Received: from localhost.localdomain (unknown [172.20.185.164])
	by node4.com.cn (NSMail) with ESMTPA id 1289F16001CD7;
	Thu, 21 Dec 2023 02:48:41 +0000 (UTC)
From: YouHong Li <liyouhong@kylinos.cn>
To: isdn@linux-pingi.de
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liyouhong <liyouhong@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] drivers/isdn/hardware/mISDN/w6692.c: Fix spelling typo in comment
Date: Thu, 21 Dec 2023 10:47:58 +0800
Message-Id: <20231221024758.1317603-1-liyouhong@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: liyouhong <liyouhong@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: liyouhong <liyouhong@kylinos.cn>

diff --git a/drivers/isdn/hardware/mISDN/w6692.c b/drivers/isdn/hardware/=
mISDN/w6692.c
index f3b8db7b48fe..21669063b815 100644
--- a/drivers/isdn/hardware/mISDN/w6692.c
+++ b/drivers/isdn/hardware/mISDN/w6692.c
@@ -772,7 +772,7 @@ w6692_irq(int intno, void *dev_id)
 	spin_lock(&card->lock);
 	ista =3D ReadW6692(card, W_ISTA);
 	if ((ista | card->imask) =3D=3D card->imask) {
-		/* possible a shared  IRQ reqest */
+		/* possible a shared  IRQ request */
 		spin_unlock(&card->lock);
 		return IRQ_NONE;
 	}
--=20
2.34.1


