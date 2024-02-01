Return-Path: <linux-kernel+bounces-48822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8123C84620F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207181F257BE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59B13C697;
	Thu,  1 Feb 2024 20:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bF8JdN0P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C02633986;
	Thu,  1 Feb 2024 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820312; cv=none; b=TFHfP0PGT7KrSmSMAse0+5hasd7v8y44RKjWhZAvFWVaHkM/rUZ1/Y5E4VTpa3f/2Yay85/7PJMEsm7SkGq0tPa2AfKWHiEZbfsrE//eY0XjAc9qb8JvxoPgSxAeWCHKk3HqcdvoZXbapBb2R19pFJJu6pxA2UPchP9FUR6d7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820312; c=relaxed/simple;
	bh=zjg0tL6yCLbc2rRzLT+uwGDLjq+uuaZ5ZdvG93T83L0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fC7feejvN02MFBc9foPLqHvT8fKbH0ZfTPzNxs1GWhnlkn9SAcN1tfrmVjOVSFq5KQ1h902tlFPd/0feMgLnaxgvRfzGt9lpE/1L+49OiG0ZbFbuyRtcyiJvm0iVT80xJlkKNKqAatwYtThd0zOkROrrALGB3ejy32i5j3k5UiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bF8JdN0P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411KGbdw003936;
	Thu, 1 Feb 2024 20:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=ojMfxQG
	tQ2aJRuCarRcAYSie2bs/aBwnKufD4xOLV9A=; b=bF8JdN0PFaopd95u2MlLh9H
	JhJdX18xLwlndkMOcWnhBH593qC7+wY08N80MOZIckL21tgtpBeOL+2FAjjRkDRu
	XDmzTkJA3oQmk/IHdgIDbNQX3NrdOCg+8ZGK7MZB2Q4nmr53unxY+cyrpVYE4j8o
	oUFz5rU866myZo++/92NJ5UOlqfyrdSY5MfW16e6i0DeJJX4SGmLFQLog+SKrXlt
	2Dy7BotPS+c/5rX9s8dzV9yjUcOIrOYOFKo7tQSzPE9PXofGQSK8cfvPt/OGB92u
	VrUjhWEAtTbuVvLMnw2AYu88fj0qZPpuDN+UDBh86KnDlTdZrAQqaYmGwD0JFXg=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0dksruar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 20:45:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411Kj5NV000493
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 20:45:05 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 12:45:05 -0800
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
CC: <konrad.dybcio@linaro.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        "Anjelique
 Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH 0/2] Add QCOM PBS driver
Date: Thu, 1 Feb 2024 12:44:20 -0800
Message-ID: <20240201204421.16992-2-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZdCwAAefo0BZ_UjHeA0pItGe61b_QAMh
X-Proofpoint-ORIG-GUID: ZdCwAAefo0BZ_UjHeA0pItGe61b_QAMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=699 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010160

Add the Qualcomm PBS (Programmable Boot Sequencer) driver. The QCOM PBS
driver supports configuring software PBS trigger events through PBS RAM
on Qualcomm Technologies, Inc (QTI) PMICs. 

QCOM PBS driver is needed to support LUT PPG. This is a new series to
separate PBS patches from the applied LUT PPG patch. Original comments
can be found here: 
https://lore.kernel.org/all/20231221185838.28440-1-quic_amelende@quicinc.com/T/#m7ab7af4c59c6e1019721d01cb3696cb5ed708bda


Anjelique Melendez (2):
  dt-bindings: soc: qcom: Add qcom,pbs bindings
  soc: qcom: add QCOM PBS driver

 .../bindings/soc/qcom/qcom,pbs.yaml           |  46 ++++
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/qcom-pbs.c                   | 236 ++++++++++++++++++
 include/linux/soc/qcom/qcom-pbs.h             |  30 +++
 5 files changed, 322 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pbs.yaml
 create mode 100644 drivers/soc/qcom/qcom-pbs.c
 create mode 100644 include/linux/soc/qcom/qcom-pbs.h

-- 
2.41.0


