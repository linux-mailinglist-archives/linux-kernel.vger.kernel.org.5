Return-Path: <linux-kernel+bounces-30804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1C7832480
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EA91F24C06
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C0E5381;
	Fri, 19 Jan 2024 06:07:27 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373FE4A0F;
	Fri, 19 Jan 2024 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705644447; cv=none; b=N0vfXnxERLA8I80mZzLJeDuCmohriGi+UySz5C/bIxftfvlABIxycbH+lnczh4McLXz2NPy9KghG8Go5OW0sa2x7aNLCQ74D/t5Q9xNCJveM5XkvBY0x/ccpkfvSMgFfctVLkRQjhj3oVZTEeAGY6Vsu0gpJCrx8f6qIb+/KQuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705644447; c=relaxed/simple;
	bh=UBzZ49HqC2sWhE+aAm+H8+GVQvgeyj/loWZJwfPGEVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VYHMO5+QrnqeZHpDHWJgpSZyV7o3qhYldVAwx2bSdKwvsHG/oa8zyhbfI3bY/GJpj3RF1Ph0LQeuInH2IXozvs0iT4Ms8Dal4q85VYMX95PxNZIodoJVO5RPVOlyMGH0hbcsPuPPlvlnvAiLPqpm3aHDlnjpK14TttgbCu+Qjr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bce7ae8d548d4673ade61757093c66d8-20240119
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:1b893184-87f0-4021-8c3b-02909b61d1d6,IP:10,
	URL:0,TC:0,Content:30,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:25
X-CID-INFO: VERSION:1.1.35,REQID:1b893184-87f0-4021-8c3b-02909b61d1d6,IP:10,UR
	L:0,TC:0,Content:30,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:25
X-CID-META: VersionHash:5d391d7,CLOUDID:78906c8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240119140717LEZ98I33,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:4,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: bce7ae8d548d4673ade61757093c66d8-20240119
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1958869100; Fri, 19 Jan 2024 14:07:16 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 64468E000EB9;
	Fri, 19 Jan 2024 14:07:16 +0800 (CST)
X-ns-mid: postfix-65AA1194-203573312
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 846B1E000EB9;
	Fri, 19 Jan 2024 14:07:15 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: rrameshbabu@nvidia.com,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] HID: nvidia-shield: Add some null pointer checks to the hid-nvidia-shield.c
Date: Fri, 19 Jan 2024 14:07:14 +0800
Message-Id: <20240119060714.258635-1-chentao@kylinos.cn>
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
 drivers/hid/hid-nvidia-shield.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shi=
eld.c
index 82d0a77359c4..58b15750dbb0 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -800,6 +800,8 @@ static inline int thunderstrike_led_create(struct thu=
nderstrike *ts)
=20
 	led->name =3D devm_kasprintf(&ts->base.hdev->dev, GFP_KERNEL,
 				   "thunderstrike%d:blue:led", ts->id);
+	if (!led->name)
+		return -ENOMEM;
 	led->max_brightness =3D 1;
 	led->flags =3D LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
 	led->brightness_get =3D &thunderstrike_led_get_brightness;
@@ -831,6 +833,8 @@ static inline int thunderstrike_psy_create(struct shi=
eld_device *shield_dev)
 	shield_dev->battery_dev.desc.name =3D
 		devm_kasprintf(&ts->base.hdev->dev, GFP_KERNEL,
 			       "thunderstrike_%d", ts->id);
+	if (!shield_dev->battery_dev.desc.name)
+		return -ENOMEM;
=20
 	shield_dev->battery_dev.psy =3D power_supply_register(
 		&hdev->dev, &shield_dev->battery_dev.desc, &psy_cfg);
--=20
2.39.2


