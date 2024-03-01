Return-Path: <linux-kernel+bounces-88859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1495986E7A3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE502839E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D393320DC5;
	Fri,  1 Mar 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lra+oVS+"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ADC4C99;
	Fri,  1 Mar 2024 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315256; cv=none; b=WeeMUeU/12msabr4Bm/SxC/yqS70Fk8TyMuOysUQ7o5vtI+4TsDnI3Gk7uIt+3uyJoAhlxu6hgvu2tV/E3cKZVA4PpZeAjAtLvYGrfLzT6GJesHojQO/bB2eKoiqv+sd+mzSJWzSDBOEZg7WSV0B0T45lXnfI4S+njhwk6CG+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315256; c=relaxed/simple;
	bh=GuG6OcP2Q+V1fhDTC1pxrssX/s5xM4U3zgiW3bxBV9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tuv1JYBC2TJ4Q6Q4FSXuH1yJkfO11rgaNl2spoXVW5jrUR7pTK9D3unUPAk3BdqNdtZc4GsoQR8fVq3RReDcPzpslvfftNzEcyePkigGS9c0kajSThTqp4Zg99cUqRPyZibi9hpRqeNuB6tdeg37LyPjy3YrzEsyYQ0y4lP2Ylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lra+oVS+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412b83cfac4so16931625e9.0;
        Fri, 01 Mar 2024 09:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709315253; x=1709920053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FnpEmiF4nPHhd94SMr00ku6sR56qnzsYgoCp8rfi9I=;
        b=Lra+oVS+EO15mvvQPWPiBNURcSGfKX1Qv3+oP1f+9Uv5tnKbJlfjhpLtGCp4khI1aB
         kTPbWbHqWEZ1uxD22XJ36v6+bWWTqFjaJoN6gPi2xs6+dFg6gOlro9XeYGpGIg81BEoM
         c0N02shpsKP6ZbcR7pbO/OwTs16teVgqpHekxhHBwLMj/JeiYf68x5C2QX4uAbY0B9bL
         qcG6Lmp9pxLt3pboMTHHksvJtBgngJ0ddJWn9fATfwShqIW/locu77rU2kHDdc28utpV
         WIyF3v3ZK0zbMN6ltHeptxQutfg62MyoZdJemCJlenZpbjgzT6pdMZhBxK//lntdzvyY
         aHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709315253; x=1709920053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FnpEmiF4nPHhd94SMr00ku6sR56qnzsYgoCp8rfi9I=;
        b=lTz/JPDrsoOPazfmY6e6QYF9s5jLx9yvn/GYWxYmA1JcfUl4K3DA8Qswt3DEDvPrLz
         jSIjTMFJEUppchmmqVZTG1oKKq3xcsPxVfQw7R4a1pY/apFyZsxsWxNo2Et7eWHMbCS9
         GBrJjK0rrHiLByuW1eleAbHPU6jTotAFSbMXRVNVzUWkXiIgF9TWG5PSnYc40qCb8KBW
         qVJ6AQOcjsiPxpVDIEY+kLqhhEowymqyH5GTBpgso2oqk5q1qEHtuIOg/qZQ4zOeADlC
         8q0EONR5/+IvZk9UDk9yqabOB/m1W8ORpFZ6LrDXK/DlfEDyWy9n4/WlSrmQ0dwWiibh
         naOg==
X-Forwarded-Encrypted: i=1; AJvYcCU1KK8TSMeiTdSGjfzwY8lu0eLGppHL6iDGaPSnl2S/CzM5mIRsL5npqMz8Txf90ZSRFtjF2QT7/lBGbprOII6BQsa4Uj6JXR8Kt4bmsUfjVElzt2FMCEVEXHc8siFjDW8W+zIcrDy1BQ==
X-Gm-Message-State: AOJu0Yz+RYLrQLtDWSStFEfDdrK8CLJGiV5LUkHjJ1JBW7KLwQNqIdG5
	mgnXduRj/1xXGKsK9egbtk2+oGDv8OWKSJTE9knmadABLszk8sOF
X-Google-Smtp-Source: AGHT+IHNY22DmyWFecV39yW+wBg61T6ryEUFgNCrg7E6CExJ7RCLAFSk7gp/XPGjwJ3r+1Y1Xl+ejA==
X-Received: by 2002:a05:6000:12c5:b0:33e:1e0d:658c with SMTP id l5-20020a05600012c500b0033e1e0d658cmr1573306wrx.70.1709315252594;
        Fri, 01 Mar 2024 09:47:32 -0800 (PST)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id bu16-20020a056000079000b0033dc3f3d689sm5144705wrb.93.2024.03.01.09.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:47:32 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Fri, 01 Mar 2024 18:47:28 +0100
Subject: [PATCH v2 1/2] dt-bindings: thermal: convert st,stih407-thermal to
 DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-thermal-v2-1-1b32752029ec@gmail.com>
References: <20240301-thermal-v2-0-1b32752029ec@gmail.com>
In-Reply-To: <20240301-thermal-v2-0-1b32752029ec@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0

'st,passive_colling_temp' does not appear in the device-tree, and 'reg'
is missing in the device description.

Convert st,stih407-thermal binding to DT schema format in order to clean
unused 'st,passive_cooling_temp' and add missing 'reg' property.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Changes in v2:
  - Change commit log to use imperative
  - Drop description
  - Drop 'clocks' description
  - Add 'reg' property
  - Add '#thermal-sensor-cells'
  - Make node name generic in example
  - Fix YAML style
---
 .../bindings/thermal/st,stih407-thermal.yaml       | 56 ++++++++++++++++++++++
 .../devicetree/bindings/thermal/st-thermal.txt     | 32 -------------
 2 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml b/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
new file mode 100644
index 000000000000..68d7dd8b892f
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
@@ -0,0 +1,56 @@
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
+
+  '#thermal-sensor-cells': true
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
2.43.2


