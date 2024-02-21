Return-Path: <linux-kernel+bounces-75647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95A285ECCF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AEF286E77
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC5E13473F;
	Wed, 21 Feb 2024 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PpWfroAc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5640A35;
	Wed, 21 Feb 2024 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557569; cv=none; b=sC0Z8h99Z8IivdiQZCCe7XN2YNigfkBUJIu2fBg9d5DykDEDm9FG7mN+/tZtAyeHGIE3Hq3oBttbs+zgsbgYCaiNBxkMH4jY9je1flIVmW8ni6DKMG1NGDCfr95hzXqOdXT/6gSErvQaUVgSEy6Jq3AeNa6Qk1ZTHrEwXnPyTco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557569; c=relaxed/simple;
	bh=TzgXSNqdw1xftuAst6wUaXVUR3Uyud3mYme9WvyGVV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=szT9bdgAW2LoiVqxM2E8Vl538h3e3TAL9VnoVPlE/0k3q8GaBQQy6RmdoK9RJl1dyWpSafrcxDGw4wt3HlyLj7aepyaslKVEIsA3c9FZEaOT4YPIPFuXppKXGvHNgDpAOVpG1b3yxZeWCEoszyAydOjh0TwzIwXzikU5Ecc4Pw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PpWfroAc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LMcmGk003186;
	Wed, 21 Feb 2024 23:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=eicjotqJSX3Vn/q7yvGI9f0Q6Wk1DQ3G27dFMziKxn0
	=; b=PpWfroAcgvPImN6kSdCjKOJZDHUpc7e4WcTHFwNVAPiVVf+mbXKghcUxtP7
	gneJfwZQR5Ddmor56LmxLXv14xC7Mvzn4biHeI4DzzvoxhcKE3GrQgD8EQ+qsA35
	Z9bRZPQl23iHtZoPmcQ29morO1CSbQWM4LQCHd9nEHVzuf0OZ2MAA5glQO6pG086
	7QreIV5aKPd+dS3WOR/I4+UmSXXN6b09Mn4f7o61V/Zxq2r5F6/9khhLhDDIccfh
	2kcII0I5xSFcXBnZ9ACLOK6fDMHwbVl28nyLsyGvaHUTCUzR8iL7hcOXz4BJV+2k
	tLyeOI7X6e9jePawFEn3x+KEZwg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdgge1jwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 23:19:15 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LNJE7Q013459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 23:19:14 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 15:19:14 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Wed, 21 Feb 2024 15:19:11 -0800
Subject: [PATCH 3/9] arm64: dts: qcom: sc7280: Enable MDP turbo mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240221-rb3gen2-dp-connector-v1-3-dc0964ef7d96@quicinc.com>
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
In-Reply-To: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
To: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708557553; l=884;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=TzgXSNqdw1xftuAst6wUaXVUR3Uyud3mYme9WvyGVV4=;
 b=UhzzoDerfTeKx+51HM0Flkb9dOiLD0Pis8KPZAWdRsrKjFN1c/9aVPnDpxyCZvo1poA4/57f4
 hdc9XXmdewtBk+r7qNOMavk1t3HeKoJAmAxeu/vkzj3ScVOG2P4ULfD
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ckDOjuBzP1iExCre3YPqDjIkzYFZ14mr
X-Proofpoint-ORIG-GUID: ckDOjuBzP1iExCre3YPqDjIkzYFZ14mr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxlogscore=987
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210184

The max frequency listed in the DPU opp-table is 506MHz, this is not
sufficient to drive a 4k@60 display, resulting in constant underrun.

Add the missing MDP_CLK turbo frequency of 608MHz to the opp-table to
fix this.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index a19c278ebec9..a2a6717c6c87 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4417,6 +4417,11 @@ opp-506666667 {
 						opp-hz = /bits/ 64 <506666667>;
 						required-opps = <&rpmhpd_opp_nom>;
 					};
+
+					opp-608000000 {
+						opp-hz = /bits/ 64 <608000000>;
+						required-opps = <&rpmhpd_opp_turbo>;
+					};
 				};
 			};
 

-- 
2.25.1


