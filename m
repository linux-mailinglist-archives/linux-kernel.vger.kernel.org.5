Return-Path: <linux-kernel+bounces-45857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAE6843723
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEEE8B23C91
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A754BD3;
	Wed, 31 Jan 2024 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JddaQjSd"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C93254F88
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684888; cv=none; b=l/S4sR+SgQn7lUs22ZZlvVzprChnlBapCS0RNucXWsOUpGj6MbAPoKHjEIrVTNLXk3BaKOUwmfaf6/hOaeHjTdTxdr29AbI5Y16jpqAN3efb6q3bu/LKysnpuwdFSKY3kA6ddWhc0DNe/mKn/foU1bWK4Z1H03zmrbFAINL8A18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684888; c=relaxed/simple;
	bh=eg29QpxTi3ABDM8Q2DT3ev/3ZsS2P/QOtpIx5SRYMdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S4ufJf7V+U3Y1UtUA50JWzj2Q2ibseBwwxORjUctZiZlkIJXVAxXTOqhJbHiQZLUARy2sYilcEqLXtXwxR7sNX5fVGaLB0St6+hodWmQHxQu1PGZXjfBIKFW2uT1YfEXr+xw/DxGskuyI6Yg8nwTV+/gi/sdtXnE64sXDbl/9Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JddaQjSd; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dbcebaf9a9so2569525a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706684884; x=1707289684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBqhHWcchsRJISu4NAHeEL0Dxp9/GvA2bdM9yR8s63M=;
        b=JddaQjSdrPw1r7Lr4i4q7Z410Ej6T90HPgF2X5K2OE1dwCNYEDZ/e67WSwXSr31Ze2
         N02Zt2tZ7ir8jQ8KxPQ8KzXyS7gj004R5M2mBuAUH1Lud0grUSv9obhRR8ilaF+WcVB2
         pZLZ3csKqxcYBBETx3juRvAKN53YSDdJ/luxkezSfanGsGQ6Z77eXQqa02No5pS+ShBp
         sThXK010TPhTVhWfnNFgYRjz4TibI5y5YwnabCRjWvc+mdNxCuGvCtlFRsljF0umEImB
         JWaf0cVt77H0uyKmGj8SnUCloTo61FGarvezmTBwm2SY3bQwPYDS6VCF5gB5dXqzyYjA
         KEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706684884; x=1707289684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBqhHWcchsRJISu4NAHeEL0Dxp9/GvA2bdM9yR8s63M=;
        b=a8LaWnwE15LUTBQFUd8uXl0I1+oxk/t1VzEG2Fn3J6qaMIOzZM8rYaFPwRao2KMdYU
         1cCIl+8kUMBMHEdsIK2MpcsGQw+GTJp5uJPuF5+w775jx4duE6x+SaJbWxoflhXNaNYF
         Gr0QEDx7bmEuE/SkgZkcIsfRewrzu52pB6L9HOJVGscLk3kdlcVyqFCCJqLmHDPT+DWW
         LHKDMn4czXLCvdXoOGFLzysHpkkdDMEgrctmuH3JCTOfimrBbOBaxsFrgW+e55+eVrJl
         7xqxHGVJe5lwLXzKdFJnYJkYXm6+0Hyw2QRFMAJPeAw41MpEbwgkUvkrmZiQ9Msl0kZm
         ztpw==
X-Gm-Message-State: AOJu0YwJnW+mMunTJvthXAiQkMSd0AugMwBu0G0FPSlnib1rxTcEbj2X
	Nd4uLIMk6RSVR/N5ORVPvcLeEBwBH7C/gkWxayFBlT6xQ9WMDFiBS73MXerodw==
X-Google-Smtp-Source: AGHT+IHvMSDBcrOY+N+BHWrx7Fb2p5cQuWH7WxKzXfwwIM7ax1D2poFdsOfRDlr+Y4AGOXgUdzlMWg==
X-Received: by 2002:a05:6359:1585:b0:178:9a4d:4b94 with SMTP id jv5-20020a056359158500b001789a4d4b94mr670270rwb.5.1706684884507;
        Tue, 30 Jan 2024 23:08:04 -0800 (PST)
Received: from [127.0.1.1] ([103.28.246.26])
        by smtp.gmail.com with ESMTPSA id lp17-20020a056a003d5100b006ddd182bf1csm9087956pfb.46.2024.01.30.23.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 23:08:04 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 31 Jan 2024 12:37:25 +0530
Subject: [PATCH v3 02/17] phy: qcom-qmp-ufs: Switch to
 devm_clk_bulk_get_all() API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-ufs-phy-clock-v3-2-58a49d2f4605@linaro.org>
References: <20240131-ufs-phy-clock-v3-0-58a49d2f4605@linaro.org>
In-Reply-To: <20240131-ufs-phy-clock-v3-0-58a49d2f4605@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, quic_cang@quicinc.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=7957;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=eg29QpxTi3ABDM8Q2DT3ev/3ZsS2P/QOtpIx5SRYMdA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlufG7zFsb3aHB0OvU5Wj5lOfwKBgEYaxoAW2Uc
 g+Vf+SNTuOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbnxuwAKCRBVnxHm/pHO
 9YFhB/4q/CKwcgfYdHF1n1aNnXT+prChXmoqWs5CgMe38P4yFBgkKIMKxuxzMAiLjrAwMeZU+0b
 wZLFrS+4tsgjZMRsa2CWUykVBDnD0PusmfrGJ/EZjKDFi/6QejENSaNavmaAaX9aI8m818gDwMo
 raTEK0Z8YQpXFp8NqazfPmvwVXEpvwu6w2Tk/HFlH+ANsqed3FDnM7qNZj2JV00kb1iJg5cLXCv
 nKOpEclINW52XotM/tikkM2Fay5owXSVfnpxg+Nd12liZIyis+bqL3iyscx6UAPG4c+az51fPH+
 1rGypqgwh2LBGesTy6VbhxGCf/7JlAVmBg8DldYshM/8wzj3
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Device drivers should just rely on the clocks provided by the devicetree
and enable/disable them based on the requirement. There is no need to
validate the clocks provided by devicetree in the driver. That's the job
of DT schema.

So let's switch to devm_clk_bulk_get_all() API that just gets the clocks
provided by devicetree and remove hardcoded clocks info.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 63 ++++-----------------------------
 1 file changed, 7 insertions(+), 56 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 38c4a4cc670a..590432d581f9 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -923,9 +923,6 @@ struct qmp_phy_cfg {
 	/* Additional sequence for different HS Gears */
 	const struct qmp_phy_cfg_tbls tbls_hs_overlay[NUM_OVERLAY];
 
-	/* clock ids to be requested */
-	const char * const *clk_list;
-	int num_clks;
 	/* regulators to be requested */
 	const char * const *vreg_list;
 	int num_vregs;
@@ -951,6 +948,7 @@ struct qmp_ufs {
 	void __iomem *rx2;
 
 	struct clk_bulk_data *clks;
+	int num_clks;
 	struct regulator_bulk_data *vregs;
 	struct reset_control *ufs_reset;
 
@@ -983,20 +981,6 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
 	readl(base + offset);
 }
 
-/* list of clocks required by phy */
-static const char * const msm8996_ufs_phy_clk_l[] = {
-	"ref",
-};
-
-/* the primary usb3 phy on sm8250 doesn't have a ref clock */
-static const char * const sm8450_ufs_phy_clk_l[] = {
-	"qref", "ref", "ref_aux",
-};
-
-static const char * const sdm845_ufs_phy_clk_l[] = {
-	"ref", "ref_aux",
-};
-
 /* list of regulators */
 static const char * const qmp_phy_vreg_l[] = {
 	"vdda-phy", "vdda-pll",
@@ -1035,9 +1019,6 @@ static const struct qmp_phy_cfg msm8996_ufsphy_cfg = {
 		.rx_num		= ARRAY_SIZE(msm8996_ufsphy_rx),
 	},
 
-	.clk_list		= msm8996_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(msm8996_ufs_phy_clk_l),
-
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 
@@ -1075,8 +1056,6 @@ static const struct qmp_phy_cfg sa8775p_ufsphy_cfg = {
 		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
 		.max_gear	= UFS_HS_G4,
 	},
-	.clk_list		= sm8450_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v5_regs_layout,
@@ -1111,8 +1090,6 @@ static const struct qmp_phy_cfg sc7280_ufsphy_cfg = {
 		.pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
 		.max_gear	= UFS_HS_G4,
 	},
-	.clk_list               = sm8450_ufs_phy_clk_l,
-	.num_clks               = ARRAY_SIZE(sm8450_ufs_phy_clk_l),
 	.vreg_list              = qmp_phy_vreg_l,
 	.num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs                   = ufsphy_v4_regs_layout,
@@ -1147,8 +1124,6 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
 		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
 		.max_gear	= UFS_HS_G4,
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v5_regs_layout,
@@ -1174,8 +1149,6 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
 		.serdes		= sdm845_ufsphy_hs_b_serdes,
 		.serdes_num	= ARRAY_SIZE(sdm845_ufsphy_hs_b_serdes),
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v3_regs_layout,
@@ -1203,8 +1176,6 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
 		.serdes		= sm6115_ufsphy_hs_b_serdes,
 		.serdes_num	= ARRAY_SIZE(sm6115_ufsphy_hs_b_serdes),
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v2_regs_layout,
@@ -1232,8 +1203,6 @@ static const struct qmp_phy_cfg sm7150_ufsphy_cfg = {
 		.serdes		= sdm845_ufsphy_hs_b_serdes,
 		.serdes_num	= ARRAY_SIZE(sdm845_ufsphy_hs_b_serdes),
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v3_regs_layout,
@@ -1270,8 +1239,6 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
 		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
 		.max_gear	= UFS_HS_G4,
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v4_regs_layout,
@@ -1306,8 +1273,6 @@ static const struct qmp_phy_cfg sm8250_ufsphy_cfg = {
 		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
 		.max_gear	= UFS_HS_G4,
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v4_regs_layout,
@@ -1342,8 +1307,6 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
 		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
 		.max_gear	= UFS_HS_G4,
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v5_regs_layout,
@@ -1378,8 +1341,6 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
 		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
 		.max_gear	= UFS_HS_G4,
 	},
-	.clk_list		= sm8450_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v5_regs_layout,
@@ -1425,8 +1386,6 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
 		.pcs_num	= ARRAY_SIZE(sm8550_ufsphy_g5_pcs),
 		.max_gear	= UFS_HS_G5,
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v6_regs_layout,
@@ -1448,8 +1407,6 @@ static const struct qmp_phy_cfg sm8650_ufsphy_cfg = {
 		.pcs		= sm8650_ufsphy_pcs,
 		.pcs_num	= ARRAY_SIZE(sm8650_ufsphy_pcs),
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v6_regs_layout,
@@ -1541,7 +1498,7 @@ static int qmp_ufs_com_init(struct qmp_ufs *qmp)
 		return ret;
 	}
 
-	ret = clk_bulk_prepare_enable(cfg->num_clks, qmp->clks);
+	ret = clk_bulk_prepare_enable(qmp->num_clks, qmp->clks);
 	if (ret)
 		goto err_disable_regulators;
 
@@ -1561,7 +1518,7 @@ static int qmp_ufs_com_exit(struct qmp_ufs *qmp)
 
 	reset_control_assert(qmp->ufs_reset);
 
-	clk_bulk_disable_unprepare(cfg->num_clks, qmp->clks);
+	clk_bulk_disable_unprepare(qmp->num_clks, qmp->clks);
 
 	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
 
@@ -1737,19 +1694,13 @@ static int qmp_ufs_vreg_init(struct qmp_ufs *qmp)
 
 static int qmp_ufs_clk_init(struct qmp_ufs *qmp)
 {
-	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	struct device *dev = qmp->dev;
-	int num = cfg->num_clks;
-	int i;
 
-	qmp->clks = devm_kcalloc(dev, num, sizeof(*qmp->clks), GFP_KERNEL);
-	if (!qmp->clks)
-		return -ENOMEM;
+	qmp->num_clks = devm_clk_bulk_get_all(dev, &qmp->clks);
+	if (qmp->num_clks < 0)
+		return qmp->num_clks;
 
-	for (i = 0; i < num; i++)
-		qmp->clks[i].id = cfg->clk_list[i];
-
-	return devm_clk_bulk_get(dev, num, qmp->clks);
+	return 0;
 }
 
 static void qmp_ufs_clk_release_provider(void *res)

-- 
2.25.1


