Return-Path: <linux-kernel+bounces-93879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECFE873642
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B09F28AB5F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536BB80049;
	Wed,  6 Mar 2024 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OLVWpRZ9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC67605DC;
	Wed,  6 Mar 2024 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728012; cv=none; b=WaVROVr6HVds/P4/clWAfwO1FpPj32ua8h19z56Jsqx9HwYUPAaxXxkkHq+dxj6XzRR/jabjHe2WStf6dN3TOateLiXUD+49Msa4+LbYn4Cg2N++tzC0RH+CZH+ODeVfjNyZyvD+a2SOLdPlBLzZpl0C5P0L1UxW2rkmuzVuDQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728012; c=relaxed/simple;
	bh=c86ZEGbT6ZU6Z39dOgBxdZmzp3F1p3SoRnmfSFzl24Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZdxiLu+Ivws2yiTam2JlNw2UPfy1WWkh5K2KDFJ4dxc3wa3Ov6XKx19nN4a+Xx7aFNdYZx09iOxEMGtwrqI28iAYScG71Ks1Bpv/nt7eJPZmGkLmINl+MWyxTvdyiLEXNe+RB7AxMVnbehyklQLgUxrZYBuUVUUa18YFANiHwMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OLVWpRZ9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4266TGuc015150;
	Wed, 6 Mar 2024 12:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=WlzpenKnUYk6IrrhvbBlI0xOgW/za7on8QxUC8/k9pE=; b=OL
	VWpRZ9oE0OBXwlfltr8NQGD/gtMKNjMeoWmZ8W+luqScNX6lEH1iqpOuFU0TigyC
	lLKraj7WsAFyxrZetBYv1A5aTVbzjnMHoihy78w2GMYh4S/Vtgo3Tdy2b6146CjP
	RgzM1tEsbpEhPPDjKaYEITa8KdHYPNHEHlWa6zKDmHekrbhugnQZCYV/fALNIjG9
	ixMh+0CQSRhOoLfv7lXkHGCStrzdD2qOoevmCWVLO8EzGD+mAWbr98k3NjKMccHr
	fkkR1a/M/1x5bFJDA4NggPql5krUEBR+bP4IIzD30alXB+eCVxeY+dUvUZzS5x/Z
	12VNNYLBLlAlppffrcFA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpbav1m5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 12:26:46 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426CQj7b014748
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 12:26:45 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Mar 2024 04:26:43 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH 0/3] Add eFuse region for Qualcomm SoCs
Date: Wed, 6 Mar 2024 17:56:32 +0530
Message-ID: <1709727995-19821-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
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
X-Proofpoint-GUID: R0hc1XmWrZXJu2hflbxz1WkfdsVob4DB
X-Proofpoint-ORIG-GUID: R0hc1XmWrZXJu2hflbxz1WkfdsVob4DB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_07,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=399 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060099

This series is dependent on [1] for binding.

[1]
https://lore.kernel.org/lkml/1709662869-10569-1-git-send-email-quic_mojha@quicinc.com/

Mukesh Ojha (3):
  arm64: dts: qcom: sm8450: Add qfprom node
  arm64: dts: qcom: sm8550: Add qfprom node
  arm64: dts: qcom: sm8650: Add qfprom node

 arch/arm64/boot/dts/qcom/sm8450.dtsi | 7 +++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 7 +++++++
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 7 +++++++
 3 files changed, 21 insertions(+)

-- 
2.7.4


