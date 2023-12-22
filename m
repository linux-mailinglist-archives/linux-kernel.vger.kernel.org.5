Return-Path: <linux-kernel+bounces-9328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8590F81C430
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41742287169
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C479C8D4;
	Fri, 22 Dec 2023 04:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ic4YRyAh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F6E3209;
	Fri, 22 Dec 2023 04:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM3xUMm013908;
	Fri, 22 Dec 2023 04:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=S++rYSCN+Zhvdk7MOdAERLqeroPAteS+ELCWSWqu7Vc
	=; b=Ic4YRyAhUks5YfROk5Of2hIUmNV2O/peSN2Q+rEYURNE7YZNZj/Q77oglMs
	TXwqMg6tdAWCdVBeKKsHGoCl+zqmEK4mjpBgjSwmCe1yUv3qTn5H8Co+vPvzqAac
	hgZToGYvFq47o0iL7j4SFb3A3YWiJEg+wIXQynrGrvniFQVzv4EHjWxeQv3g3WX6
	2lbMZDHMnDqM3/XK30crxOhlEOshHPK/Y12eKiosJ6VBbGW4CjEN0YYz/rwSkZHP
	beIM1gr+i3RkRNJUSys9aP554nVYpcHlhhITKLBp/AXWNjmUePmCi/shg3yylw+T
	A3x9CqMybGl0RLbSDQND0KkvnmA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4kbwaj1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 04:39:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM4dQpB020659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 04:39:26 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 20:39:26 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Thu, 21 Dec 2023 20:39:29 -0800
Subject: [PATCH v2 8/8] arm64: defconfig: Enable MAX20411 regulator driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-sa8295p-gpu-v2-8-4763246b72c0@quicinc.com>
References: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com>
In-Reply-To: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703219963; l=670;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=unb+KmBC3PDXA2J/s/HHbtUD1oFS0hJ/byKzZ00/Jfw=;
 b=UVpv5+plWWT9lXJQ2PK9AaaX0E2kdoMcFR2NmGjfwfTBE4Jy1nZD3WQv9YwniRalVk3SI0DG4Cvj
 pjrm09lmBZQ+vSXCuEToid6EErvLBGmRC3YiZRowaDCpxjELU6wf
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eRAEMIO5PYu8gwi8SpcGVQzr7ID5gC1L
X-Proofpoint-ORIG-GUID: eRAEMIO5PYu8gwi8SpcGVQzr7ID5gC1L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=786 spamscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312220029

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


