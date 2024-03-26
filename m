Return-Path: <linux-kernel+bounces-120027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0152688D077
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B9E1C3F62F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346D813DDAC;
	Tue, 26 Mar 2024 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VTeZKCCG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011913C831;
	Tue, 26 Mar 2024 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490866; cv=none; b=cdNzHVMTq0UUP+/FgZTxdEY3kP3+QhCqh4+FSRYGmxBh6a45mU6b1ERVXlEELuflp4Rw1UpR6ZEZVN8FosIHRhBx7JWyvaFbHJXPf2BOluCZ74Vre45vx1FgD27aybR0k+CMnVbW3t6+qUCYqoBFngIbq0ZvmgZY4HkXaxud100=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490866; c=relaxed/simple;
	bh=AV6oMVDR5d974Jq4Vj81sLZu2tKcU8270Mh3gis9pII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3J2DdfktBgNDK0s1pEDP5iaNGxAhR3mSELoYLoyOFU7VW4NdtA1/DjPhI/10XKFcBA8IkTE0yb2hsj3y+pcDjPZgNLkzGFaXgK7vgA4eqwaZvjwfchfC3R4ZQrvN7BMnAibUeeQJQCsnYrC0jVAgovNPKTwymt040hLSR3OOAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VTeZKCCG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QLlSqe008069;
	Tue, 26 Mar 2024 22:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=nPKrmFHEjVjIWIRapavBJJRBnrJDRvbUzzmt2b2eSzc=; b=VT
	eZKCCGi8Ys709D+DTVbr/LxteRrirARTKa2NBUycsAyZKddpgBQh9qjZh+mg/PUq
	TrSkcJq9sX/p5I+fbYr7B9SwlFcx2tuY3cP9PQuUQbnhVdmK8B6t2ie8RkIKgnXU
	GCdE2QWlnKR9jIeXA8r4FqJhISiKnFH6bQdPozeaIKHtIXMNFrCV0qZjgP62p+jz
	GvmclqCdWsKcg45e0Tv1/j2G2F5NutrhVDgpnjM9S/ccBJW/dL9H53VXJi2JlAq5
	imVjHnreJ3/ZHWSkOZY9TIuxiiB9rn+bJsyNH30DBIRIJehAD516DxDyQOgPSMja
	pd9DuyJgL8ECMS6kqsEA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x41k68sx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 22:07:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QM7eiN031001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 22:07:40 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 15:07:40 -0700
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        Krzystof Kozlowski <krzystof.kozlowski@linaro.org>
Subject: [PATCH v2 1/4] dt-bindings: pinctrl: qcom,pmic-gpio: Add PMXR2230 and PM6450 support
Date: Tue, 26 Mar 2024 15:06:27 -0700
Message-ID: <20240326220628.2392802-2-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326220628.2392802-1-quic_amelende@quicinc.com>
References: <20240326220628.2392802-1-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oBzVxnNN18EuzcZYnOMD6gHMFRzr_ocJ
X-Proofpoint-GUID: oBzVxnNN18EuzcZYnOMD6gHMFRzr_ocJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_09,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260159

From: David Collins <quic_collinsd@quicinc.com>

Update the Qualcomm Technologies, Inc. PMIC GPIO binding documentation
to include compatible strings for PMXR2230 and PM6450 PMICs.

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
Acked-by: Krzystof Kozlowski <krzystof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 3f8ad07c7cfd..2b17d244f051 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,pm6150-gpio
           - qcom,pm6150l-gpio
           - qcom,pm6350-gpio
+          - qcom,pm6450-gpio
           - qcom,pm7250b-gpio
           - qcom,pm7325-gpio
           - qcom,pm7550ba-gpio
@@ -72,6 +73,7 @@ properties:
           - qcom,pmx55-gpio
           - qcom,pmx65-gpio
           - qcom,pmx75-gpio
+          - qcom,pmxr2230-gpio
 
       - enum:
           - qcom,spmi-gpio
@@ -198,6 +200,7 @@ allOf:
           contains:
             enum:
               - qcom,pm6350-gpio
+              - qcom,pm6450-gpio
               - qcom,pm8350c-gpio
     then:
       properties:
@@ -261,6 +264,7 @@ allOf:
               - qcom,pmc8180c-gpio
               - qcom,pmp8074-gpio
               - qcom,pms405-gpio
+              - qcom,pmxr2230-gpio
     then:
       properties:
         gpio-line-names:
@@ -417,6 +421,7 @@ $defs:
                  - gpio1-gpio10 for pm6150
                  - gpio1-gpio12 for pm6150l
                  - gpio1-gpio9 for pm6350
+                 - gpio1-gpio9 for pm6450
                  - gpio1-gpio12 for pm7250b
                  - gpio1-gpio10 for pm7325
                  - gpio1-gpio8 for pm7550ba
@@ -464,6 +469,7 @@ $defs:
                                             and gpio11)
                  - gpio1-gpio16 for pmx65
                  - gpio1-gpio16 for pmx75
+                 - gpio1-gpio12 for pmxr2230
 
         items:
           pattern: "^gpio([0-9]+)$"
-- 
2.34.1


