Return-Path: <linux-kernel+bounces-109439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7CE881930
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38808B211FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2E08615E;
	Wed, 20 Mar 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVb/tSAV"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA74F8B2;
	Wed, 20 Mar 2024 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970438; cv=none; b=X/QQPvZ5wv/XV7cEwVXGW22WTJLXgert1HlIbHWdjGqXhAnIQHK3FiQv17apeyCM1wgZRZHNXOnMyPG4E2vNoCI8Mdzu0pLdlAW2M65w7Tu7xuxayZV0VJf8yBkJanebKhCz46xDX0TyMLRHwrGveE+LOONU/4T5dKiYvskSeq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970438; c=relaxed/simple;
	bh=jN5oDfmJ8pi58iVOe5bgdatiEqJ5TMzdSYZ+Okekcs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iXSt8BdQlyWi902rOKH/oGUlJ7FNQpjeonghZFNmOjC/JUkwYSl+InuQij6FNAP2uy7tMnMsttllDWCiGokjISwydJSQxfT/CL1gKiDZNueTDGVjwW0tmMg4ff8h8Yfyj+swZbqRpE1/CnwJlKrrHYlw7L9LCsK44ugujig8Vm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVb/tSAV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-414689ba80eso2432005e9.2;
        Wed, 20 Mar 2024 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710970434; x=1711575234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Luf7LRUpOAFhMlxRw+l+V8h6+0FkYHyPc4K9DHr0oFI=;
        b=YVb/tSAVBL0eYQ6D6jiRr/79/2LHLTwQe3yo/NQSZZXCvDvJZ7PMOKi7clxLB1trV9
         6WN3A1RGpxSfqPVMEpLhcnBNH3fSfrMPMyveNSxdHdOq+7LDip8ibyjflYYsj4q7j5mq
         DPWbJZ6N3hX+jTxfc5uhCTVtxOXtfySxVUvhp/6G3sQrwM//yePlrhQvXKwja5jHDxcN
         kxd06DavZ0yC1gPbf/yoSfrO3xvmCOKWLlDv3oroi0G342i1fRn9/eDJgpaAsD9tbGg8
         HtoouSl3RUA5z13laFWn837AjTs7NMhLh1wyLMhmtvvs3vfIngCuwXqG6B9KNSd6+hEc
         cLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710970434; x=1711575234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Luf7LRUpOAFhMlxRw+l+V8h6+0FkYHyPc4K9DHr0oFI=;
        b=t5pLGPMpyfG1tl9q8xXsews5/2MsRmkpGpHr+D8+UkXVRn0zJOtuxMX73p8f42TXgK
         7w2HrdjDuHdTOUYfizPam62RV0BpXkD1kWYB7UTrM5Q+2/fKE6k/rfnxG2bUxtVyNb0H
         fiA0c7KkvRGC+scIokOVziDRwH0jtGwd/Avo9y6jpvJWlvXMzLR9as1wRiGw5LmhQMqc
         XAnxbhk8ZnM2UHHfe5pGIPMgPw8PnlSGTPsmWWDGh7QmdsK2MzAe7hVExX8yWsZ2ZQ2w
         SQZwhqr27WMVEftrihqrMlsad2SoMEuwb3417imW3uBsG1931lMEXCKfaIHKQKJsbyBW
         5nng==
X-Forwarded-Encrypted: i=1; AJvYcCU/GzFJQt43TIQ1sIwRrChE3KGMVSev4baRCTTtjSuVC3mQLrYrbo5qvd05QlFHsBPASgPbzp4K49g//Q+XAHmUflu8ShAD1JY+YUKiU1r10N0Cpu7vbBV/GAe2KDdZc0Amc5f4mUINjA==
X-Gm-Message-State: AOJu0YwebS+pStMSdM5w0nEGwA0/5mOb6nmsOnupM29+5vfNou7KQkPb
	jnoNeoqbJzgHSiPcecmLmYgXdszSRoeqVei4SS4aY2gsjUCxBM1bksL/d0zvyKs=
X-Google-Smtp-Source: AGHT+IGezsMTBHc2QdgFq0n7EozdBXZgHvgQuWQyJPBcvJpyQhLkTLUDVcBjSgox1jdOY++8RpnB2g==
X-Received: by 2002:a05:600c:1d28:b0:414:101a:fa67 with SMTP id l40-20020a05600c1d2800b00414101afa67mr2641769wms.18.1710970434560;
        Wed, 20 Mar 2024 14:33:54 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b00414612a43a9sm3396821wmq.28.2024.03.20.14.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 14:33:54 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Wed, 20 Mar 2024 22:33:48 +0100
Subject: [PATCH v3 1/2] dt-bindings: thermal: convert st,stih407-thermal to
 DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-thermal-v3-1-700296694c4a@gmail.com>
References: <20240320-thermal-v3-0-700296694c4a@gmail.com>
In-Reply-To: <20240320-thermal-v3-0-700296694c4a@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0

'st,passive_colling_temp' does not appear in the device-tree, 'reg' and
'#thermal-sensor-cells' are also missing in the device description.

Convert st,stih407-thermal binding to DT schema format in order to clean
unused 'st,passive_cooling_temp' and add missing properties.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Changes in v3:
  - Specify const value for '#thermal-sensor-cells'
  - Add 'maxItems' for 'interrupts' property
  - Change commit log accordingly

Changes in v2:
  - Change commit log to use imperative
  - Drop description
  - Drop 'clocks' description
  - Add 'reg' property
  - Add '#thermal-sensor-cells'
  - Make node name generic in example
  - Fix YAML style
---
 .../bindings/thermal/st,stih407-thermal.yaml       | 58 ++++++++++++++++++++++
 .../devicetree/bindings/thermal/st-thermal.txt     | 32 ------------
 2 files changed, 58 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml b/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
new file mode 100644
index 000000000000..9f6fc5c95c55
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/st,stih407-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STi digital thermal sensor (DTS)
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+  - Lee Jones <lee@kernel.org>
+
+allOf:
+  - $ref: thermal-sensor.yaml
+
+properties:
+  compatible:
+    const: st,stih407-thermal
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: thermal
+
+  interrupts:
+    description:
+      For thermal sensors for which no interrupt has been defined, a polling
+      delay of 1000ms will be used to read the temperature from device.
+    maxItems: 1
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    temperature-sensor@91a0000 {
+        compatible = "st,stih407-thermal";
+        reg = <0x91a0000 0x28>;
+        clock-names = "thermal";
+        clocks = <&CLK_SYSIN>;
+        interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
+        #thermal-sensor-cells = <0>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/thermal/st-thermal.txt b/Documentation/devicetree/bindings/thermal/st-thermal.txt
deleted file mode 100644
index a2f939137e35..000000000000
--- a/Documentation/devicetree/bindings/thermal/st-thermal.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Binding for Thermal Sensor driver for STMicroelectronics STi series of SoCs.
-
-Required parameters:
--------------------
-
-compatible : 	Should be "st,stih407-thermal"
-
-clock-names : 	Should be "thermal".
-		  See: Documentation/devicetree/bindings/resource-names.txt
-clocks : 	Phandle of the clock used by the thermal sensor.
-		  See: Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Optional parameters:
--------------------
-
-reg : 		For non-sysconf based sensors, this should be the physical base
-		address and length of the sensor's registers.
-interrupts :	Standard way to define interrupt number.
-		  NB: For thermal sensor's for which no interrupt has been
-		  defined, a polling delay of 1000ms will be used to read the
-		  temperature from device.
-
-Example:
-
-	temp0@91a0000 {
-		compatible = "st,stih407-thermal";
-		reg = <0x91a0000 0x28>;
-		clock-names = "thermal";
-		clocks = <&CLK_SYSIN>;
-		interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
-		st,passive_cooling_temp = <110>;
-	};

-- 
2.44.0


