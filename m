Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8047F9387
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjKZPrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjKZPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:47:17 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED2719A3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:46:53 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso5253759e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701013611; x=1701618411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvYwFATyIvmV3iv8lQG/WHQRHMyZF8eGnwS5y8SkTH4=;
        b=Rwo9PSiEY0rmCczZ8NlaZ3zxS283qeWPXOIUVyWrZfxEIMR1QdyTS+olS78/HZlrxW
         IT+yu4Uq4W/w6C89edwYNctssFxMAA44gLAZt8Fa+8b3oDzZaLEZzBgjJ+2IS+AaIOic
         EOj3H2YR5ljopANfZGMv097HyumuhKhXE7yBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701013611; x=1701618411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvYwFATyIvmV3iv8lQG/WHQRHMyZF8eGnwS5y8SkTH4=;
        b=edUrx2++SWH6tmMvPUQ940USdTr9YmckgOKumwZTkp+BXgzxauSNPe74qRsa1ClXG4
         6ETAZeHSTL5M5sagm1MFWC7hWw8snrp3jBZ90dLOhHTn3FpO5b5blp8Kqn6gC9Xi2MGy
         rnwc+3Bdn4+SkUaldZBsGhXjFzAcMy3IN9m7ljTr7zuLeM8ipv+YoJ0DtLPaOC1PZbS1
         paK/OtCE8xAZCubw3XKwqJyYqW9f6jsl2k9H2x8e7w8RJv8QXT9EulvKi67zIt46AiOi
         rA3FzsuRr9ABtfPIXFMnFuRWuc7zxNx4KkL5jyqoxzXE+otz0tmtc446skYJlIVH9dRH
         2btg==
X-Gm-Message-State: AOJu0Yyx3H/YxyKTGUiTrRsB22cftbQGnfqlXMxgwkLHhgpBZDEtZvf/
        tvyMZbxnsUazXVGYCkeTY0kISY3msQeWMmCTaRgFeg==
X-Google-Smtp-Source: AGHT+IFRT43+21ag7z11Y59I4mpDM38vIvgjT3QRpkqVhX7AzY8w5hDd/69qhJ30RrFss7BIU9kZYA==
X-Received: by 2002:ac2:5a0f:0:b0:509:4f70:f6f3 with SMTP id q15-20020ac25a0f000000b005094f70f6f3mr6257684lfn.64.1701013611530;
        Sun, 26 Nov 2023 07:46:51 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-244-100-54.retail.telecomitalia.it. [95.244.100.54])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906591800b009fdc684a79esm4656158ejq.124.2023.11.26.07.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 07:46:51 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 07/11] dt-bindings: display: panel: Add Ilitek ili9805 panel controller
Date:   Sun, 26 Nov 2023 16:44:59 +0100
Message-ID: <20231126154605.15767-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231126154605.15767-1-dario.binacchi@amarulasolutions.com>
References: <20231126154605.15767-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Add documentation for "ilitek,ili9805" panel.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Add $ref to panel-common.yaml
- Drop port, reset-gpios, and backlight
- Set port and backlight ad required
- Replace additionalProperties with unevaluatedProperties

 .../display/panel/ilitek,ili9805.yaml         | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
new file mode 100644
index 000000000000..e08af5f0b2e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9805.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ILI9805 based MIPI-DSI panels
+
+maintainers:
+  - Michael Trimarchi <michael@amarulasolutions.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - giantplus,gpm1790a0
+      - const: ilitek,ili9805
+
+  avdd-supply: true
+  dvdd-supply: true
+  power-supply: true
+  reg: true
+
+required:
+  - compatible
+  - avdd-supply
+  - dvdd-supply
+  - reg
+  - reset-gpios
+  - port
+  - backlight
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
+            compatible = "giantplus,gpm1790a0", "ilitek,ili9805";
+            reg = <0>;
+            power-supply = <&reg_display>;
+            avdd-supply = <&avdd_display>;
+            dvdd-supply = <&dvdd_display>;
+            reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL05 */
+            backlight = <&backlight>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&mipi_dsi_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.42.0

