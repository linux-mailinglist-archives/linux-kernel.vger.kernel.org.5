Return-Path: <linux-kernel+bounces-103751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F46087C3F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A8A1C22624
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D9C76052;
	Thu, 14 Mar 2024 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IocsMgx2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD5A7603D;
	Thu, 14 Mar 2024 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446731; cv=none; b=TY3hVFmAYfmqVu1FJSL1P9+zi2CLjysg/+MjmnPWNb9vpEsqVCyxA/Je9+7GNR6LTkf4hYlqYXV09jGM0MHsRMo9qETVPS3JNhUoySaoEpJY7JkqLWfa4bRxg4VQGqY77uLKM/MPHi+Ybh4YINe45tEj9z50SovpNeOx72hHjfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446731; c=relaxed/simple;
	bh=En9iGV+pw0aIJO8sYBZaHn3HOpe1eC+humoEy13FBh4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtKh6HfHfUqg1UL/x/XczjSBz11yvytza/bAEpQmsBV5G3k+wwTEFWExGXlo/tFO7zg7WT3i5pq1B3ujRvh7/rovHLgdwgX6Aq8y+pu+yE7MstQRRNUkUBxXb7sHEUKTiqGCeNvarWNgB+LKvYpuOVfd0yESaprKKuUeS5KQ03c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IocsMgx2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EGwXXw027453;
	Thu, 14 Mar 2024 20:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=dFVFlDLWRnqaXhjPZI5aeZNhcqmU6SRebTLJp10PFps=; b=Io
	csMgx2gkGkqPXK15ZfdhTLzId59D+5Y1/98Tdh8G7yPChJ1PzNRMkuFzFyKVv6jp
	K1/PlZG3/PsWmUM6xAH3ZmVzAl8JW2Lu+bVtyZnq2n+RjWXK74tKsyWpynw8q56Y
	wjSZ/uxMUfKQIE9ZfVPtVC7Xi5nMeB/TWYJCbzQpSYNKz/jNl3mlzy7T5gNxl2kl
	dHdCSXssxvI+KlW3mehs65yTGzgZCDvesb3YQMUvXfrVT1B0Tk70+Wu/ItxS/DX+
	BpkEV3fWSb6NefGRGkaefAW5GZ48iepG3Qs1ukC5T8PwW0c6y/uGN7Y/yDFy321W
	8vwV9kHjJV7GYH5zShFA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuwtm9fgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:05:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EK5QTj009516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:05:26 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 13:05:25 -0700
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH 2/5] dt-bindings: pinctrl: qcom,pmic-gpio: Add PMIH010x and PMD802x binding
Date: Thu, 14 Mar 2024 13:04:19 -0700
Message-ID: <20240314200419.4733-6-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240314200419.4733-2-quic_amelende@quicinc.com>
References: <20240314200419.4733-2-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YvoHXPxpeA9Y9Z7UlMr16HXyY8-ymC3e
X-Proofpoint-GUID: YvoHXPxpeA9Y9Z7UlMr16HXyY8-ymC3e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=856 clxscore=1015 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140155

Update the Qualcomm Technologies, Inc. PMIC GPIO binding documentation
to include compatible strings for PMIH010x and PMD802x PMICs.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 .../bindings/pinctrl/qcom,pmic-gpio.yaml      | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 2b17d244f051..5cc04c016b25 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -57,10 +57,12 @@ properties:
           - qcom,pma8084-gpio
           - qcom,pmc8180-gpio
           - qcom,pmc8180c-gpio
+          - qcom,pmd802x-gpio
           - qcom,pmi632-gpio
           - qcom,pmi8950-gpio
           - qcom,pmi8994-gpio
           - qcom,pmi8998-gpio
+          - qcom,pmih010x-gpio
           - qcom,pmk8350-gpio
           - qcom,pmk8550-gpio
           - qcom,pmm8155au-gpio
@@ -143,6 +145,7 @@ allOf:
               - qcom,pm8005-gpio
               - qcom,pm8450-gpio
               - qcom,pm8916-gpio
+              - qcom,pmd802x-gpio
               - qcom,pmk8350-gpio
               - qcom,pmr735a-gpio
               - qcom,pmr735b-gpio
@@ -304,6 +307,21 @@ allOf:
           minItems: 1
           maxItems: 7
 
+  - if:
+      properties:
+        comptaible:
+          contains:
+            enum:
+              - qcom,pmih010x-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 18
+          maxItems: 18
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 9
+
   - if:
       properties:
         compatible:
@@ -452,9 +470,11 @@ $defs:
                  - gpio1-gpio22 for pm8994
                  - gpio1-gpio26 for pm8998
                  - gpio1-gpio22 for pma8084
+                 - gpio1-gpio4 for pmd802x
                  - gpio1-gpio8 for pmi632
                  - gpio1-gpio2 for pmi8950
                  - gpio1-gpio10 for pmi8994
+                 - gpio1-gpio18 for pmih010x
                  - gpio1-gpio4 for pmk8350
                  - gpio1-gpio6 for pmk8550
                  - gpio1-gpio10 for pmm8155au
-- 
2.41.0


