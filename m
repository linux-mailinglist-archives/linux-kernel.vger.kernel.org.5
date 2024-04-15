Return-Path: <linux-kernel+bounces-145510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CC98A5732
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C553F284889
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE950811E7;
	Mon, 15 Apr 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="KJ4Vk7g0"
Received: from mail.mainlining.org (mainlining.org [94.241.141.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57A7FBA6;
	Mon, 15 Apr 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.241.141.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197479; cv=none; b=fZnci/HK4qf3L1DH5dVXDznMaVdXboZEtFZdtloNWAqkJTcKVw0l8C1BXCh2ke3wE0dIb58cVU/pMQDekqnJbi9ZLAN/fsg4DxGHFkfSSdSXblxKrV12t2saZ82OwBas6OuK87N66ILoXSJGu8W9droNNwQdizRwho8GtVxq+jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197479; c=relaxed/simple;
	bh=CBDbfaw1bQFqtDrtwKojlcf8PInrM02KOlK7NoLMrso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ipKpudc/SrpyXomYR5V2srhGThzf6fI+k55dfITmY58rt3k4uQwLXJ2ifTmWPX6pHXbvolo1vrzNOS3yVvrGRG6N9l9N5WvfyRsKjqX1klYC/1oeOxU9ScCegoDamdy9LzMw0ppGxZ0MmriARNFtu2sxCQyvdIry/LCxnmIjLu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=KJ4Vk7g0; arc=none smtp.client-ip=94.241.141.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from david-ryuzu.localdomain (ipbcc3a836.dynamic.kabel-deutschland.de [188.195.168.54])
	by mail.mainlining.org (Postfix) with ESMTPSA id 22498E20B1;
	Mon, 15 Apr 2024 16:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1713197470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VYQhhD2wbjbQiZRixP3ePAg/EmEMxo1zpO0oJAxY/Y=;
	b=KJ4Vk7g0dcIYyOfrJWqX3owpvSbFPaY8TpnKI6BykuXh3UvOwbFqD1szN6aZgw7/7u9WDv
	+O27UJRRQSiq+oJWEsFU5V8eCS7m75OKL/Jc+xi818QN0EDjr/4M7/86Mpx3RnrcZ/j1Ha
	IIvrwi5DZuswnbVxeDylk9Sk6znhx1QAJCRmMIWfhq7SsqfJSZu/KEfxqR/bhbjIHsUvLs
	irWjuvFm9jQ4ZuPm65VwjuRyPKG5B6OK0MGzi+ipoVTFG3IuZKa7xeuk2bF9QErcycJAbC
	6y1YAHyhGNp1eaXgQ6MhKFFozFIyoeRZlCczZvpGtV+fGo0JazUp9iV+mA9uRw==
From: David Wronek <david@mainlining.org>
Date: Mon, 15 Apr 2024 18:10:41 +0200
Subject: [PATCH v2 1/2] dt-bindings: display: panel: Add Raydium RM69380
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-raydium-rm69380-driver-v2-1-524216461306@mainlining.org>
References: <20240415-raydium-rm69380-driver-v2-0-524216461306@mainlining.org>
In-Reply-To: <20240415-raydium-rm69380-driver-v2-0-524216461306@mainlining.org>
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
 phone-devel@vger.kernel.org, David Wronek <david@mainlining.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713197467; l=2952;
 i=david@mainlining.org; s=20240121; h=from:subject:message-id;
 bh=CBDbfaw1bQFqtDrtwKojlcf8PInrM02KOlK7NoLMrso=;
 b=kK7TaB4wXGFsvGU4WlAVjoC3cK3LbPsUJTOHNP8VyvCR7ToGMcJqk6hPx/m5BHuqFY3pKQom9
 vkOkLaVrUXOD1n7NewYbfVV2KipTUFht2Wo7aT8hyx+lT0xQ5ESsgBX
X-Developer-Key: i=david@mainlining.org; a=ed25519;
 pk=PJIYyFK3VrK6x+9W6ih8IGSJ5dxRXHiYay+gG1qQzqs=

Raydium RM69380 is a display driver IC used to drive OLED DSI panels.
Add a dt-binding for it.

Signed-off-by: David Wronek <david@mainlining.org>
---
 .../bindings/display/panel/raydium,rm69380.yaml    | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml
new file mode 100644
index 000000000000..0ac7d033cbe0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml
@@ -0,0 +1,91 @@
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
+  The Raydium RM69380 is a generic DSI panel IC used to control
+  OLED panels.
+
+allOf:
+  - $ref: panel-common-dual.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - lenovo,j716f-edo-rm69380
+      - const: raydium,rm69380
+    description: This indicates the panel manufacturer of the panel
+      that is in turn using the RM69380 panel driver. The compatible
+      string determines how the RM69380 panel driver shall be configured
+      to work with the indicated panel. The raydium,rm69380 compatible shall
+      always be provided as a fallback.
+
+  avdd-supply:
+    description: Analog voltage rail
+
+  vddio-supply:
+    description: I/O voltage rail
+
+  reset-gpios:
+    maxItems: 1
+    description: phandle of gpio for reset line - This should be active low
+
+  ports: true
+  reg: true
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - vddio-supply
+  - reset-gpios
+  - ports
+
+additionalProperties: false
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


