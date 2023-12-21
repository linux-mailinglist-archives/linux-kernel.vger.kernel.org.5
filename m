Return-Path: <linux-kernel+bounces-7826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB1781ADD2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666041C22E82
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3A818054;
	Thu, 21 Dec 2023 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TFH9Mu7f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A0AB654;
	Thu, 21 Dec 2023 03:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL3Z33c016454;
	Thu, 21 Dec 2023 03:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=S++rYSCN+Zhvdk7MOdAERLqeroPAteS+ELCWSWqu7Vc
	=; b=TFH9Mu7f43fpIr7Fii5gjvHFOjs3RWAIyFh3VnntJNiKBx9zYIk0Fc+YZdS
	HsuXEwFXx6PVkSHriEVIo9aJ9FgUw3EAyWwU23SHiH77mdexLF2yEzoTV1xwti8/
	gxlMJkpnHjUpB+tyIWnWpq8m2jIfjv23Sofq0WhcZBvEfrtFBUUletfPRlN2GPVd
	5lxrzcoFLYOIC1dQShZbWgfdbRsOrQWgrLAiwEQRuX9jgIKjigTVvV2Vfo500Av6
	68CbYRZ0pDG7QeD7QfQdrgRrch/ND48gJUs1N7CvYfwXPjBIP4BnAC5RvqhReRAa
	Z5p17i56wBfAyqP9bKD0EP0vjdw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3wr12k84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 03:50:53 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BL3oqrJ004602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 03:50:52 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 19:50:51 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Wed, 20 Dec 2023 19:50:42 -0800
Subject: [PATCH 8/8] arm64: defconfig: Enable MAX20411 regulator driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-sa8295p-gpu-v1-8-d8cdf2257f97@quicinc.com>
References: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com>
In-Reply-To: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com>
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
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703130649; l=670;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=unb+KmBC3PDXA2J/s/HHbtUD1oFS0hJ/byKzZ00/Jfw=;
 b=HHjMmAHWw9PSs2dYfX8aRLVDQkwSa+1ftCEgjo9hQBBYGA6UvG3BXO448RQ5/vQ4F4KroNdxaz6K
 nT+H70ycAE1c7lL5jWjkNrwWtBJmKsjsdw3Y6PjKmQ52JhOQL2yk
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SlhIlja6p63QDVmjoiTmEG45uHdvq-14
X-Proofpoint-GUID: SlhIlja6p63QDVmjoiTmEG45uHdvq-14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=787 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210026

The Qualcomm SA8295P ADP board uses a max20411 to power the GPU
subsystem.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ef1061089548..ec94a0c4fd03 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -751,6 +751,7 @@ CONFIG_REGULATOR_HI6421V530=y
 CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
+CONFIG_REGULATOR_MAX20411=m
 CONFIG_REGULATOR_MP8859=y
 CONFIG_REGULATOR_MT6315=m
 CONFIG_REGULATOR_MT6357=y

-- 
2.25.1


