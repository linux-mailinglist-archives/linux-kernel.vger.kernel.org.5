Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5344808A52
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443316AbjLGOV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443300AbjLGOVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:21:01 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BA9271C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:17:53 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1ceae92ab6so123978666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701958657; x=1702563457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lnfcl+xGcZaVaSiEbrLmOIuOeFLP66KSKvq8kyj8O1U=;
        b=NZ8+Da5fHKMFSu0LpyzL+R+w8s3rY83cQ4VDa9wQuQMpcetGK4oJdS8mzKWBJZVgjh
         C3LaBFFvYY2nyXueOmSQy8kcl9P68LK41z/7VemV1MowCS8UoOf3Yy/JSlJkHOMX1dWJ
         AdzDJf/OW8aCU5n2YFI1ClABXnS/Xseg85Ifc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958657; x=1702563457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lnfcl+xGcZaVaSiEbrLmOIuOeFLP66KSKvq8kyj8O1U=;
        b=aFH9lD8IUlRQfbnBSj+USLFIciLwLf4pBoq0X5kfVu7sX6cnnRXHSX5bGqgUyDoVBj
         4AUj+mmSwl1OG2CI6QVdAL3nbLSJlHiuT9xVEXtbmqXVzhLYcKtz+VjzjGSz1xd/OTyV
         sOkbsPryIrgPEHLEtvqJhUI8orW1646S+DeqXrWVgKWejb7CeMmKw0aILefEC6LSKvgf
         W6MhFKQv8ZBDDwCZNAaqxnRq/fMfeFyjGIFY6GJnr2hTjPCwCdQ8ejoa/RR7otrb+eMx
         /GfO8IcEtt0y2T3oxk9YG5gvmUmtYOLS9Lxoaf2l/nM9w6QVsf1Ishf2/Ip/OdioyoHt
         IMfA==
X-Gm-Message-State: AOJu0YzlNOiUCZJGNiI5nGbGBSxdFWbKONc8NGr4QdW9H/RXIwygDAiX
        Rcf9a83YZa0uu5dRiJGhMQ8mNy/CfEy9oBDpwBdeEA==
X-Google-Smtp-Source: AGHT+IFtossF30BRk7kiXSxr96Y10pvhW8uv10PwvHYm08qEzDZZ582D1xtILrbPaDhUujjEIXgLmQ==
X-Received: by 2002:a17:906:ad0:b0:a1d:7e27:4d28 with SMTP id z16-20020a1709060ad000b00a1d7e274d28mr1399465ejf.146.1701958656739;
        Thu, 07 Dec 2023 06:17:36 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:9bf:959c:3c66:46c2])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906c09800b00a1e814b7155sm885421ejz.62.2023.12.07.06.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:17:36 -0800 (PST)
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
Subject: [PATCH v5 07/10] dt-bindings: display: panel: Add Ilitek ili9805 panel controller
Date:   Thu,  7 Dec 2023 15:16:36 +0100
Message-ID: <20231207141723.108004-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207141723.108004-1-dario.binacchi@amarulasolutions.com>
References: <20231207141723.108004-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Add documentation for "ilitek,ili9805" panel.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v5:
- Add 'Reviewed-by' tag of Krzysztof Kozlowski

Changes in v3:
- Drop power-supply

Changes in v2:
- Add $ref to panel-common.yaml
- Drop port, reset-gpios, and backlight
- Set port and backlight ad required
- Replace additionalProperties with unevaluatedProperties

 .../display/panel/ilitek,ili9805.yaml         | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
new file mode 100644
index 000000000000..f4f91f93f490
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
@@ -0,0 +1,62 @@
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
+          - tianma,tm041xdhg01
+      - const: ilitek,ili9805
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
+            compatible = "giantplus,gpm1790a0", "ilitek,ili9805";
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

