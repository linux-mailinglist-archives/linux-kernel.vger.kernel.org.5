Return-Path: <linux-kernel+bounces-122146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB31788F2B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32101C271D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB86154BF0;
	Wed, 27 Mar 2024 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="ZFaMkrGC"
Received: from mail-108-mta190.mxroute.com (mail-108-mta190.mxroute.com [136.175.108.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFB5154BF3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581470; cv=none; b=Ra/e8GMPPfsGeVhQihA9U5m7OY8fDa1NHPm32uUv7tisIpU2+WsiJ4AtdxBXmmw159tPxXzxYJBfF6Crc0haFGGKoU2S4s+9RalvAGjfjzVIIJc8UuSbRS60A8KGDYmK9mzB1L35y1mMK9jdX0ddaDVBD/Axvy6lY1YHa02D3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581470; c=relaxed/simple;
	bh=1iE8P7W9oJH44MhsahqLftnU88zvC+0TSEH6ZniPwWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWJBqtExIo/niPOnFpIXU9eIwzO84cp4x4tgLLeLitmtcbqIoErSql6mojP96e+cFPiaC9/whLlCoKLzmSst/5BGOJ7bJsNuATHhh7cZJ5bKTyVpNvDM25j5jStHI23ZKmupAlQudNwy8EkEwTqDNlv7vSSXwxt+a8YiSfYaYVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=ZFaMkrGC; arc=none smtp.client-ip=136.175.108.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta190.mxroute.com (ZoneMTA) with ESMTPSA id 18e823447750003bea.00f
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 27 Mar 2024 23:17:28 +0000
X-Zone-Loop: a1067ebaf39cb9b6bbd7a44f8dd65ede421c7bfc7bd7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hq3LXvJ1k7/mJNF6jC9ba4k3K25mnAdHN91vxGscAic=; b=ZFaMkrGCR1VTgX5BJNZOHrhz+Z
	KLQI+o+Pd5s+9A9IseKwvfEU9EQK9bJRrCB+iG4OIo1SNJBDHHRBTyXVnU9GubB5obZfiVxtWwHcX
	cTxNm85ckb3KuflObK/r8YEazGnH8pip9kUxd7yFTxx4+aLYZejrhub1FHNMPt8bsMsma0knekvvj
	UOFLAlTz7Ai73jkJtFjKEK7eb0zz9c0vAhvMq5EpiJesb6YMjbsF/nhDiowRhy7adyO8t5CczWHRu
	37K1+kXrXa4rZKArZQdrCe5GZdNIXeslLOjFgtR+Q6mgFEai9gSmYEkolyFMnV4KTXZCBY63CugD1
	8EUSyzrQ==;
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
	Luigi311 <git@luigi311.com>
Subject: [PATCH 05/23] media: i2c: imx258: Add regulator control
Date: Wed, 27 Mar 2024 17:16:51 -0600
Message-ID: <20240327231710.53188-6-git@luigi311.com>
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

The device tree bindings define the relevant regulators for the
sensor, so update the driver to request the regulators and control
them at the appropriate times.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Luigi311 <git@luigi311.com>
---
 drivers/media/i2c/imx258.c | 42 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index df7ed4716762..495eaada2945 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -7,6 +7,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-fwnode.h>
@@ -507,6 +508,16 @@ static const char * const imx258_test_pattern_menu[] = {
 	"Pseudorandom Sequence (PN9)",
 };
 
+/* regulator supplies */
+static const char * const imx258_supply_name[] = {
+	/* Supplies can be enabled in any order */
+	"vana",  /* Analog (2.8V) supply */
+	"vdig",  /* Digital Core (1.2V) supply */
+	"vif",  /* IF (1.8V) supply */
+};
+
+#define IMX258_NUM_SUPPLIES ARRAY_SIZE(imx258_supply_name)
+
 /* Configurations for supported link frequencies */
 #define IMX258_LINK_FREQ_634MHZ	633600000ULL
 #define IMX258_LINK_FREQ_320MHZ	320000000ULL
@@ -611,6 +622,7 @@ struct imx258 {
 	struct mutex mutex;
 
 	struct clk *clk;
+	struct regulator_bulk_data supplies[IMX258_NUM_SUPPLIES];
 };
 
 static inline struct imx258 *to_imx258(struct v4l2_subdev *_sd)
@@ -995,9 +1007,19 @@ static int imx258_power_on(struct device *dev)
 	struct imx258 *imx258 = to_imx258(sd);
 	int ret;
 
+	ret = regulator_bulk_enable(IMX258_NUM_SUPPLIES,
+				    imx258->supplies);
+	if (ret) {
+		dev_err(dev, "%s: failed to enable regulators\n",
+			__func__);
+		return ret;
+	}
+
 	ret = clk_prepare_enable(imx258->clk);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "failed to enable clock\n");
+		regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
+	}
 
 	return ret;
 }
@@ -1008,6 +1030,7 @@ static int imx258_power_off(struct device *dev)
 	struct imx258 *imx258 = to_imx258(sd);
 
 	clk_disable_unprepare(imx258->clk);
+	regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
 
 	return 0;
 }
@@ -1220,6 +1243,18 @@ static void imx258_free_controls(struct imx258 *imx258)
 	mutex_destroy(&imx258->mutex);
 }
 
+static int imx258_get_regulators(struct imx258 *imx258,
+				 struct i2c_client *client)
+{
+	unsigned int i;
+
+	for (i = 0; i < IMX258_NUM_SUPPLIES; i++)
+		imx258->supplies[i].supply = imx258_supply_name[i];
+
+	return devm_regulator_bulk_get(&client->dev,
+				    IMX258_NUM_SUPPLIES, imx258->supplies);
+}
+
 static int imx258_probe(struct i2c_client *client)
 {
 	struct imx258 *imx258;
@@ -1230,6 +1265,11 @@ static int imx258_probe(struct i2c_client *client)
 	if (!imx258)
 		return -ENOMEM;
 
+	ret = imx258_get_regulators(imx258, client);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to get regulators\n");
+
 	imx258->clk = devm_clk_get_optional(&client->dev, NULL);
 	if (IS_ERR(imx258->clk))
 		return dev_err_probe(&client->dev, PTR_ERR(imx258->clk),
-- 
2.42.0


