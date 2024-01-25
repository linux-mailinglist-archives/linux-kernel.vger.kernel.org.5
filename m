Return-Path: <linux-kernel+bounces-39283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE5A83CE25
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2149F1F28E21
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B3613DB89;
	Thu, 25 Jan 2024 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EnAJ9wxJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764413B795;
	Thu, 25 Jan 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216725; cv=none; b=oAo2nTVy4R7Oq8bUuy1sAV9Vwwq8FGgqySVodtVWdjk+ShVCcQQrh2cDj8nwRMr+utMvENvCT2AuGT68qDQ1KK3a1o9B7Ln5Z2wD7P2Xn61VNrQNp9zSd5uXm+UALt6w526RKnchye2oDY+fQAdskAQaDadgbwW2EeNowrnHO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216725; c=relaxed/simple;
	bh=7ZWW+8qHDNDoQXk/hD+0GuH82VHOG4uW2aOnjSqYjh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=I0vYkwlZ1Q03c36htubqVvCigxEzVnFbgJB9NTizqDSllih5621pV0zh3yfCWnYG1LCwI65TStP0Jk5RrbTPEXCiXtMxtMGHvFD6dppou1omYDYn+B0ENYROSeYx268hxcZKs9Oa9/x625s0Yl0SmrkQDJgEJ6Mnp6ujpnzB5NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EnAJ9wxJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PInLki024137;
	Thu, 25 Jan 2024 21:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=vtJobCucxjhRKCLo3qeZp87nG4VsdWwAweQjG0KAvcE
	=; b=EnAJ9wxJiQyZ8ti7Hu9E/X3kIRngBOBy69krynt2yAJzDKtPIEIXkArQS65
	TltYQcrtRbdHqnSezsp1gA1/qPMje+vHYtzoFS8fLKnAMWlnOXKE/ej07ntv2Sbr
	Edny5Vd4FXYQBFEZeP82YpDm3P6cHx3nUOi19HTqrcqYyCQBIJHsdeCt3qlvz809
	sSwBwtVFwMRv9JTkejlHBAeTLoGgFyw6Ms/M1T+4anAGlV/TDEPeGungKHw9oi09
	Ol4MmJh+6cjqVd1cnkOVpgoAVqyx1SLgbcKtEi/18m9+hhBpPJiNuFIrKZQ8EtGQ
	jq5uLWvOYHLn5xsy6tai7VIfdtQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vup5cspv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:05:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PL5CA0031694
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:05:12 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 13:05:12 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Thu, 25 Jan 2024 13:05:08 -0800
Subject: [PATCH v4 2/8] clk: qcom: gdsc: Enable supply reglator in GPU GX
 handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240125-sa8295p-gpu-v4-2-7011c2a63037@quicinc.com>
References: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
In-Reply-To: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Johan Hovold
	<johan+linaro@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706216711; l=1360;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=7ZWW+8qHDNDoQXk/hD+0GuH82VHOG4uW2aOnjSqYjh0=;
 b=1NeGLEQVxHiYJnR/45jQ91/akTnQICpIXQEZIkJgnDvaHfFFITEH9yODLmFrDdhJTKA7ZDVSI
 sGt5hqD0qTFBkXcNrLl44zNYLkzjef/Il5yIzE8JQ9X3hjwM+KJdO6r
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zmNifAXCMG9Gg86X56VwY1X2x5Vmlkth
X-Proofpoint-ORIG-GUID: zmNifAXCMG9Gg86X56VwY1X2x5Vmlkth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_13,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=937 clxscore=1015
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250152

The GX GDSC is modelled to aid the GMU in powering down the GPU in the
event that the GPU crashes, so that it can be restarted again. But in
the event that the power-domain is supplied through a dedicated
regulator (in contrast to being a subdomin of another power-domain),
something needs to turn that regulator on, both to make sure things are
powered and to match the operation in gdsc_disable().

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/clk/qcom/gdsc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 5358e28122ab..e7a4068b9f39 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -557,7 +557,15 @@ void gdsc_unregister(struct gdsc_desc *desc)
  */
 int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
 {
-	/* Do nothing but give genpd the impression that we were successful */
-	return 0;
+	struct gdsc *sc = domain_to_gdsc(domain);
+	int ret = 0;
+
+	/* Enable the parent supply, when controlled through the regulator framework. */
+	if (sc->rsupply)
+		ret = regulator_enable(sc->rsupply);
+
+	/* Do nothing with the GDSC itself */
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);

-- 
2.25.1


