Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E6B778F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjHKMQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbjHKMPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:15:50 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE5430C1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:40 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9bb097c1bso29562471fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691756139; x=1692360939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1F191sgCas2damdbpzwzWThozkSlHg1QIbt6U/ua/h8=;
        b=Mb7/VWJSSHHXTHHLEj0FluL+bTYvpRE2bMbUYyx6uIc9a3wM8jZLl8UQ+6ClcU2n8M
         EQBryZQLOFt7AjOoNTrSYhF99jFV18iY9uQkdxYnHqs8tXJCuVSuX1UOdkmyTkPOcxMp
         P1RaDHowG3+f/ZQwOslRS/pOc7nK+WzGxY69y7pQZnfqi7jOh4Me6OZqp6RRL+osHPlE
         KjIkZfE28fgBKl3SAvEvOBBHJwZotW4XcNZC9a6cvdKzSACHHW1E4f0QsMF9oYK/qQrW
         cUtOdUeQHnEh78ixCSHHMv/lVTba1rRcgStNOdb9aMsPm+arM9ugBgcPL2ZJ2PKdVHCO
         Y7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756139; x=1692360939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1F191sgCas2damdbpzwzWThozkSlHg1QIbt6U/ua/h8=;
        b=O4C47WMkofIlOFKcJ0i/iIlujbpPlqw7SlIRK2P1p7vPdB8rKlr4GEkxqt9lrlThtg
         Ycvki7DCrDdsfaUVgDcQ+BD8nv3ingHWIn/VCKsDaRMoTl7EeRp81QHVV1cd15YP0wpz
         kUl6dJuK8bIRHeawENMmghUSMhj1YZozKMrS9PbSrQTIwFdYu3WvOwfr/5JSCE4xMWQD
         s7EVoUquPweIhsHNQBq93B4yKkm+zyoGpc4RmMSK0ektUrgQ0H1X7gxRhHKCYaqcKN8p
         fGfC0p9ICdpcafjtfh/99dix3wEDxBlvRMscvZp7G+ivP9QGvGgris1h9SgRz6F2qeS4
         ZgBg==
X-Gm-Message-State: AOJu0Ywjtz+YyTAUoxVHtrHkuNznf7SpdAtf09Vy1yMzv0ytXY1Qubv6
        t32gIDO6b51N56rHA3mJ0cX/HHsvM1sjs95m+BM=
X-Google-Smtp-Source: AGHT+IH2PPSc/1IWkx80mNJCMlmO3NSs+TTNFd1omvbXsUln+rZ3zNgXHQxPptnrcOKbm4OmgFdwZg==
X-Received: by 2002:a2e:8791:0:b0:2b6:c081:6323 with SMTP id n17-20020a2e8791000000b002b6c0816323mr1398144lji.50.1691756138801;
        Fri, 11 Aug 2023 05:15:38 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e870c000000b002b9ec22d9fasm848487lji.29.2023.08.11.05.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:15:38 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 14:15:20 +0200
Subject: [PATCH 09/20] interconnect: qcom: sm8350: Retire DEFINE_QNODE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_retire_macrosd-v1-9-c03aaeffc769@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691756124; l=46347;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=h/NlkCxZEaAO6fUFKtc1Sul+x9yxrufgSpTXTcEyKfA=;
 b=aTB1SG+Eeq9wnKyvhsULt4YbwkAzOGBZClem0nouaD7xADAuDm8szKLOIXq2oh+PBOXGX4L0I
 BTdzC2To9DfBJKe724vYXxyQMv8VNo4IhlDQezbLessMLY4w7Ni9ump
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
 drivers/interconnect/qcom/sm8350.c | 1488 ++++++++++++++++++++++++++++++++----
 1 file changed, 1338 insertions(+), 150 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index 0e02e1800e0c..4f3b9b1ab101 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -15,156 +15,1344 @@
 #include "icc-rpmh.h"
 #include "sm8350.h"
 
-DEFINE_QNODE(qhm_qspi, SM8350_MASTER_QSPI_0, 1, 4, SM8350_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(qhm_qup0, SM8350_MASTER_QUP_0, 1, 4, SM8350_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qhm_qup1, SM8350_MASTER_QUP_1, 1, 4, SM8350_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(qhm_qup2, SM8350_MASTER_QUP_2, 1, 4, SM8350_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qnm_a1noc_cfg, SM8350_MASTER_A1NOC_CFG, 1, 4, SM8350_SLAVE_SERVICE_A1NOC);
-DEFINE_QNODE(xm_sdc4, SM8350_MASTER_SDCC_4, 1, 8, SM8350_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_ufs_mem, SM8350_MASTER_UFS_MEM, 1, 8, SM8350_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_usb3_0, SM8350_MASTER_USB3_0, 1, 8, SM8350_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_usb3_1, SM8350_MASTER_USB3_1, 1, 8, SM8350_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(qhm_qdss_bam, SM8350_MASTER_QDSS_BAM, 1, 4, SM8350_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qnm_a2noc_cfg, SM8350_MASTER_A2NOC_CFG, 1, 4, SM8350_SLAVE_SERVICE_A2NOC);
-DEFINE_QNODE(qxm_crypto, SM8350_MASTER_CRYPTO, 1, 8, SM8350_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qxm_ipa, SM8350_MASTER_IPA, 1, 8, SM8350_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(xm_pcie3_0, SM8350_MASTER_PCIE_0, 1, 8, SM8350_SLAVE_ANOC_PCIE_GEM_NOC);
-DEFINE_QNODE(xm_pcie3_1, SM8350_MASTER_PCIE_1, 1, 8, SM8350_SLAVE_ANOC_PCIE_GEM_NOC);
-DEFINE_QNODE(xm_qdss_etr, SM8350_MASTER_QDSS_ETR, 1, 8, SM8350_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(xm_sdc2, SM8350_MASTER_SDCC_2, 1, 8, SM8350_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(xm_ufs_card, SM8350_MASTER_UFS_CARD, 1, 8, SM8350_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qnm_gemnoc_cnoc, SM8350_MASTER_GEM_NOC_CNOC, 1, 16, SM8350_SLAVE_AHB2PHY_SOUTH, SM8350_SLAVE_AHB2PHY_NORTH, SM8350_SLAVE_AOSS, SM8350_SLAVE_APPSS, SM8350_SLAVE_CAMERA_CFG, SM8350_SLAVE_CLK_CTL, SM8350_SLAVE_CDSP_CFG, SM8350_SLAVE_RBCPR_CX_CFG, SM8350_SLAVE_RBCPR_MMCX_CFG, SM8350_SLAVE_RBCPR_MX_CFG, SM8350_SLAVE_CRYPTO_0_CFG, SM8350_SLAVE_CX_RDPM, SM8350_SLAVE_DCC_CFG, SM8350_SLAVE_DISPLAY_CFG, SM8350_SLAVE_GFX3D_CFG, SM8350_SLAVE_HWKM, SM8350_SLAVE_IMEM_CFG, SM8350_SLAVE_IPA_CFG, SM8350_SLAVE_IPC_ROUTER_CFG, SM8350_SLAVE_LPASS, SM8350_SLAVE_CNOC_MSS, SM8350_SLAVE_MX_RDPM, SM8350_SLAVE_PCIE_0_CFG, SM8350_SLAVE_PCIE_1_CFG, SM8350_SLAVE_PDM, SM8350_SLAVE_PIMEM_CFG, SM8350_SLAVE_PKA_WRAPPER_CFG, SM8350_SLAVE_PMU_WRAPPER_CFG, SM8350_SLAVE_QDSS_CFG, SM8350_SLAVE_QSPI_0, SM8350_SLAVE_QUP_0, SM8350_SLAVE_QUP_1, SM8350_SLAVE_QUP_2, SM8350_SLAVE_SDCC_2, SM8350_SLAVE_SDCC_4, SM8350_SLAVE_SECURITY, SM8350_SLAVE_SPSS_CFG, SM8350_SLAVE_TCSR, SM8350_SLAVE_TLMM, SM8350_SLAVE_UFS_CARD_C
 FG, SM8350_SLAVE_UFS_MEM_CFG, SM8350_SLAVE_USB3_0, SM8350_SLAVE_USB3_1, SM8350_SLAVE_VENUS_CFG, SM8350_SLAVE_VSENSE_CTRL_CFG, SM8350_SLAVE_A1NOC_CFG, SM8350_SLAVE_A2NOC_CFG, SM8350_SLAVE_DDRSS_CFG, SM8350_SLAVE_CNOC_MNOC_CFG, SM8350_SLAVE_SNOC_CFG, SM8350_SLAVE_BOOT_IMEM, SM8350_SLAVE_IMEM, SM8350_SLAVE_PIMEM, SM8350_SLAVE_SERVICE_CNOC, SM8350_SLAVE_QDSS_STM, SM8350_SLAVE_TCU);
-DEFINE_QNODE(qnm_gemnoc_pcie, SM8350_MASTER_GEM_NOC_PCIE_SNOC, 1, 8, SM8350_SLAVE_PCIE_0, SM8350_SLAVE_PCIE_1);
-DEFINE_QNODE(xm_qdss_dap, SM8350_MASTER_QDSS_DAP, 1, 8, SM8350_SLAVE_AHB2PHY_SOUTH, SM8350_SLAVE_AHB2PHY_NORTH, SM8350_SLAVE_AOSS, SM8350_SLAVE_APPSS, SM8350_SLAVE_CAMERA_CFG, SM8350_SLAVE_CLK_CTL, SM8350_SLAVE_CDSP_CFG, SM8350_SLAVE_RBCPR_CX_CFG, SM8350_SLAVE_RBCPR_MMCX_CFG, SM8350_SLAVE_RBCPR_MX_CFG, SM8350_SLAVE_CRYPTO_0_CFG, SM8350_SLAVE_CX_RDPM, SM8350_SLAVE_DCC_CFG, SM8350_SLAVE_DISPLAY_CFG, SM8350_SLAVE_GFX3D_CFG, SM8350_SLAVE_HWKM, SM8350_SLAVE_IMEM_CFG, SM8350_SLAVE_IPA_CFG, SM8350_SLAVE_IPC_ROUTER_CFG, SM8350_SLAVE_LPASS, SM8350_SLAVE_CNOC_MSS, SM8350_SLAVE_MX_RDPM, SM8350_SLAVE_PCIE_0_CFG, SM8350_SLAVE_PCIE_1_CFG, SM8350_SLAVE_PDM, SM8350_SLAVE_PIMEM_CFG, SM8350_SLAVE_PKA_WRAPPER_CFG, SM8350_SLAVE_PMU_WRAPPER_CFG, SM8350_SLAVE_QDSS_CFG, SM8350_SLAVE_QSPI_0, SM8350_SLAVE_QUP_0, SM8350_SLAVE_QUP_1, SM8350_SLAVE_QUP_2, SM8350_SLAVE_SDCC_2, SM8350_SLAVE_SDCC_4, SM8350_SLAVE_SECURITY, SM8350_SLAVE_SPSS_CFG, SM8350_SLAVE_TCSR, SM8350_SLAVE_TLMM, SM8350_SLAVE_UFS_CARD_CFG, SM835
 0_SLAVE_UFS_MEM_CFG, SM8350_SLAVE_USB3_0, SM8350_SLAVE_USB3_1, SM8350_SLAVE_VENUS_CFG, SM8350_SLAVE_VSENSE_CTRL_CFG, SM8350_SLAVE_A1NOC_CFG, SM8350_SLAVE_A2NOC_CFG, SM8350_SLAVE_DDRSS_CFG, SM8350_SLAVE_CNOC_MNOC_CFG, SM8350_SLAVE_SNOC_CFG, SM8350_SLAVE_BOOT_IMEM, SM8350_SLAVE_IMEM, SM8350_SLAVE_PIMEM, SM8350_SLAVE_SERVICE_CNOC, SM8350_SLAVE_QDSS_STM, SM8350_SLAVE_TCU);
-DEFINE_QNODE(qnm_cnoc_dc_noc, SM8350_MASTER_CNOC_DC_NOC, 1, 4, SM8350_SLAVE_LLCC_CFG, SM8350_SLAVE_GEM_NOC_CFG);
-DEFINE_QNODE(alm_gpu_tcu, SM8350_MASTER_GPU_TCU, 1, 8, SM8350_SLAVE_GEM_NOC_CNOC, SM8350_SLAVE_LLCC);
-DEFINE_QNODE(alm_sys_tcu, SM8350_MASTER_SYS_TCU, 1, 8, SM8350_SLAVE_GEM_NOC_CNOC, SM8350_SLAVE_LLCC);
-DEFINE_QNODE(chm_apps, SM8350_MASTER_APPSS_PROC, 2, 32, SM8350_SLAVE_GEM_NOC_CNOC, SM8350_SLAVE_LLCC, SM8350_SLAVE_MEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(qnm_cmpnoc, SM8350_MASTER_COMPUTE_NOC, 2, 32, SM8350_SLAVE_GEM_NOC_CNOC, SM8350_SLAVE_LLCC);
-DEFINE_QNODE(qnm_gemnoc_cfg, SM8350_MASTER_GEM_NOC_CFG, 1, 4, SM8350_SLAVE_MSS_PROC_MS_MPU_CFG, SM8350_SLAVE_MCDMA_MS_MPU_CFG, SM8350_SLAVE_SERVICE_GEM_NOC_1, SM8350_SLAVE_SERVICE_GEM_NOC_2, SM8350_SLAVE_SERVICE_GEM_NOC);
-DEFINE_QNODE(qnm_gpu, SM8350_MASTER_GFX3D, 2, 32, SM8350_SLAVE_GEM_NOC_CNOC, SM8350_SLAVE_LLCC);
-DEFINE_QNODE(qnm_mnoc_hf, SM8350_MASTER_MNOC_HF_MEM_NOC, 2, 32, SM8350_SLAVE_LLCC);
-DEFINE_QNODE(qnm_mnoc_sf, SM8350_MASTER_MNOC_SF_MEM_NOC, 2, 32, SM8350_SLAVE_GEM_NOC_CNOC, SM8350_SLAVE_LLCC);
-DEFINE_QNODE(qnm_pcie, SM8350_MASTER_ANOC_PCIE_GEM_NOC, 1, 16, SM8350_SLAVE_GEM_NOC_CNOC, SM8350_SLAVE_LLCC);
-DEFINE_QNODE(qnm_snoc_gc, SM8350_MASTER_SNOC_GC_MEM_NOC, 1, 8, SM8350_SLAVE_LLCC);
-DEFINE_QNODE(qnm_snoc_sf, SM8350_MASTER_SNOC_SF_MEM_NOC, 1, 16, SM8350_SLAVE_GEM_NOC_CNOC, SM8350_SLAVE_LLCC, SM8350_SLAVE_MEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(qhm_config_noc, SM8350_MASTER_CNOC_LPASS_AG_NOC, 1, 4, SM8350_SLAVE_LPASS_CORE_CFG, SM8350_SLAVE_LPASS_LPI_CFG, SM8350_SLAVE_LPASS_MPU_CFG, SM8350_SLAVE_LPASS_TOP_CFG, SM8350_SLAVE_SERVICES_LPASS_AML_NOC, SM8350_SLAVE_SERVICE_LPASS_AG_NOC);
-DEFINE_QNODE(llcc_mc, SM8350_MASTER_LLCC, 4, 4, SM8350_SLAVE_EBI1);
-DEFINE_QNODE(qnm_camnoc_hf, SM8350_MASTER_CAMNOC_HF, 2, 32, SM8350_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qnm_camnoc_icp, SM8350_MASTER_CAMNOC_ICP, 1, 8, SM8350_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qnm_camnoc_sf, SM8350_MASTER_CAMNOC_SF, 2, 32, SM8350_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qnm_mnoc_cfg, SM8350_MASTER_CNOC_MNOC_CFG, 1, 4, SM8350_SLAVE_SERVICE_MNOC);
-DEFINE_QNODE(qnm_video0, SM8350_MASTER_VIDEO_P0, 1, 32, SM8350_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qnm_video1, SM8350_MASTER_VIDEO_P1, 1, 32, SM8350_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qnm_video_cvp, SM8350_MASTER_VIDEO_PROC, 1, 32, SM8350_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_mdp0, SM8350_MASTER_MDP0, 1, 32, SM8350_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_mdp1, SM8350_MASTER_MDP1, 1, 32, SM8350_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_rot, SM8350_MASTER_ROTATOR, 1, 32, SM8350_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qhm_nsp_noc_config, SM8350_MASTER_CDSP_NOC_CFG, 1, 4, SM8350_SLAVE_SERVICE_NSP_NOC);
-DEFINE_QNODE(qxm_nsp, SM8350_MASTER_CDSP_PROC, 2, 32, SM8350_SLAVE_CDSP_MEM_NOC);
-DEFINE_QNODE(qnm_aggre1_noc, SM8350_MASTER_A1NOC_SNOC, 1, 16, SM8350_SLAVE_SNOC_GEM_NOC_SF);
-DEFINE_QNODE(qnm_aggre2_noc, SM8350_MASTER_A2NOC_SNOC, 1, 16, SM8350_SLAVE_SNOC_GEM_NOC_SF);
-DEFINE_QNODE(qnm_snoc_cfg, SM8350_MASTER_SNOC_CFG, 1, 4, SM8350_SLAVE_SERVICE_SNOC);
-DEFINE_QNODE(qxm_pimem, SM8350_MASTER_PIMEM, 1, 8, SM8350_SLAVE_SNOC_GEM_NOC_GC);
-DEFINE_QNODE(xm_gic, SM8350_MASTER_GIC, 1, 8, SM8350_SLAVE_SNOC_GEM_NOC_GC);
-DEFINE_QNODE(qnm_mnoc_hf_disp, SM8350_MASTER_MNOC_HF_MEM_NOC_DISP, 2, 32, SM8350_SLAVE_LLCC_DISP);
-DEFINE_QNODE(qnm_mnoc_sf_disp, SM8350_MASTER_MNOC_SF_MEM_NOC_DISP, 2, 32, SM8350_SLAVE_LLCC_DISP);
-DEFINE_QNODE(llcc_mc_disp, SM8350_MASTER_LLCC_DISP, 4, 4, SM8350_SLAVE_EBI1_DISP);
-DEFINE_QNODE(qxm_mdp0_disp, SM8350_MASTER_MDP0_DISP, 1, 32, SM8350_SLAVE_MNOC_HF_MEM_NOC_DISP);
-DEFINE_QNODE(qxm_mdp1_disp, SM8350_MASTER_MDP1_DISP, 1, 32, SM8350_SLAVE_MNOC_HF_MEM_NOC_DISP);
-DEFINE_QNODE(qxm_rot_disp, SM8350_MASTER_ROTATOR_DISP, 1, 32, SM8350_SLAVE_MNOC_SF_MEM_NOC_DISP);
-DEFINE_QNODE(qns_a1noc_snoc, SM8350_SLAVE_A1NOC_SNOC, 1, 16, SM8350_MASTER_A1NOC_SNOC);
-DEFINE_QNODE(srvc_aggre1_noc, SM8350_SLAVE_SERVICE_A1NOC, 1, 4);
-DEFINE_QNODE(qns_a2noc_snoc, SM8350_SLAVE_A2NOC_SNOC, 1, 16, SM8350_MASTER_A2NOC_SNOC);
-DEFINE_QNODE(qns_pcie_mem_noc, SM8350_SLAVE_ANOC_PCIE_GEM_NOC, 1, 16, SM8350_MASTER_ANOC_PCIE_GEM_NOC);
-DEFINE_QNODE(srvc_aggre2_noc, SM8350_SLAVE_SERVICE_A2NOC, 1, 4);
-DEFINE_QNODE(qhs_ahb2phy0, SM8350_SLAVE_AHB2PHY_SOUTH, 1, 4);
-DEFINE_QNODE(qhs_ahb2phy1, SM8350_SLAVE_AHB2PHY_NORTH, 1, 4);
-DEFINE_QNODE(qhs_aoss, SM8350_SLAVE_AOSS, 1, 4);
-DEFINE_QNODE(qhs_apss, SM8350_SLAVE_APPSS, 1, 8);
-DEFINE_QNODE(qhs_camera_cfg, SM8350_SLAVE_CAMERA_CFG, 1, 4);
-DEFINE_QNODE(qhs_clk_ctl, SM8350_SLAVE_CLK_CTL, 1, 4);
-DEFINE_QNODE(qhs_compute_cfg, SM8350_SLAVE_CDSP_CFG, 1, 4);
-DEFINE_QNODE(qhs_cpr_cx, SM8350_SLAVE_RBCPR_CX_CFG, 1, 4);
-DEFINE_QNODE(qhs_cpr_mmcx, SM8350_SLAVE_RBCPR_MMCX_CFG, 1, 4);
-DEFINE_QNODE(qhs_cpr_mx, SM8350_SLAVE_RBCPR_MX_CFG, 1, 4);
-DEFINE_QNODE(qhs_crypto0_cfg, SM8350_SLAVE_CRYPTO_0_CFG, 1, 4);
-DEFINE_QNODE(qhs_cx_rdpm, SM8350_SLAVE_CX_RDPM, 1, 4);
-DEFINE_QNODE(qhs_dcc_cfg, SM8350_SLAVE_DCC_CFG, 1, 4);
-DEFINE_QNODE(qhs_display_cfg, SM8350_SLAVE_DISPLAY_CFG, 1, 4);
-DEFINE_QNODE(qhs_gpuss_cfg, SM8350_SLAVE_GFX3D_CFG, 1, 8);
-DEFINE_QNODE(qhs_hwkm, SM8350_SLAVE_HWKM, 1, 4);
-DEFINE_QNODE(qhs_imem_cfg, SM8350_SLAVE_IMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_ipa, SM8350_SLAVE_IPA_CFG, 1, 4);
-DEFINE_QNODE(qhs_ipc_router, SM8350_SLAVE_IPC_ROUTER_CFG, 1, 4);
-DEFINE_QNODE(qhs_lpass_cfg, SM8350_SLAVE_LPASS, 1, 4, SM8350_MASTER_CNOC_LPASS_AG_NOC);
-DEFINE_QNODE(qhs_mss_cfg, SM8350_SLAVE_CNOC_MSS, 1, 4);
-DEFINE_QNODE(qhs_mx_rdpm, SM8350_SLAVE_MX_RDPM, 1, 4);
-DEFINE_QNODE(qhs_pcie0_cfg, SM8350_SLAVE_PCIE_0_CFG, 1, 4);
-DEFINE_QNODE(qhs_pcie1_cfg, SM8350_SLAVE_PCIE_1_CFG, 1, 4);
-DEFINE_QNODE(qhs_pdm, SM8350_SLAVE_PDM, 1, 4);
-DEFINE_QNODE(qhs_pimem_cfg, SM8350_SLAVE_PIMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_pka_wrapper_cfg, SM8350_SLAVE_PKA_WRAPPER_CFG, 1, 4);
-DEFINE_QNODE(qhs_pmu_wrapper_cfg, SM8350_SLAVE_PMU_WRAPPER_CFG, 1, 4);
-DEFINE_QNODE(qhs_qdss_cfg, SM8350_SLAVE_QDSS_CFG, 1, 4);
-DEFINE_QNODE(qhs_qspi, SM8350_SLAVE_QSPI_0, 1, 4);
-DEFINE_QNODE(qhs_qup0, SM8350_SLAVE_QUP_0, 1, 4);
-DEFINE_QNODE(qhs_qup1, SM8350_SLAVE_QUP_1, 1, 4);
-DEFINE_QNODE(qhs_qup2, SM8350_SLAVE_QUP_2, 1, 4);
-DEFINE_QNODE(qhs_sdc2, SM8350_SLAVE_SDCC_2, 1, 4);
-DEFINE_QNODE(qhs_sdc4, SM8350_SLAVE_SDCC_4, 1, 4);
-DEFINE_QNODE(qhs_security, SM8350_SLAVE_SECURITY, 1, 4);
-DEFINE_QNODE(qhs_spss_cfg, SM8350_SLAVE_SPSS_CFG, 1, 4);
-DEFINE_QNODE(qhs_tcsr, SM8350_SLAVE_TCSR, 1, 4);
-DEFINE_QNODE(qhs_tlmm, SM8350_SLAVE_TLMM, 1, 4);
-DEFINE_QNODE(qhs_ufs_card_cfg, SM8350_SLAVE_UFS_CARD_CFG, 1, 4);
-DEFINE_QNODE(qhs_ufs_mem_cfg, SM8350_SLAVE_UFS_MEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_usb3_0, SM8350_SLAVE_USB3_0, 1, 4);
-DEFINE_QNODE(qhs_usb3_1, SM8350_SLAVE_USB3_1, 1, 4);
-DEFINE_QNODE(qhs_venus_cfg, SM8350_SLAVE_VENUS_CFG, 1, 4);
-DEFINE_QNODE(qhs_vsense_ctrl_cfg, SM8350_SLAVE_VSENSE_CTRL_CFG, 1, 4);
-DEFINE_QNODE(qns_a1_noc_cfg, SM8350_SLAVE_A1NOC_CFG, 1, 4);
-DEFINE_QNODE(qns_a2_noc_cfg, SM8350_SLAVE_A2NOC_CFG, 1, 4);
-DEFINE_QNODE(qns_ddrss_cfg, SM8350_SLAVE_DDRSS_CFG, 1, 4);
-DEFINE_QNODE(qns_mnoc_cfg, SM8350_SLAVE_CNOC_MNOC_CFG, 1, 4);
-DEFINE_QNODE(qns_snoc_cfg, SM8350_SLAVE_SNOC_CFG, 1, 4);
-DEFINE_QNODE(qxs_boot_imem, SM8350_SLAVE_BOOT_IMEM, 1, 8);
-DEFINE_QNODE(qxs_imem, SM8350_SLAVE_IMEM, 1, 8);
-DEFINE_QNODE(qxs_pimem, SM8350_SLAVE_PIMEM, 1, 8);
-DEFINE_QNODE(srvc_cnoc, SM8350_SLAVE_SERVICE_CNOC, 1, 4);
-DEFINE_QNODE(xs_pcie_0, SM8350_SLAVE_PCIE_0, 1, 8);
-DEFINE_QNODE(xs_pcie_1, SM8350_SLAVE_PCIE_1, 1, 8);
-DEFINE_QNODE(xs_qdss_stm, SM8350_SLAVE_QDSS_STM, 1, 4);
-DEFINE_QNODE(xs_sys_tcu_cfg, SM8350_SLAVE_TCU, 1, 8);
-DEFINE_QNODE(qhs_llcc, SM8350_SLAVE_LLCC_CFG, 1, 4);
-DEFINE_QNODE(qns_gemnoc, SM8350_SLAVE_GEM_NOC_CFG, 1, 4);
-DEFINE_QNODE(qhs_mdsp_ms_mpu_cfg, SM8350_SLAVE_MSS_PROC_MS_MPU_CFG, 1, 4);
-DEFINE_QNODE(qhs_modem_ms_mpu_cfg, SM8350_SLAVE_MCDMA_MS_MPU_CFG, 1, 4);
-DEFINE_QNODE(qns_gem_noc_cnoc, SM8350_SLAVE_GEM_NOC_CNOC, 1, 16, SM8350_MASTER_GEM_NOC_CNOC);
-DEFINE_QNODE(qns_llcc, SM8350_SLAVE_LLCC, 4, 16, SM8350_MASTER_LLCC);
-DEFINE_QNODE(qns_pcie, SM8350_SLAVE_MEM_NOC_PCIE_SNOC, 1, 8);
-DEFINE_QNODE(srvc_even_gemnoc, SM8350_SLAVE_SERVICE_GEM_NOC_1, 1, 4);
-DEFINE_QNODE(srvc_odd_gemnoc, SM8350_SLAVE_SERVICE_GEM_NOC_2, 1, 4);
-DEFINE_QNODE(srvc_sys_gemnoc, SM8350_SLAVE_SERVICE_GEM_NOC, 1, 4);
-DEFINE_QNODE(qhs_lpass_core, SM8350_SLAVE_LPASS_CORE_CFG, 1, 4);
-DEFINE_QNODE(qhs_lpass_lpi, SM8350_SLAVE_LPASS_LPI_CFG, 1, 4);
-DEFINE_QNODE(qhs_lpass_mpu, SM8350_SLAVE_LPASS_MPU_CFG, 1, 4);
-DEFINE_QNODE(qhs_lpass_top, SM8350_SLAVE_LPASS_TOP_CFG, 1, 4);
-DEFINE_QNODE(srvc_niu_aml_noc, SM8350_SLAVE_SERVICES_LPASS_AML_NOC, 1, 4);
-DEFINE_QNODE(srvc_niu_lpass_agnoc, SM8350_SLAVE_SERVICE_LPASS_AG_NOC, 1, 4);
-DEFINE_QNODE(ebi, SM8350_SLAVE_EBI1, 4, 4);
-DEFINE_QNODE(qns_mem_noc_hf, SM8350_SLAVE_MNOC_HF_MEM_NOC, 2, 32, SM8350_MASTER_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qns_mem_noc_sf, SM8350_SLAVE_MNOC_SF_MEM_NOC, 2, 32, SM8350_MASTER_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(srvc_mnoc, SM8350_SLAVE_SERVICE_MNOC, 1, 4);
-DEFINE_QNODE(qns_nsp_gemnoc, SM8350_SLAVE_CDSP_MEM_NOC, 2, 32, SM8350_MASTER_COMPUTE_NOC);
-DEFINE_QNODE(service_nsp_noc, SM8350_SLAVE_SERVICE_NSP_NOC, 1, 4);
-DEFINE_QNODE(qns_gemnoc_gc, SM8350_SLAVE_SNOC_GEM_NOC_GC, 1, 8, SM8350_MASTER_SNOC_GC_MEM_NOC);
-DEFINE_QNODE(qns_gemnoc_sf, SM8350_SLAVE_SNOC_GEM_NOC_SF, 1, 16, SM8350_MASTER_SNOC_SF_MEM_NOC);
-DEFINE_QNODE(srvc_snoc, SM8350_SLAVE_SERVICE_SNOC, 1, 4);
-DEFINE_QNODE(qns_llcc_disp, SM8350_SLAVE_LLCC_DISP, 4, 16, SM8350_MASTER_LLCC_DISP);
-DEFINE_QNODE(ebi_disp, SM8350_SLAVE_EBI1_DISP, 4, 4);
-DEFINE_QNODE(qns_mem_noc_hf_disp, SM8350_SLAVE_MNOC_HF_MEM_NOC_DISP, 2, 32, SM8350_MASTER_MNOC_HF_MEM_NOC_DISP);
-DEFINE_QNODE(qns_mem_noc_sf_disp, SM8350_SLAVE_MNOC_SF_MEM_NOC_DISP, 2, 32, SM8350_MASTER_MNOC_SF_MEM_NOC_DISP);
+static struct qcom_icc_node qhm_qspi = {
+	.name = "qhm_qspi",
+	.id = SM8350_MASTER_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup0 = {
+	.name = "qhm_qup0",
+	.id = SM8350_MASTER_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.id = SM8350_MASTER_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup2 = {
+	.name = "qhm_qup2",
+	.id = SM8350_MASTER_QUP_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_a1noc_cfg = {
+	.name = "qnm_a1noc_cfg",
+	.id = SM8350_MASTER_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_SERVICE_A1NOC },
+};
+
+static struct qcom_icc_node xm_sdc4 = {
+	.name = "xm_sdc4",
+	.id = SM8350_MASTER_SDCC_4,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = SM8350_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.id = SM8350_MASTER_USB3_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb3_1 = {
+	.name = "xm_usb3_1",
+	.id = SM8350_MASTER_USB3_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SM8350_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_a2noc_cfg = {
+	.name = "qnm_a2noc_cfg",
+	.id = SM8350_MASTER_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_SERVICE_A2NOC },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SM8350_MASTER_CRYPTO,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.id = SM8350_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_pcie3_0 = {
+	.name = "xm_pcie3_0",
+	.id = SM8350_MASTER_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie3_1 = {
+	.name = "xm_pcie3_1",
+	.id = SM8350_MASTER_PCIE_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr = {
+	.name = "xm_qdss_etr",
+	.id = SM8350_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.id = SM8350_MASTER_SDCC_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ufs_card = {
+	.name = "xm_ufs_card",
+	.id = SM8350_MASTER_UFS_CARD,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_gemnoc_cnoc = {
+	.name = "qnm_gemnoc_cnoc",
+	.id = SM8350_MASTER_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 56,
+	.links = { SM8350_SLAVE_AHB2PHY_SOUTH,
+		   SM8350_SLAVE_AHB2PHY_NORTH,
+		   SM8350_SLAVE_AOSS,
+		   SM8350_SLAVE_APPSS,
+		   SM8350_SLAVE_CAMERA_CFG,
+		   SM8350_SLAVE_CLK_CTL,
+		   SM8350_SLAVE_CDSP_CFG,
+		   SM8350_SLAVE_RBCPR_CX_CFG,
+		   SM8350_SLAVE_RBCPR_MMCX_CFG,
+		   SM8350_SLAVE_RBCPR_MX_CFG,
+		   SM8350_SLAVE_CRYPTO_0_CFG,
+		   SM8350_SLAVE_CX_RDPM,
+		   SM8350_SLAVE_DCC_CFG,
+		   SM8350_SLAVE_DISPLAY_CFG,
+		   SM8350_SLAVE_GFX3D_CFG,
+		   SM8350_SLAVE_HWKM,
+		   SM8350_SLAVE_IMEM_CFG,
+		   SM8350_SLAVE_IPA_CFG,
+		   SM8350_SLAVE_IPC_ROUTER_CFG,
+		   SM8350_SLAVE_LPASS,
+		   SM8350_SLAVE_CNOC_MSS,
+		   SM8350_SLAVE_MX_RDPM,
+		   SM8350_SLAVE_PCIE_0_CFG,
+		   SM8350_SLAVE_PCIE_1_CFG,
+		   SM8350_SLAVE_PDM,
+		   SM8350_SLAVE_PIMEM_CFG,
+		   SM8350_SLAVE_PKA_WRAPPER_CFG,
+		   SM8350_SLAVE_PMU_WRAPPER_CFG,
+		   SM8350_SLAVE_QDSS_CFG,
+		   SM8350_SLAVE_QSPI_0,
+		   SM8350_SLAVE_QUP_0,
+		   SM8350_SLAVE_QUP_1,
+		   SM8350_SLAVE_QUP_2,
+		   SM8350_SLAVE_SDCC_2,
+		   SM8350_SLAVE_SDCC_4,
+		   SM8350_SLAVE_SECURITY,
+		   SM8350_SLAVE_SPSS_CFG,
+		   SM8350_SLAVE_TCSR,
+		   SM8350_SLAVE_TLMM,
+		   SM8350_SLAVE_UFS_CARD_CFG,
+		   SM8350_SLAVE_UFS_MEM_CFG,
+		   SM8350_SLAVE_USB3_0,
+		   SM8350_SLAVE_USB3_1,
+		   SM8350_SLAVE_VENUS_CFG,
+		   SM8350_SLAVE_VSENSE_CTRL_CFG,
+		   SM8350_SLAVE_A1NOC_CFG,
+		   SM8350_SLAVE_A2NOC_CFG,
+		   SM8350_SLAVE_DDRSS_CFG,
+		   SM8350_SLAVE_CNOC_MNOC_CFG,
+		   SM8350_SLAVE_SNOC_CFG,
+		   SM8350_SLAVE_BOOT_IMEM,
+		   SM8350_SLAVE_IMEM,
+		   SM8350_SLAVE_PIMEM,
+		   SM8350_SLAVE_SERVICE_CNOC,
+		   SM8350_SLAVE_QDSS_STM,
+		   SM8350_SLAVE_TCU
+	},
+};
+
+static struct qcom_icc_node qnm_gemnoc_pcie = {
+	.name = "qnm_gemnoc_pcie",
+	.id = SM8350_MASTER_GEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM8350_SLAVE_PCIE_0,
+		   SM8350_SLAVE_PCIE_1
+	},
+};
+
+static struct qcom_icc_node xm_qdss_dap = {
+	.name = "xm_qdss_dap",
+	.id = SM8350_MASTER_QDSS_DAP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 56,
+	.links = { SM8350_SLAVE_AHB2PHY_SOUTH,
+		   SM8350_SLAVE_AHB2PHY_NORTH,
+		   SM8350_SLAVE_AOSS,
+		   SM8350_SLAVE_APPSS,
+		   SM8350_SLAVE_CAMERA_CFG,
+		   SM8350_SLAVE_CLK_CTL,
+		   SM8350_SLAVE_CDSP_CFG,
+		   SM8350_SLAVE_RBCPR_CX_CFG,
+		   SM8350_SLAVE_RBCPR_MMCX_CFG,
+		   SM8350_SLAVE_RBCPR_MX_CFG,
+		   SM8350_SLAVE_CRYPTO_0_CFG,
+		   SM8350_SLAVE_CX_RDPM,
+		   SM8350_SLAVE_DCC_CFG,
+		   SM8350_SLAVE_DISPLAY_CFG,
+		   SM8350_SLAVE_GFX3D_CFG,
+		   SM8350_SLAVE_HWKM,
+		   SM8350_SLAVE_IMEM_CFG,
+		   SM8350_SLAVE_IPA_CFG,
+		   SM8350_SLAVE_IPC_ROUTER_CFG,
+		   SM8350_SLAVE_LPASS,
+		   SM8350_SLAVE_CNOC_MSS,
+		   SM8350_SLAVE_MX_RDPM,
+		   SM8350_SLAVE_PCIE_0_CFG,
+		   SM8350_SLAVE_PCIE_1_CFG,
+		   SM8350_SLAVE_PDM,
+		   SM8350_SLAVE_PIMEM_CFG,
+		   SM8350_SLAVE_PKA_WRAPPER_CFG,
+		   SM8350_SLAVE_PMU_WRAPPER_CFG,
+		   SM8350_SLAVE_QDSS_CFG,
+		   SM8350_SLAVE_QSPI_0,
+		   SM8350_SLAVE_QUP_0,
+		   SM8350_SLAVE_QUP_1,
+		   SM8350_SLAVE_QUP_2,
+		   SM8350_SLAVE_SDCC_2,
+		   SM8350_SLAVE_SDCC_4,
+		   SM8350_SLAVE_SECURITY,
+		   SM8350_SLAVE_SPSS_CFG,
+		   SM8350_SLAVE_TCSR,
+		   SM8350_SLAVE_TLMM,
+		   SM8350_SLAVE_UFS_CARD_CFG,
+		   SM8350_SLAVE_UFS_MEM_CFG,
+		   SM8350_SLAVE_USB3_0,
+		   SM8350_SLAVE_USB3_1,
+		   SM8350_SLAVE_VENUS_CFG,
+		   SM8350_SLAVE_VSENSE_CTRL_CFG,
+		   SM8350_SLAVE_A1NOC_CFG,
+		   SM8350_SLAVE_A2NOC_CFG,
+		   SM8350_SLAVE_DDRSS_CFG,
+		   SM8350_SLAVE_CNOC_MNOC_CFG,
+		   SM8350_SLAVE_SNOC_CFG,
+		   SM8350_SLAVE_BOOT_IMEM,
+		   SM8350_SLAVE_IMEM,
+		   SM8350_SLAVE_PIMEM,
+		   SM8350_SLAVE_SERVICE_CNOC,
+		   SM8350_SLAVE_QDSS_STM,
+		   SM8350_SLAVE_TCU
+	},
+};
+
+static struct qcom_icc_node qnm_cnoc_dc_noc = {
+	.name = "qnm_cnoc_dc_noc",
+	.id = SM8350_MASTER_CNOC_DC_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { SM8350_SLAVE_LLCC_CFG,
+		   SM8350_SLAVE_GEM_NOC_CFG
+	},
+};
+
+static struct qcom_icc_node alm_gpu_tcu = {
+	.name = "alm_gpu_tcu",
+	.id = SM8350_MASTER_GPU_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM8350_SLAVE_GEM_NOC_CNOC,
+		   SM8350_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node alm_sys_tcu = {
+	.name = "alm_sys_tcu",
+	.id = SM8350_MASTER_SYS_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM8350_SLAVE_GEM_NOC_CNOC,
+		   SM8350_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.id = SM8350_MASTER_APPSS_PROC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SM8350_SLAVE_GEM_NOC_CNOC,
+		   SM8350_SLAVE_LLCC,
+		   SM8350_SLAVE_MEM_NOC_PCIE_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_cmpnoc = {
+	.name = "qnm_cmpnoc",
+	.id = SM8350_MASTER_COMPUTE_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM8350_SLAVE_GEM_NOC_CNOC,
+		   SM8350_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node qnm_gemnoc_cfg = {
+	.name = "qnm_gemnoc_cfg",
+	.id = SM8350_MASTER_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 5,
+	.links = { SM8350_SLAVE_MSS_PROC_MS_MPU_CFG,
+		   SM8350_SLAVE_MCDMA_MS_MPU_CFG,
+		   SM8350_SLAVE_SERVICE_GEM_NOC_1,
+		   SM8350_SLAVE_SERVICE_GEM_NOC_2,
+		   SM8350_SLAVE_SERVICE_GEM_NOC
+	},
+};
+
+static struct qcom_icc_node qnm_gpu = {
+	.name = "qnm_gpu",
+	.id = SM8350_MASTER_GFX3D,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM8350_SLAVE_GEM_NOC_CNOC,
+		   SM8350_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = SM8350_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = SM8350_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM8350_SLAVE_GEM_NOC_CNOC,
+		   SM8350_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.id = SM8350_MASTER_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 2,
+	.links = { SM8350_SLAVE_GEM_NOC_CNOC,
+		   SM8350_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SM8350_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SM8350_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SM8350_SLAVE_GEM_NOC_CNOC,
+		   SM8350_SLAVE_LLCC,
+		   SM8350_SLAVE_MEM_NOC_PCIE_SNOC
+	},
+};
+
+static struct qcom_icc_node qhm_config_noc = {
+	.name = "qhm_config_noc",
+	.id = SM8350_MASTER_CNOC_LPASS_AG_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 6,
+	.links = { SM8350_SLAVE_LPASS_CORE_CFG,
+		   SM8350_SLAVE_LPASS_LPI_CFG,
+		   SM8350_SLAVE_LPASS_MPU_CFG,
+		   SM8350_SLAVE_LPASS_TOP_CFG,
+		   SM8350_SLAVE_SERVICES_LPASS_AML_NOC,
+		   SM8350_SLAVE_SERVICE_LPASS_AG_NOC
+	},
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SM8350_MASTER_LLCC,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_EBI1 },
+};
+
+static struct qcom_icc_node qnm_camnoc_hf = {
+	.name = "qnm_camnoc_hf",
+	.id = SM8350_MASTER_CAMNOC_HF,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_icp = {
+	.name = "qnm_camnoc_icp",
+	.id = SM8350_MASTER_CAMNOC_ICP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_sf = {
+	.name = "qnm_camnoc_sf",
+	.id = SM8350_MASTER_CAMNOC_SF,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_mnoc_cfg = {
+	.name = "qnm_mnoc_cfg",
+	.id = SM8350_MASTER_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_SERVICE_MNOC },
+};
+
+static struct qcom_icc_node qnm_video0 = {
+	.name = "qnm_video0",
+	.id = SM8350_MASTER_VIDEO_P0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video1 = {
+	.name = "qnm_video1",
+	.id = SM8350_MASTER_VIDEO_P1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video_cvp = {
+	.name = "qnm_video_cvp",
+	.id = SM8350_MASTER_VIDEO_PROC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_mdp0 = {
+	.name = "qxm_mdp0",
+	.id = SM8350_MASTER_MDP0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_mdp1 = {
+	.name = "qxm_mdp1",
+	.id = SM8350_MASTER_MDP1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_rot = {
+	.name = "qxm_rot",
+	.id = SM8350_MASTER_ROTATOR,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qhm_nsp_noc_config = {
+	.name = "qhm_nsp_noc_config",
+	.id = SM8350_MASTER_CDSP_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_SERVICE_NSP_NOC },
+};
+
+static struct qcom_icc_node qxm_nsp = {
+	.name = "qxm_nsp",
+	.id = SM8350_MASTER_CDSP_PROC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_CDSP_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = SM8350_MASTER_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.id = SM8350_MASTER_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_snoc_cfg = {
+	.name = "qnm_snoc_cfg",
+	.id = SM8350_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_SERVICE_SNOC },
+};
+
+static struct qcom_icc_node qxm_pimem = {
+	.name = "qxm_pimem",
+	.id = SM8350_MASTER_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_SNOC_GEM_NOC_GC },
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = SM8350_MASTER_GIC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_SNOC_GEM_NOC_GC },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf_disp = {
+	.name = "qnm_mnoc_hf_disp",
+	.id = SM8350_MASTER_MNOC_HF_MEM_NOC_DISP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_LLCC_DISP },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf_disp = {
+	.name = "qnm_mnoc_sf_disp",
+	.id = SM8350_MASTER_MNOC_SF_MEM_NOC_DISP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_LLCC_DISP },
+};
+
+static struct qcom_icc_node llcc_mc_disp = {
+	.name = "llcc_mc_disp",
+	.id = SM8350_MASTER_LLCC_DISP,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_EBI1_DISP },
+};
+
+static struct qcom_icc_node qxm_mdp0_disp = {
+	.name = "qxm_mdp0_disp",
+	.id = SM8350_MASTER_MDP0_DISP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_MNOC_HF_MEM_NOC_DISP },
+};
+
+static struct qcom_icc_node qxm_mdp1_disp = {
+	.name = "qxm_mdp1_disp",
+	.id = SM8350_MASTER_MDP1_DISP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_MNOC_HF_MEM_NOC_DISP },
+};
+
+static struct qcom_icc_node qxm_rot_disp = {
+	.name = "qxm_rot_disp",
+	.id = SM8350_MASTER_ROTATOR_DISP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_MNOC_SF_MEM_NOC_DISP },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = SM8350_SLAVE_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8350_MASTER_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node srvc_aggre1_noc = {
+	.name = "srvc_aggre1_noc",
+	.id = SM8350_SLAVE_SERVICE_A1NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.id = SM8350_SLAVE_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8350_MASTER_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_pcie_mem_noc = {
+	.name = "qns_pcie_mem_noc",
+	.id = SM8350_SLAVE_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8350_MASTER_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node srvc_aggre2_noc = {
+	.name = "srvc_aggre2_noc",
+	.id = SM8350_SLAVE_SERVICE_A2NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy0 = {
+	.name = "qhs_ahb2phy0",
+	.id = SM8350_SLAVE_AHB2PHY_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy1 = {
+	.name = "qhs_ahb2phy1",
+	.id = SM8350_SLAVE_AHB2PHY_NORTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SM8350_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.id = SM8350_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = SM8350_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SM8350_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_compute_cfg = {
+	.name = "qhs_compute_cfg",
+	.id = SM8350_SLAVE_CDSP_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.id = SM8350_SLAVE_RBCPR_CX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_mmcx = {
+	.name = "qhs_cpr_mmcx",
+	.id = SM8350_SLAVE_RBCPR_MMCX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_mx = {
+	.name = "qhs_cpr_mx",
+	.id = SM8350_SLAVE_RBCPR_MX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SM8350_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cx_rdpm = {
+	.name = "qhs_cx_rdpm",
+	.id = SM8350_SLAVE_CX_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_dcc_cfg = {
+	.name = "qhs_dcc_cfg",
+	.id = SM8350_SLAVE_DCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.id = SM8350_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = SM8350_SLAVE_GFX3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_hwkm = {
+	.name = "qhs_hwkm",
+	.id = SM8350_SLAVE_HWKM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SM8350_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SM8350_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipc_router = {
+	.name = "qhs_ipc_router",
+	.id = SM8350_SLAVE_IPC_ROUTER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_lpass_cfg = {
+	.name = "qhs_lpass_cfg",
+	.id = SM8350_SLAVE_LPASS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8350_MASTER_CNOC_LPASS_AG_NOC },
+};
+
+static struct qcom_icc_node qhs_mss_cfg = {
+	.name = "qhs_mss_cfg",
+	.id = SM8350_SLAVE_CNOC_MSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mx_rdpm = {
+	.name = "qhs_mx_rdpm",
+	.id = SM8350_SLAVE_MX_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie0_cfg = {
+	.name = "qhs_pcie0_cfg",
+	.id = SM8350_SLAVE_PCIE_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie1_cfg = {
+	.name = "qhs_pcie1_cfg",
+	.id = SM8350_SLAVE_PCIE_1_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SM8350_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pimem_cfg = {
+	.name = "qhs_pimem_cfg",
+	.id = SM8350_SLAVE_PIMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pka_wrapper_cfg = {
+	.name = "qhs_pka_wrapper_cfg",
+	.id = SM8350_SLAVE_PKA_WRAPPER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pmu_wrapper_cfg = {
+	.name = "qhs_pmu_wrapper_cfg",
+	.id = SM8350_SLAVE_PMU_WRAPPER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SM8350_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qspi = {
+	.name = "qhs_qspi",
+	.id = SM8350_SLAVE_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup0 = {
+	.name = "qhs_qup0",
+	.id = SM8350_SLAVE_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.id = SM8350_SLAVE_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup2 = {
+	.name = "qhs_qup2",
+	.id = SM8350_SLAVE_QUP_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.id = SM8350_SLAVE_SDCC_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc4 = {
+	.name = "qhs_sdc4",
+	.id = SM8350_SLAVE_SDCC_4,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_security = {
+	.name = "qhs_security",
+	.id = SM8350_SLAVE_SECURITY,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_spss_cfg = {
+	.name = "qhs_spss_cfg",
+	.id = SM8350_SLAVE_SPSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SM8350_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.id = SM8350_SLAVE_TLMM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_card_cfg = {
+	.name = "qhs_ufs_card_cfg",
+	.id = SM8350_SLAVE_UFS_CARD_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = SM8350_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_0 = {
+	.name = "qhs_usb3_0",
+	.id = SM8350_SLAVE_USB3_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_1 = {
+	.name = "qhs_usb3_1",
+	.id = SM8350_SLAVE_USB3_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = SM8350_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.id = SM8350_SLAVE_VSENSE_CTRL_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_a1_noc_cfg = {
+	.name = "qns_a1_noc_cfg",
+	.id = SM8350_SLAVE_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_a2_noc_cfg = {
+	.name = "qns_a2_noc_cfg",
+	.id = SM8350_SLAVE_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_ddrss_cfg = {
+	.name = "qns_ddrss_cfg",
+	.id = SM8350_SLAVE_DDRSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_mnoc_cfg = {
+	.name = "qns_mnoc_cfg",
+	.id = SM8350_SLAVE_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_snoc_cfg = {
+	.name = "qns_snoc_cfg",
+	.id = SM8350_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qxs_boot_imem = {
+	.name = "qxs_boot_imem",
+	.id = SM8350_SLAVE_BOOT_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SM8350_SLAVE_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qxs_pimem = {
+	.name = "qxs_pimem",
+	.id = SM8350_SLAVE_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node srvc_cnoc = {
+	.name = "srvc_cnoc",
+	.id = SM8350_SLAVE_SERVICE_CNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_pcie_0 = {
+	.name = "xs_pcie_0",
+	.id = SM8350_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_pcie_1 = {
+	.name = "xs_pcie_1",
+	.id = SM8350_SLAVE_PCIE_1,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SM8350_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SM8350_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_llcc = {
+	.name = "qhs_llcc",
+	.id = SM8350_SLAVE_LLCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_gemnoc = {
+	.name = "qns_gemnoc",
+	.id = SM8350_SLAVE_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
+	.name = "qhs_mdsp_ms_mpu_cfg",
+	.id = SM8350_SLAVE_MSS_PROC_MS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_modem_ms_mpu_cfg = {
+	.name = "qhs_modem_ms_mpu_cfg",
+	.id = SM8350_SLAVE_MCDMA_MS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_gem_noc_cnoc = {
+	.name = "qns_gem_noc_cnoc",
+	.id = SM8350_SLAVE_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8350_MASTER_GEM_NOC_CNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SM8350_SLAVE_LLCC,
+	.channels = 4,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8350_MASTER_LLCC },
+};
+
+static struct qcom_icc_node qns_pcie = {
+	.name = "qns_pcie",
+	.id = SM8350_SLAVE_MEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node srvc_even_gemnoc = {
+	.name = "srvc_even_gemnoc",
+	.id = SM8350_SLAVE_SERVICE_GEM_NOC_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node srvc_odd_gemnoc = {
+	.name = "srvc_odd_gemnoc",
+	.id = SM8350_SLAVE_SERVICE_GEM_NOC_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node srvc_sys_gemnoc = {
+	.name = "srvc_sys_gemnoc",
+	.id = SM8350_SLAVE_SERVICE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_lpass_core = {
+	.name = "qhs_lpass_core",
+	.id = SM8350_SLAVE_LPASS_CORE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_lpass_lpi = {
+	.name = "qhs_lpass_lpi",
+	.id = SM8350_SLAVE_LPASS_LPI_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_lpass_mpu = {
+	.name = "qhs_lpass_mpu",
+	.id = SM8350_SLAVE_LPASS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_lpass_top = {
+	.name = "qhs_lpass_top",
+	.id = SM8350_SLAVE_LPASS_TOP_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node srvc_niu_aml_noc = {
+	.name = "srvc_niu_aml_noc",
+	.id = SM8350_SLAVE_SERVICES_LPASS_AML_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node srvc_niu_lpass_agnoc = {
+	.name = "srvc_niu_lpass_agnoc",
+	.id = SM8350_SLAVE_SERVICE_LPASS_AG_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SM8350_SLAVE_EBI1,
+	.channels = 4,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = SM8350_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf = {
+	.name = "qns_mem_noc_sf",
+	.id = SM8350_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.id = SM8350_SLAVE_SERVICE_MNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_nsp_gemnoc = {
+	.name = "qns_nsp_gemnoc",
+	.id = SM8350_SLAVE_CDSP_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_MASTER_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node service_nsp_noc = {
+	.name = "service_nsp_noc",
+	.id = SM8350_SLAVE_SERVICE_NSP_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_gemnoc_gc = {
+	.name = "qns_gemnoc_gc",
+	.id = SM8350_SLAVE_SNOC_GEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = SM8350_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8350_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_snoc = {
+	.name = "srvc_snoc",
+	.id = SM8350_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_llcc_disp = {
+	.name = "qns_llcc_disp",
+	.id = SM8350_SLAVE_LLCC_DISP,
+	.channels = 4,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8350_MASTER_LLCC_DISP },
+};
+
+static struct qcom_icc_node ebi_disp = {
+	.name = "ebi_disp",
+	.id = SM8350_SLAVE_EBI1_DISP,
+	.channels = 4,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf_disp = {
+	.name = "qns_mem_noc_hf_disp",
+	.id = SM8350_SLAVE_MNOC_HF_MEM_NOC_DISP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_MASTER_MNOC_HF_MEM_NOC_DISP },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf_disp = {
+	.name = "qns_mem_noc_sf_disp",
+	.id = SM8350_SLAVE_MNOC_SF_MEM_NOC_DISP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_MASTER_MNOC_SF_MEM_NOC_DISP },
+};
 
 DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
 DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);

-- 
2.41.0

