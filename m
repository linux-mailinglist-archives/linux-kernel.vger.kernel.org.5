Return-Path: <linux-kernel+bounces-36310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA444839F31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E1F286742
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFB646BF;
	Wed, 24 Jan 2024 02:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D7j5D5XD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D824402;
	Wed, 24 Jan 2024 02:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063620; cv=none; b=GqHOU52vhvXdwKZ44kvyQ2OEpl3qj+dnbHED6vczKX+oqJbH8kNoF/LdnBBH8LW1h1syHVWFmWtJd1bQl8E5+Zvq/2I4UAyufAGVshr2PYzWDTfMjpFvMJyliIQoNnweQOf9MMoKEl6TI1i8P8NniKhs0P9oMBL8efSYMZIqjo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063620; c=relaxed/simple;
	bh=FL+pr4dyrSEYYZj9+gnRMdPMX6n5TMwj+txbGf5lE3k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cfUN1TeK0z+0nzC2lXwuYMQbSvmZIS3WBtasPvMHptZHVe00B05edCvb2uxPIxHxB6+x9TSvMZlUeJiJzwWOUeIuv0uKwIWe2Sy9ZKmE2MBwAUHhd3cILY0+EYh+rVJzXeOiY7RzV7WTAAJITNMwVEv3oSzpdAcbqSXhfQyym8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D7j5D5XD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O0UEln027872;
	Wed, 24 Jan 2024 02:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=aphJM1OrJDGrU1DnpiZruNE4xg1uwTRC5GcBTmn2ics=; b=D7
	j5D5XDfF4EphNhepoVoyF770hUDe8mF4pJu4sjpHqOpdvYHHd4OKvw2seVONMwIC
	+xjg0goZJTpXHMQrVfN1m62dWdA4WxPU8L0MoMMttwWn4pLUXwZRbniY3M2ANLoR
	uB2RJ8D/vfXpoS5aHr8xImsQVwq/4or6cRJNUFo+kmWyU6o6iktH2bs2OekxutcF
	AgLD0oxDML6r2w030ZHwF6SgmzmWdIZRhdNJsbgfdXEkzVc3CWUWUBpIWxMHVgYr
	sT34gfxMvp4txQS0O+wa47/ER7gfK4qHlNwZ/cqI6WmffImqRY2NBtHl6Y2vA98a
	CmsKovJjYfULnvWj+gEQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmhrgjm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:33:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O2XYJs011207
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:33:34 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 18:33:28 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 0/2] dt-bindings: pinctrl: qcom: update SM4450 pinctrl
Date: Wed, 24 Jan 2024 10:33:03 +0800
Message-ID: <20240124023305.15755-1-quic_tengfan@quicinc.com>
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
X-Proofpoint-GUID: Fgf2iqPYXS4AYbjbYEOdY6RkATjjAogC
X-Proofpoint-ORIG-GUID: Fgf2iqPYXS4AYbjbYEOdY6RkATjjAogC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1011 impostorscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=681 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240018

Fix the wrong compatible name and consolidate functions in SM4450
pinctrl dt-bindings document.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---

Tengfei Fan (2):
  dt-bindings: pinctrl: qcom: modify the wrong compatible name
  dt-bindings: pinctrl: qcom: consolidate functions

 .../bindings/pinctrl/qcom,sm4450-tlmm.yaml    | 53 +++++++------------
 1 file changed, 18 insertions(+), 35 deletions(-)


base-commit: 774551425799cb5bbac94e1768fd69eec4f78dd4
-- 
2.17.1


