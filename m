Return-Path: <linux-kernel+bounces-159044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33878B2894
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01F1285D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91721514F4;
	Thu, 25 Apr 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="isG7sgCr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEE814E2CC;
	Thu, 25 Apr 2024 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071387; cv=none; b=EiDHGew0iz2l9OWJhaO+Hal1Z6G5b/CDjIaOtg/Kiq7jW0mEvvIqW5WMY2X5K3QepeiETL2tZ3ho5RlvjGkwDbRTslGrhvjsT4Jo47w8TyIuPhMQVObo/9e89vzaGb4sojOWOHipRGuGISYmHQnBBmWxsrelW7T0lgi/kh2+gJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071387; c=relaxed/simple;
	bh=sYiKYo5yrzo3uz+ciXwmOitpeX6FAmTwxbeLT5atQqw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TZJzwgg0m/fe0+nLO0xOI0pvzH46Q693UUpAbx0YLpweu2hCYwmm33t9NrwYy8bcFj1iV8sT/NWrkSXI9RZl4gxaQaaSdl8L9b62OhP+LpcmWR4Hdnf9k0ClW+f6GJjkpwcNh6DHRdu1fYvmvPh5HGDs8rAGZArR4mEXDN7+Ako=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=isG7sgCr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PIRJgY001502;
	Thu, 25 Apr 2024 18:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=FTrp4nh
	XYXjYe6/hbotlI8vnChMZIzJNtiB8ie3le3Q=; b=isG7sgCrjHEVuthVx7YdOA7
	TWFfGGt6+Q2fycCTgdAMUhI21tbia9Y365NWBu4CeFow67l4SDvbj1A1W9Jql/7j
	oWcZNIKPrqrbAWajW5yN2XwKygXBgquiD6/kPKISttSaNpQlhu/+F35CIy3tfeSZ
	5OEnfAYuxeWMHbFznd5qyTolGspXoPe3ylmC3PQUdhCprifhQE3hV4GR5KpjGWcU
	0X0KdGJO6krMCAgjp9CzKFDgzFt5D53kyU+rxll1gnItNbYf24ODk6qMdMIj542H
	hgnGQOb/uHsewNVFf4ohmhIP5i7WI16i4hARq/KjMMyMFQAWpLy7YrNJJJyBKkw=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqtph8b8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 18:56:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PIuKU3025128
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 18:56:20 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 11:56:19 -0700
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <quic_amelende@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: pinctrl: qcom,pmic-gpio: Fix "comptaible" typo for PMIH0108
Date: Thu, 25 Apr 2024 11:56:03 -0700
Message-ID: <20240425185603.3295450-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: DydczXE3DsI5ayXcHfairIjsqj9XyhDt
X-Proofpoint-ORIG-GUID: DydczXE3DsI5ayXcHfairIjsqj9XyhDt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_19,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 phishscore=0 mlxlogscore=872 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404250136

Fix "comptaible" typo in if schema for qcom,pmih0108-gpio.

Fixes: 6acc46f8c065 ("dt-bindings: pinctrl: qcom,pmic-gpio: Add PMIH0108 and PMD8028 support")
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index bd9471de0c69..50846a2d09c8 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -309,7 +309,7 @@ allOf:
 
   - if:
       properties:
-        comptaible:
+        compatible:
           contains:
             enum:
               - qcom,pmih0108-gpio

base-commit: f3953d6d4f608bb3eb4cbd8145913db4627c4e74
-- 
2.34.1


