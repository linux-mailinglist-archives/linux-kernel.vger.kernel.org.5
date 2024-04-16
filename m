Return-Path: <linux-kernel+bounces-147388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36488A7341
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599DA1F22411
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA07B137766;
	Tue, 16 Apr 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="UgG/gtxC"
Received: from mail.mainlining.org (mainlining.org [94.241.141.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B80E555;
	Tue, 16 Apr 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.241.141.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292275; cv=none; b=Ei+E91wfOhUTYcUBki9JYvhlkWJ60i55at+2D+rDLwSqqsydoaQDUuKDvgNapeJTw/s8z/ywFNk9uC31octy2Cnm0VH/7KrEe5R/Wt2SsNOwZcbInMuy1heeNVR/JpsgHVq9+HlCNE0g2SwzR0TFdzYmw2lJvLFaavI0v+uOrug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292275; c=relaxed/simple;
	bh=H4PFzqvmKwXu3PaRjVJ2GZOn4+++zfi7W3Cn2y64I2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DpAJlKxDSlJc5RHdSzW2O71oL6y4E7vKn7XUgofv/j8r+cu4IRb7f80qDg50kz0A9993NtOZfpeZtIEtxDYawGY/hfbw0Bj+sh6lazR/XJoQ6iwoXG0Tq4MT+BJ0l+ydDKFeYk3aXXj+mFhE/Lg9bCUWmWctQV1Sk7mt50DUu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=UgG/gtxC; arc=none smtp.client-ip=94.241.141.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from david-ryuzu.localdomain (ipbcc3a836.dynamic.kabel-deutschland.de [188.195.168.54])
	by mail.mainlining.org (Postfix) with ESMTPSA id 3A167E20E8;
	Tue, 16 Apr 2024 18:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1713292272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RnGPoQ0r3htGk+5p1b1VSDz+6cHpvgMQDQZH9FEMlN4=;
	b=UgG/gtxCkxIJEfg7a7fu45DFLfcwBY0E+RUDaQpVsMIE9WnflnfqMQ8u1GvK8WXQtJgVzX
	iOdogn3yqI+WsfO0ZkRWs2A1TpuyyF/c5D9dSMlZAeIrDgngMqYHHAy6rxBPfPU/4Ea30B
	YprKphN89Dd86Qu0vlh/zmRG3CwLlFfIC0TlDzgvzil2riGp4673fmdMeKnYa5bLqRGEs2
	/YEL2IvF2GwT5lxiX4fhHh0lFJ1As10OlE2Z9/CM1g4RBZLCaGbCQC2Rkc0SHzb+nXBYS2
	S2bBVhgT6h2KD1uFGk2PSvKFhFS0a7lUw9aePHhl70OSVZE8cZPkvy4bs51sSA==
From: David Wronek <david@mainlining.org>
Date: Tue, 16 Apr 2024 20:30:48 +0200
Subject: [PATCH v3 1/2] dt-bindings: display: panel: Add Raydium RM69380
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-raydium-rm69380-driver-v3-1-21600ac4ce5f@mainlining.org>
References: <20240416-raydium-rm69380-driver-v3-0-21600ac4ce5f@mainlining.org>
In-Reply-To: <20240416-raydium-rm69380-driver-v3-0-21600ac4ce5f@mainlining.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Daniel Vetter <daniel@ffwll.ch>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713292268; l=3057;
 i=david@mainlining.org; s=20240121; h=from:subject:message-id;
 bh=H4PFzqvmKwXu3PaRjVJ2GZOn4+++zfi7W3Cn2y64I2E=;
 b=8R6vLaLnAFMrla6QeH3sC3y4q+4yQ2ldcUICK1JxwYhChkT0O7xPmnRmNrG+rY/0zIDOUrufg
 z6y3FWAE77RDQ5oDJO7p8/+lzXxBRHydsJIuA54NV3HebqlZhsF2UEi
X-Developer-Key: i=david@mainlining.org; a=ed25519;
 pk=PJIYyFK3VrK6x+9W6ih8IGSJ5dxRXHiYay+gG1qQzqs=

Raydium RM69380 is a display driver IC used to drive OLED DSI panels.
Add a dt-binding for it.

Signed-off-by: David Wronek <david@mainlining.org>
---
Note:
Depends on commit 48a516363e29 ("dt-bindings: display: panel: add common dual-link schema")
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


