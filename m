Return-Path: <linux-kernel+bounces-30862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CA383253A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443C81C234B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB179D53F;
	Fri, 19 Jan 2024 07:46:55 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB62ED518
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650415; cv=none; b=n+7zPhN/9OE0IoaWbKOSQhbYPYHD86msDSS/VXlCzDz/ZUncSPg4wka5FU2+SR38YO+N+88w66Ln7IWJ09iYU6H6oUMpvulozF19VlGNfM4HzcPWxcKFK114GD6qcqspeu3xHpj4MOGtHsheQKDYbIvSkL0VXUFFnod5L3BwbpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650415; c=relaxed/simple;
	bh=U9lDSuASbh6d5ZjnANlzasKqEFRINfeIrxMa70xYl8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jzDB9szACf39aUFvjsXJHW/svrf3xWnEGelHIfVLAGkRjKL9qewX0t7hb3C26+qxt2m9yApK82LCiGYix69JCCFA7Eu3+wzT86eRLVYuSj1gItVfnzOuS9KBxwpGe+tZcGqICxmZl7J8Hyr2qsGQlG3w1s8oqJ15nvQ+dNtSkTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b295426561af4f67bc70b69a7c2ea1ee-20240119
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:c4acb646-4d71-44fb-aa5e-55f74e42c7d6,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.35,REQID:c4acb646-4d71-44fb-aa5e-55f74e42c7d6,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:5d391d7,CLOUDID:78f5572f-1ab8-4133-9780-81938111c800,B
	ulkID:240119154645RWLL5RGM,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: b295426561af4f67bc70b69a7c2ea1ee-20240119
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1189345623; Fri, 19 Jan 2024 15:46:42 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 3CD5BE000EB9;
	Fri, 19 Jan 2024 15:46:42 +0800 (CST)
X-ns-mid: postfix-65AA28E2-47313902
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 648F9E000EB9;
	Fri, 19 Jan 2024 15:46:36 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: neil.armstrong@linaro.org,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] meson-mx-socinfo: Fix possible null-pointer dereference issues in meson_mx_socinfo_init
Date: Fri, 19 Jan 2024 15:46:35 +0800
Message-Id: <20240119074635.265218-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In meson_mx_socinfo_revision, kasprintf() returns a pointer
to dynamically allocated memory which can be NULL upon failure.

Similarly, the kstrdup_const in the meson_mx_socinfo_soc_id
returns a null pointer when it fails. Ensure the allocation was successfu=
l
by checking the pointer validity. Avoid null pointer dereference issues.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/soc/amlogic/meson-mx-socinfo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/amlogic/meson-mx-socinfo.c b/drivers/soc/amlogic=
/meson-mx-socinfo.c
index 92125dd65f33..9c0296599561 100644
--- a/drivers/soc/amlogic/meson-mx-socinfo.c
+++ b/drivers/soc/amlogic/meson-mx-socinfo.c
@@ -160,6 +160,12 @@ static int __init meson_mx_socinfo_init(void)
 							   metal_rev);
 	soc_dev_attr->soc_id =3D meson_mx_socinfo_soc_id(major_ver, metal_rev);
=20
+	if (!soc_dev_attr->revision || !soc_dev_attr->soc_id) {
+		kfree_const(soc_dev_attr->revision);
+		kfree_const(soc_dev_attr->soc_id);
+		kfree(soc_dev_attr);
+		return -ENOMEM;
+	}
 	soc_dev =3D soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
 		kfree_const(soc_dev_attr->revision);
--=20
2.39.2


