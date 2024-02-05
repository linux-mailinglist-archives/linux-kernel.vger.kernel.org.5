Return-Path: <linux-kernel+bounces-52864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A926E849D90
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F2FB23463
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D512E40B;
	Mon,  5 Feb 2024 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lrzsTTbo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47672C1A7;
	Mon,  5 Feb 2024 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145067; cv=none; b=XpoEBR3hMxYtwHR/6S3lRLUTNlUKvKH9t7ofeLyHEJqjARmOTq9shQ5RbE9l1Ov1MCZvhC7w+Kggkt+u2jQQW/TRSo7Ik7oFKTEAi408Q9Z6bPPSxyiQEqOHCCOoECHxRVDtpLM7O+gOn+SEyfE26MQMawNBIA8LH+ZfKDzbOws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145067; c=relaxed/simple;
	bh=/0KvirHf/RiTCQAcY/QGGkqAslSPzV6J6MWqcYknQZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7HHG1SDoc/itCYJg+0hLVlDbDwRHgtXBIU8MYnekxx9xX4ZDDDkByHX+NQScMWx6qb6DkSCgbrncnrGnA8pwmYvEHS/E24f8HmMs/7/ukcnpXEvQiekw8ZStegrHcjUR3QH5I+C7Z/wKUc+YEljck7lJ//b8F+TIzmEgKwckTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lrzsTTbo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415Cx2gY026508;
	Mon, 5 Feb 2024 14:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=C5TlyNoGJc6f8E94iuE+
	EQNzGaBOVzIYHleZp2+QFQk=; b=lrzsTTboBrxh5tNYoUeYAODLXvwwZacoPUmD
	KE3FzypkDS1E2amv+Zsv5H+Dc5fE7SlVDORvoK6FW+PFb8fl58CKh6wkWRYcKSH3
	GJVJ8PcZPLehF+lVHE9A8JgTrAxt3CBx2zSar7vYzZATqkdPWsTygWMEH9PdKJ4r
	UEvcAPbtFzmSwlPhN9Vj6KCKDsDNG+SstE4DyTNE+ODJw0uGHRN9lI+X9wpjDWJB
	V1wKD3z2gtzzcOd2IbWYZNuFfy/aoyMYQbQAWcN1yVFCAIWdkPeIx6ivmCmjTr4I
	EFE52XFrGGPSiib6B2I3w6lkhpuSraRnhZqKznALVy0kQ2DATw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2rk71618-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 14:57:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415Evev4025894
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 14:57:40 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 06:57:36 -0800
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: <djakov@kernel.org>
CC: <rafael@kernel.org>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_okukatla@quicinc.com>, <quic_viveka@quicinc.com>,
        <peterz@infradead.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/4] arm64: dts: qcom: sc7280: Add clocks for QoS configuration
Date: Mon, 5 Feb 2024 20:26:06 +0530
Message-ID: <20240205145606.16936-5-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240205145606.16936-1-quic_okukatla@quicinc.com>
References: <20240205145606.16936-1-quic_okukatla@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZUC6vsATagv7uc5T9p1YtfcT2cLvVY86
X-Proofpoint-ORIG-GUID: ZUC6vsATagv7uc5T9p1YtfcT2cLvVY86
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_09,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=885 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050113

Add handles for the required clocks to be enabled for configuring
QoS on sc7280.

Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index c3a94c4c6490..6b50f37af508 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2099,6 +2099,8 @@
 			reg = <0 0x016e0000 0 0x1c080>;
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				<&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
 		};
 
 		aggre2_noc: interconnect@1700000 {
@@ -2106,6 +2108,7 @@
 			compatible = "qcom,sc7280-aggre2-noc";
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&rpmhcc RPMH_IPA_CLK>;
 		};
 
 		mmss_noc: interconnect@1740000 {
-- 
2.17.1


