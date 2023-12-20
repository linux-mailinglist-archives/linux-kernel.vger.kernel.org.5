Return-Path: <linux-kernel+bounces-7029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9389781A0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C4C1F2A48B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DEC38FA9;
	Wed, 20 Dec 2023 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h1Wvf0SD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0B38DE3;
	Wed, 20 Dec 2023 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKDkDB0020538;
	Wed, 20 Dec 2023 14:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=PjWxAAt9MknS5V+QjQfPmWfDBe9WcXbFmZWO5eGIgGE=; b=h1
	Wvf0SDYhUEltVhDp2+IFcz+rj5gEPi2UsKfiuHXtLOwznQSiz9MtJCCLTTrR6AKj
	u53KAbUrHyJ32WU4gthFiuSpsxBYFthe7phuDBzDUtJw4x2n9SS5isyWLtgSFtta
	4WsZ8T4PKzQpoGvOnbzPpy4sxoOGob05K2J+GdkHTuignaqzGqdHB6w+1PmUn+xf
	TCVtzKK+DTFUmC26Um5pBJBfW6+5x5ZZTWoR9ZE48JubG4i9faHvD9B6Z6U6Bguo
	PyfkObZnzAbJz1FDvH8tr1vid6nkQP0ABnKsSzDXJjw3u2a1oFGQCidx0bUrDqsP
	1fCcocOBk7ohgegLNClw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3fa3jdx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 14:05:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BKE5ofD003939
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 14:05:50 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Dec 2023 06:05:49 -0800
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, James Clark
	<james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Andy Gross
	<agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Mao Jinlong <quic_jinlmao@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tingwei Zhang
	<quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao
 Zhang" <quic_taozha@quicinc.com>, <coresight@lists.linaro.org>
Subject: [PATCH v1 1/2] dt-bindings: arm: coresight: Update the pattern of ete node name
Date: Wed, 20 Dec 2023 06:05:34 -0800
Message-ID: <20231220140538.13136-2-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231220140538.13136-1-quic_jinlmao@quicinc.com>
References: <20231220140538.13136-1-quic_jinlmao@quicinc.com>
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
X-Proofpoint-GUID: 0pS1-RiTlJAQ17VBDyNz-bFvyPxHvIo-
X-Proofpoint-ORIG-GUID: 0pS1-RiTlJAQ17VBDyNz-bFvyPxHvIo-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200099

Update the suffix for ete node name to be with "-".

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../bindings/arm/arm,embedded-trace-extension.yaml          | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
index f725e6940993..cbf583d34029 100644
--- a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
@@ -23,7 +23,7 @@ description: |
 
 properties:
   $nodename:
-    pattern: "^ete([0-9a-f]+)$"
+    pattern: "^ete-([0-9a-f]+)$"
   compatible:
     items:
       - const: arm,embedded-trace-extension
@@ -55,13 +55,13 @@ examples:
 
 # An ETE node without legacy CoreSight connections
   - |
-    ete0 {
+    ete-0 {
       compatible = "arm,embedded-trace-extension";
       cpu = <&cpu_0>;
     };
 # An ETE node with legacy CoreSight connections
   - |
-   ete1 {
+   ete-1 {
       compatible = "arm,embedded-trace-extension";
       cpu = <&cpu_1>;
 
-- 
2.41.0


