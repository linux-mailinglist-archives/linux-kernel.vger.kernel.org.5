Return-Path: <linux-kernel+bounces-39276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7463083CE01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B98129A4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D3913A26A;
	Thu, 25 Jan 2024 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f+S5jMSh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8384137C31;
	Thu, 25 Jan 2024 21:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216721; cv=none; b=f0YGeJuqgnORzlf0bNtXFniMLbzpTezTqc6oSvTwiftYYRE57YkImDJ8oHy9uhzHSb/j9feSLUfrrfSNFUKFh/1KqoSG08RcyV1VrBU6UXrbTok6i3MmtAkuGsTIIAb8y0DkEmIk+oSMII0+sbCwGioiT04diNbEXRDbj1M+2cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216721; c=relaxed/simple;
	bh=XqG6SvzlCntF+3+Nx+hVAQgPWgQW/RVb0t9LmLHIY+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZCDqT+SPgsNdGtB8LDQydWPOQgaQhOFP/wayn6pzt30sW5hOqrjhtemxB1fXAorNDpYdOY+vHaHOqrMHfm7UPNI8ZRTa8aRzB/SyzIgjTVECXqtNFz5NMFVRbXu3IV1YY1vc6bGRGq1KUC8/EfaJMIQZHR9WY2sHqrnbscuu24s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f+S5jMSh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PJQY5n005990;
	Thu, 25 Jan 2024 21:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=ZMlir0J/FxMSwVAPbsGBDxQdkacIBRKuJrcSmKp/nJU
	=; b=f+S5jMShOzYJowhiJ70WBhjqvEjAYy5PhF4nw3jNUEUi0BAUCuIE0g6qowh
	+D1AuQIa8GkiDjP2ROOQo4gSd8aLhJhxtRSIkArKwkOw4SCRv5gowejTEebDMtW7
	8bwRRrodXycC7lGVmHmUpSLNOIj06sp4E6y55e8a6L4KZ/KpNjyCGvcfJ/vvqmVf
	2Z9Gs8VZz2OtKbD3oMY6BLWd9NLaB81cFJEoadbzgUj4G0ZuxZh4J4bKahJuOjNp
	hgkUNx/TtLr7mHI3n3dCwpYZm6Hmr6qPDW16YGM7h3HulF80U7KOxj0YzO0deUta
	56qDyDg+YnLBbUvE1AqSf8OCqYw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vuqra17yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:05:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PL5CeC031043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:05:12 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 13:05:12 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Thu, 25 Jan 2024 13:05:09 -0800
Subject: [PATCH v4 3/8] clk: qcom: gpucc-sc8280xp: Add external supply for
 GX gdsc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240125-sa8295p-gpu-v4-3-7011c2a63037@quicinc.com>
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
 Andersson" <quic_bjorande@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706216711; l=958;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=XqG6SvzlCntF+3+Nx+hVAQgPWgQW/RVb0t9LmLHIY+4=;
 b=XDttVYXJbGouKJcX2dpHEn0pi5SpkZUCZhx6tSuTP8t7IgMoPrYxHXMJvHuwPlds9MH6O93nJ
 RE5v2dzM60JD6zpgVVcftpl7cFTib5f1ReWyXbcyMqBlOP/ScloV1FT
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VjGFL2goocQ-CdcYKUpNbqfftx482lN7
X-Proofpoint-ORIG-GUID: VjGFL2goocQ-CdcYKUpNbqfftx482lN7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_13,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=998 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250152

On SA8295P and SA8540P the GFX rail is powered by a dedicated external
regulator, instead of the rpmh-controlled "gfx.lvl".

Define the "vdd-gfx" as the supply regulator for the GDSC, to cause the
gdsc logic to look for, and control, this external power supply.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/clk/qcom/gpucc-sc8280xp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
index 8e147ee294ee..e2b3bc000c71 100644
--- a/drivers/clk/qcom/gpucc-sc8280xp.c
+++ b/drivers/clk/qcom/gpucc-sc8280xp.c
@@ -399,6 +399,7 @@ static struct gdsc gx_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = CLAMP_IO | RETAIN_FF_ENABLE,
+	.supply = "vdd-gfx",
 };
 
 static struct gdsc *gpu_cc_sc8280xp_gdscs[] = {

-- 
2.25.1


