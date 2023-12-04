Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859798037BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345919AbjLDOpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbjLDOpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:45:18 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECC719A7;
        Mon,  4 Dec 2023 06:44:49 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d0538d9bbcso27099765ad.3;
        Mon, 04 Dec 2023 06:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701701088; x=1702305888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eRLjlThPLhM7zIw6XvrWrrbob10TfqT1M4cq4iJfTE=;
        b=VtDFUM3IswYKjFC6VBYY7ucRJ7NImAHtJ94e7EcNY4Ht6AIzWAK3y6TZHFqSQr6AJf
         XrhMZTZeN6wXY7kJozyRPTL/A2d+7GjFWKTHihb7rLqQpZyoXiJ78+6OgkAZS8DnKcCd
         a2G7H2jxIQL9+eVzgw5JWugYu8HFhRdxoE0B5i51yrEt/lJoBjj8LCtOtO6EOmJW3Xfk
         8d8Bp59lEVdmQkCUmVbHud0ww3o+sg3//xCr2E0bE6wTpdtwqiuPlen63FNW0gEkVfsj
         4bB4yuWXZ/i7J4OOTGGmEDSNx2qH8pWzwcoWsg5oJMbQoIriV2mZKcVMCs5DF4KY7fpU
         AoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701088; x=1702305888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eRLjlThPLhM7zIw6XvrWrrbob10TfqT1M4cq4iJfTE=;
        b=fiRXS3PPUJ5vjvm/QvGWV7sNdQph3E6y3aDRORDR5NToKr5IG+rdLUqhKM63qx46TD
         7VhTlrZpZRie6n7fwmdX/BGve/opMukD/KFFNDi6pXm6ZSa0Mw+EIQR0P9lEkrtP0qhP
         AYSTcs1lZp450gDDKB9LQAMBYW/WHgLM1y/TItRpnmoQd0PsThZb7Bid540KKhD42m1Z
         hmneSlzt+NsqJ+q0wkwmKHcbIvKYpIUsfEldza8DwHSRAUOUKyNTKvLIliwgdc5v6dU9
         /5UUJt0cstFURbHOn3WKSCWDee6ci/oWZ6cB67/uPIRFYlfYRYoRzQdnDqZZ17FyM9w6
         Wd6w==
X-Gm-Message-State: AOJu0YzZ6Mp2m76gHEr2iWJ8x7vfcPL3qgs9KF5Okhvmm8BR01GRFVPC
        9n09tkdC88utDtBWb3hnm14=
X-Google-Smtp-Source: AGHT+IGTgdMm1IrP9P0QKhOOvICj9TIyyaKAwxubN0u1nWy9phktn3LnrrLnNFT21DIFr3oeklgtcg==
X-Received: by 2002:a17:903:647:b0:1d0:8e61:102a with SMTP id kh7-20020a170903064700b001d08e61102amr2321909plb.90.1701701088620;
        Mon, 04 Dec 2023 06:44:48 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.26])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001cfb99d8b82sm6446815plk.136.2023.12.04.06.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:44:48 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-amlogic@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: usb: Add the binding example for the Genesys Logic GL3523 hub
Date:   Mon,  4 Dec 2023 20:14:25 +0530
Message-ID: <20231204144429.45197-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204144429.45197-1-linux.amoon@gmail.com>
References: <20231204144429.45197-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding example for the USB3.1 Genesys Logic GL3523
integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
hub.

For onboard hub controllers that support USB 3.x and USB 2.0 hubs
with shared resets and power supplies, this property is used to identify
the hubs with which these are shared.

GL3523 has built-in 5V to 3.3V and 5V to 1.2V regulators, which serves
power to the USB HUB, it uses 5V power regulator.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V6: fix the description of the regulators
Updated the commit message for regulator updates.
add reviewed by Conor Dooley
[1] https://lore.kernel.org/all/20231130053130.21966-2-linux.amoon@gmail.com/
v5: upgrade peer-hub description : Conor Dooley
[0] https://www.genesyslogic.com.tw/en/product_view.php?show=67 [Block Diagram]
v4: Fix the description of peer-hub and update the commit message.
Schematics of the Odroid N2+
https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.6_20210121.pdf
V3: fix the dt_binding_check error, added new example for Genesys GL3523
v2: added Genesys GL3523 binding
v1: none
---
 .../bindings/usb/genesys,gl850g.yaml          | 65 +++++++++++++++++--
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
index ee08b9c3721f..c6f63a69396d 100644
--- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
+++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
@@ -9,9 +9,6 @@ title: Genesys Logic USB hub controller
 maintainers:
   - Icenowy Zheng <uwu@icenowy.me>
 
-allOf:
-  - $ref: usb-device.yaml#
-
 properties:
   compatible:
     enum:
@@ -27,12 +24,46 @@ properties:
 
   vdd-supply:
     description:
-      the regulator that provides 3.3V core power to the hub.
+      The regulator that provides 3.3V or 5.0V core power to the hub.
+
+  peer-hub:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      For onboard hub controllers that support USB 3.x and USB 2.0 hubs
+      with shared resets and power supplies, this property is used to identify
+      the hubs with which these are shared.
 
 required:
   - compatible
   - reg
 
+allOf:
+  - $ref: usb-device.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - usb5e3,608
+    then:
+      properties:
+        peer-hub: false
+        vdd-supply: false
+        reset-gpios: true
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - usb5e3,610
+              - usb5e3,620
+    then:
+      properties:
+        peer-hub: true
+        vdd-supply: true
+        reset-gpios: true
+
 additionalProperties: false
 
 examples:
@@ -49,3 +80,29 @@ examples:
             reset-gpios = <&pio 7 2 GPIO_ACTIVE_LOW>;
         };
     };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    usb {
+        dr_mode = "host";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* 2.0 hub on port 1 */
+        hub_2_0: hub@1 {
+            compatible = "usb5e3,610";
+            reg = <1>;
+            peer-hub = <&hub_3_0>;
+            reset-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&vcc_5v>;
+        };
+
+        /* 3.1 hub on port 4 */
+        hub_3_0: hub@2 {
+            compatible = "usb5e3,620";
+            reg = <2>;
+            peer-hub = <&hub_2_0>;
+            reset-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&vcc_5v>;
+        };
+    };
-- 
2.42.0

