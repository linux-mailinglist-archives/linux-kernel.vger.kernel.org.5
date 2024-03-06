Return-Path: <linux-kernel+bounces-93433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B0C872FAD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9051F26343
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD7E5D75B;
	Wed,  6 Mar 2024 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WzILONoW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA735C91C;
	Wed,  6 Mar 2024 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710266; cv=none; b=kWcyNBNWsaCm3Tf+XPNaw7+i8s5fb6tk9nAwSRAZ+K4KzWvYQfI5JJ70NzpO2jpEMe+USwbPm7AHzwGqDTvgsesx4DcXCG3JnqgttRmBa7eNvuBEFs2eY4TzQKsVyLsWiQnf/GXC2pvuhtJV3CnggocLza9VTg8X5U8dHCmbACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710266; c=relaxed/simple;
	bh=SNSEkGY4kQ3s9M8b7X9I+IIVDxto5d7ri1uoIzQCEFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXPBmuMwuVNP0qz+MS3r9tMIWFT4ahVVodtJcbXFnoy37Xz04I4PzFL3WYILvBas2hyu1+KxVBFgyCKr7KuzcOIWsyC2VR6VnPRWfHTEKwOaIw+kq04LO8SWqST2XEO9rn//6ikNVjQEObzcTyxkH9s4nr37GAHfyaXUWk1Se/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WzILONoW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42677nLi030225;
	Wed, 6 Mar 2024 07:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=6rAJW/h3885Nr/rnSGzJ
	8U/YAZnDo33NgvDYU1YLb8I=; b=WzILONoWir410R/V0jlcvGJlvfW1nCUNf4PZ
	bDaH0mCToDJB8GALIZPGQZbRl4owFbfosv6OzwgiYSDppA95VFwVvO6khCUh/lay
	WoFaRm7YWo4JCBlTrsyLcvu6Saf8BlP3rTqT94aPu6unV97xOnA9tALh/tFos3Xo
	K0Ao/DdeY661FendvPnl1xKH05EaIgXKV/8LZQE2rMXCSL8Nq7XwVgc5eLZlcvs9
	62BRyWReohHm4JMLk40NFbZKYe6m3wELlfoLvgRUwpCmB8PoZ4xsrDHtW5G0N+qW
	8TyIVaDDpVK2YH2GgZDNqaGdPGH22rKPWNLm2dsXo35FkSij1g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpktpr1pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 07:31:01 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4267V0ae003911
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 07:31:00 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Mar 2024 23:30:55 -0800
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>
Subject: [PATCH v3 4/4] arm64: dts: qcom: sc7280: Add clocks for QOS configuration
Date: Wed, 6 Mar 2024 13:00:16 +0530
Message-ID: <20240306073016.2163-5-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306073016.2163-1-quic_okukatla@quicinc.com>
References: <20240306073016.2163-1-quic_okukatla@quicinc.com>
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
X-Proofpoint-GUID: h82VgwHg5JhEsd0D82HAq4ROj_Ih23wi
X-Proofpoint-ORIG-GUID: h82VgwHg5JhEsd0D82HAq4ROj_Ih23wi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_04,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060058

Add handles for required clocks to be enabled for configuring
QoS on sc7280.

Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 7e7f0f0fb41b..e1d8fb6afae8 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2129,6 +2129,8 @@
 			reg = <0 0x016e0000 0 0x1c080>;
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				<&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
 		};
 
 		aggre2_noc: interconnect@1700000 {
@@ -2136,6 +2138,7 @@
 			compatible = "qcom,sc7280-aggre2-noc";
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&rpmhcc RPMH_IPA_CLK>;
 		};
 
 		mmss_noc: interconnect@1740000 {
-- 
2.17.1


