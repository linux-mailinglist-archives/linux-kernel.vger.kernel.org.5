Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DD2778F18
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbjHKMQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbjHKMQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:16:09 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ACF3A82
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:49 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso30766731fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691756147; x=1692360947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mop90cKkBpF5TCwzNIPhJubqPUrBGBU9DIKG3Dp5FqA=;
        b=ni7zbyYAZ7emTvXV31sGF9iiItRfwhpN0ZJbM9CaQBvvRXkq6y6o0pKW8cOJKnUe1V
         ft+XGb4kyg1eNtAqouIJBd3sdlor0c2Jz+geaRRfMIdbvOgWwQWbFdpvR45gx/RAhJFA
         QVwVplBNBrlox+gXtlUdaINP6br8o9QoJ08rrwTeK/0AliHNkZTmh9lf4fF6cAvqitoc
         6H2lJg1DJvPOuOYCXVZ6WDYecP6eb5pDzx+PUfgHrhpuG80I0OiZSkjmst7Ic0nsFJDv
         bD46SZwAr6W9BW3EBa2RGIPpVYJepyU0r1xHgE7ZdixBuvPhCudspcHHzD5jLmxRmN96
         Hg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756147; x=1692360947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mop90cKkBpF5TCwzNIPhJubqPUrBGBU9DIKG3Dp5FqA=;
        b=cn17Nd6d/k3lIiFt/fgaVvH5WLqOWHKGhsQ+EHtGauPXWRWhfiU/SHQhVoCQCEXuJr
         9hBVqaQsdmot2viEQBY8QkAnykFskojx+L+Hc/7roTMtA++DG6vQ4CsVZ3pjeDrF/7Qw
         3hw1BIkMrygxtKZ/auwCQ+6tGMZngD+EeJIg3xGTyZfI16qf9AJfGPkDPBfrHHpiT2FW
         /N7iEZAEr5xZA4Sh/bIWDzK3+MJ4KWsd0Wx8P53pjoam66x1cdXM5s78xkrZEZBeePG4
         jujokNhorfBYYeVXMRg5TGTk6fZispZ9MFBKaQ13FHCZt/gEKP6B1/E4SgO1M0Ls8Q+r
         t/Gg==
X-Gm-Message-State: AOJu0Yx2IbP5Wlnmj7EO5DUOpcGnKxgIvIQ8XquhN9k7UdRpSFQ4GEso
        7+p7xJyYTElmn6sW8DdSpGscgw==
X-Google-Smtp-Source: AGHT+IGqDOBD8Zip4Vhaddn+ttQHTeIwPT6SqmPqfx1PMKNUbQ5QHF84SF10K5jM58E3KaRiPYT63A==
X-Received: by 2002:a2e:9c18:0:b0:2af:25cf:92ae with SMTP id s24-20020a2e9c18000000b002af25cf92aemr1632829lji.22.1691756147393;
        Fri, 11 Aug 2023 05:15:47 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e870c000000b002b9ec22d9fasm848487lji.29.2023.08.11.05.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:15:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 14:15:27 +0200
Subject: [PATCH 16/20] interconnect: qcom: sm6350: Retire DEFINE_QBCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_retire_macrosd-v1-16-c03aaeffc769@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691756124; l=7516;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xX9zqaJqbpB/lUALPx7EoYfJGnY9Jnw6CymD546xQ5M=;
 b=cZuFDyQDEISIy7N2WD5Rn2I7R+jqK18Jvf0t0jyOReGk4iUpsNZUmrsTu+gk1yFjCvznWdXFK
 67uwTgOBgEJDgSOc6T/cRv7hRgLF2b3xVlDj+tLCbSg86eXYvMExqGp
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
 drivers/interconnect/qcom/sm6350.c | 251 +++++++++++++++++++++++++++++++++----
 1 file changed, 226 insertions(+), 25 deletions(-)

diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index 54ebb67d179f..49aed492e9b8 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -1162,31 +1162,232 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.buswidth = 8,
 };
 
-DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
-DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_cn0, "CN0", true, &qnm_snoc, &xm_qdss_dap, &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_ahb2phy0, &qhs_aoss, &qhs_boot_rom, &qhs_camera_cfg, &qhs_camera_nrt_thrott_cfg, &qhs_camera_rt_throttle_cfg, &qhs_clk_ctl, &qhs_cpr_cx, &qhs_cpr_mx, &qhs_crypto0_cfg, &qhs_dcc_cfg, &qhs_ddrss_cfg, &qhs_display_cfg, &qhs_display_throttle_cfg, &qhs_glm, &qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_mnoc_cfg, &qhs_mss_cfg, &qhs_npu_cfg, &qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs_qm_cfg, &qhs_qm_mpu_cfg, &qhs_qup0, &qhs_qup1, &qhs_security, &qhs_snoc_cfg, &qhs_tcsr, &qhs_ufs_mem_cfg, &qhs_usb3_0, &qhs_venus_cfg, &qhs_venus_throttle_cfg, &qhs_vsense_ctrl_cfg, &srvc_cnoc);
-DEFINE_QBCM(bcm_cn1, "CN1", false, &xm_emmc, &xm_sdc2, &qhs_ahb2phy2, &qhs_emmc_cfg, &qhs_pdm, &qhs_sdc2);
-DEFINE_QBCM(bcm_co0, "CO0", false, &qns_cdsp_gemnoc);
-DEFINE_QBCM(bcm_co2, "CO2", false, &qnm_npu);
-DEFINE_QBCM(bcm_co3, "CO3", false, &qxm_npu_dsp);
-DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
-DEFINE_QBCM(bcm_mm0, "MM0", true, &qns_mem_noc_hf);
-DEFINE_QBCM(bcm_mm1, "MM1", true, &qxm_camnoc_hf0_uncomp, &qxm_camnoc_icp_uncomp, &qxm_camnoc_sf_uncomp, &qxm_camnoc_hf, &qxm_mdp0);
-DEFINE_QBCM(bcm_mm2, "MM2", false, &qns_mem_noc_sf);
-DEFINE_QBCM(bcm_mm3, "MM3", false, &qhm_mnoc_cfg, &qnm_video0, &qnm_video_cvp, &qxm_camnoc_sf);
-DEFINE_QBCM(bcm_qup0, "QUP0", false, &qup0_core_master, &qup1_core_master, &qup0_core_slave, &qup1_core_slave);
-DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
-DEFINE_QBCM(bcm_sh2, "SH2", false, &acm_sys_tcu);
-DEFINE_QBCM(bcm_sh3, "SH3", false, &qnm_cmpnoc);
-DEFINE_QBCM(bcm_sh4, "SH4", false, &acm_apps);
-DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_gemnoc_sf);
-DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
-DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_gemnoc_gc);
-DEFINE_QBCM(bcm_sn3, "SN3", false, &qxs_pimem);
-DEFINE_QBCM(bcm_sn4, "SN4", false, &xs_qdss_stm);
-DEFINE_QBCM(bcm_sn5, "SN5", false, &qnm_aggre1_noc);
-DEFINE_QBCM(bcm_sn6, "SN6", false, &qnm_aggre2_noc);
-DEFINE_QBCM(bcm_sn10, "SN10", false, &qnm_gemnoc);
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &ebi },
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
+	.keepalive = true,
+	.num_nodes = 41,
+	.nodes = { &qnm_snoc,
+		   &xm_qdss_dap,
+		   &qhs_a1_noc_cfg,
+		   &qhs_a2_noc_cfg,
+		   &qhs_ahb2phy0,
+		   &qhs_aoss,
+		   &qhs_boot_rom,
+		   &qhs_camera_cfg,
+		   &qhs_camera_nrt_thrott_cfg,
+		   &qhs_camera_rt_throttle_cfg,
+		   &qhs_clk_ctl,
+		   &qhs_cpr_cx,
+		   &qhs_cpr_mx,
+		   &qhs_crypto0_cfg,
+		   &qhs_dcc_cfg,
+		   &qhs_ddrss_cfg,
+		   &qhs_display_cfg,
+		   &qhs_display_throttle_cfg,
+		   &qhs_glm,
+		   &qhs_gpuss_cfg,
+		   &qhs_imem_cfg,
+		   &qhs_ipa,
+		   &qhs_mnoc_cfg,
+		   &qhs_mss_cfg,
+		   &qhs_npu_cfg,
+		   &qhs_pimem_cfg,
+		   &qhs_prng,
+		   &qhs_qdss_cfg,
+		   &qhs_qm_cfg,
+		   &qhs_qm_mpu_cfg,
+		   &qhs_qup0,
+		   &qhs_qup1,
+		   &qhs_security,
+		   &qhs_snoc_cfg,
+		   &qhs_tcsr,
+		   &qhs_ufs_mem_cfg,
+		   &qhs_usb3_0,
+		   &qhs_venus_cfg,
+		   &qhs_venus_throttle_cfg,
+		   &qhs_vsense_ctrl_cfg,
+		   &srvc_cnoc
+	},
+};
+
+static struct qcom_icc_bcm bcm_cn1 = {
+	.name = "CN1",
+	.keepalive = false,
+	.num_nodes = 6,
+	.nodes = { &xm_emmc,
+		   &xm_sdc2,
+		   &qhs_ahb2phy2,
+		   &qhs_emmc_cfg,
+		   &qhs_pdm,
+		   &qhs_sdc2
+	},
+};
+
+static struct qcom_icc_bcm bcm_co0 = {
+	.name = "CO0",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_cdsp_gemnoc },
+};
+
+static struct qcom_icc_bcm bcm_co2 = {
+	.name = "CO2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_npu },
+};
+
+static struct qcom_icc_bcm bcm_co3 = {
+	.name = "CO3",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxm_npu_dsp },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
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
+	.keepalive = true,
+	.num_nodes = 5,
+	.nodes = { &qxm_camnoc_hf0_uncomp,
+		   &qxm_camnoc_icp_uncomp,
+		   &qxm_camnoc_sf_uncomp,
+		   &qxm_camnoc_hf,
+		   &qxm_mdp0
+	},
+};
+
+static struct qcom_icc_bcm bcm_mm2 = {
+	.name = "MM2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_bcm bcm_mm3 = {
+	.name = "MM3",
+	.keepalive = false,
+	.num_nodes = 4,
+	.nodes = { &qhm_mnoc_cfg, &qnm_video0, &qnm_video_cvp, &qxm_camnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = false,
+	.num_nodes = 4,
+	.nodes = { &qup0_core_master, &qup1_core_master, &qup0_core_slave, &qup1_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh2 = {
+	.name = "SH2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &acm_sys_tcu },
+};
+
+static struct qcom_icc_bcm bcm_sh3 = {
+	.name = "SH3",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_cmpnoc },
+};
+
+static struct qcom_icc_bcm bcm_sh4 = {
+	.name = "SH4",
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
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn6 = {
+	.name = "SN6",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn10 = {
+	.name = "SN10",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_gemnoc },
+};
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_cn1,

-- 
2.41.0

