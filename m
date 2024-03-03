Return-Path: <linux-kernel+bounces-89836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2840F86F646
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB29286667
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321256F525;
	Sun,  3 Mar 2024 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rnmdvkck"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AF16EB4B;
	Sun,  3 Mar 2024 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709484850; cv=none; b=kwp40cdiPT6wXgRKjA0k0cmJKbALEzpGGZn7PouCR7I9aFjZE1Bz2VAnGDsOPGKDKXTvkhv2cpqI+P/ymRWlL95p049fMDFyXPh2MflZ6F6DeH3Ozp4Ux80BQMJtyjixRtmt1b+JRTedOojogOWuhQY9qgze7tBgrX0JnHMkKNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709484850; c=relaxed/simple;
	bh=lMwnrLeCvVz6MVMwOx8zbh7VgWcU3y59cceellDGewY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bpogO4O90HHn5jCKwUHcXIcReECo8+gagB6f9WP76l2KAYIiWL0cTR/VgupYyL9d++GJHlJqbrz+Fyt+jhROJwkKZzuwdrua5pBt74IjEIcbSXN5p41Y5aj3ymBrmyhdCeMpPTisMvZpwWGulNK9+bZnwxT02mQr+98MKY8rvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rnmdvkck; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 423Gk8w3021392;
	Sun, 3 Mar 2024 16:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=snaF0gfNSgpz2yUDbhT9E15ErTrvt/AaN/jKFXto6zE
	=; b=RnmdvkckpvMhkybNiN58WUuN1P6RoA6wcmh6wtjWLCma7MGV08HtHdq1srV
	XgPoW8L4ITuksSNAssNhMPuavRlw/gic8ZQO3kilL4pgjrvvWuTH7NjC5X0RUQXz
	/Nh2u8r0DBqjI3i5ivLnOSLN8kkOItS/TLwigZxg0doN0W5hWgDQSWQgptxqpHp9
	1vwLq6yymi7vyGuOa2aYi1lm4hI/poK2vIQ/hrB/WtU1uEPJKyfMiHqqbeUmqaYy
	w1Fgd5wsbVVMJzpsKokwugmfDTYSTjqZRgp3CMByKRpyXe8gE/5F83n5jMY9a0VP
	/9msvXFrby65n0h7aYJyBSJ9dJQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wksfrj4xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Mar 2024 16:53:48 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 423GrliU025370
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 3 Mar 2024 16:53:47 GMT
Received: from robotics-lnxbld034.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 3 Mar 2024 08:53:43 -0800
From: Canfeng Zhuang <quic_czhuang@quicinc.com>
Date: Mon, 4 Mar 2024 00:53:17 +0800
Subject: [PATCH 2/2] dt-bindings: misc: merge qcom,qrc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240304-qcom_qrc-v1-2-2a709f95fd61@quicinc.com>
References: <20240304-qcom_qrc-v1-0-2a709f95fd61@quicinc.com>
In-Reply-To: <20240304-qcom_qrc-v1-0-2a709f95fd61@quicinc.com>
To: Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic
	<dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Canfeng Zhuang <quic_czhuang@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709484815; l=1343;
 i=quic_czhuang@quicinc.com; s=20240304; h=from:subject:message-id;
 bh=lMwnrLeCvVz6MVMwOx8zbh7VgWcU3y59cceellDGewY=;
 b=kcQunjyDHPqMorGPKhFqjSANzV5uQ4TwRuEIdywO4nZvWBpkgVZb7Zp/agwOjkjvoVUr79GSG
 oDZ1N0VWDLOB8yMJyggu/yBwJdD+MV5p6vCgCEBMNS5CIRlh8GPBiJr
X-Developer-Key: i=quic_czhuang@quicinc.com; a=ed25519;
 pk=uQG1beHWTQyrSp8QCUkEKgprUZM/nlhxKMyUwzilvXQ=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -_S58zLGaULi4NYa-xBCwRGto6RoP_3m
X-Proofpoint-GUID: -_S58zLGaULi4NYa-xBCwRGto6RoP_3m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-03_07,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403030142

Merge Qualcomm-specific qrc binding

Signed-off-by: Canfeng Zhuang <quic_czhuang@quicinc.com>
---
 .../devicetree/bindings/misc/qcom,qrc.yaml         | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,qrc.yaml b/Documentation/devicetree/bindings/misc/qcom,qrc.yaml
new file mode 100644
index 000000000000..730efd679ba0
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/qcom,qrc.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/qcom,qrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Robotics Communication Driver
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  The QRC (Qualcomm Robotics Communication) driver is used for information interaction
+  between the robot control board and the main board when using a uart port connection.
+  This Driver will support uart read & write and robot control board
+  reset function.
+
+properties:
+  compatible:
+    const: qcom,qrc-uart
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    qrc: qcom,qrc_uart {
+        compatible = "qcom,qrc-uart";
+    };
+

-- 
2.25.1


