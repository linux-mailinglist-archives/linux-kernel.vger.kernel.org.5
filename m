Return-Path: <linux-kernel+bounces-57888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA8284DEA7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A15287EAB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3138B6F501;
	Thu,  8 Feb 2024 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zOFEVaqc"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC96EB55
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389467; cv=none; b=DrymOo+fsEDVIrCHrZicgRvU6hmJ01klJd13msG9iFyAv0am3yJ3XECGE3vevaz/z40ZofG+cY1/8WVWOhlwAaOOxjGEd3d+IJZvxeMnZo6YrpKBHHW/8VOhVH1NLagXzPkFClZgmeqwxEXK3LlnTAwOBDdFo3+eAiRBdARZIX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389467; c=relaxed/simple;
	bh=pSXww4JOmKo0NvYhFm95KOT1cC7bHGNrwi3UIF5F6Ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rn2IKCg2yKnofsQV+w9cZm19QB5I76NjqTUAryj1JD2IfQWb40Z639Kcq6Hs/7hpv29p97nUGxmqtKPHvxISi/F166Kp9BCYWPO/KR+PpIN6AUdV6QtiA/QqzAD7gpnST/bdZ56tW9Syg9DSBDmtlpPoNxXVyg8LuWDoMd3uv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zOFEVaqc; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-337d05b8942so1238491f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707389463; x=1707994263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJc7ec9IijkOU/3KDLFERj5AUUPZCAR+EPoUeZ5cdPE=;
        b=zOFEVaqcJQRG3aZ2a3M2TiABoASxyeYp+EjJxletQ0Fywp80mF592xdEDhrpKFW7ZK
         9Fu74aBWkL/n8yrzTJh9wKcEMZyWXQOWRCR3vu6XMSMt+HnhuBVI0sjjSUfEt8BTmYPn
         IWw4sbL9b/CKa/+xM+YvNNISWv5GXCJiNWrpgdeyP8OrFEeI9C2gzpd7mzI82zBQsDKA
         gN/e/X2k5npzt2gKEk8s0McmkayoLB+8i3FQ3yW2HcD6iuquJ8ceLqtEwbevBR969Owh
         pM0G36MytRPXaDqi/cyc7jewrGHbBB3Oiu889nHeBbAHZV1KajFmguiJz/yAQInoaQs5
         1cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389463; x=1707994263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJc7ec9IijkOU/3KDLFERj5AUUPZCAR+EPoUeZ5cdPE=;
        b=CtsFWZ89y07ZK3G2qvwsut04RJbkRbMZBzgkFenkWTzG3nrfhMTdKO4/0gPD/6QkR5
         zY2dM0sMC1NHFXyeQnjZsYA4hsfUZq/I7whnrtOQ+DSeHPZ8GHU058BEHPlmTjMlgfbH
         zm4hhsg8dJ2h2p3pI6WazALvnWaP6JpwImGGb2OtKsJD8jsbWoe5WLGjSAFbKgbF6BHn
         m/HsuAAKHkkkmBKtueyUq9MRriF3M1fNbCTsbZh1DK3kS3gkN3zr6fNNqpFAH8rMOlQo
         x2tKLQXdShxXIu8/630omRT5yzoVqk8i9XMGdRLf9c+4p5dttofnculTlHhiCAP7ovmH
         h1fg==
X-Gm-Message-State: AOJu0Yw5Etq1vIC52RpJJJJSrAZ2nUjTMrHRLk7JF2g1T9x766ek/mUI
	I7F+GEbTR9VGljBRBitoGYChyrK5GokdIgXZKdJgGXskWTDNDcm5oqIVjsp0ykM=
X-Google-Smtp-Source: AGHT+IGa1KzLcMJM3geh+KsnsqZn7pE/aPaxXw6ft3KpFO3rO5IXc4kfibBn6t6B27KgdUQB+gW6nw==
X-Received: by 2002:adf:fed2:0:b0:33a:e67f:cf8 with SMTP id q18-20020adffed2000000b0033ae67f0cf8mr5810439wrs.20.1707389463607;
        Thu, 08 Feb 2024 02:51:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU73vpSLrggTRw4RQ8aEgoMirm1W7HvbVETod9fmQvE/UMZpn/lLKGr2CsSAunMlR+QKOLwNWioqPhgJu3GH6YuVyca+TWoqT8PbScVvFoVanK0vITO/yUbwurLGRrimlLFpcXkHoqxQjyxunWuyPPgb3m5mrJfNGdZxlW+Gd4J8+JyRMqT/yVcZJd4AO8lwIvDJOswbe2LOnb1gg72Y1LDgMuj4Z7X4ua9DTg5ku0mz0Vq
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d69c1000000b0033b4719eb6esm3308283wrw.27.2024.02.08.02.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:51:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/6] interconnect: qcom: sa8775p: constify pointer to qcom_icc_node
Date: Thu,  8 Feb 2024 11:50:52 +0100
Message-Id: <20240208105056.128448-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208105056.128448-1-krzysztof.kozlowski@linaro.org>
References: <20240208105056.128448-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointers to struct qcom_icc_node are const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/interconnect/qcom/sa8775p.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
index dd6281db08ad..fe1b11041e6a 100644
--- a/drivers/interconnect/qcom/sa8775p.c
+++ b/drivers/interconnect/qcom/sa8775p.c
@@ -2096,7 +2096,7 @@ static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
 	&bcm_sn3,
 };
 
-static struct qcom_icc_node *aggre1_noc_nodes[] = {
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[MASTER_QUP_3] = &qxm_qup3,
 	[MASTER_EMAC] = &xm_emac_0,
 	[MASTER_EMAC_1] = &xm_emac_1,
@@ -2120,7 +2120,7 @@ static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
 	&bcm_sn4,
 };
 
-static struct qcom_icc_node *aggre2_noc_nodes[] = {
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
 	[MASTER_QUP_0] = &qhm_qup0,
 	[MASTER_QUP_1] = &qhm_qup1,
@@ -2148,7 +2148,7 @@ static struct qcom_icc_bcm *clk_virt_bcms[] = {
 	&bcm_qup2,
 };
 
-static struct qcom_icc_node *clk_virt_nodes[] = {
+static struct qcom_icc_node * const clk_virt_nodes[] = {
 	[MASTER_QUP_CORE_0] = &qup0_core_master,
 	[MASTER_QUP_CORE_1] = &qup1_core_master,
 	[MASTER_QUP_CORE_2] = &qup2_core_master,
@@ -2175,7 +2175,7 @@ static struct qcom_icc_bcm *config_noc_bcms[] = {
 	&bcm_sn10,
 };
 
-static struct qcom_icc_node *config_noc_nodes[] = {
+static struct qcom_icc_node * const config_noc_nodes[] = {
 	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
 	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
 	[SLAVE_AHB2PHY_0] = &qhs_ahb2phy0,
@@ -2274,7 +2274,7 @@ static const struct qcom_icc_desc sa8775p_config_noc = {
 static struct qcom_icc_bcm *dc_noc_bcms[] = {
 };
 
-static struct qcom_icc_node *dc_noc_nodes[] = {
+static struct qcom_icc_node * const dc_noc_nodes[] = {
 	[MASTER_CNOC_DC_NOC] = &qnm_cnoc_dc_noc,
 	[SLAVE_LLCC_CFG] = &qhs_llcc,
 	[SLAVE_GEM_NOC_CFG] = &qns_gemnoc,
@@ -2292,7 +2292,7 @@ static struct qcom_icc_bcm *gem_noc_bcms[] = {
 	&bcm_sh2,
 };
 
-static struct qcom_icc_node *gem_noc_nodes[] = {
+static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[MASTER_GPU_TCU] = &alm_gpu_tcu,
 	[MASTER_PCIE_TCU] = &alm_pcie_tcu,
 	[MASTER_SYS_TCU] = &alm_sys_tcu,
@@ -2328,7 +2328,7 @@ static struct qcom_icc_bcm *gpdsp_anoc_bcms[] = {
 	&bcm_gnb0,
 };
 
-static struct qcom_icc_node *gpdsp_anoc_nodes[] = {
+static struct qcom_icc_node * const gpdsp_anoc_nodes[] = {
 	[MASTER_DSP0] = &qxm_dsp0,
 	[MASTER_DSP1] = &qxm_dsp1,
 	[SLAVE_GP_DSP_SAIL_NOC] = &qns_gp_dsp_sail_noc,
@@ -2345,7 +2345,7 @@ static struct qcom_icc_bcm *lpass_ag_noc_bcms[] = {
 	&bcm_sn9,
 };
 
-static struct qcom_icc_node *lpass_ag_noc_nodes[] = {
+static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 	[MASTER_CNOC_LPASS_AG_NOC] = &qhm_config_noc,
 	[MASTER_LPASS_PROC] = &qxm_lpass_dsp,
 	[SLAVE_LPASS_CORE_CFG] = &qhs_lpass_core,
@@ -2369,7 +2369,7 @@ static struct qcom_icc_bcm *mc_virt_bcms[] = {
 	&bcm_mc0,
 };
 
-static struct qcom_icc_node *mc_virt_nodes[] = {
+static struct qcom_icc_node * const mc_virt_nodes[] = {
 	[MASTER_LLCC] = &llcc_mc,
 	[SLAVE_EBI1] = &ebi,
 };
@@ -2386,7 +2386,7 @@ static struct qcom_icc_bcm *mmss_noc_bcms[] = {
 	&bcm_mm1,
 };
 
-static struct qcom_icc_node *mmss_noc_nodes[] = {
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
 	[MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
 	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
@@ -2418,7 +2418,7 @@ static struct qcom_icc_bcm *nspa_noc_bcms[] = {
 	&bcm_nsa1,
 };
 
-static struct qcom_icc_node *nspa_noc_nodes[] = {
+static struct qcom_icc_node * const nspa_noc_nodes[] = {
 	[MASTER_CDSP_NOC_CFG] = &qhm_nsp_noc_config,
 	[MASTER_CDSP_PROC] = &qxm_nsp,
 	[SLAVE_HCP_A] = &qns_hcp,
@@ -2438,7 +2438,7 @@ static struct qcom_icc_bcm *nspb_noc_bcms[] = {
 	&bcm_nsb1,
 };
 
-static struct qcom_icc_node *nspb_noc_nodes[] = {
+static struct qcom_icc_node * const nspb_noc_nodes[] = {
 	[MASTER_CDSPB_NOC_CFG] = &qhm_nspb_noc_config,
 	[MASTER_CDSP_PROC_B] = &qxm_nspb,
 	[SLAVE_CDSPB_MEM_NOC] = &qns_nspb_gemnoc,
@@ -2457,7 +2457,7 @@ static struct qcom_icc_bcm *pcie_anoc_bcms[] = {
 	&bcm_pci0,
 };
 
-static struct qcom_icc_node *pcie_anoc_nodes[] = {
+static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 	[MASTER_PCIE_0] = &xm_pcie3_0,
 	[MASTER_PCIE_1] = &xm_pcie3_1,
 	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
@@ -2478,7 +2478,7 @@ static struct qcom_icc_bcm *system_noc_bcms[] = {
 	&bcm_sn9,
 };
 
-static struct qcom_icc_node *system_noc_nodes[] = {
+static struct qcom_icc_node * const system_noc_nodes[] = {
 	[MASTER_GIC_AHB] = &qhm_gic,
 	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
 	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
-- 
2.34.1


