Return-Path: <linux-kernel+bounces-107596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7107087FEEE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A292E1C228D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA1880616;
	Tue, 19 Mar 2024 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cpa/qaVr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0EA3FBB9;
	Tue, 19 Mar 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855351; cv=none; b=p7MevtTSR+/scyvFHmodHjtivIZw2IKO3Go1YaaZNPHtqD+JhQ5oelCIP3eVkMm3kZiEYjXSBUWclFPUj3efDvZKa4eN+p1Qzyvf+LG1PgEfVja/lhv/hjjp+AKvV1f9yGOSCXqNp5Gbn6hns/efAF4BMU2gvZzD0SLhGa92Iv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855351; c=relaxed/simple;
	bh=WUInyl/jD2mssJJeqfCfavJZ6jHxUaoYbXOk6ZYrnrY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B1fphEKpQpit7ZJMPCfnxmgdoL+An6utKG7hHgZ5HrSpn6v1S0rcJkkSQrVEsONjSClZmVHuogqyJIFagOKOrTga4/287WdEez3JAo1yrctCekuDPoHHTKOzVr06FHJpLOIpUO92LRGhl/UCI9bwAunR+X0eIFFkqPqwqE7tOJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cpa/qaVr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JBc44H019578;
	Tue, 19 Mar 2024 13:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=3RVbbLQH3qedt1uny8kNh/EGzyenVrTTNlpoD4Ex0ek=; b=cp
	a/qaVrG03ptUqSb2DPFOsBAepVqLe7ij3hi6LaI4QVbeZtuvVTF6AwlN7rGtyTUG
	4i9xFBn/jkfFl4MovuQaWEVBG5pz0yOdK7I+y9iJ0jnYAdwgye+cr/PlPGKIAXq1
	9O/t2kbTjq5e9TaF0wMpyvSPbjZ5V+11dAxOaZN8LqBxsA/N80bDXDGraexxsR0/
	fg7qBr/D9ZEt4rR1rw9O8B5OqqPAgYFZHkiIMUWnRnF4Drfyy0GA3ctZlau1U99S
	XWO/U0UC9Cstsqk8RUUHZH8AphvBRGrN15eaVfVjkpYne1C0BDumMKDqViaF1mvb
	g+TBnVLbSGQuEFVUtlBQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy9ee8c0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 13:35:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JDZeII015042
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 13:35:40 GMT
Received: from hu-ugoswami-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 06:35:37 -0700
From: Udipto Goswami <quic_ugoswami@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Udipto Goswami <quic_ugoswami@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: sm8450: Update SNPS Phy parameters for QRD platform
Date: Tue, 19 Mar 2024 19:05:27 +0530
Message-ID: <20240319133527.25025-1-quic_ugoswami@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iX2XaXD22LLxKBIe7wk3P90KuVSvJoKQ
X-Proofpoint-ORIG-GUID: iX2XaXD22LLxKBIe7wk3P90KuVSvJoKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_03,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=765 bulkscore=0
 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190104

Update SNPS Phy tuning parameters for sm8450 QRD platform to fix
electrical compliance failures.

Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
index c7d05945aa51..7b62ead68e77 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -467,6 +467,14 @@
 	vdda-pll-supply = <&vreg_l5b_0p88>;
 	vdda18-supply = <&vreg_l1c_1p8>;
 	vdda33-supply = <&vreg_l2b_3p07>;
+	qcom,squelch-detector-bp = <(-2090)>;
+	qcom,hs-disconnect-bp = <1743>;
+	qcom,pre-emphasis-amplitude-bp = <40000>;
+	qcom,pre-emphasis-duration-bp = <20000>;
+	qcom,hs-amplitude-bp = <2000>;
+	qcom,hs-output-impedance-micro-ohms = <2600000>;
+	qcom,hs-crossover-voltage-microvolt = <(-31000)>;
+	qcom,hs-rise-fall-time-bp = <(-4100)>;
 };
 
 &usb_1_qmpphy {
-- 
2.17.1


