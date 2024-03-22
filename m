Return-Path: <linux-kernel+bounces-111528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB43886D57
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512DF1C246E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEB4657CA;
	Fri, 22 Mar 2024 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="IunH1A6N"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D2963518
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114045; cv=none; b=HKnpeIG9pKaVYJ/GJZFpXjLQFks2wH0lbCG9rqk0MgPpu2mNPm1opcHXbUuYE3emC9O+mNUsVPbaeQLk41S3MGB5jd8Jh3AyKvEZEJ1ujzNjt45f5GCn9gXSDWnra8UaVkaMnz8LQFWYUntq+Ju6YZss7MnCgGrD0IrmGtXbXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114045; c=relaxed/simple;
	bh=VMxSxsDrMIWOAp623V5jvSZ4cL+pryV8GSIsKQDn4HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCY9RPQIYESGuBcUzj7eaY4WYi78Da4hfCZa20lcS63m/ZrBCzpgUf7/4LA3/pMHgz8qBKT36/O0DAb/Ao2mrKRn8QYL34nWhcNhrMMvU4KKV5Sxl2BHId8GXDplUDsD9moNcTBK0LffIWWFgFkpPbgKaW8gG9B43f9XLVOGL/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=IunH1A6N; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=kmFZAXTAUJkEHBINWtZi5gZBA3xVRr2hXYbcafka3So=; b=IunH1A
	6NiWhsejL+KPndU6242octjCHvXtl9fAgeq7JQxjHvdjeK04DE+0Y8aBV4Pas+yt
	TxqKF5wS4gv0rHrtUCzzW6zdxAdBVF+ssRd1hRo9OfUV09sOVEXs9dNPdMH4Z1aU
	G7XzV4Dqc2NmEwqM1Y5RoANQY9m9mplnos8IzAAbRfcYQkF8/BTIWZyyirnQeen+
	2X8pIWBGJZWwprrEfFu1P+CUdzS6S0JlY7tRucaiZmPO70kVLmOGMPXFNAvAHOCX
	gefZEEaqNMANXn5f4EOp0WSa4ZwKjL5nGwenat/QrV6EJmOSi42tD37Rt4mSAgeI
	Wwk4u6Ubdy/j1Euw==
Received: (qmail 3871800 invoked from network); 22 Mar 2024 14:27:01 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Mar 2024 14:27:01 +0100
X-UD-Smtp-Session: l3s3148p1@lDxuxz8UGJRehhtF
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 49/64] i2c: sh_mobile: reword according to newest specification
Date: Fri, 22 Mar 2024 14:25:42 +0100
Message-ID: <20240322132619.6389-50-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Match the wording of this driver wrt. the newest I2C v7, SMBus 3.2, I3C
specifications and replace "master/slave" with more appropriate terms.
They are also more specific because we distinguish now between a remote
entity ("client") and a local one ("target").

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index c65ac3d7eadc..276a036d8ef0 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -53,7 +53,7 @@
 /*                                                                          */
 /* Receive operation:                                                       */
 /*                                                                          */
-/* 0 byte receive - not supported since slave may hold SDA low              */
+/* 0 byte receive - not supported since client may hold SDA low             */
 /*                                                                          */
 /* 1 byte receive       [TX] | [RX]                                         */
 /* BUS:     S     A8     ACK | D8(1)   ACK   P(*)                           */
@@ -93,7 +93,7 @@
 /*         _______________________________________________                  */
 /* BUSY __/                                               \_                */
 /*                                                                          */
-/* (*) The STOP condition is only sent by the master at the end of the last */
+/* (*) The STOP condition is only sent by the host at the end of the last   */
 /* I2C message or if the I2C_M_STOP flag is set. Similarly, the BUSY bit is */
 /* only cleared after the STOP condition, so, between messages we have to   */
 /* poll for the DTE bit.                                                    */
@@ -495,7 +495,7 @@ static struct dma_chan *sh_mobile_i2c_request_dma_chan(struct device *dev,
 
 	ret = dmaengine_slave_config(chan, &cfg);
 	if (ret) {
-		dev_dbg(dev, "slave_config failed for %s (%d)\n", chan_name, ret);
+		dev_dbg(dev, "DMA config failed for %s (%d)\n", chan_name, ret);
 		dma_release_channel(chan);
 		return ERR_PTR(ret);
 	}
@@ -540,7 +540,7 @@ static void sh_mobile_i2c_xfer_dma(struct sh_mobile_i2c_data *pd)
 					 read ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV,
 					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!txdesc) {
-		dev_dbg(pd->dev, "dma prep slave sg failed, using PIO\n");
+		dev_dbg(pd->dev, "dma prep sg failed, using PIO\n");
 		sh_mobile_i2c_cleanup_dma(pd, false);
 		return;
 	}
@@ -740,8 +740,8 @@ static u32 sh_mobile_i2c_func(struct i2c_adapter *adapter)
 
 static const struct i2c_algorithm sh_mobile_i2c_algorithm = {
 	.functionality = sh_mobile_i2c_func,
-	.master_xfer = sh_mobile_i2c_xfer,
-	.master_xfer_atomic = sh_mobile_i2c_xfer_atomic,
+	.xfer = sh_mobile_i2c_xfer,
+	.xfer_atomic = sh_mobile_i2c_xfer_atomic,
 };
 
 static const struct i2c_adapter_quirks sh_mobile_i2c_quirks = {
-- 
2.43.0


