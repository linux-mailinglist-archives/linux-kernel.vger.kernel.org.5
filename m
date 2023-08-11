Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A70778EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjHKMPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbjHKMPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:15:33 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3832D55
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:28 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso30761331fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691756127; x=1692360927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fc6buK6cjnOcfzQOJoFH/kj09AyrSLDIkobBcZ99mE=;
        b=wITYbrLp4poLEk5Jo2evM/lRjsoD9iwSUiustPBVbv/4wAREliTtOEGagsUj9ao6On
         mRGGSnOw+Vd6+L7audOiJchQdXtZqdcFCDSKHQVthQzYzZsVaw8I4kwdkEmJ1YxFRnjF
         vgFGw8JZPBMFwZEqRn1Jr5IdXQni9o1qyrD49NOiAxKrMBrJNDZsQdJJx9pZah9rim3Y
         bfAJj+7miZgSG32XgPRZUpnRq7FHrKZD+exg2ZlVrGULaFG8JBGGi3Fzu+liP8e6Z8Dn
         Ua4hMfNa9wY+K1cSkR9vOugX7cqBL5XyGfMto6CVS2JhgFjhdvB6AzgHPBm8t2kpCNyR
         FVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756127; x=1692360927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fc6buK6cjnOcfzQOJoFH/kj09AyrSLDIkobBcZ99mE=;
        b=L3ehtR8zpee/C0aogbebUN31DZD4KmKZopnpPiEmqm+xzveyJy/pMLnP1SK4MoDbL9
         bskQUYpd1QGHtxU0WjwQdlswLg5klPLzGRO2rv1bSgQMsFMXzlqBSNbPjTD0WNnK9tey
         P0g8mv2Gs8DC5bjXcgK+1wEHhLfZ5xpYQ6Hi54+uBnNi4+zOk9QO7jNETTEcg07Zb35Y
         1tNKQo0w27cQWcPBqxkscfnqzkPkrkSz3geZnPHzq5ufmjMbtAXX/DYkjwEByzEmJQQ1
         DQvnvm0cGfevFnjv2Tpdxp3mbNVZR8AKp05PbSNQoh41THD/kpGmJ0ETBNbi8y8Nwu2g
         TCBw==
X-Gm-Message-State: AOJu0YxuoRe5iqG/m2qXksCtdnDQ4U+k1hMbyLQBiKKiQIDy054+woWo
        bePjdbRm2Rs97cwKm8B6z4yPmw==
X-Google-Smtp-Source: AGHT+IEdoSjlx4UYarLgd6ikQ8twa3F4E+fZAlWJXpSCQmkwJnfakvhpTYMkZD/mUp3KIfgC8FyMgA==
X-Received: by 2002:a2e:9804:0:b0:2b9:d266:85ac with SMTP id a4-20020a2e9804000000b002b9d26685acmr1532498ljj.48.1691756126979;
        Fri, 11 Aug 2023 05:15:26 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e870c000000b002b9ec22d9fasm848487lji.29.2023.08.11.05.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:15:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 14:15:12 +0200
Subject: [PATCH 01/20] interconnect: qcom: sc7180: Retire DEFINE_QNODE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_retire_macrosd-v1-1-c03aaeffc769@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691756123; l=42545;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vtjQo9GO8r9X0ZSe/ODmQ12luBoAQRaJebf6MADwdHI=;
 b=t3LYfFBcV8JVGbRStWC7DUhCXIiOx4MpIwArgMQL+GMdf7u8MbiGZFItIm1d8/JY+XzZ3RIcM
 bk+X5B3lWrHC6MaEyTqauIRFGpPW29TZftL3piWoQlrucnW6eHybabw
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
 drivers/interconnect/qcom/sc7180.c | 1356 ++++++++++++++++++++++++++++++++----
 1 file changed, 1219 insertions(+), 137 deletions(-)

diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index d16298e77906..926820087bb3 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -16,143 +16,1225 @@
 #include "icc-rpmh.h"
 #include "sc7180.h"
 
-DEFINE_QNODE(qhm_a1noc_cfg, SC7180_MASTER_A1NOC_CFG, 1, 4, SC7180_SLAVE_SERVICE_A1NOC);
-DEFINE_QNODE(qhm_qspi, SC7180_MASTER_QSPI, 1, 4, SC7180_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(qhm_qup_0, SC7180_MASTER_QUP_0, 1, 4, SC7180_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_sdc2, SC7180_MASTER_SDCC_2, 1, 8, SC7180_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_emmc, SC7180_MASTER_EMMC, 1, 8, SC7180_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_ufs_mem, SC7180_MASTER_UFS_MEM, 1, 8, SC7180_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(qhm_a2noc_cfg, SC7180_MASTER_A2NOC_CFG, 1, 4, SC7180_SLAVE_SERVICE_A2NOC);
-DEFINE_QNODE(qhm_qdss_bam, SC7180_MASTER_QDSS_BAM, 1, 4, SC7180_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qhm_qup_1, SC7180_MASTER_QUP_1, 1, 4, SC7180_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qxm_crypto, SC7180_MASTER_CRYPTO, 1, 8, SC7180_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qxm_ipa, SC7180_MASTER_IPA, 1, 8, SC7180_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(xm_qdss_etr, SC7180_MASTER_QDSS_ETR, 1, 8, SC7180_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qhm_usb3, SC7180_MASTER_USB3, 1, 8, SC7180_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qxm_camnoc_hf0_uncomp, SC7180_MASTER_CAMNOC_HF0_UNCOMP, 1, 32, SC7180_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qxm_camnoc_hf1_uncomp, SC7180_MASTER_CAMNOC_HF1_UNCOMP, 1, 32, SC7180_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qxm_camnoc_sf_uncomp, SC7180_MASTER_CAMNOC_SF_UNCOMP, 1, 32, SC7180_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qnm_npu, SC7180_MASTER_NPU, 2, 32, SC7180_SLAVE_CDSP_GEM_NOC);
-DEFINE_QNODE(qxm_npu_dsp, SC7180_MASTER_NPU_PROC, 1, 8, SC7180_SLAVE_CDSP_GEM_NOC);
-DEFINE_QNODE(qnm_snoc, SC7180_MASTER_SNOC_CNOC, 1, 8, SC7180_SLAVE_A1NOC_CFG, SC7180_SLAVE_A2NOC_CFG, SC7180_SLAVE_AHB2PHY_SOUTH, SC7180_SLAVE_AHB2PHY_CENTER, SC7180_SLAVE_AOP, SC7180_SLAVE_AOSS, SC7180_SLAVE_BOOT_ROM, SC7180_SLAVE_CAMERA_CFG, SC7180_SLAVE_CAMERA_NRT_THROTTLE_CFG, SC7180_SLAVE_CAMERA_RT_THROTTLE_CFG, SC7180_SLAVE_CLK_CTL, SC7180_SLAVE_RBCPR_CX_CFG, SC7180_SLAVE_RBCPR_MX_CFG, SC7180_SLAVE_CRYPTO_0_CFG, SC7180_SLAVE_DCC_CFG, SC7180_SLAVE_CNOC_DDRSS, SC7180_SLAVE_DISPLAY_CFG, SC7180_SLAVE_DISPLAY_RT_THROTTLE_CFG, SC7180_SLAVE_DISPLAY_THROTTLE_CFG, SC7180_SLAVE_EMMC_CFG, SC7180_SLAVE_GLM,
-		SC7180_SLAVE_GFX3D_CFG, SC7180_SLAVE_IMEM_CFG, SC7180_SLAVE_IPA_CFG, SC7180_SLAVE_CNOC_MNOC_CFG, SC7180_SLAVE_CNOC_MSS, SC7180_SLAVE_NPU_CFG, SC7180_SLAVE_NPU_DMA_BWMON_CFG, SC7180_SLAVE_NPU_PROC_BWMON_CFG, SC7180_SLAVE_PDM, SC7180_SLAVE_PIMEM_CFG, SC7180_SLAVE_PRNG, SC7180_SLAVE_QDSS_CFG, SC7180_SLAVE_QM_CFG, SC7180_SLAVE_QM_MPU_CFG, SC7180_SLAVE_QSPI_0, SC7180_SLAVE_QUP_0, SC7180_SLAVE_QUP_1, SC7180_SLAVE_SDCC_2, SC7180_SLAVE_SECURITY, SC7180_SLAVE_SNOC_CFG, SC7180_SLAVE_TCSR, SC7180_SLAVE_TLMM_WEST, SC7180_SLAVE_TLMM_NORTH, SC7180_SLAVE_TLMM_SOUTH, SC7180_SLAVE_UFS_MEM_CFG, SC7180_SLAVE_USB3, SC7180_SLAVE_VENUS_CFG, SC7180_SLAVE_VENUS_THROTTLE_CFG, SC7180_SLAVE_VSENSE_CTRL_CFG, SC7180_SLAVE_SERVICE_CNOC);
-DEFINE_QNODE(xm_qdss_dap, SC7180_MASTER_QDSS_DAP, 1, 8, SC7180_SLAVE_A1NOC_CFG, SC7180_SLAVE_A2NOC_CFG, SC7180_SLAVE_AHB2PHY_SOUTH, SC7180_SLAVE_AHB2PHY_CENTER, SC7180_SLAVE_AOP, SC7180_SLAVE_AOSS, SC7180_SLAVE_BOOT_ROM, SC7180_SLAVE_CAMERA_CFG, SC7180_SLAVE_CAMERA_NRT_THROTTLE_CFG, SC7180_SLAVE_CAMERA_RT_THROTTLE_CFG, SC7180_SLAVE_CLK_CTL, SC7180_SLAVE_RBCPR_CX_CFG, SC7180_SLAVE_RBCPR_MX_CFG, SC7180_SLAVE_CRYPTO_0_CFG, SC7180_SLAVE_DCC_CFG, SC7180_SLAVE_CNOC_DDRSS, SC7180_SLAVE_DISPLAY_CFG, SC7180_SLAVE_DISPLAY_RT_THROTTLE_CFG, SC7180_SLAVE_DISPLAY_THROTTLE_CFG, SC7180_SLAVE_EMMC_CFG, SC7180_SLAVE_GLM, SC7180_SLAVE_GFX3D_CFG, SC7180_SLAVE_IMEM_CFG, SC7180_SLAVE_IPA_CFG, SC7180_SLAVE_CNOC_MNOC_CFG, SC7180_SLAVE_CNOC_MSS, SC7180_SLAVE_NPU_CFG, SC7180_SLAVE_NPU_DMA_BWMON_CFG,
-SC7180_SLAVE_NPU_PROC_BWMON_CFG, SC7180_SLAVE_PDM, SC7180_SLAVE_PIMEM_CFG, SC7180_SLAVE_PRNG, SC7180_SLAVE_QDSS_CFG, SC7180_SLAVE_QM_CFG, SC7180_SLAVE_QM_MPU_CFG, SC7180_SLAVE_QSPI_0, SC7180_SLAVE_QUP_0, SC7180_SLAVE_QUP_1, SC7180_SLAVE_SDCC_2, SC7180_SLAVE_SECURITY, SC7180_SLAVE_SNOC_CFG, SC7180_SLAVE_TCSR, SC7180_SLAVE_TLMM_WEST, SC7180_SLAVE_TLMM_NORTH, SC7180_SLAVE_TLMM_SOUTH, SC7180_SLAVE_UFS_MEM_CFG, SC7180_SLAVE_USB3, SC7180_SLAVE_VENUS_CFG, SC7180_SLAVE_VENUS_THROTTLE_CFG, SC7180_SLAVE_VSENSE_CTRL_CFG, SC7180_SLAVE_SERVICE_CNOC);
-DEFINE_QNODE(qhm_cnoc_dc_noc, SC7180_MASTER_CNOC_DC_NOC, 1, 4, SC7180_SLAVE_GEM_NOC_CFG, SC7180_SLAVE_LLCC_CFG);
-DEFINE_QNODE(acm_apps0, SC7180_MASTER_APPSS_PROC, 1, 16, SC7180_SLAVE_GEM_NOC_SNOC, SC7180_SLAVE_LLCC);
-DEFINE_QNODE(acm_sys_tcu, SC7180_MASTER_SYS_TCU, 1, 8, SC7180_SLAVE_GEM_NOC_SNOC, SC7180_SLAVE_LLCC);
-DEFINE_QNODE(qhm_gemnoc_cfg, SC7180_MASTER_GEM_NOC_CFG, 1, 4, SC7180_SLAVE_MSS_PROC_MS_MPU_CFG, SC7180_SLAVE_SERVICE_GEM_NOC);
-DEFINE_QNODE(qnm_cmpnoc, SC7180_MASTER_COMPUTE_NOC, 1, 32, SC7180_SLAVE_GEM_NOC_SNOC, SC7180_SLAVE_LLCC);
-DEFINE_QNODE(qnm_mnoc_hf, SC7180_MASTER_MNOC_HF_MEM_NOC, 1, 32, SC7180_SLAVE_LLCC);
-DEFINE_QNODE(qnm_mnoc_sf, SC7180_MASTER_MNOC_SF_MEM_NOC, 1, 32, SC7180_SLAVE_GEM_NOC_SNOC, SC7180_SLAVE_LLCC);
-DEFINE_QNODE(qnm_snoc_gc, SC7180_MASTER_SNOC_GC_MEM_NOC, 1, 8, SC7180_SLAVE_LLCC);
-DEFINE_QNODE(qnm_snoc_sf, SC7180_MASTER_SNOC_SF_MEM_NOC, 1, 16, SC7180_SLAVE_LLCC);
-DEFINE_QNODE(qxm_gpu, SC7180_MASTER_GFX3D, 2, 32, SC7180_SLAVE_GEM_NOC_SNOC, SC7180_SLAVE_LLCC);
-DEFINE_QNODE(llcc_mc, SC7180_MASTER_LLCC, 2, 4, SC7180_SLAVE_EBI1);
-DEFINE_QNODE(qhm_mnoc_cfg, SC7180_MASTER_CNOC_MNOC_CFG, 1, 4, SC7180_SLAVE_SERVICE_MNOC);
-DEFINE_QNODE(qxm_camnoc_hf0, SC7180_MASTER_CAMNOC_HF0, 2, 32, SC7180_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_camnoc_hf1, SC7180_MASTER_CAMNOC_HF1, 2, 32, SC7180_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_camnoc_sf, SC7180_MASTER_CAMNOC_SF, 1, 32, SC7180_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_mdp0, SC7180_MASTER_MDP0, 1, 32, SC7180_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_rot, SC7180_MASTER_ROTATOR, 1, 16, SC7180_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_venus0, SC7180_MASTER_VIDEO_P0, 1, 32, SC7180_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_venus_arm9, SC7180_MASTER_VIDEO_PROC, 1, 8, SC7180_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(amm_npu_sys, SC7180_MASTER_NPU_SYS, 2, 32, SC7180_SLAVE_NPU_COMPUTE_NOC);
-DEFINE_QNODE(qhm_npu_cfg, SC7180_MASTER_NPU_NOC_CFG, 1, 4, SC7180_SLAVE_NPU_CAL_DP0, SC7180_SLAVE_NPU_CP, SC7180_SLAVE_NPU_INT_DMA_BWMON_CFG, SC7180_SLAVE_NPU_DPM, SC7180_SLAVE_ISENSE_CFG, SC7180_SLAVE_NPU_LLM_CFG, SC7180_SLAVE_NPU_TCM, SC7180_SLAVE_SERVICE_NPU_NOC);
-DEFINE_QNODE(qup_core_master_1, SC7180_MASTER_QUP_CORE_0, 1, 4, SC7180_SLAVE_QUP_CORE_0);
-DEFINE_QNODE(qup_core_master_2, SC7180_MASTER_QUP_CORE_1, 1, 4, SC7180_SLAVE_QUP_CORE_1);
-DEFINE_QNODE(qhm_snoc_cfg, SC7180_MASTER_SNOC_CFG, 1, 4, SC7180_SLAVE_SERVICE_SNOC);
-DEFINE_QNODE(qnm_aggre1_noc, SC7180_MASTER_A1NOC_SNOC, 1, 16, SC7180_SLAVE_APPSS, SC7180_SLAVE_SNOC_CNOC, SC7180_SLAVE_SNOC_GEM_NOC_SF, SC7180_SLAVE_IMEM, SC7180_SLAVE_PIMEM, SC7180_SLAVE_QDSS_STM);
-DEFINE_QNODE(qnm_aggre2_noc, SC7180_MASTER_A2NOC_SNOC, 1, 16, SC7180_SLAVE_APPSS, SC7180_SLAVE_SNOC_CNOC, SC7180_SLAVE_SNOC_GEM_NOC_SF, SC7180_SLAVE_IMEM, SC7180_SLAVE_PIMEM, SC7180_SLAVE_QDSS_STM, SC7180_SLAVE_TCU);
-DEFINE_QNODE(qnm_gemnoc, SC7180_MASTER_GEM_NOC_SNOC, 1, 8, SC7180_SLAVE_APPSS, SC7180_SLAVE_SNOC_CNOC, SC7180_SLAVE_IMEM, SC7180_SLAVE_PIMEM, SC7180_SLAVE_QDSS_STM, SC7180_SLAVE_TCU);
-DEFINE_QNODE(qxm_pimem, SC7180_MASTER_PIMEM, 1, 8, SC7180_SLAVE_SNOC_GEM_NOC_GC, SC7180_SLAVE_IMEM);
-DEFINE_QNODE(qns_a1noc_snoc, SC7180_SLAVE_A1NOC_SNOC, 1, 16, SC7180_MASTER_A1NOC_SNOC);
-DEFINE_QNODE(srvc_aggre1_noc, SC7180_SLAVE_SERVICE_A1NOC, 1, 4);
-DEFINE_QNODE(qns_a2noc_snoc, SC7180_SLAVE_A2NOC_SNOC, 1, 16, SC7180_MASTER_A2NOC_SNOC);
-DEFINE_QNODE(srvc_aggre2_noc, SC7180_SLAVE_SERVICE_A2NOC, 1, 4);
-DEFINE_QNODE(qns_camnoc_uncomp, SC7180_SLAVE_CAMNOC_UNCOMP, 1, 32);
-DEFINE_QNODE(qns_cdsp_gemnoc, SC7180_SLAVE_CDSP_GEM_NOC, 1, 32, SC7180_MASTER_COMPUTE_NOC);
-DEFINE_QNODE(qhs_a1_noc_cfg, SC7180_SLAVE_A1NOC_CFG, 1, 4, SC7180_MASTER_A1NOC_CFG);
-DEFINE_QNODE(qhs_a2_noc_cfg, SC7180_SLAVE_A2NOC_CFG, 1, 4, SC7180_MASTER_A2NOC_CFG);
-DEFINE_QNODE(qhs_ahb2phy0, SC7180_SLAVE_AHB2PHY_SOUTH, 1, 4);
-DEFINE_QNODE(qhs_ahb2phy2, SC7180_SLAVE_AHB2PHY_CENTER, 1, 4);
-DEFINE_QNODE(qhs_aop, SC7180_SLAVE_AOP, 1, 4);
-DEFINE_QNODE(qhs_aoss, SC7180_SLAVE_AOSS, 1, 4);
-DEFINE_QNODE(qhs_boot_rom, SC7180_SLAVE_BOOT_ROM, 1, 4);
-DEFINE_QNODE(qhs_camera_cfg, SC7180_SLAVE_CAMERA_CFG, 1, 4);
-DEFINE_QNODE(qhs_camera_nrt_throttle_cfg, SC7180_SLAVE_CAMERA_NRT_THROTTLE_CFG, 1, 4);
-DEFINE_QNODE(qhs_camera_rt_throttle_cfg, SC7180_SLAVE_CAMERA_RT_THROTTLE_CFG, 1, 4);
-DEFINE_QNODE(qhs_clk_ctl, SC7180_SLAVE_CLK_CTL, 1, 4);
-DEFINE_QNODE(qhs_cpr_cx, SC7180_SLAVE_RBCPR_CX_CFG, 1, 4);
-DEFINE_QNODE(qhs_cpr_mx, SC7180_SLAVE_RBCPR_MX_CFG, 1, 4);
-DEFINE_QNODE(qhs_crypto0_cfg, SC7180_SLAVE_CRYPTO_0_CFG, 1, 4);
-DEFINE_QNODE(qhs_dcc_cfg, SC7180_SLAVE_DCC_CFG, 1, 4);
-DEFINE_QNODE(qhs_ddrss_cfg, SC7180_SLAVE_CNOC_DDRSS, 1, 4, SC7180_MASTER_CNOC_DC_NOC);
-DEFINE_QNODE(qhs_display_cfg, SC7180_SLAVE_DISPLAY_CFG, 1, 4);
-DEFINE_QNODE(qhs_display_rt_throttle_cfg, SC7180_SLAVE_DISPLAY_RT_THROTTLE_CFG, 1, 4);
-DEFINE_QNODE(qhs_display_throttle_cfg, SC7180_SLAVE_DISPLAY_THROTTLE_CFG, 1, 4);
-DEFINE_QNODE(qhs_emmc_cfg, SC7180_SLAVE_EMMC_CFG, 1, 4);
-DEFINE_QNODE(qhs_glm, SC7180_SLAVE_GLM, 1, 4);
-DEFINE_QNODE(qhs_gpuss_cfg, SC7180_SLAVE_GFX3D_CFG, 1, 8);
-DEFINE_QNODE(qhs_imem_cfg, SC7180_SLAVE_IMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_ipa, SC7180_SLAVE_IPA_CFG, 1, 4);
-DEFINE_QNODE(qhs_mnoc_cfg, SC7180_SLAVE_CNOC_MNOC_CFG, 1, 4, SC7180_MASTER_CNOC_MNOC_CFG);
-DEFINE_QNODE(qhs_mss_cfg, SC7180_SLAVE_CNOC_MSS, 1, 4);
-DEFINE_QNODE(qhs_npu_cfg, SC7180_SLAVE_NPU_CFG, 1, 4, SC7180_MASTER_NPU_NOC_CFG);
-DEFINE_QNODE(qhs_npu_dma_throttle_cfg, SC7180_SLAVE_NPU_DMA_BWMON_CFG, 1, 4);
-DEFINE_QNODE(qhs_npu_dsp_throttle_cfg, SC7180_SLAVE_NPU_PROC_BWMON_CFG, 1, 4);
-DEFINE_QNODE(qhs_pdm, SC7180_SLAVE_PDM, 1, 4);
-DEFINE_QNODE(qhs_pimem_cfg, SC7180_SLAVE_PIMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_prng, SC7180_SLAVE_PRNG, 1, 4);
-DEFINE_QNODE(qhs_qdss_cfg, SC7180_SLAVE_QDSS_CFG, 1, 4);
-DEFINE_QNODE(qhs_qm_cfg, SC7180_SLAVE_QM_CFG, 1, 4);
-DEFINE_QNODE(qhs_qm_mpu_cfg, SC7180_SLAVE_QM_MPU_CFG, 1, 4);
-DEFINE_QNODE(qhs_qspi, SC7180_SLAVE_QSPI_0, 1, 4);
-DEFINE_QNODE(qhs_qup0, SC7180_SLAVE_QUP_0, 1, 4);
-DEFINE_QNODE(qhs_qup1, SC7180_SLAVE_QUP_1, 1, 4);
-DEFINE_QNODE(qhs_sdc2, SC7180_SLAVE_SDCC_2, 1, 4);
-DEFINE_QNODE(qhs_security, SC7180_SLAVE_SECURITY, 1, 4);
-DEFINE_QNODE(qhs_snoc_cfg, SC7180_SLAVE_SNOC_CFG, 1, 4, SC7180_MASTER_SNOC_CFG);
-DEFINE_QNODE(qhs_tcsr, SC7180_SLAVE_TCSR, 1, 4);
-DEFINE_QNODE(qhs_tlmm_1, SC7180_SLAVE_TLMM_WEST, 1, 4);
-DEFINE_QNODE(qhs_tlmm_2, SC7180_SLAVE_TLMM_NORTH, 1, 4);
-DEFINE_QNODE(qhs_tlmm_3, SC7180_SLAVE_TLMM_SOUTH, 1, 4);
-DEFINE_QNODE(qhs_ufs_mem_cfg, SC7180_SLAVE_UFS_MEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_usb3, SC7180_SLAVE_USB3, 1, 4);
-DEFINE_QNODE(qhs_venus_cfg, SC7180_SLAVE_VENUS_CFG, 1, 4);
-DEFINE_QNODE(qhs_venus_throttle_cfg, SC7180_SLAVE_VENUS_THROTTLE_CFG, 1, 4);
-DEFINE_QNODE(qhs_vsense_ctrl_cfg, SC7180_SLAVE_VSENSE_CTRL_CFG, 1, 4);
-DEFINE_QNODE(srvc_cnoc, SC7180_SLAVE_SERVICE_CNOC, 1, 4);
-DEFINE_QNODE(qhs_gemnoc, SC7180_SLAVE_GEM_NOC_CFG, 1, 4, SC7180_MASTER_GEM_NOC_CFG);
-DEFINE_QNODE(qhs_llcc, SC7180_SLAVE_LLCC_CFG, 1, 4);
-DEFINE_QNODE(qhs_mdsp_ms_mpu_cfg, SC7180_SLAVE_MSS_PROC_MS_MPU_CFG, 1, 4);
-DEFINE_QNODE(qns_gem_noc_snoc, SC7180_SLAVE_GEM_NOC_SNOC, 1, 8, SC7180_MASTER_GEM_NOC_SNOC);
-DEFINE_QNODE(qns_llcc, SC7180_SLAVE_LLCC, 1, 16, SC7180_MASTER_LLCC);
-DEFINE_QNODE(srvc_gemnoc, SC7180_SLAVE_SERVICE_GEM_NOC, 1, 4);
-DEFINE_QNODE(ebi, SC7180_SLAVE_EBI1, 2, 4);
-DEFINE_QNODE(qns_mem_noc_hf, SC7180_SLAVE_MNOC_HF_MEM_NOC, 1, 32, SC7180_MASTER_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qns_mem_noc_sf, SC7180_SLAVE_MNOC_SF_MEM_NOC, 1, 32, SC7180_MASTER_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(srvc_mnoc, SC7180_SLAVE_SERVICE_MNOC, 1, 4);
-DEFINE_QNODE(qhs_cal_dp0, SC7180_SLAVE_NPU_CAL_DP0, 1, 4);
-DEFINE_QNODE(qhs_cp, SC7180_SLAVE_NPU_CP, 1, 4);
-DEFINE_QNODE(qhs_dma_bwmon, SC7180_SLAVE_NPU_INT_DMA_BWMON_CFG, 1, 4);
-DEFINE_QNODE(qhs_dpm, SC7180_SLAVE_NPU_DPM, 1, 4);
-DEFINE_QNODE(qhs_isense, SC7180_SLAVE_ISENSE_CFG, 1, 4);
-DEFINE_QNODE(qhs_llm, SC7180_SLAVE_NPU_LLM_CFG, 1, 4);
-DEFINE_QNODE(qhs_tcm, SC7180_SLAVE_NPU_TCM, 1, 4);
-DEFINE_QNODE(qns_npu_sys, SC7180_SLAVE_NPU_COMPUTE_NOC, 2, 32);
-DEFINE_QNODE(srvc_noc, SC7180_SLAVE_SERVICE_NPU_NOC, 1, 4);
-DEFINE_QNODE(qup_core_slave_1, SC7180_SLAVE_QUP_CORE_0, 1, 4);
-DEFINE_QNODE(qup_core_slave_2, SC7180_SLAVE_QUP_CORE_1, 1, 4);
-DEFINE_QNODE(qhs_apss, SC7180_SLAVE_APPSS, 1, 8);
-DEFINE_QNODE(qns_cnoc, SC7180_SLAVE_SNOC_CNOC, 1, 8, SC7180_MASTER_SNOC_CNOC);
-DEFINE_QNODE(qns_gemnoc_gc, SC7180_SLAVE_SNOC_GEM_NOC_GC, 1, 8, SC7180_MASTER_SNOC_GC_MEM_NOC);
-DEFINE_QNODE(qns_gemnoc_sf, SC7180_SLAVE_SNOC_GEM_NOC_SF, 1, 16, SC7180_MASTER_SNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxs_imem, SC7180_SLAVE_IMEM, 1, 8);
-DEFINE_QNODE(qxs_pimem, SC7180_SLAVE_PIMEM, 1, 8);
-DEFINE_QNODE(srvc_snoc, SC7180_SLAVE_SERVICE_SNOC, 1, 4);
-DEFINE_QNODE(xs_qdss_stm, SC7180_SLAVE_QDSS_STM, 1, 4);
-DEFINE_QNODE(xs_sys_tcu_cfg, SC7180_SLAVE_TCU, 1, 8);
+static struct qcom_icc_node qhm_a1noc_cfg = {
+	.name = "qhm_a1noc_cfg",
+	.id = SC7180_MASTER_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_SERVICE_A1NOC },
+};
+
+static struct qcom_icc_node qhm_qspi = {
+	.name = "qhm_qspi",
+	.id = SC7180_MASTER_QSPI,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup_0 = {
+	.name = "qhm_qup_0",
+	.id = SC7180_MASTER_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.id = SC7180_MASTER_SDCC_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_emmc = {
+	.name = "xm_emmc",
+	.id = SC7180_MASTER_EMMC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = SC7180_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_a2noc_cfg = {
+	.name = "qhm_a2noc_cfg",
+	.id = SC7180_MASTER_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_SERVICE_A2NOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SC7180_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup_1 = {
+	.name = "qhm_qup_1",
+	.id = SC7180_MASTER_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SC7180_MASTER_CRYPTO,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.id = SC7180_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr = {
+	.name = "xm_qdss_etr",
+	.id = SC7180_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_usb3 = {
+	.name = "qhm_usb3",
+	.id = SC7180_MASTER_USB3,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf0_uncomp = {
+	.name = "qxm_camnoc_hf0_uncomp",
+	.id = SC7180_MASTER_CAMNOC_HF0_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf1_uncomp = {
+	.name = "qxm_camnoc_hf1_uncomp",
+	.id = SC7180_MASTER_CAMNOC_HF1_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf_uncomp = {
+	.name = "qxm_camnoc_sf_uncomp",
+	.id = SC7180_MASTER_CAMNOC_SF_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qnm_npu = {
+	.name = "qnm_npu",
+	.id = SC7180_MASTER_NPU,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_CDSP_GEM_NOC },
+};
+
+static struct qcom_icc_node qxm_npu_dsp = {
+	.name = "qxm_npu_dsp",
+	.id = SC7180_MASTER_NPU_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_CDSP_GEM_NOC },
+};
+
+static struct qcom_icc_node qnm_snoc = {
+	.name = "qnm_snoc",
+	.id = SC7180_MASTER_SNOC_CNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 51,
+	.links = { SC7180_SLAVE_A1NOC_CFG,
+		   SC7180_SLAVE_A2NOC_CFG,
+		   SC7180_SLAVE_AHB2PHY_SOUTH,
+		   SC7180_SLAVE_AHB2PHY_CENTER,
+		   SC7180_SLAVE_AOP,
+		   SC7180_SLAVE_AOSS,
+		   SC7180_SLAVE_BOOT_ROM,
+		   SC7180_SLAVE_CAMERA_CFG,
+		   SC7180_SLAVE_CAMERA_NRT_THROTTLE_CFG,
+		   SC7180_SLAVE_CAMERA_RT_THROTTLE_CFG,
+		   SC7180_SLAVE_CLK_CTL,
+		   SC7180_SLAVE_RBCPR_CX_CFG,
+		   SC7180_SLAVE_RBCPR_MX_CFG,
+		   SC7180_SLAVE_CRYPTO_0_CFG,
+		   SC7180_SLAVE_DCC_CFG,
+		   SC7180_SLAVE_CNOC_DDRSS,
+		   SC7180_SLAVE_DISPLAY_CFG,
+		   SC7180_SLAVE_DISPLAY_RT_THROTTLE_CFG,
+		   SC7180_SLAVE_DISPLAY_THROTTLE_CFG,
+		   SC7180_SLAVE_EMMC_CFG,
+		   SC7180_SLAVE_GLM,
+		   SC7180_SLAVE_GFX3D_CFG,
+		   SC7180_SLAVE_IMEM_CFG,
+		   SC7180_SLAVE_IPA_CFG,
+		   SC7180_SLAVE_CNOC_MNOC_CFG,
+		   SC7180_SLAVE_CNOC_MSS,
+		   SC7180_SLAVE_NPU_CFG,
+		   SC7180_SLAVE_NPU_DMA_BWMON_CFG,
+		   SC7180_SLAVE_NPU_PROC_BWMON_CFG,
+		   SC7180_SLAVE_PDM,
+		   SC7180_SLAVE_PIMEM_CFG,
+		   SC7180_SLAVE_PRNG,
+		   SC7180_SLAVE_QDSS_CFG,
+		   SC7180_SLAVE_QM_CFG,
+		   SC7180_SLAVE_QM_MPU_CFG,
+		   SC7180_SLAVE_QSPI_0,
+		   SC7180_SLAVE_QUP_0,
+		   SC7180_SLAVE_QUP_1,
+		   SC7180_SLAVE_SDCC_2,
+		   SC7180_SLAVE_SECURITY,
+		   SC7180_SLAVE_SNOC_CFG,
+		   SC7180_SLAVE_TCSR,
+		   SC7180_SLAVE_TLMM_WEST,
+		   SC7180_SLAVE_TLMM_NORTH,
+		   SC7180_SLAVE_TLMM_SOUTH,
+		   SC7180_SLAVE_UFS_MEM_CFG,
+		   SC7180_SLAVE_USB3,
+		   SC7180_SLAVE_VENUS_CFG,
+		   SC7180_SLAVE_VENUS_THROTTLE_CFG,
+		   SC7180_SLAVE_VSENSE_CTRL_CFG,
+		   SC7180_SLAVE_SERVICE_CNOC
+	},
+};
+
+static struct qcom_icc_node xm_qdss_dap = {
+	.name = "xm_qdss_dap",
+	.id = SC7180_MASTER_QDSS_DAP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 51,
+	.links = { SC7180_SLAVE_A1NOC_CFG,
+		   SC7180_SLAVE_A2NOC_CFG,
+		   SC7180_SLAVE_AHB2PHY_SOUTH,
+		   SC7180_SLAVE_AHB2PHY_CENTER,
+		   SC7180_SLAVE_AOP,
+		   SC7180_SLAVE_AOSS,
+		   SC7180_SLAVE_BOOT_ROM,
+		   SC7180_SLAVE_CAMERA_CFG,
+		   SC7180_SLAVE_CAMERA_NRT_THROTTLE_CFG,
+		   SC7180_SLAVE_CAMERA_RT_THROTTLE_CFG,
+		   SC7180_SLAVE_CLK_CTL,
+		   SC7180_SLAVE_RBCPR_CX_CFG,
+		   SC7180_SLAVE_RBCPR_MX_CFG,
+		   SC7180_SLAVE_CRYPTO_0_CFG,
+		   SC7180_SLAVE_DCC_CFG,
+		   SC7180_SLAVE_CNOC_DDRSS,
+		   SC7180_SLAVE_DISPLAY_CFG,
+		   SC7180_SLAVE_DISPLAY_RT_THROTTLE_CFG,
+		   SC7180_SLAVE_DISPLAY_THROTTLE_CFG,
+		   SC7180_SLAVE_EMMC_CFG,
+		   SC7180_SLAVE_GLM,
+		   SC7180_SLAVE_GFX3D_CFG,
+		   SC7180_SLAVE_IMEM_CFG,
+		   SC7180_SLAVE_IPA_CFG,
+		   SC7180_SLAVE_CNOC_MNOC_CFG,
+		   SC7180_SLAVE_CNOC_MSS,
+		   SC7180_SLAVE_NPU_CFG,
+		   SC7180_SLAVE_NPU_DMA_BWMON_CFG,
+		   SC7180_SLAVE_NPU_PROC_BWMON_CFG,
+		   SC7180_SLAVE_PDM,
+		   SC7180_SLAVE_PIMEM_CFG,
+		   SC7180_SLAVE_PRNG,
+		   SC7180_SLAVE_QDSS_CFG,
+		   SC7180_SLAVE_QM_CFG,
+		   SC7180_SLAVE_QM_MPU_CFG,
+		   SC7180_SLAVE_QSPI_0,
+		   SC7180_SLAVE_QUP_0,
+		   SC7180_SLAVE_QUP_1,
+		   SC7180_SLAVE_SDCC_2,
+		   SC7180_SLAVE_SECURITY,
+		   SC7180_SLAVE_SNOC_CFG,
+		   SC7180_SLAVE_TCSR,
+		   SC7180_SLAVE_TLMM_WEST,
+		   SC7180_SLAVE_TLMM_NORTH,
+		   SC7180_SLAVE_TLMM_SOUTH,
+		   SC7180_SLAVE_UFS_MEM_CFG,
+		   SC7180_SLAVE_USB3,
+		   SC7180_SLAVE_VENUS_CFG,
+		   SC7180_SLAVE_VENUS_THROTTLE_CFG,
+		   SC7180_SLAVE_VSENSE_CTRL_CFG,
+		   SC7180_SLAVE_SERVICE_CNOC
+	},
+};
+
+static struct qcom_icc_node qhm_cnoc_dc_noc = {
+	.name = "qhm_cnoc_dc_noc",
+	.id = SC7180_MASTER_CNOC_DC_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { SC7180_SLAVE_GEM_NOC_CFG,
+		   SC7180_SLAVE_LLCC_CFG
+	},
+};
+
+static struct qcom_icc_node acm_apps0 = {
+	.name = "acm_apps0",
+	.id = SC7180_MASTER_APPSS_PROC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 2,
+	.links = { SC7180_SLAVE_GEM_NOC_SNOC,
+		   SC7180_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node acm_sys_tcu = {
+	.name = "acm_sys_tcu",
+	.id = SC7180_MASTER_SYS_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SC7180_SLAVE_GEM_NOC_SNOC,
+		   SC7180_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node qhm_gemnoc_cfg = {
+	.name = "qhm_gemnoc_cfg",
+	.id = SC7180_MASTER_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { SC7180_SLAVE_MSS_PROC_MS_MPU_CFG,
+		   SC7180_SLAVE_SERVICE_GEM_NOC
+	},
+};
+
+static struct qcom_icc_node qnm_cmpnoc = {
+	.name = "qnm_cmpnoc",
+	.id = SC7180_MASTER_COMPUTE_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC7180_SLAVE_GEM_NOC_SNOC,
+		   SC7180_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = SC7180_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = SC7180_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC7180_SLAVE_GEM_NOC_SNOC,
+		   SC7180_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SC7180_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SC7180_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qxm_gpu = {
+	.name = "qxm_gpu",
+	.id = SC7180_MASTER_GFX3D,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC7180_SLAVE_GEM_NOC_SNOC,
+		   SC7180_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SC7180_MASTER_LLCC,
+	.channels = 2,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_EBI1 },
+};
+
+static struct qcom_icc_node qhm_mnoc_cfg = {
+	.name = "qhm_mnoc_cfg",
+	.id = SC7180_MASTER_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_SERVICE_MNOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf0 = {
+	.name = "qxm_camnoc_hf0",
+	.id = SC7180_MASTER_CAMNOC_HF0,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf1 = {
+	.name = "qxm_camnoc_hf1",
+	.id = SC7180_MASTER_CAMNOC_HF1,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf = {
+	.name = "qxm_camnoc_sf",
+	.id = SC7180_MASTER_CAMNOC_SF,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_mdp0 = {
+	.name = "qxm_mdp0",
+	.id = SC7180_MASTER_MDP0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_rot = {
+	.name = "qxm_rot",
+	.id = SC7180_MASTER_ROTATOR,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_venus0 = {
+	.name = "qxm_venus0",
+	.id = SC7180_MASTER_VIDEO_P0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_venus_arm9 = {
+	.name = "qxm_venus_arm9",
+	.id = SC7180_MASTER_VIDEO_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node amm_npu_sys = {
+	.name = "amm_npu_sys",
+	.id = SC7180_MASTER_NPU_SYS,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_NPU_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node qhm_npu_cfg = {
+	.name = "qhm_npu_cfg",
+	.id = SC7180_MASTER_NPU_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 8,
+	.links = { SC7180_SLAVE_NPU_CAL_DP0,
+		   SC7180_SLAVE_NPU_CP,
+		   SC7180_SLAVE_NPU_INT_DMA_BWMON_CFG,
+		   SC7180_SLAVE_NPU_DPM,
+		   SC7180_SLAVE_ISENSE_CFG,
+		   SC7180_SLAVE_NPU_LLM_CFG,
+		   SC7180_SLAVE_NPU_TCM,
+		   SC7180_SLAVE_SERVICE_NPU_NOC
+	},
+};
+
+static struct qcom_icc_node qup_core_master_1 = {
+	.name = "qup_core_master_1",
+	.id = SC7180_MASTER_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_QUP_CORE_0 },
+};
+
+static struct qcom_icc_node qup_core_master_2 = {
+	.name = "qup_core_master_2",
+	.id = SC7180_MASTER_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_QUP_CORE_1 },
+};
+
+static struct qcom_icc_node qhm_snoc_cfg = {
+	.name = "qhm_snoc_cfg",
+	.id = SC7180_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_SLAVE_SERVICE_SNOC },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = SC7180_MASTER_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 6,
+	.links = { SC7180_SLAVE_APPSS,
+		   SC7180_SLAVE_SNOC_CNOC,
+		   SC7180_SLAVE_SNOC_GEM_NOC_SF,
+		   SC7180_SLAVE_IMEM,
+		   SC7180_SLAVE_PIMEM,
+		   SC7180_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.id = SC7180_MASTER_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 7,
+	.links = { SC7180_SLAVE_APPSS,
+		   SC7180_SLAVE_SNOC_CNOC,
+		   SC7180_SLAVE_SNOC_GEM_NOC_SF,
+		   SC7180_SLAVE_IMEM,
+		   SC7180_SLAVE_PIMEM,
+		   SC7180_SLAVE_QDSS_STM,
+		   SC7180_SLAVE_TCU
+	},
+};
+
+static struct qcom_icc_node qnm_gemnoc = {
+	.name = "qnm_gemnoc",
+	.id = SC7180_MASTER_GEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 6,
+	.links = { SC7180_SLAVE_APPSS,
+		   SC7180_SLAVE_SNOC_CNOC,
+		   SC7180_SLAVE_IMEM,
+		   SC7180_SLAVE_PIMEM,
+		   SC7180_SLAVE_QDSS_STM,
+		   SC7180_SLAVE_TCU
+	},
+};
+
+static struct qcom_icc_node qxm_pimem = {
+	.name = "qxm_pimem",
+	.id = SC7180_MASTER_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SC7180_SLAVE_SNOC_GEM_NOC_GC,
+		   SC7180_SLAVE_IMEM
+	},
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = SC7180_SLAVE_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC7180_MASTER_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node srvc_aggre1_noc = {
+	.name = "srvc_aggre1_noc",
+	.id = SC7180_SLAVE_SERVICE_A1NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.id = SC7180_SLAVE_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC7180_MASTER_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node srvc_aggre2_noc = {
+	.name = "srvc_aggre2_noc",
+	.id = SC7180_SLAVE_SERVICE_A2NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_camnoc_uncomp = {
+	.name = "qns_camnoc_uncomp",
+	.id = SC7180_SLAVE_CAMNOC_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+};
+
+static struct qcom_icc_node qns_cdsp_gemnoc = {
+	.name = "qns_cdsp_gemnoc",
+	.id = SC7180_SLAVE_CDSP_GEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7180_MASTER_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node qhs_a1_noc_cfg = {
+	.name = "qhs_a1_noc_cfg",
+	.id = SC7180_SLAVE_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_MASTER_A1NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_a2_noc_cfg = {
+	.name = "qhs_a2_noc_cfg",
+	.id = SC7180_SLAVE_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_MASTER_A2NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_ahb2phy0 = {
+	.name = "qhs_ahb2phy0",
+	.id = SC7180_SLAVE_AHB2PHY_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy2 = {
+	.name = "qhs_ahb2phy2",
+	.id = SC7180_SLAVE_AHB2PHY_CENTER,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_aop = {
+	.name = "qhs_aop",
+	.id = SC7180_SLAVE_AOP,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SC7180_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_boot_rom = {
+	.name = "qhs_boot_rom",
+	.id = SC7180_SLAVE_BOOT_ROM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = SC7180_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_camera_nrt_throttle_cfg = {
+	.name = "qhs_camera_nrt_throttle_cfg",
+	.id = SC7180_SLAVE_CAMERA_NRT_THROTTLE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_camera_rt_throttle_cfg = {
+	.name = "qhs_camera_rt_throttle_cfg",
+	.id = SC7180_SLAVE_CAMERA_RT_THROTTLE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SC7180_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.id = SC7180_SLAVE_RBCPR_CX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_mx = {
+	.name = "qhs_cpr_mx",
+	.id = SC7180_SLAVE_RBCPR_MX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SC7180_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_dcc_cfg = {
+	.name = "qhs_dcc_cfg",
+	.id = SC7180_SLAVE_DCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ddrss_cfg = {
+	.name = "qhs_ddrss_cfg",
+	.id = SC7180_SLAVE_CNOC_DDRSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_MASTER_CNOC_DC_NOC },
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.id = SC7180_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_display_rt_throttle_cfg = {
+	.name = "qhs_display_rt_throttle_cfg",
+	.id = SC7180_SLAVE_DISPLAY_RT_THROTTLE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_display_throttle_cfg = {
+	.name = "qhs_display_throttle_cfg",
+	.id = SC7180_SLAVE_DISPLAY_THROTTLE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_emmc_cfg = {
+	.name = "qhs_emmc_cfg",
+	.id = SC7180_SLAVE_EMMC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_glm = {
+	.name = "qhs_glm",
+	.id = SC7180_SLAVE_GLM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = SC7180_SLAVE_GFX3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SC7180_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SC7180_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mnoc_cfg = {
+	.name = "qhs_mnoc_cfg",
+	.id = SC7180_SLAVE_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_MASTER_CNOC_MNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_mss_cfg = {
+	.name = "qhs_mss_cfg",
+	.id = SC7180_SLAVE_CNOC_MSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_npu_cfg = {
+	.name = "qhs_npu_cfg",
+	.id = SC7180_SLAVE_NPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_MASTER_NPU_NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_npu_dma_throttle_cfg = {
+	.name = "qhs_npu_dma_throttle_cfg",
+	.id = SC7180_SLAVE_NPU_DMA_BWMON_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_npu_dsp_throttle_cfg = {
+	.name = "qhs_npu_dsp_throttle_cfg",
+	.id = SC7180_SLAVE_NPU_PROC_BWMON_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SC7180_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pimem_cfg = {
+	.name = "qhs_pimem_cfg",
+	.id = SC7180_SLAVE_PIMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = SC7180_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SC7180_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qm_cfg = {
+	.name = "qhs_qm_cfg",
+	.id = SC7180_SLAVE_QM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qm_mpu_cfg = {
+	.name = "qhs_qm_mpu_cfg",
+	.id = SC7180_SLAVE_QM_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qspi = {
+	.name = "qhs_qspi",
+	.id = SC7180_SLAVE_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup0 = {
+	.name = "qhs_qup0",
+	.id = SC7180_SLAVE_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.id = SC7180_SLAVE_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.id = SC7180_SLAVE_SDCC_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_security = {
+	.name = "qhs_security",
+	.id = SC7180_SLAVE_SECURITY,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_snoc_cfg = {
+	.name = "qhs_snoc_cfg",
+	.id = SC7180_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_MASTER_SNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SC7180_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm_1 = {
+	.name = "qhs_tlmm_1",
+	.id = SC7180_SLAVE_TLMM_WEST,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm_2 = {
+	.name = "qhs_tlmm_2",
+	.id = SC7180_SLAVE_TLMM_NORTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm_3 = {
+	.name = "qhs_tlmm_3",
+	.id = SC7180_SLAVE_TLMM_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = SC7180_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3 = {
+	.name = "qhs_usb3",
+	.id = SC7180_SLAVE_USB3,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = SC7180_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_venus_throttle_cfg = {
+	.name = "qhs_venus_throttle_cfg",
+	.id = SC7180_SLAVE_VENUS_THROTTLE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.id = SC7180_SLAVE_VSENSE_CTRL_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node srvc_cnoc = {
+	.name = "srvc_cnoc",
+	.id = SC7180_SLAVE_SERVICE_CNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_gemnoc = {
+	.name = "qhs_gemnoc",
+	.id = SC7180_SLAVE_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7180_MASTER_GEM_NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_llcc = {
+	.name = "qhs_llcc",
+	.id = SC7180_SLAVE_LLCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
+	.name = "qhs_mdsp_ms_mpu_cfg",
+	.id = SC7180_SLAVE_MSS_PROC_MS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_gem_noc_snoc = {
+	.name = "qns_gem_noc_snoc",
+	.id = SC7180_SLAVE_GEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7180_MASTER_GEM_NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SC7180_SLAVE_LLCC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC7180_MASTER_LLCC },
+};
+
+static struct qcom_icc_node srvc_gemnoc = {
+	.name = "srvc_gemnoc",
+	.id = SC7180_SLAVE_SERVICE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SC7180_SLAVE_EBI1,
+	.channels = 2,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = SC7180_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7180_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf = {
+	.name = "qns_mem_noc_sf",
+	.id = SC7180_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7180_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.id = SC7180_SLAVE_SERVICE_MNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cal_dp0 = {
+	.name = "qhs_cal_dp0",
+	.id = SC7180_SLAVE_NPU_CAL_DP0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cp = {
+	.name = "qhs_cp",
+	.id = SC7180_SLAVE_NPU_CP,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_dma_bwmon = {
+	.name = "qhs_dma_bwmon",
+	.id = SC7180_SLAVE_NPU_INT_DMA_BWMON_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_dpm = {
+	.name = "qhs_dpm",
+	.id = SC7180_SLAVE_NPU_DPM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_isense = {
+	.name = "qhs_isense",
+	.id = SC7180_SLAVE_ISENSE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_llm = {
+	.name = "qhs_llm",
+	.id = SC7180_SLAVE_NPU_LLM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tcm = {
+	.name = "qhs_tcm",
+	.id = SC7180_SLAVE_NPU_TCM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_npu_sys = {
+	.name = "qns_npu_sys",
+	.id = SC7180_SLAVE_NPU_COMPUTE_NOC,
+	.channels = 2,
+	.buswidth = 32,
+};
+
+static struct qcom_icc_node srvc_noc = {
+	.name = "srvc_noc",
+	.id = SC7180_SLAVE_SERVICE_NPU_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qup_core_slave_1 = {
+	.name = "qup_core_slave_1",
+	.id = SC7180_SLAVE_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qup_core_slave_2 = {
+	.name = "qup_core_slave_2",
+	.id = SC7180_SLAVE_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.id = SC7180_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qns_cnoc = {
+	.name = "qns_cnoc",
+	.id = SC7180_SLAVE_SNOC_CNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7180_MASTER_SNOC_CNOC },
+};
+
+static struct qcom_icc_node qns_gemnoc_gc = {
+	.name = "qns_gemnoc_gc",
+	.id = SC7180_SLAVE_SNOC_GEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7180_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = SC7180_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC7180_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SC7180_SLAVE_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qxs_pimem = {
+	.name = "qxs_pimem",
+	.id = SC7180_SLAVE_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node srvc_snoc = {
+	.name = "srvc_snoc",
+	.id = SC7180_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SC7180_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SC7180_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+};
 
 DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
 DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);

-- 
2.41.0

