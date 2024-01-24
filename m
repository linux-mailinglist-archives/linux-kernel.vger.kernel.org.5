Return-Path: <linux-kernel+bounces-36420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755C483A07F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD8D1C259FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275E8FC11;
	Wed, 24 Jan 2024 04:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z9XxlLLR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E27BE6C;
	Wed, 24 Jan 2024 04:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706070330; cv=none; b=Mwt/8Rg5GbcGr2RA/wnmpvSVTWdirdv5Pu/PLv2GqtuoMarR0MqVI4SbLH03gldJz3GTrz+MlLwvnPhl3ec1tfbRuo4Y/hVtxb+5Yy/6W2773xWt4jXFwlxLEz+jR9nCCbe+j5ccvQSjcSA6JcJK0lbhBswZZyJILh8xZ2o/RGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706070330; c=relaxed/simple;
	bh=+O+HtBL22at3YsSblQW0xAc9Tt+RUy/3+XcfmdYZC1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CY9IcVGu6MCk2IUTV2OsDmx8fcKewYIKel+g7HSzcYePEFM9LM1Eg4a5ISGeikdXGcIDDxHIofCT73QI7nbEmuij/406dqEJe0krm7muUwff6vjr6OlRG7jnuGObrOe5sQZRgoTBaCzj0hlAWpJcnKLv2LwEyrHfGbM8vXF1a8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z9XxlLLR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O42NMu018151;
	Wed, 24 Jan 2024 04:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=E7qU4RTgqiuopiFft0zFpy55mYuIKEDnGZ5FSl72Fcc
	=; b=Z9XxlLLR+FeKEYlNj6YQLjvTr/h2Wn8PZpi4NvC9LhXn45fhX7nyt2iQXXY
	7PTo36z6zk1BBx4p4Xblo0jbN5+qfem4TerjZVyHtZhvs3NPzX73RUXwoepoZ960
	nQwyMY311i4ma2KLL75kdzpy7oPO03hWmuIjxquRDArW5VYKwfqX2eaYYddfHWB9
	LUq6PjCJYWxv1cSDYkIw1Z+Q28v0Tp74TtkcS/CkWlW91jhD7m6eMwnsr5lpZhvq
	Qwd+C/B7SFbISTCx4DI59YjTyS+4G23/+9a7wT6KYI6KSuAHQYt14ScKv/vJs7BX
	snffJ2zeKiTEbQ0jqxL0udPZUJQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmh00qyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 04:25:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O4PIw3018041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 04:25:18 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 20:25:18 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 23 Jan 2024 20:25:22 -0800
Subject: [PATCH v3 8/8] arm64: defconfig: Enable MAX20411 regulator driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240123-sa8295p-gpu-v3-8-d5b4474c8f33@quicinc.com>
References: <20240123-sa8295p-gpu-v3-0-d5b4474c8f33@quicinc.com>
In-Reply-To: <20240123-sa8295p-gpu-v3-0-d5b4474c8f33@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706070316; l=670;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=+O+HtBL22at3YsSblQW0xAc9Tt+RUy/3+XcfmdYZC1M=;
 b=TKGOOgDhPgvUuFrx5x5odiWvUYTr2MKyAKagY8QHXgcY7PvszFwCefiScCrgDyBinZBIGl0/R
 fYF6x0cwPzHACERIbVE+YqJQvQz484ax++Hvd2z404m/amCs3FO5FFb
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J9zqTQ2g_oxE1_kJ3Hk_AtmFvss83mgQ
X-Proofpoint-ORIG-GUID: J9zqTQ2g_oxE1_kJ3Hk_AtmFvss83mgQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_01,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=769
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240029

The Qualcomm SA8295P ADP board uses a max20411 to power the GPU
subsystem.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e6cf3e5d63c3..43cd31f30fd2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -752,6 +752,7 @@ CONFIG_REGULATOR_HI6421V530=y
 CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
+CONFIG_REGULATOR_MAX20411=m
 CONFIG_REGULATOR_MP8859=y
 CONFIG_REGULATOR_MT6315=m
 CONFIG_REGULATOR_MT6357=y

-- 
2.25.1


