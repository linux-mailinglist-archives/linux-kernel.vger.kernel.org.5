Return-Path: <linux-kernel+bounces-86140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 438AE86C051
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80861F232D9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E183DBA8;
	Thu, 29 Feb 2024 05:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XlkNTLVQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2BB3C472;
	Thu, 29 Feb 2024 05:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709185199; cv=none; b=rf2Y3s42VcumlgjPKhEfj2xIOV/X+YB6xpyo0e2q2e2lKURRlwUkBfjop8Ilk9Dne0IxnaAoLmtS1RgOHlkKyld15oDIpTZst+U2LP6NmrDqbGBdIE0mwS5gYrxmCWrLQIFcamJ2aIG5CBZvJYaBXT3pXQrkqBjo3m8Ae+TjN18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709185199; c=relaxed/simple;
	bh=gLlphfeZwMqykTLE2cgkluz8dCXNxQwpkFEozCoV6ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mdfiR8lxtLvwAK1uS4KpeBvbJ44rW9eHNMxuo0SH7mm3/9xvf/4VGoKohMngLln9J5yaNjNhKflQCoA92+PtQmGIX/HmiV5JjL/VhMaEbulL/MnLw82OSrcs081aFl9UL9xF0w3RrbgzIkOJr67Cl66T5NhTc134eoz17frNcJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XlkNTLVQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T39GpK004692;
	Thu, 29 Feb 2024 05:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=S1qRGs0HUaMy90heuuUw2qaX9/payA7Vq1TJ1BurrRM
	=; b=XlkNTLVQbEjzIrDOCBd7VpaFBDZFz+6UPiaCRJB6ma+HrVmB65XTXQgZbDl
	PUvh8Mf4imyVsAtIeGY+59fmr1ws4wvz/Jiit5/q8hh5LRJCyjQQM15CxkpT8SPg
	ckicjQbkwBGBv1++G/MPc+EQEF5TVZNsxSxkSI2JCEMfC0Nlmd4T2LJDN/4eSoIG
	KwIdJfGrZ0f269e8RzT7b4v8merZM9sQB0SrdJ4Uex0PWlJuDZY3y/7FXwNRCC+3
	OvmsVQt7z7RIZsvGMeFeopxf3zF9yhvTAhi1Fy8PLEe3LjIMzBSZTlQwejHPd2bR
	3mud8ejSFLTmVT+HEK8aGcpZ0vw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjdjngsc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 05:39:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41T5dCvM028758
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 05:39:12 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 21:39:06 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Thu, 29 Feb 2024 11:08:54 +0530
Subject: [PATCH 1/5] clk: qcom: alpha-pll: Fix the pll post div mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240229-camcc-support-sm8150-v1-1-8c28c6c87990@quicinc.com>
References: <20240229-camcc-support-sm8150-v1-0-8c28c6c87990@quicinc.com>
In-Reply-To: <20240229-camcc-support-sm8150-v1-0-8c28c6c87990@quicinc.com>
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
X-Proofpoint-GUID: bR5pfRagSHaICsdQyN3jgCV4sSFj4j6J
X-Proofpoint-ORIG-GUID: bR5pfRagSHaICsdQyN3jgCV4sSFj4j6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=816 spamscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290042

The PLL_POST_DIV_MASK should be 0 to (width - 1) bits. Fix it.

Fixes: 1c3541145cbf ("clk: qcom: support for 2 bit PLL post divider")
Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 8a412ef47e16..8dc3b8774b8e 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -40,7 +40,7 @@
 
 #define PLL_USER_CTL(p)		((p)->offset + (p)->regs[PLL_OFF_USER_CTL])
 # define PLL_POST_DIV_SHIFT	8
-# define PLL_POST_DIV_MASK(p)	GENMASK((p)->width, 0)
+# define PLL_POST_DIV_MASK(p)	GENMASK((p)->width - 1, 0)
 # define PLL_ALPHA_EN		BIT(24)
 # define PLL_ALPHA_MODE		BIT(25)
 # define PLL_VCO_SHIFT		20

-- 
2.25.1


