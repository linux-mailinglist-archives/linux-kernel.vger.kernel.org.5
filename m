Return-Path: <linux-kernel+bounces-28599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE53F83008C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DE41C23CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D811EC8DE;
	Wed, 17 Jan 2024 07:31:37 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6849ABA4B;
	Wed, 17 Jan 2024 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705476697; cv=none; b=OdSUH2qWl5CV/++u0ABO72pN5vDqUCkVDlpC01FvCOTQw7jSbDBz2BPzq5ulrKmnNUGIpk/zmb6Juh3eiPjzqFt0Rab0Wmf00gSV5N6wkWmlptRlKJFt+3G4Jh0ZgYWCn1/8rf4K9kU0nzlyG1r/M8tzw67XrREiKiPB1gPJOzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705476697; c=relaxed/simple;
	bh=6DBmh5VudcgrGyumJ5ceN/k6JjkuLlAOr34rh1d6IVg=;
	h=X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-UUID:Received:Received:X-ns-mid:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=Z+wqSNQ6/0nVLmCAH4qQ7xn3Q8w64f0IxcdyEkUpHqiSz/Vdjlrw5oa0oDGZ8912BM2eDKo/nix+hdpEvdv3eoU50+yujBzBipzgR/AOyGNraMeZ6phA+4KeXvCxf7/tnz40JYEM1+d19nZerW4l6Pe/iU1bv99HEvGAgVk4V4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 98846c88b5f0479da8554ea9b061d516-20240117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:ba636615-2455-415e-8dd8-38c78f84f03c,IP:20,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:30
X-CID-INFO: VERSION:1.1.35,REQID:ba636615-2455-415e-8dd8-38c78f84f03c,IP:20,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:30
X-CID-META: VersionHash:5d391d7,CLOUDID:dfd7f082-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:2401171531288ICAXGXH,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 98846c88b5f0479da8554ea9b061d516-20240117
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2021478520; Wed, 17 Jan 2024 15:31:27 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 81F37E000EB9;
	Wed, 17 Jan 2024 15:31:27 +0800 (CST)
X-ns-mid: postfix-65A7824F-336142280
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 05727E000EB9;
	Wed, 17 Jan 2024 15:31:26 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: dmitry.torokhov@gmail.com,
	aduggan@synaptics.com,
	cheiny@synaptics.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v2] Input: synaptics-rmi4: Add a null pointer check to the rmi_driver_probe
Date: Wed, 17 Jan 2024 15:31:24 +0800
Message-Id: <20240117073124.143636-1-chentao@kylinos.cn>
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
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
v2: Change title and remove dev_err
---
 drivers/input/rmi4/rmi_driver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_dri=
ver.c
index 258d5fe3d395..8da104e99e7b 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -1197,6 +1197,10 @@ static int rmi_driver_probe(struct device *dev)
 		rmi_driver_set_input_params(rmi_dev, data->input);
 		data->input->phys =3D devm_kasprintf(dev, GFP_KERNEL,
 						"%s/input0", dev_name(dev));
+		if (!data->input->phys) {
+			retval =3D -ENOMEM;
+			goto err;
+		}
 	}
=20
 	retval =3D rmi_init_functions(data);
--=20
2.39.2


