Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4EA7FE8BA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344466AbjK3Fbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3Fbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:31:53 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4717BC;
        Wed, 29 Nov 2023 21:31:57 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ce3084c2d1so5503665ad.3;
        Wed, 29 Nov 2023 21:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701322317; x=1701927117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtLcNogZL4zUE1VKwwbOaAKoW0e8MSfA/IN4DJLgKRM=;
        b=c44wfmX4wj+fqdkYUVCWpmDjskMRevagcxolJ4qjr4dpnauJzm0uI0hSjiyVZri+Ul
         8p/cO+wA7eCTUwiLifAG72dCOdeuSaWb5rxYMl7YKbu4eMtgErW/fxxvZ05Pt+haVFfc
         UcITO+zT/QdtCNCvObCFzMye0kIVovnO14vCupOQkQgDSu6CkBjcFfLLmvjTxUkc0d9x
         /hNSiahlFlSBlCmhVF3LqJCEi2dybotfgQaRngDSidwzOC5kUpK2IHjfiPu0vBLo2akS
         kfvvWLK4sLSdMlveGrrVeZ2NH+1Re+5333XFRoVFmb09ySsxwyzhQIH5FBrs5O80RWSk
         e+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701322317; x=1701927117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtLcNogZL4zUE1VKwwbOaAKoW0e8MSfA/IN4DJLgKRM=;
        b=aEtlVC+27j8QVRLCkH+l4ygbeUlOPcQwzI/P1m5FVOmiIQwn0pony2axeXpF8iisGm
         iSu6JucOrDu+3S5nSWLKtnUSX/JQkopaiuwubqfAGplT7glKwLvzfEfpss2I/0/ajl0O
         +Sb2iysj2mxKZ8+SsQETR4QGSuLnXmOQ7ORJ1q5S0h46/4UBrsgM5b/ffmiGe+vc06fe
         fHyR1D7ogQaJKcIZVt9qq/FxPHTbfygLL9Y4+Ki7/9iYwzNy7UxSAhFMv1Zy5bHyBC3V
         xmZop9cwkSO/o7WOwhliz7NroG1Blc/WUoJVPNxQsXFLCHFL3Kr2QGvtga9dB0WlCTUS
         1sUg==
X-Gm-Message-State: AOJu0YyfuMZTnAkC2f34j3OI/olAYubeANHyL4SWBcJVc5mQB0XUl6p/
        Ta8hbC3sk+/lquBVddBIIeE=
X-Google-Smtp-Source: AGHT+IGvSDeAfCHQWlmojU1BSM6aAFhh7G+Sujt9p/79qfJ5k9x/f9CssKKroYjciNFXQI2GwHUYFA==
X-Received: by 2002:a17:902:dac1:b0:1cf:edd5:f783 with SMTP id q1-20020a170902dac100b001cfedd5f783mr10924289plx.15.1701322317321;
        Wed, 29 Nov 2023 21:31:57 -0800 (PST)
Received: from localhost.localdomain ([49.205.245.83])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902a5c500b001cfad1a60cesm336330plq.137.2023.11.29.21.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 21:31:56 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: usb: Add the binding example for the Genesys Logic GL3523 hub
Date:   Thu, 30 Nov 2023 11:01:26 +0530
Message-ID: <20231130053130.21966-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130053130.21966-1-linux.amoon@gmail.com>
References: <20231130053130.21966-1-linux.amoon@gmail.com>
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

[Conor Dooley: upgrade peer-hub description]
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
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
index ee08b9c3721f..499192ea4074 100644
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
+      phandle to the regulator that provides power to the hub.
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

