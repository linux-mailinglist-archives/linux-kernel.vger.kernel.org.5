Return-Path: <linux-kernel+bounces-36469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B026583A154
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32AA1C21A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1A7DDD6;
	Wed, 24 Jan 2024 05:29:13 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151BD2F5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706074152; cv=none; b=Akw8/AJBAzGv4diElWyfB/h9kCJQvoLIfrQPJ9/4pBy7Fx4hzgJX1R5SalM9MT6xYq9sH50a3OEzUQzEC3N6FmkUCzYkzahOL50yZikyaNPSCWq+lVjCNqNNZcbYPmsg8DyR03ck8B34avHiBjdPiXDmz+ItsHayfPVWu90mrAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706074152; c=relaxed/simple;
	bh=SCaqfREY4WYRJaSH+a4M/iV9rOUo2A/5FsH8cNKe8wI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aVLqz8Bc0uW8ZYT7MvVGZ8LaXgyR5Pwaq6wi3h5KCWLhg8GNmShopus//bXe64Q0BGgu/T0R5hVGclGLtRWh6kOf2f6q9hpqNoJ2swEswQ3Ux+JNk9AWrkImIqEIaa9SLuIIHwag4kxvfG4oH/MPJ9DdTxbqQ0ofBVzZhPMl/aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 03f5958d14f34d72b6830c9b16f59e57-20240124
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:514ec0a1-fb3a-47b7-b0db-28a4bdd692ba,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:514ec0a1-fb3a-47b7-b0db-28a4bdd692ba,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:f00716fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:240124131300ADXQEYSM,BulkQuantity:0,Recheck:0,SF:44|66|24|17|19|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,
	TF_CID_SPAM_SNR
X-UUID: 03f5958d14f34d72b6830c9b16f59e57-20240124
X-User: huxiaoying@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
	(envelope-from <huxiaoying@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2033242904; Wed, 24 Jan 2024 13:12:57 +0800
From: Tom Hu <huxiaoying@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: minyard@acm.org,
	xiaoying_hu@126.com,
	huxiaoying <huxiaoying@kylinos.cn>
Subject: [PATCH] char: warnning msg for devm_snprintf failed to allocate memory.
Date: Wed, 24 Jan 2024 13:12:54 +0800
Message-Id: <20240124051254.476341-1-huxiaoying@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: huxiaoying <huxiaoying@kylinos.cn>

Signed-off-by: Tom Hu <huxiaoying@kylinos.cn>
---
 drivers/char/ipmi/ipmb_dev_int.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index 49100845fcb7..8e703ecb27c3 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -321,6 +321,9 @@ static int ipmb_probe(struct i2c_client *client)
 	ipmb_dev->miscdev.name = devm_kasprintf(&client->dev, GFP_KERNEL,
 						"%s%d", "ipmb-",
 						client->adapter->nr);
+	if (!ipmb_dev->miscdev.name)
+		pr_warn("Failed to allocate mem to miscdev.name\n");
+
 	ipmb_dev->miscdev.fops = &ipmb_fops;
 	ipmb_dev->miscdev.parent = &client->dev;
 	ret = misc_register(&ipmb_dev->miscdev);
-- 
2.25.1


