Return-Path: <linux-kernel+bounces-63860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C88D85359F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577C828AF4F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8585FDDE;
	Tue, 13 Feb 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J1XwzDNM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9705FB8C;
	Tue, 13 Feb 2024 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840356; cv=none; b=n0kEdv6dFWS/WW+s0z3WdsxdjpNTEglDfR06cmMKEFJadlXcd3GCy/8sR6cr5PruK/tgI5dQ15IkqjH7GSRzVRTaTaCY5B3Sy/xOHVvLW771XMMmKTe2t0i3Vl1R2+5UhU1sBmlHL1kTX2855XYsoppwsP8j3VbMzhz507RndN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840356; c=relaxed/simple;
	bh=cGhtKaLERpJfNHDA9moP6bhwmVH7oHUhM1F+dukzjgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGMU45Q+Mx/dAszH5/IgQ9bRT/masV2Lt+xzj2q/S92o8yj7VbUClaNfZv9UURScErbpcXQr+HxOR0uHzPb19bRqx/0vnuMfEHB+Lcx60j0+o6RL01VPMpbZgGCa/6CbQjPiAiaPrb/1H+L1SghGEWlfDGcUhwKw9E2VxJFwL0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J1XwzDNM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DFWHkM010617;
	Tue, 13 Feb 2024 16:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=IgFesNMKfyBjAiBFMKBA0Ar1JHfEgXq2+FouGF1j1gs=; b=J1
	XwzDNM5KJVS21o41VZMBfkP9p7ukw2Y1WWd6KEosHLzghXf6yxqJXSOu818bF63h
	vZvNxRazZLPtdKFiEN8atx7Sv+W4I8PcsHU4Gb56KmMwxa/CWYbUEPqlXfUXFmnh
	WMtoWlVg0UUPBJpxQeCCoSH746wzivNFY74EAQwYnuAsr0J1JZ49LcXWFPzjZ/L+
	iMvxPQvidGbq24mEdOzrUadvl5g/3Fuaj8sDCO2sDg6mEl42mKMansVKi6dCi/Iv
	5WBwomvHiRbzKECGrTsywjwrGIo2MRIVfKCzpNte1ZscQ4tbA5Z2+qGJ3A77bblE
	JdAQWAqLLNN1PrkTXByQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7ju7b478-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 16:05:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41DG5XV7021529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 16:05:33 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 08:05:33 -0800
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Mao
 Jinlong" <quic_jinlmao@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] dt-bindings: arm: qcom,coresight-tpdm: Rename qcom,dsb-element-size
Date: Tue, 13 Feb 2024 08:05:17 -0800
Message-ID: <20240213160521.15925-2-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213160521.15925-1-quic_jinlmao@quicinc.com>
References: <20240213160521.15925-1-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: onR72qy8Q1VlouIOQWWTCQAaNiNVnZ2j
X-Proofpoint-GUID: onR72qy8Q1VlouIOQWWTCQAaNiNVnZ2j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_08,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=831 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130126

Change qcom,dsb-element-size to qcom,dsb-element-bits as the unit is
bit.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index d0647ffaed71..62188c51ceb5 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -44,7 +44,7 @@ properties:
     minItems: 1
     maxItems: 2
 
-  qcom,dsb-element-size:
+  qcom,dsb-element-bits:
     description:
       Specifies the DSB(Discrete Single Bit) element size supported by
       the monitor. The associated aggregator will read this size before it
@@ -111,7 +111,7 @@ examples:
       compatible = "qcom,coresight-tpdm", "arm,primecell";
       reg = <0x0684c000 0x1000>;
 
-      qcom,dsb-element-size = /bits/ 8 <32>;
+      qcom,dsb-element-bits = <32>;
       qcom,dsb-msrs-num = <16>;
 
       clocks = <&aoss_qmp>;
-- 
2.41.0


