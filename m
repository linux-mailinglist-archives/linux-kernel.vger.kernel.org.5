Return-Path: <linux-kernel+bounces-40362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD3083DF03
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7FD1F25A24
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246A01EA8D;
	Fri, 26 Jan 2024 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OZsNkRYG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD781DFD8;
	Fri, 26 Jan 2024 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287313; cv=none; b=SGGAaOwPQ6cDoNntrK2iqRRtPpmeZxoyZ/+lNUVixoc3ISHl1L02v4AD8nvhw0q9UAZbAlDfINsPsXIETM6qjCgOvVYMSL8XxIxSpqFhl3XCADZVOzNysagTEcT4dxDFSChQu6fu14/uLHRd9tnBTQInixjPoqvj8j996BgYCCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287313; c=relaxed/simple;
	bh=TTMMcaKwbtVMWjq2FvU5baWtMNXCodc6+U2gPgL4xKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=t8jGt4oXlSWU6uKTFxaUbYW+qV1o8bKmKddGfX+RKSfj9LaBEgADzrCqP0H/g2p2yjSpeKsJmmY62WvvOsWkduxEvUFKGygfcdDw82kH5/62wDHUVvORQJtM6vWVX9zzNGjpg8FY1vecbmhaN5pW4kBYbJH3Hk1AIT3mjjZkTzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OZsNkRYG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QGMoia019863;
	Fri, 26 Jan 2024 16:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=G1FEGn3O/VBptqGwJi6KCObyTHs9nhdvsW5xpkdLjlc
	=; b=OZsNkRYGex6DscoehRbZbhkJN+pEXAlQ5+61lS3+WNgNKDt1m+xTSGGaPNx
	dKKRlrGzQV8BCQPtdRqE0d+KQa6+bfoT81WGis+8Wbhf0+s7ALTyx7aJt64luEfX
	AGKDYkSJWB+rjBZ4LGaTad1zYzFtujFNDDGN1vXm9r9NRKTgwgdhTXlzBeVKCdXn
	CYzIXSjKIlLawkxy9HIFlWVBwhG9jnKxOMDrzdnknG6lJtgi64SpmGVsocSfXGXX
	hjNEsa/I5uBKMb/2EVarK7mtGOYsPRCIA0hUAi3Xe4ceToZp9reQIoVdvLmi4xTQ
	FiXc0EBSwKP63Ec8DhIR3CbI/Gw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv4casmf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 16:41:42 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QGff8U027458
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 16:41:41 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 08:41:40 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Fri, 26 Jan 2024 08:41:38 -0800
Subject: [PATCH v2 1/2] dt-bindings: HID: i2c-hid: Document reset-related
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240126-x13s-touchscreen-v2-1-5374ccc9e10d@quicinc.com>
References: <20240126-x13s-touchscreen-v2-0-5374ccc9e10d@quicinc.com>
In-Reply-To: <20240126-x13s-touchscreen-v2-0-5374ccc9e10d@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706287300; l=1255;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=TTMMcaKwbtVMWjq2FvU5baWtMNXCodc6+U2gPgL4xKE=;
 b=XjVsszoTJAZdc5gBdXDriFtFKdcPpJvmABvBQVLmB/Xh5B5tn5Du1mOmRJSqe2qvDHSClnKnH
 67Y136a56eLCWyPZJNZvuFAJpXpA01hGG5H/9FDy8PrpRtn3bQZ2gds
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5k1kVPu0KJSDlyv4oHEIQzWfVZWZKgxI
X-Proofpoint-GUID: 5k1kVPu0KJSDlyv4oHEIQzWfVZWZKgxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260123

Some I2C HID devices has a reset pin and requires that some specified
time elapses after this reset pin is deasserted, before communication
with the device is attempted.

The Linux implementation is looking for these in the "reset-gpios" and
"post-reset-deassert-delay-ms" properties already, so use these property
names.

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


