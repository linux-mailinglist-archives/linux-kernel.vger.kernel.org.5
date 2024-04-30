Return-Path: <linux-kernel+bounces-164147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802E78B79D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C721F241F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903B714374E;
	Tue, 30 Apr 2024 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lqaBGAbP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3B317554A;
	Tue, 30 Apr 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487430; cv=none; b=lDfCQ+ciqErhok0WDPHJ5T1UTa6G1iY4bAmyV9DPleGG24Izpr2V5YsK/mTTZx/1IqM6mnF4WW7Ga1TZ5PQpXpoBFGx/arf5h0WsgiRI3WJVOMDG/I/s9BzXJAHmgTkbo4hUdRMLUGLpKdlwQnnkLbRAnqpZ/aM/MaIMXi7OI8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487430; c=relaxed/simple;
	bh=ihg5lQULNJT9PW7MJ5KDEMZrd4+64GQHN2+MPl96c70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0ktCoEUkjXz4wBmMunqR9pK41PU6xP+ld3jiFA7zyPIChuosttFQXEgISbn94ySQlEoy6yGSWqbL11ARPQcpE85nWbqnFFtBcL9WKv9oECnpxlYL+XPLjrhjeZvgmjBsxwfb2zUe/e1jMh/qyTQGvnkZKFTsYGuthQ32qBefRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lqaBGAbP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U3pVlw020492;
	Tue, 30 Apr 2024 14:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=vPXYgO6VAAss9SlZNhdd2lQ2gBHk1GyH7IiMBE9Z1ko=; b=lq
	aBGAbPi9Z0c3F/qJB2dZK9nasNKL7sh66b1QVWCklPmQv28ODPp+YmUdyfb/EsTt
	aA5Cu/bKcAngBcfBidvQwPC73/BInGVheWc5jNIIImMVLLGwBk+3+ZxkP6pTWjW6
	5k53XfXhsUrSSm8oAih88kWlDy7tg8zxCAnGJThZiQ1Q/0GqSkGu1XveE33xfwWs
	8+gnCxH9gV7TGSmXENESByZvLLr4sNOndZFVFvrInfD9/qla1crrLZeo8nGcR4UZ
	JYzoLBVgWcCv8GGt6AL1/8w232jej1qA8o9QfALNfoRi3qwMfWMyBBk3SRIfCMUL
	NdAsxgQeEg5h8GGSVAcA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtqkr9v0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:30:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UEUMOp024263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:30:22 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 07:30:17 -0700
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
Subject: [PATCH V3 1/8] dt-bindings: clock: qcom: Fix SM8450 videocc incorrect header file name
Date: Tue, 30 Apr 2024 19:57:50 +0530
Message-ID: <20240430142757.16872-2-quic_jkona@quicinc.com>
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
X-Proofpoint-GUID: J-nW8BtrTpq129X97hn0d1z3FB6xsUoW
X-Proofpoint-ORIG-GUID: J-nW8BtrTpq129X97hn0d1z3FB6xsUoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 phishscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300102

Fix incorrect header file name in SM8450 videocc bindings.

Fixes: 1e910b2ba0ed ("dt-bindings: clock: qcom: Add SM8450 video clock controller")
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
---
 .../devicetree/bindings/clock/qcom,sm8450-videocc.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
index bad8f019a8d3..78a1bb5be878 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm video clock control module provides the clocks, resets and power
   domains on SM8450.
 
-  See also:: include/dt-bindings/clock/qcom,videocc-sm8450.h
+  See also:: include/dt-bindings/clock/qcom,sm8450-videocc.h
 
 properties:
   compatible:
-- 
2.43.0


