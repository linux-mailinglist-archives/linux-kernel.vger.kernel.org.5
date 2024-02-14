Return-Path: <linux-kernel+bounces-65663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B7685502F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CBFB1F221A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C3E129A83;
	Wed, 14 Feb 2024 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="5tX/Oacz"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8648E8662D;
	Wed, 14 Feb 2024 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931362; cv=none; b=hhk63KVV5i+NUyYoQmeBEBc+abXEEaGMNHxbAn2qdlF/xlV6sL5VBwILLoKiYTlsvXDj+6N9pE/kbcQobfuRlMs7exP2SaIeHrSIJA9MfmtG7r8JoLQcwtSTAlYDhdJ9H46Opw67LqL0VN+TwRBXAR0dWeJ0ap75uecofvtIFs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931362; c=relaxed/simple;
	bh=Aaa2jNzeBt4IVHxAmwNTBPziNw4IvtOWAfB8bps0trQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozUy2105pZY6Ok+Xqxw2U3+2BBBVBvgeMxdfKZUZvwriu1yKgqNBWzziKAPuVoab0agne3rR66824ncnRHealHIorTjtfsPpTFw6+IR5gMYA/SkvbrI7Nl5DW8ri8LQyuT/fdhTqnF58JrHSd4fErT4kPbMqCbUQ/O2oYr3MqnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=5tX/Oacz; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41EEb56X003989;
	Wed, 14 Feb 2024 18:22:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=9EG7+XkrPEpea5V06f07KXHol0lpljrozkJw2bM13jg=; b=5t
	X/OaczfdhutsrptiR4+GV4okj5l21VtTuahDrfbiNrgDj75hnWEFu8keC+/IW7CA
	jLPdVYe+nJhG/74mftyYIM9kjR5I5ZCeAJiui58yiC2z5mqwxsAGoFSKrjX4r2S1
	hRS0GsmAOEN3PThaL83THalRXEskOMS4pzY8RwyGgoZUK7Lo5j11FFB2M9LkeN8q
	kOUMoWBwEElCOz8NSXcho+xHR7Gk2/NgB/yAxqdjOdMqJbTD+oVI2rfmelWAW+9v
	vz2tM9KhSFECgS07g0EfL3YlPBp5PfME8ylhb2RKU22H1yMqST7gRsVVqjKdga6r
	qXZPLfuVSThJ+n250g3g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w62ktqx96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 18:22:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7C80C40045;
	Wed, 14 Feb 2024 18:22:18 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 63EBE2CA54E;
	Wed, 14 Feb 2024 18:21:35 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 14 Feb
 2024 18:21:35 +0100
Received: from localhost (10.201.20.75) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 14 Feb
 2024 18:21:34 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v3 5/7] dt-bindings: remoteproc: Add compatibility for TEE support
Date: Wed, 14 Feb 2024 18:21:25 +0100
Message-ID: <20240214172127.1022199-6-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
References: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_10,2024-02-14_01,2023-05-22_02

The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
where the Cortex-M4 firmware is loaded by the Trusted execution Environment
(TEE).
For instance, this compatible is used in both the Linux and OP-TEE
device-tree:
- In OP-TEE, a node is defined in the device tree with the
  st,stm32mp1-m4-tee to support signed remoteproc firmware.
  Based on DT properties, OP-TEE authenticates, loads, starts, and stops
  the firmware.
- On Linux, when the compatibility is set, the Cortex-M resets should not
  be declared in the device tree.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
V1 to V2 updates
- update "st,stm32mp1-m4" compatible description to generalize
- remove the 'reset-names' requirement in one conditional branch, as the
  property is already part of the condition test.
---
 .../bindings/remoteproc/st,stm32-rproc.yaml   | 51 ++++++++++++++++---
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
index 370af61d8f28..36ea54016b76 100644
--- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
@@ -16,7 +16,12 @@ maintainers:
 
 properties:
   compatible:
-    const: st,stm32mp1-m4
+    enum:
+      - st,stm32mp1-m4
+      - st,stm32mp1-m4-tee
+    description:
+      Use "st,stm32mp1-m4" for the Cortex-M4 coprocessor management by non-secure context
+      Use "st,stm32mp1-m4-tee" for the Cortex-M4 coprocessor management by secure context
 
   reg:
     description:
@@ -142,21 +147,41 @@ properties:
 required:
   - compatible
   - reg
-  - resets
 
 allOf:
   - if:
       properties:
-        reset-names:
-          not:
-            contains:
-              const: hold_boot
+        compatible:
+          contains:
+            const: st,stm32mp1-m4
     then:
+      if:
+        properties:
+          reset-names:
+            not:
+              contains:
+                const: hold_boot
+      then:
+        required:
+          - st,syscfg-holdboot
+      else:
+        properties:
+          st,syscfg-holdboot: false
+        required:
+          - reset-names
       required:
-        - st,syscfg-holdboot
-    else:
+        - resets
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,stm32mp1-m4-tee
+    then:
       properties:
         st,syscfg-holdboot: false
+        reset-names: false
+        resets: false
 
 additionalProperties: false
 
@@ -188,5 +213,15 @@ examples:
       st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
       st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
     };
+  - |
+    #include <dt-bindings/reset/stm32mp1-resets.h>
+    m4@10000000 {
+      compatible = "st,stm32mp1-m4-tee";
+      reg = <0x10000000 0x40000>,
+            <0x30000000 0x40000>,
+            <0x38000000 0x10000>;
+      st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
+      st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
+    };
 
 ...
-- 
2.25.1


