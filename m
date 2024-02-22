Return-Path: <linux-kernel+bounces-76962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3BF85FF1D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC4B1F2C927
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEBD158D6D;
	Thu, 22 Feb 2024 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqFiXaKW"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F4157E72
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622236; cv=none; b=Ns6LvmBqnq+wpw767b3Oo6o6UjBEImPRyOZ3nKEfSCZBS6l0td7knuBMMW2QMcuA8voHuW2DjaHOmeUjxDXBzeo8EbaYz0zFWCZpGVEDvnvNd6dcRzhCyBVuFM/0DVjQX6bCk7y5g0TMsc8dbeSU93iQwjM8BARJzcqzlbr0M0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622236; c=relaxed/simple;
	bh=/kmcnMlVSLpZKYFxk3treNcwTEoi3s+aE2loRmzbUpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H4DvjHC4aTcdM+RqCvohRCOEgFCE1kgslMPjc9LelU3XilEvU5tBYv+fpfXLaaNHzG6eeUG4fYdVMO2wFN4p0P83QtufW1jWWsz0BWzsWhYleh7IKTGOzi0wsCmhWks3N35M8hlyQ+DNrH41zng75xFXm4eapmRDzxbx9qE1as4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rqFiXaKW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412895f726dso5349035e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708622232; x=1709227032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frYteaRpBrCH5GSPLIf/O4ZOUibDn1IhwPsmgBnzbSM=;
        b=rqFiXaKWHZjHtQpZ9IjMK7Skvicd6MsKx3X6q2Qehh2n+4dnItPvDquAdhlD+UMuvs
         lJvcUsUr41zCThIEuWjsKqE0mnbKSAnUdZWr/yKkyqHCKXZu+oMaHm9X7wG19pAw8o8M
         bzTxwWJm8/QHMEhjlTLRQr7qo/mkJETSDwEoPKJ/JOFcY90oWPA65u19ow5nGhgyiead
         0HK9qXa8lEW8ECRx18OxzUWliXNar3NcRypIp577SbB3sNsRdvQj7+Uq21YhL9sxFBaP
         o6JXJtvd4pMnXCSBrmPBIh4R8bIJzwhacb1nfcu02l6bHAeghp30vJT58hYWp8S7CzRT
         rtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622232; x=1709227032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frYteaRpBrCH5GSPLIf/O4ZOUibDn1IhwPsmgBnzbSM=;
        b=hryrZCtb5MKu6BQyQ/EqOmf9AcNQqzkbTSNbZIvgIXxbSFsdb57GN+QbBuO3CX4Skr
         iJzIdLZfFhhXfWPyQ/QrlUZWgIeNyz5yJyYI5yxsGRMjPGApLzPwooPg8Vn8b3kEjUVG
         fqt3o2aRGAyuvP+BUFJPB1ZyZVupyXtIsY7TTFeEBzxlF6YC/JtPdLwhWNG0thH464/f
         C0jNCVJwIIG8/KuCOL/T/6hDhU1xj+vmE1ttUjGc2k+iYiT6VH1PlBG9GCQRdEEMXHzF
         uF4moGfn2AtqkUzFzAXT+wUfflqOuU+3uq6w0FTDk2l5RkC+mlBOiY1ycBOMvrR46yrS
         TuAA==
X-Forwarded-Encrypted: i=1; AJvYcCUi6LjtHq1MAC1zWnEzFNGuwbbdgT+W27CWQIWD9qwnA8pkobdYswrRa+nqiNniZE/eSuT4gsXhcqdBXQi8qWzcoarLjiiF0oNrgqcQ
X-Gm-Message-State: AOJu0YzsWxFDuMalRNkT30mCyZbu6gx8y+M8d4i/3w9fX1nyOe2RJGph
	xvkMF8OiSGdIHvVWnKyclSzRwsRf0mpjJKhG/bKPfM6fXJqmlWPFHxraRCYkDt4=
X-Google-Smtp-Source: AGHT+IHRxllSpOchpymDI1nsyQc0+h+GLKIDZe768ay5zmzcYUCs1/w1QTWrtKn7L8zhPxI82ssB5Q==
X-Received: by 2002:a05:600c:4f53:b0:412:5ef7:29c0 with SMTP id m19-20020a05600c4f5300b004125ef729c0mr11288905wmq.13.1708622232382;
        Thu, 22 Feb 2024 09:17:12 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bc047000000b0040fe4b733f4sm6656512wmc.26.2024.02.22.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:17:11 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 22 Feb 2024 17:17:02 +0000
Subject: [PATCH v6 4/6] media: qcom: camss: Add sc8280xp resources
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-b4-camss-sc8280xp-v6-4-0e0e6a2f8962@linaro.org>
References: <20240222-b4-camss-sc8280xp-v6-0-0e0e6a2f8962@linaro.org>
In-Reply-To: <20240222-b4-camss-sc8280xp-v6-0-0e0e6a2f8962@linaro.org>
To: hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, vincent.knecht@mailoo.org, 
 matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
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
index 58f4be660290..1923615f0eea 100644
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
+	/* VFE0 */
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
+	/* VFE1 */
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
+	/* VFE2 */
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
+	/* VFE_LITE_0 */
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
+	/* VFE_LITE_1 */
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
+	/* VFE_LITE_2 */
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
2.43.0


