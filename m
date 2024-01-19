Return-Path: <linux-kernel+bounces-30728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C398323A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46D61F237B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D66C15D;
	Fri, 19 Jan 2024 03:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D2M4ElFH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE08F6C;
	Fri, 19 Jan 2024 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705634636; cv=none; b=dqAm5QIVIYBLOLvusQ1Tnr6mjGhhFMB++gYH5g765NXUtnWdIqooIcx4AB+pdzc/ODMRSVSPY5KRiM/9Ig2nBC1WsWr2j90Xiyg4l+PcBJmb4/TZMHJfZKMsXI4d09+gwbgEvZeN/ATKg6y2JvyfGBFZm6de1he3geOt0D60hig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705634636; c=relaxed/simple;
	bh=FMwKrBZj7dLL39NjiQoQ6XngfNszI/oMysIVMBdZXmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihVoCuSnPUl9mjGCrMUILtihVqkmawcDQbr17XgR+7MbYPTYUdCgQOge4elNJRgLaVkYlKAWpT33qXHpewd304FgRT4J+R27pig2aUB25EUtNCtoBNjINUWfgwR1ghnd5vAoTGo+QkN5DDc+cM/UKa/JP5aYM5oDkTmgfGsNt/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D2M4ElFH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J240Sw019778;
	Fri, 19 Jan 2024 03:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=Av+gBHAVBCYtkxPSapeW
	T7g1scyLontBw8QInJ94V0I=; b=D2M4ElFHgNibmSHKe0y2TqdvXJOVk4qXKJNl
	SptcMs1XfcJ6Zfj49oDZTkSY2DB7al1kv2PBXXMNYlf6I1XVaqKGdsKeOaixj3Zt
	sOyUcZXV/OczwAHu5N++bm8lc6eZUsQQ40OCtAp5fQOYNFEtWFeiWMb/TuNvcJ+f
	//02kDyl3NQZHuHpmhJzFPMEoRUCVR1D2e17YEY8tTOszt/P7HQ+2j4ogFo6J30B
	qdXLwfw4SFB5cnaAgYlm2quy4jUKSFItUgCOFWC8tcUp+ONLyBdvOc+M/lZV5Ykd
	K8DjbzrVR583+Ze6U6IvPaQRcCwUpi2QPhlbkgTCBbSMCAlDzA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vq266272f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 03:23:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40J3NfNB002998
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 03:23:42 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 19:23:37 -0800
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
Subject: [PATCH v4 03/10] dt-bindings: arm: Add support for CMB element size
Date: Fri, 19 Jan 2024 11:22:56 +0800
Message-ID: <1705634583-17631-4-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: fKGYwNfrOXzNqJMIPq_sx-sBEGwR6bfu
X-Proofpoint-GUID: fKGYwNfrOXzNqJMIPq_sx-sBEGwR6bfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=917
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190012

Add property "qcom,cmb-elem-size" to support CMB(Continuous
Multi-Bit) element for TPDM. The associated aggregator will read
this size before it is enabled. CMB element size currently only
supports 32-bit and 64-bit.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../bindings/arm/qcom,coresight-tpdm.yaml     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 61ddc3b5b247..507a5f887097 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -52,6 +52,15 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint8
     enum: [32, 64]
 
+  qcom,cmb-element-size:
+    description:
+      Specifies the CMB(Continuous Multi-Bit) element size supported by
+      the monitor. The associated aggregator will read this size before it
+      is enabled. CMB element size currently only supports 8-bit, 32-bit
+      and 64-bit.
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [8, 32, 64]
+
   qcom,dsb-msrs-num:
     description:
       Specifies the number of DSB(Discrete Single Bit) MSR(mux select register)
@@ -110,4 +119,22 @@ examples:
       };
     };
 
+    tpdm@6c29000 {
+      compatible = "qcom,coresight-tpdm", "arm,primecell";
+      reg = <0x06c29000 0x1000>;
+
+      qcom,cmb-element-size = /bits/ 8 <64>;
+
+      clocks = <&aoss_qmp>;
+      clock-names = "apb_pclk";
+
+      out-ports {
+        port {
+          tpdm_ipcc_out_funnel_center: endpoint {
+            remote-endpoint =
+              <&funnel_center_in_tpdm_ipcc>;
+          };
+        };
+      };
+    };
 ...
-- 
2.17.1


