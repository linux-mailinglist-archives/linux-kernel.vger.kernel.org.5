Return-Path: <linux-kernel+bounces-88749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A835D86E616
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499B7B26EEA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7093A1AA;
	Fri,  1 Mar 2024 16:43:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F9639FED;
	Fri,  1 Mar 2024 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311392; cv=none; b=DHbOigtFNZv/Ub+1jjdLJedOcv/9dyb0Pt62cd0eJflwjibL77qgR60c3ep55k7ltyKf/P2+9SbklIfALGk8sqHYk22c2ok+xf50CWn+tToPRH2hHIxoDm9GWILUt067ZwVxTlM0p0MNJ8Z7IKfqUWfP1QiI+ImlLYgGNItWsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311392; c=relaxed/simple;
	bh=cLP1VhV//5a+QK8whuvHKC/YPCEW30r7xd8KhREIKck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/Eio1+KNproLUdnOWdl0Y4PAskMlzF59KfqAiwPZC2PGMauI4qkkDVakyt2Yjfkxs44nIgABMJ8idavEwzwyzhcTGjFEqCt8Yb7ZtyQFMUATgVITF792Zgae1AGI09E+NY3u7UNEjK+/oiYWqaXTD7/x0YwWJAKOlMK10COu0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17A961FB;
	Fri,  1 Mar 2024 08:43:48 -0800 (PST)
Received: from e130802.arm.com (unknown [10.57.69.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2D5A3F73F;
	Fri,  1 Mar 2024 08:43:06 -0800 (PST)
From: abdellatif.elkhlifi@arm.com
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew.Reed@arm.com,
	Adam.Johnston@arm.com,
	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: remoteproc: Add Arm remoteproc
Date: Fri,  1 Mar 2024 16:42:27 +0000
Message-Id: <20240301164227.339208-4-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

introduce the bindings for Arm remoteproc support.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
---
 .../bindings/remoteproc/arm,rproc.yaml        | 69 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml b/Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml
new file mode 100644
index 000000000000..322197158059
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/arm,rproc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm Remoteproc Devices
+
+maintainers:
+  - Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+
+description: |
+  Some Arm heterogeneous System-On-Chips feature remote processors that can
+  be controlled with a reset control register and a reset status register to
+  start or stop the processor.
+
+  This document defines the bindings for these remote processors.
+
+properties:
+  compatible:
+    enum:
+      - arm,corstone1000-extsys
+
+  reg:
+    minItems: 2
+    maxItems: 2
+    description: |
+      Address and size in bytes of the reset control register
+      and the reset status register.
+      Expects the registers to be in the order as above.
+      Should contain an entry for each value in 'reg-names'.
+
+  reg-names:
+    description: |
+      Required names for each of the reset registers defined in
+      the 'reg' property. Expects the names from the following
+      list, in the specified order, each representing the corresponding
+      reset register.
+    items:
+      - const: reset-control
+      - const: reset-status
+
+  firmware-name:
+    description: |
+      Default name of the firmware to load to the remote processor.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - firmware-name
+
+additionalProperties: false
+
+examples:
+  - |
+    extsys0: remoteproc@1a010310 {
+            compatible = "arm,corstone1000-extsys";
+            reg = <0x1a010310 0x4>, <0x1a010314 0x4>;
+            reg-names = "reset-control", "reset-status";
+            firmware-name = "es0_flashfw.elf";
+    };
+
+    extsys1: remoteproc@1a010318 {
+            compatible = "arm,corstone1000-extsys";
+            reg = <0x1a010318 0x4>, <0x1a01031c 0x4>;
+            reg-names = "reset-control", "reset-status";
+            firmware-name = "es1_flashfw.elf";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 54d6a40feea5..eddaa3841a65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1768,6 +1768,7 @@ ARM REMOTEPROC DRIVER
 M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
 L:	linux-remoteproc@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml
 F:	drivers/remoteproc/arm_rproc.c
 
 ARM SMC WATCHDOG DRIVER
-- 
2.25.1


