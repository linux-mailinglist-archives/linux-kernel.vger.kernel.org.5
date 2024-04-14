Return-Path: <linux-kernel+bounces-144381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678938A4533
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24206281082
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365E8137749;
	Sun, 14 Apr 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="udBoGc6e"
Received: from mail-108-mta129.mxroute.com (mail-108-mta129.mxroute.com [136.175.108.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A28A38F83
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713127036; cv=none; b=dgroFTX5Oz4kDV1IDGrBeUBfFF3RFhAPnjgNdm4r/p4PmSQGYjOYO8yLF2g+WGVIm9Xw6XddWrBDHoBMJ5rZeqBI4s3j52cq9Ok1bpsFGyMJ86FvefXEEc+p6WDDi102UozHLhErC1DDhawRzRCru2tUi0YpleVVx9BiX4ejoBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713127036; c=relaxed/simple;
	bh=t/cCBhDYCw1r5pzuqPaZFNwhzv2t0n4vkiPOtOot3k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmu5EwE6gwyXoY6NxO1L/0s17DvIKwFB51y0LvUylj/kEUBSCdDWOhu/JKcZbpRzu3zp20gDJhyeowdS4Ouxy10BWZrFIzGUSPo2C6o9cj6xEzLKsHOP/vw/S2erO4SHbJ7Tv7yP4s8LPt9YvaSKDu7PZ5sHNeC6WDCqKLedMsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=udBoGc6e; arc=none smtp.client-ip=136.175.108.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta129.mxroute.com (ZoneMTA) with ESMTPSA id 18ede52ecdc0003bea.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 14 Apr 2024 20:36:00 +0000
X-Zone-Loop: 1ca26a539e193c8db97efa9834b37f52c2b38714250a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0ImDi7ltEDkTokT6mguLi93jksL5klxdx4wbp5jiCIg=; b=udBoGc6eJSLXRBX7Q/xovah8ZY
	ev2shxAewp0D+viunnhh7BWSGYG+cBIsStjRBYQEOsDpzplnAfd2vTUyfyfa01L9+Tb9AUM9wZDZj
	RHKNn375xqzepToO7CZDt6DrXJLGj0j+mO2iGa/zPsyRan5ngcMqbzWE24h6ccGk74FIPOttmTfx/
	WTwDRLLN9bVpcGkU0KVrWTXravIeXfr0LM12JEz3Qa6UhvioMQTTFKSWUygwTrHhqz4QWayCKKoRZ
	d5hMQ/6Jlz6iP4rxMg3YctMBghlWTOJMahNrDxItEzjGf7nVpmpfVMDiFcuIL9cff+JyPAbtUCNcJ
	28Hfl8cw==;
From: git@luigi311.com
To: linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pavel@ucw.cz,
	phone-devel@vger.kernel.org,
	Luis Garcia <git@luigi311.com>,
	Ondrej Jirman <megi@xff.cz>
Subject: [PATCH v4 22/25] media: i2c: imx258: Add support for powerdown gpio
Date: Sun, 14 Apr 2024 14:35:00 -0600
Message-ID: <20240414203503.18402-23-git@luigi311.com>
In-Reply-To: <20240414203503.18402-1-git@luigi311.com>
References: <20240414203503.18402-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Luis Garcia <git@luigi311.com>

On some boards powerdown signal needs to be deasserted for this
sensor to be enabled.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Luis Garcia <git@luigi311.com>
---
 drivers/media/i2c/imx258.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index f043200e336e..f0bd72f241e4 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -698,6 +698,8 @@ struct imx258 {
 	unsigned int lane_mode_idx;
 	unsigned int csi2_flags;
 
+	struct gpio_desc *powerdown_gpio;
+
 	/*
 	 * Mutex for serialized access:
 	 * Protect sensor module set pad format and start/stop streaming safely.
@@ -1231,6 +1233,8 @@ static int imx258_power_on(struct device *dev)
 	struct imx258 *imx258 = to_imx258(sd);
 	int ret;
 
+	gpiod_set_value_cansleep(imx258->powerdown_gpio, 0);
+
 	ret = regulator_bulk_enable(IMX258_NUM_SUPPLIES,
 				    imx258->supplies);
 	if (ret) {
@@ -1242,6 +1246,7 @@ static int imx258_power_on(struct device *dev)
 	ret = clk_prepare_enable(imx258->clk);
 	if (ret) {
 		dev_err(dev, "failed to enable clock\n");
+		gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
 		regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
 	}
 
@@ -1254,6 +1259,9 @@ static int imx258_power_off(struct device *dev)
 	struct imx258 *imx258 = to_imx258(sd);
 
 	clk_disable_unprepare(imx258->clk);
+
+	gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
+
 	regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
 
 	return 0;
@@ -1559,6 +1567,12 @@ static int imx258_probe(struct i2c_client *client)
 	if (!imx258->variant_cfg)
 		imx258->variant_cfg = &imx258_cfg;
 
+	/* request optional power down pin */
+	imx258->powerdown_gpio = devm_gpiod_get_optional(&client->dev, "powerdown",
+							 GPIOD_OUT_HIGH);
+	if (IS_ERR(imx258->powerdown_gpio))
+		return PTR_ERR(imx258->powerdown_gpio);
+
 	/* Initialize subdev */
 	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
 
-- 
2.44.0


