Return-Path: <linux-kernel+bounces-161969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856F38B53F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84EF1C2166D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F2B2837E;
	Mon, 29 Apr 2024 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E72el8a2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8786123772;
	Mon, 29 Apr 2024 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382032; cv=none; b=ml0Pb1rMh7DL6LNMuzaVHg1Kc9a71Wu19KSpFN9/kr92E+NvqoOsLDGY7LTpm29rmFmLvtmgsMAaG10gCXbYhz0PD8eSjUDDpgpyOlEd5cmOhK1sK53b6MU3+vbt2T9ENUR99cLM9cfDBa57z76dAohj6KS0RjgMQlg4MRqbUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382032; c=relaxed/simple;
	bh=m1RA8VKximOxhjLzeBoulF/dmbxBYXP0Pfm8p7c+Kb8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fz+0ETtDGv3YRO/yXgBXQXURIrpe8DueczcXISYf3Xk2AVkG20B6jFLY5mkEVZdREdZ5D476xk+nqBbO6YXkaQdNsUpNJNoGaTc6bWTgdSz4Xh3EKjzUOJRp1YEX8/Tzf2IAM/mtrlKYwh9bN8Uciflq7Pw/W7RiVzLPoTIW+N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E72el8a2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T6G8KT015537;
	Mon, 29 Apr 2024 09:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Ioz+Q1Cmw+ToQ+CGQtrpeDHseH8BJU3i2ID0krZ5W8I=; b=E7
	2el8a2VZ+WnUUuHOaRbSZQvJZcLyWgb93VF2l2C2fTTN7LDdvfWdmzSxhCp4mWTW
	eb0BD/fDhVwss6J3y68SANQ/101QwSB/NwYs42aDq4jWbCxfQRKd1XvKukHsNYV3
	uqjgBMjsVcT/K4zt/1ljiMmSWanHCiyg5BZoKS+mFAXHswVFZOaTJwyNxu7g2qqt
	Jbb4yLtP6D4l43X1ScMEsVHvpV/o6HkqZdJ0uAdP8vlpUjxmx49tpqTNoJOdzh4y
	7Qtbg1i9ljtHmc7S9vCzLL1wR+p29a/sndl0M3xka/n1Yp9ZcArnWAgeNM5yDu51
	2W5NDlCj6Yqu1BluarnA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrpqrug3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 09:13:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43T9DdBG025014
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 09:13:39 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 02:13:33 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_varada@quicinc.com>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v10 1/6] interconnect: icc-clk: Allow user to specify master/slave ids
Date: Mon, 29 Apr 2024 14:43:09 +0530
Message-ID: <20240429091314.761900-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429091314.761900-1-quic_varada@quicinc.com>
References: <20240429091314.761900-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8Xguzf8bHPAQHnFzqdjcAXaHCwtGiENg
X-Proofpoint-ORIG-GUID: 8Xguzf8bHPAQHnFzqdjcAXaHCwtGiENg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_06,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404290057

Presently, icc-clk driver autogenerates the master and slave ids.
However, devices with multiple nodes on the interconnect could
have other constraints and may not match with the auto generated
node ids. Hence, allow the driver to provide the preferred master
and slave ids.

Also, update clk-cbf-8996 accordingly.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v9: squash cbf-msm8996 change into this
v8: Per review feedback, set master/slave ids explicitly. Dont autogenerate 
    https://lore.kernel.org/linux-arm-msm/f1b0d280-6986-4055-a611-2caceb15867d@linaro.org/
---
 drivers/clk/qcom/clk-cbf-8996.c  | 7 ++++++-
 drivers/interconnect/icc-clk.c   | 6 +++---
 include/linux/interconnect-clk.h | 2 ++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clk-cbf-8996.c b/drivers/clk/qcom/clk-cbf-8996.c
index fe24b4abeab4..a077d4403967 100644
--- a/drivers/clk/qcom/clk-cbf-8996.c
+++ b/drivers/clk/qcom/clk-cbf-8996.c
@@ -237,7 +237,12 @@ static int qcom_msm8996_cbf_icc_register(struct platform_device *pdev, struct cl
 	struct device *dev = &pdev->dev;
 	struct clk *clk = devm_clk_hw_get_clk(dev, cbf_hw, "cbf");
 	const struct icc_clk_data data[] = {
-		{ .clk = clk, .name = "cbf", },
+		{
+			.clk = clk,
+			.name = "cbf",
+			.master_id = MASTER_CBF_M4M,
+			.slave_id = SLAVE_CBF_M4M,
+		},
 	};
 	struct icc_provider *provider;
 
diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index d787f2ea36d9..2be193fd7d8f 100644
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -108,7 +108,7 @@ struct icc_provider *icc_clk_register(struct device *dev,
 	for (i = 0, j = 0; i < num_clocks; i++) {
 		qp->clocks[i].clk = data[i].clk;
 
-		node = icc_node_create(first_id + j);
+		node = icc_node_create(first_id + data[i].master_id);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			goto err;
@@ -118,10 +118,10 @@ struct icc_provider *icc_clk_register(struct device *dev,
 		node->data = &qp->clocks[i];
 		icc_node_add(node, provider);
 		/* link to the next node, slave */
-		icc_link_create(node, first_id + j + 1);
+		icc_link_create(node, first_id + data[i].slave_id);
 		onecell->nodes[j++] = node;
 
-		node = icc_node_create(first_id + j);
+		node = icc_node_create(first_id + data[i].slave_id);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			goto err;
diff --git a/include/linux/interconnect-clk.h b/include/linux/interconnect-clk.h
index 0cd80112bea5..170898faaacb 100644
--- a/include/linux/interconnect-clk.h
+++ b/include/linux/interconnect-clk.h
@@ -11,6 +11,8 @@ struct device;
 struct icc_clk_data {
 	struct clk *clk;
 	const char *name;
+	unsigned int master_id;
+	unsigned int slave_id;
 };
 
 struct icc_provider *icc_clk_register(struct device *dev,
-- 
2.34.1


