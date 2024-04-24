Return-Path: <linux-kernel+bounces-156703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68F98B070C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52E61C2264F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBE515920C;
	Wed, 24 Apr 2024 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d6crpgHP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC9B159584;
	Wed, 24 Apr 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953770; cv=none; b=OxqcJx+CIDWtcOvPnFJhgWyHiFhXqx0Dpry54ZFhU1VGiD8snke/ShkgkHoPskOmJirdAQsi0TAxnLMT7CgRgtTzA1UM6dA2421NFawBKMM5qLq7Z5t2ZtzTJx/cPXUuVwJVIiB1R6BXh6WHvAoPHuC4OQUkqSiUlUPTfZ/wJYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953770; c=relaxed/simple;
	bh=v01Rmpigo89aONdWCezoWmRzci0tF5lF/efBUigFeM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IpajlvxosPpckEuFgDLY+uziZUQWCHiUgIb5lniUvixN03WyU8CckBoUa4xubm5+FuOp7fepDE2OFRngwMGtZU63h9xWeAalUEAARYp7mDkBP0osPLg0hMKpT3mh3AVMQGzuoNkfRqPzM6qb0Mm156IN6a15yYef46JOpa6cxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d6crpgHP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6XBZg023422;
	Wed, 24 Apr 2024 10:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=elEdDrq0T2URGmjQhyQnjfQ+prOaZ92yj6iG18U4A9I=; b=d6
	crpgHPFggcg9y3cMb4xD//+MSVL3Eek2NWZ//EuUqSaHzUKBlmsIML4hVcehz+1E
	g6VXrFD7cnJfXYb6aEZtUhQxuAYpabmSaaHEhBoiBr9BrpN9epxebXVYB9f5iiei
	8Tit4CYKDMfB0W7NIqxJ9p2ji8Mz/xrrrhdXS5dNX3ehdG3BMmkKamEArhyoRvHM
	/JaDsr7s7N4eaaQk5zckszQYlpMnOKQ7sDcIoCxXB/XMSa9UyDxvOVweFHSS5iQN
	yXb8GTW32xdwHaOPWWp5vRRe+th4BOttBcUlE0YyQ/YOtixWR4FX/UOjmrpJKzb6
	C3u6wkjAoss4oc3/t2Lg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9grh2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 10:16:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OAG1jt030612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 10:16:01 GMT
Received: from tengfan-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 03:15:57 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <manivannan.sadhasivam@linaro.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 1/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM4450 compatibles
Date: Wed, 24 Apr 2024 18:15:01 +0800
Message-ID: <20240424101503.635364-2-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424101503.635364-1-quic_tengfan@quicinc.com>
References: <20240424101503.635364-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eBQDt-33hkmoZNrOMa3ck59D8msvn1pa
X-Proofpoint-ORIG-GUID: eBQDt-33hkmoZNrOMa3ck59D8msvn1pa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_07,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=910
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240042

Add compatible for EPSS CPUFREQ-HW on SM4450.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 56fc71d6a081..1e9797f96410 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -38,6 +38,7 @@ properties:
               - qcom,sc7280-cpufreq-epss
               - qcom,sc8280xp-cpufreq-epss
               - qcom,sdx75-cpufreq-epss
+              - qcom,sm4450-cpufreq-epss
               - qcom,sm6375-cpufreq-epss
               - qcom,sm8250-cpufreq-epss
               - qcom,sm8350-cpufreq-epss
@@ -133,6 +134,7 @@ allOf:
               - qcom,sc8280xp-cpufreq-epss
               - qcom,sdm670-cpufreq-hw
               - qcom,sdm845-cpufreq-hw
+              - qcom,sm4450-cpufreq-epss
               - qcom,sm6115-cpufreq-hw
               - qcom,sm6350-cpufreq-hw
               - qcom,sm6375-cpufreq-epss
-- 
2.25.1


