Return-Path: <linux-kernel+bounces-51440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C37EB848B3F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360891F239AA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB95C139;
	Sun,  4 Feb 2024 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d+mGmkFy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F729BE5D;
	Sun,  4 Feb 2024 05:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707024701; cv=none; b=rhOs1o376nbJsgshmKBJw9vyXtRG+2J4/KjcwPREUTmIkFYyYXoLbkoOrcVzdaIna3gUMCSc/j/Ax2bjD+ijrxMCHRxft1O9KYYMT5D1FKvaAshH1rCn3+S5EaK/YQC4TjxcSllxoYA9HwUt17JX68o7Z8gA+V1QPEYaPoW2nfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707024701; c=relaxed/simple;
	bh=M+aWPuLCB+CFfRhAbs9PuOpoT5UnSdPTM1qXrm+Q10Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhmrMzNDED4n1ttWPu5lnR27t2YUciltuYt+xRvsQbNu8ehvR4f1m5O6VMOTK6prz/KJjq2JRRTEGRbUsCkqcdUckOqG2wWCJX9reWojDE04f7b0ro4zUfjw3bFoZ0c+E1M1h7lPD2R4MUH3DYjxkKMDc1TMsWnhe0+GVgpm0fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d+mGmkFy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4145VSCb024502;
	Sun, 4 Feb 2024 05:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=0Smu9OPbuIZJeQjZ3sBY
	nzjPuVxq+g/6HsHgM4EhnTk=; b=d+mGmkFyEonOXX2lG8Nq7lHM8/tFXL6W2lJb
	miZFHSHt7REOzHfxWnXP4kUvBI8LoVlP7oDQc+4bPS467Bk8fgMGXlPaII2vQsnH
	aLubUWItLmJOVNvvBxrxlmPwFS1Oh0pPMOfD6z2jkvcHdDTw/6Emw/qGHIudlGZS
	8ZV0i0Tq9ujyiPc6Bzc9mLFCZiNrD4cOW8n/jQR/Oof74TfdGPl+t1dQif0s8sAa
	P+cxZ4q3rNPevSdq9vY/yQAIp9I2a4L6PAhcABuM6RbYlhkQTxChbeNkjDmVN9zY
	1XgwxuTJ76KhS6LETUREO2+dRajRMn127EKaT6VdzZVj9R4JVQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w1eyahb88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Feb 2024 05:31:28 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4145VRgu004248
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 4 Feb 2024 05:31:27 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 21:31:22 -0800
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
Subject: [PATCH v7 03/10] dt-bindings: arm: qcom,coresight-tpdm: Add support for CMB element size
Date: Sun, 4 Feb 2024 13:30:34 +0800
Message-ID: <1707024641-22460-4-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1707024641-22460-1-git-send-email-quic_taozha@quicinc.com>
References: <1707024641-22460-1-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-GUID: u4ZMN6h1OSSdm0QZjvk9p1Dq39MIy6nX
X-Proofpoint-ORIG-GUID: u4ZMN6h1OSSdm0QZjvk9p1Dq39MIy6nX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-04_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=930 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402040039

Add property "qcom,cmb-elem-bits" to support CMB(Continuous
Multi-Bit) element for TPDM. The associated aggregator will read
this size before it is enabled. CMB element size currently only
supports 8-bit, 32-bit and 64-bit. Because the existing example
tpdm "tpdm@684c000" which only supports dsb sub-unit, I introduce
a new example "tpdm@6c29000" to describe the usage of this new
property.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../bindings/arm/qcom,coresight-tpdm.yaml     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 61ddc3b5b247..2320b5445900 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -52,6 +52,14 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint8
     enum: [32, 64]
 
+  qcom,cmb-element-bits:
+    description:
+      Specifies the CMB(Continuous Multi-Bit) element size supported by
+      the monitor. The associated aggregator will read this size before it
+      is enabled. CMB element size currently only supports 8-bit, 32-bit
+      and 64-bit.
+    enum: [8, 32, 64]
+
   qcom,dsb-msrs-num:
     description:
       Specifies the number of DSB(Discrete Single Bit) MSR(mux select register)
@@ -110,4 +118,21 @@ examples:
       };
     };
 
+    tpdm@6c29000 {
+      compatible = "qcom,coresight-tpdm", "arm,primecell";
+      reg = <0x06c29000 0x1000>;
+
+      qcom,cmb-element-bits = <64>;
+
+      clocks = <&aoss_qmp>;
+      clock-names = "apb_pclk";
+
+      out-ports {
+        port {
+          tpdm_ipcc_out_funnel_center: endpoint {
+            remote-endpoint = <&funnel_center_in_tpdm_ipcc>;
+          };
+        };
+      };
+    };
 ...
-- 
2.17.1


