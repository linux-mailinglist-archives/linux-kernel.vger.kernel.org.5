Return-Path: <linux-kernel+bounces-38836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F5883C6BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FCDD1F2385E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F41B77F02;
	Thu, 25 Jan 2024 15:32:10 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D42745DD;
	Thu, 25 Jan 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196730; cv=none; b=d1gRvW6A0MliNVNyp9K9QNkaMiAJa+pqc0zNUOu7GPbyS0UMxepqqx5J7AqI3na/SP5uHUKipXpL4DMck8HFukH8K/N3HPB2aJh20/eJD5Jbj6ptQee9CkDrvW7f1J0N+HFuEuthztXW/5FbWckdDO6LTwRuKkSTdmDMScHldL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196730; c=relaxed/simple;
	bh=LJvKeqWnmJS9YgQYzDhJWoFRmXHdCPe0hkHgpXGDTkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kFEQ1NvQBaRiLxGfhjnQPV4fUhO9DtlGOlnP03noCydS9WsA7B6WG7lkSEeuaM/1tFf0jMF0SsCoMQYQLTAuuaY6nI/AqUUfWgNSJpobfkG+uq2FqYxpzYG9bualf7apwIYe6Dvh6DvayyroIfYdEUMPWJ/wwXgZpiwPkPKuunI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id A4F1084FE8;
	Thu, 25 Jan 2024 16:31:59 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Thu, 25 Jan 2024 16:30:55 +0100
Subject: [PATCH v5 3/4] dt-bindings: backlight: add Kinetic KTD2801 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240125-ktd2801-v5-3-e22da232a825@skole.hr>
References: <20240125-ktd2801-v5-0-e22da232a825@skole.hr>
In-Reply-To: <20240125-ktd2801-v5-0-e22da232a825@skole.hr>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2000;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=LJvKeqWnmJS9YgQYzDhJWoFRmXHdCPe0hkHgpXGDTkE=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlsn7DgswBUZqnKT+8/fcnn9Hru+hah1ioow/Af
 vXnD4GbKIyJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZbJ+wwAKCRCaEZ6wQi2W
 4R0BD/kB/1Eg1ozHsKPtWBSWi3LiCM+qxnj2ZuVCT6/OhEONtnJGsnXjTe5GRZFMElbjnKU5bUK
 0Bvew1WXJ2SPqoef0wAmJhXuSVbOVKMWVjaeLDDv8lWY3saxQW6c3spevVPoSDh2devRw3Oa6tC
 o/3JKl6L634njze/H8v+qsMth8jD54PnN9MekSfP0Mf4YmIaeilDxgRqcd5nL5narH0J76+EONz
 Y4eYXGyItA2v09zBCe0SURu+zci/Cga/yw1/OdIzRPm4EKNc8hy7g9xfxDuTjMAHmk98arzFOdu
 KGbzB5FPhpCYPZjmEbQQEYKVH3iaOckm/P6AzFqaDcu/P5khVBCeq5jcY/LH99vaVEs0EcW4W4m
 XxCkQB6hLLns3wqKaeqdHB7ORHYsMai1ppkTki1AFQWoS+WKkD0TE7SBYb9SMobDimgK3Hi0uZw
 xuMteBoc7ImL6F5aVB2ZUHVXdOIfsav9JlPS9jmNMW11P0ZrilAa3jbTNhCNVM7PqwudogIVLpz
 TtoufeERwAsfbxVUj6MskA041zUuwdfn8xat2aJe01vop6ItZ6G+KoXcWxe26++jXIHD3lwIPQ6
 h8ztWDgrcVG4zq+m6lDYEOdKUpwRXtRxaR9McbnpA6r28wNl8BldfgJy342B08zvwQ7FgQ5xTig
 3cAbMMec7AzUZ6w==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

KTD2801 is a LED backlight driver IC found in samsung,coreprimevelte.
The brightness can be set using PWM or the ExpressWire protocol. Add
a DT binding for the KTD2801.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 .../bindings/leds/backlight/kinetic,ktd2801.yaml   | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2801.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2801.yaml
new file mode 100644
index 000000000000..b005065e0f48
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2801.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktd2801.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kinetic Technologies KTD2801 one-wire backlight
+
+maintainers:
+  - Duje Mihanović <duje.mihanovic@skole.hr>
+
+description: |
+  The Kinetic Technologies KTD2801 is a LED backlight driver controlled
+  by a single GPIO line. The driver can be controlled with a PWM signal
+  or by pulsing the GPIO line to set the backlight level. This is called
+  "ExpressWire".
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: kinetic,ktd2801
+
+  ctrl-gpios:
+    maxItems: 1
+
+  default-brightness: true
+  max-brightness: true
+
+required:
+  - compatible
+  - ctrl-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    backlight {
+        compatible = "kinetic,ktd2801";
+        ctrl-gpios = <&gpio 97 GPIO_ACTIVE_HIGH>;
+        max-brightness = <210>;
+        default-brightness = <100>;
+    };

-- 
2.43.0



