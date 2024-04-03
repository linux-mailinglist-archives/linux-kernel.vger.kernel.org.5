Return-Path: <linux-kernel+bounces-130056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBBE8973CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF70B2D95F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCA1152527;
	Wed,  3 Apr 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="Mx8JedB6"
Received: from mail-108-mta38.mxroute.com (mail-108-mta38.mxroute.com [136.175.108.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE5614BF9E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156960; cv=none; b=PQghYN26kv665Tz+H9MdixXII2cXP2QDD9bamTNhuKB/Gsoszy62i3is6G2U8RyKD1Hgei7EbfotfPQelW8PmuNbU+uJFe0v5SOl5NI6gGvs/K5PSNoz4y+Nh8MBG1IkEuusmaDpcrlEqbrfxupxzrbafqlGSS4I2SVCgrkEo9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156960; c=relaxed/simple;
	bh=X8l0Qu5ct8EeMly/eTF0Crxww6UHAs2wZ0Q0VRWgXwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjM4O463lV1Czh3+WiynO/O0xtjg63x7TAIpNt0mx/ZHN/2y5BS0MUeTOP93SrtpvHKKi2YPfCpVm3dhzMTLZrtvMLwWQ+IX2HF1FuZhPcYbz2vqgNkt3hRpPMDS97FvbOnACwtR4CTYheQmaCCR0+nRmX7EvfgaK619VNc7Hsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=Mx8JedB6; arc=none smtp.client-ip=136.175.108.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta38.mxroute.com (ZoneMTA) with ESMTPSA id 18ea480c0610003bea.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 03 Apr 2024 15:08:05 +0000
X-Zone-Loop: 981a6e85839eab7669b67697654f107c0738c5e9f91f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MUtTZIUft2Qwd/Ss8DLnay+tIu1VwSFMmHTaDB0Zatw=; b=Mx8JedB6wozdYbTdvWIQzPOy0e
	w6Plus8ggU9/koj1uwXYIszoXv64qrgqvk15H0r5BAj68b2y9h8r7PKgGwN49Uwh/5s/BBDlRLma8
	KcbV3u6V0bVVYd3wDdorlrd+51wNDg0LSKIknwqv70jgmpm9mj9Zih9E588IoQZLVADJS5dxd3C+W
	//o2aCL84V2i2etbv2S/PSG9dFlr/y4qKsnwKj3OV7tfSjm2b3VXkFGfQAN/qkzwXu35ITEvkOArA
	jAZgVg2H08N+AxO1s8jk/trOSANpG4aJecgwm1Ia1b6jzOUHvbo3JxHOhoFjg+HeFsjAqEDxkZqCS
	VQtQv09g==;
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
Subject: [PATCH v3 23/25] drivers: media: i2c: imx258: Add support for powerdown gpio
Date: Wed,  3 Apr 2024 09:03:52 -0600
Message-ID: <20240403150355.189229-24-git@luigi311.com>
In-Reply-To: <20240403150355.189229-1-git@luigi311.com>
References: <20240403150355.189229-1-git@luigi311.com>
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
 drivers/media/i2c/imx258.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index 30352c33f63c..163f04f6f954 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -679,6 +679,8 @@ struct imx258 {
 	unsigned int lane_mode_idx;
 	unsigned int csi2_flags;
 
+	struct gpio_desc *powerdown_gpio;
+
 	/*
 	 * Mutex for serialized access:
 	 * Protect sensor module set pad format and start/stop streaming safely.
@@ -1213,6 +1215,8 @@ static int imx258_power_on(struct device *dev)
 	struct imx258 *imx258 = to_imx258(sd);
 	int ret;
 
+	gpiod_set_value_cansleep(imx258->powerdown_gpio, 0);
+
 	ret = regulator_bulk_enable(IMX258_NUM_SUPPLIES,
 				    imx258->supplies);
 	if (ret) {
@@ -1224,6 +1228,7 @@ static int imx258_power_on(struct device *dev)
 	ret = clk_prepare_enable(imx258->clk);
 	if (ret) {
 		dev_err(dev, "failed to enable clock\n");
+		gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
 		regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
 	}
 
@@ -1238,6 +1243,8 @@ static int imx258_power_off(struct device *dev)
 	clk_disable_unprepare(imx258->clk);
 	regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
 
+	gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
+
 	return 0;
 }
 
@@ -1541,6 +1548,12 @@ static int imx258_probe(struct i2c_client *client)
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


