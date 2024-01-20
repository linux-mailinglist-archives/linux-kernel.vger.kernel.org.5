Return-Path: <linux-kernel+bounces-31778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835788333DD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72FACB22514
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216D9EACE;
	Sat, 20 Jan 2024 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CUAuqFTf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0505D528;
	Sat, 20 Jan 2024 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705749695; cv=none; b=ad7G0X1yMlGgeWOAnXO+q88onDjJ1LJKeTPywLTXI2fOKzK3GThx8RVoLwh1TWj9cLOuTeE1hk9RZQfqz+MF6dYWQqrDwzMMpfTDVtpbrIUy2RjLisfIwVcRtu4XZPSiO8OSgD91tkHFQylO5EcG/Z5M2oloGSz5HGikCfV+01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705749695; c=relaxed/simple;
	bh=Bjn3VOvf9UyznsFPCxykvJED2EZ9dgcyNkkbuAuynbc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBrN2CYaUHFTkSJuKIt7mk7H6IYR+7cKfVS93kYQ4bURPW9EDyJNMqkescUajOwzfGxsNsrxWzMU34k/TDqhuJNmcOEX47noBsFFLy7+8k8oksD6F1UUnSoou9VPlrHNeODSypHjFiRnMaB8zG64CmOCREuMeANdzQUFZOh/F0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CUAuqFTf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40KAfwkB009458;
	Sat, 20 Jan 2024 11:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=mXIEo8jgGOmkiHtx1UVo
	/wdlFIhR47j418CGFjQTlRI=; b=CUAuqFTfAHz/eCIFSQbZsX0yZI0sUOUL8Crb
	5X3iXJnE/qBaiWVHrwwgzZMmuk7lfCW06+OLzR6abp2jlfMc3j4ybhgnPKX/l1dx
	xMl0va/yVCcIAPgbUD7irH/YhlSqcKUdv6D4K9+10IXV2aaw0sqDmbL6z8HKc8im
	KLp20lHjK+Hs2sNJNuqDdoOm1Ix2giGbVB0WG3sD2f9CVpoBX2MV7U/aOnyJUtmg
	6/yZQISj+uFQ9ohk25J3dLR0MVNV6LDj7hPcoCJM0p4xCLJ3C/V7f+fTj+6LO3sf
	Win3ysxssr43ymmL32+a1vBubInfrkG/CxQuzyI/WjPfg95iMQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr5gpgh3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 11:21:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40KBLMn4029930
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 11:21:22 GMT
Received: from hu-amrianan-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 20 Jan 2024 03:21:16 -0800
From: Amrit Anand <quic_amrianan@quicinc.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Elliot Berman
	<quic_eberman@quicinc.com>,
        Amrit Anand <quic_amrianan@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: hwinfo: Introduce board-id
Date: Sat, 20 Jan 2024 16:50:48 +0530
Message-ID: <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K21ccJZXt1C1jxC8YyifGsmUT9s1cD3p
X-Proofpoint-ORIG-GUID: K21ccJZXt1C1jxC8YyifGsmUT9s1cD3p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-20_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401200092

From: Elliot Berman <quic_eberman@quicinc.com>

Device manufacturers frequently ship multiple boards or SKUs under a
single software package. These software packages will ship multiple
devicetree blobs and require some mechanism to pick the correct DTB for
the board the software package was deployed. Introduce a common
definition for adding board identifiers to device trees. board-id
provides a mechanism for bootloaders to select the appropriate DTB which
is vendor/OEM-agnostic.

Isn't that what the compatible property is for?
-----------------------------------------------
The compatible property can be used for board matching, but requires
bootloaders and/or firmware to maintain a database of possible strings
to match against or have complex compatible string matching. Compatible
string matching becomes complicated when there are multiple versions of
board: the device tree selector should recognize a DTB that cares to
distinguish between v1/v2 and a DTB that doesn't make the distinction.
An eeprom either needs to store the compatible strings that could match
against the board or the bootloader needs to have vendor-specific
decoding logic for the compatible string. Neither increasing eeprom
storage nor adding vendor-specific decoding logic is desirable.

The solution proposed here is simpler to implement and doesn't require
updating firmware or bootloader for every new board.

How is this better than Qualcomm's qcom,msm-id/qcom,board-id?
-------------------------------------------------------------
The selection process for devicetrees was Qualcomm-specific and not
useful for other devices and bootloaders that were not developed by
Qualcomm because a complex algorithm was used to implement. Board-ids
provide a matching solution that can be implemented by bootloaders
without introducing vendor-specific code. Qualcomm uses three
devicetree properties: msm-id (interchangeably: soc-id), board-id, and
pmic-id.  This does not scale well for use casese which use identifiers,
for example, to distinguish between a display panel. For a display
panel, an approach could be to add a new property: display-id,
but now	bootloaders need to be updated to also read this property. We
want to	avoid requiring to update bootloaders with new hardware
identifiers: a bootloader need only recognize the identifiers it can
handle.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
---
 .../devicetree/bindings/hwinfo/board-id.yaml       | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwinfo/board-id.yaml

diff --git a/Documentation/devicetree/bindings/hwinfo/board-id.yaml b/Documentation/devicetree/bindings/hwinfo/board-id.yaml
new file mode 100644
index 0000000..82d5ff7
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwinfo/board-id.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwinfo/board-id.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Board Identifier for Devicetree Selection
+
+maintainers:
+  - Amrit Anand <quic_amrianan@quicinc.com>
+  - Elliot Berman <quic_eberman@quicinc.com>
+
+description: |
+  Device manufacturers frequently ship multiple boards under a single
+  software package. These software packages will ship multiple devicetree
+  blobs and require some mechanism to pick the correct DTB for the board
+  the software package was deployed. board-id provides a mechanism for
+  bootloaders to select the appropriate DTB which is vendor/OEM-agnostic.
+
+select:
+  anyOf:
+    - required:
+        - 'board-id'
+    - required:
+        - 'board-id-types'
+    - required:
+        - '#board-id-cells'
+
+properties:
+  $nodename:
+    const: "/"
+  board-id:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: |
+      A list of identifiers that can be used to match with this devicetree.
+      The interpretatation of each cell can be matched with the
+      board-id-type at the same index.
+
+  board-id-types:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      Defines the type of each cell, indicating to the DeviceTree selection
+      mechanism how to parse the board-id.
+
+  '#board-id-cells':
+    minimum: 1
+
+required:
+  - board-id
+  - board-id-types
+  - '#board-id-cells'
+
+additionalProperties: true
-- 
2.7.4


