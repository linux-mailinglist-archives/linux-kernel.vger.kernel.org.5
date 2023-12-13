Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F887811420
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441898AbjLMOFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379461AbjLMOFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:05:01 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3928F1AA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:04:54 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bf69afa99so8920389e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702476291; x=1703081091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dqXlBbcQt0R29oSjxr4jyi0yptqDX27ArBU37Ndav8=;
        b=kxbvaXSF/MEAbg8xDALt/cWGtZO8PfqajBEdyKv4Gi1A/U8WV12E4U3Tvb+LJdnoKF
         DxHgjIka9Chmehg1/WDlnX/yJ52UJ5gPBPPqWWJDVzWCQ+sURjphhgbD7RqcFOHZtBi+
         2hSTEfXe/E+vttFd7vciVkQn+KTPoj+H15R7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476291; x=1703081091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dqXlBbcQt0R29oSjxr4jyi0yptqDX27ArBU37Ndav8=;
        b=hek2qc1suRThIUbjHW9FilsU+kKYbmvMc1sENJl+/Q2dqsyK3E3fFTfprwk3S6me5S
         aciPYRYB6I4uJdYNkYqEswVskb+pafdDim8x/eRYEZySrH2T01pKE4cFGdpdm/zDHp1E
         dFm/k1NSGeZSpdp864RYMPkpN3sq9UO6qtoaHT1xuOfosSWu1rdxC/w417DtLRD/q3xY
         DptRxoMTRFtevM5WUmS7xg3IjpilLdIIvuUCrUKdQjiJsqqBd4QbU51KIMUrbRke3XgI
         6Ixnt2UqYTm1/KwuKa3khTg0iXvaWh7BrECuNOIncuRt94//eYui0WdXxDKMp1ZKynWH
         YXBA==
X-Gm-Message-State: AOJu0Yw/GeiBX8Pfa686e5lXx4dSpcIYa86FWR9OvAqrLjkokZ7hdWJA
        OXQ0bXQMUWMM5zuE8WgK/DVHACfGL5U7U4dx3y2R0Q==
X-Google-Smtp-Source: AGHT+IHfw1WlP9inuYGIENHnhTTUJtDuxBwuDowubx41cZfFvg/ZN3KRTyRxbBmkckspL7A9vZiN8g==
X-Received: by 2002:a05:6512:5c3:b0:50b:f9b2:ced with SMTP id o3-20020a05651205c300b0050bf9b20cedmr3452370lfo.22.1702476291575;
        Wed, 13 Dec 2023 06:04:51 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-182-13-188.pool80182.interbusiness.it. [80.182.13.188])
        by smtp.gmail.com with ESMTPSA id sf22-20020a1709078a9600b00a1ca020cdfasm7797635ejc.161.2023.12.13.06.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:04:51 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Subject: [PATCH v6 3/4] dt-bindings: display: panel: Add synaptics r63353 panel controller
Date:   Wed, 13 Dec 2023 15:03:44 +0100
Message-ID: <20231213140437.2769508-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213140437.2769508-1-dario.binacchi@amarulasolutions.com>
References: <20231213140437.2769508-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Add documentation for "synaptics,r63353" panel.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

(no changes since v3)

Changes in v3:
- Add 'Reviewed-by' tag of Krzysztof Kozlowski.
- Replace "synaptics,r63353" compatible with "syna,r63353", as
  required by vendor-prefixes.yaml.

Changes in v2:
- Add $ref to panel-common.yaml
- Drop port, reset-gpios, and backlight
- Set port and backlight ad required
- Replace additionalProperties with unevaluatedProperties

 .../display/panel/synaptics,r63353.yaml       | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml b/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
new file mode 100644
index 000000000000..e5617d125567
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/synaptics,r63353.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synaptics R63353 based MIPI-DSI panels
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
+          - sharp,ls068b3sx02
+      - const: syna,r63353
+
+  avdd-supply: true
+  dvdd-supply: true
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
+            compatible = "sharp,ls068b3sx02", "syna,r63353";
+            reg = <0>;
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
2.43.0

