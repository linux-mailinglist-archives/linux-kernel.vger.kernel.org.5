Return-Path: <linux-kernel+bounces-164152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FECE8B79ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016921F24F67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E7414375E;
	Tue, 30 Apr 2024 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S5Oo1hcp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2F7181B99;
	Tue, 30 Apr 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487451; cv=none; b=YVlqSbLj4hdAuj2OnXaXUb8TCiqLBPOPM6r44g1sUH7Whq/Vw0Ii/DO8f887qgigIGIrJ2MiUxvAF1LH4mh+fgE/93EazQ6UsHo/uI7QCwL8M9e5CztiWODiqr3rLCedZUIeWuM+hs3rheoCjxklwRb55bawcxNRxKKLooo4ZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487451; c=relaxed/simple;
	bh=/SkOWkEpWezbJiHW1cEGA0a9fKeRFGBcYXO0YebXhsw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TrQ4b7bCeVEtxSXAMa8xlMWjLtY4RAxhwJvqgOCLYOHwzSwRGqLMd1NdLnT4xGsY9mgLg0MLXf/SVE1hehLDfIkNKHKTpYosp92DZcNhYX+0ZABxxdSzOnJjsxrw8AyjH0b5oc1xBmJVqMaja7sNCvMlDsj86/bi3Jl+Qkmprr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S5Oo1hcp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U3F6wY009584;
	Tue, 30 Apr 2024 14:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=XZ5KkB533ZUQ0vvv/5r5U1dXN3Lm56bSOv7f7rE0hB0=; b=S5
	Oo1hcp18hO73zZx+QppTOWr3ylXLbPfdVBePbn3575T5EUiykvDHvImMjJcdr4wS
	DaDZMzz2+DUU4vkvFP1fnC39ZOWfFWOrAOhSRmOr1VIA/P0578/IGUWRXUmtO18+
	yQfM2UZZC+eZJJqiSfuInQIlMlSRFV/qsD7Kal01VVjBQyLrvjeXFuGweiGsmjn1
	NnkUIjYEb9T5ZjsLApF6cOETup20Pt6vT82GACHWbyRhcSXZ9eZ0u3EtoqUN3vi8
	V8m2TbCr+vK8GtmzVoOi6F+Z1Zu8n7bfVeQI+trBw/lPXoZx+bvIrBknuc2SEVqs
	e7fFcrHZEvLl9bBc0b3Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtqkr9v1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:30:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UEUi7L030998
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:30:44 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 07:30:39 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
Subject: [PATCH V3 5/8] dt-bindings: clock: qcom: Fix the incorrect order of SC8280XP camcc header
Date: Tue, 30 Apr 2024 19:57:54 +0530
Message-ID: <20240430142757.16872-6-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430142757.16872-1-quic_jkona@quicinc.com>
References: <20240430142757.16872-1-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6xtZBtzbsn1evoFECtyypvmU-r06YWrd
X-Proofpoint-ORIG-GUID: 6xtZBtzbsn1evoFECtyypvmU-r06YWrd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=980 malwarescore=0
 phishscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300102

Fix the incorrect order of SC8280XP camcc header file in SM8450 camcc
bindings.

Fixes: 206cd759fbd2 ("dt-bindings: clock: Add SC8280XP CAMCC")
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
---
 Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
index fa0e5b6b02b8..bf23e25d71f5 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
@@ -14,9 +14,9 @@ description: |
   domains on SM8450.
 
   See also::
+    include/dt-bindings/clock/qcom,sc8280xp-camcc.h
     include/dt-bindings/clock/qcom,sm8450-camcc.h
     include/dt-bindings/clock/qcom,sm8550-camcc.h
-    include/dt-bindings/clock/qcom,sc8280xp-camcc.h
     include/dt-bindings/clock/qcom,x1e80100-camcc.h
 
 allOf:
-- 
2.43.0


