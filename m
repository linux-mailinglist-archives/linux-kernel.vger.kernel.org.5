Return-Path: <linux-kernel+bounces-43140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7B8840C39
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256521C2153D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4AD15956C;
	Mon, 29 Jan 2024 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="frwD34HY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C8158D98;
	Mon, 29 Jan 2024 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546885; cv=none; b=OEpOrksHQ3puVBylVnivYeoVZ769rCPQEOysNRO4TV7PAzXWV3nILWzrqnqYxtYqnShsS8bMK3jgV1izHO0SouPTr2kXuh6WyejUKfVQSKJVaK/irXhmjJZ+W3+AcgM/7n//WQxCigXNGLcksZDYVQgQCyW7Oxdb2VXlQSVuyMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546885; c=relaxed/simple;
	bh=zMf4yKdogGXJoeObaueH6qXynndYIX55PcDoMto1YCA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=mEkjXyEZ0y1Xi86An6ssQslim5JvMOBlD1bxhmQnHgtE2ZuAdgo3Bt6AeU9yqVXu+B/C5ecEYu/G8NAcX8e6TuXY17xEYRIXFxViq5PuRTWLO67XNtshi3kdtixjXEMO2r0W0UgoZQiW+SU6UP9R1Hk6vVFpRhXI7XVZpbRzvNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=frwD34HY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40TFHYUK024662;
	Mon, 29 Jan 2024 16:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=CM0YBaqMELRYsB
	aLS7k7vp9OYdBpKgjsI+yfycdpzVU=; b=frwD34HYa8I/p1qyB1P11von+fIlwc
	OgZHANMnxyTWtNQVbhGAWySFBSMQJeyYExHUHsFSXQPS3iHvVB3lXTH3YTuAcHql
	p/4kRhjvs7rBhW9PIRMsXKzbop5BY86jc6jUcK0frMvmnKBP6P+9lPQalvt21zrf
	tp/uVdISJ+x3hn4gSkUq1SrdeZVfQL0MqoQJT9oR2AASYIaBWt+BP8oIEUUCTICa
	We8+7uYF7Yose7xVI710B8OR1DcZ31ywgD72Er9CzZDwsZPA96kEU6tnaE5kjV2d
	al1rEjdRSQkwTATtCH56aDjBqCC3WCydC0DUQjdgsenQEXlYNnuLlxMw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx3t2htw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 16:47:49 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40TGllru030126
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 16:47:47 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 08:47:47 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH v3 0/2] arm64: dts: qcom: sc8280xp-x13s: Enable touchscreen
Date: Mon, 29 Jan 2024 08:47:46 -0800
Message-ID: <20240129-x13s-touchscreen-v3-0-c4a933034145@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALLWt2UC/33NTQ6CMBCG4auYrq3pH1pceQ/jAoepzMJWW2gwh
 LtbWGliXL5fMs9MLGEkTOy4mVjETImCL6G3GwZd42/IqS3NlFBGSFXxUerE+zBAlyAiem5s2Z3
 ToAyycvaI6GhcyfOldEepD/G1fshyWf9gWXLBm6sFa1WLrobTcyAgDzsId7ZwWX0S+x+EKkSlD
 wYAapSi/SbmeX4DCo+JqPUAAAA=
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina
	<jikos@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706546867; l=1152;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=zMf4yKdogGXJoeObaueH6qXynndYIX55PcDoMto1YCA=;
 b=yME28zc6Zi3HsN3CIqYjgb5tmH4aF23nz1xArUUgY+Wxupp3MLpQV6FnSFvh+GHNVup27jxtF
 zgf5yAouabbC2PebREkF7DQPmxSPZ6HTNGucBrMpSnJvzmhpqMNdZXm
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sIwXUeHzU4eV6rMt8hzr8PW5PYGBgAyU
X-Proofpoint-GUID: sIwXUeHzU4eV6rMt8hzr8PW5PYGBgAyU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_10,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxlogscore=819 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290124

This documents and defines the necessary properties for the I2C
HID-based touchscreen found in some SKUs of the Lenovo Thinkpad X13s to
work.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Changes in v3:
- Rewrote the commit message, to properly describe the problem being
  resolved.
- Link to v2: https://lore.kernel.org/r/20240126-x13s-touchscreen-v2-0-5374ccc9e10d@quicinc.com

Changes in v2:
- Dropped output-high from &ts0_default, to avoid bouncing the reset
  line unnecessarily
- Link to v1: https://lore.kernel.org/r/20240125-x13s-touchscreen-v1-0-ab8c882def9c@quicinc.com

---
Bjorn Andersson (2):
      dt-bindings: HID: i2c-hid: Document reset-related properties
      arm64: dts: qcom: sc8280xp-x13s: Fix/enable touchscreen

 Documentation/devicetree/bindings/input/hid-over-i2c.yaml  | 6 ++++++
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 7 +++++--
 2 files changed, 11 insertions(+), 2 deletions(-)
---
base-commit: 8bf1262c53f50fa91fe15d01e5ef5629db55313c
change-id: 20240125-x13s-touchscreen-48012ff3c24e

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


