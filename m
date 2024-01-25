Return-Path: <linux-kernel+bounces-38381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7894583BE92
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F171F25D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D721CD06;
	Thu, 25 Jan 2024 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rlk8AMs0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5851CAA9;
	Thu, 25 Jan 2024 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178292; cv=none; b=ty+zYb55aPuEnKwJ1ZUmJ8hjNlgbVb4CDdbleBpWQvWb/J3AA7daZzkoZnYB5pmuoQ0e0vlzQNBe+qjdplCmwey8/pFGjuKrr2SGJ74imiPsbix7TOzuBgTAY7EOF4kTba+fZKXB0ohNpl+JFpwI5zDqm57vPettmpjMfiUeRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178292; c=relaxed/simple;
	bh=EQYKVbCfAKjEcLxMC4KcgiscmJxMMEpgyHNS+OwBYow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUz0nod56K7xKBewcV15fvM1HF3hq35YgLkKvBC/oPS/CiZlsJmphKjbHeqr/gowiaOR8A5dABEyWAA3jF+bv9pnvzn2YkDrDbLcBZILRQCHDTHmZtfjD78ICMqkbNdbfo38yS0jMj3KGb3dfAMtz9NMBxEIxrEJFl5qmm0zQTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rlk8AMs0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P9e1t7031621;
	Thu, 25 Jan 2024 10:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=IlXvLSCPH9usGxn0nlVV
	ugA8AZPCWCa5ZUPbcAOiXmE=; b=Rlk8AMs0338ySXye8tWuhWJ5V+yOadrdU4Ai
	6ouCERo7bsWz1ee7LY1rIjU8dmQEnvH+OjlILPqpUjdgJ1PxgNIy6GiIcl6QTKGs
	QgaKI0sadFiOewLjkrxb3B9zrCpwsEkL+TWWna2hZeo9MF4bYGPMtitK4bJWw9XC
	GfENw8qdNdM8xR3n6PileCOLVFVYTjPNJqC04Y6ORhomlbAsmCbTbPa6p4qFwccn
	N7A/9K/qPH5dYeYB+PwjZx6bDjUxyjOu0UVJJS58o3Fm3s3+0ym9opDCuuUWtb+W
	OWg3BW6SaEHkXe0etHz4ftIyKOlnqv8Q56cd3NycAvm2r+I/Mg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vun6w034q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 10:24:46 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PAOj3r018012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 10:24:45 GMT
Received: from hu-lxu5-sha.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jan 2024 02:24:40 -0800
From: Ling Xu <quic_lxu5@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <quic_kuiw@quicinc.com>, <quic_ekangupt@quicinc.com>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ling Xu
	<quic_lxu5@quicinc.com>
Subject: [PATCH 1/2] arm64: dts: qcom: sm8550: Add dma-coherent property
Date: Thu, 25 Jan 2024 15:54:12 +0530
Message-ID: <20240125102413.3016-2-quic_lxu5@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240125102413.3016-1-quic_lxu5@quicinc.com>
References: <20240125102413.3016-1-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Eru6F7nlH0YDwN_veSfZ2KckBY6anF7v
X-Proofpoint-ORIG-GUID: Eru6F7nlH0YDwN_veSfZ2KckBY6anF7v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_05,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=662
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250070

Add dma-coherent property to fastRPC context bank nodes to pass dma
sequence test in fastrpc sanity test, ensure that data integrity is
maintained during DMA operations.

Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index ee1ba5a8c8fc..00bb803940fc 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -4254,6 +4254,7 @@
 						reg = <3>;
 						iommus = <&apps_smmu 0x1003 0x80>,
 							 <&apps_smmu 0x1063 0x0>;
+						dma-coherent;
 					};
 
 					compute-cb@4 {
@@ -4261,6 +4262,7 @@
 						reg = <4>;
 						iommus = <&apps_smmu 0x1004 0x80>,
 							 <&apps_smmu 0x1064 0x0>;
+						dma-coherent;
 					};
 
 					compute-cb@5 {
@@ -4268,6 +4270,7 @@
 						reg = <5>;
 						iommus = <&apps_smmu 0x1005 0x80>,
 							 <&apps_smmu 0x1065 0x0>;
+						dma-coherent;
 					};
 
 					compute-cb@6 {
@@ -4275,6 +4278,7 @@
 						reg = <6>;
 						iommus = <&apps_smmu 0x1006 0x80>,
 							 <&apps_smmu 0x1066 0x0>;
+						dma-coherent;
 					};
 
 					compute-cb@7 {
@@ -4282,6 +4286,7 @@
 						reg = <7>;
 						iommus = <&apps_smmu 0x1007 0x80>,
 							 <&apps_smmu 0x1067 0x0>;
+						dma-coherent;
 					};
 				};
 
@@ -4388,6 +4393,7 @@
 						iommus = <&apps_smmu 0x1961 0x0>,
 							 <&apps_smmu 0x0c01 0x20>,
 							 <&apps_smmu 0x19c1 0x10>;
+						dma-coherent;
 					};
 
 					compute-cb@2 {
@@ -4396,6 +4402,7 @@
 						iommus = <&apps_smmu 0x1962 0x0>,
 							 <&apps_smmu 0x0c02 0x20>,
 							 <&apps_smmu 0x19c2 0x10>;
+						dma-coherent;
 					};
 
 					compute-cb@3 {
@@ -4404,6 +4411,7 @@
 						iommus = <&apps_smmu 0x1963 0x0>,
 							 <&apps_smmu 0x0c03 0x20>,
 							 <&apps_smmu 0x19c3 0x10>;
+						dma-coherent;
 					};
 
 					compute-cb@4 {
@@ -4412,6 +4420,7 @@
 						iommus = <&apps_smmu 0x1964 0x0>,
 							 <&apps_smmu 0x0c04 0x20>,
 							 <&apps_smmu 0x19c4 0x10>;
+						dma-coherent;
 					};
 
 					compute-cb@5 {
@@ -4420,6 +4429,7 @@
 						iommus = <&apps_smmu 0x1965 0x0>,
 							 <&apps_smmu 0x0c05 0x20>,
 							 <&apps_smmu 0x19c5 0x10>;
+						dma-coherent;
 					};
 
 					compute-cb@6 {
@@ -4428,6 +4438,7 @@
 						iommus = <&apps_smmu 0x1966 0x0>,
 							 <&apps_smmu 0x0c06 0x20>,
 							 <&apps_smmu 0x19c6 0x10>;
+						dma-coherent;
 					};
 
 					compute-cb@7 {
@@ -4436,6 +4447,7 @@
 						iommus = <&apps_smmu 0x1967 0x0>,
 							 <&apps_smmu 0x0c07 0x20>,
 							 <&apps_smmu 0x19c7 0x10>;
+						dma-coherent;
 					};
 
 					compute-cb@8 {
@@ -4444,6 +4456,7 @@
 						iommus = <&apps_smmu 0x1968 0x0>,
 							 <&apps_smmu 0x0c08 0x20>,
 							 <&apps_smmu 0x19c8 0x10>;
+						dma-coherent;
 					};
 
 					/* note: secure cb9 in downstream */
-- 
2.17.1


