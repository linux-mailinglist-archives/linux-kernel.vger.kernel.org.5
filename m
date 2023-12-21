Return-Path: <linux-kernel+bounces-7754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3881F81ACAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35A7287B28
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FAC46BB;
	Thu, 21 Dec 2023 02:35:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172A94404;
	Thu, 21 Dec 2023 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c2713873dbb3464a955e73b98afabf69-20231221
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:90a79e35-9fc6-466c-ab94-6681d1db0fed,IP:25,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:28
X-CID-INFO: VERSION:1.1.33,REQID:90a79e35-9fc6-466c-ab94-6681d1db0fed,IP:25,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_HamU,ACTION
	:release,TS:28
X-CID-META: VersionHash:364b77b,CLOUDID:cdde512e-1ab8-4133-9780-81938111c800,B
	ulkID:231221103511OABB4G6M,BulkQuantity:0,Recheck:0,SF:66|38|24|16|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD
X-UUID: c2713873dbb3464a955e73b98afabf69-20231221
Received: from node4.com.cn [(39.156.73.12)] by mailgw
	(envelope-from <liyouhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1028198504; Thu, 21 Dec 2023 10:35:10 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 6805B16001CD7;
	Thu, 21 Dec 2023 10:35:10 +0800 (CST)
X-ns-mid: postfix-6583A45E-29320911
Received: from localhost.localdomain (unknown [172.20.185.164])
	by node4.com.cn (NSMail) with ESMTPA id 6C42C16001CD7;
	Thu, 21 Dec 2023 02:35:09 +0000 (UTC)
From: YouHong Li <liyouhong@kylinos.cn>
To: balbi@kernel.org,
	leoyang.li@nxp.com
Cc: linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	liyouhong <liyouhong@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] drivers/usb/gadget/udc: Fix spelling typo in comments(reqest->request)
Date: Thu, 21 Dec 2023 10:34:25 +0800
Message-Id: <20231221023425.1316397-1-liyouhong@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: liyouhong <liyouhong@kylinos.cn>

Fix spelling typo in comments.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: liyouhong <liyouhong@kylinos.cn>

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/u=
dc/fsl_udc_core.c
index ee5705d336e3..97932278e381 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -1360,7 +1360,7 @@ static void ch9getstatus(struct fsl_udc *udc, u8 re=
quest_type, u16 value,
 	udc->ep0_dir =3D USB_DIR_IN;
 	/* Borrow the per device status_req */
 	req =3D udc->status_req;
-	/* Fill in the reqest structure */
+	/* Fill in the request structure */
 	*((u16 *) req->req.buf) =3D cpu_to_le16(tmp);
=20
 	req->ep =3D ep;
diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/ud=
c/mv_udc_core.c
index d888dcda2bc8..78308b64955d 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -1451,7 +1451,7 @@ udc_prime_status(struct mv_udc *udc, u8 direction, =
u16 status, bool empty)
=20
 	req =3D udc->status_req;
=20
-	/* fill in the reqest structure */
+	/* fill in the request structure */
 	if (empty =3D=3D false) {
 		*((u16 *) req->req.buf) =3D cpu_to_le16(status);
 		req->req.length =3D 2;
--=20
2.34.1


