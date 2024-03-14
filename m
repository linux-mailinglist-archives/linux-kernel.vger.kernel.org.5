Return-Path: <linux-kernel+bounces-103750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C76F87C3F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5742A28410B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26127762DE;
	Thu, 14 Mar 2024 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d1+9KRET"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58BB762C7;
	Thu, 14 Mar 2024 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446724; cv=none; b=JsrN9ULmsOOwTfX/dGPWdh+G9S9D4eGDpg0hoAalt9xT8kXrTa7Q/No7sXP/JZBPK7HkoeMGdpiPHzmVFTThtrESFhK/b9WV79uHlIy67gzk9xc3r2aMdl8ME/mAHCIkJODJCuBrNqDU7USQRuY+LYCh3oG/TwO7SZW2WKf86sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446724; c=relaxed/simple;
	bh=WPIqOrH9yOTY8bYbuoMFxzapg2fQl86rNePVQN4CX0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7EzrJz420Wl0YZ24rAF8qWrjmhsF/kPD8D/HBXrdT6h/qeCv36TLzfWb7QXNqrVeWlfz1mQFB2rlYBiPGmjY9FhBnlQN15xrcpavHT9BHaaqrzj4l3nNMdKJtzYnp6GirH78+y6EmBCWVMfG72CP8x5ZUjyzbrPVDsE76KN9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d1+9KRET; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42ECHC3E016984;
	Thu, 14 Mar 2024 20:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=oohcgOK8ft41xR4xPKyintVIAkvR5G7rn8QPWMrgbV8=; b=d1
	+9KRETG2PlwKC1ve7GP+upQZSL06Ea8cwtlaI2xThjxZWHN1Hfx9MuYgwEiSNXzu
	LhD91HtuAWQGggKIIDTa+bOBSJmnPj0Cl1w4/QhyFgg5NNvBlOMvzCyWpx04Ms5H
	IMX4c7RvhILpCgtnYnNuILI3Eq9NObbFwvZTZL7anFScawkK8hg/Lq6IkiJHbTjQ
	/QmMwZ2yomxmDrkbnIDGbLJPFI8BhavAqUg7Zgvqn0nzJJG3wkge2tVGVltgA0W4
	MRuGj7YEqtt2HrTvfRiIl57kxRrnRTQLeAEXYBRyeLONsYg2zx9lW3Hd+y9KfOgw
	UQ5udwiEeMQg0m6ztn3Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuujssuqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:05:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EK5ISk009487
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:05:18 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 13:05:18 -0700
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH 1/5] dt-bindings: pinctrl: qcom-pmic-gpio: add PMXR2230 and PM6450 binding
Date: Thu, 14 Mar 2024 13:04:17 -0700
Message-ID: <20240314200419.4733-4-quic_amelende@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Ji0yXvwJ3BsAOkuFm1QI-TGH4C5HKw-q
X-Proofpoint-GUID: Ji0yXvwJ3BsAOkuFm1QI-TGH4C5HKw-q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxlogscore=875 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140155

From: David Collins <quic_collinsd@quicinc.com>

Update the Qualcomm Technologies, Inc. PMIC GPIO binding documentation
to inclde compatible strings for PMXR2230 and PM6450 PMICs.

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
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
2.41.0


