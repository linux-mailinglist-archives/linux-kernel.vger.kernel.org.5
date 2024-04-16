Return-Path: <linux-kernel+bounces-146354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE0F8A6410
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0D21C212B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4FF78C78;
	Tue, 16 Apr 2024 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RtjD3pRU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D76D1B0;
	Tue, 16 Apr 2024 06:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249433; cv=none; b=a4Ed8kQCAr1jPvmEvEoQLJu1j/eYzZBakRuGmLXvMymQy2MEYNlzCpnd73nr3oK+qmExfVLj6NRbFCjJsBJAWpQcDn4UxZNSLNDXqyfOneSp0tcSGbm4+jJHXCeWpcsdTZcv/KOUfiQzwac6j/8EYknn3jOLA6mrZCW69/ETUPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249433; c=relaxed/simple;
	bh=TQvwJrRmdiVMMw365XRskZQl/AxwM/o4oFDNQ4Jdn0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KiCQ3u8Y9n98fgkKoqUPvoUcC0V5XdkZ77gYpxn3XiQ2kfGYi+6hdCWR9Hbm3IEYfe1sCEMVG0ZPhCidhUHQURp5/+dA+ymcyCw3wy/Sk3WT76gOG0uo+igXeyRB8wXR/oSDdRY3XjwSJ2sn8de8jBPH1RajqqwQG0i7udV2o9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RtjD3pRU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G0IDfE007056;
	Tue, 16 Apr 2024 06:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=UbZpWzxnbNtzAQAci8lzeJG9HgfWiJYq+5IXKnWZxUg=; b=Rt
	jD3pRUvWmcTL0XgZ7rMygSUdXULMLMtO5gKzgy3bkqHA4aHMebmQMnrocNrdW+JM
	ORGcqyMIQsDTBxS4jODOnmdlHotL1F/O/faviObkpikUBMeS4AH17HPi1xxxMHbx
	fK8ACEHCZ7QNfNBNrjz0GCkv7nP4NgHu5BqqKjMbDvDBKy35+qH2SSVsW6Nj0R8O
	Mu/JaRcQ6FgqxXFBRrcyVoh+Oa2FeYeQgAccS8tpS9Mjl4lQga4g80HDUOXkwIO5
	ATMibLk40i1rNDS4bLqCOgx8eEM6Lozgl1UfMkAe5aQS7vI/SKpJno8pdFPQLNhA
	3DQk4oE/55I3r1aJFQ4A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xh5jxa1av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 06:36:48 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43G6alcq021505
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 06:36:47 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Apr 2024 23:36:42 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami
	<bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <quic_pkumpatl@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v2 3/8] ASoC: dt-bindings: wcd937x-sdw: add bindings for wcd937x-sdw
Date: Tue, 16 Apr 2024 12:05:55 +0530
Message-ID: <20240416063600.309747-4-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416063600.309747-1-quic_mohs@quicinc.com>
References: <20240416063600.309747-1-quic_mohs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cT74JxAJc1zNy15LBOFMfliUDzcqkgUN
X-Proofpoint-ORIG-GUID: cT74JxAJc1zNy15LBOFMfliUDzcqkgUN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_03,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=850 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160038

From: Prasad Kumpatla <quic_pkumpatl@quicinc.com>

Qualcomm WCD9370/WCD9375 Codec is a standalone Hi-Fi audio codec IC
connected over SoundWire. This device has two SoundWire devices RX and
TX respectively.
This binding is for those slave devices on WCD9370/WCD9375.

Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
---
 .../bindings/sound/qcom,wcd937x-sdw.yaml      | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
new file mode 100644
index 000000000000..2b7358e266ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,wcd937x-sdw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SoundWire Slave devices on WCD9370
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Qualcomm WCD9370 Codec is a standalone Hi-Fi audio codec IC.
+  It has RX and TX Soundwire slave devices. This bindings is for the
+  slave devices.
+
+properties:
+  compatible:
+    const: sdw20217010a00
+
+  reg:
+    maxItems: 1
+
+  qcom,tx-port-mapping:
+    description: |
+      Specifies static port mapping between slave and master tx ports.
+      In the order of slave port index.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 4
+
+  qcom,rx-port-mapping:
+    description: |
+      Specifies static port mapping between slave and master rx ports.
+      In the order of slave port index.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 5
+    maxItems: 5
+
+required:
+  - compatible
+  - reg
+  - qcom,port-mapping
+
+additionalProperties: false
+
+examples:
+  - |
+    soundwire@3210000 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        reg = <0x03210000 0x2000>;
+        wcd937x_rx: codec@0,4 {
+            compatible = "sdw20217010a00";
+            reg  = <0 4>;
+            qcom,rx-port-mapping = <1 2 3 4 5>;
+        };
+    };
+
+    soundwire@3230000 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        reg = <0x03230000 0x2000>;
+        wcd937x_tx: codec@0,3 {
+            compatible = "sdw20217010a00";
+            reg  = <0 3>;
+            qcom,tx-port-mapping = <2 3 4 5>;
+        };
+    };
+
+...
-- 
2.25.1


