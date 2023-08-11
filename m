Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE653778F14
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbjHKMQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbjHKMQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:16:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F652D55
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:50 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so29356301fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691756148; x=1692360948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8nXwqI/zJQHlQHw1gDfrYjoMa6W0CJJfJ5/Y0SETdxM=;
        b=HRlFdRSGiyKhCmoLXF76uoNOQv5TveVUVJj2cQCVXwucglB1p+ZNzQmoDT68m1lLgO
         HLc0qMq9+LN9QzT2xdt8givtHFxFwsnREm/umOC9nt2jwViy6MJ5tWI0wtNdnV51Ezjo
         4bBS1tx24uPfEnmqncttAjXr4XkDwFwofMTpX65rGCXWhAu1SwDhk7DM1fpravr6Q1M6
         ihD434djBSc6wHfjQZD7OW3BDdyBVBnyk0kQ3Po5ie3Aeu+cz3/blxM+QTCJy46+JVoZ
         1hSPChLCiPwBNlH59JjYzep3ucLJg6KMcoyvG3EaTOzia83u8mycgYkA4LrXN1JAtBQq
         f8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756148; x=1692360948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nXwqI/zJQHlQHw1gDfrYjoMa6W0CJJfJ5/Y0SETdxM=;
        b=azRXIhK+O8qzpwdZZ5puHoqnSBuz4bk44oBFfFmm/C8SQyMzUKAbYuoFO9M1wXL4NI
         mC/RL6LFPdSnmkJWKhZzcXqgVvCVi0yuIw3XhPdKKRN94GOyNbQ7D3cW1yPqM1F4KR8P
         XsSJPxakQNXytot98FhcJJyK7bkOff+rnuT+ea6l95wuyYExjnVoeM2nSYBOpqzuRhgT
         nR10vs+gkBTpE6xq/WAJO7/ax99i8Kr/8zefPWVRm4GKg1ygGRWc4nL/BMnO6PXmjtcw
         yplVDjEpahkJ600ARNQ+bjBANe4AU6kKesUYIZ7KiTIOg8k35MmvAerAtqXy4h2Pdo/b
         +1hA==
X-Gm-Message-State: AOJu0YzL0moSCfcyCSUUcNvFq0x3KmOOyMKQLCdjz0fVpO1GQY2zLg25
        xXENBoUaY4N5zrdmqI76ClteJg==
X-Google-Smtp-Source: AGHT+IGOQbswS1J4B+Hx8DRU/0kN+anlEImM5AO+PUeBaa5cQFBVLUH/gdpsTPI+fZ/thAj2mCmWlg==
X-Received: by 2002:a2e:7809:0:b0:2b6:e625:ba55 with SMTP id t9-20020a2e7809000000b002b6e625ba55mr1562305ljc.41.1691756148669;
        Fri, 11 Aug 2023 05:15:48 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e870c000000b002b9ec22d9fasm848487lji.29.2023.08.11.05.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:15:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 14:15:28 +0200
Subject: [PATCH 17/20] interconnect: qcom: sm8150: Retire DEFINE_QBCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_retire_macrosd-v1-17-c03aaeffc769@linaro.org>
References: <20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org>
In-Reply-To: <20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691756124; l=8486;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=b8tMoZivg7zk5LCCO+705hB94ZdyObvnU5cXTR1Pe34=;
 b=J/+GMwbfFqKy7pI0i8cVaAEXILu/2T2VB/6iiD96JiyRv/aG3/gGCnTMA8ASAA/kBsoFNaXtT
 ptcu30rm01qCPFAHfVcuBQa9QRq6bvleKx9C6DJekJEg71aGHQ/QNmk
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct definition macros are hard to read and comapre, expand them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm8150.c | 283 +++++++++++++++++++++++++++++++++----
 1 file changed, 255 insertions(+), 28 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index 17a645e3c077..c7c9cf7f746b 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -1280,34 +1280,261 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.buswidth = 8,
 };
 
-DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
-DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
-DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
-DEFINE_QBCM(bcm_mm0, "MM0", true, &qns_mem_noc_hf);
-DEFINE_QBCM(bcm_mm1, "MM1", false, &qxm_camnoc_hf0_uncomp, &qxm_camnoc_hf1_uncomp, &qxm_camnoc_sf_uncomp, &qxm_camnoc_hf0, &qxm_camnoc_hf1, &qxm_mdp0, &qxm_mdp1);
-DEFINE_QBCM(bcm_sh2, "SH2", false, &qns_gem_noc_snoc);
-DEFINE_QBCM(bcm_mm2, "MM2", false, &qxm_camnoc_sf, &qns2_mem_noc);
-DEFINE_QBCM(bcm_sh3, "SH3", false, &acm_gpu_tcu, &acm_sys_tcu);
-DEFINE_QBCM(bcm_mm3, "MM3", false, &qxm_rot, &qxm_venus0, &qxm_venus1, &qxm_venus_arm9);
-DEFINE_QBCM(bcm_sh4, "SH4", false, &qnm_cmpnoc);
-DEFINE_QBCM(bcm_sh5, "SH5", false, &acm_apps);
-DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_gemnoc_sf);
-DEFINE_QBCM(bcm_co0, "CO0", false, &qns_cdsp_mem_noc);
-DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
-DEFINE_QBCM(bcm_co1, "CO1", false, &qnm_npu);
-DEFINE_QBCM(bcm_cn0, "CN0", true, &qhm_spdm, &qnm_snoc, &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_ahb2phy_south, &qhs_aop, &qhs_aoss, &qhs_camera_cfg, &qhs_clk_ctl, &qhs_compute_dsp, &qhs_cpr_cx, &qhs_cpr_mmcx, &qhs_cpr_mx, &qhs_crypto0_cfg, &qhs_ddrss_cfg, &qhs_display_cfg, &qhs_emac_cfg, &qhs_glm, &qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_mnoc_cfg, &qhs_npu_cfg, &qhs_pcie0_cfg, &qhs_pcie1_cfg, &qhs_phy_refgen_north, &qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs_qspi, &qhs_qupv3_east, &qhs_qupv3_north, &qhs_qupv3_south, &qhs_sdc2, &qhs_sdc4, &qhs_snoc_cfg, &qhs_spdm, &qhs_spss_cfg, &qhs_ssc_cfg, &qhs_tcsr, &qhs_tlmm_east, &qhs_tlmm_north, &qhs_tlmm_south, &qhs_tlmm_west, &qhs_tsif, &qhs_ufs_card_cfg, &qhs_ufs_mem_cfg, &qhs_usb3_0, &qhs_usb3_1, &qhs_venus_cfg, &qhs_vsense_ctrl_cfg, &qns_cnoc_a2noc, &srvc_cnoc);
-DEFINE_QBCM(bcm_qup0, "QUP0", false, &qhm_qup0, &qhm_qup1, &qhm_qup2);
-DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_gemnoc_gc);
-DEFINE_QBCM(bcm_sn3, "SN3", false, &srvc_aggre1_noc, &srvc_aggre2_noc, &qns_cnoc);
-DEFINE_QBCM(bcm_sn4, "SN4", false, &qxs_pimem);
-DEFINE_QBCM(bcm_sn5, "SN5", false, &xs_qdss_stm);
-DEFINE_QBCM(bcm_sn8, "SN8", false, &xs_pcie_0, &xs_pcie_1);
-DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_aggre1_noc);
-DEFINE_QBCM(bcm_sn11, "SN11", false, &qnm_aggre2_noc);
-DEFINE_QBCM(bcm_sn12, "SN12", false, &qxm_pimem, &xm_gic);
-DEFINE_QBCM(bcm_sn14, "SN14", false, &qns_pcie_mem_noc);
-DEFINE_QBCM(bcm_sn15, "SN15", false, &qnm_gemnoc);
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_mm0 = {
+	.name = "MM0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.keepalive = false,
+	.num_nodes = 7,
+	.nodes = { &qxm_camnoc_hf0_uncomp,
+		   &qxm_camnoc_hf1_uncomp,
+		   &qxm_camnoc_sf_uncomp,
+		   &qxm_camnoc_hf0,
+		   &qxm_camnoc_hf1,
+		   &qxm_mdp0,
+		   &qxm_mdp1
+	},
+};
+
+static struct qcom_icc_bcm bcm_sh2 = {
+	.name = "SH2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_gem_noc_snoc },
+};
+
+static struct qcom_icc_bcm bcm_mm2 = {
+	.name = "MM2",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qxm_camnoc_sf, &qns2_mem_noc },
+};
+
+static struct qcom_icc_bcm bcm_sh3 = {
+	.name = "SH3",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &acm_gpu_tcu, &acm_sys_tcu },
+};
+
+static struct qcom_icc_bcm bcm_mm3 = {
+	.name = "MM3",
+	.keepalive = false,
+	.num_nodes = 4,
+	.nodes = { &qxm_rot, &qxm_venus0, &qxm_venus1, &qxm_venus_arm9 },
+};
+
+static struct qcom_icc_bcm bcm_sh4 = {
+	.name = "SH4",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_cmpnoc },
+};
+
+static struct qcom_icc_bcm bcm_sh5 = {
+	.name = "SH5",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &acm_apps },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_co0 = {
+	.name = "CO0",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_cdsp_mem_noc },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxs_imem },
+};
+
+static struct qcom_icc_bcm bcm_co1 = {
+	.name = "CO1",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_npu },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.num_nodes = 53,
+	.nodes = { &qhm_spdm,
+		   &qnm_snoc,
+		   &qhs_a1_noc_cfg,
+		   &qhs_a2_noc_cfg,
+		   &qhs_ahb2phy_south,
+		   &qhs_aop,
+		   &qhs_aoss,
+		   &qhs_camera_cfg,
+		   &qhs_clk_ctl,
+		   &qhs_compute_dsp,
+		   &qhs_cpr_cx,
+		   &qhs_cpr_mmcx,
+		   &qhs_cpr_mx,
+		   &qhs_crypto0_cfg,
+		   &qhs_ddrss_cfg,
+		   &qhs_display_cfg,
+		   &qhs_emac_cfg,
+		   &qhs_glm,
+		   &qhs_gpuss_cfg,
+		   &qhs_imem_cfg,
+		   &qhs_ipa,
+		   &qhs_mnoc_cfg,
+		   &qhs_npu_cfg,
+		   &qhs_pcie0_cfg,
+		   &qhs_pcie1_cfg,
+		   &qhs_phy_refgen_north,
+		   &qhs_pimem_cfg,
+		   &qhs_prng,
+		   &qhs_qdss_cfg,
+		   &qhs_qspi,
+		   &qhs_qupv3_east,
+		   &qhs_qupv3_north,
+		   &qhs_qupv3_south,
+		   &qhs_sdc2,
+		   &qhs_sdc4,
+		   &qhs_snoc_cfg,
+		   &qhs_spdm,
+		   &qhs_spss_cfg,
+		   &qhs_ssc_cfg,
+		   &qhs_tcsr,
+		   &qhs_tlmm_east,
+		   &qhs_tlmm_north,
+		   &qhs_tlmm_south,
+		   &qhs_tlmm_west,
+		   &qhs_tsif,
+		   &qhs_ufs_card_cfg,
+		   &qhs_ufs_mem_cfg,
+		   &qhs_usb3_0,
+		   &qhs_usb3_1,
+		   &qhs_venus_cfg,
+		   &qhs_vsense_ctrl_cfg,
+		   &qns_cnoc_a2noc,
+		   &srvc_cnoc
+	},
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = false,
+	.num_nodes = 3,
+	.nodes = { &qhm_qup0, &qhm_qup1, &qhm_qup2 },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_gc },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.keepalive = false,
+	.num_nodes = 3,
+	.nodes = { &srvc_aggre1_noc, &srvc_aggre2_noc, &qns_cnoc },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxs_pimem },
+};
+
+static struct qcom_icc_bcm bcm_sn5 = {
+	.name = "SN5",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &xs_qdss_stm },
+};
+
+static struct qcom_icc_bcm bcm_sn8 = {
+	.name = "SN8",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &xs_pcie_0, &xs_pcie_1 },
+};
+
+static struct qcom_icc_bcm bcm_sn9 = {
+	.name = "SN9",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn11 = {
+	.name = "SN11",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn12 = {
+	.name = "SN12",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qxm_pimem, &xm_gic },
+};
+
+static struct qcom_icc_bcm bcm_sn14 = {
+	.name = "SN14",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_pcie_mem_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn15 = {
+	.name = "SN15",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_gemnoc },
+};
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_qup0,

-- 
2.41.0

