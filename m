Return-Path: <linux-kernel+bounces-130043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD455897378
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6911F21B4F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE01214A623;
	Wed,  3 Apr 2024 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="nriGqUvR"
Received: from mail-108-mta105.mxroute.com (mail-108-mta105.mxroute.com [136.175.108.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9A514A62A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156861; cv=none; b=AVuia7TY4wbvwrNXO0j7ZHYLNOYynAF5pZCTENQ9hoRWK4se3l9PkTU6iVVWQ0unwiCNK7PMhIrAUFrBY6Nwsv2o7keqmdu9PfMktyv3G8+NcK0cyRw6pCSYmXCbLKoNAVCBZXc5va0ZTliMNphwVB/igTUTmExspKenq3b1rXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156861; c=relaxed/simple;
	bh=p/2CjxpgGSHmngntZ4G3Mf8HbIeSWUTf08sZ3fpDyaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQP4ciufigzWDP5FvKCTg8ojbUBZ+38TbhkE4ZbPipq4RwH9OuRUBR7L1GOZCXzCbUUZcGTumSuejtuaYUu3tc252tBkUgnT4ty4uqIWMenJjnC5BdWCH4h7sYzxfWKCfN8VCcf8OhbcRmZzadFulJKOuoDaTACHBqzfO+J8xAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=nriGqUvR; arc=none smtp.client-ip=136.175.108.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta105.mxroute.com (ZoneMTA) with ESMTPSA id 18ea48019f50003bea.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 03 Apr 2024 15:07:22 +0000
X-Zone-Loop: 9b21b170dbaa7925398741aaa3f8aa03aae2172b2c5a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oq7lZ8HrTywGSq7kzULa57nC/5tfOLJ5od2jKoW3WyA=; b=nriGqUvR9LYv5q30AgYiAgjDt6
	WBe4xF4oMnA5j02acCzFf1Le0JHnN9VAhVAeB5vZ66+yvz5Nm3jQAXwk7M1PjWv8O4dL2L6U3ELiG
	xr5y312IO1ET62knHT9jiLnJf4Gyfi6vG/LiwXXzd6rBz+agfsGed6GJfMMdC+nBRiQG2qPkuPUgg
	YFIsH3XOy3852hlPvXB9j8GoVuM/k90SmvMwPLY7dRWNr/m/wuqk7HU8/wHhfHHZrQVscL+8L0gv2
	uKLtnSltZoBt8O0mS+VIl9tIoo+4+52gSxYPrgq086cvik/gqh7VpsJSPs7DN1M/jSl5jY881m0cR
	4+v0Er4Q==;
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
Subject: [PATCH v3 02/25] media: i2c: imx258: Make image geometry meet sensor requirements
Date: Wed,  3 Apr 2024 09:03:31 -0600
Message-ID: <20240403150355.189229-3-git@luigi311.com>
In-Reply-To: <20240403150355.189229-1-git@luigi311.com>
References: <20240403150355.189229-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The output image is defined as being 4208x3118 pixels in size.
Y_ADD_STA register was set to 0, and Y_ADD_END to 3118, giving
3119 lines total.

The datasheet lists a requirement for Y_ADD_STA to be a multiple
of a power of 2 depending on binning/scaling mode (2 for full pixel,
4 for x2-bin/scale, 8 for (x2-bin)+(x2-subsample) or x4-bin, or 16
for (x4-bin)+(x2-subsample)).
(Y_ADD_END – Y_ADD_STA + 1) also has to be a similar power of 2.

The current configuration for the full res modes breaks that second
requirement, and we can't increase Y_ADD_STA to 1 to retain exactly
the same field of view as that then breaks the first requirement.
For the binned modes, they are worse off as 3118 is not a multiple of
4.

Increase the main mode to 4208x3120 so that it is the same FOV as the
binned modes, with Y_ADD_STA at 0.
Fix Y_ADD_STA and Y_ADD_END for the binned modes so that they meet the
sensor requirements.

This does change the Bayer order as the default configuration is for
H&V flips to be enabled, so readout is from Y_STA_END to Y_ADD_STA,
and this patch has changed Y_STA_END.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Luis Garcia <git@luigi311.com>
---
 drivers/media/i2c/imx258.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index 2dbafd21dd70..4a7048d834c6 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -111,7 +111,7 @@ struct imx258_mode {
 	struct imx258_reg_list reg_list;
 };
 
-/* 4208x3118 needs 1267Mbps/lane, 4 lanes */
+/* 4208x3120 needs 1267Mbps/lane, 4 lanes */
 static const struct imx258_reg mipi_data_rate_1267mbps[] = {
 	{ 0x0301, 0x05 },
 	{ 0x0303, 0x02 },
@@ -148,7 +148,7 @@ static const struct imx258_reg mipi_data_rate_640mbps[] = {
 	{ 0x0823, 0x00 },
 };
 
-static const struct imx258_reg mode_4208x3118_regs[] = {
+static const struct imx258_reg mode_4208x3120_regs[] = {
 	{ 0x0136, 0x13 },
 	{ 0x0137, 0x33 },
 	{ 0x3051, 0x00 },
@@ -210,7 +210,7 @@ static const struct imx258_reg mode_4208x3118_regs[] = {
 	{ 0x0348, 0x10 },
 	{ 0x0349, 0x6F },
 	{ 0x034A, 0x0C },
-	{ 0x034B, 0x2E },
+	{ 0x034B, 0x2F },
 	{ 0x0381, 0x01 },
 	{ 0x0383, 0x01 },
 	{ 0x0385, 0x01 },
@@ -329,7 +329,7 @@ static const struct imx258_reg mode_2104_1560_regs[] = {
 	{ 0x0348, 0x10 },
 	{ 0x0349, 0x6F },
 	{ 0x034A, 0x0C },
-	{ 0x034B, 0x2E },
+	{ 0x034B, 0x2F },
 	{ 0x0381, 0x01 },
 	{ 0x0383, 0x01 },
 	{ 0x0385, 0x01 },
@@ -448,7 +448,7 @@ static const struct imx258_reg mode_1048_780_regs[] = {
 	{ 0x0348, 0x10 },
 	{ 0x0349, 0x6F },
 	{ 0x034A, 0x0C },
-	{ 0x034B, 0x2E },
+	{ 0x034B, 0x2F },
 	{ 0x0381, 0x01 },
 	{ 0x0383, 0x01 },
 	{ 0x0385, 0x01 },
@@ -562,12 +562,12 @@ static const struct imx258_link_freq_config link_freq_configs[] = {
 static const struct imx258_mode supported_modes[] = {
 	{
 		.width = 4208,
-		.height = 3118,
+		.height = 3120,
 		.vts_def = IMX258_VTS_30FPS,
 		.vts_min = IMX258_VTS_30FPS,
 		.reg_list = {
-			.num_of_regs = ARRAY_SIZE(mode_4208x3118_regs),
-			.regs = mode_4208x3118_regs,
+			.num_of_regs = ARRAY_SIZE(mode_4208x3120_regs),
+			.regs = mode_4208x3120_regs,
 		},
 		.link_freq_index = IMX258_LINK_FREQ_1267MBPS,
 	},
@@ -707,7 +707,7 @@ static int imx258_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 	/* Initialize try_fmt */
 	try_fmt->width = supported_modes[0].width;
 	try_fmt->height = supported_modes[0].height;
-	try_fmt->code = MEDIA_BUS_FMT_SGRBG10_1X10;
+	try_fmt->code = MEDIA_BUS_FMT_SBGGR10_1X10;
 	try_fmt->field = V4L2_FIELD_NONE;
 
 	return 0;
@@ -819,7 +819,7 @@ static int imx258_enum_mbus_code(struct v4l2_subdev *sd,
 	if (code->index > 0)
 		return -EINVAL;
 
-	code->code = MEDIA_BUS_FMT_SGRBG10_1X10;
+	code->code = MEDIA_BUS_FMT_SBGGR10_1X10;
 
 	return 0;
 }
@@ -831,7 +831,7 @@ static int imx258_enum_frame_size(struct v4l2_subdev *sd,
 	if (fse->index >= ARRAY_SIZE(supported_modes))
 		return -EINVAL;
 
-	if (fse->code != MEDIA_BUS_FMT_SGRBG10_1X10)
+	if (fse->code != MEDIA_BUS_FMT_SBGGR10_1X10)
 		return -EINVAL;
 
 	fse->min_width = supported_modes[fse->index].width;
@@ -847,7 +847,7 @@ static void imx258_update_pad_format(const struct imx258_mode *mode,
 {
 	fmt->format.width = mode->width;
 	fmt->format.height = mode->height;
-	fmt->format.code = MEDIA_BUS_FMT_SGRBG10_1X10;
+	fmt->format.code = MEDIA_BUS_FMT_SBGGR10_1X10;
 	fmt->format.field = V4L2_FIELD_NONE;
 }
 
@@ -894,7 +894,7 @@ static int imx258_set_pad_format(struct v4l2_subdev *sd,
 	mutex_lock(&imx258->mutex);
 
 	/* Only one raw bayer(GBRG) order is supported */
-	fmt->format.code = MEDIA_BUS_FMT_SGRBG10_1X10;
+	fmt->format.code = MEDIA_BUS_FMT_SBGGR10_1X10;
 
 	mode = v4l2_find_nearest_size(supported_modes,
 		ARRAY_SIZE(supported_modes), width, height,
-- 
2.42.0


