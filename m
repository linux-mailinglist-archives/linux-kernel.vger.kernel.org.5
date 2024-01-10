Return-Path: <linux-kernel+bounces-22404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B28CB829D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F67F288302
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF454C601;
	Wed, 10 Jan 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ASB0evTS"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404CD4BAAC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-40e43e489e4so47907175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1704899657; x=1705504457; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Sy3lixVdO+ssOCBS2YWjdDhiY4KhMhsBIz9dLLKsi4=;
        b=ASB0evTSIyJ8rkwyCgCQB8gDS1MCsjrs8/UyM1tuBnDUmNTEioQH826cFFsRzEQ22f
         EAo6E4bvBxQRW2elm9IoRYviJCmaPSXWYwfkwdBuxFKf7bTyHZJfPju2QOCr5uhCfI5W
         AA3FpKt1LVeru6hveBIIsKi37ts+ygrHk1A+ugBDNcmDf1x/0do+Jf7QWM5gRGLkCK/e
         g503dt0Hcz1WyA4QBK1e7hemkiW+n7UKFzlXtnNAKDv7rxlb/riZUPfUm7E8/3fYDYR5
         Y9YYDRMrOBzEeP0ttaFQE9DBru0FB0ezPko7GURpB+Y7r15OfyarrWN8gqxRX8X2LUxO
         37zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704899657; x=1705504457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Sy3lixVdO+ssOCBS2YWjdDhiY4KhMhsBIz9dLLKsi4=;
        b=H29SYyU7H/PDJqTxqblXTKPxAqqpz0HiTQepjdImz53G+l/58bQgobdOA6JXTBmllF
         HeFAZ8qIcB62XR9j4owEkC5EvZ+m6/nnhMsFGmutrvxE7FVtzuQ+V93uNpEDZsaW7RYI
         snVH1r2AOBH/guZF7gxdmTjI9VWccC+cMDMvgh2FKoj6XcFORlzHW6qbueommNaIJ7dX
         +/4+ayQBLz/NOIZQC2qPMfSI6xNrR/gXLtqQy6UwCRvMJKTH76UbHn5U6dddvDX0nDCy
         tiWyzTz6CL5DqUU/hvaY1IyN8n0H6NivzuF1i8KB6NsP1Sg6DpBODJAhfoXOjOjsTEJh
         L8OQ==
X-Gm-Message-State: AOJu0YxMdcNzdyCAvff7PpxLfCWCBfgumDip2f0XRQxXQJ71XR+tHCRB
	7ixQ7GVV1NxqaAP4kRl+tqF2mCeD6ZxfMw==
X-Google-Smtp-Source: AGHT+IGVu1Xwg6HHebOGdxAq74eDIEF0T/L/qFlmD5lnH0vOca8XN01eTTuA9zLK7Yh+9y4To+F4xA==
X-Received: by 2002:a05:600c:310f:b0:40e:3ab9:102d with SMTP id g15-20020a05600c310f00b0040e3ab9102dmr661174wmo.181.1704899657574;
        Wed, 10 Jan 2024 07:14:17 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id jx22-20020a170906ca5600b00a27a25afaf2sm2174517ejb.98.2024.01.10.07.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 07:14:17 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 10 Jan 2024 16:14:08 +0100
Subject: [PATCH v2 1/4] dt-bindings: display: panel: Add Himax HX83112A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240110-fp4-panel-v2-1-8ad11174f65b@fairphone.com>
References: <20240110-fp4-panel-v2-0-8ad11174f65b@fairphone.com>
In-Reply-To: <20240110-fp4-panel-v2-0-8ad11174f65b@fairphone.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4

Himax HX83112A is a display driver IC used to drive LCD DSI panels.
Describe it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../bindings/display/panel/himax,hx83112a.yaml     | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml
new file mode 100644
index 000000000000..22f58f1da9fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/himax,hx83112a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Himax HX83112A-based DSI display panels
+
+maintainers:
+  - Luca Weiss <luca.weiss@fairphone.com>
+
+description:
+  The Himax HX83112A is a generic DSI Panel IC used to control
+  LCD panels.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: fairphone,fp4-hx83112a-djn
+      - const: himax,hx83112a
+
+  vdd1-supply:
+    description: Digital voltage rail
+
+  vsn-supply:
+    description: Positive source voltage rail
+
+  vsp-supply:
+    description: Negative source voltage rail
+
+  reg: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vdd1-supply
+  - vsn-supply
+  - vsp-supply
+  - port
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
+            compatible = "fairphone,fp4-hx83112a-djn", "himax,hx83112a";
+            reg = <0>;
+
+            backlight = <&pm6150l_wled>;
+            reset-gpios = <&pm6150l_gpios 9 GPIO_ACTIVE_LOW>;
+
+            vdd1-supply = <&vreg_l1e>;
+            vsn-supply = <&pm6150l_lcdb_ncp>;
+            vsp-supply = <&pm6150l_lcdb_ldo>;
+
+            port {
+                panel_in_0: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+
+...

-- 
2.43.0


