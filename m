Return-Path: <linux-kernel+bounces-47559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA59D844F69
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743D61F2237A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40433B793;
	Thu,  1 Feb 2024 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pnoNZ5E5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BFF39FD8;
	Thu,  1 Feb 2024 03:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706756870; cv=none; b=TIfQFSzds1QgbC7Rky3Xeu2pkyelTI2iReWje9jAaN9ircpmUMSXM1+VKg1rGsHu4MHuFerT9x+eVXKH9gEOt6SfFxWLxnfT0u/ybp2mCmNRqBnSv7UTPN/bfptltkr0fUgKLVgTy7tDU08XwszzgB0KQOU1bHqd76w+2A+aOxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706756870; c=relaxed/simple;
	bh=sRNwMVnqiPST18DQ+4Nf5qjr6s72kIiHbnqk/kOu/nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GSMMBrP96bjnfikoicBcElmFHCDJ+iexLiy1v+Qigp200Kna35wA/VYREBqJ8wIwDMZW+7eqhtgK8TTCVXKVtZa+Bve7hNXBx9s84M0Sl3BEYFVAC3wYrrcVxX3D9a5ntk4FWtVUrCv5BzE1rmUuEmP52RliekLc+EpwJYzxMcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pnoNZ5E5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4111spBD019439;
	Thu, 1 Feb 2024 03:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=ApiIP2dVAKuSXIV6ecbV5vVRcAz+r4l+ETQRV6c+EUI
	=; b=pnoNZ5E5+UPm+B+NQILcHcihKnXY5JqPP82nq0R6tu8oCv7uby6trKGQ4Vp
	bDsrs06krr+7tg4TpAUG+80jGZ4iGG+EgtgZ8CdVkLKP5lteZEmovNTdZYaCFqkv
	kWkAJOAyKE2H4fVXtELKE31+argCLCvzyey26MB5J3UcSxIaPpWZyesENY0HSW3E
	Vy/DrMaLqaND7d67vyo9nDon1UeVCMZWPem7Xm+ajXf+sKvcH6hey0wQtiXzkFeA
	bWjFRmwufvIvnYLfyHUhfDrhezWNIwz7UHfOZxXURHxJQgv5B7xAUd9Ige/k0x6H
	TixbE752qtTgiudGomjOch38V9Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyq0dsv9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 03:07:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41137bT5013918
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 03:07:37 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 19:07:37 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Wed, 31 Jan 2024 19:07:26 -0800
Subject: [PATCH v4 1/3] dt-bindings: HID: i2c-hid: Document reset-related
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240131-x13s-touchscreen-v4-1-39c0f9925d3c@quicinc.com>
References: <20240131-x13s-touchscreen-v4-0-39c0f9925d3c@quicinc.com>
In-Reply-To: <20240131-x13s-touchscreen-v4-0-39c0f9925d3c@quicinc.com>
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
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706756856; l=1349;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=sRNwMVnqiPST18DQ+4Nf5qjr6s72kIiHbnqk/kOu/nw=;
 b=CcBTReLiI2/FG9b2iwv2WsiymZ/p7Fx0kja24y+LakWmXEILz9d0CZqwYmsAk6W6BSz2QZjFL
 CI4pyuGjl+mBN/iNpsVfOe7X2ZWUakiOvj8PQz0u4OSXW2KdR18z4fV
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eTKa0U78fPLNcBaqxtgGIc_IBIx_JYQN
X-Proofpoint-ORIG-GUID: eTKa0U78fPLNcBaqxtgGIc_IBIx_JYQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2402010023

Some I2C HID devices has a reset pin and requires that some specified
time elapses after this reset pin is deasserted, before communication
with the device is attempted.

The Linux implementation is looking for these in the "reset-gpios" and
"post-reset-deassert-delay-ms" properties already, so use these property
names.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 Documentation/devicetree/bindings/input/hid-over-i2c.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.yaml b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
index 138caad96a29..f07ff4cb3d26 100644
--- a/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
+++ b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
@@ -50,6 +50,12 @@ properties:
     description: Time required by the device after enabling its regulators
       or powering it on, before it is ready for communication.
 
+  post-reset-deassert-delay-ms:
+    description: Time required by the device after reset has been deasserted,
+      before it is ready for communication.
+
+  reset-gpios: true
+
   touchscreen-inverted-x: true
 
   touchscreen-inverted-y: true

-- 
2.25.1


