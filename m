Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7407E1BDB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjKFIV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjKFIVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:21:24 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0DB1B2;
        Mon,  6 Nov 2023 00:21:17 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-542d654d03cso6802809a12.1;
        Mon, 06 Nov 2023 00:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699258876; x=1699863676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAkE6N58iv9ZlL35+7s9gY4pQHaPFju6clZQFlGVEvg=;
        b=aTUwTWIULmOQDpVlQQ7AS1fkELni6W6YUvc3hP61PlxVcXXVDPp0yf7hA/x/6eki0A
         0KE+slNoRFjwS1FuywnUZxqO3OfqNp2KOTbOVha/TYl0bpWIfyC24dLmwMb0sL7sp0U5
         jETc/oDAehgi+Vr/ioUliDqhc/9DUlrQFkCd8Eh8bcuysZ42hiXovlEpjQVbv3e+1u1l
         7aGHJpCSkDH+2GVk6nZAF7rk1FE9I0cyMoc+GPYsmftsvX9D6hbHaUQHe5BUnMyjZ9Ca
         hO32qRVk5jmHnr4A2dqNx6k8IEM9p5s7vZpnTYs/BfCTQgz9sgo4YzCkwX6LMohxibgc
         9mdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699258876; x=1699863676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAkE6N58iv9ZlL35+7s9gY4pQHaPFju6clZQFlGVEvg=;
        b=arwW765zBVajCskmx9FUQbv79IH3LiKWNT+BTWJVIuD5uAovIWNCJ8eHoF/7TdcpkY
         xaPCIMnJ6gW7CuvXi3hBNkBto08CfiiVhbDPYp+vPEhYTbgCzwfP4gOsxvNomiFfKXVR
         Pu84U//S7jv2epegABj/390czMOOFHI6GIe0+hdTtaUKucFrY8yoWvnYDrFial8GH+bf
         oagSbOrivLs9s9K6W/O3yxfsglD7YZ4/NHrQlDKq91mJW11SYzD/MoG07vfPZ4v9Y+5u
         u9a7iJHgwvGibjuQVb5dyXa9KHLuRk8Ddc9TDtwDjZuGPXK0T5D26uAph5h66ump+nqC
         KcRQ==
X-Gm-Message-State: AOJu0YyjRnjQJKU2MTqExY1AeJpqMsDRdQ2GgSxPahP67i4lzOGla9bq
        XXZGwibiSDDeBwVnJbaoRL8=
X-Google-Smtp-Source: AGHT+IGg0/pfCAk54rdqXv1lCo2XKWLAzW1VHX02HrHzOGvjf0VULJqs/AvV6snZhUnV6cmS2NEYSw==
X-Received: by 2002:aa7:c494:0:b0:53d:e5d7:4148 with SMTP id m20-20020aa7c494000000b0053de5d74148mr26327795edq.1.1699258875791;
        Mon, 06 Nov 2023 00:21:15 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-109.cust.vodafonedsl.it. [188.217.59.109])
        by smtp.gmail.com with ESMTPSA id x1-20020a50ba81000000b005434e3d8e7bsm4221884ede.1.2023.11.06.00.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:21:15 -0800 (PST)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     sakari.ailus@linux.intel.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, mhecht73@gmail.com,
        linuxfancy@googlegroups.com, laurent.pinchart@ideasonboard.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v13 2/3] media: dt-bindings: alvium: add document YAML binding
Date:   Mon,  6 Nov 2023 09:20:57 +0100
Message-Id: <20231106082102.368937-3-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106082102.368937-1-tomm.merciai@gmail.com>
References: <20231106082102.368937-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes since v9:
 - Removed alliedvision,lp2hs-delay-us property as suggested by SAilus

 .../media/i2c/alliedvision,alvium-csi2.yaml   | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
new file mode 100644
index 000000000000..d3329e991d16
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
@@ -0,0 +1,81 @@
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

