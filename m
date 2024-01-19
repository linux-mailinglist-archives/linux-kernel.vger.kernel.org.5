Return-Path: <linux-kernel+bounces-30734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F01718323B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CC51F21712
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0EF6AA0;
	Fri, 19 Jan 2024 03:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jKXLW2Ll"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1C92030D;
	Fri, 19 Jan 2024 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705634670; cv=none; b=ETBWJLCc073PnU7ZMIn5ZiOozP06qAgl5sWjdiFqiWKH6utRL0U56UR/TgS6o5OuDW1+iTxOZ/Jb8cKJlJ+gw/B9678u6oi6cfkkLq0464TQqdL6S3BMKLx9IX77d9rv9X+vIBcxEVspU6UyK8UiK9bZkwTGingYCF7gqEjfiDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705634670; c=relaxed/simple;
	bh=s63tdmu4J/JXIvq8qByAPmtqRZBeyyUc8B5oOgieb5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpWNFDeqROZhr4zpUIxnLflh0761I1spvZCbGXTOEluBZHNVo8qIRiuP4lFi6+Z56gtlT/WV1DOiwEwOiNO6rn1Uirkn5szFywNpoveLoIsW77DycIvvztXcnf+8BMExs4LwoO1bRPDPdTL02du2rj5w5uY51lirU6twMYDOTQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jKXLW2Ll; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J30EfB006742;
	Fri, 19 Jan 2024 03:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=P0gG66sprIDUxIHAkWp8
	TDRiT7WDt4eNfv3vdPoMxAg=; b=jKXLW2LlG/hcIhJm9wgPaHB1my5aiNTbcWYH
	kPz3kbKNjgZxpAKncS6z+zlRb6hEJymHEEyBpux7eyo+dDD1r+vZdUj6Tv/St5Tu
	sBtEMV2oFIxU5yt3uxOAgvRl90SCYyxuYV1HFAc05tsjQsuoBbYdnDm1dh7PocDb
	dqESCmxxfB8xVKlIN2YkY/hxcrx/hWefHpvPli9N8XvaCuRQL/P/u5TsxwdEdg3o
	nMmG5wCuYbbFxvlSIEONCA9RloMDbRi/9NriOAwJcSnG0evUus2fVgN74qQJIvGC
	OqhBPAsK4uN0uMkHNqB0H6541QbngVzbIz4/9QIP4wG7RnzIZw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vq2d0j6up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 03:24:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40J3OC3p006182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 03:24:12 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 19:24:07 -0800
From: Tao Zhang <quic_taozha@quicinc.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao
	<quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>
Subject: [PATCH v4 09/10] dt-bindings: arm: Add support for TPDM CMB MSR register
Date: Fri, 19 Jan 2024 11:23:02 +0800
Message-ID: <1705634583-17631-10-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1705634583-17631-1-git-send-email-quic_taozha@quicinc.com>
References: <1705634583-17631-1-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: mcfwN9AHF44AN4LWPeuyOdAJIwQHo5b2
X-Proofpoint-GUID: mcfwN9AHF44AN4LWPeuyOdAJIwQHo5b2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190012

Add property "qcom,cmb_msr_num" to support CMB MSR(mux select register)
for TPDM. It specifies the number of CMB MSR registers supported by
the TDPM.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 507a5f887097..75190318b253 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -70,6 +70,15 @@ properties:
     minimum: 0
     maximum: 32
 
+  qcom,cmb-msrs-num:
+    description:
+      Specifies the number of CMB MSR(mux select register) registers supported
+      by the monitor. If this property is not configured or set to 0, it means
+      this TPDM doesn't support CMB MSR.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 32
+
   clocks:
     maxItems: 1
 
@@ -124,6 +133,7 @@ examples:
       reg = <0x06c29000 0x1000>;
 
       qcom,cmb-element-size = /bits/ 8 <64>;
+      qcom,cmb-msrs-num = <32>;
 
       clocks = <&aoss_qmp>;
       clock-names = "apb_pclk";
-- 
2.17.1


