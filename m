Return-Path: <linux-kernel+bounces-144374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911268A4520
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7BE1C20D51
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A9F136E00;
	Sun, 14 Apr 2024 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="kQArnOD6"
Received: from mail-108-mta124.mxroute.com (mail-108-mta124.mxroute.com [136.175.108.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB187135A59
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713126972; cv=none; b=ioJDk4ozjv4/Nd/73497O5dD1jNxN4pOcEcidtkDS0uYvc5UFa6LeiD21tlsK+oqDEj5aRL60sS8jYdRoQQi5hgTIPlJuLB1WIHHR1FxcdGnFgyFRQpwqpxZ3ndjy77hlsd0XbsPQBVMelESMIJTBNdIvdx5AlYVChp64oregAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713126972; c=relaxed/simple;
	bh=1Al2X4/Z9BOhfBe2tjhwOtcJteP1g/8Kssi8PBv9Dtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9G2hivAZzzF7PZOLCCBJPijMU12uRTABsRVSqyuwwLyW/EO4/xlLIBtwwpxegZsTRAjUKyi65iSGxG0Qs6oLKD+b/2S+omehMcZ+e5hxfNwjC07MIIzS7q/vMUIZqpgIMvQFRt+tfev4AYRChInW8ur9b8zxY6I9HMUon3NgHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=kQArnOD6; arc=none smtp.client-ip=136.175.108.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta124.mxroute.com (ZoneMTA) with ESMTPSA id 18ede5267560003bea.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 14 Apr 2024 20:35:26 +0000
X-Zone-Loop: 1ee80a96c5aa6ec78b497d81807a546b97d76903245f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JIvVqv/364uB2mrny4F+hSowPVF47wy89VevZ9gPo+A=; b=kQArnOD6wCpjhUXrDF2QzFsCZT
	G5R/sn5W3ccAXG6UvKNVMdn9BndQ0j9Xuog1yUXTxLSokyqDO8VJ5yFxf0QL7/nHSmzRtarauhMcx
	mwleDI7dglAGfFEvVFH+hh3879YdItyq69P0BLd3ul4ZDgGNeBe6Cmvg4Up9lAdknXTpqctZS/kpw
	rmrVCyl/jv6/3z1YU/CNpAIk22V30P3a41gnJS1DpcMNTyyjjJYzA7y69hYKs0ilg90zJS2taDvCb
	9+X9wKh4jQqG5SGKcRpfoCGFIlzFdyyE+OqFp7+QNeTXAxZpjCKJxEtRYwBgWbEKaDp0maODF2eJC
	UFQAlf3g==;
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
Subject: [PATCH v4 07/25] media: i2c: imx258: Split out common registers from the mode based ones
Date: Sun, 14 Apr 2024 14:34:45 -0600
Message-ID: <20240414203503.18402-8-git@luigi311.com>
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

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

Out of all the registers that are defined for each mode, only around
10 differ between the modes.

Split the table into common and mode specific ones.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Luis Garcia <git@luigi311.com>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/media/i2c/imx258.c | 236 ++++---------------------------------
 1 file changed, 21 insertions(+), 215 deletions(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index 321b504c6a48..351add1bc5d5 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -151,7 +151,7 @@ static const struct imx258_reg mipi_data_rate_640mbps[] = {
 	{ 0x0823, 0x00 },
 };
 
-static const struct imx258_reg mode_4208x3120_regs[] = {
+static const struct imx258_reg mode_common_regs[] = {
 	{ 0x0136, 0x13 },
 	{ 0x0137, 0x33 },
 	{ 0x3051, 0x00 },
@@ -216,27 +216,17 @@ static const struct imx258_reg mode_4208x3120_regs[] = {
 	{ 0x0383, 0x01 },
 	{ 0x0385, 0x01 },
 	{ 0x0387, 0x01 },
-	{ 0x0900, 0x00 },
-	{ 0x0901, 0x11 },
-	{ 0x0401, 0x00 },
 	{ 0x0404, 0x00 },
-	{ 0x0405, 0x10 },
 	{ 0x0408, 0x00 },
 	{ 0x0409, 0x00 },
 	{ 0x040A, 0x00 },
 	{ 0x040B, 0x00 },
 	{ 0x040C, 0x10 },
 	{ 0x040D, 0x70 },
-	{ 0x040E, 0x0C },
-	{ 0x040F, 0x30 },
 	{ 0x3038, 0x00 },
 	{ 0x303A, 0x00 },
 	{ 0x303B, 0x10 },
 	{ 0x300D, 0x00 },
-	{ 0x034C, 0x10 },
-	{ 0x034D, 0x70 },
-	{ 0x034E, 0x0C },
-	{ 0x034F, 0x30 },
 	{ 0x0350, 0x01 },
 	{ 0x0204, 0x00 },
 	{ 0x0205, 0x00 },
@@ -266,234 +256,43 @@ static const struct imx258_reg mode_4208x3120_regs[] = {
 	{ 0x0220, 0x00 },
 };
 
+static const struct imx258_reg mode_4208x3120_regs[] = {
+	{ 0x0900, 0x00 },
+	{ 0x0901, 0x11 },
+	{ 0x0401, 0x00 },
+	{ 0x0405, 0x10 },
+	{ 0x040E, 0x0C },
+	{ 0x040F, 0x30 },
+	{ 0x034C, 0x10 },
+	{ 0x034D, 0x70 },
+	{ 0x034E, 0x0C },
+	{ 0x034F, 0x30 },
+};
+
 static const struct imx258_reg mode_2104_1560_regs[] = {
-	{ 0x0136, 0x13 },
-	{ 0x0137, 0x33 },
-	{ 0x3051, 0x00 },
-	{ 0x3052, 0x00 },
-	{ 0x4E21, 0x14 },
-	{ 0x6B11, 0xCF },
-	{ 0x7FF0, 0x08 },
-	{ 0x7FF1, 0x0F },
-	{ 0x7FF2, 0x08 },
-	{ 0x7FF3, 0x1B },
-	{ 0x7FF4, 0x23 },
-	{ 0x7FF5, 0x60 },
-	{ 0x7FF6, 0x00 },
-	{ 0x7FF7, 0x01 },
-	{ 0x7FF8, 0x00 },
-	{ 0x7FF9, 0x78 },
-	{ 0x7FFA, 0x00 },
-	{ 0x7FFB, 0x00 },
-	{ 0x7FFC, 0x00 },
-	{ 0x7FFD, 0x00 },
-	{ 0x7FFE, 0x00 },
-	{ 0x7FFF, 0x03 },
-	{ 0x7F76, 0x03 },
-	{ 0x7F77, 0xFE },
-	{ 0x7FA8, 0x03 },
-	{ 0x7FA9, 0xFE },
-	{ 0x7B24, 0x81 },
-	{ 0x7B25, 0x00 },
-	{ 0x6564, 0x07 },
-	{ 0x6B0D, 0x41 },
-	{ 0x653D, 0x04 },
-	{ 0x6B05, 0x8C },
-	{ 0x6B06, 0xF9 },
-	{ 0x6B08, 0x65 },
-	{ 0x6B09, 0xFC },
-	{ 0x6B0A, 0xCF },
-	{ 0x6B0B, 0xD2 },
-	{ 0x6700, 0x0E },
-	{ 0x6707, 0x0E },
-	{ 0x9104, 0x00 },
-	{ 0x4648, 0x7F },
-	{ 0x7420, 0x00 },
-	{ 0x7421, 0x1C },
-	{ 0x7422, 0x00 },
-	{ 0x7423, 0xD7 },
-	{ 0x5F04, 0x00 },
-	{ 0x5F05, 0xED },
-	{ 0x0112, 0x0A },
-	{ 0x0113, 0x0A },
-	{ 0x0114, 0x03 },
-	{ 0x0342, 0x14 },
-	{ 0x0343, 0xE8 },
-	{ 0x0344, 0x00 },
-	{ 0x0345, 0x00 },
-	{ 0x0346, 0x00 },
-	{ 0x0347, 0x00 },
-	{ 0x0348, 0x10 },
-	{ 0x0349, 0x6F },
-	{ 0x034A, 0x0C },
-	{ 0x034B, 0x2F },
-	{ 0x0381, 0x01 },
-	{ 0x0383, 0x01 },
-	{ 0x0385, 0x01 },
-	{ 0x0387, 0x01 },
 	{ 0x0900, 0x01 },
 	{ 0x0901, 0x12 },
 	{ 0x0401, 0x01 },
-	{ 0x0404, 0x00 },
 	{ 0x0405, 0x20 },
-	{ 0x0408, 0x00 },
-	{ 0x0409, 0x00 },
-	{ 0x040A, 0x00 },
-	{ 0x040B, 0x00 },
-	{ 0x040C, 0x10 },
-	{ 0x040D, 0x70 },
 	{ 0x040E, 0x06 },
 	{ 0x040F, 0x18 },
-	{ 0x3038, 0x00 },
-	{ 0x303A, 0x00 },
-	{ 0x303B, 0x10 },
-	{ 0x300D, 0x00 },
 	{ 0x034C, 0x08 },
 	{ 0x034D, 0x38 },
 	{ 0x034E, 0x06 },
 	{ 0x034F, 0x18 },
-	{ 0x0350, 0x01 },
-	{ 0x0204, 0x00 },
-	{ 0x0205, 0x00 },
-	{ 0x020E, 0x01 },
-	{ 0x020F, 0x00 },
-	{ 0x0210, 0x01 },
-	{ 0x0211, 0x00 },
-	{ 0x0212, 0x01 },
-	{ 0x0213, 0x00 },
-	{ 0x0214, 0x01 },
-	{ 0x0215, 0x00 },
-	{ 0x7BCD, 0x01 },
-	{ 0x94DC, 0x20 },
-	{ 0x94DD, 0x20 },
-	{ 0x94DE, 0x20 },
-	{ 0x95DC, 0x20 },
-	{ 0x95DD, 0x20 },
-	{ 0x95DE, 0x20 },
-	{ 0x7FB0, 0x00 },
-	{ 0x9010, 0x3E },
-	{ 0x9419, 0x50 },
-	{ 0x941B, 0x50 },
-	{ 0x9519, 0x50 },
-	{ 0x951B, 0x50 },
-	{ 0x3030, 0x00 },
-	{ 0x3032, 0x00 },
-	{ 0x0220, 0x00 },
 };
 
 static const struct imx258_reg mode_1048_780_regs[] = {
-	{ 0x0136, 0x13 },
-	{ 0x0137, 0x33 },
-	{ 0x3051, 0x00 },
-	{ 0x3052, 0x00 },
-	{ 0x4E21, 0x14 },
-	{ 0x6B11, 0xCF },
-	{ 0x7FF0, 0x08 },
-	{ 0x7FF1, 0x0F },
-	{ 0x7FF2, 0x08 },
-	{ 0x7FF3, 0x1B },
-	{ 0x7FF4, 0x23 },
-	{ 0x7FF5, 0x60 },
-	{ 0x7FF6, 0x00 },
-	{ 0x7FF7, 0x01 },
-	{ 0x7FF8, 0x00 },
-	{ 0x7FF9, 0x78 },
-	{ 0x7FFA, 0x00 },
-	{ 0x7FFB, 0x00 },
-	{ 0x7FFC, 0x00 },
-	{ 0x7FFD, 0x00 },
-	{ 0x7FFE, 0x00 },
-	{ 0x7FFF, 0x03 },
-	{ 0x7F76, 0x03 },
-	{ 0x7F77, 0xFE },
-	{ 0x7FA8, 0x03 },
-	{ 0x7FA9, 0xFE },
-	{ 0x7B24, 0x81 },
-	{ 0x7B25, 0x00 },
-	{ 0x6564, 0x07 },
-	{ 0x6B0D, 0x41 },
-	{ 0x653D, 0x04 },
-	{ 0x6B05, 0x8C },
-	{ 0x6B06, 0xF9 },
-	{ 0x6B08, 0x65 },
-	{ 0x6B09, 0xFC },
-	{ 0x6B0A, 0xCF },
-	{ 0x6B0B, 0xD2 },
-	{ 0x6700, 0x0E },
-	{ 0x6707, 0x0E },
-	{ 0x9104, 0x00 },
-	{ 0x4648, 0x7F },
-	{ 0x7420, 0x00 },
-	{ 0x7421, 0x1C },
-	{ 0x7422, 0x00 },
-	{ 0x7423, 0xD7 },
-	{ 0x5F04, 0x00 },
-	{ 0x5F05, 0xED },
-	{ 0x0112, 0x0A },
-	{ 0x0113, 0x0A },
-	{ 0x0114, 0x03 },
-	{ 0x0342, 0x14 },
-	{ 0x0343, 0xE8 },
-	{ 0x0344, 0x00 },
-	{ 0x0345, 0x00 },
-	{ 0x0346, 0x00 },
-	{ 0x0347, 0x00 },
-	{ 0x0348, 0x10 },
-	{ 0x0349, 0x6F },
-	{ 0x034A, 0x0C },
-	{ 0x034B, 0x2F },
-	{ 0x0381, 0x01 },
-	{ 0x0383, 0x01 },
-	{ 0x0385, 0x01 },
-	{ 0x0387, 0x01 },
 	{ 0x0900, 0x01 },
 	{ 0x0901, 0x14 },
 	{ 0x0401, 0x01 },
-	{ 0x0404, 0x00 },
 	{ 0x0405, 0x40 },
-	{ 0x0408, 0x00 },
-	{ 0x0409, 0x00 },
-	{ 0x040A, 0x00 },
-	{ 0x040B, 0x00 },
-	{ 0x040C, 0x10 },
-	{ 0x040D, 0x70 },
 	{ 0x040E, 0x03 },
 	{ 0x040F, 0x0C },
-	{ 0x3038, 0x00 },
-	{ 0x303A, 0x00 },
-	{ 0x303B, 0x10 },
-	{ 0x300D, 0x00 },
 	{ 0x034C, 0x04 },
 	{ 0x034D, 0x18 },
 	{ 0x034E, 0x03 },
 	{ 0x034F, 0x0C },
-	{ 0x0350, 0x01 },
-	{ 0x0204, 0x00 },
-	{ 0x0205, 0x00 },
-	{ 0x020E, 0x01 },
-	{ 0x020F, 0x00 },
-	{ 0x0210, 0x01 },
-	{ 0x0211, 0x00 },
-	{ 0x0212, 0x01 },
-	{ 0x0213, 0x00 },
-	{ 0x0214, 0x01 },
-	{ 0x0215, 0x00 },
-	{ 0x7BCD, 0x00 },
-	{ 0x94DC, 0x20 },
-	{ 0x94DD, 0x20 },
-	{ 0x94DE, 0x20 },
-	{ 0x95DC, 0x20 },
-	{ 0x95DD, 0x20 },
-	{ 0x95DE, 0x20 },
-	{ 0x7FB0, 0x00 },
-	{ 0x9010, 0x3E },
-	{ 0x9419, 0x50 },
-	{ 0x941B, 0x50 },
-	{ 0x9519, 0x50 },
-	{ 0x951B, 0x50 },
-	{ 0x3030, 0x00 },
-	{ 0x3032, 0x00 },
-	{ 0x0220, 0x00 },
 };
 
 static const char * const imx258_test_pattern_menu[] = {
@@ -955,6 +754,13 @@ static int imx258_start_streaming(struct imx258 *imx258)
 		return ret;
 	}
 
+	ret = imx258_write_regs(imx258, mode_common_regs,
+				ARRAY_SIZE(mode_common_regs));
+	if (ret) {
+		dev_err(&client->dev, "%s failed to set common regs\n", __func__);
+		return ret;
+	}
+
 	/* Apply default values of current mode */
 	reg_list = &imx258->cur_mode->reg_list;
 	ret = imx258_write_regs(imx258, reg_list->regs, reg_list->num_of_regs);
-- 
2.44.0


