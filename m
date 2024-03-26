Return-Path: <linux-kernel+bounces-119825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1A488CD62
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44922E7069
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AB813D2A2;
	Tue, 26 Mar 2024 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mImu7TJ6"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDBC13D252
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482166; cv=none; b=jixYkL10HAG78iE8e6bzt57BSlCdmY1r8TMH/LwKR75S+mlJ7yW3l6HPl98dTV+ORoXW6eXm41wV8+JpDC4BHBfC7ZwCONb1tFsyixlnN6FWPrOJDsTSPmGgZF3RG2RQDbGH4n1/lk4vVIFnwQluuct/VwPLccRpKGZRAAEI3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482166; c=relaxed/simple;
	bh=QAWXhP0/DeIKOkR5EyVgpxxI+y5QCHvQ1OzY2zqxNkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KagjOGN2NT2bRjEY+pz7aPfWGHxCPERCykDhIacvq+bCvBkqjgN5B7M6328pJO8ind3psig8+lr+H/SzsbvkMU4n4i4ZZ8S5QsWpotZhHjZXnF+9xOf4mxWnOvVMZnOnTUYkpv0kXxhhI2NaLF78uRU6J+WKOvysha6ZpetTgV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mImu7TJ6; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-515a86daf09so4070082e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711482163; x=1712086963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgBxsKu0wsGM1uHB/qLjbyXLhZUIVqIiRSHak/4hN1c=;
        b=mImu7TJ69dwiullkVL8ePLuDXi4tOPVPcaR0ZlMY3bWjiWomw1FPvK/0tjXOFT2eOI
         h50N444R/ChUK2yJfmSWwdrn5CrBorrsqmrVcX7KtbZQ1zzyCx0QzMY7iUGMP/zqsiiP
         VPDLR68Pm4d4B/LXL3KZ36R+VqtQf72pk2zeFkjHS6CBrhRLe6i91HG8yqqsMkJlghxS
         /BUaibl7G/wwsvkDmqU2Tvyje2EPCf1yfPnavXRSqd1Vtufe8aY6wkvlJBT5bfjzNSEO
         6/GoV4dOGP+NrVhxrz/kRfVwV0hoLNY/y1bFBlUMnjqTD+oBK7Sm8GdxoO+AF5uQJF8V
         Le6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711482163; x=1712086963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgBxsKu0wsGM1uHB/qLjbyXLhZUIVqIiRSHak/4hN1c=;
        b=l0wwulvJ+w1yD+HGkFXs2oaXE0PXbOyeAM+eOOAPcYJzRiFrS27cGOGIOlcsF4oGFA
         iCnLT2P9U4nZSg8qIGkre2irByDuflFpFHgWfiZCRccUPxaQldKBippmtKZBvW0DOa34
         jQKQGrMNkcqxDhkoMlMQeLhpbjOBQL8MELTa7TswyBgT+0ouI7DIzjJLvk55mdqllKkE
         ll0UJX3NVZcxpHIqoHzt48ltG2+aEOCbb0v95Xf6WHud9CYIe/SDBre9P0NuBzcLhf/o
         awaLMWWNeA04nYPa8FS2/rJhlu5slH+qzVe+SZEey84WobdDfXYpJFoa3jFoSTA0T1Z9
         fXGg==
X-Forwarded-Encrypted: i=1; AJvYcCXJKfcwXaV/ZKR+fJFhxytFFuDl/Y42bfMF43Zz+BiQzL16bD57wNAfu1qRkl/nY5R6xShCpwbIqU7D4MG8ju8UqTEhRgO6CPQ1zqwf
X-Gm-Message-State: AOJu0Ywt7f9tdb7HHgusqs/8ybPxc0ZlKtugxFkErBEhapjpG3CfdnWy
	s1Nw1g79EA+pCXzxGX7lCMfoB3/mrkmczi+tCvlpxlBFoZuXZQeWDCEXF58fb2E=
X-Google-Smtp-Source: AGHT+IEFZe+XDEC7vIPSgYKQGe5QWiPwKZbMZ2fhQJHVWweMsvEZn9JP0XYrsxAVX2VTc7Ax1lqh3A==
X-Received: by 2002:a19:7714:0:b0:513:df6:dcd3 with SMTP id s20-20020a197714000000b005130df6dcd3mr7382857lfc.48.1711482162693;
        Tue, 26 Mar 2024 12:42:42 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b00a46d4e26301sm4523807ejk.27.2024.03.26.12.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:42:42 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 26 Mar 2024 20:42:32 +0100
Subject: [PATCH 1/4] interconnect: qcom: sm6115: Unspaghettify SNoC QoS
 port numbering
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-topic-rpm_icc_qos_cleanup-v1-1-357e736792be@linaro.org>
References: <20240326-topic-rpm_icc_qos_cleanup-v1-0-357e736792be@linaro.org>
In-Reply-To: <20240326-topic-rpm_icc_qos_cleanup-v1-0-357e736792be@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711482160; l=5340;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=QAWXhP0/DeIKOkR5EyVgpxxI+y5QCHvQ1OzY2zqxNkU=;
 b=mmsZQopLXWoyeGXaSfSSIJpsCJdAipax9jUk9FgHghFCfhN81j1SnQC3GSq20gMg7L3v867LD
 LHTXmj/DIiTA30JVUeFPBhuwIbx56u+717kDDaw1USkyN4W6+/Cp62Y
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

When I was creating this driver, my bright mind overlooked the existence
of desc->qos_offset and decided to make up for the difference it made by
adding 21 (0x15) to the port index on SNoC and its downstream buses.

Undo this mistake to make the indices actually mean something.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm6115.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/interconnect/qcom/sm6115.c b/drivers/interconnect/qcom/sm6115.c
index 7e15ddf0a80a..271b07c74862 100644
--- a/drivers/interconnect/qcom/sm6115.c
+++ b/drivers/interconnect/qcom/sm6115.c
@@ -242,7 +242,7 @@ static struct qcom_icc_node crypto_c0 = {
 	.id = SM6115_MASTER_CRYPTO_CORE0,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 43,
+	.qos.qos_port = 22,
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.areq_prio = 2,
 	.mas_rpm_id = 23,
@@ -332,7 +332,7 @@ static struct qcom_icc_node qnm_camera_nrt = {
 	.id = SM6115_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
-	.qos.qos_port = 25,
+	.qos.qos_port = 4,
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.areq_prio = 3,
 	.mas_rpm_id = -1,
@@ -346,7 +346,7 @@ static struct qcom_icc_node qxm_venus0 = {
 	.id = SM6115_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 16,
-	.qos.qos_port = 30,
+	.qos.qos_port = 9,
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.areq_prio = 3,
 	.qos.urg_fwd_en = true,
@@ -361,7 +361,7 @@ static struct qcom_icc_node qxm_venus_cpu = {
 	.id = SM6115_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 34,
+	.qos.qos_port = 13,
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.areq_prio = 4,
 	.mas_rpm_id = -1,
@@ -379,7 +379,7 @@ static struct qcom_icc_node qnm_camera_rt = {
 	.id = SM6115_MASTER_CAMNOC_HF,
 	.channels = 1,
 	.buswidth = 32,
-	.qos.qos_port = 31,
+	.qos.qos_port = 10,
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.areq_prio = 3,
 	.qos.urg_fwd_en = true,
@@ -394,7 +394,7 @@ static struct qcom_icc_node qxm_mdp0 = {
 	.id = SM6115_MASTER_MDP_PORT0,
 	.channels = 1,
 	.buswidth = 16,
-	.qos.qos_port = 26,
+	.qos.qos_port = 5,
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.areq_prio = 3,
 	.qos.urg_fwd_en = true,
@@ -434,7 +434,7 @@ static struct qcom_icc_node qhm_tic = {
 	.id = SM6115_MASTER_TIC,
 	.channels = 1,
 	.buswidth = 4,
-	.qos.qos_port = 29,
+	.qos.qos_port = 8,
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.areq_prio = 2,
 	.mas_rpm_id = -1,
@@ -484,7 +484,7 @@ static struct qcom_icc_node qxm_pimem = {
 	.id = SM6115_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 41,
+	.qos.qos_port = 20,
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.areq_prio = 2,
 	.mas_rpm_id = -1,
@@ -498,7 +498,7 @@ static struct qcom_icc_node qhm_qdss_bam = {
 	.id = SM6115_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
-	.qos.qos_port = 23,
+	.qos.qos_port = 2,
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.areq_prio = 2,
 	.mas_rpm_id = -1,
@@ -523,7 +523,7 @@ static struct qcom_icc_node qhm_qup0 = {
 	.id = SM6115_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.qos.qos_port = 21,
+	.qos.qos_port = 0,
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.areq_prio = 2,
 	.mas_rpm_id = 166,
@@ -537,7 +537,7 @@ static struct qcom_icc_node qxm_ipa = {
 	.id = SM6115_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 24,
+	.qos.qos_port = 3,
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.areq_prio = 2,
 	.mas_rpm_id = 59,
@@ -551,7 +551,7 @@ static struct qcom_icc_node xm_qdss_etr = {
 	.id = SM6115_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 33,
+	.qos.qos_port = 12,
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.areq_prio = 2,
 	.mas_rpm_id = -1,
@@ -565,7 +565,7 @@ static struct qcom_icc_node xm_sdc1 = {
 	.id = SM6115_MASTER_SDCC_1,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 38,
+	.qos.qos_port = 17,
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.areq_prio = 2,
 	.mas_rpm_id = 33,
@@ -579,7 +579,7 @@ static struct qcom_icc_node xm_sdc2 = {
 	.id = SM6115_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 44,
+	.qos.qos_port = 23,
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.areq_prio = 2,
 	.mas_rpm_id = 35,
@@ -593,7 +593,7 @@ static struct qcom_icc_node xm_usb3_0 = {
 	.id = SM6115_MASTER_USB3,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 45,
+	.qos.qos_port = 24,
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.areq_prio = 2,
 	.mas_rpm_id = -1,
@@ -1336,6 +1336,7 @@ static const struct qcom_icc_desc sm6115_sys_noc = {
 	.intf_clocks = snoc_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(snoc_intf_clocks),
 	.bus_clk_desc = &bus_2_clk,
+	.qos_offset = 0x15000,
 	.keep_alive = true,
 };
 
@@ -1367,6 +1368,7 @@ static const struct qcom_icc_desc sm6115_mmnrt_virt = {
 	.regmap_cfg = &sys_noc_regmap_config,
 	.bus_clk_desc = &mmaxi_0_clk,
 	.keep_alive = true,
+	.qos_offset = 0x15000,
 	.ab_coeff = 142,
 };
 
@@ -1383,6 +1385,7 @@ static const struct qcom_icc_desc sm6115_mmrt_virt = {
 	.regmap_cfg = &sys_noc_regmap_config,
 	.bus_clk_desc = &mmaxi_1_clk,
 	.keep_alive = true,
+	.qos_offset = 0x15000,
 	.ab_coeff = 139,
 };
 

-- 
2.44.0


