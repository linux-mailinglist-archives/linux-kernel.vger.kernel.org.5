Return-Path: <linux-kernel+bounces-39575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3858F83D319
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5AD28C18B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F8EB658;
	Fri, 26 Jan 2024 03:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JD3R4M7j"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B61BE4C;
	Fri, 26 Jan 2024 03:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241331; cv=none; b=Yw6uY8bMjP97C2Yeox4+FDYYDZ7J1cjjcYIS+KKS38bDsxSF6H9fRFFUhAfHrxkEUfyDebVvmcaZmsD2EHLBZEwPFUxAhfnRTjqTppDTHy/FxoC8qnvy8sOoDYk1haWzkHVWFUTxJUgBJVmU0UY5Mvp7Om6xxbKteuk0LAham/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241331; c=relaxed/simple;
	bh=KrhrQ0tvNVJ+4cAK8q+wOOdb/RYDdrZuBoVCellyfZg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=SK73aKkJlvjCL0Hx68OS2gzAO/wydxTcQI9n9LBnvVXvHAS6B2Lp9q9WROiK1aH8e2Ng/D/AH/h1qIE5vyrVf3w7KocOtBtk9bL56wCbztw5aoH4Wg8M69G0RH4AKUA1gvZkTr44BH/jjb2iWYul+k7Ne6O77c5xmKTTyspXMZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JD3R4M7j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40Q3a5ra022681;
	Fri, 26 Jan 2024 03:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=Q9PEpT5d0K89jY
	+OAqVxi28NZMVH5s03aNK1+117VZ4=; b=JD3R4M7jVnYUQ0SJ56WCIGj9SFKXJc
	UwxqWhs+0hnBVPHGdFnKInsaB6rdqbeCjiKz67Xpzrhu/yKShrhom6pQ76ieKU+3
	edocyhNcbJEqI8mPLxfM20fAh0r+4jAIVpEZombCZ1dAzwLfoT+o+YOMUMq/JhnV
	p0B++cERACwLAr4Vz1958ZHg40Z4FO64eKS7zzmrhZfriPyBti1Flpzj3uym+l7T
	H4z4JmA81kDJZVhDLtyAMAWEo+2scgMwEH+NCDNK+gcXsDo02AehmHSc/UdsRUTx
	XFIbq1Vi/oJBShcvh7/F2C5orbHK8cpg0LfQQOPhOPout2MM2K8zqAhA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv1018f2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 03:55:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40Q3tHFN017841
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 03:55:17 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 19:55:16 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH 0/2] arm64: dts: qcom: sc8280xp-x13s: Enable touchscreen
Date: Thu, 25 Jan 2024 19:55:12 -0800
Message-ID: <20240125-x13s-touchscreen-v1-0-ab8c882def9c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACAts2UC/x2MywqAIBAAfyX2nOAriH4lOoStuRcNt0IQ/z3pO
 AMzFRgzIcMyVMj4ElOKHdQ4gAt7PFHQ0Rm01FYqPYmiDIs7PS6wy4hR2Ll7743TFqFnV0ZP5V+
 uW2sf2D2ow2IAAAA=
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
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706241316; l=740;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=KrhrQ0tvNVJ+4cAK8q+wOOdb/RYDdrZuBoVCellyfZg=;
 b=9+ugStnJZS5YmfVKrhUaHEkTUr4sb5UzOtiSOyv6YSrXUz8JBoQtfVjUwtw+PuGrhYTzsWGyJ
 br6vBtXx2gECfQSQMTMIuuDqSv2bbU5O0/tSGUIs9zQfJ5ipjHyKiP/
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _GXpBmOPdIDcXxn0_uDGZh6BFGBMhnr_
X-Proofpoint-GUID: _GXpBmOPdIDcXxn0_uDGZh6BFGBMhnr_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=698 adultscore=0 spamscore=0 clxscore=1011 phishscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260026

This documents and defines the necessary properties for the I2C
HID-based touchscreen found in some SKUs of the Lenovo Thinkpad X13s to
work.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Bjorn Andersson (2):
      dt-bindings: HID: i2c-hid: Document reset-related properties
      arm64: dts: qcom: sc8280xp-x13s: Fix/enable touchscreen

 Documentation/devicetree/bindings/input/hid-over-i2c.yaml  | 6 ++++++
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)
---
base-commit: 8bf1262c53f50fa91fe15d01e5ef5629db55313c
change-id: 20240125-x13s-touchscreen-48012ff3c24e

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


