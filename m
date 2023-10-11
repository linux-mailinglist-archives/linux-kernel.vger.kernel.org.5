Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9130B7C4911
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjJKFMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjJKFMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:12:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578C39E;
        Tue, 10 Oct 2023 22:12:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c724577e1fso51524305ad.0;
        Tue, 10 Oct 2023 22:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697001133; x=1697605933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AAeg5rnm7dhw3iuQdfCGB3ANcuPT0KR7q/ABYzaFXeE=;
        b=Ce+qkq9abw8UusYCfjX7/hRyG9dH9pNO81iQgKEvAaSbLU84+KXk3GeupLdqXVqY1H
         Y744YLR8fdxpXinVbN1g19AmojXj+m0G+jUY0TtvnqxOl9zQpBjkpGD1FFS9f85Uysgd
         jqVeZOsWufKdQPP2NIp4wsdRRSmLRakJ+orSD/dPscgDM5l9sK9Mv9TVWi+9MWJtk0y9
         iuV5CeRzI1xi28rZA+/0WdBEhVckt7pDykRGfqySzUBMWlsTB5lq1Z8yw6xd7NXYZCXS
         hu/fQR1Jb3N3bfvyfnjunkP6YJAs7sn+4y8kSd3AOVyxU70/wnm1URfbFXOGa4OO1Njc
         6Jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697001133; x=1697605933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAeg5rnm7dhw3iuQdfCGB3ANcuPT0KR7q/ABYzaFXeE=;
        b=LJeq+CGAAaxTtVOZP0zDM7MuJYIY8d1k8up0hhkfOe1PuIY+uM+fKHhTIGzGchhncs
         jr/e/bRGVzU8g2aZwbCkzS+CLHUQIMnlDxzYmvfYIG4IdzEEezv6NB/nON+5zm1/IXFS
         mRH5kKJD8+rfUg5EhVukKqnHM1gGoO/q9XWvjArYFZyISTy/H07XLpwIzfqPle/s4EuZ
         cRlQ8Yslzq6Jm8dKN+UxEMDDLnkupMGIRWvSFxM/lZlH7YqbkUmpiFMr9a22N+k0r/V9
         7GY8JjOpYfa/zdGHBdtJfwtAGZq7vE0Y8xVWdPql4SGRJXYD+UINn2XRzIg8HkzbQexG
         pPBw==
X-Gm-Message-State: AOJu0YzOhzDbRIx4CpVi0nbL71zOcN/DKOinD9klm5SM4ttdL6zifLry
        yIiGbihxbBTf0Rt0xanKiNgoCiR5YcM=
X-Google-Smtp-Source: AGHT+IEViPR1az4s4UtNoSCznxFPTajeY+X7PBATL8XmnQXXsDDL3tIBxiZqz+OKMpyjEylDJ+kUWw==
X-Received: by 2002:a17:903:1c8:b0:1c8:a63a:2087 with SMTP id e8-20020a17090301c800b001c8a63a2087mr9847818plh.65.1697001133481;
        Tue, 10 Oct 2023 22:12:13 -0700 (PDT)
Received: from localhost.localdomain ([49.205.243.94])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e5cd00b001c5dea67c26sm12777083plf.233.2023.10.10.22.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 22:12:13 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: usb: Add the binding example for the Genesys Logic GL3523 hub
Date:   Wed, 11 Oct 2023 10:41:48 +0530
Message-ID: <20231011051152.133257-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding example for the USB3.1 Genesys Logic GL3523
integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
hub.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
New patch.
---
 .../bindings/usb/genesys,gl850g.yaml          | 28 +++++++++++++++++--
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
index d0927f6768a4..2f6e0c870e1d 100644
--- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
+++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
@@ -22,29 +22,51 @@ properties:
   reg: true
 
   reset-gpios:
+    maxItems: 1
     description: GPIO controlling the RESET# pin.
 
   vdd-supply:
     description:
       the regulator that provides 3.3V core power to the hub.
 
+  peer-hub:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the peer hub on the controller.
+
 required:
   - compatible
   - reg
+  - reset-gpios
+  - vdd-supply
+  - peer-hub
 
 additionalProperties: false
 
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
+
     usb {
         dr_mode = "host";
         #address-cells = <1>;
         #size-cells = <0>;
 
-        hub: hub@1 {
-            compatible = "usb5e3,608";
+        /* 2.0 hub on port 1 */
+        hub_2_0: hub@1 {
+            compatible = "usb5e3,610";
             reg = <1>;
-            reset-gpios = <&pio 7 2 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&vcc_5v>;
+            peer-hub = <&hub_3_0>;
+            reset-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
+        };
+
+        /* 3.1 hub on port 4 */
+        hub_3_0: hub@2 {
+            compatible = "usb5e3,620";
+            reg = <2>;
+            vdd-supply = <&vcc_5v>;
+            peer-hub = <&hub_2_0>;
+            reset-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
         };
     };
-- 
2.42.0

