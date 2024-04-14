Return-Path: <linux-kernel+bounces-144223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1725C8A4358
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD431C2031E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0041B134CEF;
	Sun, 14 Apr 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="GbQKyzGY"
Received: from mail.mainlining.org (mainlining.org [94.241.141.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF364134432;
	Sun, 14 Apr 2024 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.241.141.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713108694; cv=none; b=k9woZp7Bm7kzc2pIpBtvFcI2SyjFbCNmLXCS8J+0Lkncgf5UXpppHYIuFqjp+greHeNPoApxmMtBkqsk059YR4oieZKOBmy3qoP8oiPtkecXDtxvQsp5OWunzViZZmjTVYtsKArfOWUUz5guQT6GuzbxUm8XxWdlc6JPqIIRnM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713108694; c=relaxed/simple;
	bh=iaVKhaEtwD3vSAsF6Kkc8NkVIHXOiq0xCW909ztf0Zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=orDnF89PxgsZolunzSgbvrF8o46FTeL+Tz+uFwyNHNvHp3Egq1MdyrWXRsRr5YU8pyvI/8geMNWcaum2x772ez2BUmyckcHzB9pPW2UrTbnoscGWQOz5xjiyrTQtbhe6fmqyIHttlAnVNfajZ4/jYfHmPTcgYWWHlb+T1ge6HXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=GbQKyzGY; arc=none smtp.client-ip=94.241.141.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from david-ryuzu.localdomain (ipbcc3a836.dynamic.kabel-deutschland.de [188.195.168.54])
	by mail.mainlining.org (Postfix) with ESMTPSA id 35E83E21DB;
	Sun, 14 Apr 2024 15:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1713108188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtqK3uEi0BtvzaEa+6wDfgaSFywVG1Occvijkka7SVg=;
	b=GbQKyzGY3vX5Ra2kUdZX+6zjq49WnTZR2+JQUMaCTnVtyaSxsX9ZETC035w2ScD/8u5xc0
	SYUfkGYP3lL8zF90Bv7Xr2EG6CFsO+mrz5ehZuUKo1vcFvu8lZgud1Kl+KgZ6QkouT5aBN
	0b+EVqbPQ1mKjwiLVrwu5mIs9lJQLn/4S3LwZCZkvxwd3c1WQtjK1FA35iUom6RhYJLOCB
	5qMjYPGEaV7cnnYnFMOo6GdxBbrDfVrsiUFbWkwM+puAs8Tpy73YSvUqafrmngBP9iAVXW
	afzUr4qLb6YI7a/j9UeLAZkQgJpPttlNgseuz5wm8siMR3LB+gZ2wLiSDtYWCg==
From: David Wronek <david@mainlining.org>
Date: Sun, 14 Apr 2024 17:22:30 +0200
Subject: [PATCH 1/2] dt-bindings: display: panel: Add Raydium RM69380
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-raydium-rm69380-driver-v1-1-5e86ba2490b5@mainlining.org>
References: <20240414-raydium-rm69380-driver-v1-0-5e86ba2490b5@mainlining.org>
In-Reply-To: <20240414-raydium-rm69380-driver-v1-0-5e86ba2490b5@mainlining.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 David Wronek <david@mainlining.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713108185; l=2750;
 i=david@mainlining.org; s=20240121; h=from:subject:message-id;
 bh=iaVKhaEtwD3vSAsF6Kkc8NkVIHXOiq0xCW909ztf0Zw=;
 b=2qWujeaKtp1Jj2aeXeZqqhTLSo63aKqqMsvWwFXS1hqWu0fVA+wqK9mZQDiIL1XWNg5OZ+iDw
 Keo4kVMdbEGCxgW6FOij1pZxgNsX6R69WhP/zr04M0sJWe1OvXxtk6G
X-Developer-Key: i=david@mainlining.org; a=ed25519;
 pk=PJIYyFK3VrK6x+9W6ih8IGSJ5dxRXHiYay+gG1qQzqs=

Raydium RM69380 is a display driver IC used to drive OLED DSI panels.
Add a dt-binding for it.

Signed-off-by: David Wronek <david@mainlining.org>
---
 .../bindings/display/panel/raydium,rm69380.yaml    | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml
new file mode 100644
index 000000000000..9b01b9c22ae9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/raydium,rm69380.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raydium RM6380-based DSI display panels
+
+maintainers:
+  - David Wronek <david@mainlining.org>
+
+description:
+  The Raydium RM69380 is a generic DSI Panel IC used to control
+  OLED panels.
+
+properties:
+  compatible:
+    items:
+      - const: lenovo,j716f-edo-rm69380
+      - const: raydium,rm69380
+
+  avdd-supply:
+    description: Analog voltage rail
+
+  vddio-supply:
+    description: I/O voltage rail
+
+  reset-gpios:
+    maxItems: 1
+
+  reg: true
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - vddio-supply
+  - reset-gpios
+
+allOf:
+  - $ref: panel-common-dual.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - lenovo,j716f-edo-rm69380
+    then:
+      properties:
+        port: false
+        ports:
+          required:
+            - port@1
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "lenovo,j716f-edo-rm69380", "raydium,rm69380";
+            reg = <0>;
+
+            avdd-supply = <&panel_avdd_regulator>;
+            vddio-supply = <&vreg_l14a>;
+            reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    panel_in_0: endpoint {
+                        remote-endpoint = <&mdss_dsi0_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    panel_in_1: endpoint {
+                        remote-endpoint = <&mdss_dsi1_out>;
+                    };
+                };
+            };
+        };
+    };
+
+...

-- 
2.44.0


