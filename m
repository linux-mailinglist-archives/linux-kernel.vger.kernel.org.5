Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BC2778F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbjHKMPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbjHKMPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:15:42 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE442D72
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:36 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b962c226ceso30654471fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691756134; x=1692360934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13DpPNME0UmDtY7/+6m9MXSQSANMMUMm1xZQMhdT4uc=;
        b=d3ZOk8ogFF55J0YlGWQjCBMbHw1lFuAocHYKh5McxhaqQqOVp+8/jD3LuOVS6KcRJC
         yudHiX9f3D9vUQ5SbT/CUylGQkZC891n+6lsuNidoPF869qtTIIOzj07jhqeQX7kau2M
         kx9P+O1kVIubl+qjTs/6c/ADTcB2EzGITSTAZxzRW1IkQ8keosOq0gEY9HQ9WwX8QKC5
         oUB5QtW8qM+7mQjr2ReFIUus8AqtFSHY9QY1bCH3oWv+Z3KBA7j99Afg5V3L+jdldC3s
         qGS5b2i4c/A4TT4w7qdrTwg9dNRuPGR1Td/rze8ViKWdEgzkuyc5VnQMY6H641Fulxl7
         C4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756134; x=1692360934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13DpPNME0UmDtY7/+6m9MXSQSANMMUMm1xZQMhdT4uc=;
        b=d11kyolJr8a6sH+UESCIZljjVhzb0PPzoYouyJlw0IfPFX4PL9VBh1ltKnK6OnnPKf
         CXGmTAJusM5RzszqwCzF8AHKPc0/mL3ienlDSTHxMX37Sz91+YWVPQv4gyajqHjvaQAx
         smj0xS52VVGknaSSS/drP3RSQ9Tt0WF8vijDfob/5v/WfkuofqsLAXUnzcqfVTlGw3D3
         ZW2cFMVOyAuOTzZPK9ttuadPrpLyQ1g6OsTHIyi5DfCpE+03AjljHZ4C6oUbed/TcNJW
         XP4Av77uTpe1mEHWbkhsjyee1bZmJ4qKj7mS9DuYd2mUACGMB+O/5EuSV+Zi7PVZRwy9
         EOAw==
X-Gm-Message-State: AOJu0YzhYn2kfp00QxngZGXVyllSZFpT7EWSID0QnGUslsfbvovlgS4e
        iP+WW1rkJc+MDGsFFhGnklRhuw==
X-Google-Smtp-Source: AGHT+IFQO1SDy1cjo2jXBT+4oBxQv3TKT6IGQSkjKx4p71TBNv7ndtbSEhspqSniOzW0KE4q92JcDg==
X-Received: by 2002:a2e:3318:0:b0:2b7:364e:91ec with SMTP id d24-20020a2e3318000000b002b7364e91ecmr1576917ljc.13.1691756134206;
        Fri, 11 Aug 2023 05:15:34 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e870c000000b002b9ec22d9fasm848487lji.29.2023.08.11.05.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:15:33 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 14:15:17 +0200
Subject: [PATCH 06/20] interconnect: qcom: sm6350: Retire DEFINE_QNODE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_retire_macrosd-v1-6-c03aaeffc769@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691756124; l=39658;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=YLADi6aaed0uBSplf+fJFIRAmvw9qAzp9gW8K4pWB+0=;
 b=m2wHWPMUG8mGRS0t+E0enlzJ1H2dKNHTrEtdF638fj0/96hcw4lNvST8q4UWpLBC3KKIgU7N+
 tl+NC8mWRnCCkfCqi/aGGyXztcBH/us2RpVDBIslRCUaJPB+3gTDHPu
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct definition macros are hard to read and comapre, expand them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm6350.c | 1273 ++++++++++++++++++++++++++++++++----
 1 file changed, 1146 insertions(+), 127 deletions(-)

diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index 15c647c0e987..54ebb67d179f 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -15,133 +15,1152 @@
 #include "icc-rpmh.h"
 #include "sm6350.h"
 
-DEFINE_QNODE(qhm_a1noc_cfg, SM6350_MASTER_A1NOC_CFG, 1, 4, SM6350_SLAVE_SERVICE_A1NOC);
-DEFINE_QNODE(qhm_qup_0, SM6350_MASTER_QUP_0, 1, 4, SM6350_A1NOC_SNOC_SLV);
-DEFINE_QNODE(xm_emmc, SM6350_MASTER_EMMC, 1, 8, SM6350_A1NOC_SNOC_SLV);
-DEFINE_QNODE(xm_ufs_mem, SM6350_MASTER_UFS_MEM, 1, 8, SM6350_A1NOC_SNOC_SLV);
-DEFINE_QNODE(qhm_a2noc_cfg, SM6350_MASTER_A2NOC_CFG, 1, 4, SM6350_SLAVE_SERVICE_A2NOC);
-DEFINE_QNODE(qhm_qdss_bam, SM6350_MASTER_QDSS_BAM, 1, 4, SM6350_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qhm_qup_1, SM6350_MASTER_QUP_1, 1, 4, SM6350_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qxm_crypto, SM6350_MASTER_CRYPTO_CORE_0, 1, 8, SM6350_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qxm_ipa, SM6350_MASTER_IPA, 1, 8, SM6350_A2NOC_SNOC_SLV);
-DEFINE_QNODE(xm_qdss_etr, SM6350_MASTER_QDSS_ETR, 1, 8, SM6350_A2NOC_SNOC_SLV);
-DEFINE_QNODE(xm_sdc2, SM6350_MASTER_SDCC_2, 1, 8, SM6350_A2NOC_SNOC_SLV);
-DEFINE_QNODE(xm_usb3_0, SM6350_MASTER_USB3, 1, 8, SM6350_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qxm_camnoc_hf0_uncomp, SM6350_MASTER_CAMNOC_HF0_UNCOMP, 2, 32, SM6350_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qxm_camnoc_icp_uncomp, SM6350_MASTER_CAMNOC_ICP_UNCOMP, 1, 32, SM6350_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qxm_camnoc_sf_uncomp, SM6350_MASTER_CAMNOC_SF_UNCOMP, 1, 32, SM6350_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qup0_core_master, SM6350_MASTER_QUP_CORE_0, 1, 4, SM6350_SLAVE_QUP_CORE_0);
-DEFINE_QNODE(qup1_core_master, SM6350_MASTER_QUP_CORE_1, 1, 4, SM6350_SLAVE_QUP_CORE_1);
-DEFINE_QNODE(qnm_npu, SM6350_MASTER_NPU, 2, 32, SM6350_SLAVE_CDSP_GEM_NOC);
-DEFINE_QNODE(qxm_npu_dsp, SM6350_MASTER_NPU_PROC, 1, 8, SM6350_SLAVE_CDSP_GEM_NOC);
-DEFINE_QNODE(qnm_snoc, SM6350_SNOC_CNOC_MAS, 1, 8, SM6350_SLAVE_CAMERA_CFG, SM6350_SLAVE_SDCC_2, SM6350_SLAVE_CNOC_MNOC_CFG, SM6350_SLAVE_UFS_MEM_CFG, SM6350_SLAVE_QM_CFG, SM6350_SLAVE_SNOC_CFG, SM6350_SLAVE_QM_MPU_CFG, SM6350_SLAVE_GLM, SM6350_SLAVE_PDM, SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG, SM6350_SLAVE_A2NOC_CFG, SM6350_SLAVE_QDSS_CFG, SM6350_SLAVE_VSENSE_CTRL_CFG, SM6350_SLAVE_CAMERA_RT_THROTTLE_CFG, SM6350_SLAVE_DISPLAY_CFG, SM6350_SLAVE_TCSR, SM6350_SLAVE_DCC_CFG, SM6350_SLAVE_CNOC_DDRSS, SM6350_SLAVE_DISPLAY_THROTTLE_CFG, SM6350_SLAVE_NPU_CFG, SM6350_SLAVE_AHB2PHY, SM6350_SLAVE_GRAPHICS_3D_CFG, SM6350_SLAVE_BOOT_ROM, SM6350_SLAVE_VENUS_CFG, SM6350_SLAVE_IPA_CFG, SM6350_SLAVE_SECURITY, SM6350_SLAVE_IMEM_CFG, SM6350_SLAVE_CNOC_MSS, SM6350_SLAVE_SERVICE_CNOC, SM6350_SLAVE_USB3, SM6350_SLAVE_VENUS_THROTTLE_CFG, SM6350_SLAVE_RBCPR_CX_CFG, SM6350_SLAVE_A1NOC_CFG, SM6350_SLAVE_AOSS, SM6350_SLAVE_PRNG, SM6350_SLAVE_EMMC_CFG, SM6350_SLAVE_CRYPTO_0_CFG, SM6350_SLAVE_PIMEM_CFG, SM6350_S
 LAVE_RBCPR_MX_CFG, SM6350_SLAVE_QUP_0, SM6350_SLAVE_QUP_1, SM6350_SLAVE_CLK_CTL);
-DEFINE_QNODE(xm_qdss_dap, SM6350_MASTER_QDSS_DAP, 1, 8, SM6350_SLAVE_CAMERA_CFG, SM6350_SLAVE_SDCC_2, SM6350_SLAVE_CNOC_MNOC_CFG, SM6350_SLAVE_UFS_MEM_CFG, SM6350_SLAVE_QM_CFG, SM6350_SLAVE_SNOC_CFG, SM6350_SLAVE_QM_MPU_CFG, SM6350_SLAVE_GLM, SM6350_SLAVE_PDM, SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG, SM6350_SLAVE_A2NOC_CFG, SM6350_SLAVE_QDSS_CFG, SM6350_SLAVE_VSENSE_CTRL_CFG, SM6350_SLAVE_CAMERA_RT_THROTTLE_CFG, SM6350_SLAVE_DISPLAY_CFG, SM6350_SLAVE_TCSR, SM6350_SLAVE_DCC_CFG, SM6350_SLAVE_CNOC_DDRSS, SM6350_SLAVE_DISPLAY_THROTTLE_CFG, SM6350_SLAVE_NPU_CFG, SM6350_SLAVE_AHB2PHY, SM6350_SLAVE_GRAPHICS_3D_CFG, SM6350_SLAVE_BOOT_ROM, SM6350_SLAVE_VENUS_CFG, SM6350_SLAVE_IPA_CFG, SM6350_SLAVE_SECURITY, SM6350_SLAVE_IMEM_CFG, SM6350_SLAVE_CNOC_MSS, SM6350_SLAVE_SERVICE_CNOC, SM6350_SLAVE_USB3, SM6350_SLAVE_VENUS_THROTTLE_CFG, SM6350_SLAVE_RBCPR_CX_CFG, SM6350_SLAVE_A1NOC_CFG, SM6350_SLAVE_AOSS, SM6350_SLAVE_PRNG, SM6350_SLAVE_EMMC_CFG, SM6350_SLAVE_CRYPTO_0_CFG, SM6350_SLAVE_PIMEM_CFG, SM6
 350_SLAVE_RBCPR_MX_CFG, SM6350_SLAVE_QUP_0, SM6350_SLAVE_QUP_1, SM6350_SLAVE_CLK_CTL);
-DEFINE_QNODE(qhm_cnoc_dc_noc, SM6350_MASTER_CNOC_DC_NOC, 1, 4, SM6350_SLAVE_LLCC_CFG, SM6350_SLAVE_GEM_NOC_CFG);
-DEFINE_QNODE(acm_apps, SM6350_MASTER_AMPSS_M0, 1, 16, SM6350_SLAVE_LLCC, SM6350_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(acm_sys_tcu, SM6350_MASTER_SYS_TCU, 1, 8, SM6350_SLAVE_LLCC, SM6350_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(qhm_gemnoc_cfg, SM6350_MASTER_GEM_NOC_CFG, 1, 4, SM6350_SLAVE_MCDMA_MS_MPU_CFG, SM6350_SLAVE_SERVICE_GEM_NOC, SM6350_SLAVE_MSS_PROC_MS_MPU_CFG);
-DEFINE_QNODE(qnm_cmpnoc, SM6350_MASTER_COMPUTE_NOC, 1, 32, SM6350_SLAVE_LLCC, SM6350_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(qnm_mnoc_hf, SM6350_MASTER_MNOC_HF_MEM_NOC, 1, 32, SM6350_SLAVE_LLCC, SM6350_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(qnm_mnoc_sf, SM6350_MASTER_MNOC_SF_MEM_NOC, 1, 32, SM6350_SLAVE_LLCC, SM6350_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(qnm_snoc_gc, SM6350_MASTER_SNOC_GC_MEM_NOC, 1, 8, SM6350_SLAVE_LLCC);
-DEFINE_QNODE(qnm_snoc_sf, SM6350_MASTER_SNOC_SF_MEM_NOC, 1, 16, SM6350_SLAVE_LLCC);
-DEFINE_QNODE(qxm_gpu, SM6350_MASTER_GRAPHICS_3D, 2, 32, SM6350_SLAVE_LLCC, SM6350_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(llcc_mc, SM6350_MASTER_LLCC, 2, 4, SM6350_SLAVE_EBI_CH0);
-DEFINE_QNODE(qhm_mnoc_cfg, SM6350_MASTER_CNOC_MNOC_CFG, 1, 4, SM6350_SLAVE_SERVICE_MNOC);
-DEFINE_QNODE(qnm_video0, SM6350_MASTER_VIDEO_P0, 1, 32, SM6350_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qnm_video_cvp, SM6350_MASTER_VIDEO_PROC, 1, 8, SM6350_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_camnoc_hf, SM6350_MASTER_CAMNOC_HF, 2, 32, SM6350_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_camnoc_icp, SM6350_MASTER_CAMNOC_ICP, 1, 8, SM6350_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_camnoc_sf, SM6350_MASTER_CAMNOC_SF, 1, 32, SM6350_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_mdp0, SM6350_MASTER_MDP_PORT0, 1, 32, SM6350_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(amm_npu_sys, SM6350_MASTER_NPU_SYS, 2, 32, SM6350_SLAVE_NPU_COMPUTE_NOC);
-DEFINE_QNODE(qhm_npu_cfg, SM6350_MASTER_NPU_NOC_CFG, 1, 4, SM6350_SLAVE_SERVICE_NPU_NOC, SM6350_SLAVE_ISENSE_CFG, SM6350_SLAVE_NPU_LLM_CFG, SM6350_SLAVE_NPU_INT_DMA_BWMON_CFG, SM6350_SLAVE_NPU_CP, SM6350_SLAVE_NPU_TCM, SM6350_SLAVE_NPU_CAL_DP0, SM6350_SLAVE_NPU_DPM);
-DEFINE_QNODE(qhm_snoc_cfg, SM6350_MASTER_SNOC_CFG, 1, 4, SM6350_SLAVE_SERVICE_SNOC);
-DEFINE_QNODE(qnm_aggre1_noc, SM6350_A1NOC_SNOC_MAS, 1, 16, SM6350_SLAVE_SNOC_GEM_NOC_SF, SM6350_SLAVE_PIMEM, SM6350_SLAVE_OCIMEM, SM6350_SLAVE_APPSS, SM6350_SNOC_CNOC_SLV, SM6350_SLAVE_QDSS_STM);
-DEFINE_QNODE(qnm_aggre2_noc, SM6350_A2NOC_SNOC_MAS, 1, 16, SM6350_SLAVE_SNOC_GEM_NOC_SF, SM6350_SLAVE_PIMEM, SM6350_SLAVE_OCIMEM, SM6350_SLAVE_APPSS, SM6350_SNOC_CNOC_SLV, SM6350_SLAVE_TCU, SM6350_SLAVE_QDSS_STM);
-DEFINE_QNODE(qnm_gemnoc, SM6350_MASTER_GEM_NOC_SNOC, 1, 8, SM6350_SLAVE_PIMEM, SM6350_SLAVE_OCIMEM, SM6350_SLAVE_APPSS, SM6350_SNOC_CNOC_SLV, SM6350_SLAVE_TCU, SM6350_SLAVE_QDSS_STM);
-DEFINE_QNODE(qxm_pimem, SM6350_MASTER_PIMEM, 1, 8, SM6350_SLAVE_SNOC_GEM_NOC_GC, SM6350_SLAVE_OCIMEM);
-DEFINE_QNODE(xm_gic, SM6350_MASTER_GIC, 1, 8, SM6350_SLAVE_SNOC_GEM_NOC_GC);
-DEFINE_QNODE(qns_a1noc_snoc, SM6350_A1NOC_SNOC_SLV, 1, 16, SM6350_A1NOC_SNOC_MAS);
-DEFINE_QNODE(srvc_aggre1_noc, SM6350_SLAVE_SERVICE_A1NOC, 1, 4);
-DEFINE_QNODE(qns_a2noc_snoc, SM6350_A2NOC_SNOC_SLV, 1, 16, SM6350_A2NOC_SNOC_MAS);
-DEFINE_QNODE(srvc_aggre2_noc, SM6350_SLAVE_SERVICE_A2NOC, 1, 4);
-DEFINE_QNODE(qns_camnoc_uncomp, SM6350_SLAVE_CAMNOC_UNCOMP, 1, 32);
-DEFINE_QNODE(qup0_core_slave, SM6350_SLAVE_QUP_CORE_0, 1, 4);
-DEFINE_QNODE(qup1_core_slave, SM6350_SLAVE_QUP_CORE_1, 1, 4);
-DEFINE_QNODE(qns_cdsp_gemnoc, SM6350_SLAVE_CDSP_GEM_NOC, 1, 32, SM6350_MASTER_COMPUTE_NOC);
-DEFINE_QNODE(qhs_a1_noc_cfg, SM6350_SLAVE_A1NOC_CFG, 1, 4, SM6350_MASTER_A1NOC_CFG);
-DEFINE_QNODE(qhs_a2_noc_cfg, SM6350_SLAVE_A2NOC_CFG, 1, 4, SM6350_MASTER_A2NOC_CFG);
-DEFINE_QNODE(qhs_ahb2phy0, SM6350_SLAVE_AHB2PHY, 1, 4);
-DEFINE_QNODE(qhs_ahb2phy2, SM6350_SLAVE_AHB2PHY_2, 1, 4);
-DEFINE_QNODE(qhs_aoss, SM6350_SLAVE_AOSS, 1, 4);
-DEFINE_QNODE(qhs_boot_rom, SM6350_SLAVE_BOOT_ROM, 1, 4);
-DEFINE_QNODE(qhs_camera_cfg, SM6350_SLAVE_CAMERA_CFG, 1, 4);
-DEFINE_QNODE(qhs_camera_nrt_thrott_cfg, SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG, 1, 4);
-DEFINE_QNODE(qhs_camera_rt_throttle_cfg, SM6350_SLAVE_CAMERA_RT_THROTTLE_CFG, 1, 4);
-DEFINE_QNODE(qhs_clk_ctl, SM6350_SLAVE_CLK_CTL, 1, 4);
-DEFINE_QNODE(qhs_cpr_cx, SM6350_SLAVE_RBCPR_CX_CFG, 1, 4);
-DEFINE_QNODE(qhs_cpr_mx, SM6350_SLAVE_RBCPR_MX_CFG, 1, 4);
-DEFINE_QNODE(qhs_crypto0_cfg, SM6350_SLAVE_CRYPTO_0_CFG, 1, 4);
-DEFINE_QNODE(qhs_dcc_cfg, SM6350_SLAVE_DCC_CFG, 1, 4);
-DEFINE_QNODE(qhs_ddrss_cfg, SM6350_SLAVE_CNOC_DDRSS, 1, 4, SM6350_MASTER_CNOC_DC_NOC);
-DEFINE_QNODE(qhs_display_cfg, SM6350_SLAVE_DISPLAY_CFG, 1, 4);
-DEFINE_QNODE(qhs_display_throttle_cfg, SM6350_SLAVE_DISPLAY_THROTTLE_CFG, 1, 4);
-DEFINE_QNODE(qhs_emmc_cfg, SM6350_SLAVE_EMMC_CFG, 1, 4);
-DEFINE_QNODE(qhs_glm, SM6350_SLAVE_GLM, 1, 4);
-DEFINE_QNODE(qhs_gpuss_cfg, SM6350_SLAVE_GRAPHICS_3D_CFG, 1, 8);
-DEFINE_QNODE(qhs_imem_cfg, SM6350_SLAVE_IMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_ipa, SM6350_SLAVE_IPA_CFG, 1, 4);
-DEFINE_QNODE(qhs_mnoc_cfg, SM6350_SLAVE_CNOC_MNOC_CFG, 1, 4, SM6350_MASTER_CNOC_MNOC_CFG);
-DEFINE_QNODE(qhs_mss_cfg, SM6350_SLAVE_CNOC_MSS, 1, 4);
-DEFINE_QNODE(qhs_npu_cfg, SM6350_SLAVE_NPU_CFG, 1, 4, SM6350_MASTER_NPU_NOC_CFG);
-DEFINE_QNODE(qhs_pdm, SM6350_SLAVE_PDM, 1, 4);
-DEFINE_QNODE(qhs_pimem_cfg, SM6350_SLAVE_PIMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_prng, SM6350_SLAVE_PRNG, 1, 4);
-DEFINE_QNODE(qhs_qdss_cfg, SM6350_SLAVE_QDSS_CFG, 1, 4);
-DEFINE_QNODE(qhs_qm_cfg, SM6350_SLAVE_QM_CFG, 1, 4);
-DEFINE_QNODE(qhs_qm_mpu_cfg, SM6350_SLAVE_QM_MPU_CFG, 1, 4);
-DEFINE_QNODE(qhs_qup0, SM6350_SLAVE_QUP_0, 1, 4);
-DEFINE_QNODE(qhs_qup1, SM6350_SLAVE_QUP_1, 1, 4);
-DEFINE_QNODE(qhs_sdc2, SM6350_SLAVE_SDCC_2, 1, 4);
-DEFINE_QNODE(qhs_security, SM6350_SLAVE_SECURITY, 1, 4);
-DEFINE_QNODE(qhs_snoc_cfg, SM6350_SLAVE_SNOC_CFG, 1, 4, SM6350_MASTER_SNOC_CFG);
-DEFINE_QNODE(qhs_tcsr, SM6350_SLAVE_TCSR, 1, 4);
-DEFINE_QNODE(qhs_ufs_mem_cfg, SM6350_SLAVE_UFS_MEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_usb3_0, SM6350_SLAVE_USB3, 1, 4);
-DEFINE_QNODE(qhs_venus_cfg, SM6350_SLAVE_VENUS_CFG, 1, 4);
-DEFINE_QNODE(qhs_venus_throttle_cfg, SM6350_SLAVE_VENUS_THROTTLE_CFG, 1, 4);
-DEFINE_QNODE(qhs_vsense_ctrl_cfg, SM6350_SLAVE_VSENSE_CTRL_CFG, 1, 4);
-DEFINE_QNODE(srvc_cnoc, SM6350_SLAVE_SERVICE_CNOC, 1, 4);
-DEFINE_QNODE(qhs_gemnoc, SM6350_SLAVE_GEM_NOC_CFG, 1, 4, SM6350_MASTER_GEM_NOC_CFG);
-DEFINE_QNODE(qhs_llcc, SM6350_SLAVE_LLCC_CFG, 1, 4);
-DEFINE_QNODE(qhs_mcdma_ms_mpu_cfg, SM6350_SLAVE_MCDMA_MS_MPU_CFG, 1, 4);
-DEFINE_QNODE(qhs_mdsp_ms_mpu_cfg, SM6350_SLAVE_MSS_PROC_MS_MPU_CFG, 1, 4);
-DEFINE_QNODE(qns_gem_noc_snoc, SM6350_SLAVE_GEM_NOC_SNOC, 1, 8, SM6350_MASTER_GEM_NOC_SNOC);
-DEFINE_QNODE(qns_llcc, SM6350_SLAVE_LLCC, 1, 16, SM6350_MASTER_LLCC);
-DEFINE_QNODE(srvc_gemnoc, SM6350_SLAVE_SERVICE_GEM_NOC, 1, 4);
-DEFINE_QNODE(ebi, SM6350_SLAVE_EBI_CH0, 2, 4);
-DEFINE_QNODE(qns_mem_noc_hf, SM6350_SLAVE_MNOC_HF_MEM_NOC, 1, 32, SM6350_MASTER_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qns_mem_noc_sf, SM6350_SLAVE_MNOC_SF_MEM_NOC, 1, 32, SM6350_MASTER_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(srvc_mnoc, SM6350_SLAVE_SERVICE_MNOC, 1, 4);
-DEFINE_QNODE(qhs_cal_dp0, SM6350_SLAVE_NPU_CAL_DP0, 1, 4);
-DEFINE_QNODE(qhs_cp, SM6350_SLAVE_NPU_CP, 1, 4);
-DEFINE_QNODE(qhs_dma_bwmon, SM6350_SLAVE_NPU_INT_DMA_BWMON_CFG, 1, 4);
-DEFINE_QNODE(qhs_dpm, SM6350_SLAVE_NPU_DPM, 1, 4);
-DEFINE_QNODE(qhs_isense, SM6350_SLAVE_ISENSE_CFG, 1, 4);
-DEFINE_QNODE(qhs_llm, SM6350_SLAVE_NPU_LLM_CFG, 1, 4);
-DEFINE_QNODE(qhs_tcm, SM6350_SLAVE_NPU_TCM, 1, 4);
-DEFINE_QNODE(qns_npu_sys, SM6350_SLAVE_NPU_COMPUTE_NOC, 2, 32);
-DEFINE_QNODE(srvc_noc, SM6350_SLAVE_SERVICE_NPU_NOC, 1, 4);
-DEFINE_QNODE(qhs_apss, SM6350_SLAVE_APPSS, 1, 8);
-DEFINE_QNODE(qns_cnoc, SM6350_SNOC_CNOC_SLV, 1, 8, SM6350_SNOC_CNOC_MAS);
-DEFINE_QNODE(qns_gemnoc_gc, SM6350_SLAVE_SNOC_GEM_NOC_GC, 1, 8, SM6350_MASTER_SNOC_GC_MEM_NOC);
-DEFINE_QNODE(qns_gemnoc_sf, SM6350_SLAVE_SNOC_GEM_NOC_SF, 1, 16, SM6350_MASTER_SNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxs_imem, SM6350_SLAVE_OCIMEM, 1, 8);
-DEFINE_QNODE(qxs_pimem, SM6350_SLAVE_PIMEM, 1, 8);
-DEFINE_QNODE(srvc_snoc, SM6350_SLAVE_SERVICE_SNOC, 1, 4);
-DEFINE_QNODE(xs_qdss_stm, SM6350_SLAVE_QDSS_STM, 1, 4);
-DEFINE_QNODE(xs_sys_tcu_cfg, SM6350_SLAVE_TCU, 1, 8);
+static struct qcom_icc_node qhm_a1noc_cfg = {
+	.name = "qhm_a1noc_cfg",
+	.id = SM6350_MASTER_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_SERVICE_A1NOC },
+};
+
+static struct qcom_icc_node qhm_qup_0 = {
+	.name = "qhm_qup_0",
+	.id = SM6350_MASTER_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_emmc = {
+	.name = "xm_emmc",
+	.id = SM6350_MASTER_EMMC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM6350_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = SM6350_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM6350_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qhm_a2noc_cfg = {
+	.name = "qhm_a2noc_cfg",
+	.id = SM6350_MASTER_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_SERVICE_A2NOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SM6350_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qhm_qup_1 = {
+	.name = "qhm_qup_1",
+	.id = SM6350_MASTER_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SM6350_MASTER_CRYPTO_CORE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM6350_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.id = SM6350_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM6350_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_qdss_etr = {
+	.name = "xm_qdss_etr",
+	.id = SM6350_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM6350_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.id = SM6350_MASTER_SDCC_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM6350_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.id = SM6350_MASTER_USB3,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM6350_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf0_uncomp = {
+	.name = "qxm_camnoc_hf0_uncomp",
+	.id = SM6350_MASTER_CAMNOC_HF0_UNCOMP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qxm_camnoc_icp_uncomp = {
+	.name = "qxm_camnoc_icp_uncomp",
+	.id = SM6350_MASTER_CAMNOC_ICP_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf_uncomp = {
+	.name = "qxm_camnoc_sf_uncomp",
+	.id = SM6350_MASTER_CAMNOC_SF_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qup0_core_master = {
+	.name = "qup0_core_master",
+	.id = SM6350_MASTER_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_QUP_CORE_0 },
+};
+
+static struct qcom_icc_node qup1_core_master = {
+	.name = "qup1_core_master",
+	.id = SM6350_MASTER_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_QUP_CORE_1 },
+};
+
+static struct qcom_icc_node qnm_npu = {
+	.name = "qnm_npu",
+	.id = SM6350_MASTER_NPU,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_CDSP_GEM_NOC },
+};
+
+static struct qcom_icc_node qxm_npu_dsp = {
+	.name = "qxm_npu_dsp",
+	.id = SM6350_MASTER_NPU_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_CDSP_GEM_NOC },
+};
+
+static struct qcom_icc_node qnm_snoc = {
+	.name = "qnm_snoc",
+	.id = SM6350_SNOC_CNOC_MAS,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 42,
+	.links = { SM6350_SLAVE_CAMERA_CFG,
+		   SM6350_SLAVE_SDCC_2,
+		   SM6350_SLAVE_CNOC_MNOC_CFG,
+		   SM6350_SLAVE_UFS_MEM_CFG,
+		   SM6350_SLAVE_QM_CFG,
+		   SM6350_SLAVE_SNOC_CFG,
+		   SM6350_SLAVE_QM_MPU_CFG,
+		   SM6350_SLAVE_GLM,
+		   SM6350_SLAVE_PDM,
+		   SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG,
+		   SM6350_SLAVE_A2NOC_CFG,
+		   SM6350_SLAVE_QDSS_CFG,
+		   SM6350_SLAVE_VSENSE_CTRL_CFG,
+		   SM6350_SLAVE_CAMERA_RT_THROTTLE_CFG,
+		   SM6350_SLAVE_DISPLAY_CFG,
+		   SM6350_SLAVE_TCSR,
+		   SM6350_SLAVE_DCC_CFG,
+		   SM6350_SLAVE_CNOC_DDRSS,
+		   SM6350_SLAVE_DISPLAY_THROTTLE_CFG,
+		   SM6350_SLAVE_NPU_CFG,
+		   SM6350_SLAVE_AHB2PHY,
+		   SM6350_SLAVE_GRAPHICS_3D_CFG,
+		   SM6350_SLAVE_BOOT_ROM,
+		   SM6350_SLAVE_VENUS_CFG,
+		   SM6350_SLAVE_IPA_CFG,
+		   SM6350_SLAVE_SECURITY,
+		   SM6350_SLAVE_IMEM_CFG,
+		   SM6350_SLAVE_CNOC_MSS,
+		   SM6350_SLAVE_SERVICE_CNOC,
+		   SM6350_SLAVE_USB3,
+		   SM6350_SLAVE_VENUS_THROTTLE_CFG,
+		   SM6350_SLAVE_RBCPR_CX_CFG,
+		   SM6350_SLAVE_A1NOC_CFG,
+		   SM6350_SLAVE_AOSS,
+		   SM6350_SLAVE_PRNG,
+		   SM6350_SLAVE_EMMC_CFG,
+		   SM6350_SLAVE_CRYPTO_0_CFG,
+		   SM6350_SLAVE_PIMEM_CFG,
+		   SM6350_SLAVE_RBCPR_MX_CFG,
+		   SM6350_SLAVE_QUP_0,
+		   SM6350_SLAVE_QUP_1,
+		   SM6350_SLAVE_CLK_CTL
+	},
+};
+
+static struct qcom_icc_node xm_qdss_dap = {
+	.name = "xm_qdss_dap",
+	.id = SM6350_MASTER_QDSS_DAP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 42,
+	.links = { SM6350_SLAVE_CAMERA_CFG,
+		   SM6350_SLAVE_SDCC_2,
+		   SM6350_SLAVE_CNOC_MNOC_CFG,
+		   SM6350_SLAVE_UFS_MEM_CFG,
+		   SM6350_SLAVE_QM_CFG,
+		   SM6350_SLAVE_SNOC_CFG,
+		   SM6350_SLAVE_QM_MPU_CFG,
+		   SM6350_SLAVE_GLM,
+		   SM6350_SLAVE_PDM,
+		   SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG,
+		   SM6350_SLAVE_A2NOC_CFG,
+		   SM6350_SLAVE_QDSS_CFG,
+		   SM6350_SLAVE_VSENSE_CTRL_CFG,
+		   SM6350_SLAVE_CAMERA_RT_THROTTLE_CFG,
+		   SM6350_SLAVE_DISPLAY_CFG,
+		   SM6350_SLAVE_TCSR,
+		   SM6350_SLAVE_DCC_CFG,
+		   SM6350_SLAVE_CNOC_DDRSS,
+		   SM6350_SLAVE_DISPLAY_THROTTLE_CFG,
+		   SM6350_SLAVE_NPU_CFG,
+		   SM6350_SLAVE_AHB2PHY,
+		   SM6350_SLAVE_GRAPHICS_3D_CFG,
+		   SM6350_SLAVE_BOOT_ROM,
+		   SM6350_SLAVE_VENUS_CFG,
+		   SM6350_SLAVE_IPA_CFG,
+		   SM6350_SLAVE_SECURITY,
+		   SM6350_SLAVE_IMEM_CFG,
+		   SM6350_SLAVE_CNOC_MSS,
+		   SM6350_SLAVE_SERVICE_CNOC,
+		   SM6350_SLAVE_USB3,
+		   SM6350_SLAVE_VENUS_THROTTLE_CFG,
+		   SM6350_SLAVE_RBCPR_CX_CFG,
+		   SM6350_SLAVE_A1NOC_CFG,
+		   SM6350_SLAVE_AOSS,
+		   SM6350_SLAVE_PRNG,
+		   SM6350_SLAVE_EMMC_CFG,
+		   SM6350_SLAVE_CRYPTO_0_CFG,
+		   SM6350_SLAVE_PIMEM_CFG,
+		   SM6350_SLAVE_RBCPR_MX_CFG,
+		   SM6350_SLAVE_QUP_0,
+		   SM6350_SLAVE_QUP_1,
+		   SM6350_SLAVE_CLK_CTL
+	},
+};
+
+static struct qcom_icc_node qhm_cnoc_dc_noc = {
+	.name = "qhm_cnoc_dc_noc",
+	.id = SM6350_MASTER_CNOC_DC_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { SM6350_SLAVE_LLCC_CFG,
+		   SM6350_SLAVE_GEM_NOC_CFG
+	},
+};
+
+static struct qcom_icc_node acm_apps = {
+	.name = "acm_apps",
+	.id = SM6350_MASTER_AMPSS_M0,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 2,
+	.links = { SM6350_SLAVE_LLCC,
+		   SM6350_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node acm_sys_tcu = {
+	.name = "acm_sys_tcu",
+	.id = SM6350_MASTER_SYS_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM6350_SLAVE_LLCC,
+		   SM6350_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qhm_gemnoc_cfg = {
+	.name = "qhm_gemnoc_cfg",
+	.id = SM6350_MASTER_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 3,
+	.links = { SM6350_SLAVE_MCDMA_MS_MPU_CFG,
+		   SM6350_SLAVE_SERVICE_GEM_NOC,
+		   SM6350_SLAVE_MSS_PROC_MS_MPU_CFG
+	},
+};
+
+static struct qcom_icc_node qnm_cmpnoc = {
+	.name = "qnm_cmpnoc",
+	.id = SM6350_MASTER_COMPUTE_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM6350_SLAVE_LLCC,
+		   SM6350_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = SM6350_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM6350_SLAVE_LLCC,
+		   SM6350_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = SM6350_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM6350_SLAVE_LLCC,
+		   SM6350_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SM6350_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SM6350_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qxm_gpu = {
+	.name = "qxm_gpu",
+	.id = SM6350_MASTER_GRAPHICS_3D,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM6350_SLAVE_LLCC,
+		   SM6350_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SM6350_MASTER_LLCC,
+	.channels = 2,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_EBI_CH0 },
+};
+
+static struct qcom_icc_node qhm_mnoc_cfg = {
+	.name = "qhm_mnoc_cfg",
+	.id = SM6350_MASTER_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_SERVICE_MNOC },
+};
+
+static struct qcom_icc_node qnm_video0 = {
+	.name = "qnm_video0",
+	.id = SM6350_MASTER_VIDEO_P0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video_cvp = {
+	.name = "qnm_video_cvp",
+	.id = SM6350_MASTER_VIDEO_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf = {
+	.name = "qxm_camnoc_hf",
+	.id = SM6350_MASTER_CAMNOC_HF,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_icp = {
+	.name = "qxm_camnoc_icp",
+	.id = SM6350_MASTER_CAMNOC_ICP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf = {
+	.name = "qxm_camnoc_sf",
+	.id = SM6350_MASTER_CAMNOC_SF,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_mdp0 = {
+	.name = "qxm_mdp0",
+	.id = SM6350_MASTER_MDP_PORT0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node amm_npu_sys = {
+	.name = "amm_npu_sys",
+	.id = SM6350_MASTER_NPU_SYS,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_NPU_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node qhm_npu_cfg = {
+	.name = "qhm_npu_cfg",
+	.id = SM6350_MASTER_NPU_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 8,
+	.links = { SM6350_SLAVE_SERVICE_NPU_NOC,
+		   SM6350_SLAVE_ISENSE_CFG,
+		   SM6350_SLAVE_NPU_LLM_CFG,
+		   SM6350_SLAVE_NPU_INT_DMA_BWMON_CFG,
+		   SM6350_SLAVE_NPU_CP,
+		   SM6350_SLAVE_NPU_TCM,
+		   SM6350_SLAVE_NPU_CAL_DP0,
+		   SM6350_SLAVE_NPU_DPM
+	},
+};
+
+static struct qcom_icc_node qhm_snoc_cfg = {
+	.name = "qhm_snoc_cfg",
+	.id = SM6350_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_SERVICE_SNOC },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = SM6350_A1NOC_SNOC_MAS,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 6,
+	.links = { SM6350_SLAVE_SNOC_GEM_NOC_SF,
+		   SM6350_SLAVE_PIMEM,
+		   SM6350_SLAVE_OCIMEM,
+		   SM6350_SLAVE_APPSS,
+		   SM6350_SNOC_CNOC_SLV,
+		   SM6350_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.id = SM6350_A2NOC_SNOC_MAS,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 7,
+	.links = { SM6350_SLAVE_SNOC_GEM_NOC_SF,
+		   SM6350_SLAVE_PIMEM,
+		   SM6350_SLAVE_OCIMEM,
+		   SM6350_SLAVE_APPSS,
+		   SM6350_SNOC_CNOC_SLV,
+		   SM6350_SLAVE_TCU,
+		   SM6350_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qnm_gemnoc = {
+	.name = "qnm_gemnoc",
+	.id = SM6350_MASTER_GEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 6,
+	.links = { SM6350_SLAVE_PIMEM,
+		   SM6350_SLAVE_OCIMEM,
+		   SM6350_SLAVE_APPSS,
+		   SM6350_SNOC_CNOC_SLV,
+		   SM6350_SLAVE_TCU,
+		   SM6350_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qxm_pimem = {
+	.name = "qxm_pimem",
+	.id = SM6350_MASTER_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM6350_SLAVE_SNOC_GEM_NOC_GC,
+		   SM6350_SLAVE_OCIMEM
+	},
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = SM6350_MASTER_GIC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM6350_SLAVE_SNOC_GEM_NOC_GC },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = SM6350_A1NOC_SNOC_SLV,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM6350_A1NOC_SNOC_MAS },
+};
+
+static struct qcom_icc_node srvc_aggre1_noc = {
+	.name = "srvc_aggre1_noc",
+	.id = SM6350_SLAVE_SERVICE_A1NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.id = SM6350_A2NOC_SNOC_SLV,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM6350_A2NOC_SNOC_MAS },
+};
+
+static struct qcom_icc_node srvc_aggre2_noc = {
+	.name = "srvc_aggre2_noc",
+	.id = SM6350_SLAVE_SERVICE_A2NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_camnoc_uncomp = {
+	.name = "qns_camnoc_uncomp",
+	.id = SM6350_SLAVE_CAMNOC_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+};
+
+static struct qcom_icc_node qup0_core_slave = {
+	.name = "qup0_core_slave",
+	.id = SM6350_SLAVE_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qup1_core_slave = {
+	.name = "qup1_core_slave",
+	.id = SM6350_SLAVE_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_cdsp_gemnoc = {
+	.name = "qns_cdsp_gemnoc",
+	.id = SM6350_SLAVE_CDSP_GEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM6350_MASTER_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node qhs_a1_noc_cfg = {
+	.name = "qhs_a1_noc_cfg",
+	.id = SM6350_SLAVE_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_MASTER_A1NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_a2_noc_cfg = {
+	.name = "qhs_a2_noc_cfg",
+	.id = SM6350_SLAVE_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_MASTER_A2NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_ahb2phy0 = {
+	.name = "qhs_ahb2phy0",
+	.id = SM6350_SLAVE_AHB2PHY,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy2 = {
+	.name = "qhs_ahb2phy2",
+	.id = SM6350_SLAVE_AHB2PHY_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SM6350_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_boot_rom = {
+	.name = "qhs_boot_rom",
+	.id = SM6350_SLAVE_BOOT_ROM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = SM6350_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_camera_nrt_thrott_cfg = {
+	.name = "qhs_camera_nrt_thrott_cfg",
+	.id = SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_camera_rt_throttle_cfg = {
+	.name = "qhs_camera_rt_throttle_cfg",
+	.id = SM6350_SLAVE_CAMERA_RT_THROTTLE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SM6350_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.id = SM6350_SLAVE_RBCPR_CX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_mx = {
+	.name = "qhs_cpr_mx",
+	.id = SM6350_SLAVE_RBCPR_MX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SM6350_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_dcc_cfg = {
+	.name = "qhs_dcc_cfg",
+	.id = SM6350_SLAVE_DCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ddrss_cfg = {
+	.name = "qhs_ddrss_cfg",
+	.id = SM6350_SLAVE_CNOC_DDRSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_MASTER_CNOC_DC_NOC },
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.id = SM6350_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_display_throttle_cfg = {
+	.name = "qhs_display_throttle_cfg",
+	.id = SM6350_SLAVE_DISPLAY_THROTTLE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_emmc_cfg = {
+	.name = "qhs_emmc_cfg",
+	.id = SM6350_SLAVE_EMMC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_glm = {
+	.name = "qhs_glm",
+	.id = SM6350_SLAVE_GLM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = SM6350_SLAVE_GRAPHICS_3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SM6350_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SM6350_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mnoc_cfg = {
+	.name = "qhs_mnoc_cfg",
+	.id = SM6350_SLAVE_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_MASTER_CNOC_MNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_mss_cfg = {
+	.name = "qhs_mss_cfg",
+	.id = SM6350_SLAVE_CNOC_MSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_npu_cfg = {
+	.name = "qhs_npu_cfg",
+	.id = SM6350_SLAVE_NPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_MASTER_NPU_NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SM6350_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pimem_cfg = {
+	.name = "qhs_pimem_cfg",
+	.id = SM6350_SLAVE_PIMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = SM6350_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SM6350_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qm_cfg = {
+	.name = "qhs_qm_cfg",
+	.id = SM6350_SLAVE_QM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qm_mpu_cfg = {
+	.name = "qhs_qm_mpu_cfg",
+	.id = SM6350_SLAVE_QM_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup0 = {
+	.name = "qhs_qup0",
+	.id = SM6350_SLAVE_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.id = SM6350_SLAVE_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.id = SM6350_SLAVE_SDCC_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_security = {
+	.name = "qhs_security",
+	.id = SM6350_SLAVE_SECURITY,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_snoc_cfg = {
+	.name = "qhs_snoc_cfg",
+	.id = SM6350_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_MASTER_SNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SM6350_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = SM6350_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_0 = {
+	.name = "qhs_usb3_0",
+	.id = SM6350_SLAVE_USB3,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = SM6350_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_venus_throttle_cfg = {
+	.name = "qhs_venus_throttle_cfg",
+	.id = SM6350_SLAVE_VENUS_THROTTLE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.id = SM6350_SLAVE_VSENSE_CTRL_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node srvc_cnoc = {
+	.name = "srvc_cnoc",
+	.id = SM6350_SLAVE_SERVICE_CNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_gemnoc = {
+	.name = "qhs_gemnoc",
+	.id = SM6350_SLAVE_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM6350_MASTER_GEM_NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_llcc = {
+	.name = "qhs_llcc",
+	.id = SM6350_SLAVE_LLCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mcdma_ms_mpu_cfg = {
+	.name = "qhs_mcdma_ms_mpu_cfg",
+	.id = SM6350_SLAVE_MCDMA_MS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
+	.name = "qhs_mdsp_ms_mpu_cfg",
+	.id = SM6350_SLAVE_MSS_PROC_MS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_gem_noc_snoc = {
+	.name = "qns_gem_noc_snoc",
+	.id = SM6350_SLAVE_GEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM6350_MASTER_GEM_NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SM6350_SLAVE_LLCC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM6350_MASTER_LLCC },
+};
+
+static struct qcom_icc_node srvc_gemnoc = {
+	.name = "srvc_gemnoc",
+	.id = SM6350_SLAVE_SERVICE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SM6350_SLAVE_EBI_CH0,
+	.channels = 2,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = SM6350_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM6350_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf = {
+	.name = "qns_mem_noc_sf",
+	.id = SM6350_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM6350_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.id = SM6350_SLAVE_SERVICE_MNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cal_dp0 = {
+	.name = "qhs_cal_dp0",
+	.id = SM6350_SLAVE_NPU_CAL_DP0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cp = {
+	.name = "qhs_cp",
+	.id = SM6350_SLAVE_NPU_CP,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_dma_bwmon = {
+	.name = "qhs_dma_bwmon",
+	.id = SM6350_SLAVE_NPU_INT_DMA_BWMON_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_dpm = {
+	.name = "qhs_dpm",
+	.id = SM6350_SLAVE_NPU_DPM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_isense = {
+	.name = "qhs_isense",
+	.id = SM6350_SLAVE_ISENSE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_llm = {
+	.name = "qhs_llm",
+	.id = SM6350_SLAVE_NPU_LLM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tcm = {
+	.name = "qhs_tcm",
+	.id = SM6350_SLAVE_NPU_TCM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_npu_sys = {
+	.name = "qns_npu_sys",
+	.id = SM6350_SLAVE_NPU_COMPUTE_NOC,
+	.channels = 2,
+	.buswidth = 32,
+};
+
+static struct qcom_icc_node srvc_noc = {
+	.name = "srvc_noc",
+	.id = SM6350_SLAVE_SERVICE_NPU_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.id = SM6350_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qns_cnoc = {
+	.name = "qns_cnoc",
+	.id = SM6350_SNOC_CNOC_SLV,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM6350_SNOC_CNOC_MAS },
+};
+
+static struct qcom_icc_node qns_gemnoc_gc = {
+	.name = "qns_gemnoc_gc",
+	.id = SM6350_SLAVE_SNOC_GEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM6350_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = SM6350_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM6350_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SM6350_SLAVE_OCIMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qxs_pimem = {
+	.name = "qxs_pimem",
+	.id = SM6350_SLAVE_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node srvc_snoc = {
+	.name = "srvc_snoc",
+	.id = SM6350_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SM6350_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SM6350_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+};
 
 DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
 DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);

-- 
2.41.0

