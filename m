Return-Path: <linux-kernel+bounces-111492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE52886CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290EC1C21DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A135D8F6;
	Fri, 22 Mar 2024 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="TAdyd+hG"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D72F50A9D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114012; cv=none; b=ugZdwTZBAx0bWxCmS53cF+rLCp6hQ0hB1hZ+OZurddUgwq4MWyYqG3V0f2Hg/m0gDbD32Y9IMHojsHtHAzl6Da8Wcd/AuUcqPRzMGbiOp+q9JmPbN+6s5LwMm5+mZ+woHx1Mc1cCHM5KR0gMf4UBECmx8lolnWIFjnZdy5ikN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114012; c=relaxed/simple;
	bh=OAlNvTXGEkYV1iU16HT3reE5eFZpV/T3pdtkP4RibpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSaXyYQFCcy8yQ5UHetvE7f9VOmydzF75B+6vfXRnNeUvYgAui2KsqkUpugMh9zjQo2QlQvINqRsRnKM2a5/lts9iLIqEUaHxaK+Yd1DKnxUKu3k4/AzHF5221bv01RgzrDHP9+d+/oULX5X9Ec6WXQE3LFvGFwiob6eReRYUeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=TAdyd+hG; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=bKgrZEObGcmhfV42TbjIYa6lNwDyHSA/oza3/g3uxco=; b=TAdyd+
	hGz6KcvPtAGB6w6n5CXQ7uXp5/mcMwVTBZi2VYnAOuU+7dYoiDypDWdx0mRDWQv1
	JwQPq0hF8kK4eQ1TowJtQke0OYjQIojBRBf403/aksRzZdUfvoWwf9erT5lGOHs6
	tVbGV8zsGZTcdsZAzkdxrTvP1X7rH7Zp+sbdtDz6gUD8G9YtUQim2bI/zkyP3VrQ
	trsKtHSzlgxSk7NXLKk7n298VC3Ow9EP/P0BP/T6eunzU7DLYbh6rhhbD01nw3yg
	4eZt84TTZV/IDA5AzDDUT12gZ8iJhKTlRcu7st3DS9UacQYtoVevRpN86oT72Ef5
	fIeM/5dBJHXKKiqQ==
Received: (qmail 3870370 invoked from network); 22 Mar 2024 14:26:33 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Mar 2024 14:26:33 +0100
X-UD-Smtp-Session: l3s3148p1@Gxi9xT8UuuBehhtF
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/64] i2c: davinci: reword according to newest specification
Date: Fri, 22 Mar 2024 14:25:08 +0100
Message-ID: <20240322132619.6389-16-wsa+renesas@sang-engineering.com>
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
 drivers/i2c/busses/i2c-davinci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 02b3b1160fb0..1884d77934e9 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -263,7 +263,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 	/* compute clock dividers */
 	i2c_davinci_calc_clk_dividers(dev);
 
-	/* Respond at reserved "SMBus Host" slave address" (and zero);
+	/* Respond at reserved "SMBus Host" client address" (and zero);
 	 * we seem to have no option to not respond...
 	 */
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_OAR_REG, DAVINCI_I2C_OWN_ADDRESS);
@@ -407,7 +407,7 @@ static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev)
 }
 
 /*
- * Low level master read/write transaction. This function is called
+ * Low level host read/write transaction. This function is called
  * from i2c_davinci_xfer.
  */
 static int
@@ -428,7 +428,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	if (pdata->bus_delay)
 		udelay(pdata->bus_delay);
 
-	/* set the slave address */
+	/* set the client address */
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_SAR_REG, msg->addr);
 
 	dev->buf = msg->buf;
@@ -440,10 +440,9 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	reinit_completion(&dev->cmd_complete);
 	dev->cmd_err = 0;
 
-	/* Take I2C out of reset and configure it as master */
+	/* Take I2C out of reset and configure it as host */
 	flag = DAVINCI_I2C_MDR_IRS | DAVINCI_I2C_MDR_MST;
 
-	/* if the slave address is ten bit address, enable XA bit */
 	if (msg->flags & I2C_M_TEN)
 		flag |= DAVINCI_I2C_MDR_XA;
 	if (!(msg->flags & I2C_M_RD))
@@ -688,7 +687,7 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
 			break;
 
 		case DAVINCI_I2C_IVR_AAS:
-			dev_dbg(dev->dev, "Address as slave interrupt\n");
+			dev_dbg(dev->dev, "Address as client interrupt\n");
 			break;
 
 		default:
@@ -745,7 +744,7 @@ static inline void i2c_davinci_cpufreq_deregister(struct davinci_i2c_dev *dev)
 #endif
 
 static const struct i2c_algorithm i2c_davinci_algo = {
-	.master_xfer	= i2c_davinci_xfer,
+	.xfer	= i2c_davinci_xfer,
 	.functionality	= i2c_davinci_func,
 };
 
-- 
2.43.0


