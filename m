Return-Path: <linux-kernel+bounces-30425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F86831E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D631C233D6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37352D05C;
	Thu, 18 Jan 2024 17:33:35 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA242D791;
	Thu, 18 Jan 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599215; cv=none; b=Rnx8997FQyjFHg1q5ytH4FWZEaSDIcHzZD1ZoVX8OPyBcFlJYhuKybHtRCXWtcHPM3DnAsjgNWZMTBAoq5y7HL0jPLlKefW03Et7SG34qe47jFPJuORt95Dsx/OQcu6L037N7WRM21tcCXy8ipd0ANWveaDpEGW20Wk/p5IMp1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599215; c=relaxed/simple;
	bh=iNn7xg36o4SOnQIC660Uj6QfFESJksQoGp7is54EjGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MdGOc6GWVUayVFepXTBEIFbx9N2AbSXi6Q8cW+aYm8cP0BXd5MGKfpcJRl3tRjGFnAgpxZWunlDUlEPtia4JSOk+aNtB9/aLr+kX4DzAnOFYuXGyOryqMPHsaYv1uPMICkxOtw0RKz6kMHRiXuwkdmYGbkYBifdSUPBt32NpNts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 27BD883BA7;
	Thu, 18 Jan 2024 18:33:25 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Thu, 18 Jan 2024 18:32:38 +0100
Subject: [PATCH v2 1/2] dt-bindings: backlight: add Kinetic KTD2801 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240118-ktd2801-v2-1-425cf32e0769@skole.hr>
References: <20240118-ktd2801-v2-0-425cf32e0769@skole.hr>
In-Reply-To: <20240118-ktd2801-v2-0-425cf32e0769@skole.hr>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=iNn7xg36o4SOnQIC660Uj6QfFESJksQoGp7is54EjGU=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlqWDB1JxAMfpI+JslgU8OnmNzd2BuzUDgLgTbn
 RxOcz/B/oWJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZalgwQAKCRCaEZ6wQi2W
 4ZDiD/0fXVj/3tE/NZpBl4xZ0KueJ6+p03t2s+FLZUBCEYfa+wm5lvHCMBy8vDgihzdgDNDdvf8
 F8I+XU+ON5hZiwwKQIXI74g6VOBtJstetpkIdsgEvWpiwaNovurv5MzKG2t89CkpqGHfujP2eB5
 +OiIlpn588ZcR8LZK847TUxTrbq7dAAn8DAV3O+DPMVwAPXeuqb2BSl3mboP9+bsunUbHjruq7g
 f58ifQKxj60bjPsaDXv7lGTghHYDUWCklxKYyEBvhN70qadYI2hRxQeCMzTE0gcjd3a9h3xfikF
 g8+facKX3Bx+7040X/RCeWVMwHSAJlLcM0kbn2aiWlQR4m9D9/O1Za1GA8cWF4ORo/FiQMe7bs9
 8t8kY/BTrsaeG+H2wh7zY4RL4FzFL+0m6oJVHVfQ0Si83EllIEi2QMwJo88ptiZUTVMDRZWTaUG
 j4+q4eYgtQjPBZOxP4z9YsugXvpGuqnHEozzlxdcWit4tIQWtPFC9vapA4dYIACyD2stW7+VRVo
 iLgRHBMBt1srw+ZlUvaIpfFoIJMiwS4OMKAsyfWfQmHFMsAzqZnfyjqEMSgm2PfNheFconwUlwp
 Ontkyi+TbITqvXD7TGuBNwaIqsRHoHRtUHyUIWZH61sM7iyojaZEIiylYho1yJ0WJPCWIQ1VF9c
 WGO0cWm0VIOY5Sg==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Add the dt binding for the Kinetic KTD2801 backlight driver.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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



