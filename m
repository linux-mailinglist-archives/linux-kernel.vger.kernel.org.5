Return-Path: <linux-kernel+bounces-105392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B4487DD4A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB771F211F2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE901BDE6;
	Sun, 17 Mar 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TSY4JoHa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224AE1BC3E;
	Sun, 17 Mar 2024 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710682227; cv=none; b=gemsM9FPEJOeIp4WljCmYrr0jMCGh3gYhYCq/95dEGU9v+NDo9wSNeUxqEirDFShugyPr9dt7/PC83CtWwsbN05NvpjVh/qYqTKl/W2jhXOc3GI7ttFdqH89u42TEMhnVY9YlRRNP6EzkOhPcLd9iU2q0qCecfphNCZ5bTmJAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710682227; c=relaxed/simple;
	bh=2gdq8EBgY1LmHd9w6DjX1eMIdhBWiKxla81oO9Irugs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FVUZ0tuvC5ph7PuxWvPA9JMGowWw7qDLs4On0dBu+qL+R31fUcPxfWuMUFowFjdNPzMZxEmzDsUOXC5p7QzgMv4Zb6cfGyjVsU7RYnYAJKvbd7ay1HFc5gyJxSSu7wCAu2cxBe8DnbIX6W4ueVw7sTIaCgtmE0vzROBxKTnLKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TSY4JoHa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HDQ1im023310;
	Sun, 17 Mar 2024 13:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=6bxKWY+
	uxQwNgwJMAYt+WRedxst3xgEotcSyVl8ra58=; b=TSY4JoHafJGdOgCTUJS8P/C
	qRfyZj08/uJUYY0hlhKC3eZfldPihINnzYzh0dCR0BiPaMt7ctRplC46pF70x86X
	9uWKgi3vvEtOo5jlKpdruTguWCJrUy4URhs2VIdqzjJwcn/fpaKpVMDP6xXQrNxN
	pIIOOn8alCWbV8DPOKy+FcUi5yLB8vXp3iaCP0ziqPvbVe3S8Jfy8uh7lktvYvXN
	+BR2wQW0Pj8dRpUMFFH4IJEHaAXynmU4bWXe554/TzKSMj4F5sebWpn4HEsOnvCj
	9HGNjjuQn7Vw0AYS/8uunPqUKxtpAcuJoIkbiKg+u3+x9onb7ycB2zqNGdSnr3Q=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wwxtb04u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Mar 2024 13:30:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42HDU8Pe022340
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Mar 2024 13:30:08 GMT
Received: from hu-rjendra-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 17 Mar 2024 06:30:04 -0700
From: Rajendra Nayak <quic_rjendra@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <abel.vesa@linaro.org>, <quic_sibis@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v2] arm64: dts: qcom: x1e80100: Fix the compatible for cluster idle states
Date: Sun, 17 Mar 2024 18:59:18 +0530
Message-ID: <20240317132918.1068817-1-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: s34K_ikphXzrQSQftGafd5ZdFJ9pKEHz
X-Proofpoint-ORIG-GUID: s34K_ikphXzrQSQftGafd5ZdFJ9pKEHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_09,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxlogscore=769
 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403170106

The compatible's for the cluster/domain idle states of x1e80100
are wrong, fix it.

Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v2:
Updated the subject to include 'qcom: x1e80100'

 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 8e517f76189e..6b40082bac68 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -284,7 +284,7 @@ CLUSTER_C4: cpu-sleep-0 {
 
 		domain-idle-states {
 			CLUSTER_CL4: cluster-sleep-0 {
-				compatible = "arm,idle-state";
+				compatible = "domain-idle-state";
 				idle-state-name = "l2-ret";
 				arm,psci-suspend-param = <0x01000044>;
 				entry-latency-us = <350>;
@@ -293,7 +293,7 @@ CLUSTER_CL4: cluster-sleep-0 {
 			};
 
 			CLUSTER_CL5: cluster-sleep-1 {
-				compatible = "arm,idle-state";
+				compatible = "domain-idle-state";
 				idle-state-name = "ret-pll-off";
 				arm,psci-suspend-param = <0x01000054>;
 				entry-latency-us = <2200>;
-- 
2.34.1


