Return-Path: <linux-kernel+bounces-41450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7380583F1F3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129251F2626F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91E85A0FE;
	Sat, 27 Jan 2024 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aJcD05gv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14F3218B;
	Sat, 27 Jan 2024 23:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706398012; cv=none; b=aFsegzHITJS1kWMjHpNeDQ7MJbf0Aab3VULfE4aHKCWVh4KHM4irEw/Gh35fl0JK6gI89SBi/C3MOpTjfkIBn/gz4FTNmj5y1nPxugP055KFq69nwdUHI56i5G8Krb4b2VHYpQq74khCEk8HxLm1VqXgPsoPCtK8j1ItPb2feRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706398012; c=relaxed/simple;
	bh=dggcWDGlnE/h/JrGhQotIsZI8RLZ/aPTvyRmoDXPyIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QH7hhXkvk1xHK0f+F7O/IVHU6btWv+GN1c2bPBeNs7ob5O9bPiOVfUtSJYskZipsyFoBp9qOZpDFIJbSx0p023YScVU7smZfeMGKa+pmnluWKlsHgj8yUxA6w2ISAs9dzdXtsP5gXWhUE6Wuf5KB8rLWJsQMMx0mumm6ofDMDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aJcD05gv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40RN1QmR020317;
	Sat, 27 Jan 2024 23:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=EVy1Whp1fEX2E6iJ0cv7YjXVOSm7Sb+8vbZjvGNLpS0=; b=aJ
	cD05gv+axsji6AWbr9dEywFZvK1Pr67fSTBAWYPsE0ZiHFQM+AjEMUV+w2S3CxDc
	gAgPM5AHhBIIkIxcnkiUg7ixA+WE/ZmHEcQNGJRWhz5rTxAKwQQP4e2VZ9U6SSJb
	QKU3FNOcTXGUE9sMk2rF3NZWq+AoHRCG059OGPBCa2ECBj476XIseHGNqa2tZi4v
	BpDt9nDck+d7EeYkLGhSn9ma3zFz/joZs8g+UIzzV77VqRwz8+xk4njSNvEcrZXZ
	kNRy0Bh+lc1Aw4ixKIYWXK+YxatJRsQxTBym+SotgDvmH28PSgNulEJe9SiT+8G8
	XZfrMSfUkYxE78ozKjyg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvu0rs1j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40RNQNFS010255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:24 GMT
Received: from hu-gaurkash-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 27 Jan 2024 15:26:20 -0800
From: Gaurav Kashyap <quic_gaurkash@quicinc.com>
To: <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <andersson@kernel.org>, <ebiggers@google.com>,
        <neil.armstrong@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <kernel@quicinc.com>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_omprsing@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <bartosz.golaszewski@linaro.org>,
        <konrad.dybcio@linaro.org>, <ulf.hansson@linaro.org>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <mani@kernel.org>,
        <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
        Gaurav Kashyap <quic_gaurkash@quicinc.com>
Subject: [PATCH v4 13/15] dt-bindings: crypto: ice: document the hwkm property
Date: Sat, 27 Jan 2024 15:14:11 -0800
Message-ID: <20240127232436.2632187-14-quic_gaurkash@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
References: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TyFuLK0k5a895ZQkLuUabwPwb5_UHJqY
X-Proofpoint-ORIG-GUID: TyFuLK0k5a895ZQkLuUabwPwb5_UHJqY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270178

When Qualcomm's Inline Crypto Engine (ICE) contains Hardware
Key Manager (HWKM), and the 'HWKM' mode is enabled, it
supports wrapped keys. However, this also requires firmware
support in Trustzone to work correctly, which may not be available
on all chipsets. In the above scenario, ICE needs to support standard
keys even though HWKM is integrated from a hardware perspective.

Introducing this property so that Hardware wrapped key support
can be enabled/disabled from software based on chipset firmware,
and not just based on hardware version.

Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/crypto/qcom,inline-crypto-engine.yaml     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
index 09e43157cc71..6415d7be9b73 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -25,6 +25,16 @@ properties:
   clocks:
     maxItems: 1
 
+  qcom,ice-use-hwkm:
+    type: boolean
+    description:
+      Use the supported Hardware Key Manager (HWKM) in Qualcomm ICE
+      to support wrapped keys. Having this entry helps scenarios where
+      the ICE hardware supports HWKM, but the Trustzone firmware does
+      not have the full capability to use this HWKM and support wrapped
+      keys. Not having this entry enabled would make ICE function in
+      non-HWKM mode supporting standard keys.
+
 required:
   - compatible
   - reg
-- 
2.43.0


