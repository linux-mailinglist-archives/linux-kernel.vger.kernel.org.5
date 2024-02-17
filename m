Return-Path: <linux-kernel+bounces-70104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AB685931D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 23:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2FF4B21281
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C77880636;
	Sat, 17 Feb 2024 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8F7nG4p"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4874180619;
	Sat, 17 Feb 2024 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708207431; cv=none; b=inNEmacYaxZsyHCt7wgyWROPTbUJvrX5NwgU53sw+tmB1xpvRRYbavRFF8iMJI3gaqlKXSXeJ0GRYz1+vW1lf46WHNb6N2Xkeuzenw4SLxvMca4vBR1MoYNhnt1ZZO/+T7F05vJ7U3gx8GS+2d2E8rbPqNOS0fWBJ/+zJVXk7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708207431; c=relaxed/simple;
	bh=bJMbBwrT+WhkUJ3j7dNm7o0p5T2uQRQJ2CSbo+C+NWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwN08UwrDDTTQRAIvCOIshElefS/BwqlQB+14sD8qyGUhQI3/7y6BNjeD/SoPrFRG14xPQl0xRdppgv70B4UZvdnYnGJjEK7QNwe081+tOxJ62BEQ+kAGrvtxp8F0BWERz620dMQGdI7TPhaUCU531FHYDF2Ghs65K3MiOj4X+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8F7nG4p; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso20164941fa.2;
        Sat, 17 Feb 2024 14:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708207427; x=1708812227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aApdOnqEiLTFDlM0DEkECZ6pJ/nXDPDXWmDBeJDbWs=;
        b=X8F7nG4pAN6O1sdFAKgH+AaZZro9wdWTQpRnyj8smMzFfTgM9bJtV2GVNrk1y6cI/Y
         CB3AINfNPrmYkgUI4dH6bBWKePFxhJnxGMkTHb4rGrb91meFJDdjk2io7+1GCHQ6hyKx
         61BVg325hswiopee78kCrUmxYfkGJMXkduZ0BXcVZDzaK58izk6hoq1p08iiQorTJUh7
         /jTEg72C8cQtsSC6EbApQOsGXUxzjHe+ch5v6Zaf6pDftcH35Guloj+Pxbe9YIsK6RV2
         uEqm/QWdFPGMignw1fLezn9AT2YckGvrs8iY43lcQazEmTu2Vpst5aOZHcU2fUo5qlIv
         wsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708207427; x=1708812227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aApdOnqEiLTFDlM0DEkECZ6pJ/nXDPDXWmDBeJDbWs=;
        b=sMBm9hBXc1R9+3/b51ECe6nDk01mXjy9P78gz+F/IHNRhTETbSApoeW3we1cMwSdqI
         c/VBR7mJOlvVHePrdkDZP9QvD2CNMtF5oh+fQzEg4RzC39C49pBB21hMU7XoZW1rAb0l
         n15Apltil49JHMLqYYe92LoBBft/K93kco2+fzfbMB02yjG0FpRPUyowY7vbv/8CiHm9
         6YPDRRk++WN8qxKikxbhB6ouCJ6l/SonODhz4F8IFwwhjfDsPOzIk18eEnqqiwCktqO9
         qLqZoEAkdbXbw+1GJivdB8SVrPicViCwf3bmtJ01rDMQv/lBN+AiovjYCjomHngvvarL
         /i9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI0D8sRW6AuV0kh+Tm+44bfNrydMumBI+caOXzi+9SwIqUBAjmpEpFsPvFnLKGAYLhp6OhQ27lSP9384b1shtDFXbG2otybZGsiKwVOWI8sHnybckKakPJu2x4YDZCqWdHbv3BYpiEKYviBjObNyz9UTz3SZkrnOqkExqkZkthAWdtxpVW
X-Gm-Message-State: AOJu0YyQ0X0HVPbelpc/pkR2h6gIruaRgQWDOFlxRnRE4V6mbN+QEeMh
	acdNO3N3OZb2umuWfLJzNzb7nW/x3yMD7VKQ5q+Ahpv5cIsJf5u1
X-Google-Smtp-Source: AGHT+IHCMtS6+6PY3+RlRsAimgdxCMlkqh+ql4ZMQZgYBOGjXLhDbbfZ95KmDdtHrQy8+heZyfcoQg==
X-Received: by 2002:a05:6512:3450:b0:512:9dee:44fe with SMTP id j16-20020a056512345000b005129dee44femr1911524lfr.26.1708207426996;
        Sat, 17 Feb 2024 14:03:46 -0800 (PST)
Received: from localhost.localdomain ([2a05:3580:f312:6c01:1b8f:2a1b:d18:1951])
        by smtp.gmail.com with ESMTPSA id p19-20020a056512313300b00511936e2d61sm363836lfd.56.2024.02.17.14.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 14:03:46 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH 2/2] media: gc2145: implement basic dvp bus support
Date: Sun, 18 Feb 2024 01:03:08 +0300
Message-ID: <20240217220308.594883-3-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217220308.594883-1-andrej.skvortzov@gmail.com>
References: <20240217220308.594883-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested on PinePhone with libcamera-based GNOME screenshot.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 drivers/media/i2c/gc2145.c | 117 ++++++++++++++++++++++++++++---------
 1 file changed, 90 insertions(+), 27 deletions(-)

diff --git a/drivers/media/i2c/gc2145.c b/drivers/media/i2c/gc2145.c
index bef7b0e056a8..9a70b8d504e1 100644
--- a/drivers/media/i2c/gc2145.c
+++ b/drivers/media/i2c/gc2145.c
@@ -39,6 +39,10 @@
 #define GC2145_REG_ANALOG_MODE1	CCI_REG8(0x17)
 #define GC2145_REG_OUTPUT_FMT	CCI_REG8(0x84)
 #define GC2145_REG_SYNC_MODE	CCI_REG8(0x86)
+#define GC2145_SYNC_MODE_VSYNC_POL	BIT(0)
+#define GC2145_SYNC_MODE_HSYNC_POL	BIT(1)
+#define GC2145_SYNC_MODE_OPCLK_POL	BIT(2)
+#define GC2145_SYNC_MODE_OPCLK_GATE	BIT(3)
 #define GC2145_SYNC_MODE_COL_SWITCH	BIT(4)
 #define GC2145_SYNC_MODE_ROW_SWITCH	BIT(5)
 #define GC2145_REG_BYPASS_MODE	CCI_REG8(0x89)
@@ -53,6 +57,12 @@
 #define GC2145_REG_GLOBAL_GAIN	CCI_REG8(0xb0)
 #define GC2145_REG_CHIP_ID	CCI_REG16(0xf0)
 #define GC2145_REG_PAD_IO	CCI_REG8(0xf2)
+#define GC2145_REG_PLL_MODE1	CCI_REG8(0xf7)
+#define GC2145_REG_PLL_MODE2	CCI_REG8(0xf8)
+#define GC2145_REG_CM_MODE	CCI_REG8(0xf9)
+#define GC2145_REG_CLK_DIV_MODE	CCI_REG8(0xfa)
+#define GC2145_REG_ANALOG_PWC	CCI_REG8(0xfc)
+#define GC2145_REG_PAD_IO	CCI_REG8(0xf2)
 #define GC2145_REG_PAGE_SELECT	CCI_REG8(0xfe)
 /* Page 3 */
 #define GC2145_REG_DPHY_ANALOG_MODE1	CCI_REG8(0x01)
@@ -598,6 +608,7 @@ struct gc2145 {
 	struct v4l2_subdev sd;
 	struct media_pad pad;
 
+	struct v4l2_fwnode_endpoint ep; /* the parsed DT endpoint info */
 	struct regmap *regmap;
 	struct clk *xclk;
 
@@ -612,6 +623,11 @@ struct gc2145 {
 	const struct gc2145_mode *mode;
 };
 
+static inline bool gc2145_is_csi2(const struct gc2145 *gc2145)
+{
+	return gc2145->ep.bus_type == V4L2_MBUS_CSI2_DPHY;
+}
+
 static inline struct gc2145 *to_gc2145(struct v4l2_subdev *_sd)
 {
 	return container_of(_sd, struct gc2145, sd);
@@ -773,6 +789,38 @@ static int gc2145_set_pad_format(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static int gc2145_config_dvp_mode(struct gc2145 *gc2145,
+				   const struct gc2145_format *gc2145_format)
+{
+	int ret = 0;
+	u64 sync_mode;
+	int flags;
+
+	flags = gc2145->ep.bus.parallel.flags;
+
+	ret = cci_read(gc2145->regmap, GC2145_REG_SYNC_MODE, &sync_mode, NULL);
+	if (ret)
+		return ret;
+
+	sync_mode &= ~(GC2145_SYNC_MODE_VSYNC_POL |
+		       GC2145_SYNC_MODE_HSYNC_POL |
+		       GC2145_SYNC_MODE_OPCLK_POL);
+
+	if (flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
+		sync_mode |= GC2145_SYNC_MODE_VSYNC_POL;
+
+	if (flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)
+		sync_mode |= GC2145_SYNC_MODE_HSYNC_POL;
+
+	if (flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
+		sync_mode |= GC2145_SYNC_MODE_OPCLK_POL;
+
+	cci_write(gc2145->regmap, GC2145_REG_SYNC_MODE, sync_mode, &ret);
+	cci_write(gc2145->regmap, GC2145_REG_PAD_IO, 0x0f, &ret);
+
+	return ret;
+}
+
 static const struct cci_reg_sequence gc2145_common_mipi_regs[] = {
 	{GC2145_REG_PAGE_SELECT, 0x03},
 	{GC2145_REG_DPHY_ANALOG_MODE1, GC2145_DPHY_MODE_PHY_CLK_EN |
@@ -895,10 +943,13 @@ static int gc2145_start_streaming(struct gc2145 *gc2145,
 		goto err_rpm_put;
 	}
 
-	/* Perform MIPI specific configuration */
-	ret = gc2145_config_mipi_mode(gc2145, gc2145_format);
+	/* Perform interface specific configuration */
+	if (gc2145_is_csi2(gc2145))
+		ret = gc2145_config_mipi_mode(gc2145, gc2145_format);
+	else
+		ret = gc2145_config_dvp_mode(gc2145, gc2145_format);
 	if (ret) {
-		dev_err(&client->dev, "%s failed to write mipi conf\n",
+		dev_err(&client->dev, "%s failed to write interface conf\n",
 			__func__);
 		goto err_rpm_put;
 	}
@@ -924,6 +975,9 @@ static void gc2145_stop_streaming(struct gc2145 *gc2145)
 			GC2145_CSI2_MODE_EN | GC2145_CSI2_MODE_MIPI_EN, 0,
 			&ret);
 	cci_write(gc2145->regmap, GC2145_REG_PAGE_SELECT, 0x00, &ret);
+
+	/* Disable dvp streaming */
+	cci_write(gc2145->regmap, GC2145_REG_PAD_IO, 0x00, &ret);
 	if (ret)
 		dev_err(&client->dev, "%s failed to write regs\n", __func__);
 
@@ -1233,9 +1287,8 @@ static int gc2145_init_controls(struct gc2145 *gc2145)
 static int gc2145_check_hwcfg(struct device *dev)
 {
 	struct fwnode_handle *endpoint;
-	struct v4l2_fwnode_endpoint ep_cfg = {
-		.bus_type = V4L2_MBUS_CSI2_DPHY
-	};
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct gc2145 *gc2145 = to_gc2145(sd);
 	int ret;
 
 	endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
@@ -1244,36 +1297,46 @@ static int gc2145_check_hwcfg(struct device *dev)
 		return -EINVAL;
 	}
 
-	ret = v4l2_fwnode_endpoint_alloc_parse(endpoint, &ep_cfg);
+	ret = v4l2_fwnode_endpoint_parse(endpoint, &gc2145->ep);
 	fwnode_handle_put(endpoint);
 	if (ret)
 		return ret;
 
-	/* Check the number of MIPI CSI2 data lanes */
-	if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2) {
-		dev_err(dev, "only 2 data lanes are currently supported\n");
-		ret = -EINVAL;
-		goto out;
-	}
+	switch (gc2145->ep.bus_type) {
+	case V4L2_MBUS_CSI2_DPHY:
+		/* Check the link frequency set in device tree */
+		if (!gc2145->ep.nr_of_link_frequencies) {
+			dev_err(dev, "link-frequencies property not found in DT\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/* Check the number of MIPI CSI2 data lanes */
+		if (gc2145->ep.bus.mipi_csi2.num_data_lanes != 2) {
+			dev_err(dev, "only 2 data lanes are currently supported\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (gc2145->ep.nr_of_link_frequencies != 3 ||
+			gc2145->ep.link_frequencies[0] != GC2145_640_480_LINKFREQ ||
+			gc2145->ep.link_frequencies[1] != GC2145_1280_720_LINKFREQ ||
+			gc2145->ep.link_frequencies[2] != GC2145_1600_1200_LINKFREQ) {
+			dev_err(dev, "Invalid link-frequencies provided\n");
+			ret = -EINVAL;
+			goto out;
+		}
+		break;
 
-	/* Check the link frequency set in device tree */
-	if (!ep_cfg.nr_of_link_frequencies) {
-		dev_err(dev, "link-frequency property not found in DT\n");
+	case V4L2_MBUS_PARALLEL:
+		break;
+	default:
+		dev_err(dev, "unsupported bus type %u\n",
+			gc2145->ep.bus_type);
 		ret = -EINVAL;
 		goto out;
 	}
-
-	if (ep_cfg.nr_of_link_frequencies != 3 ||
-	    ep_cfg.link_frequencies[0] != GC2145_640_480_LINKFREQ ||
-	    ep_cfg.link_frequencies[1] != GC2145_1280_720_LINKFREQ ||
-	    ep_cfg.link_frequencies[2] != GC2145_1600_1200_LINKFREQ) {
-		dev_err(dev, "Invalid link-frequencies provided\n");
-		ret = -EINVAL;
-	}
-
 out:
-	v4l2_fwnode_endpoint_free(&ep_cfg);
-
 	return ret;
 }
 
-- 
2.43.0


