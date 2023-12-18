Return-Path: <linux-kernel+bounces-3528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AFD816D69
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF4C284B41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18941BDD7;
	Mon, 18 Dec 2023 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4ZY/aRa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1A94B156
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d045097b4cso9771075ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702901257; x=1703506057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSz/bHjwwlCoYKLoGELFqaslJ84OPxmUtiMSGQ7rw5w=;
        b=c4ZY/aRa7GDz6idGF4EEvdVsg2Zz73MumkKW5x57nmsuaSJOSb2sy0DE3uPyQMHnrf
         4LKIVQwBtjV63SMFfgui52zrnIcB2MnoU7vl3O/TQPx5Tlln5MjUb9/QyOStiyf6CB+t
         SjEjexDkkDGPvUQWJgP4YcegKqkY/TEcqFkGXV6ZCwV6XaywPiz4EMgvKNLT6BTg5xrp
         VKl+yQBmEqB655GmHQZdejTqceT3vRFH+0bR8GP6q+PHmhF9/08cPUFQXRfDVi9oZ7jI
         a16AOnEWH2mpbXPamoxNhIw/2cMmQEX7N9+0SizPQ2OQT4IgxkigZIMLHnTRMGoZRjVO
         7zvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702901257; x=1703506057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSz/bHjwwlCoYKLoGELFqaslJ84OPxmUtiMSGQ7rw5w=;
        b=BNiqXoivXxOX77SKiOD3j52ze7NfSIpf6yaPBlpJOcNApWvrCZZg/x2W/SQuZz2l9Q
         VfFAJKeFe5TISDL92rXLme1stcHsMlYaNYOGGamsMVjZAxCoeD9niBkInQ5GWXGY0yW8
         HN9UTpzDDWD4WDC3YVRr+8mH0wB24pAqBik17taLr21HhEA2Zd6rexdm64cvnAVWjt/7
         SXsm3B5nrK4qcq0i7SMa4KKr1v2Lo/aZn18DIJqYM1d2eSDlJ9pS2vS/tNa98umZxj17
         TujYVYXs+X5eoNI2LvOExfFE5yhizZZhd07nlZpmAZ7MjrtB77pGI96JGhaPofcbSwmL
         CPyw==
X-Gm-Message-State: AOJu0YxSYogoKqya4pmeKMHz99HRaIos5A0awADj/VynRtM7S+reIQkd
	az5N2hjvy8qkxgoUw+j6P0Rq
X-Google-Smtp-Source: AGHT+IG0t9oGeyfc7/rtJ11LwNl5za4dkimLF1SW6sE2PBnGyaGkf6vRgSEwEaOXIIyn5pgNgmTpCw==
X-Received: by 2002:a17:902:da87:b0:1d3:acef:6f4c with SMTP id j7-20020a170902da8700b001d3acef6f4cmr651234plx.21.1702901257374;
        Mon, 18 Dec 2023 04:07:37 -0800 (PST)
Received: from localhost.localdomain ([117.207.27.21])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902c3d200b001d368c778dasm1285709plj.235.2023.12.18.04.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 04:07:37 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	vkoul@kernel.org,
	sboyd@kernel.org,
	mturquette@baylibre.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	quic_cang@quicinc.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 02/16] phy: qcom-qmp-ufs: Switch to devm_clk_bulk_get_all() API
Date: Mon, 18 Dec 2023 17:36:58 +0530
Message-Id: <20231218120712.16438-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218120712.16438-1-manivannan.sadhasivam@linaro.org>
References: <20231218120712.16438-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device drivers should just rely on the clocks provided by the devicetree
and enable/disable them based on the requirement. There is no need to
validate the clocks provided by devicetree in the driver. That's the job
of DT schema.

So let's switch to devm_clk_bulk_get_all() API that just gets the clocks
provided by devicetree and remove hardcoded clocks info.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 61 +++----------------------
 1 file changed, 7 insertions(+), 54 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 514fa14df634..174b105fda82 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -837,9 +837,6 @@ struct qmp_phy_cfg {
 	/* Additional sequence for HS G4 */
 	const struct qmp_phy_cfg_tbls tbls_hs_g4;
 
-	/* clock ids to be requested */
-	const char * const *clk_list;
-	int num_clks;
 	/* regulators to be requested */
 	const char * const *vreg_list;
 	int num_vregs;
@@ -865,6 +862,7 @@ struct qmp_ufs {
 	void __iomem *rx2;
 
 	struct clk_bulk_data *clks;
+	int num_clks;
 	struct regulator_bulk_data *vregs;
 	struct reset_control *ufs_reset;
 
@@ -897,20 +895,6 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
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
@@ -948,9 +932,6 @@ static const struct qmp_phy_cfg msm8996_ufsphy_cfg = {
 		.rx_num		= ARRAY_SIZE(msm8996_ufsphy_rx),
 	},
 
-	.clk_list		= msm8996_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(msm8996_ufs_phy_clk_l),
-
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 
@@ -986,8 +967,6 @@ static const struct qmp_phy_cfg sa8775p_ufsphy_cfg = {
 		.pcs		= sm8350_ufsphy_g4_pcs,
 		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
 	},
-	.clk_list		= sm8450_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v5_regs_layout,
@@ -1020,8 +999,6 @@ static const struct qmp_phy_cfg sc7280_ufsphy_cfg = {
 		.pcs            = sm8150_ufsphy_hs_g4_pcs,
 		.pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
 	},
-	.clk_list               = sm8450_ufs_phy_clk_l,
-	.num_clks               = ARRAY_SIZE(sm8450_ufs_phy_clk_l),
 	.vreg_list              = qmp_phy_vreg_l,
 	.num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs                   = ufsphy_v4_regs_layout,
@@ -1054,8 +1031,6 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
 		.pcs		= sm8350_ufsphy_g4_pcs,
 		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v5_regs_layout,
@@ -1080,8 +1055,6 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
 		.serdes		= sdm845_ufsphy_hs_b_serdes,
 		.serdes_num	= ARRAY_SIZE(sdm845_ufsphy_hs_b_serdes),
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v3_regs_layout,
@@ -1108,8 +1081,6 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
 		.serdes		= sm6115_ufsphy_hs_b_serdes,
 		.serdes_num	= ARRAY_SIZE(sm6115_ufsphy_hs_b_serdes),
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v2_regs_layout,
@@ -1136,8 +1107,6 @@ static const struct qmp_phy_cfg sm7150_ufsphy_cfg = {
 		.serdes		= sdm845_ufsphy_hs_b_serdes,
 		.serdes_num	= ARRAY_SIZE(sdm845_ufsphy_hs_b_serdes),
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v3_regs_layout,
@@ -1172,8 +1141,6 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
 		.pcs		= sm8150_ufsphy_hs_g4_pcs,
 		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v4_regs_layout,
@@ -1206,8 +1173,6 @@ static const struct qmp_phy_cfg sm8250_ufsphy_cfg = {
 		.pcs		= sm8150_ufsphy_hs_g4_pcs,
 		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v4_regs_layout,
@@ -1240,8 +1205,6 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
 		.pcs		= sm8350_ufsphy_g4_pcs,
 		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v5_regs_layout,
@@ -1274,8 +1237,6 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
 		.pcs		= sm8350_ufsphy_g4_pcs,
 		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
 	},
-	.clk_list		= sm8450_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v5_regs_layout,
@@ -1296,8 +1257,6 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
 		.pcs		= sm8550_ufsphy_pcs,
 		.pcs_num	= ARRAY_SIZE(sm8550_ufsphy_pcs),
 	},
-	.clk_list		= sdm845_ufs_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v6_regs_layout,
@@ -1383,7 +1342,7 @@ static int qmp_ufs_com_init(struct qmp_ufs *qmp)
 		return ret;
 	}
 
-	ret = clk_bulk_prepare_enable(cfg->num_clks, qmp->clks);
+	ret = clk_bulk_prepare_enable(qmp->num_clks, qmp->clks);
 	if (ret)
 		goto err_disable_regulators;
 
@@ -1403,7 +1362,7 @@ static int qmp_ufs_com_exit(struct qmp_ufs *qmp)
 
 	reset_control_assert(qmp->ufs_reset);
 
-	clk_bulk_disable_unprepare(cfg->num_clks, qmp->clks);
+	clk_bulk_disable_unprepare(qmp->num_clks, qmp->clks);
 
 	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
 
@@ -1573,19 +1532,13 @@ static int qmp_ufs_vreg_init(struct qmp_ufs *qmp)
 
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


