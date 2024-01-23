Return-Path: <linux-kernel+bounces-35651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365748394C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D72283781
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435987FBDC;
	Tue, 23 Jan 2024 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RqcwivGW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3AD481C7;
	Tue, 23 Jan 2024 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027677; cv=none; b=kkZpJwxXex3KS/IrU6k6PWeLGaOT9nbjkcNYlq61eZqrJrpCev0u0E01h1XCdfmsV4ghXR0g+B1NjJRkKEMunhvzk5rBJWkaQyP1ULhcsV8j6Pmv8I3JUjtqBiKr0sf81Z1+0ayP050wcuncXFqcOjJClYqJFbviC8qhF/N++40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027677; c=relaxed/simple;
	bh=ZVT6u/jVKOPURDGdsXTE55rzOKA3jVxHIiN5SEtzdcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FCbz+i47LY4TRmsk9W4NSWoz8Y8u1Io86G9cW+0WQzWZAA+8VM6TGnZr7RGerFrWUpuGRQJZ/AquUiabXGWc2uZ/cRCMDMupeunniJ43hb2a7ZoqcjAb5OIqDoR/9Uq2mxE6RWKw5aRQVSYIPWTEubss9/RDNXPgmmDwtSIBKcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RqcwivGW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NBU8k2004867;
	Tue, 23 Jan 2024 16:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=5b5fU+KTOzPUrCgOe77YLsSItA8Pgv5o+1xi3qZwPH0
	=; b=RqcwivGWESdAuAZqs+/Dzgj6VHm0kVuX5yd/imvEFTJk8vygyB9WwL/68C6
	d/cGY89W/dpNxB0nH4KWbsR0l5TsCVFGaSmkBplT4VbvMXTKwPw2IbDHJzNhhnt0
	lfozjlIGbwDjnDsfgAcsJV4c9IAPIeEzTkMm/SeI+U26n+a9j5ub8JqIaoL0c5rh
	xyla5Svfpp4qx+pNpKGj0VXGpkbK7usCTcMKWjenmT2ufYoEXBTtGuavLvlbk2fa
	GRf8FA0gBg9+ZulAi7aZT3ZpVsR6mng6XUbERbp/lot91SUyEY6AU6TJGEAMCEYm
	dNxaTJ9P/Rtg3mZ1JudMkzFiDNA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt9un97ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 16:34:32 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NGYW6i009628
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 16:34:32 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 08:34:27 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Tue, 23 Jan 2024 22:04:09 +0530
Subject: [PATCH 3/3] arm64: dts: qcom: sm8150: Add bi_tcxo_ao support for
 gcc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240123-gcc-ao-support-v1-3-6c18d5310874@quicinc.com>
References: <20240123-gcc-ao-support-v1-0-6c18d5310874@quicinc.com>
In-Reply-To: <20240123-gcc-ao-support-v1-0-6c18d5310874@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8MRo409U4M5HUK3i5XJqUBUDGN5clySr
X-Proofpoint-GUID: 8MRo409U4M5HUK3i5XJqUBUDGN5clySr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_09,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=501
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401230122

Add bi_tcxo_ao support to be able to put active only vote
on critical clocks during suspend.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 761a6757dc26..b91ef95c0c3a 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -906,9 +906,10 @@ gcc: clock-controller@100000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-			clock-names = "bi_tcxo",
+			clock-names = "bi_tcxo", "bi_tcxo_ao",
 				      "sleep_clk";
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK_A>,
 				 <&sleep_clk>;
 		};
 

-- 
2.25.1


