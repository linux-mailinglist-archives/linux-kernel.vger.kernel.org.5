Return-Path: <linux-kernel+bounces-43138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5EB840C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC5B28393E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D1215704E;
	Mon, 29 Jan 2024 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NBGccvIq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B58A154BF0;
	Mon, 29 Jan 2024 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546882; cv=none; b=uPQBNBLiD3y4e0IClu1VLenX9mdB8q0JIS5JKpU37uVY+ZGUASs7MJWemjX9JlHzGxpXYbXt7GAJ4zP84L/Gomeq4clQYt5eEn17upAOKHuxyU8zxVo7S0zpw3b+0Ocsan2w/0YRSsHjJTJMn0ve6kqk4SbSUvgokMa2gsKN0OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546882; c=relaxed/simple;
	bh=wRxyeE1FYChaTRbmRTHXVTWt4fK4t6i35GhQJNVbcDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qQy+CqF8wiG12NaAhh4wCOvJZLZJseksxQ1WdFrRq9EUdgH3wKjui2B+BGJgJkbK2CUM1/5SFP3J/bUf+r+Cyr9BwutYoHMmZMGzuWCrKUEHljvZFV7LxxQwXDRb8Y3+/r9lc7XfDIiZX0O1Yc3nk7jxpknPxDm9nasGpRdkK2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NBGccvIq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40TFelt5022360;
	Mon, 29 Jan 2024 16:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=yWcwasbMTli/mA5DcycGXWMtS/vMlr7FR2DA8r+wqoQ
	=; b=NBGccvIqHa1D2CPJ9nLbDCk6HuQQ5Or3I/y1+VlcFHhYXNuFvceS5gYfls3
	6EsV/aAaMAALMq5ZfsaCJXnU3sGU6nEtDYtmqZN3fyUZt4pS/2wlXmnnQRnps/W2
	qhyuDpB9rhm6BWyqV/yczW+mRm97TV+yLFZijwKEGcbNlXP6gpKw9aHn+DFOr3CO
	Jl7ktzOzPERCNl7xD9PXCyqMSuJ01oKuHRxZvE0llrZukMXWmAG+ngjijtVZjak+
	UKx0LW68jgEO/wmwa4Cctk3XUAKMmI7Obm/uHiAN49dxPtvSIQ/+qvvdMAcQQZv8
	SV2aIjUXbYeWjXjrD1Jg3b4G0vw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxevdr69f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 16:47:49 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40TGlmhU016566
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 16:47:48 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 08:47:47 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Mon, 29 Jan 2024 08:47:47 -0800
Subject: [PATCH v3 1/2] dt-bindings: HID: i2c-hid: Document reset-related
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240129-x13s-touchscreen-v3-1-c4a933034145@quicinc.com>
References: <20240129-x13s-touchscreen-v3-0-c4a933034145@quicinc.com>
In-Reply-To: <20240129-x13s-touchscreen-v3-0-c4a933034145@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706546867; l=1308;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=wRxyeE1FYChaTRbmRTHXVTWt4fK4t6i35GhQJNVbcDo=;
 b=svdO0R1HjoxjFsLgFyZvHI+eiAS+FHqdn1ByUv5P6pbSbvlyV5YCR4JGXySsupsN43If2dM3C
 /d614pvcSTXDWsfaMLC35Yo+rOeaEA8VpktxXRVnEku5n4pGOw/tav2
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: szsRmFwLl5YV6uMV-5PMqidy9Y8EVTuj
X-Proofpoint-ORIG-GUID: szsRmFwLl5YV6uMV-5PMqidy9Y8EVTuj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_10,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401290124

Some I2C HID devices has a reset pin and requires that some specified
time elapses after this reset pin is deasserted, before communication
with the device is attempted.

The Linux implementation is looking for these in the "reset-gpios" and
"post-reset-deassert-delay-ms" properties already, so use these property
names.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
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


