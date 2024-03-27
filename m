Return-Path: <linux-kernel+bounces-122176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEA888F318
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFC51F2E410
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B16C15666D;
	Wed, 27 Mar 2024 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="HJ1eg5oN"
Received: from mail-108-mta123.mxroute.com (mail-108-mta123.mxroute.com [136.175.108.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD1C156669
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581807; cv=none; b=Lp09sb4TXvgP3CDt4i1frTcOvkxcmRZcijrGXTUZTtExCTYMsZhTBnT7KkjXO1i6RdVOIkjPVId0aDoyUHWsBf/yD6Vk5zZpoIm743H5MdttCRyEb1ugnsr5CMa4YFcZpYHcMW2ErVICa5B+qoZ/MYon592doNiCjmmq6n9uP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581807; c=relaxed/simple;
	bh=6+2wz7C48VzI3IyZhlih65O+oIcytRh3P8S1DW3VqYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWqtEZB+n5DNZRhB7WIiePm1BEoqBksY0epsZxZd89GqQKYh2aLq2WAf1ry2Pk72ElNNoya/ZwG17EGLtSWOZFTrvNByyz4bSYfoc/Y1nzeXsk1iAoFKnpbKKxwICv8qLfnoUoLuUhGokxMng5atJ/ChKNw0qm6KceKPWixWj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=HJ1eg5oN; arc=none smtp.client-ip=136.175.108.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta123.mxroute.com (ZoneMTA) with ESMTPSA id 18e823488ac0003bea.00f
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 27 Mar 2024 23:17:44 +0000
X-Zone-Loop: 772719196a745200371b9d60c1a9d2c9fccf6a25e704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MWmmMzvpB7rAQwa1TAxwPfh+Zj5RVzbFzB4BAQpgxHA=; b=HJ1eg5oNFBw6ptNnK6DZzTUMzV
	eizEzmCukzFA5ZssZ1MdX5BAte3cGofJ/hqCj6uVuVQxWdTOIcAB6FGDKE420+IytRo4HNswQy6FN
	QQADfHQLAFNW88ni8/35rUCXtevGG3wkSdJK5pAfyDJMbTpTd5RI3/bhay2IZ3FQA7bkxvabqSlx+
	Yu2Gy8YQnWQauI3NjagAnxbq/LJlYm3VrFd3rVRaiTMrMnUvrTzeCLfwdC1qakl1Y3LHSgiGoJFVH
	CxcosMAqcgoF1xgeaL3Js5On987dUVbavhEkf4YpNn4jsogebyYaEjxb3q9lwlbmMvhrJAiok8oFr
	EOelcVUg==;
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/23] media: i2c: imx258: Issue reset before starting streaming
Date: Wed, 27 Mar 2024 17:17:00 -0600
Message-ID: <20240327231710.53188-15-git@luigi311.com>
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

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

Whilst not documented, register 0x0103 bit 0 is the soft
reset for the sensor, so send it before trying to configure
the sensor.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/media/i2c/imx258.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index c2c5e819ddc0..a62ed8c26663 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -20,6 +20,8 @@
 #define IMX258_MODE_STANDBY		0x00
 #define IMX258_MODE_STREAMING		0x01
 
+#define IMX258_REG_RESET		0x0103
+
 /* Chip ID */
 #define IMX258_REG_CHIP_ID		0x0016
 #define IMX258_CHIP_ID			0x0258
@@ -1059,6 +1061,16 @@ static int imx258_start_streaming(struct imx258 *imx258)
 	const struct imx258_link_freq_config *link_freq_cfg;
 	int ret, link_freq_index;
 
+	ret = imx258_write_reg(imx258, IMX258_REG_RESET, IMX258_REG_VALUE_08BIT,
+			       0x01);
+	if (ret) {
+		dev_err(&client->dev, "%s failed to reset sensor\n", __func__);
+		return ret;
+	}
+
+	/* 12ms is required from poweron to standby */
+	fsleep(12000);
+
 	/* Setup PLL */
 	link_freq_index = imx258->cur_mode->link_freq_index;
 	link_freq_cfg = &imx258->link_freq_configs[link_freq_index];
-- 
2.42.0


