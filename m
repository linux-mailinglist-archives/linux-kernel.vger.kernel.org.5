Return-Path: <linux-kernel+bounces-34088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ACF83733C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8E7291BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A02740C01;
	Mon, 22 Jan 2024 19:51:46 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8413D981;
	Mon, 22 Jan 2024 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953105; cv=none; b=KzjiOsLCtOBT8B2z7w7/hSy6xNjHS/xNGbHbpPgH1u7horJs410qX0sdN126dapBR80XjWtNe5ke2pGsInEnvc3NFhUEX0QOQJ6A8q521NDqsEIB/3f2mYCQldV/+XLmrqIY+eUIBZebaKBzarAJw1DVYCkcxa2YoI2DUOo7L0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953105; c=relaxed/simple;
	bh=0YufyoxCcDHdvrCe1DCC6ao7YtZtJoU6/jXb8S7jhuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S25jM3KhssSfZZcCdpVG4SiIv/dEkbRbUZMaMgUv633jlALSLVS2Gx5JPf/KWU577/LGGouPtzfuGUn5JVqfNb8Xg7t/4HrfCp3uePpgs1lMC/WxmmJXJXK+gelfYmiLQQ/eRTpsjSj3Lg9y+XbQR0GIYnMIY2Z5tvFfbvVeOOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 898648689C;
	Mon, 22 Jan 2024 20:51:40 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Mon, 22 Jan 2024 20:50:58 +0100
Subject: [PATCH v4 2/3] dt-bindings: backlight: add Kinetic KTD2801 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240122-ktd2801-v4-2-33c986a3eb68@skole.hr>
References: <20240122-ktd2801-v4-0-33c986a3eb68@skole.hr>
In-Reply-To: <20240122-ktd2801-v4-0-33c986a3eb68@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1941;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=0YufyoxCcDHdvrCe1DCC6ao7YtZtJoU6/jXb8S7jhuc=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlrsckO1mwx44YvZ3Dc3vxmj9vux3yBgfybdSqz
 pzWPxya09WJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZa7HJAAKCRCaEZ6wQi2W
 4WmYEACb+8QNWDYRs9Ws6URBZHTMcmYpGX91/smv02pU7AujWpAUZbArxpyHjWMitPiPK9BierL
 PKG8VVdhfjMI6fIrzH5QaK18hn4XoRNDD6XWWvAnoxl6J4CEAXjfCCFUAAvQhmneuT0+noHNm3h
 OPwO8J6BxRLur/AfCjA2tle6EtXcYRv34Ww4M36hZzn7URzoiCvabtf0yctEQAhfFpo6Y/rAqQm
 7uJSfVssxae0QXqhfC4m5LE0zw6Xl2Mv8shxWrlI8hHoF77eVUe8jJo8EtfEcJbj0t22ZHJlwJj
 Np1Y/Q9F2h8kJTScvHnfwkmrAKLn9upCiPQQ7E+QDF0LP8fMed8pY4GT779n9W2duZf5N0+eRlz
 Wcsp9jxQmdfHpRYZvfrWqvJ4s5Rkpa+NkJFdlCXlDeVk1F3G0i6vsth2vM85UNDmIWr2F1Xji6o
 UIN9Vrww/2vX0/Hct0ZNg9Ss7cVckIVyxc4QmLsRI17gVPztD+FLrDOWXod1qSTIGJRT00SKJJD
 O/TGjCJWJo6cQJLis4gJ34Fy8Fza66t/DNNluaJSkSYSHZzW1iX5CsjPsBTKT8N5Larxa+epgi3
 iRy2FHLgA/GMOCeCP2jOGNjx8Gnz1ECU6tNdYV4Hu38n2ovebY4jX+OhCLi0my0QSuBdvDga9SE
 3ahH/6ZkawbaQqw==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

KTD2801 is a LED backlight driver IC found in samsung,coreprimevelte.
The brightness can be set using PWM or the ExpressWire protocol. Add
a DT binding for the KTD2801.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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



