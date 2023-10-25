Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2060B7D6373
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjJYHhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjJYHgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:36:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68996171A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:34:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32da7ac5c4fso3555834f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219275; x=1698824075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toDAK10JFSwHPkulesZe8HTy28t6EZTKIHYym2YrLGE=;
        b=vDDhoi+ijpsKz0qvXxt9h/irHHpkllkfGARuJUKZm4Nscu/RbSmCyWnzKRfT14wm0i
         q3dPoCi/HOG8pTMKm3ljTJmNK2rnmyUw+indMoE4AeR9EfiMxn3fS0eVuJtS/CjKlH2a
         sNxbWN3xKHT7Q2SBxYcET1iFxR5Iq+BrOz9gY1j41DLEgNaGQ2wEzcvHta7nK0gBpej0
         tkQdIt/c1F4/MS9SwOgXYUfc9dwVIl1R2781dA7JedE6CSMfUPVjfsq9+Zqjw2X6Fufc
         IziItyUVavN9I/KvAJks1hwOSZyFA/agjohsxV1p/a4XJFAiYTC6lsFVUQXrE0fhrxIN
         MLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219275; x=1698824075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toDAK10JFSwHPkulesZe8HTy28t6EZTKIHYym2YrLGE=;
        b=K+s/b2JGdv1CsU367gdQOTagpDs9UakldWlBmkCSlF6sJnDcoh+1SkSqCHKKUu6LJi
         +Aie6XTvt+5hm2jajpaUt+AmFY6ix9Ij9+60CnUC0U6qPpFxXET+9GIkx06JIgd6CKW5
         +xmAJz3EVWw3lECstIikdYOjwPkczzScRAUP3/cKWNGhsAZ2NRLZuu7hgMi5/gnLEdeC
         mxiL6PhkVOK0buPwQXmcNbv13Gj3gwfavmUIf6DFe02NzrPxWl5LFzwAgxubVJKoxi/x
         cw0qj0dP3dgWmlTlo7Sq7bTUbJBeo2rwTiDG+7460mgSsgBeKXhir5nki6jvUWRPHYMt
         kUkw==
X-Gm-Message-State: AOJu0Yw7+AdsOwQZpe51j8OG/VSt5r5jZYVnFBwt76t5zOcQP9i+1R0J
        U4detM5fd0JcNM5GqZ4SD9L2DA==
X-Google-Smtp-Source: AGHT+IG4JJPR0NVKvViSjXPwupCEOZkaWWtKLYCtu/+s59YBq76D1GEVXviCNNAR8F9dlm6E4JcvzA==
X-Received: by 2002:adf:e40e:0:b0:32d:a310:cc2a with SMTP id g14-20020adfe40e000000b0032da310cc2amr9688667wrm.23.1698219275657;
        Wed, 25 Oct 2023 00:34:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d4ac7000000b0032dde679398sm11431392wrs.8.2023.10.25.00.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:34:35 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:34:28 +0200
Subject: [PATCH 6/7] phy: qcom: qmp-pcie: add QMP PCIe PHY tables for
 SM8650
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-phy-v1-6-6137101520c4@linaro.org>
References: <20231025-topic-sm8650-upstream-phy-v1-0-6137101520c4@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-phy-v1-0-6137101520c4@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4346;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jEiylMQ86A3JRCyG8A6COHqo4G+yx8E7uU5kScEEk/w=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMUDvUJPjVZf06ZspRkDmXm4LKb1auDEcX2i2uem
 Y+NGsdaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjFAwAKCRB33NvayMhJ0bE+D/
 9wwT2fREfhjQd7Wc2H+Np1y7dzjR9he9ZM5IkCUzs3Aly5U8fzLZgUs3bebx+g7cvJ1iKDXSPqMezA
 ABFe1hp3K6u5ZCxJNgRf/Dxkua6n8rbVwp53Eh3gqBSGw/63kuPdoIJTTJPSCoHOf2Eqm2v24KPQfI
 CWhzjQQVTCQnw+CPiniNTfou+AZKnjj7fwyD9MrVqelJMAQWoUoA8JcfuxHf4yUhhZFIDC+CVhsToe
 +tmlG4e0KBH2Yaz/VaSWNq1DXxNTeA2cXs67SbD5/CoaMcdQaQ8WCQIR7R/q4QMCDLmvJQLLp3efr2
 E8m04OB5wzM+8cpwbeBK9eBbzusczxPxnEuG7OWE1UwLJYDfasmHbNfjVb8tFcmttt2G0WOB4EISQx
 5tXoc9Zw4YVot8gUyCYiX0QH2UJ4OpaXj6fjCFYnGOacgnIntUfMMBAfr5sxoD4leHP4sQm3iFc5pT
 XAPFCagrO72PrKVC7c8mSeeQ6YPQcebYK36euulYSCD7aVhYeKbfKMVCld6g/DhpvSnNpo3/gmSKLw
 nA8kHc8qCd9lUcHPuIr2MQCnwOLU/f2I6Vc2/dUV5Z9h6yLjLC/IrIoLDopiNnfjqEQfk3Axbkz4re
 DQ9YIp20qXqr0FWUqMlICOCvEleQauIS32hYZ/50qTgNQyx4ocoVhZgnCklw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add QMP PCIe PHY support for the SM8650 platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 65 ++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index b64598ac59f4..2af7115ef968 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1909,6 +1909,35 @@ static const struct qmp_phy_init_tbl sm8550_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G4_FOM_EQ_CONFIG5, 0xf2),
 };
 
+static const struct qmp_phy_init_tbl sm8650_qmp_gen4x2_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_2, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_3, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_PI_CONTROLS, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE3, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_IVCM_CAL_CTRL2, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_3, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_VGA_CAL_MAN_VAL, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_GM_CAL, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_EQU_ADAPTOR_CNTRL4, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_SIGDET_ENABLES, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_PHPRE_CTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B0, 0xd3),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B1, 0xd3),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B3, 0x9a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B4, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B5, 0xb6),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B6, 0xee),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B0, 0x23),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B1, 0x9b),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B2, 0x60),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B3, 0xdf),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B4, 0x43),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B5, 0x76),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B6, 0xff),
+};
+
 static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x2_pcie_serdes_alt_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_IVCO, 0x0f),
@@ -3047,6 +3076,36 @@ static const struct qmp_phy_cfg sm8550_qmp_gen4x2_pciephy_cfg = {
 	.has_nocsr_reset	= true,
 };
 
+static const struct qmp_phy_cfg sm8650_qmp_gen4x2_pciephy_cfg = {
+	.lanes = 2,
+
+	.offsets		= &qmp_pcie_offsets_v6_20,
+
+	.tbls = {
+		.serdes			= sm8550_qmp_gen4x2_pcie_serdes_tbl,
+		.serdes_num		= ARRAY_SIZE(sm8550_qmp_gen4x2_pcie_serdes_tbl),
+		.tx			= sm8550_qmp_gen4x2_pcie_tx_tbl,
+		.tx_num			= ARRAY_SIZE(sm8550_qmp_gen4x2_pcie_tx_tbl),
+		.rx			= sm8650_qmp_gen4x2_pcie_rx_tbl,
+		.rx_num			= ARRAY_SIZE(sm8650_qmp_gen4x2_pcie_rx_tbl),
+		.pcs			= sm8550_qmp_gen4x2_pcie_pcs_tbl,
+		.pcs_num		= ARRAY_SIZE(sm8550_qmp_gen4x2_pcie_pcs_tbl),
+		.pcs_misc		= sm8550_qmp_gen4x2_pcie_pcs_misc_tbl,
+		.pcs_misc_num		= ARRAY_SIZE(sm8550_qmp_gen4x2_pcie_pcs_misc_tbl),
+		.ln_shrd		= sm8550_qmp_gen4x2_pcie_ln_shrd_tbl,
+		.ln_shrd_num		= ARRAY_SIZE(sm8550_qmp_gen4x2_pcie_ln_shrd_tbl),
+	},
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= sm8550_qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(sm8550_qmp_phy_vreg_l),
+	.regs			= pciephy_v5_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS_4_20,
+	.has_nocsr_reset	= true,
+};
+
 static const struct qmp_phy_cfg sa8775p_qmp_gen4x2_pciephy_cfg = {
 	.lanes			= 2,
 	.offsets		= &qmp_pcie_offsets_v5_20,
@@ -3820,6 +3879,12 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm8550-qmp-gen4x2-pcie-phy",
 		.data = &sm8550_qmp_gen4x2_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sm8650-qmp-gen3x2-pcie-phy",
+		.data = &sm8550_qmp_gen3x2_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sm8650-qmp-gen4x2-pcie-phy",
+		.data = &sm8650_qmp_gen4x2_pciephy_cfg,
 	},
 	{ },
 };

-- 
2.34.1

