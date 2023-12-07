Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60781808A48
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443187AbjLGOTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443314AbjLGOTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:19:08 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3FB26A2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:17:48 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1eb422b412so151340366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701958654; x=1702563454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dqXlBbcQt0R29oSjxr4jyi0yptqDX27ArBU37Ndav8=;
        b=eDB1QVCbg/lpBn07ozpqGioZsE/w+1DmECW3E0AlFA6Z6SEms/egLq8I0IBkfYSAa2
         MKiCEDQuINJIEbu695gVM+gSpeIzhfz+ul6g+ECxZLyk93evMxZ/VM8IGd18XhCPoieI
         9GSWvqBtqTcX+ms4JHsnfek3plfm/obpLZQN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958654; x=1702563454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dqXlBbcQt0R29oSjxr4jyi0yptqDX27ArBU37Ndav8=;
        b=YiZ9kYSWsJBh7QitlzywyndWMrW5lkwoUwnBPHR1lvEfd1MSDxwW8amZBGFudspJ/q
         zhsL21Ts8reJxXY3riaizQPOmsKO5Gne53HL1VMQKh6UXGpLs60y/5iz2s/H/j4YJku2
         pm/m+gtsRxw7jpVH2q4YUzb1ZEPn+uAHl4hUMQgqFOizUR3b2ti3kbne1H3hUoa9xROm
         DiXONlF/zgzIFGTQcJFuhpW9xXsojB8wgU7TZH2udEsWytWBxo+2lvWMYH9Unw64mjfH
         d9jHzsvWAsIBOs/R9Lr45lLff/2NsS9HtSBLyZDGpKgR2Vq009Hgj3oWMyNUee3h8fb3
         55HQ==
X-Gm-Message-State: AOJu0YyxXX8rDqtSfcWcZWPMBp31dSIvXbU1fqvjKlxesZHjjT4vzdOV
        PRspbVKbOB+d8ziKJnJxU4xqr52cOviYOzIMQ/+dTw==
X-Google-Smtp-Source: AGHT+IGUsXPh/1mHOLB8zINVRPtfrNm/VIkLzErWqvPlYmZO9IqYL1s/WHV2wax9+Cs25yBY0eVUtw==
X-Received: by 2002:a17:906:2558:b0:a0f:c538:4612 with SMTP id j24-20020a170906255800b00a0fc5384612mr4598113ejb.28.1701958654342;
        Thu, 07 Dec 2023 06:17:34 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:9bf:959c:3c66:46c2])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906c09800b00a1e814b7155sm885421ejz.62.2023.12.07.06.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:17:34 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
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
Subject: [PATCH v5 05/10] dt-bindings: display: panel: Add synaptics r63353 panel controller
Date:   Thu,  7 Dec 2023 15:16:34 +0100
Message-ID: <20231207141723.108004-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207141723.108004-1-dario.binacchi@amarulasolutions.com>
References: <20231207141723.108004-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

