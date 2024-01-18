Return-Path: <linux-kernel+bounces-29722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A6983127C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6593286EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 05:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CDC8F52;
	Thu, 18 Jan 2024 05:43:13 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C772333EA;
	Thu, 18 Jan 2024 05:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705556592; cv=none; b=oGOH7p0ufQ3kXl8BGyCiNsyw6P6EmIUGToG5+sMLyfqyq/ZsBBZ7Ye6TCuWEseQH8evjQmlH/AU5lYqP0JHLy9yv700lnnEaXlPk4IHcT0iu51NIngikd92N5STGmK4Uj2YSSZ5Ye/oK1d6E0bmvTdIOt9nNnsqqYOTOxtvYArI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705556592; c=relaxed/simple;
	bh=N8lyXV983QZcIN4IypN9VKPidDixXf4Ufs7PA3JcatQ=;
	h=X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-UUID:Received:Received:X-ns-mid:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=u3VoVaW6bzEj5lKYs4m8UFESVnFFhleV98IcQ5mBJU30R+Mcw33LwH431KNHPraOZxktGIHEv+j1UBhw7Opb4882zLcbvzfw8BIj+qJaPxyBE19GvT8EjZKfGXV7QHpSvRwiNgPYrsgzaOky7+tOTvsmex1RM8WaE5B5He8uaZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6d39311e58964ef3910abf0a8c644cd4-20240118
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f8b43031-f88e-4f9b-bc87-756d56c07d5b,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.35,REQID:f8b43031-f88e-4f9b-bc87-756d56c07d5b,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:5d391d7,CLOUDID:8b8e7a7f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240118134304ZHV6LL3N,BulkQuantity:0,Recheck:0,SF:24|17|19|44|66|38|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 6d39311e58964ef3910abf0a8c644cd4-20240118
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1039748442; Thu, 18 Jan 2024 13:43:01 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1B115E000EB9;
	Thu, 18 Jan 2024 13:43:01 +0800 (CST)
X-ns-mid: postfix-65A8BA64-89835715
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id A0077E000EB9;
	Thu, 18 Jan 2024 13:42:59 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: nm@ti.com,
	ssantosh@kernel.org,
	ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] pmdomain: Add a null pointer check to the omap_prm_domain_init
Date: Thu, 18 Jan 2024 13:42:57 +0800
Message-Id: <20240118054257.200814-1-chentao@kylinos.cn>
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
 drivers/pmdomain/ti/omap_prm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/ti/omap_prm.c b/drivers/pmdomain/ti/omap_pr=
m.c
index c2feae3a634c..b8ceb3c2b81c 100644
--- a/drivers/pmdomain/ti/omap_prm.c
+++ b/drivers/pmdomain/ti/omap_prm.c
@@ -695,6 +695,8 @@ static int omap_prm_domain_init(struct device *dev, s=
truct omap_prm *prm)
 	data =3D prm->data;
 	name =3D devm_kasprintf(dev, GFP_KERNEL, "prm_%s",
 			      data->name);
+	if (!name)
+		return -ENOMEM;
=20
 	prmd->dev =3D dev;
 	prmd->prm =3D prm;
--=20
2.39.2


