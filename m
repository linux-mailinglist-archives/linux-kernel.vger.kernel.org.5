Return-Path: <linux-kernel+bounces-24025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3840B82B591
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C6E286CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBB157338;
	Thu, 11 Jan 2024 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z87XcEkX"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B456B76
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-336897b6bd6so5338325f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705003026; x=1705607826; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VruG++fZ5jU2hKKx0BJ6HBmek88ni0w2T34SzkuW8J8=;
        b=z87XcEkX2mWw5raE9302J52rYVHQdzeRiz+OtPwM5B8wGVw3vy8UILrn3Kv8BvaOHg
         HN8DSgfUICE6XS3rWLCnnUOgTtQjQRQNpbfVJnCzFwWBNAnuTyCzwYYRRuTaPDw3JhF9
         P4b78O2X8XZtxyBHq+YCdI+FDt0yPXskwKHWq/cB7O35U+n9qaOrZPJEWQRblcUia9Kd
         PzN9BeIctCnkl2qy4GeDvO98N4VXggBxzRPdRwAzAfQ8JzuEEv+SW/CMARVuT0WN9823
         pDiGhwg10jcGRd2T38eb62ct1zChWgE4UQY1Q9cd7+Q0j/EdkvKHKOcDOsYmpe4y8NUf
         mijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705003026; x=1705607826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VruG++fZ5jU2hKKx0BJ6HBmek88ni0w2T34SzkuW8J8=;
        b=OgReiiQXlsvEAtY26lFWKMFZs3H1Gw3MZPa6YFKUqFwQG63EG5wmHawt8Wlyc7Htym
         EN9r+gXg0r4Y8hzjmkitfDvzoTsURq6Frb+sAGXsd5qGcB92+C0F92u6xN8qHrWA7V7v
         2rUCJbRaDIG1Ewr2+mdjSh8KwySPsbPYojjypBrds7Pe93Hipru3jxFJqvSQ0PjUB66h
         YWEd3Sn4DC0t7Uvsr+IE8ITCkOzo1MkQxVJscFlbkUgdMj8rkh9rkA2+bb62KVaS7pl+
         TNgEmYjv4LnDKyEdFnft7v0z3PNL1OnNP2G2wpS/xMfPfO4DYw33zpjluhPD6HX65rU/
         kZ6w==
X-Gm-Message-State: AOJu0YzXdr9OZsmQAZ4MIQj9W/UXasCr3Cm535YB0jki5avVPN06F4+o
	ag9coYKXEZUZ9eQPWe6ITYThgYxJt/Pp0A==
X-Google-Smtp-Source: AGHT+IHeT5URh66hPtENDGA/6G5VukazA73Mm07T/ZeTNGJuociiql/E6fVXl+q2sMPpMOcFkUuyAg==
X-Received: by 2002:adf:e4c8:0:b0:336:ca94:3e00 with SMTP id v8-20020adfe4c8000000b00336ca943e00mr127785wrm.69.1705003026587;
        Thu, 11 Jan 2024 11:57:06 -0800 (PST)
Received: from [127.0.1.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe647000000b0033763a9ea2dsm1955382wrn.63.2024.01.11.11.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 11:57:06 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 11 Jan 2024 19:57:04 +0000
Subject: [PATCH 3/5] media: qcom: camss: Add sc8280xp resources
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240111-linux-next-24-01-09-sc8280xp-camss-changes-v1-3-b92a650121ba@linaro.org>
References: <20240111-linux-next-24-01-09-sc8280xp-camss-changes-v1-0-b92a650121ba@linaro.org>
In-Reply-To: <20240111-linux-next-24-01-09-sc8280xp-camss-changes-v1-0-b92a650121ba@linaro.org>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-4e032

This commit describes the hardware layout for the sc8280xp for the
following hardware blocks:

- 4 x VFE, 4 RDI per VFE
- 4 x VFE Lite, 4 RDI per VFE
- 4 x CSID
- 4 x CSID Lite
- 4 x CSI PHY

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

---
Depends on:
Link: https://lore.kernel.org/linux-arm-msm/20240111-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v4-2-cdd5c57ff1dc@linaro.org
---
 drivers/media/platform/qcom/camss/camss.c | 307 ++++++++++++++++++++++++++++++
 1 file changed, 307 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 58f4be660290..916fe4a83aa9 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -941,6 +941,298 @@ static const struct resources_icc icc_res_sm8250[] = {
 	},
 };
 
+static const struct camss_subdev_resources csiphy_res_sc8280xp[] = {
+	/* CSIPHY0 */
+	{
+		.regulators = {},
+		.clock = { "csiphy0", "csiphy0_timer" },
+		.clock_rate = { { 400000000 },
+				{ 300000000 } },
+		.reg = { "csiphy0" },
+		.interrupt = { "csiphy0" },
+		.ops = &csiphy_ops_3ph_1_0
+	},
+	/* CSIPHY1 */
+	{
+		.regulators = {},
+		.clock = { "csiphy1", "csiphy1_timer" },
+		.clock_rate = { { 400000000 },
+				{ 300000000 } },
+		.reg = { "csiphy1" },
+		.interrupt = { "csiphy1" },
+		.ops = &csiphy_ops_3ph_1_0
+	},
+	/* CSIPHY2 */
+	{
+		.regulators = {},
+		.clock = { "csiphy2", "csiphy2_timer" },
+		.clock_rate = { { 400000000 },
+				{ 300000000 } },
+		.reg = { "csiphy2" },
+		.interrupt = { "csiphy2" },
+		.ops = &csiphy_ops_3ph_1_0
+	},
+	/* CSIPHY3 */
+	{
+		.regulators = {},
+		.clock = { "csiphy3", "csiphy3_timer" },
+		.clock_rate = { { 400000000 },
+				{ 300000000 } },
+		.reg = { "csiphy3" },
+		.interrupt = { "csiphy3" },
+		.ops = &csiphy_ops_3ph_1_0
+	},
+};
+
+static const struct camss_subdev_resources csid_res_sc8280xp[] = {
+	/* CSID0 */
+	{
+		.regulators = { "vdda-phy", "vdda-pll" },
+		.clock = { "vfe0_csid", "vfe0_cphy_rx", "vfe0", "vfe0_axi" },
+		.clock_rate = { { 400000000, 480000000, 600000000 },
+				{ 0 },
+				{ 0 },
+				{ 0 } },
+		.reg = { "csid0" },
+		.interrupt = { "csid0" },
+		.ops = &csid_ops_gen2
+	},
+	/* CSID1 */
+	{
+		.regulators = { "vdda-phy", "vdda-pll" },
+		.clock = { "vfe1_csid", "vfe1_cphy_rx", "vfe1", "vfe1_axi" },
+		.clock_rate = { { 400000000, 480000000, 600000000 },
+				{ 0 },
+				{ 0 },
+				{ 0 } },
+		.reg = { "csid1" },
+		.interrupt = { "csid1" },
+		.ops = &csid_ops_gen2
+	},
+	/* CSID2 */
+	{
+		.regulators = { "vdda-phy", "vdda-pll" },
+		.clock = { "vfe2_csid", "vfe2_cphy_rx", "vfe2", "vfe2_axi" },
+		.clock_rate = { { 400000000, 480000000, 600000000 },
+				{ 0 },
+				{ 0 },
+				{ 0 } },
+		.reg = { "csid2" },
+		.interrupt = { "csid2" },
+		.ops = &csid_ops_gen2
+	},
+	/* CSID3 */
+	{
+		.regulators = { "vdda-phy", "vdda-pll" },
+		.clock = { "vfe3_csid", "vfe3_cphy_rx", "vfe3", "vfe3_axi" },
+		.clock_rate = { { 400000000, 480000000, 600000000 },
+				{ 0 },
+				{ 0 },
+				{ 0 } },
+		.reg = { "csid3" },
+		.interrupt = { "csid3" },
+		.ops = &csid_ops_gen2
+	},
+	/* CSID_LITE0 */
+	{
+		.regulators = { "vdda-phy", "vdda-pll" },
+		.clock = { "vfe_lite0_csid", "vfe_lite0_cphy_rx", "vfe_lite0" },
+		.clock_rate = { { 400000000, 480000000, 600000000 },
+				{ 0 },
+				{ 0 }, },
+		.reg = { "csid0_lite" },
+		.interrupt = { "csid0_lite" },
+		.is_lite = true,
+		.ops = &csid_ops_gen2
+	},
+	/* CSID_LITE1 */
+	{
+		.regulators = { "vdda-phy", "vdda-pll" },
+		.clock = { "vfe_lite1_csid", "vfe_lite1_cphy_rx", "vfe_lite1" },
+		.clock_rate = { { 400000000, 480000000, 600000000 },
+				{ 0 },
+				{ 0 }, },
+		.reg = { "csid1_lite" },
+		.interrupt = { "csid1_lite" },
+		.is_lite = true,
+		.ops = &csid_ops_gen2
+	},
+	/* CSID_LITE2 */
+	{
+		.regulators = { "vdda-phy", "vdda-pll" },
+		.clock = { "vfe_lite2_csid", "vfe_lite2_cphy_rx", "vfe_lite2" },
+		.clock_rate = { { 400000000, 480000000, 600000000 },
+				{ 0 },
+				{ 0 }, },
+		.reg = { "csid2_lite" },
+		.interrupt = { "csid2_lite" },
+		.is_lite = true,
+		.ops = &csid_ops_gen2
+	},
+	/* CSID_LITE3 */
+	{
+		.regulators = { "vdda-phy", "vdda-pll" },
+		.clock = { "vfe_lite3_csid", "vfe_lite3_cphy_rx", "vfe_lite3" },
+		.clock_rate = { { 400000000, 480000000, 600000000 },
+				{ 0 },
+				{ 0 }, },
+		.reg = { "csid3_lite" },
+		.interrupt = { "csid3_lite" },
+		.is_lite = true,
+		.ops = &csid_ops_gen2
+	}
+};
+
+static const struct camss_subdev_resources vfe_res_sc8280xp[] = {
+	/* IFE0 */
+	{
+		.regulators = {},
+		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi", "vfe0", "vfe0_axi" },
+		.clock_rate = { { 0 },
+				{ 0 },
+				{ 19200000, 80000000},
+				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
+				{ 400000000, 558000000, 637000000, 760000000 },
+				{ 0 }, },
+		.reg = { "vfe0" },
+		.interrupt = { "vfe0" },
+		.pd_name = "ife0",
+		.line_num = 4,
+		.ops = &vfe_ops_170
+	},
+	/* IFE1 */
+	{
+		.regulators = {},
+		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi", "vfe1", "vfe1_axi" },
+		.clock_rate = { { 0 },
+				{ 0 },
+				{ 19200000, 80000000},
+				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
+				{ 400000000, 558000000, 637000000, 760000000 },
+				{ 0 }, },
+		.reg = { "vfe1" },
+		.interrupt = { "vfe1" },
+		.pd_name = "ife1",
+		.line_num = 4,
+		.ops = &vfe_ops_170
+	},
+	/* IFE2 */
+	{
+		.regulators = {},
+		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi", "vfe2", "vfe2_axi" },
+		.clock_rate = { { 0 },
+				{ 0 },
+				{ 19200000, 80000000},
+				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
+				{ 400000000, 558000000, 637000000, 760000000 },
+				{ 0 }, },
+		.reg = { "vfe2" },
+		.interrupt = { "vfe2" },
+		.pd_name = "ife2",
+		.line_num = 4,
+		.ops = &vfe_ops_170
+	},
+	/* VFE3 */
+	{
+		.regulators = {},
+		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi", "vfe3", "vfe3_axi" },
+		.clock_rate = { { 0 },
+				{ 0 },
+				{ 19200000, 80000000},
+				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
+				{ 400000000, 558000000, 637000000, 760000000 },
+				{ 0 }, },
+		.reg = { "vfe3" },
+		.interrupt = { "vfe3" },
+		.pd_name = "ife3",
+		.line_num = 4,
+		.ops = &vfe_ops_170
+	},
+	/* IFE_LITE_0 */
+	{
+		.regulators = {},
+		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi", "vfe_lite0" },
+		.clock_rate = { { 0 },
+				{ 0 },
+				{ 19200000, 80000000},
+				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
+				{ 320000000, 400000000, 480000000, 600000000 }, },
+		.reg = { "vfe_lite0" },
+		.interrupt = { "vfe_lite0" },
+		.is_lite = true,
+		.line_num = 4,
+		.ops = &vfe_ops_170
+	},
+	/* IFE_LITE_1 */
+	{
+		.regulators = {},
+		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi", "vfe_lite1" },
+		.clock_rate = { { 0 },
+				{ 0 },
+				{ 19200000, 80000000},
+				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
+				{ 320000000, 400000000, 480000000, 600000000 }, },
+		.reg = { "vfe_lite1" },
+		.interrupt = { "vfe_lite1" },
+		.is_lite = true,
+		.line_num = 4,
+		.ops = &vfe_ops_170
+	},
+	/* IFE_LITE_2 */
+	{
+		.regulators = {},
+		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi", "vfe_lite2" },
+		.clock_rate = { { 0 },
+				{ 0 },
+				{ 19200000, 80000000},
+				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
+				{ 320000000, 400000000, 480000000, 600000000, }, },
+		.reg = { "vfe_lite2" },
+		.interrupt = { "vfe_lite2" },
+		.is_lite = true,
+		.line_num = 4,
+		.ops = &vfe_ops_170
+	},
+	/* VFE_LITE_3 */
+	{
+		.regulators = {},
+		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi", "vfe_lite3" },
+		.clock_rate = { { 0 },
+				{ 0 },
+				{ 19200000, 80000000},
+				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
+				{ 320000000, 400000000, 480000000, 600000000 }, },
+		.reg = { "vfe_lite3" },
+		.interrupt = { "vfe_lite3" },
+		.is_lite = true,
+		.line_num = 4,
+		.ops = &vfe_ops_170
+	},
+};
+
+static const struct resources_icc icc_res_sc8280xp[] = {
+	{
+		.name = "cam_ahb",
+		.icc_bw_tbl.avg = 150000,
+		.icc_bw_tbl.peak = 300000,
+	},
+	{
+		.name = "cam_hf_mnoc",
+		.icc_bw_tbl.avg = 2097152,
+		.icc_bw_tbl.peak = 2097152,
+	},
+	{
+		.name = "cam_sf_mnoc",
+		.icc_bw_tbl.avg = 2097152,
+		.icc_bw_tbl.peak = 2097152,
+	},
+	{
+		.name = "cam_sf_icp_mnoc",
+		.icc_bw_tbl.avg = 2097152,
+		.icc_bw_tbl.peak = 2097152,
+	},
+};
+
 /*
  * camss_add_clock_margin - Add margin to clock frequency rate
  * @rate: Clock frequency rate
@@ -1826,12 +2118,27 @@ static const struct camss_resources sm8250_resources = {
 	.vfe_num = ARRAY_SIZE(vfe_res_8250),
 };
 
+static const struct camss_resources sc8280xp_resources = {
+	.version = CAMSS_8280XP,
+	.pd_name = "top",
+	.csiphy_res = csiphy_res_sc8280xp,
+	.csid_res = csid_res_sc8280xp,
+	.ispif_res = NULL,
+	.vfe_res = vfe_res_sc8280xp,
+	.icc_res = icc_res_sc8280xp,
+	.icc_path_num = ARRAY_SIZE(icc_res_sc8280xp),
+	.csiphy_num = ARRAY_SIZE(csiphy_res_sc8280xp),
+	.csid_num = ARRAY_SIZE(csid_res_sc8280xp),
+	.vfe_num = ARRAY_SIZE(vfe_res_sc8280xp),
+};
+
 static const struct of_device_id camss_dt_match[] = {
 	{ .compatible = "qcom,msm8916-camss", .data = &msm8916_resources },
 	{ .compatible = "qcom,msm8996-camss", .data = &msm8996_resources },
 	{ .compatible = "qcom,sdm660-camss", .data = &sdm660_resources },
 	{ .compatible = "qcom,sdm845-camss", .data = &sdm845_resources },
 	{ .compatible = "qcom,sm8250-camss", .data = &sm8250_resources },
+	{ .compatible = "qcom,sc8280xp-camss", .data = &sc8280xp_resources },
 	{ }
 };
 

-- 
2.42.0


