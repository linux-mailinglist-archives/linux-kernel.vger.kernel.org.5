Return-Path: <linux-kernel+bounces-39279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FE283CE10
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B040A29AA72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834F813B78E;
	Thu, 25 Jan 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I48H5bJh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDA413A242;
	Thu, 25 Jan 2024 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216722; cv=none; b=ctrYmsuWkjcuNdTAuaF4vpwHJ0VA8dPxxw971QknWDN8WYcPOzrvvZ0FLj6pzKDr9LzGBsZg3IFrKdMx8Wv/KMvQewH3+1Tnw+H6GGqDWnCXvC+o23/jsU3KW7EgBFvVa7jTYuyuIviQ8M/Cx1whgottAc4Jh0M5Wh4PX/278tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216722; c=relaxed/simple;
	bh=wB7NJGtRNbfW5rgrFcxjSLvoTR2wr8u6sCO82j3nEyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=arqYn/4t8bgFN/At2hp2o6P6b1MrCEQ/tB5TjNyH3Shvv+XTFW5MF5MNpY1uEcKtkmySMt0oxQiXDqYYUVMOcitrmOI9jjJoLHpzDDhYArmFPhl4ZCvAlErq1P0uPNrEFPCKtr+orKyKTpJfS+g/IrLreeArZOtM6Lh5eOqw8Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I48H5bJh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PIeCl9002956;
	Thu, 25 Jan 2024 21:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=jdTPCIWbZU1YuhLSVBXhk8j7wmEbnSsTEzOslXqBqWM
	=; b=I48H5bJhzv2vx5vZsUj48rRwqXUOjB2Hqng/07SyHkiuXCPwEmKdTLCYl69
	jets7WAWyRDwwGDVbchDAPp5AjYZFRskm663t2MrdF5n2xDQWVqhaICGK0pXxIlZ
	2hVH5sHBDZ2Z0sB1Io7TW+zEQVnM2MIwALXYoZTz1YGpPTQHDUP2czYK2Mow4Z2c
	q6VUv5pkOcrvvrX6pxCBPh2+tevR+JPjPWZyKx6Y7VW9cXrfqMZyXzl8JGJrRQyM
	eraw5JkVkt8S0SoAuBiZ4bMARG5AXbUaxfZJ51rezoF/3ne91nvGErQWVM8CRLbM
	2nL4r1I5UYf6Rd+WqVUdDCNppoA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vumcwsub2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:05:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PL5CeD031043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:05:13 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 13:05:12 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Thu, 25 Jan 2024 13:05:10 -0800
Subject: [PATCH v4 4/8] soc: qcom: rpmhpd: Drop SA8540P gfx.lvl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240125-sa8295p-gpu-v4-4-7011c2a63037@quicinc.com>
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
	<dmitry.baryshkov@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706216711; l=1039;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=wB7NJGtRNbfW5rgrFcxjSLvoTR2wr8u6sCO82j3nEyw=;
 b=pNJ4BH7uAdplqbpAnDnpNcEagsDpKnEMKgrGtdzcMwPC6nJrrVfuSTXFLLfOVjzNqEgoMkv2i
 W2FQG48+ECmCwSZsTGZPCNHGEE5Xgj9TxAgVs05g5MXImph4696rUda
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RNy_nk4avt6AXHwO2Q9UC-nns6-JwE1x
X-Proofpoint-GUID: RNy_nk4avt6AXHwO2Q9UC-nns6-JwE1x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_13,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=975 impostorscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401250152

On SA8295P and SA8540P gfx.lvl is not provdied by rpmh, but rather is
handled by an external regulator (max20411). Drop gfx.lvl from the list
of power-domains exposed on this platform.

Fixes: f68f1cb3437d ("soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh power-domains")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 3078896b1300..27a73ff72614 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -217,7 +217,6 @@ static struct rpmhpd *sa8540p_rpmhpds[] = {
 	[SC8280XP_CX] = &cx,
 	[SC8280XP_CX_AO] = &cx_ao,
 	[SC8280XP_EBI] = &ebi,
-	[SC8280XP_GFX] = &gfx,
 	[SC8280XP_LCX] = &lcx,
 	[SC8280XP_LMX] = &lmx,
 	[SC8280XP_MMCX] = &mmcx,

-- 
2.25.1


