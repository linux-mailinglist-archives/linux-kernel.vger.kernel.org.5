Return-Path: <linux-kernel+bounces-144357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2311F8A44F0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 21:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDCC2813F5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E598A137910;
	Sun, 14 Apr 2024 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BeZsaeQC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92231136E16;
	Sun, 14 Apr 2024 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713123126; cv=none; b=Xq1vOBhzxK8RHursx7ByA51YSyXrGGg3Ivmrwjw/2fMrmXFvHqbCtY87vxxAqmyRrNVJEpel4WjbKuZSgrklyyOmANwsR4nvQxle/WUH9xpi6L2+TVPYVoJ+4G3P6lxP7vDI5Es9ulQYTtA2GkEZ+Ia+IX9V+UkhJOStzrguEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713123126; c=relaxed/simple;
	bh=NZ2VeXUCel2XPe1CBjAQ/uMwdyrsZmjtgBptKtRvGao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=vBDWpMUPzjEm110wFxRnuY2pAxdV7RGCmWzC4h6f4qTFV/CdwzhuaFFILwqV83fgOf2gJ5oMPkXt4qtpvEiPhMyKtpVIaGf1y2pTdgUBLQii5e0WTZISEK6OdjbuT84KSECuc9GUWQsbt5yvzj2BJsrCNV40XHFjhxevvia6kFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BeZsaeQC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43EJUYvS029431;
	Sun, 14 Apr 2024 19:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=umhEKn8h+1buMqVYLoKXaJnsY3+7UpynRDnMhkEzrd0
	=; b=BeZsaeQCNWGd5rH0K/6ZZL7KdnQE4YRl3rJKAhyGvsCtbX5rZvio7h/ZfQG
	pQ0rXo/xwDVsd9ZKg9AcFuwxeg/Rxurh5hEt+hSSHMKJbIbVpCNeFDZxUIPkOTe2
	sY983VgD5ggI4QWwN63oe3IW6dFzwPWXJbQTBk6SzejayoXjiHZAMXbdDVHlkWXd
	P6gxHwYMpEoSkZryp9tFOpu+pIAybFU6Zal65SLWWW9i4iCL+aauzVs2fB9Et5Jj
	G2TeE2MMk93zSsbI0OLs9UxB9mYDD1vvfxd1WDoMeIi7LMjR78s9AfcS3hORmf9Z
	qy2QMEfXnZMYg8teGXuPGWzEJOA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfh2ct7r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 19:31:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43EJVc7p023182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 19:31:39 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 14 Apr 2024 12:30:30 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Sun, 14 Apr 2024 12:30:25 -0700
Subject: [PATCH v2 2/4] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240414-arm-psci-system_reset2-vendor-reboots-v2-2-da9a055a648f@quicinc.com>
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
In-Reply-To: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
CC: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yz5wiYonQyBJ0Axp5BpKRu3FExRY3kMt
X-Proofpoint-GUID: yz5wiYonQyBJ0Axp5BpKRu3FExRY3kMt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404140142

Add bindings to describe vendor-specific reboot modes. Values here
correspond to valid parameters to vendor-specific reset types in PSCI
SYSTEM_RESET2 call.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 38 +++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index cbb012e217ab..ac778274b3ac 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -137,8 +137,31 @@ allOf:
       required:
         - cpu_off
         - cpu_on
-
-additionalProperties: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: arm,psci-1.0
+    then:
+      allOf:
+        - $ref: /schemas/power/reset/reboot-mode.yaml#
+        - properties:
+            # "mode-normal" is just SYSTEM_RESET
+            mode-normal: false
+        - patternProperties:
+            "^mode-.*$":
+              items:
+                maxItems: 2
+              description: |
+                Describes a vendor-specific reset type. The string after "mode-"
+                maps a reboot mode to the parameters in the PSCI SYSTEM_RESET2 call.
+
+                Parameters are named mode-xxx = <type[, cookie]>, where xxx
+                is the name of the magic reboot mode, type is the lower 31 bits
+                of the reset_type, and, optionally, the cookie value. If the cookie
+                is not provided, it is defaulted to zero.
+
+unevaluatedProperties: false
 
 examples:
   - |+
@@ -261,4 +284,15 @@ examples:
         domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
       };
     };
+
+  - |+
+
+    // Case 5: SYSTEM_RESET2 vendor resets
+    psci {
+      compatible = "arm,psci-1.0";
+      method = "smc";
+
+      mode-edl = <0>;
+      mode-bootloader = <1 2>;
+    };
 ...

-- 
2.34.1


