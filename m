Return-Path: <linux-kernel+bounces-122175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 680F488F316
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0541F2E685
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA2C15686B;
	Wed, 27 Mar 2024 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="CQZa0O3P"
Received: from mail-108-mta42.mxroute.com (mail-108-mta42.mxroute.com [136.175.108.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82E15666A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581807; cv=none; b=jc578Ds/aKyFK8ig9KlT247DoJskHwd6eV4XLPGgnHeNkiWRL5ZWj3UHsvQeejiqVBfwEyB1FJVGqqdAPCVtMOpw0UYPB6rfeC2MHJgGiSLL69Qy+ANW4gr4GqZ5wnf6jaziHGppnrdanwnt2LBVQ06t+Vap8gWhm05ftwp56sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581807; c=relaxed/simple;
	bh=0vPk/AhRfa0eJWWuR2HM/VywuaD7+XD66XjsHchVAAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiaXTZ2PG0Q60mD+6C7w519I/oWvqU8B41rkIiPVFYaN+02cWNaLcVZNLImvb9Egj58FGRWGeBd5TliH8QytOCyWX9fUfeOJMNFn+RLkClFWVLE99P4PU31jZst+N2oFIj7+BM9vu8hXW8uuIjTd+DQoMdoVupnOzMTdYg25CCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=CQZa0O3P; arc=none smtp.client-ip=136.175.108.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta42.mxroute.com (ZoneMTA) with ESMTPSA id 18e8234c8880003bea.00f
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 27 Mar 2024 23:18:01 +0000
X-Zone-Loop: 1a6cfa4d518c963a6c29148c9fce95b0a07a2e5eb217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bZsei1tpRAidGrbzZBEBrMkrAWAYUFFFPXs9zNhTnjM=; b=CQZa0O3PSCbFR1uiO7kH14OhAl
	MRIrBoW588+LBeFTMgqoC9m6Q6QhFF9QJXofPkO5Y608wcdb0mwdS6uG971ktGYzOVPFDlYRrMxT5
	IdUr7FImKuxuMA+r9BaBdB+OKEHWTAGM2a1CpTzW/dkctGnYYIiOghw5joJ7TBgpxNhMvXDT9KF+5
	+tx2NWcH66UGXEkkA8Sv+WMKabdhX1UQ6i5zz7Zu8XnkY2SXNq6/B+3VvboiVrKMTNrmjlSlcQiDT
	nACFUSO4pwvsJzaOX+uq8qWVO65/VB4hXQnNfhxEKxrgq/aDrjIKRVHJ34Zf6krUjS6W9wFpMESaN
	3sPxq0kg==;
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
	Luigi311 <git@luigi311.com>,
	Ondrej Jirman <megi@xff.cz>
Subject: [PATCH 22/23] drivers: media: i2c: imx258: Add support for powerdown gpio
Date: Wed, 27 Mar 2024 17:17:08 -0600
Message-ID: <20240327231710.53188-23-git@luigi311.com>
In-Reply-To: <20240327231710.53188-1-git@luigi311.com>
References: <20240327231710.53188-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Luigi311 <git@luigi311.com>

On some boards powerdown signal needs to be deasserted for this
sensor to be enabled.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 .../devicetree/bindings/media/i2c/sony,imx258.yaml  |  4 ++++
 drivers/media/i2c/imx258.c                          | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
index c7856de15ba3..0414085bf22f 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
@@ -35,6 +35,10 @@ properties:
   reg:
     maxItems: 1
 
+  powerdown-gpios:
+    description: |-
+      Reference to the GPIO connected to the PWDN pin, if any.
+
   reset-gpios:
     description: |-
       Reference to the GPIO connected to the XCLR pin, if any.
diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index c559a06bf180..d8c51d5f04e0 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -686,6 +686,8 @@ struct imx258 {
 	unsigned int lane_mode_idx;
 	unsigned int csi2_flags;
 
+	struct gpio_desc *powerdown_gpio;
+
 	/*
 	 * Mutex for serialized access:
 	 * Protect sensor module set pad format and start/stop streaming safely.
@@ -1220,6 +1222,8 @@ static int imx258_power_on(struct device *dev)
 	struct imx258 *imx258 = to_imx258(sd);
 	int ret;
 
+	gpiod_set_value_cansleep(imx258->powerdown_gpio, 0);
+
 	ret = regulator_bulk_enable(IMX258_NUM_SUPPLIES,
 				    imx258->supplies);
 	if (ret) {
@@ -1231,6 +1235,7 @@ static int imx258_power_on(struct device *dev)
 	ret = clk_prepare_enable(imx258->clk);
 	if (ret) {
 		dev_err(dev, "failed to enable clock\n");
+		gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
 		regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
 	}
 
@@ -1245,6 +1250,8 @@ static int imx258_power_off(struct device *dev)
 	clk_disable_unprepare(imx258->clk);
 	regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
 
+	gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
+
 	return 0;
 }
 
@@ -1548,6 +1555,12 @@ static int imx258_probe(struct i2c_client *client)
 	if (!imx258->variant_cfg)
 		imx258->variant_cfg = &imx258_cfg;
 
+	/* request optional power down pin */
+	imx258->powerdown_gpio = devm_gpiod_get_optional(&client->dev, "powerdown",
+						    GPIOD_OUT_HIGH);
+	if (IS_ERR(imx258->powerdown_gpio))
+		return PTR_ERR(imx258->powerdown_gpio);
+
 	/* Initialize subdev */
 	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
 
-- 
2.42.0


