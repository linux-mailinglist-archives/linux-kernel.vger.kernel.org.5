Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1BA778F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbjHKMRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbjHKMQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:16:34 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22A630DA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:16:02 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so30499191fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691756150; x=1692360950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VsLQSDJTgCDn8Hhe67TADtfW4JIZVp51SQabtOzna8=;
        b=p6J7HvHE/Dll6tRtJdrljych+lXOPN5l239mYP4MmX/wO9h/v4a0NqXKwDF473FStN
         MsfeI9LSdY7JN0EY2aOr3NzQhdr5uaDxgOJiC3ocdx0UcvZYJX9N6QQKW8nMFPr1YNqN
         E1mm2DXK0wZhXV+w4W1vp89A1GYVB0HZuur1YvAZJ6Sy6SlBuoyLXzoiGgOMG1zGTh6j
         00kSWJuifViDTV3I4QA+M0eVSHwGUc2XuPIvYvQdx6pqsxzyTjqqgEnWeELrqgIvLjAT
         tPzho6EV5//HnRWhJO61X/Klaxy4vnjr0lBRO007D8De1gbRp8sP2wSsXICqRtbeNMsy
         0CUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756150; x=1692360950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VsLQSDJTgCDn8Hhe67TADtfW4JIZVp51SQabtOzna8=;
        b=Vp3X6tL1I9P0774aI45ziLrmTf/7lyviZdrHzcfspSMmKK+rjZZj6iHIWH0EgfnOP7
         /Ki/2xopX3L3IBR2HpnZAYhNH2ahfccshdCJbfYs17lpYN9zoOzqjWSPZl5mnpbsxsTm
         /mLdlIb9GiXsCJCW6RwmjM0OLNIsIkMk61fckYMLU7YRSnwNoRFTuXNHioUCjELCNzdE
         6zGpWsLj3Wp59vWuwXEsYo8YiJ1yD+utmKsWoTL43YnHq0P0FKLlB7vTWIVA02Qi9EKl
         rb1hV99GNaOyYBIGaGLnF2SlcwiQjf4VuCy5K33NUddGYHJWgxldw2P4861U6NbK1KJS
         mG0Q==
X-Gm-Message-State: AOJu0YzVxwHM5ahDx1+P7oGuHQh8Bj+hY5rGpe/BWK87SOa7Z5quHvJB
        Ec9uofjy6ppIESeKsw1MFHKAkw==
X-Google-Smtp-Source: AGHT+IGvuW1ohI4axqpY/XTj6eldoKqI2U4Bfu9vVDFsCiZZAn9HWRl3wsmoWI+Z5Cc7JaVj6HBecg==
X-Received: by 2002:a2e:9d59:0:b0:2b7:2ea:33c9 with SMTP id y25-20020a2e9d59000000b002b702ea33c9mr1578918ljj.20.1691756149906;
        Fri, 11 Aug 2023 05:15:49 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e870c000000b002b9ec22d9fasm848487lji.29.2023.08.11.05.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:15:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 14:15:29 +0200
Subject: [PATCH 18/20] interconnect: qcom: sm8250: Retire DEFINE_QBCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_retire_macrosd-v1-18-c03aaeffc769@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691756124; l=8008;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=A4ec5VzKAtEVsV4Rwvxv+zSQFZelpm2bJaI9CKFJvPA=;
 b=ne2k9T+zja68w0N93FA/i3aOf9Y8fMxzxC3XkVbTHsixLkcNWpp8QPOnie1Ll/SIIQ9hn4h+Y
 +HfkX/0dfZvAOf75amDcFRwfmKZLXQX0qWg6+S4LWvU5OAQ1AZHT1Io
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
 drivers/interconnect/qcom/sm8250.c | 267 +++++++++++++++++++++++++++++++++----
 1 file changed, 240 insertions(+), 27 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index f218a7c1d7a6..d4a4ecef11f0 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -1395,33 +1395,246 @@ static struct qcom_icc_node qup2_core_slave = {
 	.buswidth = 4,
 };
 
-DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
-DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
-DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
-DEFINE_QBCM(bcm_mm0, "MM0", true, &qns_mem_noc_hf);
-DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_mm1, "MM1", false, &qnm_camnoc_hf, &qxm_mdp0, &qxm_mdp1);
-DEFINE_QBCM(bcm_sh2, "SH2", false, &alm_gpu_tcu, &alm_sys_tcu);
-DEFINE_QBCM(bcm_mm2, "MM2", false, &qns_mem_noc_sf);
-DEFINE_QBCM(bcm_qup0, "QUP0", false, &qup0_core_master, &qup1_core_master, &qup2_core_master);
-DEFINE_QBCM(bcm_sh3, "SH3", false, &qnm_cmpnoc);
-DEFINE_QBCM(bcm_mm3, "MM3", false, &qnm_camnoc_icp, &qnm_camnoc_sf, &qnm_video0, &qnm_video1, &qnm_video_cvp);
-DEFINE_QBCM(bcm_sh4, "SH4", false, &chm_apps);
-DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_gemnoc_sf);
-DEFINE_QBCM(bcm_co0, "CO0", false, &qns_cdsp_mem_noc);
-DEFINE_QBCM(bcm_cn0, "CN0", true, &qnm_snoc, &xm_qdss_dap, &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_ahb2phy0, &qhs_ahb2phy1, &qhs_aoss, &qhs_camera_cfg, &qhs_clk_ctl, &qhs_compute_dsp, &qhs_cpr_cx, &qhs_cpr_mmcx, &qhs_cpr_mx, &qhs_crypto0_cfg, &qhs_cx_rdpm, &qhs_dcc_cfg, &qhs_ddrss_cfg, &qhs_display_cfg, &qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_ipc_router, &qhs_lpass_cfg, &qhs_mnoc_cfg, &qhs_npu_cfg, &qhs_pcie0_cfg, &qhs_pcie1_cfg, &qhs_pcie_modem_cfg, &qhs_pdm, &qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs_qspi, &qhs_qup0, &qhs_qup1, &qhs_qup2, &qhs_sdc2, &qhs_sdc4, &qhs_snoc_cfg, &qhs_tcsr, &qhs_tlmm0, &qhs_tlmm1, &qhs_tlmm2, &qhs_tsif, &qhs_ufs_card_cfg, &qhs_ufs_mem_cfg, &qhs_usb3_0, &qhs_usb3_1, &qhs_venus_cfg, &qhs_vsense_ctrl_cfg, &qns_cnoc_a2noc, &srvc_cnoc);
-DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
-DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_gemnoc_gc);
-DEFINE_QBCM(bcm_co2, "CO2", false, &qnm_npu);
-DEFINE_QBCM(bcm_sn3, "SN3", false, &qxs_pimem);
-DEFINE_QBCM(bcm_sn4, "SN4", false, &xs_qdss_stm);
-DEFINE_QBCM(bcm_sn5, "SN5", false, &xs_pcie_modem);
-DEFINE_QBCM(bcm_sn6, "SN6", false, &xs_pcie_0, &xs_pcie_1);
-DEFINE_QBCM(bcm_sn7, "SN7", false, &qnm_aggre1_noc);
-DEFINE_QBCM(bcm_sn8, "SN8", false, &qnm_aggre2_noc);
-DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_gemnoc_pcie);
-DEFINE_QBCM(bcm_sn11, "SN11", false, &qnm_gemnoc);
-DEFINE_QBCM(bcm_sn12, "SN12", false, &qns_pcie_modem_mem_noc, &qns_pcie_mem_noc);
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
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.keepalive = false,
+	.num_nodes = 3,
+	.nodes = { &qnm_camnoc_hf, &qxm_mdp0, &qxm_mdp1 },
+};
+
+static struct qcom_icc_bcm bcm_sh2 = {
+	.name = "SH2",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &alm_gpu_tcu, &alm_sys_tcu },
+};
+
+static struct qcom_icc_bcm bcm_mm2 = {
+	.name = "MM2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = false,
+	.num_nodes = 3,
+	.nodes = { &qup0_core_master, &qup1_core_master, &qup2_core_master },
+};
+
+static struct qcom_icc_bcm bcm_sh3 = {
+	.name = "SH3",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_cmpnoc },
+};
+
+static struct qcom_icc_bcm bcm_mm3 = {
+	.name = "MM3",
+	.keepalive = false,
+	.num_nodes = 5,
+	.nodes = { &qnm_camnoc_icp, &qnm_camnoc_sf, &qnm_video0, &qnm_video1, &qnm_video_cvp },
+};
+
+static struct qcom_icc_bcm bcm_sh4 = {
+	.name = "SH4",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &chm_apps },
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
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.num_nodes = 52,
+	.nodes = { &qnm_snoc,
+		   &xm_qdss_dap,
+		   &qhs_a1_noc_cfg,
+		   &qhs_a2_noc_cfg,
+		   &qhs_ahb2phy0,
+		   &qhs_ahb2phy1,
+		   &qhs_aoss,
+		   &qhs_camera_cfg,
+		   &qhs_clk_ctl,
+		   &qhs_compute_dsp,
+		   &qhs_cpr_cx,
+		   &qhs_cpr_mmcx,
+		   &qhs_cpr_mx,
+		   &qhs_crypto0_cfg,
+		   &qhs_cx_rdpm,
+		   &qhs_dcc_cfg,
+		   &qhs_ddrss_cfg,
+		   &qhs_display_cfg,
+		   &qhs_gpuss_cfg,
+		   &qhs_imem_cfg,
+		   &qhs_ipa,
+		   &qhs_ipc_router,
+		   &qhs_lpass_cfg,
+		   &qhs_mnoc_cfg,
+		   &qhs_npu_cfg,
+		   &qhs_pcie0_cfg,
+		   &qhs_pcie1_cfg,
+		   &qhs_pcie_modem_cfg,
+		   &qhs_pdm,
+		   &qhs_pimem_cfg,
+		   &qhs_prng,
+		   &qhs_qdss_cfg,
+		   &qhs_qspi,
+		   &qhs_qup0,
+		   &qhs_qup1,
+		   &qhs_qup2,
+		   &qhs_sdc2,
+		   &qhs_sdc4,
+		   &qhs_snoc_cfg,
+		   &qhs_tcsr,
+		   &qhs_tlmm0,
+		   &qhs_tlmm1,
+		   &qhs_tlmm2,
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
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxs_imem },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_gc },
+};
+
+static struct qcom_icc_bcm bcm_co2 = {
+	.name = "CO2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_npu },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxs_pimem },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &xs_qdss_stm },
+};
+
+static struct qcom_icc_bcm bcm_sn5 = {
+	.name = "SN5",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &xs_pcie_modem },
+};
+
+static struct qcom_icc_bcm bcm_sn6 = {
+	.name = "SN6",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &xs_pcie_0, &xs_pcie_1 },
+};
+
+static struct qcom_icc_bcm bcm_sn7 = {
+	.name = "SN7",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn8 = {
+	.name = "SN8",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn9 = {
+	.name = "SN9",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_gemnoc_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn11 = {
+	.name = "SN11",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_gemnoc },
+};
+
+static struct qcom_icc_bcm bcm_sn12 = {
+	.name = "SN12",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qns_pcie_modem_mem_noc, &qns_pcie_mem_noc },
+};
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_sn12,

-- 
2.41.0

