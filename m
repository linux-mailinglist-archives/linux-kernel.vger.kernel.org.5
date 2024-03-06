Return-Path: <linux-kernel+bounces-93880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF067873645
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF271C23600
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EBA8004B;
	Wed,  6 Mar 2024 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KPnrjgLH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DEB80025;
	Wed,  6 Mar 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728022; cv=none; b=WrxCJU4wY+RkZ+M8pJ6UvxM/VUhaKZDhBsYan6zvUvVfuwd4Cw0tSjAI5+8sbHBTcG9k5g3t+AgD6/AuDtEwtOVQCzsHB0GzOVvOU7/Bjpts/kgxXH+AOGebb2NZZ/1tmzK4xyOibNfi3Aj8VGA3zqkQlsNRrUyXCeyNMnGKxZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728022; c=relaxed/simple;
	bh=MJxp1yRgYHEXhuVRnk5MPvJkOv91gGfGP/QIhQ6nDBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lh3np1NMAIaP6o5uvtK9ZTpczNUZwk0rNn74ItI0+pJucIevzXKeL4TZTJFiArtrBZBeF5LdaPbTsFJ9+qVvKmiJb8uIzc3D/JISq9vjSiJnAF45zZS94h05YC/MHlr42XynSOp/rSTUBFboWL9Lp6senyYkcuJW1e/we3N5tWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KPnrjgLH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426BcTWv019444;
	Wed, 6 Mar 2024 12:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=detI0Zz7sQSGy2bIdqMU
	iEk6pKc4wJaoEiEy7vPs2t8=; b=KPnrjgLH8ZduNcTKdQbt1MRtrQpkBlwT3DD4
	X2Sp3Yu12D9sF1mRZ8u0TmNYdF76Wud40Fiq6MwLOC9l29VdUzAeZe81pQxSZqw9
	S2GSUfrh/3VTLbUAZOcnJiDfoCpRWWS3FcMDJMQSztr8UXuc3hazgX/wp5rkMNzM
	Enapk6kCnS2SfIJOSerkZAZjxZJhQm/No/2Mngd7L62e0xrHdoFE1psn88CHDVhA
	jWtGUx4dv0rfBKa2/4kXRLnJ3rVkQ26kXDjyt2GWaRkx2RDxBQftheudzMo8V2fO
	EHJqO0QJWrz9ihMnvtGtpOwzOSncTKSBJRHd5/YpTzRPDeJYgw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpktprman-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 12:26:54 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426CQrO7007002
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 12:26:53 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Mar 2024 04:26:50 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH 2/3] arm64: dts: qcom: sm8550: Add qfprom node
Date: Wed, 6 Mar 2024 17:56:34 +0530
Message-ID: <1709727995-19821-3-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1709727995-19821-1-git-send-email-quic_mojha@quicinc.com>
References: <1709727995-19821-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xw8KNn3WxNK0_rLC2i1b462o2po1-Kt3
X-Proofpoint-ORIG-GUID: xw8KNn3WxNK0_rLC2i1b462o2po1-Kt3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_07,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxlogscore=779 mlxscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060099

Add the qfprom node for sm8550 SoC

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 7474cddf7ad3..42130406342d 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -4164,6 +4164,13 @@
 			#clock-cells = <1>;
 		};
 
+		qfprom: efuse@221c8000 {
+			compatible = "qcom,sm8550-qfprom", "qcom,qfprom";
+			reg = <0 0x221c8000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		pmu@24091000 {
 			compatible = "qcom,sm8550-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
 			reg = <0 0x24091000 0 0x1000>;
-- 
2.7.4


