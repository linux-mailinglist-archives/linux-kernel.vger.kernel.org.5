Return-Path: <linux-kernel+bounces-102882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE5E87B7FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D2028416F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22DB4A11;
	Thu, 14 Mar 2024 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ERxsUxZI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0CF9DB;
	Thu, 14 Mar 2024 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710398045; cv=none; b=IHaodvuUs7rdLRpBSekMtUCjohTsEGTYBpDA2N8+xa+4lVp7US50eaihBICwiparbL75PDn6Mt57XkMUvi5dEttSob2AVTfp5SHwAkv0v0GVZrudFkAlFeQClIjtiuXxt0/OnaBZLtT5VOIGeurbD9R/qncNImzcBJ8isLaKGnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710398045; c=relaxed/simple;
	bh=+bFdUJyOYKwTrYV4x6J+m/pVXk7bGoNavriufSSMezQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J59vg/lEuZgYy8mo3J0oNQACNJASr6zn5JeKRb4RXEt9lG6BRjP26hA02yaToVtPCHGWN4V9GbD+1MclYw4mq4kVIpWAkr4DPbSQUGajMcqFc9+rbEsH2K7z8sAlDaYphFruCcXmEYiGiERWBfExapbV4mzmKJREVHpc4mlv+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ERxsUxZI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E2Jg6i027942;
	Thu, 14 Mar 2024 06:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=/quYWKqEIc/h1upfh0SRmrCUaTXjybxugd1mNo8OXlI=; b=ER
	xsUxZInFk/x+iPZf6wq9+/VcXLbnKhPqlzCtui5w93RXdq1r02fQmfKYjp+Oh8QI
	fUOxBAhzF3ZXMnrl+ZkSvsJYktKmW3gCQunOwFIrpgl3OTe9yaXztAiY21mcPydc
	y/nP5g2/JGx4Ge8n+6DizoaFu7BKBBplB5evDyolm8+rRUbhbw0oSIm1NZeEQOPZ
	8SpVwVKuNTZ8GMEQK64iFjTLWC5DWw1wDM/PP4Su4Z4PMKw25MRmBareYwgh9CvL
	/dLcg16wjp69wmaeS1KA+XDD2EAbvvaBjDuKEH9+GAmKlEVAgoT9Pec0JYFzJXdz
	jnVsKwy3viScvpP/zzXQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wugq19g2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 06:33:52 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42E6Xpxu014743
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 06:33:51 GMT
Received: from hu-lxu5-sha.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Mar 2024 23:33:45 -0700
From: Ling Xu <quic_lxu5@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <quic_ekangupt@quicinc.com>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ling Xu <quic_lxu5@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: sm8650: Add three missing fastrpc-compute-cb nodes
Date: Thu, 14 Mar 2024 12:03:34 +0530
Message-ID: <20240314063334.31942-1-quic_lxu5@quicinc.com>
X-Mailer: git-send-email 2.17.1
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
X-Proofpoint-ORIG-GUID: ugi6Zx4lWUZWFDEq69sMs-6I0Tx42tYP
X-Proofpoint-GUID: ugi6Zx4lWUZWFDEq69sMs-6I0Tx42tYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_03,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=680 phishscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140042

Add three missing cDSP fastrpc compute-cb nodes for the SM8650 SoC.

Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index ba72d8f38420..c238ad1be0d4 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5084,6 +5084,35 @@
 							 <&apps_smmu 0x19c8 0x0>;
 						dma-coherent;
 					};
+
+					/* note: secure cb9 in downstream */
+
+					compute-cb@10 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <12>;
+						iommus = <&apps_smmu 0x196C 0x0000>,
+							 <&apps_smmu 0x0C0C 0x0020>,
+							 <&apps_smmu 0x19CC 0x0000>;
+						dma-coherent;
+					};
+
+					compute-cb@11 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <13>;
+						iommus = <&apps_smmu 0x196D 0x0000>,
+							 <&apps_smmu 0x0C0D 0x0020>,
+							 <&apps_smmu 0x19CD 0x0000>;
+						dma-coherent;
+					};
+
+					compute-cb@12 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <14>;
+						iommus = <&apps_smmu 0x196E 0x0000>,
+							 <&apps_smmu 0x0C0E 0x0020>,
+							 <&apps_smmu 0x19CE 0x0000>;
+						dma-coherent;
+					};
 				};
 			};
 		};
-- 
2.17.1


