Return-Path: <linux-kernel+bounces-29981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E463831628
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF24B1F22234
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C259D1F94D;
	Thu, 18 Jan 2024 09:47:25 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8891173D;
	Thu, 18 Jan 2024 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571245; cv=none; b=UF1egfU06kpQb2j1ZmQTqwzgiTT+0J+3ct6M3pCHUE41lR7fbqUQUr6UtWRhYwRfmD/IPa8GClC9sUjAFlILDv+MF4GoxGyQGZ1vaeav3NNi8oJoBur3VbfykKA83TDwf3EwkkJlZUflheTkMszBk1rVjFB3nG4I7I8vPLvUZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571245; c=relaxed/simple;
	bh=xUKe/6pES/NscQ+RcGPUqZZ6ve+SBnXl+mH5PIJD128=;
	h=X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-UUID:Received:Received:X-ns-mid:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=GuU32bhO2fIC4J1g5xbc2zSRnFr5N2kcIze86q5WcvmFs+JGhFHO+uejShYddPHpmAdP9zolZeC+CVeEKWeNpME5JXNCU1rHsQdXTIvsWmnU/S0PB+fHW23N6j3MeKX3+z+MB7Yt0TdSWhCKZCP3PqEj4Sadaa6+fEcT2nfEn4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3d0cabb88c414149bc8eca0681ee3386-20240118
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:02285d8d-6596-4773-956c-95702a0cee6f,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.35,REQID:02285d8d-6596-4773-956c-95702a0cee6f,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:5d391d7,CLOUDID:c4567d7f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240118174709GVOR3L11,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 3d0cabb88c414149bc8eca0681ee3386-20240118
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1667805969; Thu, 18 Jan 2024 17:47:08 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 71955E000EB9;
	Thu, 18 Jan 2024 17:47:08 +0800 (CST)
X-ns-mid: postfix-65A8F39C-245485265
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id E42E8E000EB9;
	Thu, 18 Jan 2024 17:47:05 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] hwmon: (peci/cputemp) Add a null pointer check to the wled_configure
Date: Thu, 18 Jan 2024 17:47:04 +0800
Message-Id: <20240118094704.212641-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/video/backlight/qcom-wled.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backligh=
t/qcom-wled.c
index 10129095a4c1..a0b06839d778 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1406,8 +1406,11 @@ static int wled_configure(struct wled *wled)
 	wled->ctrl_addr =3D be32_to_cpu(*prop_addr);
=20
 	rc =3D of_property_read_string(dev->of_node, "label", &wled->name);
-	if (rc)
+	if (rc) {
 		wled->name =3D devm_kasprintf(dev, GFP_KERNEL, "%pOFn", dev->of_node);
+		if (!wled->name)
+			return -ENOMEM;
+	}
=20
 	switch (wled->version) {
 	case 3:
--=20
2.39.2


