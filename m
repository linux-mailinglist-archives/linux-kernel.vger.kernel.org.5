Return-Path: <linux-kernel+bounces-11766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0613A81EB62
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8230CB21EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A880A20E3;
	Wed, 27 Dec 2023 01:59:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87BF290A;
	Wed, 27 Dec 2023 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 736372425c134f35a7e7d7a0bf2b187f-20231227
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:a9f54529-18db-4295-8c11-d437e02624db,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.35,REQID:a9f54529-18db-4295-8c11-d437e02624db,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:88c59a8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:231227095903XK28CY75,BulkQuantity:0,Recheck:0,SF:17|19|44|66|24|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 736372425c134f35a7e7d7a0bf2b187f-20231227
Received: from node4.com.cn [(39.156.73.12)] by mailgw
	(envelope-from <liyouhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 140538751; Wed, 27 Dec 2023 09:59:02 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id C900216001CD7;
	Wed, 27 Dec 2023 09:59:01 +0800 (CST)
X-ns-mid: postfix-658B84E5-69383545
Received: from localhost.localdomain (unknown [172.20.185.164])
	by node4.com.cn (NSMail) with ESMTPA id 6BD7116001CD7;
	Wed, 27 Dec 2023 01:58:59 +0000 (UTC)
From: YouHong Li <liyouhong@kylinos.cn>
To: paulus@samba.org
Cc: linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	liyouhong <liyouhong@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2] drivers/net/ppp/ppp_async.c: Fix spelling typo in comment
Date: Wed, 27 Dec 2023 09:58:31 +0800
Message-Id: <20231227015831.289077-1-liyouhong@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: liyouhong <liyouhong@kylinos.cn>

Fix spelling typo in comment

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: liyouhong <liyouhong@kylinos.cn>
Reviewed-by: Simon Horman <horms@kernel.org>

diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index b287bb811875..cb55b2d95eff 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -547,7 +547,7 @@ ppp_async_encode(struct asyncppp *ap)
 	proto =3D get_unaligned_be16(data);
=20
 	/*
-	 * LCP packets with code values between 1 (configure-reqest)
+	 * LCP packets with code values between 1 (configure-request)
 	 * and 7 (code-reject) must be sent as though no options
 	 * had been negotiated.
 	 */
--=20
2.34.1


