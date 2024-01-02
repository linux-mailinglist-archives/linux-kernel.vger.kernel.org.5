Return-Path: <linux-kernel+bounces-14709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66090822100
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A25C1C2254C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B187C15AE6;
	Tue,  2 Jan 2024 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pBXd8W6T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C37156FE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso18284390a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704220208; x=1704825008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGwWL/pQvZsl/RDgzls2Zz44nUJBfwr395ckpL6qqDU=;
        b=pBXd8W6T/YNc6Hc5nq+80xiNtnbKpl0D2gI/w5MNzIvsH15heBMgPDnAPfcl5KAmbW
         dMXUCnrHoSAld7i94jCb4k30Y7+Qe/l2MpgpcKJSZnruJVRfhIMK9Ak2XSd7atb0bjSE
         /GFf4Msea/YIGRfCqsoQ8bMH4fjWqyGxyqBjprT/ZSv3wri64cuR7G0F+8Kfjz4/9l0s
         YexhoJ59XBmKJdjt0NoG/MBrot43TWQHFa0TEo0u9dQefECKZW8V3LD1rDX/Nm7DZKjb
         x5sekeSIBoIDleadhQAt77J74VzH4vQze4sWxkRo+sZzOTLxoFeLP3R74i20rhziP+vI
         qDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704220208; x=1704825008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGwWL/pQvZsl/RDgzls2Zz44nUJBfwr395ckpL6qqDU=;
        b=eiwcShA1elPWZ1ImG1koiG3KTzh6d7fAhl3kAdWiFNt4gYCcOOM9rl5bloA0gW2EXy
         NllU9zx9DYlsdWNvqqr9O2LxQ26/h4s5Ze1lxNY5aesdQ/AOsJOVi0OsLzOV0gUSIt71
         zPipYrJyCRv8n+ogp2PJaf2M0/IsMJTKWtlv7OCYBL7COKUkmK8rIfDe3i7Zp6FH+cNl
         ulIC4ibt8Ur8G/0sj67bxIm3bCrzxJItYlFfkA6kvf+ey5CNKpK3FZrncHuGFgO1sjhA
         HgvhKdKRQw4v1DJOkOu7/3XZytcgpkrU8VTYN23mbWVNxJCVyXt+zxCov3Hk2TaW04cD
         awvg==
X-Gm-Message-State: AOJu0Yxaq7W/dLdAOW1irJicvRwQGt1kuneCNPbhrFjJlmOYsU29k2WU
	XwrBYOHPJ1Wlo7y/4KJ58SCtnv8LyTMPaw==
X-Google-Smtp-Source: AGHT+IEsiwm1+BPPmK97+zBr7En7OrMVshTzgH7A105uaFebMrfmI9xqkW/92MJGGLq6SiTLbxGLNw==
X-Received: by 2002:a17:906:57c1:b0:a23:54aa:311b with SMTP id u1-20020a17090657c100b00a2354aa311bmr19429093ejr.34.1704220208328;
        Tue, 02 Jan 2024 10:30:08 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id et10-20020a170907294a00b00a2699a54888sm11968835ejc.64.2024.01.02.10.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:30:08 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 02 Jan 2024 19:29:47 +0100
Subject: [PATCH 1/4] interconnect: qcom: x1e80100: Remove bogus per-RSC
 BCMs and nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-topic-x1e_fixes-v1-1-70723e08d5f6@linaro.org>
References: <20240102-topic-x1e_fixes-v1-0-70723e08d5f6@linaro.org>
In-Reply-To: <20240102-topic-x1e_fixes-v1-0-70723e08d5f6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704220203; l=12344;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mNa869fDrci8rw/llu3AyPu8WaoxGUB7b59qLee5D8M=;
 b=66uM6q+cMMnpZG6Ar45PAj4O/OnCy5/2zXaet0FGaC2kUJy44ePPf8fL5QJSub08IDqpiTPFw
 DYzoFe6mcDnBZS6CAvpvmfrhv2TPWZJNgniS5K3sHHUmkZYi5llcWhh
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The downstream kernel has infrastructure for passing votes from different
interconnect nodes onto different RPMh RSCs. This neither implemented, not
is going to be implemented upstream (in favor of a different solution
using ICC tags through the same node).

Unfortunately, as it happens, meaningless (in the upstream context) parts
of the vendor driver were copied, ending up causing havoc - since all
"per-RSC" (in quotes because they all point to the main APPS one) BCMs
defined within the driver overwrite the value in RPMh on every
aggregation.

To both avoid keeping bogus code around and possibly introducing
impossible-to-track-down bugs (busses shutting down for no reason), get
rid of the duplicated BCMs and their associated ICC nodes.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/x1e80100.c | 315 -----------------------------------
 1 file changed, 315 deletions(-)

diff --git a/drivers/interconnect/qcom/x1e80100.c b/drivers/interconnect/qcom/x1e80100.c
index d19501d913b3..5b2de9c3a1d6 100644
--- a/drivers/interconnect/qcom/x1e80100.c
+++ b/drivers/interconnect/qcom/x1e80100.c
@@ -670,150 +670,6 @@ static struct qcom_icc_node xm_usb4_2 = {
 	.links = { X1E80100_SLAVE_AGGRE_USB_SOUTH },
 };
 
-static struct qcom_icc_node qnm_mnoc_hf_disp = {
-	.name = "qnm_mnoc_hf_disp",
-	.id = X1E80100_MASTER_MNOC_HF_MEM_NOC_DISP,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_LLCC_DISP },
-};
-
-static struct qcom_icc_node qnm_pcie_disp = {
-	.name = "qnm_pcie_disp",
-	.id = X1E80100_MASTER_ANOC_PCIE_GEM_NOC_DISP,
-	.channels = 1,
-	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_LLCC_DISP },
-};
-
-static struct qcom_icc_node llcc_mc_disp = {
-	.name = "llcc_mc_disp",
-	.id = X1E80100_MASTER_LLCC_DISP,
-	.channels = 8,
-	.buswidth = 4,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_EBI1_DISP },
-};
-
-static struct qcom_icc_node qnm_mdp_disp = {
-	.name = "qnm_mdp_disp",
-	.id = X1E80100_MASTER_MDP_DISP,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_HF_MEM_NOC_DISP },
-};
-
-static struct qcom_icc_node qnm_pcie_pcie = {
-	.name = "qnm_pcie_pcie",
-	.id = X1E80100_MASTER_ANOC_PCIE_GEM_NOC_PCIE,
-	.channels = 1,
-	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_LLCC_PCIE },
-};
-
-static struct qcom_icc_node llcc_mc_pcie = {
-	.name = "llcc_mc_pcie",
-	.id = X1E80100_MASTER_LLCC_PCIE,
-	.channels = 8,
-	.buswidth = 4,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_EBI1_PCIE },
-};
-
-static struct qcom_icc_node qnm_pcie_north_gem_noc_pcie = {
-	.name = "qnm_pcie_north_gem_noc_pcie",
-	.id = X1E80100_MASTER_PCIE_NORTH_PCIE,
-	.channels = 1,
-	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_ANOC_PCIE_GEM_NOC_PCIE },
-};
-
-static struct qcom_icc_node qnm_pcie_south_gem_noc_pcie = {
-	.name = "qnm_pcie_south_gem_noc_pcie",
-	.id = X1E80100_MASTER_PCIE_SOUTH_PCIE,
-	.channels = 1,
-	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_ANOC_PCIE_GEM_NOC_PCIE },
-};
-
-static struct qcom_icc_node xm_pcie_3_pcie = {
-	.name = "xm_pcie_3_pcie",
-	.id = X1E80100_MASTER_PCIE_3_PCIE,
-	.channels = 1,
-	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_NORTH_PCIE },
-};
-
-static struct qcom_icc_node xm_pcie_4_pcie = {
-	.name = "xm_pcie_4_pcie",
-	.id = X1E80100_MASTER_PCIE_4_PCIE,
-	.channels = 1,
-	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_NORTH_PCIE },
-};
-
-static struct qcom_icc_node xm_pcie_5_pcie = {
-	.name = "xm_pcie_5_pcie",
-	.id = X1E80100_MASTER_PCIE_5_PCIE,
-	.channels = 1,
-	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_NORTH_PCIE },
-};
-
-static struct qcom_icc_node xm_pcie_0_pcie = {
-	.name = "xm_pcie_0_pcie",
-	.id = X1E80100_MASTER_PCIE_0_PCIE,
-	.channels = 1,
-	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_SOUTH_PCIE },
-};
-
-static struct qcom_icc_node xm_pcie_1_pcie = {
-	.name = "xm_pcie_1_pcie",
-	.id = X1E80100_MASTER_PCIE_1_PCIE,
-	.channels = 1,
-	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_SOUTH_PCIE },
-};
-
-static struct qcom_icc_node xm_pcie_2_pcie = {
-	.name = "xm_pcie_2_pcie",
-	.id = X1E80100_MASTER_PCIE_2_PCIE,
-	.channels = 1,
-	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_SOUTH_PCIE },
-};
-
-static struct qcom_icc_node xm_pcie_6a_pcie = {
-	.name = "xm_pcie_6a_pcie",
-	.id = X1E80100_MASTER_PCIE_6A_PCIE,
-	.channels = 1,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_SOUTH_PCIE },
-};
-
-static struct qcom_icc_node xm_pcie_6b_pcie = {
-	.name = "xm_pcie_6b_pcie",
-	.id = X1E80100_MASTER_PCIE_6B_PCIE,
-	.channels = 1,
-	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_SOUTH_PCIE },
-};
-
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
 	.id = X1E80100_SLAVE_A1NOC_SNOC,
@@ -1514,76 +1370,6 @@ static struct qcom_icc_node qns_aggre_usb_south_snoc = {
 	.links = { X1E80100_MASTER_AGGRE_USB_SOUTH },
 };
 
-static struct qcom_icc_node qns_llcc_disp = {
-	.name = "qns_llcc_disp",
-	.id = X1E80100_SLAVE_LLCC_DISP,
-	.channels = 8,
-	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_LLCC_DISP },
-};
-
-static struct qcom_icc_node ebi_disp = {
-	.name = "ebi_disp",
-	.id = X1E80100_SLAVE_EBI1_DISP,
-	.channels = 8,
-	.buswidth = 4,
-	.num_links = 0,
-};
-
-static struct qcom_icc_node qns_mem_noc_hf_disp = {
-	.name = "qns_mem_noc_hf_disp",
-	.id = X1E80100_SLAVE_MNOC_HF_MEM_NOC_DISP,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_MNOC_HF_MEM_NOC_DISP },
-};
-
-static struct qcom_icc_node qns_llcc_pcie = {
-	.name = "qns_llcc_pcie",
-	.id = X1E80100_SLAVE_LLCC_PCIE,
-	.channels = 8,
-	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_LLCC_PCIE },
-};
-
-static struct qcom_icc_node ebi_pcie = {
-	.name = "ebi_pcie",
-	.id = X1E80100_SLAVE_EBI1_PCIE,
-	.channels = 8,
-	.buswidth = 4,
-	.num_links = 0,
-};
-
-static struct qcom_icc_node qns_pcie_mem_noc_pcie = {
-	.name = "qns_pcie_mem_noc_pcie",
-	.id = X1E80100_SLAVE_ANOC_PCIE_GEM_NOC_PCIE,
-	.channels = 1,
-	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_ANOC_PCIE_GEM_NOC_PCIE },
-};
-
-static struct qcom_icc_node qns_pcie_north_gem_noc_pcie = {
-	.name = "qns_pcie_north_gem_noc_pcie",
-	.id = X1E80100_SLAVE_PCIE_NORTH_PCIE,
-	.channels = 1,
-	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_PCIE_NORTH_PCIE },
-};
-
-static struct qcom_icc_node qns_pcie_south_gem_noc_pcie = {
-	.name = "qns_pcie_south_gem_noc_pcie",
-	.id = X1E80100_SLAVE_PCIE_SOUTH_PCIE,
-	.channels = 1,
-	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_PCIE_SOUTH_PCIE },
-};
-
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.num_nodes = 1,
@@ -1755,72 +1541,6 @@ static struct qcom_icc_bcm bcm_sn4 = {
 	.nodes = { &qnm_usb_anoc },
 };
 
-static struct qcom_icc_bcm bcm_acv_disp = {
-	.name = "ACV",
-	.num_nodes = 1,
-	.nodes = { &ebi_disp },
-};
-
-static struct qcom_icc_bcm bcm_mc0_disp = {
-	.name = "MC0",
-	.num_nodes = 1,
-	.nodes = { &ebi_disp },
-};
-
-static struct qcom_icc_bcm bcm_mm0_disp = {
-	.name = "MM0",
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf_disp },
-};
-
-static struct qcom_icc_bcm bcm_mm1_disp = {
-	.name = "MM1",
-	.num_nodes = 1,
-	.nodes = { &qnm_mdp_disp },
-};
-
-static struct qcom_icc_bcm bcm_sh0_disp = {
-	.name = "SH0",
-	.num_nodes = 1,
-	.nodes = { &qns_llcc_disp },
-};
-
-static struct qcom_icc_bcm bcm_sh1_disp = {
-	.name = "SH1",
-	.num_nodes = 2,
-	.nodes = { &qnm_mnoc_hf_disp, &qnm_pcie_disp },
-};
-
-static struct qcom_icc_bcm bcm_acv_pcie = {
-	.name = "ACV",
-	.num_nodes = 1,
-	.nodes = { &ebi_pcie },
-};
-
-static struct qcom_icc_bcm bcm_mc0_pcie = {
-	.name = "MC0",
-	.num_nodes = 1,
-	.nodes = { &ebi_pcie },
-};
-
-static struct qcom_icc_bcm bcm_pc0_pcie = {
-	.name = "PC0",
-	.num_nodes = 1,
-	.nodes = { &qns_pcie_mem_noc_pcie },
-};
-
-static struct qcom_icc_bcm bcm_sh0_pcie = {
-	.name = "SH0",
-	.num_nodes = 1,
-	.nodes = { &qns_llcc_pcie },
-};
-
-static struct qcom_icc_bcm bcm_sh1_pcie = {
-	.name = "SH1",
-	.num_nodes = 1,
-	.nodes = { &qnm_pcie_pcie },
-};
-
 static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
 };
 
@@ -1982,10 +1702,6 @@ static const struct qcom_icc_desc x1e80100_cnoc_main = {
 static struct qcom_icc_bcm * const gem_noc_bcms[] = {
 	&bcm_sh0,
 	&bcm_sh1,
-	&bcm_sh0_disp,
-	&bcm_sh1_disp,
-	&bcm_sh0_pcie,
-	&bcm_sh1_pcie,
 };
 
 static struct qcom_icc_node * const gem_noc_nodes[] = {
@@ -2004,11 +1720,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
 	[SLAVE_LLCC] = &qns_llcc,
 	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
-	[MASTER_MNOC_HF_MEM_NOC_DISP] = &qnm_mnoc_hf_disp,
-	[MASTER_ANOC_PCIE_GEM_NOC_DISP] = &qnm_pcie_disp,
-	[SLAVE_LLCC_DISP] = &qns_llcc_disp,
-	[MASTER_ANOC_PCIE_GEM_NOC_PCIE] = &qnm_pcie_pcie,
-	[SLAVE_LLCC_PCIE] = &qns_llcc_pcie,
 };
 
 static const struct qcom_icc_desc x1e80100_gem_noc = {
@@ -2067,19 +1778,11 @@ static const struct qcom_icc_desc x1e80100_lpass_lpicx_noc = {
 static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
-	&bcm_acv_disp,
-	&bcm_mc0_disp,
-	&bcm_acv_pcie,
-	&bcm_mc0_pcie,
 };
 
 static struct qcom_icc_node * const mc_virt_nodes[] = {
 	[MASTER_LLCC] = &llcc_mc,
 	[SLAVE_EBI1] = &ebi,
-	[MASTER_LLCC_DISP] = &llcc_mc_disp,
-	[SLAVE_EBI1_DISP] = &ebi_disp,
-	[MASTER_LLCC_PCIE] = &llcc_mc_pcie,
-	[SLAVE_EBI1_PCIE] = &ebi_pcie,
 };
 
 static const struct qcom_icc_desc x1e80100_mc_virt = {
@@ -2092,8 +1795,6 @@ static const struct qcom_icc_desc x1e80100_mc_virt = {
 static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
 	&bcm_mm0,
 	&bcm_mm1,
-	&bcm_mm0_disp,
-	&bcm_mm1_disp,
 };
 
 static struct qcom_icc_node * const mmss_noc_nodes[] = {
@@ -2110,8 +1811,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
 	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
 	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
-	[MASTER_MDP_DISP] = &qnm_mdp_disp,
-	[SLAVE_MNOC_HF_MEM_NOC_DISP] = &qns_mem_noc_hf_disp,
 };
 
 static const struct qcom_icc_desc x1e80100_mmss_noc = {
@@ -2139,16 +1838,12 @@ static const struct qcom_icc_desc x1e80100_nsp_noc = {
 
 static struct qcom_icc_bcm * const pcie_center_anoc_bcms[] = {
 	&bcm_pc0,
-	&bcm_pc0_pcie,
 };
 
 static struct qcom_icc_node * const pcie_center_anoc_nodes[] = {
 	[MASTER_PCIE_NORTH] = &qnm_pcie_north_gem_noc,
 	[MASTER_PCIE_SOUTH] = &qnm_pcie_south_gem_noc,
 	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
-	[MASTER_PCIE_NORTH_PCIE] = &qnm_pcie_north_gem_noc_pcie,
-	[MASTER_PCIE_SOUTH_PCIE] = &qnm_pcie_south_gem_noc_pcie,
-	[SLAVE_ANOC_PCIE_GEM_NOC_PCIE] = &qns_pcie_mem_noc_pcie,
 };
 
 static const struct qcom_icc_desc x1e80100_pcie_center_anoc = {
@@ -2166,10 +1861,6 @@ static struct qcom_icc_node * const pcie_north_anoc_nodes[] = {
 	[MASTER_PCIE_4] = &xm_pcie_4,
 	[MASTER_PCIE_5] = &xm_pcie_5,
 	[SLAVE_PCIE_NORTH] = &qns_pcie_north_gem_noc,
-	[MASTER_PCIE_3_PCIE] = &xm_pcie_3_pcie,
-	[MASTER_PCIE_4_PCIE] = &xm_pcie_4_pcie,
-	[MASTER_PCIE_5_PCIE] = &xm_pcie_5_pcie,
-	[SLAVE_PCIE_NORTH_PCIE] = &qns_pcie_north_gem_noc_pcie,
 };
 
 static const struct qcom_icc_desc x1e80100_pcie_north_anoc = {
@@ -2189,12 +1880,6 @@ static struct qcom_icc_node * const pcie_south_anoc_nodes[] = {
 	[MASTER_PCIE_6A] = &xm_pcie_6a,
 	[MASTER_PCIE_6B] = &xm_pcie_6b,
 	[SLAVE_PCIE_SOUTH] = &qns_pcie_south_gem_noc,
-	[MASTER_PCIE_0_PCIE] = &xm_pcie_0_pcie,
-	[MASTER_PCIE_1_PCIE] = &xm_pcie_1_pcie,
-	[MASTER_PCIE_2_PCIE] = &xm_pcie_2_pcie,
-	[MASTER_PCIE_6A_PCIE] = &xm_pcie_6a_pcie,
-	[MASTER_PCIE_6B_PCIE] = &xm_pcie_6b_pcie,
-	[SLAVE_PCIE_SOUTH_PCIE] = &qns_pcie_south_gem_noc_pcie,
 };
 
 static const struct qcom_icc_desc x1e80100_pcie_south_anoc = {

-- 
2.43.0


