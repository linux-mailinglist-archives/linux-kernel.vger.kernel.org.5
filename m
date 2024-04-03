Return-Path: <linux-kernel+bounces-130051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B54897393
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC9D1C27BA6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF61A14E2ED;
	Wed,  3 Apr 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="o7l8zwQ6"
Received: from mail-108-mta144.mxroute.com (mail-108-mta144.mxroute.com [136.175.108.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209E114D6F3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156941; cv=none; b=U4BsI+mh//+wWexYL3EhrL5eSavzcetaeIH6msTP5J1TntaEUSxJI37FDL+qbndwrfd9IW6pLfLinzJm+E4AaJBsuL9hZ/IPXejZs503BU5O0Abbjx0cGa3LpXv4PCh+JqRKw+INXodl4rGjpG0up66FPQYDC65UIvliX3GOZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156941; c=relaxed/simple;
	bh=SZKceW7XhiaFkOM1tmAN0wp1PM47pjw3iJvgmSOm5o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESZ+0njo3hgxnVtemNzZfrZEJuDHRSP5Wa8+aEr6dv3fz3hiu1PKSXX57xSv8K9I9bislAPZPPb1Ep8iCckh76vNFFNOSbbS1vMUaHDPf62ocwSoZuY67TXCa41UVT0sK9xPYaFQH1QFP9OhU3mvMDE9/4ddz/XVYU83VZJXsT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=o7l8zwQ6; arc=none smtp.client-ip=136.175.108.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta144.mxroute.com (ZoneMTA) with ESMTPSA id 18ea4809fcc0003bea.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 03 Apr 2024 15:07:56 +0000
X-Zone-Loop: 72260621b4f8ffe5973d9a6b2b8a5e58654f9f622fc3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=89UYSwemjH72oCJkImoj3GYITxzLE07DmWICqE+PSTA=; b=o7l8zwQ6frYkmj0OJGZtK64NUa
	h7YAI85vmWCxIqCkNZwSlU48WtNJ10P3xewp+Q2rppA9GinKIwNxsMlGiEbxOFDuUzZHyiEK50+rf
	DsA4rie9qVKkAfCqnIKEduBqzYB4Aq7TCrxe+NUS82k0nbb0oXu7f1UOCmtQplw1f6k7XmYNoovjL
	tcAgUflDknJevPd0PXBSBZ9Uz6lSyMD6px3QHzHiAOeGe4cc3+lGEWC0YfK0TvWtfXDBDLY8KFn3f
	qv+sJHTA4o1i0mxukWtzS8zVKyaC55Bnb94BNPc7I/HCEZjF1XyTxembR4KkQk3rSD77nrTvCX0ih
	5md5ucdg==;
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
	Luis Garcia <git@luigi311.com>
Subject: [PATCH v3 19/25] media: i2c: imx258: Change register settings for variants of the sensor
Date: Wed,  3 Apr 2024 09:03:48 -0600
Message-ID: <20240403150355.189229-20-git@luigi311.com>
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

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

Sony have advised that there are variants of the IMX258 sensor which
require slightly different register configuration to the mainline
imx258 driver defaults.

There is no available run-time detection for the variant, so add
configuration via the DT compatible string.

The Vision Components imx258 module supports PDAF, so add the
register differences for that variant

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Luis Garcia <git@luigi311.com>
---
 drivers/media/i2c/imx258.c | 48 ++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index 775d957c9b87..fa48da212037 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <media/v4l2-ctrls.h>
@@ -321,8 +322,6 @@ static const struct imx258_reg mipi_642mbps_24mhz_4l[] = {
 
 static const struct imx258_reg mode_common_regs[] = {
 	{ 0x3051, 0x00 },
-	{ 0x3052, 0x00 },
-	{ 0x4E21, 0x14 },
 	{ 0x6B11, 0xCF },
 	{ 0x7FF0, 0x08 },
 	{ 0x7FF1, 0x0F },
@@ -345,7 +344,6 @@ static const struct imx258_reg mode_common_regs[] = {
 	{ 0x7FA8, 0x03 },
 	{ 0x7FA9, 0xFE },
 	{ 0x7B24, 0x81 },
-	{ 0x7B25, 0x00 },
 	{ 0x6564, 0x07 },
 	{ 0x6B0D, 0x41 },
 	{ 0x653D, 0x04 },
@@ -460,6 +458,33 @@ static const struct imx258_reg mode_1048_780_regs[] = {
 	{ 0x034F, 0x0C },
 };
 
+struct imx258_variant_cfg {
+	const struct imx258_reg *regs;
+	unsigned int num_regs;
+};
+
+static const struct imx258_reg imx258_cfg_regs[] = {
+	{ 0x3052, 0x00 },
+	{ 0x4E21, 0x14 },
+	{ 0x7B25, 0x00 },
+};
+
+static const struct imx258_variant_cfg imx258_cfg = {
+	.regs = imx258_cfg_regs,
+	.num_regs = ARRAY_SIZE(imx258_cfg_regs),
+};
+
+static const struct imx258_reg imx258_pdaf_cfg_regs[] = {
+	{ 0x3052, 0x01 },
+	{ 0x4E21, 0x10 },
+	{ 0x7B25, 0x01 },
+};
+
+static const struct imx258_variant_cfg imx258_pdaf_cfg = {
+	.regs = imx258_pdaf_cfg_regs,
+	.num_regs = ARRAY_SIZE(imx258_pdaf_cfg_regs),
+};
+
 static const char * const imx258_test_pattern_menu[] = {
 	"Disabled",
 	"Solid Colour",
@@ -637,6 +662,8 @@ struct imx258 {
 	struct v4l2_subdev sd;
 	struct media_pad pad;
 
+	const struct imx258_variant_cfg *variant_cfg;
+
 	struct v4l2_ctrl_handler ctrl_handler;
 	/* V4L2 Controls */
 	struct v4l2_ctrl *link_freq;
@@ -1104,6 +1131,14 @@ static int imx258_start_streaming(struct imx258 *imx258)
 		return ret;
 	}
 
+	ret = imx258_write_regs(imx258, imx258->variant_cfg->regs,
+				imx258->variant_cfg->num_regs);
+	if (ret) {
+		dev_err(&client->dev, "%s failed to set variant config\n",
+			__func__);
+		return ret;
+	}
+
 	ret = imx258_write_reg(imx258, IMX258_CLK_BLANK_STOP,
 			       IMX258_REG_VALUE_08BIT,
 			       imx258->csi2_flags & V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK ?
@@ -1492,6 +1527,10 @@ static int imx258_probe(struct i2c_client *client)
 
 	imx258->csi2_flags = ep.bus.mipi_csi2.flags;
 
+	imx258->variant_cfg = of_device_get_match_data(&client->dev);
+	if (!imx258->variant_cfg)
+		imx258->variant_cfg = &imx258_cfg;
+
 	/* Initialize subdev */
 	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
 
@@ -1579,7 +1618,8 @@ MODULE_DEVICE_TABLE(acpi, imx258_acpi_ids);
 #endif
 
 static const struct of_device_id imx258_dt_ids[] = {
-	{ .compatible = "sony,imx258" },
+	{ .compatible = "sony,imx258", .data = &imx258_cfg },
+	{ .compatible = "sony,imx258-pdaf", .data = &imx258_pdaf_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx258_dt_ids);
-- 
2.42.0


