Return-Path: <linux-kernel+bounces-11762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543DB81EB51
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFFA281E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729531FD7;
	Wed, 27 Dec 2023 01:38:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8FF1FA3;
	Wed, 27 Dec 2023 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2c39ad4cd6904d7489c56ffc3cfa8a80-20231227
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:97ddd336-8745-4ebc-8e11-43bf9cac696a,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:97ddd336-8745-4ebc-8e11-43bf9cac696a,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:6fa03382-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:231227093823KW7WS7H6,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 2c39ad4cd6904d7489c56ffc3cfa8a80-20231227
Received: from node4.com.cn [(39.156.73.12)] by mailgw
	(envelope-from <liyouhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 398273438; Wed, 27 Dec 2023 09:38:21 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 6900316001CD8;
	Wed, 27 Dec 2023 09:38:21 +0800 (CST)
X-ns-mid: postfix-658B800D-28500922
Received: from localhost.localdomain (unknown [172.20.185.164])
	by node4.com.cn (NSMail) with ESMTPA id 391FB16001CD7;
	Wed, 27 Dec 2023 01:38:19 +0000 (UTC)
From: YouHong Li <liyouhong@kylinos.cn>
To: isdn@linux-pingi.de
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	YouHong Li <liyouhong@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2] drivers/isdn/hardware/mISDN/w6692.c: Fix spelling typo in comment
Date: Wed, 27 Dec 2023 09:37:53 +0800
Message-Id: <20231227013753.286177-1-liyouhong@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: YouHong Li <liyouhong@kylinos.cn>
Reviewed-by: Simon Horman <horms@kernel.org>

---
v1->v2
	*Fix spelling typo in comment oscilator =3D=3D> oscillator
---
diff --git a/drivers/isdn/hardware/mISDN/w6692.c b/drivers/isdn/hardware/=
mISDN/w6692.c
index 6f60aced11c5..69d23e732e85 100644
--- a/drivers/isdn/hardware/mISDN/w6692.c
+++ b/drivers/isdn/hardware/mISDN/w6692.c
@@ -788,7 +788,7 @@ w6692_irq(int intno, void *dev_id)
 	spin_lock(&card->lock);
 	ista =3D ReadW6692(card, W_ISTA);
 	if ((ista | card->imask) =3D=3D card->imask) {
-		/* possible a shared  IRQ reqest */
+		/* possible a shared  IRQ request */
 		spin_unlock(&card->lock);
 		return IRQ_NONE;
 	}
@@ -873,7 +873,7 @@ static void initW6692(struct w6692_hw *card)
 	/* enable peripheral */
 	if (card->subtype =3D=3D W6692_USR) {
 		/* seems that USR implemented some power control features
-		 * Pin 79 is connected to the oscilator circuit so we
+		 * Pin 79 is connected to the oscillator circuit so we
 		 * have to handle it here
 		 */
 		card->pctl =3D 0x80;
--=20
2.34.1


