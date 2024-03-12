Return-Path: <linux-kernel+bounces-99785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25689878D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9731C21C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093F7945A;
	Tue, 12 Mar 2024 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pmFvsPsI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1350BA39;
	Tue, 12 Mar 2024 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710212385; cv=none; b=Of6Mof1zshWBuWbFWV1G6KM9RCrYt2bKX+NB/MN8zh+03ZFKs+eqAKga/UHrF5z8jNp/ct3KPjVoEiBXtYeG2YA7SF3R6vvfmCoiVb6KmOo0/SbG99l/V1Hg7jP9VB1j3lIl7Fk8ppNG83cnZ33CtD5lsWHkYkFR2csdhfoIROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710212385; c=relaxed/simple;
	bh=jCdBNatzGEdZ2CfTazqC7lWaSN8WBO9A2pZTJlA6Cgw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a2khZ6Hf1MrBq2bsLAZY0ij0KVkbCduQeIPPDeMj1iyviidZ1cLKgAai4RRwCzyYDHMQ0W034ByxucAmLIImCInwy8tWo7yf6KGWQxMlKptDM+PQ8qY1gg9GMpvcVEknAs9LVo2vb+xFOW8K6bnPQ4YzgD+C/XNwQeSFAgSyNAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pmFvsPsI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C2IuPR004529;
	Tue, 12 Mar 2024 02:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=jtKpQuokls/6ATw0gnJnkxEntL0Z3Hy3xmSu/hjvtqM=; b=pm
	FvsPsIZ/jl1X+GSICPsldV5KT1UkoT0+XX1qzS67SubXY9G/pM/nVkM1jJdawwAL
	GVOmBz3RIKmNohZcHaqbUgtE7fjnhgohYkpRmtG+/I1GNmMGqzB9nmlxB4J5HRs6
	ZYUcUN4VbKabJaAKZuV2gQ/V7kxloXifci9C0ExahA9IfKmlQwwm6KoxtPfgK+nO
	O4t9twV3cjKOkpg+Y0rpPKoGAmUtr2cv20q5awgxd5gSPeE+AWkbcmYyQbKsvflu
	+8ugfn7J+wQBq6/kD7hrtZ4hmV0I9dMYoymu2Kn5OMvJhVvgex9OwXp0Ra5FwAc2
	IELUMqbiG2b1XMu9ZROQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wte5d01rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 02:59:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C2xd09028977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 02:59:39 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Mar 2024 19:59:33 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v3 0/2] update SM4450 pinctrl document
Date: Tue, 12 Mar 2024 10:58:05 +0800
Message-ID: <20240312025807.26075-1-quic_tengfan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: IMHCGhf4FCpzxA6osyvFgY1vHman8jHb
X-Proofpoint-GUID: IMHCGhf4FCpzxA6osyvFgY1vHman8jHb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_02,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 mlxlogscore=787
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120022

Update compatible name, consolidate or remove functions to match with
SM4450 driver.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---

v2 -> v3:
   - update patche commit message for [PATCH v3 2/2]
   - consolidate or remove some functions for match with SM4450 pinctrl
     driver

v1 -> v2:
  - update patches commit message
  - Remove excess Spaces

previous discussion here:
[1] v2: https://lore.kernel.org/linux-arm-msm/20240129092512.23602-1-quic_tengfan@quicinc.com/
[2] v1: https://lore.kernel.org/linux-arm-msm/20240124023305.15755-1-quic_tengfan@quicinc.com/

Tengfei Fan (2):
  dt-bindings: pinctrl: qcom: update compatible name for match with
    driver
  dt-bindings: pinctrl: qcom: update functions to match with driver

 .../bindings/pinctrl/qcom,sm4450-tlmm.yaml    | 54 +++++++------------
 1 file changed, 19 insertions(+), 35 deletions(-)


base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.17.1


