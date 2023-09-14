Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F347A09AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbjINPsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241258AbjINPsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:48:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F661FF3;
        Thu, 14 Sep 2023 08:48:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1011294f8f.0;
        Thu, 14 Sep 2023 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694706493; x=1695311293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JqijGATevexodiqwpgWWh8neUeu+NISOC/UOfLz2IU=;
        b=PoeNwb/IhjyDyhTBRq6+sH6XuabY2D4vh+HaN9mAZ9L3VwinT+KcXnj25g6JCqXj09
         slcCXew7Uqv/A7Y2ZU5cMioG4XVcwo5BORzve+9u8Jf0jpZfsnJ3YM99BHClKEHyIkGp
         A9L/3/q0H84je4tTi2au1sqPKOWqpXeM+uWlNs2dudU8XxEd+M0lU+TSFYZ1ht16o6Xz
         0WS+pNd5cBsEUC8OqcMRewi/DHIhO+p2YQgoz8vvtaG8rIzj0Flh25GqxSoLGdjipG53
         dLKd70KKFsPIuwPwyCNJOSRODt5kA7qfn5du0npiTjQdkrkb+iBcXMknGzXPyt2CppKK
         sxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694706493; x=1695311293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JqijGATevexodiqwpgWWh8neUeu+NISOC/UOfLz2IU=;
        b=I56EFNmdFoFc6ZDThI07825P4SiGEB5FFynQXco4pskilwwTYyru4YFCaaY37BKOSF
         wfF7sDhk/cDZmmnKsiz3OzQRzksYGp8+NzVeeo+VSakeiTR+CaQG/mN0jV+c4IvVdn7C
         LgqRkqxW5Lxr2vXRkAiA/PdW7PDGcvxG3dDc1RudOLAblLqVHz3yCwIduxgKZEZxN9u1
         8QPPdEeg132QJO/dnDwtcUAfghZm8IXnQUV0+HD0l/QYJ9TaeJnFSAesstWGggNySQjd
         Zgd6PK8uvvtEJqHivFizrPJzC9w0/YplI5GL4r6CCuTn9DlRz6hR5918u0I3bD+rWZHh
         uaag==
X-Gm-Message-State: AOJu0YzkFRhHeOuBeUaRYROHJPdx8Xq+X0hPUWOExabEodUsttwlbXd4
        us4x4zEb6/PK8JI+LY9D2RU=
X-Google-Smtp-Source: AGHT+IGfr0epp6GKwOUQ1Bn38d8YU+tLMrL5M1UVMssjFHX9xasrYIFC0diJTkN3VSRaxrHtgVMokQ==
X-Received: by 2002:adf:fd0a:0:b0:319:6753:8104 with SMTP id e10-20020adffd0a000000b0031967538104mr4798650wrr.47.1694706492665;
        Thu, 14 Sep 2023 08:48:12 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-54-79.cust.vodafonedsl.it. [188.217.54.79])
        by smtp.gmail.com with ESMTPSA id f13-20020adff44d000000b0031c79de4d8bsm2071169wrp.106.2023.09.14.08.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:48:12 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        linuxfancy@googlegroups.com, hdegoede@redhat.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Martin Hecht <martin.hecht@avnet.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/3] media: dt-bindings: alvium: add document YAML binding
Date:   Thu, 14 Sep 2023 17:47:54 +0200
Message-Id: <20230914154758.1795663-3-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914154758.1795663-1-tomm.merciai@gmail.com>
References: <20230914154758.1795663-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation of device tree in YAML schema for the ALVIUM
Camera from Allied Vision Inc.

References:
 - https://www.alliedvision.com/en/products/embedded-vision-solutions

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes since v1:
 - Fixed build error as suggested by RHerring bot

Changes since v2:
 - Fixed License as suggested by KKozlowski/CDooley
 - Removed rotation property as suggested by CDooley/LPinchart
 - Fixed example node name as suggested by CDooley
 - Fixed title as suggested by LPinchart
 - Fixed compatible name as suggested by LPinchart
 - Removed clock as suggested by LPinchart
 - Removed gpios not as suggested by LPinchart
 - Renamed property name streamon-delay into alliedvision,lp2hs-delay-us
 - Fixed vendor prefix, unit append as suggested by KKozlowski
 - Fixed data-lanes
 - Fixed blank space + example indentation (from 6 -> 4 space) as suggested by KKozlowski
 - Dropped status into example  as suggested by KKozlowski
 - Added vcc-ext-in supply as suggested by LPinchart
 - Dropped pinctrl into example as suggested by LPinchart

Changes since v3:
 - Fixed vcc-ext-in-supply description as suggested by LPinchart
 - Fixed alliedvision,lp2hs-delay-us description as suggested by LPinchart
 - Added maximum to alliedvision,lp2hs-delay-us as suggested by LPinchart
 - Collected Reviewed-by tag from LPinchart

Changes since v4:
 - Fixed id as reported by RHerring bot and LPinchart
 - Add minimum into alliedvision,lp2hs-delay-us as suggested by CDooley
 - Tested using make dt_binding_check DT_SCHEMA_FILES=alliedvision,alvium-csi2.yaml

Changes since v5:
 - Fixed alliedvision,lp2hs-delay-us description as suggested by CDooley
 - Collected CDooley Reviewed-by tag

 .../media/i2c/alliedvision,alvium-csi2.yaml   | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
new file mode 100644
index 000000000000..327cd5421257
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium-csi2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allied Vision Alvium Camera
+
+maintainers:
+  - Tommaso Merciai <tomm.merciai@gmail.com>
+  - Martin Hecht <martin.hecht@avnet.eu>
+
+allOf:
+  - $ref: /schemas/media/video-interface-devices.yaml#
+
+properties:
+  compatible:
+    const: alliedvision,alvium-csi2
+
+  reg:
+    maxItems: 1
+
+  vcc-ext-in-supply:
+    description: |
+      The regulator that supplies power to the VCC_EXT_IN pins.
+
+  alliedvision,lp2hs-delay-us:
+    minimum: 1
+    maximum: 150000
+    description: |
+      Low power to high speed delay time.
+
+      If the value is present, the camera forces a reset of all
+      D-PHY lanes for the duration specified by this property. All lanes
+      will transition to the low-power state and back to the high-speed
+      state after the delay. Otherwise the lanes will transition to and
+      remain in the high-speed state immediately after power on.
+
+      This is meant to help CSI-2 receivers synchronizing their D-PHY
+      RX.
+
+  port:
+    description: Digital Output Port
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          link-frequencies: true
+
+          data-lanes:
+            minItems: 1
+            items:
+              - const: 1
+              - const: 2
+              - const: 3
+              - const: 4
+
+        required:
+          - data-lanes
+          - link-frequencies
+
+required:
+  - compatible
+  - reg
+  - vcc-ext-in-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        alvium: camera@3c {
+            compatible = "alliedvision,alvium-csi2";
+            reg = <0x3c>;
+            vcc-ext-in-supply = <&reg_vcc_ext_in>;
+            alliedvision,lp2hs-delay-us = <20>;
+
+            port {
+                alvium_out: endpoint {
+                    remote-endpoint = <&mipi_csi_0_in>;
+                    data-lanes = <1 2 3 4>;
+                    link-frequencies = /bits/ 64 <681250000>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.34.1

