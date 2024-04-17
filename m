Return-Path: <linux-kernel+bounces-148356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9D68A815D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB5AB22E94
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4605113C9AA;
	Wed, 17 Apr 2024 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X2298v5j"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3613C834;
	Wed, 17 Apr 2024 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351406; cv=none; b=F+GAq8de7cJ66XzLXJFA7RyrmZNrV4rHeDWsF6Dlzj6Q99hOrICsHWCfxTaIYcqPNLERme4zyxJln8d93gmTGS3+u/C/BhskvnqmZvmV0ZWLrvEMDysMtqlUy18E0S0a3966CpZciFesPAmTizw5VxfC/nTJ8UxxVC2e5i8ebtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351406; c=relaxed/simple;
	bh=Hh2WRmXUCbCC0JLvjqOK8K3GZqooqmHdFQAIaw8+fSU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PpM32VjRoTnvxBTvHv2p6U7SHCgUDDSEpOfoLqmWsJV1rRhRg3iJdaFaBNt/zifmE2AnF3n/5iwBLMVY/RUd5aab7WyJ6Qg82MJ9LTefyn4TDJnuQKzXuQSN0ep+eEDZ374pvdE/KNUcvM8JvcbcN46m6Q6VUbySRQlXKV+lcbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X2298v5j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H9xsIp013305;
	Wed, 17 Apr 2024 10:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=xUqZIjXeNjj1yhvQVdxFGG07Lg5WpKVraOGBSU68gxw=; b=X2
	298v5jYk5pQPiiCCAfurISwEmZQpCNwu7tdFYEePypdsNZtGrHhHt/cULw5UR4O3
	u4gTAJI3pyPgksUl290Pf3WN/jxpsY80JgnppsWpO+J83mavEW5ZzjL+NP8QDe1h
	9CUJ5sJ6QSZpFeNRMiEW5WQGGLsZj5pk/5bqbrd1Iqb/NiW/GBLhkE1rbzPI4lTp
	XtORxRKF3jOH7XLOIP3u34/ooPlMhWuLlBhk1kblTanVWfs1RlihgQDnioDPAjss
	27BLdua+NdeX7lamG/lad4T7tBqQPP0l74t9GxHLifdyTzq3Phg6CgijQYKTuDwC
	vrU42MESATWzzP8jMA4Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjbt5r6cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:56:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HAuesn008934
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:56:40 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 03:56:35 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <quic_varada@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v8 1/7] interconnect: icc-clk: Allow user to specify master/slave ids
Date: Wed, 17 Apr 2024 16:25:59 +0530
Message-ID: <20240417105605.836705-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417105605.836705-1-quic_varada@quicinc.com>
References: <20240417105605.836705-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: a0qUGwzWlpGE7OpErKYQ6mRfOrjEA08b
X-Proofpoint-GUID: a0qUGwzWlpGE7OpErKYQ6mRfOrjEA08b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=975 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170075

Presently, icc-clk driver autogenerates the master and slave ids.
However, devices with multiple nodes on the interconnect could
have other constraints and may not match with the auto generated
node ids. Hence, allow the driver to provide the preferred master
and slave ids.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v8: Per review feedback, set master/slave ids explicitly. Dont autogenerate 
    https://lore.kernel.org/linux-arm-msm/f1b0d280-6986-4055-a611-2caceb15867d@linaro.org/
---
 drivers/interconnect/icc-clk.c   | 6 +++---
 include/linux/interconnect-clk.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

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


