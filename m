Return-Path: <linux-kernel+bounces-120197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4348D88D44B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B89DDB21F54
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614652209D;
	Wed, 27 Mar 2024 02:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OmzOQpgO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C44A20315;
	Wed, 27 Mar 2024 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505087; cv=none; b=fp6yvKqJiirjYJVhfVkFu57KRjw3aKNM4yWiw34uNgoUFJqCuKcwSSLEc687RtjcBNbXo31Dx1drEDnaEpY2jY0jI9fw/XRfhW+SHc86utvmw+7wXx/wp2r8n3clIVX9pwtxuf8LCAQSE+AjaKVzW8f/oR8csiW0+wPvOCureSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505087; c=relaxed/simple;
	bh=PH3agPVcu0oRlNkvdU1AcR2OvLC0h7VlusCgUGbWUQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HLTF3yK/IjHRYMZyyInVxNm3LYN979erHtzcqAPrzWOIKMNdOFv1hI7nt+ScDw7+dlzkfNpt9UCJA4O8IxsV05vZZLoDxxez04B7PxnzREymJ/6hMDBHl2/R2MqNx8F6B+xGveP6UYTMPSsTtDaa8TE0OzwrAORQyf3lt0I9PGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OmzOQpgO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R0tRsT024156;
	Wed, 27 Mar 2024 02:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=OA4HTGE3gk5yXf2lZJ9Uk1ZR1AxJF8BlqYBnZRsloV8
	=; b=OmzOQpgOnKeqq7byHiyz3/+vwNBYLgBS4DiWRxmSjJt8B4+O7lvdIzxt9Ye
	9NNHZVCkO9eoFR/cxujTEF37s1QQqS8fV7gzkkvgTZ9C0uKvaR6gczIil7F8j9WF
	SDVeGjKnij+osnGr0iU/CvpKc0MxMt9POE1qKKS8QeZywbSWNZr8SjczepS4eV7a
	xySlcGzAZpMOObAflUZcs5h7wbyoF5Cni5eulvZ7v+/dO0voPOB54U/DuLEhx2xI
	+xUVnUgFMZ2HUk1NEo6fq5S3oiGZMkgRI7vzhPe1TubLE9c2PLehoFCJcrdTMtlE
	1hQ1D/9Um5x5ZIxo2FKj9SlkAHA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4780gbf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 02:04:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42R24TRx012225
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 02:04:29 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 19:04:29 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 26 Mar 2024 19:04:18 -0700
Subject: [PATCH v2 1/6] arm64: dts: qcom: sc7280: Enable MDP turbo mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240326-rb3gen2-dp-connector-v2-1-a9f1bc32ecaf@quicinc.com>
References: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
In-Reply-To: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
To: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711505069; l=1047;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=PH3agPVcu0oRlNkvdU1AcR2OvLC0h7VlusCgUGbWUQk=;
 b=MgIUmDhiEgicryNajAoVbvLkS3dRSe/Q056wfsQ24Zn4H4nreljRKaUFie14TnsrHmHfB6eq/
 ppq+RWJQbCqBekN+Tp+yHb6ouIOxV2wmMEQKBzmha2HPMNlk3HpEzex
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6GMQsUpAR1sNcUkqroR15R5iYDhCwiKC
X-Proofpoint-GUID: 6GMQsUpAR1sNcUkqroR15R5iYDhCwiKC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=917
 bulkscore=0 mlxscore=0 phishscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270012

The max frequency listed in the DPU opp-table is 506MHz, this is not
sufficient to drive a 4k@60 display, resulting in constant underrun.

Add the missing MDP_CLK turbo frequency of 608MHz to the opp-table to
fix this.

Acked-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 41f51d326111..261d2d431faa 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4458,6 +4458,11 @@ opp-506666667 {
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


