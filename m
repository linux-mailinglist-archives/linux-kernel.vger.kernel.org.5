Return-Path: <linux-kernel+bounces-122149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6C988F2B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C032936AE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36906154C07;
	Wed, 27 Mar 2024 23:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="NTkh79fo"
Received: from mail-108-mta60.mxroute.com (mail-108-mta60.mxroute.com [136.175.108.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFAE154444
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581486; cv=none; b=XKpWkS6ibBH47ZBaggA/0lFTf1xYfxCmBoEFN9QJuO//RIOhy7v61yrDoNGbPRP/nMTuZNNtUhyx5zyYamq49yjX7ht6PM7qDzTQNecUVfzj+CG/q/9j4zUQ06HX7DBA9T29adMmQUO9W624KljcuxCgaBy6BrnOSjAUcH9ym8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581486; c=relaxed/simple;
	bh=NA4X1r1+uHBdhIRfrPTtAP2uPVsX5ISROQaTF9/cHho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSYxkYUhN9X/LCwGAsA3V7nPA2TyWiaS137YZmrcaCqMCfSj3swhgyX4dEd9NMFolhlKRxV8iJLLQ1UNYAAPpSCitlUPfDTb1Y947i1vpo3Rr7y6m/LL4NtyapegOj3AaC/T7qmRxeDrm2wAn6OhT7bPeul5iYVTzHrLsBszfQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=NTkh79fo; arc=none smtp.client-ip=136.175.108.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta60.mxroute.com (ZoneMTA) with ESMTPSA id 18e823465720003bea.00f
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 27 Mar 2024 23:17:35 +0000
X-Zone-Loop: 9d85f27764df038cc6349a67a69d0e4600b78c24246e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JSVvy6qYqNREABJ9B24Hgd/994IGZ+daMOMn7F0GMDk=; b=NTkh79fo6/bKHCu4GpZvLp3Hpe
	l9frUrwgAnwuinubKx3obETrKYZuz5JOfYji2sCkcXt7caK77m6UKA4dzXyZnfdcUqWJBmkcrSTyJ
	mLZbBcjaroD7UlGhpX5qeyrxml/Jtf05Q5R94alc/aeWFJtQR0K8/A1GR9NiIkZtht5uGYYuh+sld
	NUUlRbjIL/+oAiGjzVxA/ww5TK0H2mzRtt9anHbzNQCo/yL9paQzYFAAOWolpJ4as/HqtCYxJed0d
	k6Vd9fUXEnZM8ltjqAklK6ePqI8TA8m+VYYtOMA3hAIy97JQlLuU6Lluo3GLyaeR2/yE+RwQAfeqy
	+HKQZmuw==;
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
Subject: [PATCH 09/23] media: i2c: imx258: Add support for running on 2 CSI data lanes
Date: Wed, 27 Mar 2024 17:16:55 -0600
Message-ID: <20240327231710.53188-10-git@luigi311.com>
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

Extends the driver to also support 2 data lanes.
Frame rates are obviously more restricted on 2 lanes, but some
hardware simply hasn't wired more up.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Luigi311 <git@luigi311.com>
---
 drivers/media/i2c/imx258.c | 214 ++++++++++++++++++++++++++++++++-----
 1 file changed, 190 insertions(+), 24 deletions(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index 6ee7de079454..c65b9aad3b0a 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -86,12 +86,18 @@ struct imx258_reg_list {
 	const struct imx258_reg *regs;
 };
 
+enum {
+	IMX258_2_LANE_MODE,
+	IMX258_4_LANE_MODE,
+	IMX258_LANE_CONFIGS,
+};
+
 /* Link frequency config */
 struct imx258_link_freq_config {
 	u32 pixels_per_line;
 
 	/* PLL registers for this link frequency */
-	struct imx258_reg_list reg_list;
+	struct imx258_reg_list reg_list[IMX258_LANE_CONFIGS];
 };
 
 /* Mode : resolution and related config&values */
@@ -111,8 +117,34 @@ struct imx258_mode {
 	struct imx258_reg_list reg_list;
 };
 
-/* 4208x3120 needs 1267Mbps/lane, 4 lanes */
-static const struct imx258_reg mipi_1267mbps_19_2mhz[] = {
+/*
+ * 4208x3120 @ 30 fps needs 1267Mbps/lane, 4 lanes.
+ * To avoid further computation of clock settings, adopt the same per
+ * lane data rate when using 2 lanes, thus allowing a maximum of 15fps.
+ */
+static const struct imx258_reg mipi_1267mbps_19_2mhz_2l[] = {
+	{ 0x0136, 0x13 },
+	{ 0x0137, 0x33 },
+	{ 0x0301, 0x0A },
+	{ 0x0303, 0x02 },
+	{ 0x0305, 0x03 },
+	{ 0x0306, 0x00 },
+	{ 0x0307, 0xC6 },
+	{ 0x0309, 0x0A },
+	{ 0x030B, 0x01 },
+	{ 0x030D, 0x02 },
+	{ 0x030E, 0x00 },
+	{ 0x030F, 0xD8 },
+	{ 0x0310, 0x00 },
+
+	{ 0x0114, 0x01 },
+	{ 0x0820, 0x09 },
+	{ 0x0821, 0xa6 },
+	{ 0x0822, 0x66 },
+	{ 0x0823, 0x66 },
+};
+
+static const struct imx258_reg mipi_1267mbps_19_2mhz_4l[] = {
 	{ 0x0136, 0x13 },
 	{ 0x0137, 0x33 },
 	{ 0x0301, 0x05 },
@@ -126,16 +158,18 @@ static const struct imx258_reg mipi_1267mbps_19_2mhz[] = {
 	{ 0x030E, 0x00 },
 	{ 0x030F, 0xD8 },
 	{ 0x0310, 0x00 },
+
+	{ 0x0114, 0x03 },
 	{ 0x0820, 0x13 },
 	{ 0x0821, 0x4C },
 	{ 0x0822, 0xCC },
 	{ 0x0823, 0xCC },
 };
 
-static const struct imx258_reg mipi_1272mbps_24mhz[] = {
+static const struct imx258_reg mipi_1272mbps_24mhz_2l[] = {
 	{ 0x0136, 0x18 },
 	{ 0x0137, 0x00 },
-	{ 0x0301, 0x05 },
+	{ 0x0301, 0x0a },
 	{ 0x0303, 0x02 },
 	{ 0x0305, 0x04 },
 	{ 0x0306, 0x00 },
@@ -146,13 +180,59 @@ static const struct imx258_reg mipi_1272mbps_24mhz[] = {
 	{ 0x030E, 0x00 },
 	{ 0x030F, 0xD8 },
 	{ 0x0310, 0x00 },
+
+	{ 0x0114, 0x01 },
 	{ 0x0820, 0x13 },
 	{ 0x0821, 0x4C },
 	{ 0x0822, 0xCC },
 	{ 0x0823, 0xCC },
 };
 
-static const struct imx258_reg mipi_640mbps_19_2mhz[] = {
+static const struct imx258_reg mipi_1272mbps_24mhz_4l[] = {
+	{ 0x0136, 0x18 },
+	{ 0x0137, 0x00 },
+	{ 0x0301, 0x05 },
+	{ 0x0303, 0x02 },
+	{ 0x0305, 0x04 },
+	{ 0x0306, 0x00 },
+	{ 0x0307, 0xD4 },
+	{ 0x0309, 0x0A },
+	{ 0x030B, 0x01 },
+	{ 0x030D, 0x02 },
+	{ 0x030E, 0x00 },
+	{ 0x030F, 0xD8 },
+	{ 0x0310, 0x00 },
+
+	{ 0x0114, 0x03 },
+	{ 0x0820, 0x13 },
+	{ 0x0821, 0xE0 },
+	{ 0x0822, 0x00 },
+	{ 0x0823, 0x00 },
+};
+
+static const struct imx258_reg mipi_640mbps_19_2mhz_2l[] = {
+	{ 0x0136, 0x13 },
+	{ 0x0137, 0x33 },
+	{ 0x0301, 0x05 },
+	{ 0x0303, 0x02 },
+	{ 0x0305, 0x03 },
+	{ 0x0306, 0x00 },
+	{ 0x0307, 0x64 },
+	{ 0x0309, 0x0A },
+	{ 0x030B, 0x01 },
+	{ 0x030D, 0x02 },
+	{ 0x030E, 0x00 },
+	{ 0x030F, 0xD8 },
+	{ 0x0310, 0x00 },
+
+	{ 0x0114, 0x01 },
+	{ 0x0820, 0x05 },
+	{ 0x0821, 0x00 },
+	{ 0x0822, 0x00 },
+	{ 0x0823, 0x00 },
+};
+
+static const struct imx258_reg mipi_640mbps_19_2mhz_4l[] = {
 	{ 0x0136, 0x13 },
 	{ 0x0137, 0x33 },
 	{ 0x0301, 0x05 },
@@ -166,13 +246,37 @@ static const struct imx258_reg mipi_640mbps_19_2mhz[] = {
 	{ 0x030E, 0x00 },
 	{ 0x030F, 0xD8 },
 	{ 0x0310, 0x00 },
+
+	{ 0x0114, 0x03 },
+	{ 0x0820, 0x0A },
+	{ 0x0821, 0x00 },
+	{ 0x0822, 0x00 },
+	{ 0x0823, 0x00 },
+};
+
+static const struct imx258_reg mipi_642mbps_24mhz_2l[] = {
+	{ 0x0136, 0x18 },
+	{ 0x0137, 0x00 },
+	{ 0x0301, 0x0A },
+	{ 0x0303, 0x02 },
+	{ 0x0305, 0x04 },
+	{ 0x0306, 0x00 },
+	{ 0x0307, 0x6B },
+	{ 0x0309, 0x0A },
+	{ 0x030B, 0x01 },
+	{ 0x030D, 0x02 },
+	{ 0x030E, 0x00 },
+	{ 0x030F, 0xD8 },
+	{ 0x0310, 0x00 },
+
+	{ 0x0114, 0x01 },
 	{ 0x0820, 0x0A },
 	{ 0x0821, 0x00 },
 	{ 0x0822, 0x00 },
 	{ 0x0823, 0x00 },
 };
 
-static const struct imx258_reg mipi_642mbps_24mhz[] = {
+static const struct imx258_reg mipi_642mbps_24mhz_4l[] = {
 	{ 0x0136, 0x18 },
 	{ 0x0137, 0x00 },
 	{ 0x0301, 0x05 },
@@ -186,6 +290,8 @@ static const struct imx258_reg mipi_642mbps_24mhz[] = {
 	{ 0x030E, 0x00 },
 	{ 0x030F, 0xD8 },
 	{ 0x0310, 0x00 },
+
+	{ 0x0114, 0x03 },
 	{ 0x0820, 0x0A },
 	{ 0x0821, 0x00 },
 	{ 0x0822, 0x00 },
@@ -240,7 +346,6 @@ static const struct imx258_reg mode_common_regs[] = {
 	{ 0x5F05, 0xED },
 	{ 0x0112, 0x0A },
 	{ 0x0113, 0x0A },
-	{ 0x0114, 0x03 },
 	{ 0x0342, 0x14 },
 	{ 0x0343, 0xE8 },
 	{ 0x0344, 0x00 },
@@ -359,11 +464,13 @@ enum {
 
 /*
  * pixel_rate = link_freq * data-rate * nr_of_lanes / bits_per_sample
- * data rate => double data rate; number of lanes => 4; bits per pixel => 10
+ * data rate => double data rate;
+ * number of lanes => (configurable 2 or 4);
+ * bits per pixel => 10
  */
-static u64 link_freq_to_pixel_rate(u64 f)
+static u64 link_freq_to_pixel_rate(u64 f, unsigned int nlanes)
 {
-	f *= 2 * 4;
+	f *= 2 * nlanes;
 	do_div(f, 10);
 
 	return f;
@@ -393,15 +500,27 @@ static const struct imx258_link_freq_config link_freq_configs_19_2[] = {
 	[IMX258_LINK_FREQ_1267MBPS] = {
 		.pixels_per_line = IMX258_PPL_DEFAULT,
 		.reg_list = {
-			.num_of_regs = ARRAY_SIZE(mipi_1267mbps_19_2mhz),
-			.regs = mipi_1267mbps_19_2mhz,
+			[IMX258_2_LANE_MODE] = {
+				.num_of_regs = ARRAY_SIZE(mipi_1267mbps_19_2mhz_2l),
+				.regs = mipi_1267mbps_19_2mhz_2l,
+			},
+			[IMX258_4_LANE_MODE] = {
+				.num_of_regs = ARRAY_SIZE(mipi_1267mbps_19_2mhz_4l),
+				.regs = mipi_1267mbps_19_2mhz_4l,
+			},
 		}
 	},
 	[IMX258_LINK_FREQ_640MBPS] = {
 		.pixels_per_line = IMX258_PPL_DEFAULT,
 		.reg_list = {
-			.num_of_regs = ARRAY_SIZE(mipi_640mbps_19_2mhz),
-			.regs = mipi_640mbps_19_2mhz,
+			[IMX258_2_LANE_MODE] = {
+				.num_of_regs = ARRAY_SIZE(mipi_640mbps_19_2mhz_2l),
+				.regs = mipi_640mbps_19_2mhz_2l,
+			},
+			[IMX258_4_LANE_MODE] = {
+				.num_of_regs = ARRAY_SIZE(mipi_640mbps_19_2mhz_4l),
+				.regs = mipi_640mbps_19_2mhz_4l,
+			},
 		}
 	},
 };
@@ -410,15 +529,27 @@ static const struct imx258_link_freq_config link_freq_configs_24[] = {
 	[IMX258_LINK_FREQ_1267MBPS] = {
 		.pixels_per_line = IMX258_PPL_DEFAULT,
 		.reg_list = {
-			.num_of_regs = ARRAY_SIZE(mipi_1272mbps_24mhz),
-			.regs = mipi_1272mbps_24mhz,
+			[IMX258_2_LANE_MODE] = {
+				.num_of_regs = ARRAY_SIZE(mipi_1272mbps_24mhz_2l),
+				.regs = mipi_1272mbps_24mhz_2l,
+			},
+			[IMX258_4_LANE_MODE] = {
+				.num_of_regs = ARRAY_SIZE(mipi_1272mbps_24mhz_4l),
+				.regs = mipi_1272mbps_24mhz_4l,
+			},
 		}
 	},
 	[IMX258_LINK_FREQ_640MBPS] = {
 		.pixels_per_line = IMX258_PPL_DEFAULT,
 		.reg_list = {
-			.num_of_regs = ARRAY_SIZE(mipi_642mbps_24mhz),
-			.regs = mipi_642mbps_24mhz,
+			[IMX258_2_LANE_MODE] = {
+				.num_of_regs = ARRAY_SIZE(mipi_642mbps_24mhz_2l),
+				.regs = mipi_642mbps_24mhz_2l,
+			},
+			[IMX258_4_LANE_MODE] = {
+				.num_of_regs = ARRAY_SIZE(mipi_642mbps_24mhz_4l),
+				.regs = mipi_642mbps_24mhz_4l,
+			},
 		}
 	},
 };
@@ -477,6 +608,7 @@ struct imx258 {
 
 	const struct imx258_link_freq_config *link_freq_configs;
 	const s64 *link_freq_menu_items;
+	unsigned int nlanes;
 
 	/*
 	 * Mutex for serialized access:
@@ -782,7 +914,7 @@ static int imx258_set_pad_format(struct v4l2_subdev *sd,
 		__v4l2_ctrl_s_ctrl(imx258->link_freq, mode->link_freq_index);
 
 		link_freq = imx258->link_freq_menu_items[mode->link_freq_index];
-		pixel_rate = link_freq_to_pixel_rate(link_freq);
+		pixel_rate = link_freq_to_pixel_rate(link_freq, imx258->nlanes);
 		__v4l2_ctrl_s_ctrl_int64(imx258->pixel_rate, pixel_rate);
 		/* Update limits and set FPS to default */
 		vblank_def = imx258->cur_mode->vts_def -
@@ -811,11 +943,13 @@ static int imx258_start_streaming(struct imx258 *imx258)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
 	const struct imx258_reg_list *reg_list;
+	const struct imx258_link_freq_config *link_freq_cfg;
 	int ret, link_freq_index;
 
 	/* Setup PLL */
 	link_freq_index = imx258->cur_mode->link_freq_index;
-	reg_list = &imx258->link_freq_configs[link_freq_index].reg_list;
+	link_freq_cfg = &imx258->link_freq_configs[link_freq_index];
+	reg_list = &link_freq_cfg->reg_list[imx258->nlanes == 2 ? 0 : 1];
 	ret = imx258_write_regs(imx258, reg_list->regs, reg_list->num_of_regs);
 	if (ret) {
 		dev_err(&client->dev, "%s failed to set plls\n", __func__);
@@ -1033,9 +1167,11 @@ static int imx258_init_controls(struct imx258 *imx258)
 		vflip->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
 	pixel_rate_max =
-		link_freq_to_pixel_rate(imx258->link_freq_menu_items[0]);
+		link_freq_to_pixel_rate(imx258->link_freq_menu_items[0],
+					imx258->nlanes);
 	pixel_rate_min =
-		link_freq_to_pixel_rate(imx258->link_freq_menu_items[1]);
+		link_freq_to_pixel_rate(imx258->link_freq_menu_items[1],
+					imx258->nlanes);
 	/* By default, PIXEL_RATE is read only */
 	imx258->pixel_rate = v4l2_ctrl_new_std(ctrl_hdlr, &imx258_ctrl_ops,
 				V4L2_CID_PIXEL_RATE,
@@ -1132,6 +1268,10 @@ static int imx258_get_regulators(struct imx258 *imx258,
 static int imx258_probe(struct i2c_client *client)
 {
 	struct imx258 *imx258;
+	struct fwnode_handle *endpoint;
+	struct v4l2_fwnode_endpoint ep = {
+		.bus_type = V4L2_MBUS_CSI2_DPHY
+	};
 	int ret;
 	u32 val = 0;
 
@@ -1172,13 +1312,35 @@ static int imx258_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
+	endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(&client->dev), NULL);
+	if (!endpoint) {
+		dev_err(&client->dev, "Endpoint node not found\n");
+		return -EINVAL;
+	}
+
+	ret = v4l2_fwnode_endpoint_alloc_parse(endpoint, &ep);
+	fwnode_handle_put(endpoint);
+	if (ret) {
+		dev_err(&client->dev, "Parsing endpoint node failed\n");
+		return ret;
+	}
+
+	/* Get number of data lanes */
+	imx258->nlanes = ep.bus.mipi_csi2.num_data_lanes;
+	if (imx258->nlanes != 2 && imx258->nlanes != 4) {
+		dev_err(&client->dev, "Invalid data lanes: %u\n",
+			imx258->nlanes);
+		ret = -EINVAL;
+		goto error_endpoint_free;
+	}
+
 	/* Initialize subdev */
 	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
 
 	/* Will be powered off via pm_runtime_idle */
 	ret = imx258_power_on(&client->dev);
 	if (ret)
-		return ret;
+		goto error_endpoint_free;
 
 	/* Check module identity */
 	ret = imx258_identify_module(imx258);
@@ -1211,6 +1373,7 @@ static int imx258_probe(struct i2c_client *client)
 	pm_runtime_set_active(&client->dev);
 	pm_runtime_enable(&client->dev);
 	pm_runtime_idle(&client->dev);
+	v4l2_fwnode_endpoint_free(&ep);
 
 	return 0;
 
@@ -1223,6 +1386,9 @@ static int imx258_probe(struct i2c_client *client)
 error_identify:
 	imx258_power_off(&client->dev);
 
+error_endpoint_free:
+	v4l2_fwnode_endpoint_free(&ep);
+
 	return ret;
 }
 
-- 
2.42.0


