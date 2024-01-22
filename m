Return-Path: <linux-kernel+bounces-33162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E431B836571
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BA41F22C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ECB3DB84;
	Mon, 22 Jan 2024 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CCosHldH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885483D98B;
	Mon, 22 Jan 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933884; cv=none; b=nhd/Bro1Rsf8bq7qS6kHLx7BUwkoFnZKtq+SwNgFOZHhuKn2qJUlsJyZxkMv7FrzwlH/49IQyVxb7rvc5DBJq0Oo9VME/8Gt0eorVtAl+gADeKpoZk/TGDyf52u4p2ZIcaPN7maGif+MOobf2SeJZCl1b5bUrViHF0dOJ6ppheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933884; c=relaxed/simple;
	bh=7MCuJ3UfHRqMd+JUh7AKlEUIeNyOfhgog0Os6Bc9bOM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Or/mn3E1gfwf4szAAc5gIZnqaZWIlApLuOLMIKsZLQVf6A4+XU2zmiz2yaArbHx0tu1EwWs7HGlVaq7EdlPqywRdrPiAcQG7hTYMZZRLNk0b4GS19jxHloIfsJKZ0ZMncUg33uNrGGT71YQ2YOYcSBTgRkGRf9THkt2HGX3Lyug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CCosHldH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MDMWJZ014355;
	Mon, 22 Jan 2024 14:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=JvI6Fhi5xpbjzdZllOYN
	MowS8mtoLNuEfuwLjBBQ6fo=; b=CCosHldHabNtl2sI9jcPdbEfa9SfaGVG6uu5
	Q3Of12N1kWgUxXpi8b8ZYXPan5+wvmf3oYZ5W6wGBWPzzLRMn5XfEV7Dv5983zAb
	1qaxE9KF3nyGS7/33nGjGierqpKe39uvuxT383JcBSoP3bPElQI1vsZzYQOSNgdr
	O8ph4iCzC2Vo/n8BlF999rK7rGz6N6EAbeLGHOxq50dvaTr3PaqJvW6nrVyw+oQx
	nd/lX7NzaUrh9SH0qx++8D/iGiLtfCycaxz9vEB9VkbymP+p1YWL5op3C9flKMoq
	By4TisC4aVXVFS8MWJ7HuY/2JaIqJKYCmfHZl5MbBWUIhZR55g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vsq7w0jun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 14:31:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MEVJrn013348
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 14:31:19 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 06:31:16 -0800
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: <georgi.djakov@linaro.org>, <cros-qcom-dts-watchers@chromium.org>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [4/4] arm64: dts: qcom: sc7280: Add clocks for QOS configuration
Date: Mon, 22 Jan 2024 20:00:30 +0530
Message-ID: <20240122143030.11904-5-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240122143030.11904-1-quic_okukatla@quicinc.com>
References: <20240122143030.11904-1-quic_okukatla@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y-eXGHC-1czn3ZTHsLkwoEe6KAXtwmSP
X-Proofpoint-ORIG-GUID: Y-eXGHC-1czn3ZTHsLkwoEe6KAXtwmSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_05,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 mlxlogscore=677 phishscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401220098

Add clock handles for required clocks to be enabled for
configuring QoS on sc7280.

Change-Id: I58991300ff1d8d2865763d4e79ee81c03586249e
Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 83b5b76ba179..73acf1bd0f97 100644
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


