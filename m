Return-Path: <linux-kernel+bounces-163420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1078B6A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5663281914
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308E31A291;
	Tue, 30 Apr 2024 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lnMXHsyj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD382556F;
	Tue, 30 Apr 2024 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459366; cv=none; b=sO8Hr6O7RBt5uiJRBPQ0ThLVS9Ni96ppgcb0o9KzbIYcHNWpBsbVSZ19CAzPIPj4r+QMo9fELFnY3Rv9CytYUbns1FiUMvaz3DfqxVKzlJ8uQSdyq5YxZJhgt+mcm3RmH09nRAcDK7e+vALsLRbhz2IVUgtdKV++VqlI1pUg+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459366; c=relaxed/simple;
	bh=9MysDbisVLLLmWRpjBI1h5YqDXwpadmEz+fgY337vpI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElwvVQbOcaPf2HvMCXlnhrKIC8RPNMLnFkfVISFBbM86DkAFnYecpDY7rhFqxsTyPZL5as+1/kPA5rWaeuRPGog5OWVypNeAWy7WG/u8luqqO2vARYg2GXoRiRkkUoo07qyop6ASFp/WPzVN7irtM8SSbmLrXQMCA5cxsWOnqQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lnMXHsyj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U4THXm000426;
	Tue, 30 Apr 2024 06:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=mTYqvHM0p4lP1xX3WJfDTxYMxZt7GW2xHcpqr6M4Htw=; b=ln
	MXHsyjn5IhB3jA+4aaOuZdjFj9prdiu0yvD2KYM7jg53UTA3M4EJohBYJ4wXCg1k
	7KfD8EvnS45ch3PegyJ39ch5HQ00P+xp0m7xmE1yrN8PWnDUXncYNBEcbCW+s1p6
	TvjBPkP7Exj/BeDWvkDcnrPOecGJ/7IxAEYGcx557WxvNDB9E9YznRqLyfNI5X3z
	JJcEa0Js5trje3Z9uNqANC+bTy8nspfydPqW1VQ0pB4xiF5U3BO3h3NlEsiry1cM
	z1o7Jky3fAz86DpPOToMs7tx1mOqbaMZGHmAj5BczBXm2P6/sSj2+EhuexjmcHM7
	Gw+Cv90Dt3FNhGRCk5hA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtsnm8ayj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 06:42:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U6gc7t023311
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 06:42:38 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 23:42:33 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_varada@quicinc.com>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <bryan.odonoghue@linaro.org>
Subject: [PATCH v11 1/6] interconnect: icc-clk: Specify master/slave ids
Date: Tue, 30 Apr 2024 12:12:09 +0530
Message-ID: <20240430064214.2030013-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430064214.2030013-1-quic_varada@quicinc.com>
References: <20240430064214.2030013-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: 6Z780spFIPwOVf28EFtAbEHrOYD4H7S7
X-Proofpoint-ORIG-GUID: 6Z780spFIPwOVf28EFtAbEHrOYD4H7S7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_03,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300047

Presently, icc-clk driver autogenerates the master and slave ids.
However, devices with multiple nodes on the interconnect could
have other constraints and may not match with the auto generated
node ids.

Hence, modify the driver to use the master/slave ids provided by
the caller instead of auto generating.

Also, update clk-cbf-8996 accordingly.

Acked-by: Georgi Djakov <djakov@kernel.org>
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


