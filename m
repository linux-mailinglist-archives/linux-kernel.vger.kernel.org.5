Return-Path: <linux-kernel+bounces-86138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9017A86C046
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B459F1C2129F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0847C3B190;
	Thu, 29 Feb 2024 05:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n5bv9s8A"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74873A1BF;
	Thu, 29 Feb 2024 05:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709185181; cv=none; b=DNZom48TieXWl5vTus+Ms3y6N1gBcGv8pfbG4Ldf+wwXeqfiG/XSzGC4rLziThCfMIH1K1rdGwn/Hc0k/1A9zEsvW6eslAqlDtwHZds6I1b0wsM85z/1Vks/4rXAh4edFQdhDtgM4J2b+m+k2teu5t/KFRnXaU5nON+hbDjVwT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709185181; c=relaxed/simple;
	bh=DB6LgLjnrJ7phIYd9/PpD0EwgxadninTd4QwfLnvfig=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=YayhynwOsMrKzyyrZRNVQj1oq2pNO/E3ixsj3NuZl48HKMm/Wi+wB4t6uihcnxUsMZC2iHDp9tuUc59FJS4tq8LxeDG20E3xgwGnaCmJxeSJpKlI3OfqAdMXr/VxFuVE7vWA75U+JIGrqNIlZ0wKDEEh95KKlZdKOx0bdU0fNrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n5bv9s8A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T484eB018478;
	Thu, 29 Feb 2024 05:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=5A8Rs87XUubM0I
	4u7oQxcWAIxYITrEgsH9L4xfy44Sk=; b=n5bv9s8AaIBTYD7DExhxMTnsI7UADf
	Q8gOZJDZpyDmYcHIjOqVKSyk2lEONSS//moICG66770Op56MxRFdHhChDay4yAjx
	XStdM1v7mz7qsJh4VgAdfGtkYlJ9BlzCrMUt/0quBtp14RqdBCeKNJwBdQmIa94A
	/R8Zk1PQjo5h063aQ7Rk1EwssL5sxtU8A1JDQf3h2Bpr7hRf9ftTZTsqzxAKDfAE
	V4kfa1cKpiLm/NwJBZBGjhIFGOEa3IDGOweammoFXqJBceUgcCgz0uQtGTrq4CmI
	uHDi6xBURlCh6jH8rsTutNWTRxpiiufXsveT2XRNbXDfMMEaiw8wxSwA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj1r1tq2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 05:39:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41T5d6Xx024175
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 05:39:06 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 21:39:01 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: [PATCH 0/5] clk: qcom: sm8150: Add camera clock controller support
 for SM8150
Date: Thu, 29 Feb 2024 11:08:53 +0530
Message-ID: <20240229-camcc-support-sm8150-v1-0-8c28c6c87990@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG0Y4GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyNL3eTE3ORk3eLSgoL8ohLd4lwLQ1MD3RTjNHOjRJNEw0SjJCWg1oK
 i1LTMCrCx0bG1tQBEP6h7ZgAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Stephen Boyd <sboyd@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>,
        "Imran
 Shaik" <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZgaToXXud25X70w4dqqTjzKVey0wxvpe
X-Proofpoint-GUID: ZgaToXXud25X70w4dqqTjzKVey0wxvpe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 malwarescore=0 clxscore=1011 spamscore=0 adultscore=0
 mlxlogscore=862 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290042

Add camcc support and Regera PLL ops. Also, fix the pll post div mask.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
Satya Priya Kakitapalli (4):
      clk: qcom: alpha-pll: Fix the pll post div mask
      dt-bindings: clock: qcom: Add SM8150 camera clock controller
      clk: qcom: Add camera clock controller driver for SM8150
      arm64: dts: qcom: Add camera clock controller for sm8150

Taniya Das (1):
      clk: qcom: clk-alpha-pll: Add support for Regera PLL ops

 .../bindings/clock/qcom,sm8150-camcc.yaml          |   77 +
 arch/arm64/boot/dts/qcom/sa8155p.dtsi              |    4 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   12 +
 drivers/clk/qcom/Kconfig                           |    9 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/camcc-sm8150.c                    | 2159 ++++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c                   |  154 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |    5 +
 include/dt-bindings/clock/qcom,sm8150-camcc.h      |  135 ++
 9 files changed, 2554 insertions(+), 2 deletions(-)
---
base-commit: 20af1ca418d2c0b11bc2a1fe8c0c88f67bcc2a7e
change-id: 20240229-camcc-support-sm8150-d3f72a4a1a2b

Best regards,
-- 
Satya Priya Kakitapalli <quic_skakitap@quicinc.com>


