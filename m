Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BC0778EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjHKMPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjHKMPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:15:35 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B94BE55
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:33 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so29312941fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691756131; x=1692360931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8nkAfO+Ll1Xz6XrA+AAXfv+x4jIbPO7zsJOGjvxObNw=;
        b=Zp2pJFgMV4eJwHU66m7Anln5kt8BLBicCHghhg/QoMmNhNjjeqbrzrvnUpzy93C5Dp
         0Az4ISIH5G7SZxeGUKB5E/5JCeD3Cvml7FRZjNLufJZjpxWzutfgEaYjqwXpX5v1e9R/
         raBHvVegwkgyg+FXhwUJiV55CTZ8YjjXTXa20sDjE0veve9AuwP2ziITShQh3FX97FtR
         2G7/XLSHcBABZphpZRT1sEvko/J16enOoUU6Waa8Gx4T7Fn9J04iltgfzaCIw1owJswg
         7PFkS/NV0yBSJsYqHS8vkKwAJpqWutEJBBsbw62JjUO0noAOcjreVEKADkqZn6l2QHwc
         baRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756131; x=1692360931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nkAfO+Ll1Xz6XrA+AAXfv+x4jIbPO7zsJOGjvxObNw=;
        b=VHsZ+qftm624mXh3EnwWmsHb54GgYZ63u/TcqiapD4dxXftCHjFCaLjfG7pdpwLv+9
         TtvfMlaiLDTORuc6SR1HVv0G4z9G8Ou3Kd+V/PRCRuNXh8fVC5ql+qYAHUQWLg6TVWRz
         HKkaIikwz/Ci1oNQutvk23gANE/3rrIbrjII6VdQXR8t5sa+Xv9wVbsiE5+3ueWFvKKl
         7N16yUVUDdyfN4CEbxL1jvBgDFPpCjVwMXGcJIDl7RBASZ0lvoquZwT+f7YKKvUeaOV0
         d0Nd01jS89skGV7n2Or5kGibV0FluwhXtdSb6XS8dr7U1hcP9KTDlQzsNLaX2/WI/PeG
         XGOA==
X-Gm-Message-State: AOJu0YxPjznpIOD6QUZi/lCmhnsAJllRo4r4dC3j9YCVOaLVSOY4c4xa
        OkNE129GKgP/fcQNdTeqoTMeVA==
X-Google-Smtp-Source: AGHT+IFVutKu63yhPhQ6eDcVAoznpG/QOoJYwQEY35+dCDCK05pYrqj2Xmp54MIr6cd2PYmh/TsecA==
X-Received: by 2002:a05:651c:1038:b0:2b9:575e:5298 with SMTP id w24-20020a05651c103800b002b9575e5298mr1422855ljm.13.1691756131275;
        Fri, 11 Aug 2023 05:15:31 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e870c000000b002b9ec22d9fasm848487lji.29.2023.08.11.05.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:15:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 14:15:15 +0200
Subject: [PATCH 04/20] interconnect: qcom: sdx55: Retire DEFINE_QNODE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_retire_macrosd-v1-4-c03aaeffc769@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691756124; l=22083;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=osSC81eDujRtXgK+JA7cmtPaGuCecCL1dMVBWGsT2FA=;
 b=+lpt4Gw+rjvKHr1ZTWpscmaG5SuJDzjjJCcN5cV/vO/xgkaSFgvwEYlVVpMhyvGUpPALmi2MF
 lyiTcYSJ+n7A+Vt0zYU031PUYxrFrilnfHKhTz9Jd6rHYx66jIZFyiu
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct definition macros are hard to read and comapre, expand them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sdx55.c | 681 ++++++++++++++++++++++++++++++++++----
 1 file changed, 623 insertions(+), 58 deletions(-)

diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
index cf4cde512613..c4d4e24bf18a 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -19,64 +19,629 @@
 #include "icc-rpmh.h"
 #include "sdx55.h"
 
-DEFINE_QNODE(llcc_mc, SDX55_MASTER_LLCC, 4, 4, SDX55_SLAVE_EBI_CH0);
-DEFINE_QNODE(acm_tcu, SDX55_MASTER_TCU_0, 1, 8, SDX55_SLAVE_LLCC, SDX55_SLAVE_MEM_NOC_SNOC, SDX55_SLAVE_MEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(qnm_snoc_gc, SDX55_MASTER_SNOC_GC_MEM_NOC, 1, 8, SDX55_SLAVE_LLCC);
-DEFINE_QNODE(xm_apps_rdwr, SDX55_MASTER_AMPSS_M0, 1, 16, SDX55_SLAVE_LLCC, SDX55_SLAVE_MEM_NOC_SNOC, SDX55_SLAVE_MEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(qhm_audio, SDX55_MASTER_AUDIO, 1, 4, SDX55_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(qhm_blsp1, SDX55_MASTER_BLSP_1, 1, 4, SDX55_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(qhm_qdss_bam, SDX55_MASTER_QDSS_BAM, 1, 4, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_TLMM, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
-DEFINE_QNODE(qhm_qpic, SDX55_MASTER_QPIC, 1, 4, SDX55_SLAVE_AOSS, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP, SDX55_SLAVE_AUDIO);
-DEFINE_QNODE(qhm_snoc_cfg, SDX55_MASTER_SNOC_CFG, 1, 4, SDX55_SLAVE_SERVICE_SNOC);
-DEFINE_QNODE(qhm_spmi_fetcher1, SDX55_MASTER_SPMI_FETCHER, 1, 4, SDX55_SLAVE_AOSS, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP);
-DEFINE_QNODE(qnm_aggre_noc, SDX55_MASTER_ANOC_SNOC, 1, 8, SDX55_SLAVE_PCIE_0, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_TLMM, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QDSS_STM, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_USB3, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_APPSS, SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
-DEFINE_QNODE(qnm_ipa, SDX55_MASTER_IPA, 1, 8, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_AOSS, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_QDSS_STM, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_AUDIO, SDX55_SLAVE_TLMM, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
-DEFINE_QNODE(qnm_memnoc, SDX55_MASTER_MEM_NOC_SNOC, 1, 8, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_TLMM, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QDSS_STM, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_APPSS,  SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
-DEFINE_QNODE(qnm_memnoc_pcie, SDX55_MASTER_MEM_NOC_PCIE_SNOC, 1, 8, SDX55_SLAVE_PCIE_0);
-DEFINE_QNODE(qxm_crypto, SDX55_MASTER_CRYPTO_CORE_0, 1, 8, SDX55_SLAVE_AOSS, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP);
-DEFINE_QNODE(xm_emac, SDX55_MASTER_EMAC, 1, 8, SDX55_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(xm_ipa2pcie_slv, SDX55_MASTER_IPA_PCIE, 1, 8, SDX55_SLAVE_PCIE_0);
-DEFINE_QNODE(xm_pcie, SDX55_MASTER_PCIE, 1, 8, SDX55_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(xm_qdss_etr, SDX55_MASTER_QDSS_ETR, 1, 8, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_AOSS, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
-DEFINE_QNODE(xm_sdc1, SDX55_MASTER_SDCC_1, 1, 8, SDX55_SLAVE_AOSS, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP, SDX55_SLAVE_AUDIO);
-DEFINE_QNODE(xm_usb3, SDX55_MASTER_USB3, 1, 8, SDX55_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(ebi, SDX55_SLAVE_EBI_CH0, 1, 4);
-DEFINE_QNODE(qns_llcc, SDX55_SLAVE_LLCC, 1, 16, SDX55_SLAVE_EBI_CH0);
-DEFINE_QNODE(qns_memnoc_snoc, SDX55_SLAVE_MEM_NOC_SNOC, 1, 8, SDX55_MASTER_MEM_NOC_SNOC);
-DEFINE_QNODE(qns_sys_pcie, SDX55_SLAVE_MEM_NOC_PCIE_SNOC, 1, 8, SDX55_MASTER_MEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(qhs_aop, SDX55_SLAVE_AOP, 1, 4);
-DEFINE_QNODE(qhs_aoss, SDX55_SLAVE_AOSS, 1, 4);
-DEFINE_QNODE(qhs_apss, SDX55_SLAVE_APPSS, 1, 4);
-DEFINE_QNODE(qhs_audio, SDX55_SLAVE_AUDIO, 1, 4);
-DEFINE_QNODE(qhs_blsp1, SDX55_SLAVE_BLSP_1, 1, 4);
-DEFINE_QNODE(qhs_clk_ctl, SDX55_SLAVE_CLK_CTL, 1, 4);
-DEFINE_QNODE(qhs_crypto0_cfg, SDX55_SLAVE_CRYPTO_0_CFG, 1, 4);
-DEFINE_QNODE(qhs_ddrss_cfg, SDX55_SLAVE_CNOC_DDRSS, 1, 4);
-DEFINE_QNODE(qhs_ecc_cfg, SDX55_SLAVE_ECC_CFG, 1, 4);
-DEFINE_QNODE(qhs_emac_cfg, SDX55_SLAVE_EMAC_CFG, 1, 4);
-DEFINE_QNODE(qhs_imem_cfg, SDX55_SLAVE_IMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_ipa, SDX55_SLAVE_IPA_CFG, 1, 4);
-DEFINE_QNODE(qhs_mss_cfg, SDX55_SLAVE_CNOC_MSS, 1, 4);
-DEFINE_QNODE(qhs_pcie_parf, SDX55_SLAVE_PCIE_PARF, 1, 4);
-DEFINE_QNODE(qhs_pdm, SDX55_SLAVE_PDM, 1, 4);
-DEFINE_QNODE(qhs_prng, SDX55_SLAVE_PRNG, 1, 4);
-DEFINE_QNODE(qhs_qdss_cfg, SDX55_SLAVE_QDSS_CFG, 1, 4);
-DEFINE_QNODE(qhs_qpic, SDX55_SLAVE_QPIC, 1, 4);
-DEFINE_QNODE(qhs_sdc1, SDX55_SLAVE_SDCC_1, 1, 4);
-DEFINE_QNODE(qhs_snoc_cfg, SDX55_SLAVE_SNOC_CFG, 1, 4, SDX55_MASTER_SNOC_CFG);
-DEFINE_QNODE(qhs_spmi_fetcher, SDX55_SLAVE_SPMI_FETCHER, 1, 4);
-DEFINE_QNODE(qhs_spmi_vgi_coex, SDX55_SLAVE_SPMI_VGI_COEX, 1, 4);
-DEFINE_QNODE(qhs_tcsr, SDX55_SLAVE_TCSR, 1, 4);
-DEFINE_QNODE(qhs_tlmm, SDX55_SLAVE_TLMM, 1, 4);
-DEFINE_QNODE(qhs_usb3, SDX55_SLAVE_USB3, 1, 4);
-DEFINE_QNODE(qhs_usb3_phy, SDX55_SLAVE_USB3_PHY_CFG, 1, 4);
-DEFINE_QNODE(qns_aggre_noc, SDX55_SLAVE_ANOC_SNOC, 1, 8, SDX55_MASTER_ANOC_SNOC);
-DEFINE_QNODE(qns_snoc_memnoc, SDX55_SLAVE_SNOC_MEM_NOC_GC, 1, 8, SDX55_MASTER_SNOC_GC_MEM_NOC);
-DEFINE_QNODE(qxs_imem, SDX55_SLAVE_OCIMEM, 1, 8);
-DEFINE_QNODE(srvc_snoc, SDX55_SLAVE_SERVICE_SNOC, 1, 4);
-DEFINE_QNODE(xs_pcie, SDX55_SLAVE_PCIE_0, 1, 8);
-DEFINE_QNODE(xs_qdss_stm, SDX55_SLAVE_QDSS_STM, 1, 4);
-DEFINE_QNODE(xs_sys_tcu_cfg, SDX55_SLAVE_TCU, 1, 8);
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SDX55_MASTER_LLCC,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_EBI_CH0 },
+};
+
+static struct qcom_icc_node acm_tcu = {
+	.name = "acm_tcu",
+	.id = SDX55_MASTER_TCU_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 3,
+	.links = { SDX55_SLAVE_LLCC,
+		   SDX55_SLAVE_MEM_NOC_SNOC,
+		   SDX55_SLAVE_MEM_NOC_PCIE_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SDX55_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node xm_apps_rdwr = {
+	.name = "xm_apps_rdwr",
+	.id = SDX55_MASTER_AMPSS_M0,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SDX55_SLAVE_LLCC,
+		   SDX55_SLAVE_MEM_NOC_SNOC,
+		   SDX55_SLAVE_MEM_NOC_PCIE_SNOC
+	},
+};
+
+static struct qcom_icc_node qhm_audio = {
+	.name = "qhm_audio",
+	.id = SDX55_MASTER_AUDIO,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_ANOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_blsp1 = {
+	.name = "qhm_blsp1",
+	.id = SDX55_MASTER_BLSP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_ANOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SDX55_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 28,
+	.links = { SDX55_SLAVE_SNOC_CFG,
+		   SDX55_SLAVE_EMAC_CFG,
+		   SDX55_SLAVE_USB3,
+		   SDX55_SLAVE_TLMM,
+		   SDX55_SLAVE_SPMI_FETCHER,
+		   SDX55_SLAVE_QDSS_CFG,
+		   SDX55_SLAVE_PDM,
+		   SDX55_SLAVE_SNOC_MEM_NOC_GC,
+		   SDX55_SLAVE_TCSR,
+		   SDX55_SLAVE_CNOC_DDRSS,
+		   SDX55_SLAVE_SPMI_VGI_COEX,
+		   SDX55_SLAVE_QPIC,
+		   SDX55_SLAVE_OCIMEM,
+		   SDX55_SLAVE_IPA_CFG,
+		   SDX55_SLAVE_USB3_PHY_CFG,
+		   SDX55_SLAVE_AOP,
+		   SDX55_SLAVE_BLSP_1,
+		   SDX55_SLAVE_SDCC_1,
+		   SDX55_SLAVE_CNOC_MSS,
+		   SDX55_SLAVE_PCIE_PARF,
+		   SDX55_SLAVE_ECC_CFG,
+		   SDX55_SLAVE_AUDIO,
+		   SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_PRNG,
+		   SDX55_SLAVE_CRYPTO_0_CFG,
+		   SDX55_SLAVE_TCU,
+		   SDX55_SLAVE_CLK_CTL,
+		   SDX55_SLAVE_IMEM_CFG
+	},
+};
+
+static struct qcom_icc_node qhm_qpic = {
+	.name = "qhm_qpic",
+	.id = SDX55_MASTER_QPIC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 5,
+	.links = { SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_IPA_CFG,
+		   SDX55_SLAVE_ANOC_SNOC,
+		   SDX55_SLAVE_AOP,
+		   SDX55_SLAVE_AUDIO
+	},
+};
+
+static struct qcom_icc_node qhm_snoc_cfg = {
+	.name = "qhm_snoc_cfg",
+	.id = SDX55_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_SERVICE_SNOC },
+};
+
+static struct qcom_icc_node qhm_spmi_fetcher1 = {
+	.name = "qhm_spmi_fetcher1",
+	.id = SDX55_MASTER_SPMI_FETCHER,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 3,
+	.links = { SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_ANOC_SNOC,
+		   SDX55_SLAVE_AOP
+	},
+};
+
+static struct qcom_icc_node qnm_aggre_noc = {
+	.name = "qnm_aggre_noc",
+	.id = SDX55_MASTER_ANOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 30,
+	.links = { SDX55_SLAVE_PCIE_0,
+		   SDX55_SLAVE_SNOC_CFG,
+		   SDX55_SLAVE_SDCC_1,
+		   SDX55_SLAVE_TLMM,
+		   SDX55_SLAVE_SPMI_FETCHER,
+		   SDX55_SLAVE_QDSS_CFG,
+		   SDX55_SLAVE_PDM,
+		   SDX55_SLAVE_SNOC_MEM_NOC_GC,
+		   SDX55_SLAVE_TCSR,
+		   SDX55_SLAVE_CNOC_DDRSS,
+		   SDX55_SLAVE_SPMI_VGI_COEX,
+		   SDX55_SLAVE_QDSS_STM,
+		   SDX55_SLAVE_QPIC,
+		   SDX55_SLAVE_OCIMEM,
+		   SDX55_SLAVE_IPA_CFG,
+		   SDX55_SLAVE_USB3_PHY_CFG,
+		   SDX55_SLAVE_AOP,
+		   SDX55_SLAVE_BLSP_1,
+		   SDX55_SLAVE_USB3,
+		   SDX55_SLAVE_CNOC_MSS,
+		   SDX55_SLAVE_PCIE_PARF,
+		   SDX55_SLAVE_ECC_CFG,
+		   SDX55_SLAVE_APPSS,
+		   SDX55_SLAVE_AUDIO,
+		   SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_PRNG,
+		   SDX55_SLAVE_CRYPTO_0_CFG,
+		   SDX55_SLAVE_TCU,
+		   SDX55_SLAVE_CLK_CTL,
+		   SDX55_SLAVE_IMEM_CFG
+	},
+};
+
+static struct qcom_icc_node qnm_ipa = {
+	.name = "qnm_ipa",
+	.id = SDX55_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 27,
+	.links = { SDX55_SLAVE_SNOC_CFG,
+		   SDX55_SLAVE_EMAC_CFG,
+		   SDX55_SLAVE_USB3,
+		   SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_SPMI_FETCHER,
+		   SDX55_SLAVE_QDSS_CFG,
+		   SDX55_SLAVE_PDM,
+		   SDX55_SLAVE_SNOC_MEM_NOC_GC,
+		   SDX55_SLAVE_TCSR,
+		   SDX55_SLAVE_CNOC_DDRSS,
+		   SDX55_SLAVE_QDSS_STM,
+		   SDX55_SLAVE_QPIC,
+		   SDX55_SLAVE_OCIMEM,
+		   SDX55_SLAVE_IPA_CFG,
+		   SDX55_SLAVE_USB3_PHY_CFG,
+		   SDX55_SLAVE_AOP,
+		   SDX55_SLAVE_BLSP_1,
+		   SDX55_SLAVE_SDCC_1,
+		   SDX55_SLAVE_CNOC_MSS,
+		   SDX55_SLAVE_PCIE_PARF,
+		   SDX55_SLAVE_ECC_CFG,
+		   SDX55_SLAVE_AUDIO,
+		   SDX55_SLAVE_TLMM,
+		   SDX55_SLAVE_PRNG,
+		   SDX55_SLAVE_CRYPTO_0_CFG,
+		   SDX55_SLAVE_CLK_CTL,
+		   SDX55_SLAVE_IMEM_CFG
+	},
+};
+
+static struct qcom_icc_node qnm_memnoc = {
+	.name = "qnm_memnoc",
+	.id = SDX55_MASTER_MEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 29,
+	.links = { SDX55_SLAVE_SNOC_CFG,
+		   SDX55_SLAVE_EMAC_CFG,
+		   SDX55_SLAVE_USB3,
+		   SDX55_SLAVE_TLMM,
+		   SDX55_SLAVE_SPMI_FETCHER,
+		   SDX55_SLAVE_QDSS_CFG,
+		   SDX55_SLAVE_PDM,
+		   SDX55_SLAVE_TCSR,
+		   SDX55_SLAVE_CNOC_DDRSS,
+		   SDX55_SLAVE_SPMI_VGI_COEX,
+		   SDX55_SLAVE_QDSS_STM,
+		   SDX55_SLAVE_QPIC,
+		   SDX55_SLAVE_OCIMEM,
+		   SDX55_SLAVE_IPA_CFG,
+		   SDX55_SLAVE_USB3_PHY_CFG,
+		   SDX55_SLAVE_AOP,
+		   SDX55_SLAVE_BLSP_1,
+		   SDX55_SLAVE_SDCC_1,
+		   SDX55_SLAVE_CNOC_MSS,
+		   SDX55_SLAVE_PCIE_PARF,
+		   SDX55_SLAVE_ECC_CFG,
+		   SDX55_SLAVE_APPSS,
+		   SDX55_SLAVE_AUDIO,
+		   SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_PRNG,
+		   SDX55_SLAVE_CRYPTO_0_CFG,
+		   SDX55_SLAVE_TCU,
+		   SDX55_SLAVE_CLK_CTL,
+		   SDX55_SLAVE_IMEM_CFG
+	},
+};
+
+static struct qcom_icc_node qnm_memnoc_pcie = {
+	.name = "qnm_memnoc_pcie",
+	.id = SDX55_MASTER_MEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_PCIE_0 },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SDX55_MASTER_CRYPTO_CORE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 3,
+	.links = { SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_ANOC_SNOC,
+		   SDX55_SLAVE_AOP
+	},
+};
+
+static struct qcom_icc_node xm_emac = {
+	.name = "xm_emac",
+	.id = SDX55_MASTER_EMAC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_ANOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ipa2pcie_slv = {
+	.name = "xm_ipa2pcie_slv",
+	.id = SDX55_MASTER_IPA_PCIE,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_PCIE_0 },
+};
+
+static struct qcom_icc_node xm_pcie = {
+	.name = "xm_pcie",
+	.id = SDX55_MASTER_PCIE,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_ANOC_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr = {
+	.name = "xm_qdss_etr",
+	.id = SDX55_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 28,
+	.links = { SDX55_SLAVE_SNOC_CFG,
+		   SDX55_SLAVE_EMAC_CFG,
+		   SDX55_SLAVE_USB3,
+		   SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_SPMI_FETCHER,
+		   SDX55_SLAVE_QDSS_CFG,
+		   SDX55_SLAVE_PDM,
+		   SDX55_SLAVE_SNOC_MEM_NOC_GC,
+		   SDX55_SLAVE_TCSR,
+		   SDX55_SLAVE_CNOC_DDRSS,
+		   SDX55_SLAVE_SPMI_VGI_COEX,
+		   SDX55_SLAVE_QPIC,
+		   SDX55_SLAVE_OCIMEM,
+		   SDX55_SLAVE_IPA_CFG,
+		   SDX55_SLAVE_USB3_PHY_CFG,
+		   SDX55_SLAVE_AOP,
+		   SDX55_SLAVE_BLSP_1,
+		   SDX55_SLAVE_SDCC_1,
+		   SDX55_SLAVE_CNOC_MSS,
+		   SDX55_SLAVE_PCIE_PARF,
+		   SDX55_SLAVE_ECC_CFG,
+		   SDX55_SLAVE_AUDIO,
+		   SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_PRNG,
+		   SDX55_SLAVE_CRYPTO_0_CFG,
+		   SDX55_SLAVE_TCU,
+		   SDX55_SLAVE_CLK_CTL,
+		   SDX55_SLAVE_IMEM_CFG
+	},
+};
+
+static struct qcom_icc_node xm_sdc1 = {
+	.name = "xm_sdc1",
+	.id = SDX55_MASTER_SDCC_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 5,
+	.links = { SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_IPA_CFG,
+		   SDX55_SLAVE_ANOC_SNOC,
+		   SDX55_SLAVE_AOP,
+		   SDX55_SLAVE_AUDIO
+	},
+};
+
+static struct qcom_icc_node xm_usb3 = {
+	.name = "xm_usb3",
+	.id = SDX55_MASTER_USB3,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_ANOC_SNOC },
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SDX55_SLAVE_EBI_CH0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SDX55_SLAVE_LLCC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_EBI_CH0 },
+};
+
+static struct qcom_icc_node qns_memnoc_snoc = {
+	.name = "qns_memnoc_snoc",
+	.id = SDX55_SLAVE_MEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_MASTER_MEM_NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_sys_pcie = {
+	.name = "qns_sys_pcie",
+	.id = SDX55_SLAVE_MEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_MASTER_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qhs_aop = {
+	.name = "qhs_aop",
+	.id = SDX55_SLAVE_AOP,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SDX55_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.id = SDX55_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_audio = {
+	.name = "qhs_audio",
+	.id = SDX55_SLAVE_AUDIO,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_blsp1 = {
+	.name = "qhs_blsp1",
+	.id = SDX55_SLAVE_BLSP_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SDX55_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SDX55_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ddrss_cfg = {
+	.name = "qhs_ddrss_cfg",
+	.id = SDX55_SLAVE_CNOC_DDRSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ecc_cfg = {
+	.name = "qhs_ecc_cfg",
+	.id = SDX55_SLAVE_ECC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_emac_cfg = {
+	.name = "qhs_emac_cfg",
+	.id = SDX55_SLAVE_EMAC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SDX55_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SDX55_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mss_cfg = {
+	.name = "qhs_mss_cfg",
+	.id = SDX55_SLAVE_CNOC_MSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie_parf = {
+	.name = "qhs_pcie_parf",
+	.id = SDX55_SLAVE_PCIE_PARF,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SDX55_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = SDX55_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SDX55_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qpic = {
+	.name = "qhs_qpic",
+	.id = SDX55_SLAVE_QPIC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc1 = {
+	.name = "qhs_sdc1",
+	.id = SDX55_SLAVE_SDCC_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_snoc_cfg = {
+	.name = "qhs_snoc_cfg",
+	.id = SDX55_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX55_MASTER_SNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_spmi_fetcher = {
+	.name = "qhs_spmi_fetcher",
+	.id = SDX55_SLAVE_SPMI_FETCHER,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_spmi_vgi_coex = {
+	.name = "qhs_spmi_vgi_coex",
+	.id = SDX55_SLAVE_SPMI_VGI_COEX,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SDX55_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.id = SDX55_SLAVE_TLMM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3 = {
+	.name = "qhs_usb3",
+	.id = SDX55_SLAVE_USB3,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_phy = {
+	.name = "qhs_usb3_phy",
+	.id = SDX55_SLAVE_USB3_PHY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_aggre_noc = {
+	.name = "qns_aggre_noc",
+	.id = SDX55_SLAVE_ANOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_MASTER_ANOC_SNOC },
+};
+
+static struct qcom_icc_node qns_snoc_memnoc = {
+	.name = "qns_snoc_memnoc",
+	.id = SDX55_SLAVE_SNOC_MEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SDX55_SLAVE_OCIMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node srvc_snoc = {
+	.name = "srvc_snoc",
+	.id = SDX55_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_pcie = {
+	.name = "xs_pcie",
+	.id = SDX55_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SDX55_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SDX55_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+};
 
 DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
 DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);

-- 
2.41.0

