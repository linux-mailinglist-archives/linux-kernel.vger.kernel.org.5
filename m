Return-Path: <linux-kernel+bounces-51447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C90F4848B54
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732501F23F81
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB57D63AC;
	Sun,  4 Feb 2024 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dtt+WP3H"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299312E71;
	Sun,  4 Feb 2024 05:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707024743; cv=none; b=r9gVotBduHy8EUiwvgH5gNsp/YE04IinVfTRBFo41aLfCwjiOtIzwAVUWZ39QKj+JJk6pIFNmdrfiEC9fWj8aNjeUwH78jBDL3GKV7rtAJnJKEwcqQvISpdbWJwJpfJxros23TgqOHMGK86lBQsgFLy4kf/zkKw/YrVy49gq7yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707024743; c=relaxed/simple;
	bh=iecTvx9v5QqH2K0o5UQVVOjjfRd5PbwLqfWdQNMwVJ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c9CMivrCbEamDeBBlB6R+Ix2E7W/VYspToLZMb8aCROdoXQiezz2/xBP0eiFfSTi+rHC3K3BmvNcewQhP+FaiK+jWR+cleF9156jV50AYlxMPW/xTyRyEFB329rWFHWXzVYrn4VdAFGULDyBh4c3NmSfD0CTs4N6TfJ+3e4NFvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dtt+WP3H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4145VlBC021718;
	Sun, 4 Feb 2024 05:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=FBRGBFPiQXAekeCT5kxH
	bQX6SkwEE/Luu8hARdqAzIY=; b=dtt+WP3H5OE6vzXtdy8gmoWvbQ+wUD6AcQic
	hLAZhD7s74L2eigAFpQPMmJ4aUoMVto24thauXr96/4S/Awsf0w6xfZGAfnQ8aj0
	BrfZzXMCO6GCW6nERF47HuvfnK7GeJXrpX6OMKwZUJIYVRJn4puZlrbU1NUsbeBj
	KHBmyyXdjoCAE4WUwylQC8DSTUsPmx9cQgv3TfGHsE9ajtWX1m2LGTD3cQvbU4iO
	bbjz8TERtm+FwWh+uqK4dI/99ORLlY5/Mwsxgd27dX+4FmY5J6aDP0aASXqWi7uP
	7WcibZxUzgImX3KJVwlObWFRIaPxp7VtLl+OswgIpiB2Vp3sWA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w1f40sakd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Feb 2024 05:31:58 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4145VvhY024848
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 4 Feb 2024 05:31:57 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 21:31:52 -0800
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
Subject: [PATCH v7 09/10] dt-bindings: arm: qcom,coresight-tpdm: Add support for TPDM CMB MSR register
Date: Sun, 4 Feb 2024 13:30:40 +0800
Message-ID: <1707024641-22460-10-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: W2sSG-s1TN8in8U46lCS5aDHeCe3WYyc
X-Proofpoint-GUID: W2sSG-s1TN8in8U46lCS5aDHeCe3WYyc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-04_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402040039

Add property "qcom,cmb_msr_num" to support CMB MSR(mux select register)
for TPDM. It specifies the number of CMB MSR registers supported by
the TDPM.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 2320b5445900..d0647ffaed71 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -69,6 +69,15 @@ properties:
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
 
@@ -123,6 +132,7 @@ examples:
       reg = <0x06c29000 0x1000>;
 
       qcom,cmb-element-bits = <64>;
+      qcom,cmb-msrs-num = <32>;
 
       clocks = <&aoss_qmp>;
       clock-names = "apb_pclk";
-- 
2.17.1


