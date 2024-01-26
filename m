Return-Path: <linux-kernel+bounces-40587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CEF83E2D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198B21F25498
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AD6225DE;
	Fri, 26 Jan 2024 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZKTyhTiC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA79222EFD;
	Fri, 26 Jan 2024 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298460; cv=none; b=UxKDdXo6Ls0IXHZmFBBMGhSb8SKe/15auSoKGFP1tljQ3Gf/6L2jJhcrokh0flcYpNyKvXZyOMn1PvpHS3kl9ImQhjUjOhJSZFXQnQj+4j26nVkAhOz3xgzhktWjcaw5peFHMVU26F1eOpUACHBammlKL/6IgCLzRnc9IA2vb/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298460; c=relaxed/simple;
	bh=9Xn9HY2ZMUXFU2z8kP3lVZnvT0TyWycwArAs9PhAWuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLjD+XbhEU0eVIZAfJFZJAIwp4Ja/mLnSfO7xHEYhY5CN0QANfZx3s42ER/UyE6rBpWQJweqAttL4EDq6MSKeNUXxG6tF7EQ3OGSUPXdXiQ0LmVJMrerKSlI/nyRu0D2GJ1adK9i71UkKXGCUFNlojel9RIylu0du+OBDBPxD4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZKTyhTiC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QGUYSG015679;
	Fri, 26 Jan 2024 19:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=tfk2oZMBY1QjYgBmALjMym7en0dKS68Xzwz2ZK1Y7io=; b=ZK
	TyhTiCyYg1jRplLnWJMDPscgboJiF3vzoc3K1qn24iS9mmsVNSumk9vqY9lRZARl
	GVmeVw2w8Yp6F4JDed8zRqqMrMUZJO+MhgxmOGoT+TvBD9miHOemb52Wiy74I90j
	A/J/QBcElR4ZRCpjL7wDtMYsdPmpA304Ktha+j/UWMR9w7p53GU9QNvi+DM9Xnh+
	JrISSIyhYzUC8f2tzSnre3MqBcShRL+ZT69dP9XHtJ6qcYMyzZA0jUdN+Y/Y9h+V
	KJ6mTB4knTwjxp+yF715klLpX6yU3Tgim/OxUHgBoRAbkFXqx5NcOCJg8rlws16y
	4773cYX6qw6e2/bFxLsw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv8e89ff5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 19:47:34 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QJlY1x015770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 19:47:34 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 11:47:31 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
Subject: [PATCH 2/5] arm64: dts: qcom: sm8450: Add mapping to llcc Broadcast_AND region
Date: Fri, 26 Jan 2024 11:47:18 -0800
Message-ID: <7ed5cc5930b5cc81b9fa391eb92a12f7336e595b.1706296015.git.quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1706296015.git.quic_uchalich@quicinc.com>
References: <cover.1706296015.git.quic_uchalich@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LwRdI-VMXYBRfm-jqLxhtFS5ph6zU5zr
X-Proofpoint-ORIG-GUID: LwRdI-VMXYBRfm-jqLxhtFS5ph6zU5zr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=504
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260146

Mapping Broadcast_AND region for LLCC in SM8450.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 01e4dfc4babd..d2d6fae55e2a 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -4306,9 +4306,10 @@ system-cache-controller@19200000 {
 			compatible = "qcom,sm8450-llcc";
 			reg = <0 0x19200000 0 0x80000>, <0 0x19600000 0 0x80000>,
 			      <0 0x19300000 0 0x80000>, <0 0x19700000 0 0x80000>,
-			      <0 0x19a00000 0 0x80000>;
+			      <0 0x19a00000 0 0x80000>, <0 0x19c00000 0 0x80000>;
 			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
-				    "llcc3_base", "llcc_broadcast_base";
+				    "llcc3_base", "llcc_broadcast_base",
+				    "llcc_broadcast_and_base";
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1


