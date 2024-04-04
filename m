Return-Path: <linux-kernel+bounces-131792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBD6898BD5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6C74B25685
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E776812D752;
	Thu,  4 Apr 2024 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7vzq0mt"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632712D201;
	Thu,  4 Apr 2024 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246826; cv=none; b=g1qoWpuUZ4dW6lUF4M1Rh1fztV8TDDZMok0okrwsLF/UGCq99lTyJ2femBkSAHGCf3XrgnWDo9n/LtPjRg1fDoIIsBIORd6PNu9ZjKiJxVaWoa351N7E/R207r8nP2xjxFEUQ+P9dBQH4Qb19gerV2SqEBS4VN4K046RHLb4pNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246826; c=relaxed/simple;
	bh=YsR66LWGItmKjfFG/4thl5QkI/T85/VwbY4I36tSedw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gTyHtd7W+WHxDCcVSrXWsjf099xWWxKM7eESh/ywHLw2FHYJcdQs7eXk8kp2lbZn6EWADRPLCxtnMlApyC/eV7YM3M3uSpyWZ4h05EOwsAD5Gn4GjJtUZlQGwYnush4yqV2L623uopBZxgiK9lv52cnvAFwVmhfDlP2agdDVghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7vzq0mt; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce2aada130so874971a12.1;
        Thu, 04 Apr 2024 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712246824; x=1712851624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwkMEGu4bH84VlMdGnCK4KPRxbhmbdEM0Bw2IunWXXM=;
        b=R7vzq0mtho5WmQX+rPI4dBoqeSFZsHzivsGCvSz4BVVms805y5ed9oD2nxvkZI0snm
         jAtuccmu70AIWQpBNusRa3OS4IN+bvOfmmivw2YFziNjA8nkVske76qvn+gpAad/Rftf
         VMRiyD+Y32qDdaA7CQuAmYI4cXfzeZ29cJnXuYgZS2KFZeDQgkPIq3i0n0MSpmA9BWeY
         yOCi0CMe6uCaJ2IHrWMRVFGyArXFx7W5GIr92fomuKbL4vN+LY4M7QYuZVg7Ol0AXJWM
         EWvitP6dgJKniJhTFae52QDlqJSo7LmpTGt3sz7yXD86QlrCO4qHdzKPU+ZwMspEpxGW
         X9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712246824; x=1712851624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwkMEGu4bH84VlMdGnCK4KPRxbhmbdEM0Bw2IunWXXM=;
        b=MxmTrQJct7K5arIRXxH296zY4Y91T2DnlANc7snOPp/etWh6KUEXFj7sCs287ZLYAU
         rbvDK7gKf7RG3RbdwX0jjg+n96dHXe4rtMWtO+pIa85lu8S7yz5mmEryIh7wwHt82p76
         LyPSkXmAxoqDyWDPKYMyo1DhPtBGUBHjXkgRWI71GQgorhlTPYJLYhU92BStfCEHIHlK
         MCUJUVfW6CHzSlc6tXKHuKbhq0qEeGU7e0sCnk4RjThGEPO+ZpG7rqc1LSqp2vOvosEs
         A7Mx7tOq/OoucaENMMXa7UgeIaRmQBv+8U0/liCwCN8lfOnOFij+ZXJo1KMbnn7QWPse
         MS3w==
X-Forwarded-Encrypted: i=1; AJvYcCX1izD8X7i8F5NrSHGmupuFmq6Wu1B93E4xxajm5Uea/92RDZj0m3iI2cjVj9c5X3NasZM/L9cC16CEBi5BMOZ+6mC1kXOwCSn8YAZepRbZLEFd4xMXMJEcO3k4jPYZjFjDwTXEQDMNNA==
X-Gm-Message-State: AOJu0YwlfGfdjOk7Epq6WltngSIyqnDPHv1ixM32RCtriscd/RM/Vj57
	zwr8tu73NH4wEXXQq9GNEIvvwWCzjBOWhYaLTVuaGRI7lQA5xyG1
X-Google-Smtp-Source: AGHT+IHibPG0W6H55vie7dFKnWlXEFmJq9c7f5VRpXhqgGA+gL558fvkCHxdOte330lCDtfdPWWS2w==
X-Received: by 2002:a17:90a:b10f:b0:29b:b3fa:b7a5 with SMTP id z15-20020a17090ab10f00b0029bb3fab7a5mr2556863pjq.7.1712246822352;
        Thu, 04 Apr 2024 09:07:02 -0700 (PDT)
Received: from localhost.localdomain ([203.188.229.101])
        by smtp.gmail.com with ESMTPSA id g14-20020a17090ace8e00b002a2979a8651sm1685928pju.54.2024.04.04.09.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 09:07:01 -0700 (PDT)
From: Mighty <bavishimithil@gmail.com>
To: 
Cc: Mithil Bavishi <bavishimithil@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: omap-mcpdm: Convert to DT schema
Date: Thu,  4 Apr 2024 21:36:49 +0530
Message-Id: <20240404160649.967-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mithil Bavishi <bavishimithil@gmail.com>

Convert the OMAP4+ McPDM bindings to DT schema.

Signed-off-by: Mighty <bavishimithil@gmail.com>
---
 .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 ----------
 .../bindings/sound/ti,omap-mcpdm.yaml         | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,omap-mcpdm.yaml

diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
deleted file mode 100644
index ff98a0cb5..000000000
--- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Texas Instruments OMAP4+ McPDM
-
-Required properties:
-- compatible: "ti,omap4-mcpdm"
-- reg: Register location and size as an array:
-       <MPU access base address, size>,
-       <L3 interconnect address, size>;
-- interrupts: Interrupt number for McPDM
-- ti,hwmods: Name of the hwmod associated to the McPDM
-- clocks:  phandle for the pdmclk provider, likely <&twl6040>
-- clock-names: Must be "pdmclk"
-
-Example:
-
-mcpdm: mcpdm@40132000 {
-	compatible = "ti,omap4-mcpdm";
-	reg = <0x40132000 0x7f>, /* MPU private access */
-	      <0x49032000 0x7f>; /* L3 Interconnect */
-	interrupts = <0 112 0x4>;
-	interrupt-parent = <&gic>;
-	ti,hwmods = "mcpdm";
-};
-
-In board DTS file the pdmclk needs to be added:
-
-&mcpdm {
-	clocks = <&twl6040>;
-	clock-names = "pdmclk";
-	status = "okay";
-};
diff --git a/Documentation/devicetree/bindings/sound/ti,omap-mcpdm.yaml b/Documentation/devicetree/bindings/sound/ti,omap-mcpdm.yaml
new file mode 100644
index 000000000..4d5d37e98
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,omap-mcpdm.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,omap-mcpdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP McPDM
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  OMAP ALSA SoC DAI driver using McPDM port used by TWL6040
+
+properties:
+  compatible:
+    const: ti,omap4-mcpdm
+
+  reg:
+    description:
+      Register location and size as an array
+      <MPU access base address, size>,
+      <L3 interconnect address, size>;
+
+  interrupts:
+    maxItems: 1
+
+  ti,hwmods:
+    maxItems: 1
+
+  clocks:
+    description: phandle for the pdmclk provider, likely <&twl6040>
+
+  clock-names:
+    description: Must be "pdmclk"
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ti,hwmods
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    mcpdm@0 {
+      compatible = "ti,omap4-mcpdm";
+      reg = <0x40132000 0x7f>, /* MPU private access */
+            <0x49032000 0x7f>; /* L3 Interconnect */
+      interrupts = <0 112 0x4>;
+      interrupt-parent = <&gic>;
+      ti,hwmods = "mcpdm";
+      clocks = <&twl6040>;
+      clock-names = "pdmclk";
+    };
-- 
2.34.1


