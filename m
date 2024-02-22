Return-Path: <linux-kernel+bounces-75979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 064D385F178
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61235B23B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84C91B277;
	Thu, 22 Feb 2024 06:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ5Ea6HR"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED208182BE;
	Thu, 22 Feb 2024 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708582962; cv=none; b=b8WKFNs9bJuTde3R62w8kzCKx3Jj2oB9xOXgNKRNQmEszsUl+JO3tosgWdd365vvfUitKR9nNAm7dbJn7NxX5JIZyrVi4GzCtnA8cbOKFcUg3B1zzAJQkTco0NlK1b98d290yZG1HedJP2FOb8Ja0h4bzKYFJm1zzD4LPzF7NPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708582962; c=relaxed/simple;
	bh=CiNzg6Yp843nKshqdagjyTnr1I83W2fCS43AP+wDXEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CF8JtBf379LDeNGugZ/uZD3XbU7ihqRCRAKl1wp/Mywc87jWUzmyiUhOdTLYy8gfAhTLCrBFWRrkMIlQs+K45eNwF+nV63U4wQLfKchj9atjf9ALXHqCDnwo2334nybu7jz8y5EkYphOUlC7NI42y8c9HPpXq9lB4kfRA28gRa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZ5Ea6HR; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512b3b04995so1518215e87.3;
        Wed, 21 Feb 2024 22:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708582959; x=1709187759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HAmPH36vkNVR/rLtY2ZH6iPhLV0i4g5sTx72BRLCdw=;
        b=XZ5Ea6HR6HWmn252b6QRJkZaNoQY39bzkzHZ9CC7r2/lslHz+6uSEUkvZkTPfAqEL6
         /sGPpzjyPRyfb3AlUe+0HIEZQ1O6/RNAg/T0B5eb/LaGC9O5gJjrdUun172ptFVrS+el
         gjZDxTaub8+I6VmdrujS//bwJ9a3F/LUATLG9mgV4tpur47/36MbhYdQUc5uKZj25HHX
         4f137iKsk61wAd3ROauqVM/TGXrPTSHD7g7EUDpxKkz516if5iBolQ5kShCf1tD3uEj5
         NvEUOuXmn+LyWLNAxAETtK/CzQWg6eqDBVeJ5qF1g2E+AUZph8scy5TU+TJYsNZvfojL
         2FtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708582959; x=1709187759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HAmPH36vkNVR/rLtY2ZH6iPhLV0i4g5sTx72BRLCdw=;
        b=olTiIhnn6JS3dy0uDrOlHfIjtD6knRFHMe46J4RweKbv7t/FGNcU4tv1yAZVYUuY8Q
         RBQ3owdbLmTeFFUuUlfzmclCcaRyig3kGw7G4m06fPFIc15VuoQOxUXKJh2z0dpnzW/v
         JWcE7zlvhWd7k8FXZFefCOlaDVVaVtDjbZSFwzADfwMRchkuGEf4Usm9Ipe/aPnLYOW+
         v4hsTen1uBvnQ4NcrkD12bA6XAgKvMwNzUcZDWUZmfIrTyYIbuddVGMpFslBDb1Xoc62
         bJT2ilhQwxa0bDgsl/93UA7mT3y2Kys7cYXFPQoqhvFM82qk6ul2ZMG4onzLBLu8BE3s
         7B9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWq7DKFqh+kw0O+OcE38Mv6yW+KqVPC/Lj5+8pcgOSSHmyta/ywUY9nG3jeK+XURgkW1TPbLrAcV8V8KpD9L81Jub5df6fLGrwfQgAL+5VU6MD2IsxLJLmV58pOvZ08Y3B0tB8qAPkj9QSfPt5V0WjnOhy4CHK5cDeGFYAW0+1v0vKToR8z
X-Gm-Message-State: AOJu0YzNF4VXbMRd+9pU2I7ut0TEgVGvQG4vBN5cQVhubbMIaGTQXaw0
	u1Ushsu61ykGyIngyAZfIuc9vZYCl5ykcASWt9wAGP5brf6EuB/y
X-Google-Smtp-Source: AGHT+IEIzJUy+FL39VrMly+Rvku/PPsPpA9tgGAxSDcth1+TTlF9djmled6DNDrdU9i23LTQuOYOmg==
X-Received: by 2002:ac2:4c4b:0:b0:512:bfb7:6d2c with SMTP id o11-20020ac24c4b000000b00512bfb76d2cmr5768401lfk.53.1708582958982;
        Wed, 21 Feb 2024 22:22:38 -0800 (PST)
Received: from localhost.localdomain ([2a05:3580:f312:6c02:29d4:49b1:c3dc:494c])
        by smtp.gmail.com with ESMTPSA id e8-20020a05651236c800b0051296788949sm1945574lfs.232.2024.02.21.22.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 22:22:37 -0800 (PST)
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
Subject: [PATCH v2 2/2] media: gc2145: implement basic dvp bus support
Date: Thu, 22 Feb 2024 09:22:14 +0300
Message-ID: <20240222062214.2627810-3-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222062214.2627810-1-andrej.skvortzov@gmail.com>
References: <20240222062214.2627810-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 drivers/media/i2c/gc2145.c | 122 +++++++++++++++++++++++++++++--------
 1 file changed, 96 insertions(+), 26 deletions(-)

diff --git a/drivers/media/i2c/gc2145.c b/drivers/media/i2c/gc2145.c
index bef7b0e056a8..2c5c9f3de5ff 100644
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
 
@@ -773,6 +784,38 @@ static int gc2145_set_pad_format(struct v4l2_subdev *sd,
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
@@ -895,10 +938,13 @@ static int gc2145_start_streaming(struct gc2145 *gc2145,
 		goto err_rpm_put;
 	}
 
-	/* Perform MIPI specific configuration */
-	ret = gc2145_config_mipi_mode(gc2145, gc2145_format);
+	/* Perform interface specific configuration */
+	if (gc2145->ep.bus_type == V4L2_MBUS_CSI2_DPHY)
+		ret = gc2145_config_mipi_mode(gc2145, gc2145_format);
+	else
+		ret = gc2145_config_dvp_mode(gc2145, gc2145_format);
 	if (ret) {
-		dev_err(&client->dev, "%s failed to write mipi conf\n",
+		dev_err(&client->dev, "%s failed to write interface conf\n",
 			__func__);
 		goto err_rpm_put;
 	}
@@ -924,6 +970,9 @@ static void gc2145_stop_streaming(struct gc2145 *gc2145)
 			GC2145_CSI2_MODE_EN | GC2145_CSI2_MODE_MIPI_EN, 0,
 			&ret);
 	cci_write(gc2145->regmap, GC2145_REG_PAGE_SELECT, 0x00, &ret);
+
+	/* Disable dvp streaming */
+	cci_write(gc2145->regmap, GC2145_REG_PAD_IO, 0x00, &ret);
 	if (ret)
 		dev_err(&client->dev, "%s failed to write regs\n", __func__);
 
@@ -1233,9 +1282,8 @@ static int gc2145_init_controls(struct gc2145 *gc2145)
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
@@ -1244,36 +1292,57 @@ static int gc2145_check_hwcfg(struct device *dev)
 		return -EINVAL;
 	}
 
-	ret = v4l2_fwnode_endpoint_alloc_parse(endpoint, &ep_cfg);
+
+	gc2145->ep.bus_type = V4L2_MBUS_CSI2_DPHY;
+	ret = v4l2_fwnode_endpoint_alloc_parse(endpoint, &gc2145->ep);
+	if (ret) {
+		gc2145->ep.bus_type = V4L2_MBUS_PARALLEL;
+		ret = v4l2_fwnode_endpoint_alloc_parse(endpoint, &gc2145->ep);
+	}
 	fwnode_handle_put(endpoint);
-	if (ret)
+	if (ret) {
+		dev_err(dev, "could not parse endpoint\n");
 		return ret;
-
-	/* Check the number of MIPI CSI2 data lanes */
-	if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2) {
-		dev_err(dev, "only 2 data lanes are currently supported\n");
-		ret = -EINVAL;
-		goto out;
 	}
 
-	/* Check the link frequency set in device tree */
-	if (!ep_cfg.nr_of_link_frequencies) {
-		dev_err(dev, "link-frequency property not found in DT\n");
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
+
+	case V4L2_MBUS_PARALLEL:
+		break;
+	default:
+		dev_err(dev, "unsupported bus type %u\n", gc2145->ep.bus_type);
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (ep_cfg.nr_of_link_frequencies != 3 ||
-	    ep_cfg.link_frequencies[0] != GC2145_640_480_LINKFREQ ||
-	    ep_cfg.link_frequencies[1] != GC2145_1280_720_LINKFREQ ||
-	    ep_cfg.link_frequencies[2] != GC2145_1600_1200_LINKFREQ) {
-		dev_err(dev, "Invalid link-frequencies provided\n");
-		ret = -EINVAL;
-	}
+	return 0;
 
 out:
-	v4l2_fwnode_endpoint_free(&ep_cfg);
-
+	v4l2_fwnode_endpoint_free(&gc2145->ep);
 	return ret;
 }
 
@@ -1421,6 +1490,7 @@ static void gc2145_remove(struct i2c_client *client)
 	if (!pm_runtime_status_suspended(&client->dev))
 		gc2145_power_off(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
+	v4l2_fwnode_endpoint_free(&gc2145->ep);
 }
 
 static const struct of_device_id gc2145_dt_ids[] = {
-- 
2.43.0


