Return-Path: <linux-kernel+bounces-4014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A55088176B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071221F23616
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0EB5A854;
	Mon, 18 Dec 2023 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdE/CJzT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966B8498B6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso5656367a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702915338; x=1703520138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nzUKMjm+afoe+kk65tFGWl2EZRkA+Zlh/igycIPqJc=;
        b=cdE/CJzTSQnilnXzd3Fmyklok/dlaDNI1eQiuuiZs5IBFbd8pRxOOLx5FKu5yHc5v2
         wXXgmIV4DA9tOXie9SW+WwKlB4FMEVOXHb8dXznCJhEnMg8cdqGHCksVemCBuD9BmHXh
         XTJ9HDQzIy8w2g/IWslaPMQiLwnVGzjKp3KJssahw2/xyvrSUcrbL1GbbEF2LmQ+b+VA
         xykrppcV5VQ3DG7hYhHCySVFltjsSWNOLVGswpdtbA1Ent1VZJNw+ml+bBY3fbnc1sL4
         Q+Lb5Rscs7aJCk/StvCFqOV/5RG2yUcb3VBZLKdRb63pBnC0SKmYa1vkVCQekQWifVwk
         iT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915338; x=1703520138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nzUKMjm+afoe+kk65tFGWl2EZRkA+Zlh/igycIPqJc=;
        b=Lr139ZgmMtOKbnimRu2L91ZxRZNn5IGaS+ssKCgiLKH5ARORR0+1YO6DjzsSW1wD01
         c4MH6mWXmvxBobTL5mF5+aUPCIwvszEisT7n5GogqpLN4tOSaaUfvHhDLhYIC+D9La4z
         70ZHCj2MRRwnE2sevUTT3PmOtKbGa1mpg7gK9JP7Gnx6cNXxrfsLgcAU1iEhCekoJjoT
         t8bDJnFEzfPkebhr3p3rzviN6Dsxek6S3bZ0PsRGuP+bPPtNxJvarMPxfR6dLpbSvsDR
         3gjzBdm3b7Tfhn478wCTioBWSnrgdlAGFwwkmzyRGDNMdEHxJjtD4+aaDmB5MlilXu7L
         7q4w==
X-Gm-Message-State: AOJu0YwX0QXNx/b5wsE09MDE05zI81uaIdVuz4jRDP243ezfcX2wsQY4
	YOQv4nXyczizTl/odqSYr9/W6w==
X-Google-Smtp-Source: AGHT+IErBEk/GugoHlpzgrmI5OYAdkfPIyNCsYiGr+rc/bN4f0LL7ntcmKAShINj7NDSPVGYK9QnVw==
X-Received: by 2002:a17:906:4a0a:b0:a23:4ff0:42cd with SMTP id w10-20020a1709064a0a00b00a234ff042cdmr2362054eju.38.1702915337713;
        Mon, 18 Dec 2023 08:02:17 -0800 (PST)
Received: from [10.167.154.1] (178235179137.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.137])
        by smtp.gmail.com with ESMTPSA id ts7-20020a170907c5c700b00a1dd58874b8sm14260693ejc.119.2023.12.18.08.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:02:17 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 18 Dec 2023 17:02:02 +0100
Subject: [PATCH 01/12] interconnect: qcom: sm8550: Remove bogus per-RSC
 BCMs and nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-topic-8550_fixes-v1-1-ce1272d77540@linaro.org>
References: <20231218-topic-8550_fixes-v1-0-ce1272d77540@linaro.org>
In-Reply-To: <20231218-topic-8550_fixes-v1-0-ce1272d77540@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702915332; l=31363;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=oof9143qzZLAgiksoPESQ2uwG+Rp/r2cv+dzhypmSIo=;
 b=UXrhyJZfhlrZYbJqjztI/iSm67qEyz0rqXbNkzvsdFs7SAJY0Z8eDU4iZTtVPby7d532Yu60f
 qvYRV2kKZ9TCkRQ2trHgINrMsIPWpgPrq2jETSjqoHvXMRY6u2DFBJE
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

Fixes: e6f0d6a30f73 ("interconnect: qcom: Add SM8550 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm8550.c | 574 -------------------------------------
 drivers/interconnect/qcom/sm8550.h | 284 ++++++++----------
 2 files changed, 122 insertions(+), 736 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
index 629faa4c9aae..abc52ad3d1f2 100644
--- a/drivers/interconnect/qcom/sm8550.c
+++ b/drivers/interconnect/qcom/sm8550.c
@@ -524,231 +524,6 @@ static struct qcom_icc_node xm_gic = {
 	.links = { SM8550_SLAVE_SNOC_GEM_NOC_GC },
 };
 
-static struct qcom_icc_node qnm_mnoc_hf_disp = {
-	.name = "qnm_mnoc_hf_disp",
-	.id = SM8550_MASTER_MNOC_HF_MEM_NOC_DISP,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_LLCC_DISP },
-};
-
-static struct qcom_icc_node qnm_pcie_disp = {
-	.name = "qnm_pcie_disp",
-	.id = SM8550_MASTER_ANOC_PCIE_GEM_NOC_DISP,
-	.channels = 1,
-	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_LLCC_DISP },
-};
-
-static struct qcom_icc_node llcc_mc_disp = {
-	.name = "llcc_mc_disp",
-	.id = SM8550_MASTER_LLCC_DISP,
-	.channels = 4,
-	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_EBI1_DISP },
-};
-
-static struct qcom_icc_node qnm_mdp_disp = {
-	.name = "qnm_mdp_disp",
-	.id = SM8550_MASTER_MDP_DISP,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_MNOC_HF_MEM_NOC_DISP },
-};
-
-static struct qcom_icc_node qnm_mnoc_hf_cam_ife_0 = {
-	.name = "qnm_mnoc_hf_cam_ife_0",
-	.id = SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_0,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_LLCC_CAM_IFE_0 },
-};
-
-static struct qcom_icc_node qnm_mnoc_sf_cam_ife_0 = {
-	.name = "qnm_mnoc_sf_cam_ife_0",
-	.id = SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_0,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_LLCC_CAM_IFE_0 },
-};
-
-static struct qcom_icc_node qnm_pcie_cam_ife_0 = {
-	.name = "qnm_pcie_cam_ife_0",
-	.id = SM8550_MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_0,
-	.channels = 1,
-	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_LLCC_CAM_IFE_0 },
-};
-
-static struct qcom_icc_node llcc_mc_cam_ife_0 = {
-	.name = "llcc_mc_cam_ife_0",
-	.id = SM8550_MASTER_LLCC_CAM_IFE_0,
-	.channels = 4,
-	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_EBI1_CAM_IFE_0 },
-};
-
-static struct qcom_icc_node qnm_camnoc_hf_cam_ife_0 = {
-	.name = "qnm_camnoc_hf_cam_ife_0",
-	.id = SM8550_MASTER_CAMNOC_HF_CAM_IFE_0,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_0 },
-};
-
-static struct qcom_icc_node qnm_camnoc_icp_cam_ife_0 = {
-	.name = "qnm_camnoc_icp_cam_ife_0",
-	.id = SM8550_MASTER_CAMNOC_ICP_CAM_IFE_0,
-	.channels = 1,
-	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_0 },
-};
-
-static struct qcom_icc_node qnm_camnoc_sf_cam_ife_0 = {
-	.name = "qnm_camnoc_sf_cam_ife_0",
-	.id = SM8550_MASTER_CAMNOC_SF_CAM_IFE_0,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_0 },
-};
-
-static struct qcom_icc_node qnm_mnoc_hf_cam_ife_1 = {
-	.name = "qnm_mnoc_hf_cam_ife_1",
-	.id = SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_1,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_LLCC_CAM_IFE_1 },
-};
-
-static struct qcom_icc_node qnm_mnoc_sf_cam_ife_1 = {
-	.name = "qnm_mnoc_sf_cam_ife_1",
-	.id = SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_1,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_LLCC_CAM_IFE_1 },
-};
-
-static struct qcom_icc_node qnm_pcie_cam_ife_1 = {
-	.name = "qnm_pcie_cam_ife_1",
-	.id = SM8550_MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_1,
-	.channels = 1,
-	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_LLCC_CAM_IFE_1 },
-};
-
-static struct qcom_icc_node llcc_mc_cam_ife_1 = {
-	.name = "llcc_mc_cam_ife_1",
-	.id = SM8550_MASTER_LLCC_CAM_IFE_1,
-	.channels = 4,
-	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_EBI1_CAM_IFE_1 },
-};
-
-static struct qcom_icc_node qnm_camnoc_hf_cam_ife_1 = {
-	.name = "qnm_camnoc_hf_cam_ife_1",
-	.id = SM8550_MASTER_CAMNOC_HF_CAM_IFE_1,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_1 },
-};
-
-static struct qcom_icc_node qnm_camnoc_icp_cam_ife_1 = {
-	.name = "qnm_camnoc_icp_cam_ife_1",
-	.id = SM8550_MASTER_CAMNOC_ICP_CAM_IFE_1,
-	.channels = 1,
-	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_1 },
-};
-
-static struct qcom_icc_node qnm_camnoc_sf_cam_ife_1 = {
-	.name = "qnm_camnoc_sf_cam_ife_1",
-	.id = SM8550_MASTER_CAMNOC_SF_CAM_IFE_1,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_1 },
-};
-
-static struct qcom_icc_node qnm_mnoc_hf_cam_ife_2 = {
-	.name = "qnm_mnoc_hf_cam_ife_2",
-	.id = SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_2,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_LLCC_CAM_IFE_2 },
-};
-
-static struct qcom_icc_node qnm_mnoc_sf_cam_ife_2 = {
-	.name = "qnm_mnoc_sf_cam_ife_2",
-	.id = SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_2,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_LLCC_CAM_IFE_2 },
-};
-
-static struct qcom_icc_node qnm_pcie_cam_ife_2 = {
-	.name = "qnm_pcie_cam_ife_2",
-	.id = SM8550_MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_2,
-	.channels = 1,
-	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_LLCC_CAM_IFE_2 },
-};
-
-static struct qcom_icc_node llcc_mc_cam_ife_2 = {
-	.name = "llcc_mc_cam_ife_2",
-	.id = SM8550_MASTER_LLCC_CAM_IFE_2,
-	.channels = 4,
-	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_EBI1_CAM_IFE_2 },
-};
-
-static struct qcom_icc_node qnm_camnoc_hf_cam_ife_2 = {
-	.name = "qnm_camnoc_hf_cam_ife_2",
-	.id = SM8550_MASTER_CAMNOC_HF_CAM_IFE_2,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_2 },
-};
-
-static struct qcom_icc_node qnm_camnoc_icp_cam_ife_2 = {
-	.name = "qnm_camnoc_icp_cam_ife_2",
-	.id = SM8550_MASTER_CAMNOC_ICP_CAM_IFE_2,
-	.channels = 1,
-	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_2 },
-};
-
-static struct qcom_icc_node qnm_camnoc_sf_cam_ife_2 = {
-	.name = "qnm_camnoc_sf_cam_ife_2",
-	.id = SM8550_MASTER_CAMNOC_SF_CAM_IFE_2,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_2 },
-};
-
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
 	.id = SM8550_SLAVE_A1NOC_SNOC,
@@ -1342,137 +1117,6 @@ static struct qcom_icc_node qns_gemnoc_sf = {
 	.links = { SM8550_MASTER_SNOC_SF_MEM_NOC },
 };
 
-static struct qcom_icc_node qns_llcc_disp = {
-	.name = "qns_llcc_disp",
-	.id = SM8550_SLAVE_LLCC_DISP,
-	.channels = 4,
-	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8550_MASTER_LLCC_DISP },
-};
-
-static struct qcom_icc_node ebi_disp = {
-	.name = "ebi_disp",
-	.id = SM8550_SLAVE_EBI1_DISP,
-	.channels = 4,
-	.buswidth = 4,
-	.num_links = 0,
-};
-
-static struct qcom_icc_node qns_mem_noc_hf_disp = {
-	.name = "qns_mem_noc_hf_disp",
-	.id = SM8550_SLAVE_MNOC_HF_MEM_NOC_DISP,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_MASTER_MNOC_HF_MEM_NOC_DISP },
-};
-
-static struct qcom_icc_node qns_llcc_cam_ife_0 = {
-	.name = "qns_llcc_cam_ife_0",
-	.id = SM8550_SLAVE_LLCC_CAM_IFE_0,
-	.channels = 4,
-	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8550_MASTER_LLCC_CAM_IFE_0 },
-};
-
-static struct qcom_icc_node ebi_cam_ife_0 = {
-	.name = "ebi_cam_ife_0",
-	.id = SM8550_SLAVE_EBI1_CAM_IFE_0,
-	.channels = 4,
-	.buswidth = 4,
-	.num_links = 0,
-};
-
-static struct qcom_icc_node qns_mem_noc_hf_cam_ife_0 = {
-	.name = "qns_mem_noc_hf_cam_ife_0",
-	.id = SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_0,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_0 },
-};
-
-static struct qcom_icc_node qns_mem_noc_sf_cam_ife_0 = {
-	.name = "qns_mem_noc_sf_cam_ife_0",
-	.id = SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_0,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_0 },
-};
-
-static struct qcom_icc_node qns_llcc_cam_ife_1 = {
-	.name = "qns_llcc_cam_ife_1",
-	.id = SM8550_SLAVE_LLCC_CAM_IFE_1,
-	.channels = 4,
-	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8550_MASTER_LLCC_CAM_IFE_1 },
-};
-
-static struct qcom_icc_node ebi_cam_ife_1 = {
-	.name = "ebi_cam_ife_1",
-	.id = SM8550_SLAVE_EBI1_CAM_IFE_1,
-	.channels = 4,
-	.buswidth = 4,
-	.num_links = 0,
-};
-
-static struct qcom_icc_node qns_mem_noc_hf_cam_ife_1 = {
-	.name = "qns_mem_noc_hf_cam_ife_1",
-	.id = SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_1,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_1 },
-};
-
-static struct qcom_icc_node qns_mem_noc_sf_cam_ife_1 = {
-	.name = "qns_mem_noc_sf_cam_ife_1",
-	.id = SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_1,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_1 },
-};
-
-static struct qcom_icc_node qns_llcc_cam_ife_2 = {
-	.name = "qns_llcc_cam_ife_2",
-	.id = SM8550_SLAVE_LLCC_CAM_IFE_2,
-	.channels = 4,
-	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8550_MASTER_LLCC_CAM_IFE_2 },
-};
-
-static struct qcom_icc_node ebi_cam_ife_2 = {
-	.name = "ebi_cam_ife_2",
-	.id = SM8550_SLAVE_EBI1_CAM_IFE_2,
-	.channels = 4,
-	.buswidth = 4,
-	.num_links = 0,
-};
-
-static struct qcom_icc_node qns_mem_noc_hf_cam_ife_2 = {
-	.name = "qns_mem_noc_hf_cam_ife_2",
-	.id = SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_2,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_2 },
-};
-
-static struct qcom_icc_node qns_mem_noc_sf_cam_ife_2 = {
-	.name = "qns_mem_noc_sf_cam_ife_2",
-	.id = SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_2,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_2 },
-};
-
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = 0x8,
@@ -1639,161 +1283,6 @@ static struct qcom_icc_bcm bcm_sn7 = {
 	.nodes = { &qns_pcie_mem_noc },
 };
 
-static struct qcom_icc_bcm bcm_acv_disp = {
-	.name = "ACV",
-	.enable_mask = 0x1,
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
-static struct qcom_icc_bcm bcm_sh0_disp = {
-	.name = "SH0",
-	.num_nodes = 1,
-	.nodes = { &qns_llcc_disp },
-};
-
-static struct qcom_icc_bcm bcm_sh1_disp = {
-	.name = "SH1",
-	.enable_mask = 0x1,
-	.num_nodes = 2,
-	.nodes = { &qnm_mnoc_hf_disp, &qnm_pcie_disp },
-};
-
-static struct qcom_icc_bcm bcm_acv_cam_ife_0 = {
-	.name = "ACV",
-	.enable_mask = 0x0,
-	.num_nodes = 1,
-	.nodes = { &ebi_cam_ife_0 },
-};
-
-static struct qcom_icc_bcm bcm_mc0_cam_ife_0 = {
-	.name = "MC0",
-	.num_nodes = 1,
-	.nodes = { &ebi_cam_ife_0 },
-};
-
-static struct qcom_icc_bcm bcm_mm0_cam_ife_0 = {
-	.name = "MM0",
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf_cam_ife_0 },
-};
-
-static struct qcom_icc_bcm bcm_mm1_cam_ife_0 = {
-	.name = "MM1",
-	.enable_mask = 0x1,
-	.num_nodes = 4,
-	.nodes = { &qnm_camnoc_hf_cam_ife_0, &qnm_camnoc_icp_cam_ife_0,
-		   &qnm_camnoc_sf_cam_ife_0, &qns_mem_noc_sf_cam_ife_0 },
-};
-
-static struct qcom_icc_bcm bcm_sh0_cam_ife_0 = {
-	.name = "SH0",
-	.num_nodes = 1,
-	.nodes = { &qns_llcc_cam_ife_0 },
-};
-
-static struct qcom_icc_bcm bcm_sh1_cam_ife_0 = {
-	.name = "SH1",
-	.enable_mask = 0x1,
-	.num_nodes = 3,
-	.nodes = { &qnm_mnoc_hf_cam_ife_0, &qnm_mnoc_sf_cam_ife_0,
-		   &qnm_pcie_cam_ife_0 },
-};
-
-static struct qcom_icc_bcm bcm_acv_cam_ife_1 = {
-	.name = "ACV",
-	.enable_mask = 0x0,
-	.num_nodes = 1,
-	.nodes = { &ebi_cam_ife_1 },
-};
-
-static struct qcom_icc_bcm bcm_mc0_cam_ife_1 = {
-	.name = "MC0",
-	.num_nodes = 1,
-	.nodes = { &ebi_cam_ife_1 },
-};
-
-static struct qcom_icc_bcm bcm_mm0_cam_ife_1 = {
-	.name = "MM0",
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf_cam_ife_1 },
-};
-
-static struct qcom_icc_bcm bcm_mm1_cam_ife_1 = {
-	.name = "MM1",
-	.enable_mask = 0x1,
-	.num_nodes = 4,
-	.nodes = { &qnm_camnoc_hf_cam_ife_1, &qnm_camnoc_icp_cam_ife_1,
-		   &qnm_camnoc_sf_cam_ife_1, &qns_mem_noc_sf_cam_ife_1 },
-};
-
-static struct qcom_icc_bcm bcm_sh0_cam_ife_1 = {
-	.name = "SH0",
-	.num_nodes = 1,
-	.nodes = { &qns_llcc_cam_ife_1 },
-};
-
-static struct qcom_icc_bcm bcm_sh1_cam_ife_1 = {
-	.name = "SH1",
-	.enable_mask = 0x1,
-	.num_nodes = 3,
-	.nodes = { &qnm_mnoc_hf_cam_ife_1, &qnm_mnoc_sf_cam_ife_1,
-		   &qnm_pcie_cam_ife_1 },
-};
-
-static struct qcom_icc_bcm bcm_acv_cam_ife_2 = {
-	.name = "ACV",
-	.enable_mask = 0x0,
-	.num_nodes = 1,
-	.nodes = { &ebi_cam_ife_2 },
-};
-
-static struct qcom_icc_bcm bcm_mc0_cam_ife_2 = {
-	.name = "MC0",
-	.num_nodes = 1,
-	.nodes = { &ebi_cam_ife_2 },
-};
-
-static struct qcom_icc_bcm bcm_mm0_cam_ife_2 = {
-	.name = "MM0",
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf_cam_ife_2 },
-};
-
-static struct qcom_icc_bcm bcm_mm1_cam_ife_2 = {
-	.name = "MM1",
-	.enable_mask = 0x1,
-	.num_nodes = 4,
-	.nodes = { &qnm_camnoc_hf_cam_ife_2, &qnm_camnoc_icp_cam_ife_2,
-		   &qnm_camnoc_sf_cam_ife_2, &qns_mem_noc_sf_cam_ife_2 },
-};
-
-static struct qcom_icc_bcm bcm_sh0_cam_ife_2 = {
-	.name = "SH0",
-	.num_nodes = 1,
-	.nodes = { &qns_llcc_cam_ife_2 },
-};
-
-static struct qcom_icc_bcm bcm_sh1_cam_ife_2 = {
-	.name = "SH1",
-	.enable_mask = 0x1,
-	.num_nodes = 3,
-	.nodes = { &qnm_mnoc_hf_cam_ife_2, &qnm_mnoc_sf_cam_ife_2,
-		   &qnm_pcie_cam_ife_2 },
-};
-
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 };
 
@@ -1945,14 +1434,6 @@ static const struct qcom_icc_desc sm8550_cnoc_main = {
 static struct qcom_icc_bcm * const gem_noc_bcms[] = {
 	&bcm_sh0,
 	&bcm_sh1,
-	&bcm_sh0_disp,
-	&bcm_sh1_disp,
-	&bcm_sh0_cam_ife_0,
-	&bcm_sh1_cam_ife_0,
-	&bcm_sh0_cam_ife_1,
-	&bcm_sh1_cam_ife_1,
-	&bcm_sh0_cam_ife_2,
-	&bcm_sh1_cam_ife_2,
 };
 
 static struct qcom_icc_node * const gem_noc_nodes[] = {
@@ -1971,21 +1452,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
 	[SLAVE_LLCC] = &qns_llcc,
 	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
-	[MASTER_MNOC_HF_MEM_NOC_DISP] = &qnm_mnoc_hf_disp,
-	[MASTER_ANOC_PCIE_GEM_NOC_DISP] = &qnm_pcie_disp,
-	[SLAVE_LLCC_DISP] = &qns_llcc_disp,
-	[MASTER_MNOC_HF_MEM_NOC_CAM_IFE_0] = &qnm_mnoc_hf_cam_ife_0,
-	[MASTER_MNOC_SF_MEM_NOC_CAM_IFE_0] = &qnm_mnoc_sf_cam_ife_0,
-	[MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_0] = &qnm_pcie_cam_ife_0,
-	[SLAVE_LLCC_CAM_IFE_0] = &qns_llcc_cam_ife_0,
-	[MASTER_MNOC_HF_MEM_NOC_CAM_IFE_1] = &qnm_mnoc_hf_cam_ife_1,
-	[MASTER_MNOC_SF_MEM_NOC_CAM_IFE_1] = &qnm_mnoc_sf_cam_ife_1,
-	[MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_1] = &qnm_pcie_cam_ife_1,
-	[SLAVE_LLCC_CAM_IFE_1] = &qns_llcc_cam_ife_1,
-	[MASTER_MNOC_HF_MEM_NOC_CAM_IFE_2] = &qnm_mnoc_hf_cam_ife_2,
-	[MASTER_MNOC_SF_MEM_NOC_CAM_IFE_2] = &qnm_mnoc_sf_cam_ife_2,
-	[MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_2] = &qnm_pcie_cam_ife_2,
-	[SLAVE_LLCC_CAM_IFE_2] = &qns_llcc_cam_ife_2,
 };
 
 static const struct qcom_icc_desc sm8550_gem_noc = {
@@ -2044,27 +1510,11 @@ static const struct qcom_icc_desc sm8550_lpass_lpicx_noc = {
 static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
-	&bcm_acv_disp,
-	&bcm_mc0_disp,
-	&bcm_acv_cam_ife_0,
-	&bcm_mc0_cam_ife_0,
-	&bcm_acv_cam_ife_1,
-	&bcm_mc0_cam_ife_1,
-	&bcm_acv_cam_ife_2,
-	&bcm_mc0_cam_ife_2,
 };
 
 static struct qcom_icc_node * const mc_virt_nodes[] = {
 	[MASTER_LLCC] = &llcc_mc,
 	[SLAVE_EBI1] = &ebi,
-	[MASTER_LLCC_DISP] = &llcc_mc_disp,
-	[SLAVE_EBI1_DISP] = &ebi_disp,
-	[MASTER_LLCC_CAM_IFE_0] = &llcc_mc_cam_ife_0,
-	[SLAVE_EBI1_CAM_IFE_0] = &ebi_cam_ife_0,
-	[MASTER_LLCC_CAM_IFE_1] = &llcc_mc_cam_ife_1,
-	[SLAVE_EBI1_CAM_IFE_1] = &ebi_cam_ife_1,
-	[MASTER_LLCC_CAM_IFE_2] = &llcc_mc_cam_ife_2,
-	[SLAVE_EBI1_CAM_IFE_2] = &ebi_cam_ife_2,
 };
 
 static const struct qcom_icc_desc sm8550_mc_virt = {
@@ -2077,13 +1527,6 @@ static const struct qcom_icc_desc sm8550_mc_virt = {
 static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
 	&bcm_mm0,
 	&bcm_mm1,
-	&bcm_mm0_disp,
-	&bcm_mm0_cam_ife_0,
-	&bcm_mm1_cam_ife_0,
-	&bcm_mm0_cam_ife_1,
-	&bcm_mm1_cam_ife_1,
-	&bcm_mm0_cam_ife_2,
-	&bcm_mm1_cam_ife_2,
 };
 
 static struct qcom_icc_node * const mmss_noc_nodes[] = {
@@ -2100,23 +1543,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
 	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
 	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
-	[MASTER_MDP_DISP] = &qnm_mdp_disp,
-	[SLAVE_MNOC_HF_MEM_NOC_DISP] = &qns_mem_noc_hf_disp,
-	[MASTER_CAMNOC_HF_CAM_IFE_0] = &qnm_camnoc_hf_cam_ife_0,
-	[MASTER_CAMNOC_ICP_CAM_IFE_0] = &qnm_camnoc_icp_cam_ife_0,
-	[MASTER_CAMNOC_SF_CAM_IFE_0] = &qnm_camnoc_sf_cam_ife_0,
-	[SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_0] = &qns_mem_noc_hf_cam_ife_0,
-	[SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_0] = &qns_mem_noc_sf_cam_ife_0,
-	[MASTER_CAMNOC_HF_CAM_IFE_1] = &qnm_camnoc_hf_cam_ife_1,
-	[MASTER_CAMNOC_ICP_CAM_IFE_1] = &qnm_camnoc_icp_cam_ife_1,
-	[MASTER_CAMNOC_SF_CAM_IFE_1] = &qnm_camnoc_sf_cam_ife_1,
-	[SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_1] = &qns_mem_noc_hf_cam_ife_1,
-	[SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_1] = &qns_mem_noc_sf_cam_ife_1,
-	[MASTER_CAMNOC_HF_CAM_IFE_2] = &qnm_camnoc_hf_cam_ife_2,
-	[MASTER_CAMNOC_ICP_CAM_IFE_2] = &qnm_camnoc_icp_cam_ife_2,
-	[MASTER_CAMNOC_SF_CAM_IFE_2] = &qnm_camnoc_sf_cam_ife_2,
-	[SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_2] = &qns_mem_noc_hf_cam_ife_2,
-	[SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_2] = &qns_mem_noc_sf_cam_ife_2,
 };
 
 static const struct qcom_icc_desc sm8550_mmss_noc = {
diff --git a/drivers/interconnect/qcom/sm8550.h b/drivers/interconnect/qcom/sm8550.h
index 8d5862c04bca..c9b2986e1293 100644
--- a/drivers/interconnect/qcom/sm8550.h
+++ b/drivers/interconnect/qcom/sm8550.h
@@ -12,167 +12,127 @@
 #define SM8550_MASTER_A1NOC_SNOC			0
 #define SM8550_MASTER_A2NOC_SNOC			1
 #define SM8550_MASTER_ANOC_PCIE_GEM_NOC			2
-#define SM8550_MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_0	3
-#define SM8550_MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_1	4
-#define SM8550_MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_2	5
-#define SM8550_MASTER_ANOC_PCIE_GEM_NOC_DISP		6
-#define SM8550_MASTER_APPSS_PROC			7
-#define SM8550_MASTER_CAMNOC_HF				8
-#define SM8550_MASTER_CAMNOC_HF_CAM_IFE_0		9
-#define SM8550_MASTER_CAMNOC_HF_CAM_IFE_1		10
-#define SM8550_MASTER_CAMNOC_HF_CAM_IFE_2		11
-#define SM8550_MASTER_CAMNOC_ICP			12
-#define SM8550_MASTER_CAMNOC_ICP_CAM_IFE_0		13
-#define SM8550_MASTER_CAMNOC_ICP_CAM_IFE_1		14
-#define SM8550_MASTER_CAMNOC_ICP_CAM_IFE_2		15
-#define SM8550_MASTER_CAMNOC_SF				16
-#define SM8550_MASTER_CAMNOC_SF_CAM_IFE_0		17
-#define SM8550_MASTER_CAMNOC_SF_CAM_IFE_1		18
-#define SM8550_MASTER_CAMNOC_SF_CAM_IFE_2		19
-#define SM8550_MASTER_CDSP_HCP				20
-#define SM8550_MASTER_CDSP_PROC				21
-#define SM8550_MASTER_CNOC_CFG				22
-#define SM8550_MASTER_CNOC_MNOC_CFG			23
-#define SM8550_MASTER_COMPUTE_NOC			24
-#define SM8550_MASTER_CRYPTO				25
-#define SM8550_MASTER_GEM_NOC_CNOC			26
-#define SM8550_MASTER_GEM_NOC_PCIE_SNOC			27
-#define SM8550_MASTER_GFX3D				28
-#define SM8550_MASTER_GIC				29
-#define SM8550_MASTER_GIC_AHB				30
-#define SM8550_MASTER_GPU_TCU				31
-#define SM8550_MASTER_IPA				32
-#define SM8550_MASTER_LLCC				33
-#define SM8550_MASTER_LLCC_CAM_IFE_0			34
-#define SM8550_MASTER_LLCC_CAM_IFE_1			35
-#define SM8550_MASTER_LLCC_CAM_IFE_2			36
-#define SM8550_MASTER_LLCC_DISP				37
-#define SM8550_MASTER_LPASS_GEM_NOC			38
-#define SM8550_MASTER_LPASS_LPINOC			39
-#define SM8550_MASTER_LPASS_PROC			40
-#define SM8550_MASTER_LPIAON_NOC			41
-#define SM8550_MASTER_MDP				42
-#define SM8550_MASTER_MDP_DISP				43
-#define SM8550_MASTER_MNOC_HF_MEM_NOC			44
-#define SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_0		45
-#define SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_1		46
-#define SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_2		47
-#define SM8550_MASTER_MNOC_HF_MEM_NOC_DISP		48
-#define SM8550_MASTER_MNOC_SF_MEM_NOC			49
-#define SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_0		50
-#define SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_1		51
-#define SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_2		52
-#define SM8550_MASTER_MSS_PROC				53
-#define SM8550_MASTER_PCIE_0				54
-#define SM8550_MASTER_PCIE_1				55
-#define SM8550_MASTER_PCIE_ANOC_CFG			56
-#define SM8550_MASTER_QDSS_BAM				57
-#define SM8550_MASTER_QDSS_ETR				58
-#define SM8550_MASTER_QDSS_ETR_1			59
-#define SM8550_MASTER_QSPI_0				60
-#define SM8550_MASTER_QUP_1				61
-#define SM8550_MASTER_QUP_2				62
-#define SM8550_MASTER_QUP_CORE_0			63
-#define SM8550_MASTER_QUP_CORE_1			64
-#define SM8550_MASTER_QUP_CORE_2			65
-#define SM8550_MASTER_SDCC_2				66
-#define SM8550_MASTER_SDCC_4				67
-#define SM8550_MASTER_SNOC_GC_MEM_NOC			68
-#define SM8550_MASTER_SNOC_SF_MEM_NOC			69
-#define SM8550_MASTER_SP				70
-#define SM8550_MASTER_SYS_TCU				71
-#define SM8550_MASTER_UFS_MEM				72
-#define SM8550_MASTER_USB3_0				73
-#define SM8550_MASTER_VIDEO				74
-#define SM8550_MASTER_VIDEO_CV_PROC			75
-#define SM8550_MASTER_VIDEO_PROC			76
-#define SM8550_MASTER_VIDEO_V_PROC			77
-#define SM8550_SLAVE_A1NOC_SNOC				78
-#define SM8550_SLAVE_A2NOC_SNOC				79
-#define SM8550_SLAVE_AHB2PHY_NORTH			80
-#define SM8550_SLAVE_AHB2PHY_SOUTH			81
-#define SM8550_SLAVE_ANOC_PCIE_GEM_NOC			82
-#define SM8550_SLAVE_AOSS				83
-#define SM8550_SLAVE_APPSS				84
-#define SM8550_SLAVE_BOOT_IMEM				85
-#define SM8550_SLAVE_CAMERA_CFG				86
-#define SM8550_SLAVE_CDSP_MEM_NOC			87
-#define SM8550_SLAVE_CLK_CTL				88
-#define SM8550_SLAVE_CNOC_CFG				89
-#define SM8550_SLAVE_CNOC_MNOC_CFG			90
-#define SM8550_SLAVE_CNOC_MSS				91
-#define SM8550_SLAVE_CPR_NSPCX				92
-#define SM8550_SLAVE_CRYPTO_0_CFG			93
-#define SM8550_SLAVE_CX_RDPM				94
-#define SM8550_SLAVE_DDRSS_CFG				95
-#define SM8550_SLAVE_DISPLAY_CFG			96
-#define SM8550_SLAVE_EBI1				97
-#define SM8550_SLAVE_EBI1_CAM_IFE_0			98
-#define SM8550_SLAVE_EBI1_CAM_IFE_1			99
-#define SM8550_SLAVE_EBI1_CAM_IFE_2			100
-#define SM8550_SLAVE_EBI1_DISP				101
-#define SM8550_SLAVE_GEM_NOC_CNOC			102
-#define SM8550_SLAVE_GFX3D_CFG				103
-#define SM8550_SLAVE_I2C				104
-#define SM8550_SLAVE_IMEM				105
-#define SM8550_SLAVE_IMEM_CFG				106
-#define SM8550_SLAVE_IPA_CFG				107
-#define SM8550_SLAVE_IPC_ROUTER_CFG			108
-#define SM8550_SLAVE_LLCC				109
-#define SM8550_SLAVE_LLCC_CAM_IFE_0			110
-#define SM8550_SLAVE_LLCC_CAM_IFE_1			111
-#define SM8550_SLAVE_LLCC_CAM_IFE_2			112
-#define SM8550_SLAVE_LLCC_DISP				113
-#define SM8550_SLAVE_LPASS_GEM_NOC			114
-#define SM8550_SLAVE_LPASS_QTB_CFG			115
-#define SM8550_SLAVE_LPIAON_NOC_LPASS_AG_NOC		116
-#define SM8550_SLAVE_LPICX_NOC_LPIAON_NOC		117
-#define SM8550_SLAVE_MEM_NOC_PCIE_SNOC			118
-#define SM8550_SLAVE_MNOC_HF_MEM_NOC			119
-#define SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_0		120
-#define SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_1		121
-#define SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_2		122
-#define SM8550_SLAVE_MNOC_HF_MEM_NOC_DISP		123
-#define SM8550_SLAVE_MNOC_SF_MEM_NOC			124
-#define SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_0		125
-#define SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_1		126
-#define SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_2		127
-#define SM8550_SLAVE_MX_RDPM				128
-#define SM8550_SLAVE_NSP_QTB_CFG			129
-#define SM8550_SLAVE_PCIE_0				130
-#define SM8550_SLAVE_PCIE_0_CFG				131
-#define SM8550_SLAVE_PCIE_1				132
-#define SM8550_SLAVE_PCIE_1_CFG				133
-#define SM8550_SLAVE_PCIE_ANOC_CFG			134
-#define SM8550_SLAVE_PDM				135
-#define SM8550_SLAVE_PIMEM_CFG				136
-#define SM8550_SLAVE_PRNG				137
-#define SM8550_SLAVE_QDSS_CFG				138
-#define SM8550_SLAVE_QDSS_STM				139
-#define SM8550_SLAVE_QSPI_0				140
-#define SM8550_SLAVE_QUP_1				141
-#define SM8550_SLAVE_QUP_2				142
-#define SM8550_SLAVE_QUP_CORE_0				143
-#define SM8550_SLAVE_QUP_CORE_1				144
-#define SM8550_SLAVE_QUP_CORE_2				145
-#define SM8550_SLAVE_RBCPR_CX_CFG			146
-#define SM8550_SLAVE_RBCPR_MMCX_CFG			147
-#define SM8550_SLAVE_RBCPR_MXA_CFG			148
-#define SM8550_SLAVE_RBCPR_MXC_CFG			149
-#define SM8550_SLAVE_SDCC_2				150
-#define SM8550_SLAVE_SDCC_4				151
-#define SM8550_SLAVE_SERVICE_MNOC			152
-#define SM8550_SLAVE_SERVICE_PCIE_ANOC			153
-#define SM8550_SLAVE_SNOC_GEM_NOC_GC			154
-#define SM8550_SLAVE_SNOC_GEM_NOC_SF			155
-#define SM8550_SLAVE_SPSS_CFG				156
-#define SM8550_SLAVE_TCSR				157
-#define SM8550_SLAVE_TCU				158
-#define SM8550_SLAVE_TLMM				159
-#define SM8550_SLAVE_TME_CFG				160
-#define SM8550_SLAVE_UFS_MEM_CFG			161
-#define SM8550_SLAVE_USB3_0				162
-#define SM8550_SLAVE_VENUS_CFG				163
-#define SM8550_SLAVE_VSENSE_CTRL_CFG			164
+#define SM8550_MASTER_APPSS_PROC			3
+#define SM8550_MASTER_CAMNOC_HF				4
+#define SM8550_MASTER_CAMNOC_ICP			5
+#define SM8550_MASTER_CAMNOC_SF				6
+#define SM8550_MASTER_CDSP_HCP				7
+#define SM8550_MASTER_CDSP_PROC				8
+#define SM8550_MASTER_CNOC_CFG				9
+#define SM8550_MASTER_CNOC_MNOC_CFG			10
+#define SM8550_MASTER_COMPUTE_NOC			11
+#define SM8550_MASTER_CRYPTO				12
+#define SM8550_MASTER_GEM_NOC_CNOC			13
+#define SM8550_MASTER_GEM_NOC_PCIE_SNOC			14
+#define SM8550_MASTER_GFX3D				15
+#define SM8550_MASTER_GIC				16
+#define SM8550_MASTER_GIC_AHB				17
+#define SM8550_MASTER_GPU_TCU				18
+#define SM8550_MASTER_IPA				19
+#define SM8550_MASTER_LLCC				20
+#define SM8550_MASTER_LPASS_GEM_NOC			21
+#define SM8550_MASTER_LPASS_LPINOC			22
+#define SM8550_MASTER_LPASS_PROC			23
+#define SM8550_MASTER_LPIAON_NOC			24
+#define SM8550_MASTER_MDP				25
+#define SM8550_MASTER_MNOC_HF_MEM_NOC			26
+#define SM8550_MASTER_MNOC_SF_MEM_NOC			27
+#define SM8550_MASTER_MSS_PROC				28
+#define SM8550_MASTER_PCIE_0				29
+#define SM8550_MASTER_PCIE_1				30
+#define SM8550_MASTER_PCIE_ANOC_CFG			31
+#define SM8550_MASTER_QDSS_BAM				32
+#define SM8550_MASTER_QDSS_ETR				33
+#define SM8550_MASTER_QDSS_ETR_1			34
+#define SM8550_MASTER_QSPI_0				35
+#define SM8550_MASTER_QUP_1				36
+#define SM8550_MASTER_QUP_2				37
+#define SM8550_MASTER_QUP_CORE_0			38
+#define SM8550_MASTER_QUP_CORE_1			39
+#define SM8550_MASTER_QUP_CORE_2			40
+#define SM8550_MASTER_SDCC_2				41
+#define SM8550_MASTER_SDCC_4				42
+#define SM8550_MASTER_SNOC_GC_MEM_NOC			43
+#define SM8550_MASTER_SNOC_SF_MEM_NOC			44
+#define SM8550_MASTER_SP				45
+#define SM8550_MASTER_SYS_TCU				46
+#define SM8550_MASTER_UFS_MEM				47
+#define SM8550_MASTER_USB3_0				48
+#define SM8550_MASTER_VIDEO				49
+#define SM8550_MASTER_VIDEO_CV_PROC			50
+#define SM8550_MASTER_VIDEO_PROC			51
+#define SM8550_MASTER_VIDEO_V_PROC			52
+#define SM8550_SLAVE_A1NOC_SNOC				53
+#define SM8550_SLAVE_A2NOC_SNOC				54
+#define SM8550_SLAVE_AHB2PHY_NORTH			55
+#define SM8550_SLAVE_AHB2PHY_SOUTH			56
+#define SM8550_SLAVE_ANOC_PCIE_GEM_NOC			57
+#define SM8550_SLAVE_AOSS				58
+#define SM8550_SLAVE_APPSS				59
+#define SM8550_SLAVE_BOOT_IMEM				60
+#define SM8550_SLAVE_CAMERA_CFG				61
+#define SM8550_SLAVE_CDSP_MEM_NOC			62
+#define SM8550_SLAVE_CLK_CTL				63
+#define SM8550_SLAVE_CNOC_CFG				64
+#define SM8550_SLAVE_CNOC_MNOC_CFG			65
+#define SM8550_SLAVE_CNOC_MSS				66
+#define SM8550_SLAVE_CPR_NSPCX				67
+#define SM8550_SLAVE_CRYPTO_0_CFG			68
+#define SM8550_SLAVE_CX_RDPM				69
+#define SM8550_SLAVE_DDRSS_CFG				70
+#define SM8550_SLAVE_DISPLAY_CFG			71
+#define SM8550_SLAVE_EBI1				72
+#define SM8550_SLAVE_GEM_NOC_CNOC			73
+#define SM8550_SLAVE_GFX3D_CFG				74
+#define SM8550_SLAVE_I2C				75
+#define SM8550_SLAVE_IMEM				76
+#define SM8550_SLAVE_IMEM_CFG				77
+#define SM8550_SLAVE_IPA_CFG				78
+#define SM8550_SLAVE_IPC_ROUTER_CFG			79
+#define SM8550_SLAVE_LLCC				80
+#define SM8550_SLAVE_LPASS_GEM_NOC			81
+#define SM8550_SLAVE_LPASS_QTB_CFG			82
+#define SM8550_SLAVE_LPIAON_NOC_LPASS_AG_NOC		83
+#define SM8550_SLAVE_LPICX_NOC_LPIAON_NOC		84
+#define SM8550_SLAVE_MEM_NOC_PCIE_SNOC			85
+#define SM8550_SLAVE_MNOC_HF_MEM_NOC			86
+#define SM8550_SLAVE_MNOC_SF_MEM_NOC			87
+#define SM8550_SLAVE_MX_RDPM				88
+#define SM8550_SLAVE_NSP_QTB_CFG			89
+#define SM8550_SLAVE_PCIE_0				90
+#define SM8550_SLAVE_PCIE_0_CFG				91
+#define SM8550_SLAVE_PCIE_1				92
+#define SM8550_SLAVE_PCIE_1_CFG				93
+#define SM8550_SLAVE_PCIE_ANOC_CFG			94
+#define SM8550_SLAVE_PDM				95
+#define SM8550_SLAVE_PIMEM_CFG				96
+#define SM8550_SLAVE_PRNG				97
+#define SM8550_SLAVE_QDSS_CFG				98
+#define SM8550_SLAVE_QDSS_STM				99
+#define SM8550_SLAVE_QSPI_0				100
+#define SM8550_SLAVE_QUP_1				101
+#define SM8550_SLAVE_QUP_2				102
+#define SM8550_SLAVE_QUP_CORE_0				103
+#define SM8550_SLAVE_QUP_CORE_1				104
+#define SM8550_SLAVE_QUP_CORE_2				105
+#define SM8550_SLAVE_RBCPR_CX_CFG			106
+#define SM8550_SLAVE_RBCPR_MMCX_CFG			107
+#define SM8550_SLAVE_RBCPR_MXA_CFG			108
+#define SM8550_SLAVE_RBCPR_MXC_CFG			109
+#define SM8550_SLAVE_SDCC_2				110
+#define SM8550_SLAVE_SDCC_4				111
+#define SM8550_SLAVE_SERVICE_MNOC			112
+#define SM8550_SLAVE_SERVICE_PCIE_ANOC			113
+#define SM8550_SLAVE_SNOC_GEM_NOC_GC			114
+#define SM8550_SLAVE_SNOC_GEM_NOC_SF			115
+#define SM8550_SLAVE_SPSS_CFG				116
+#define SM8550_SLAVE_TCSR				117
+#define SM8550_SLAVE_TCU				118
+#define SM8550_SLAVE_TLMM				119
+#define SM8550_SLAVE_TME_CFG				120
+#define SM8550_SLAVE_UFS_MEM_CFG			121
+#define SM8550_SLAVE_USB3_0				122
+#define SM8550_SLAVE_VENUS_CFG				123
+#define SM8550_SLAVE_VSENSE_CTRL_CFG			124
 
 #endif

-- 
2.43.0


