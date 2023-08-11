Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98708778F21
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbjHKMQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbjHKMQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:16:02 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72E1358E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:45 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so28803521fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691756144; x=1692360944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5qOrJnvbfwQelT0VAreE8SweqQH8vkuH8EWGhMm474=;
        b=bcc/9QE4P9BTWYMVRG4JA6Eu6zCfLY3biknjjLMLqzni6Fyl3HmIsTu0ZaxIFk4NyD
         OEBvLRaF+IeO9JzZWXa0El2gAIxHvy+xIv9ISSDQuGBmGdpQzxUlx/YBUf8AzrGYmHcp
         74OFIXJDU8O4mK56gMrBBBQMnUTVEekAv8fkSi/By6RDh9YotZqJFgZhDHC+sskoc3bF
         XfpGwV0izQ40NSs9ELa0oLNjLr99iLuvRQMf94gSTxDqcx8VKmvjR+e4bzYmubOlY1Rs
         wyWXg9Dl7QBqNkdyKFNZVogr4XBKYeCoqw2eTawcUG50b2sb9udslTjzaUuU+M+AAKOY
         7I8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756144; x=1692360944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5qOrJnvbfwQelT0VAreE8SweqQH8vkuH8EWGhMm474=;
        b=fvUuI85KbTa5wVdpAN3CZuoWMYDcSqDSsVGqtmnt4Y0QpPWH8i8/j3JK0UsngXHtrk
         0L7aY5lI8Rgv6bYdQEzvqx65j9WeZJoA5xrT51lNgQGwXeR7bKOa73YrBu/Enkqu13pe
         GVo25cGa2o+md2Nj9VP8acbHuNizaWicRqMVKrzzSNa43HMfHQ1CZ9pLkH/JSdMAtabB
         NYSCKHCsfOavuMq93u1waP9YDd5qhBCVJrDTIL0Y4AE2laIK308sp1NTOHI32RVAUTPu
         lG4BcXqkf4mSay/bYofepcOcmKUNY78k5zp3r/LtJEX9GALsn+D+Oxu3BRGh02TId4d1
         kDeg==
X-Gm-Message-State: AOJu0YzRNOBJZrfpo2UwnN90AjnhXMrbjNu1XHkHfdrVdp5gplQoOdWv
        ewKENwLVj/lksD+LT872jA+dM/aMpuFDQ1/4yso=
X-Google-Smtp-Source: AGHT+IH2yuhLCWCHKRQuRQmQzpxxDpiECZb3pdRuWCJBzwyIjl2X5N6ABRj+n3q7HBMgm026Oj4TQg==
X-Received: by 2002:a2e:9783:0:b0:2b4:6d59:7863 with SMTP id y3-20020a2e9783000000b002b46d597863mr1445784lji.25.1691756143833;
        Fri, 11 Aug 2023 05:15:43 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e870c000000b002b9ec22d9fasm848487lji.29.2023.08.11.05.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:15:43 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 14:15:24 +0200
Subject: [PATCH 13/20] interconnect: qcom: sdm845: Retire DEFINE_QBCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_retire_macrosd-v1-13-c03aaeffc769@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691756124; l=8237;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=q8HkJmI77QA8ncuqsyCIOznHdhkyEYBI+vqiqXl6piU=;
 b=5aBqwP3wuvgdofVDkswValfSbLgedegKFUl/Dy+kKNPV0GSbleZWAmpM2JEcgWsebQm/zwxJ/
 9sgzUJElukEBL5lS6hLk/XUxjCo3oKLRTXXu9gO1S4D/n1xpniVHHGm
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
 drivers/interconnect/qcom/sdm845.c | 277 +++++++++++++++++++++++++++++++++----
 1 file changed, 249 insertions(+), 28 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 2b5067eebd8b..b9243c0aa626 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -1263,34 +1263,255 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.buswidth = 8,
 };
 
-DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
-DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
-DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
-DEFINE_QBCM(bcm_mm0, "MM0", false, &qns_mem_noc_hf);
-DEFINE_QBCM(bcm_sh1, "SH1", false, &qns_apps_io);
-DEFINE_QBCM(bcm_mm1, "MM1", true, &qxm_camnoc_hf0_uncomp, &qxm_camnoc_hf1_uncomp, &qxm_camnoc_sf_uncomp, &qxm_camnoc_hf0, &qxm_camnoc_hf1, &qxm_mdp0, &qxm_mdp1);
-DEFINE_QBCM(bcm_sh2, "SH2", false, &qns_memnoc_snoc);
-DEFINE_QBCM(bcm_mm2, "MM2", false, &qns2_mem_noc);
-DEFINE_QBCM(bcm_sh3, "SH3", false, &acm_tcu);
-DEFINE_QBCM(bcm_mm3, "MM3", false, &qxm_camnoc_sf, &qxm_rot, &qxm_venus0, &qxm_venus1, &qxm_venus_arm9);
-DEFINE_QBCM(bcm_sh5, "SH5", false, &qnm_apps);
-DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_memnoc_sf);
-DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_cn0, "CN0", false, &qhm_spdm, &qhm_tic, &qnm_snoc, &xm_qdss_dap, &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_aop, &qhs_aoss, &qhs_camera_cfg, &qhs_clk_ctl, &qhs_compute_dsp_cfg, &qhs_cpr_cx, &qhs_crypto0_cfg, &qhs_dcc_cfg, &qhs_ddrss_cfg, &qhs_display_cfg, &qhs_glm, &qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_mnoc_cfg, &qhs_pcie0_cfg, &qhs_pcie_gen3_cfg, &qhs_pdm, &qhs_phy_refgen_south, &qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs_qupv3_north, &qhs_qupv3_south, &qhs_sdc2, &qhs_sdc4, &qhs_snoc_cfg, &qhs_spdm, &qhs_spss_cfg, &qhs_tcsr, &qhs_tlmm_north, &qhs_tlmm_south, &qhs_tsif, &qhs_ufs_card_cfg, &qhs_ufs_mem_cfg, &qhs_usb3_0, &qhs_usb3_1, &qhs_venus_cfg, &qhs_vsense_ctrl_cfg, &qns_cnoc_a2noc, &srvc_cnoc);
-DEFINE_QBCM(bcm_qup0, "QUP0", false, &qhm_qup1, &qhm_qup2);
-DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
-DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_memnoc_gc);
-DEFINE_QBCM(bcm_sn3, "SN3", false, &qns_cnoc);
-DEFINE_QBCM(bcm_sn4, "SN4", false, &qxm_pimem);
-DEFINE_QBCM(bcm_sn5, "SN5", false, &xs_qdss_stm);
-DEFINE_QBCM(bcm_sn6, "SN6", false, &qhs_apss, &srvc_snoc, &xs_sys_tcu_cfg);
-DEFINE_QBCM(bcm_sn7, "SN7", false, &qxs_pcie);
-DEFINE_QBCM(bcm_sn8, "SN8", false, &qxs_pcie_gen3);
-DEFINE_QBCM(bcm_sn9, "SN9", false, &srvc_aggre1_noc, &qnm_aggre1_noc);
-DEFINE_QBCM(bcm_sn11, "SN11", false, &srvc_aggre2_noc, &qnm_aggre2_noc);
-DEFINE_QBCM(bcm_sn12, "SN12", false, &qnm_gladiator_sodv, &xm_gic);
-DEFINE_QBCM(bcm_sn14, "SN14", false, &qnm_pcie_anoc);
-DEFINE_QBCM(bcm_sn15, "SN15", false, &qnm_memnoc);
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
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_bcm bcm_sh1 = {
+	.name = "SH1",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_apps_io },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.keepalive = true,
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
+	.nodes = { &qns_memnoc_snoc },
+};
+
+static struct qcom_icc_bcm bcm_mm2 = {
+	.name = "MM2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns2_mem_noc },
+};
+
+static struct qcom_icc_bcm bcm_sh3 = {
+	.name = "SH3",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &acm_tcu },
+};
+
+static struct qcom_icc_bcm bcm_mm3 = {
+	.name = "MM3",
+	.keepalive = false,
+	.num_nodes = 5,
+	.nodes = { &qxm_camnoc_sf, &qxm_rot, &qxm_venus0, &qxm_venus1, &qxm_venus_arm9 },
+};
+
+static struct qcom_icc_bcm bcm_sh5 = {
+	.name = "SH5",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_apps },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_memnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = false,
+	.num_nodes = 47,
+	.nodes = { &qhm_spdm,
+		   &qhm_tic,
+		   &qnm_snoc,
+		   &xm_qdss_dap,
+		   &qhs_a1_noc_cfg,
+		   &qhs_a2_noc_cfg,
+		   &qhs_aop,
+		   &qhs_aoss,
+		   &qhs_camera_cfg,
+		   &qhs_clk_ctl,
+		   &qhs_compute_dsp_cfg,
+		   &qhs_cpr_cx,
+		   &qhs_crypto0_cfg,
+		   &qhs_dcc_cfg,
+		   &qhs_ddrss_cfg,
+		   &qhs_display_cfg,
+		   &qhs_glm,
+		   &qhs_gpuss_cfg,
+		   &qhs_imem_cfg,
+		   &qhs_ipa,
+		   &qhs_mnoc_cfg,
+		   &qhs_pcie0_cfg,
+		   &qhs_pcie_gen3_cfg,
+		   &qhs_pdm,
+		   &qhs_phy_refgen_south,
+		   &qhs_pimem_cfg,
+		   &qhs_prng,
+		   &qhs_qdss_cfg,
+		   &qhs_qupv3_north,
+		   &qhs_qupv3_south,
+		   &qhs_sdc2,
+		   &qhs_sdc4,
+		   &qhs_snoc_cfg,
+		   &qhs_spdm,
+		   &qhs_spss_cfg,
+		   &qhs_tcsr,
+		   &qhs_tlmm_north,
+		   &qhs_tlmm_south,
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
+	.num_nodes = 2,
+	.nodes = { &qhm_qup1, &qhm_qup2 },
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
+	.nodes = { &qns_memnoc_gc },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_cnoc },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxm_pimem },
+};
+
+static struct qcom_icc_bcm bcm_sn5 = {
+	.name = "SN5",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &xs_qdss_stm },
+};
+
+static struct qcom_icc_bcm bcm_sn6 = {
+	.name = "SN6",
+	.keepalive = false,
+	.num_nodes = 3,
+	.nodes = { &qhs_apss, &srvc_snoc, &xs_sys_tcu_cfg },
+};
+
+static struct qcom_icc_bcm bcm_sn7 = {
+	.name = "SN7",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxs_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn8 = {
+	.name = "SN8",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxs_pcie_gen3 },
+};
+
+static struct qcom_icc_bcm bcm_sn9 = {
+	.name = "SN9",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &srvc_aggre1_noc, &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn11 = {
+	.name = "SN11",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &srvc_aggre2_noc, &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn12 = {
+	.name = "SN12",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qnm_gladiator_sodv, &xm_gic },
+};
+
+static struct qcom_icc_bcm bcm_sn14 = {
+	.name = "SN14",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_pcie_anoc },
+};
+
+static struct qcom_icc_bcm bcm_sn15 = {
+	.name = "SN15",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_memnoc },
+};
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_sn9,

-- 
2.41.0

