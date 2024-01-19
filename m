Return-Path: <linux-kernel+bounces-31420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D84832E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC1CB21157
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0A955E58;
	Fri, 19 Jan 2024 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RqzajSw2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C934C3D4;
	Fri, 19 Jan 2024 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685090; cv=none; b=g40ZhDYpiiXuijilhdLk1FgzLu+Cjit3dNizgMDQFO/E47+DoomXfZwH+RDs580hBKugPkJ3BIsEaAqgQ9Gq1p4OiyDqmpErWib9Bsw2hNMIF31ihSSP1S7RhYGxwvQCivzPCV5PGdHKHBFgVv5DdYlb6gvURz48AfrWyORcQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685090; c=relaxed/simple;
	bh=p0dATL2sTq98fffXdlt1SbUyiBrcnI+xMllTBKuJdgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=QimmVcAO+l0cb0L0TRJuJiuY26oVP76xQd+lDr7julh41RD2P/cd2Mk7c0fWM/8OB3ZhXVvYU/nsxx6xGRCrFqRMDKUEOcpY/ryU6qPbyyEs0JIH0Mh9s8vzBlnLDISDAHc1BTStdixkHRH0IGVYdmLp3dlyGCpUNzCm/fcCssU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RqzajSw2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40JFOOue001026;
	Fri, 19 Jan 2024 17:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=pKr
	RR3dhjtfeyrwYUub7o3zhfb2MzOfYys+JVa8W0I4=; b=RqzajSw28Hrvonowuc5
	+yi1BSrcP4ZkNjKODO1Jwj8dg87vE83z8KOSUBXvWwhW+M0ux7J8Vxp0WA3B5rQG
	UGak+cYF2OVi1FNzGszpF0Uhh/DGxOEl5/5ItzTOBtcPxpdKRKMMwQ48+QP/aJk/
	wqd3V2zlqFWz4m/kI1e9E+L4oNIc5dpyxZr4/CGRONOI3rwD25WgGLMXvSXeIaVm
	9HkybBXsU/1vJzoKdlBmjb07Ev6YPS6eOufeuLASwgHHGqn19NjakTtbw6JJy+CO
	t5b27gvGsu2K5lEdODDQ8lQCUd+N3vzy21L2GPAqAFJfZXZyjv1DuzAjO9D3iORa
	JUg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqn89h3m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 17:24:37 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40JHOaGR024702
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 17:24:36 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 19 Jan
 2024 09:24:36 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Fri, 19 Jan 2024 09:24:34 -0800
Subject: [PATCH] arm64: qcom: Select PM and PM_GENERIC_DOMAINS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240119-arch-qcom-select-pm-v1-1-584f8c6ae1ce@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFGwqmUC/x3MQQqAIBBA0avErBvQEqSuEi1qnGogrTQiiO6et
 HyL/x9IHIUTtMUDkS9JsoUMXRZAyxBmRnHZUKnKKK0bHCIteNDmMfHKdOLukWujLBln7FhDLvf
 Ik9z/tevf9wMQpmySZQAAAA==
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705685076; l=921;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=p0dATL2sTq98fffXdlt1SbUyiBrcnI+xMllTBKuJdgE=;
 b=K10bJuZ28vwRLWOjEbeEOiEzFcpo5oPSxSdn9ygvVu6VrE3R2LxnPj3IsZH7DW2TN4NAnvzkO
 umVSBHis8ggA8ZWE2DuKf/wsK6mkbHUbzKxChDK1TbjRuY7ze01HTWf
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eEXKY__pJt5kh2PzXuKvO9yAsQmOkTit
X-Proofpoint-ORIG-GUID: eEXKY__pJt5kh2PzXuKvO9yAsQmOkTit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_10,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=883 clxscore=1011
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190100

Several Qualcomm drivers depends on PM and PM_GENERIC_DOMAINS, but
no-one enables these in a ARCH_QCOM system today. Add this, to allow
such drivers to be enabled in that configuration.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 24335565bad5..843fbb6bf0cf 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -260,6 +260,8 @@ config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
 	select PINCTRL
+	select PM
+	select PM_GENERIC_DOMAINS
 	help
 	  This enables support for the ARMv8 based Qualcomm chipsets.
 

---
base-commit: 2863b714f3ad0a9686f2de1b779228ad8c7a8052
change-id: 20240119-arch-qcom-select-pm-e3407c4d47b3

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


