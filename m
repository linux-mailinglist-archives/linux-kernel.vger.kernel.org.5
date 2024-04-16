Return-Path: <linux-kernel+bounces-147369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CA88A7309
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A4A1F21EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7533113775D;
	Tue, 16 Apr 2024 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NTQwhIjF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C3136675;
	Tue, 16 Apr 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291688; cv=none; b=pCSX8pu1SSxOZSOSU+Q+ll6gI5jvqFQDxP+TO7CqsU3yHb0T86XRYhVj+Yz7N/jREcm3C8D5R5TOungYwXGYLzyi2mK2dYAu9S0Gf/iwfAISHGdMjRDXBQuvkP2bPWT4B10wfpt2KCQR/xc04nDD98DUDkTwVAdicKSKSaPl51E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291688; c=relaxed/simple;
	bh=0uNHnY3/vyfm1OdSaRqU0rd1S/3Au1oahr6hn9+Yh9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuactwEf8QfBodZJVNuNkO7p36PTIxbGPuWowyMOsXgIBvQcuBij2i+ZgThcoZA/9LgXEGpH8pHO797VdTf8yB04pOohdI/LL8Q9OrGNt/m4RUOTaBIE4DKYSQKp2L9/QrnNIF/5Gu+QZRSBePW01d5iaxNmrCDaNddgHjujgxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NTQwhIjF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GDoY8M018510;
	Tue, 16 Apr 2024 18:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=GQP/S9wF50hkAtHrqa2wzWbWX4noH2h5fH52On1Who4=; b=NT
	QwhIjFIjr/7jp0gyi4AJiJlAKkJDZ4q08HigZJ0tdNNKgK995VrChinCoCJMsCKH
	ccaOmvPPKZwsuE3dbwpKUMRahHT8elRRjSOVNCNV6SpNF2KQWMv+1k6InBkNTOyJ
	111FF8cX2RBASVil9DxPgWaBIS0C4COGwJEFmdOJ3sLUzvL8+ZWxjG4fmonm3Dnj
	yg3h6QqAqVMw9fnEMcCvlUA2GEU3gPZqUj5Bg8/S2zlFdT82RVskXiP98IKVm4m3
	z6Z0Jq5V8wPiAIvdHFbys3kBMK+rFzN7YSQEhAQdl0AtGvxx7YPF7TQ9b/IuAR33
	DB4lw3Q1Qd0l/Bfis27Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhtjr8vbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 18:21:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43GILL4c009164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 18:21:21 GMT
Received: from hu-ajipan-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 16 Apr 2024 11:21:15 -0700
From: Ajit Pandey <quic_ajipan@quicinc.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH V2 1/8] clk: qcom: clk-alpha-pll: Fix CAL_L_VAL override for LUCID EVO PLL
Date: Tue, 16 Apr 2024 23:49:58 +0530
Message-ID: <20240416182005.75422-2-quic_ajipan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416182005.75422-1-quic_ajipan@quicinc.com>
References: <20240416182005.75422-1-quic_ajipan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jujZR0PCkt-404QU1KeuzIAp_DuQUgyX
X-Proofpoint-GUID: jujZR0PCkt-404QU1KeuzIAp_DuQUgyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_16,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160115

In LUCID EVO PLL CAL_L_VAL and L_VAL bitfields are part of single
PLL_L_VAL register. Update for L_VAL bitfield values in PLL_L_VAL
register using regmap_write() API in __alpha_pll_trion_set_rate
callback will override LUCID EVO PLL initial configuration related
to PLL_CAL_L_VAL bit fields in PLL_L_VAL register.

Observed random PLL lock failures during PLL enable due to such
override in PLL calibration value. Use regmap_update_bits() with
L_VAL bitfield mask instead of regmap_write() API to update only
PLL_L_VAL bitfields in __alpha_pll_trion_set_rate callback.

Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL configuration interfaces")
Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
Cc: stable@vger.kernel.org
---
 drivers/clk/qcom/clk-alpha-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 8a412ef47e16..81cabd28eabe 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1656,7 +1656,7 @@ static int __alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (ret < 0)
 		return ret;
 
-	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+	regmap_update_bits(pll->clkr.regmap, PLL_L_VAL(pll), LUCID_EVO_PLL_L_VAL_MASK,  l);
 	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
 
 	/* Latch the PLL input */
-- 
2.25.1


