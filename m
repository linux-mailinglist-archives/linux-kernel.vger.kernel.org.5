Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D448376BEC8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjHAUvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjHAUvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:51:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CC019B7;
        Tue,  1 Aug 2023 13:51:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso66969465e9.0;
        Tue, 01 Aug 2023 13:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690923094; x=1691527894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9IES0zos/bI6j0U8igIT/6JUvKE2fcDpLlO5bVCh6r0=;
        b=oCB4w+Gl+D2t7lRzLVAUJXr4f6u1jnWPnypk++jST37wqxR5pxyBb70GVGYfhMWU1D
         j7VguKVgdlpCzx1w9Bl/pDLq/2P3eSuaqTPzG2ec33opLTBdGw36aK17xyPIwBUh6dXc
         sf7knAsqpCbLjHoguX0F1rA48/YIZvB89S+dzF00qPBEIkD07142tbmOGSbSRITR6FdM
         c4fmD4uy+RBueRcghpX6n8xRGpNMoqcqdgSlqY3SLEKtcOTY+qeQvd4r+SLQAUgSzzvL
         xON6UFP6vjTcJa0MRLve/tS9t4E6mTilvWMQRayTz5gKqqZ1D2TWJil/d8a7aTbia2KU
         LySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690923094; x=1691527894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9IES0zos/bI6j0U8igIT/6JUvKE2fcDpLlO5bVCh6r0=;
        b=Y4kdGUxzAXtWwHL7MlXF4HEL56CpchiOHhDnXbutL+ktMG03+EvP5PC6dA1H5JgjYY
         S9ZGM3rhZo5CUeoyBVcGi74BPgWT8TcRcz30qbuZ32dKORWo1fAtwAxg4piuJE7ZP2dd
         TgGvklZvolrQq/VJObQtJBPN0Q9DixGiN1ZN4SaltL7QL5Akzza3cQOu8A3l4r79Te2K
         24BPTOrpcBx83MPC8sPmiuUjjTgS+4QeRSM600718tE4J5nVngD7r0dRlw4SXDGJnQIy
         S6s63vPGrYBDVeRKcRM2uT/T40uXPZW+O3AExJeTpI8BJj9e3Jva+HNaeZuxNqQ1G2/5
         VA5A==
X-Gm-Message-State: ABy/qLbvplepnltMEafpxPrY7yGuVpsAHoQoF6RkIjqIB+g63jdCoERa
        DBIhdNDTNl63h5Z26Elu9RY=
X-Google-Smtp-Source: APBJJlE6PiNkJjq87PuqQnLz5kv7YUnoIM9/dLb51bSe5wbM6tc0xUXBV6T/v2ZhGYPKxog9mdqxvw==
X-Received: by 2002:a5d:428e:0:b0:314:2d71:1f7a with SMTP id k14-20020a5d428e000000b003142d711f7amr3325273wrq.32.1690923094053;
        Tue, 01 Aug 2023 13:51:34 -0700 (PDT)
Received: from localhost ([2a01:e0a:32f:1f0:c25b:89f6:3b46:6d1e])
        by smtp.gmail.com with ESMTPSA id f13-20020adfdb4d000000b003141e9e2f81sm17162490wrj.4.2023.08.01.13.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 13:51:33 -0700 (PDT)
From:   Raphael Gallais-Pou <rgallaispou@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rapha=C3=ABl=20Gallais-Pou?= 
        <raphael.gallais.pou@gmail.com>
Subject: [PATCH] dt-bindings: phy: st: convert phy-stih407-usb to DT schema
Date:   Tue,  1 Aug 2023 22:55:10 +0200
Message-ID: <20230801205510.15713-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphaël Gallais-Pou <raphael.gallais.pou@gmail.com>

Convert the st,stih407-usb2-phy binding to DT schema format.

Signed-off-by: Raphaël Gallais-Pou <raphael.gallais.pou@gmail.com>
---
 .../bindings/phy/phy-stih407-usb.txt          | 24 -------
 .../bindings/phy/st,stih407-usb2-phy.yaml     | 63 +++++++++++++++++++
 2 files changed, 63 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-stih407-usb.txt
 create mode 100644 Documentation/devicetree/bindings/phy/st,stih407-usb2-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-stih407-usb.txt b/Documentation/devicetree/bindings/phy/phy-stih407-usb.txt
deleted file mode 100644
index 35f03df00130..000000000000
--- a/Documentation/devicetree/bindings/phy/phy-stih407-usb.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-ST STiH407 USB PHY controller
-
-This file documents the dt bindings for the usb picoPHY driver which is the PHY for both USB2 and USB3
-host controllers (when controlling usb2/1.1 devices) available on STiH407 SoC family from STMicroelectronics.
-
-Required properties:
-- compatible		: should be "st,stih407-usb2-phy"
-- st,syscfg		: phandle of sysconfig bank plus integer array containing phyparam and phyctrl register offsets
-- resets		: list of phandle and reset specifier pairs. There should be two entries, one
-			  for the whole phy and one for the port
-- reset-names		: list of reset signal names. Should be "global" and "port"
-See: Documentation/devicetree/bindings/reset/st,stih407-powerdown.yaml
-See: Documentation/devicetree/bindings/reset/reset.txt
-
-Example:
-
-usb2_picophy0: usbpicophy@f8 {
-	compatible	= "st,stih407-usb2-phy";
-	#phy-cells	= <0>;
-	st,syscfg	= <&syscfg_core 0x100 0xf4>;
-	resets		= <&softreset STIH407_PICOPHY_SOFTRESET>,
-			  <&picophyreset STIH407_PICOPHY0_RESET>;
-	reset-names	= "global", "port";
-};
diff --git a/Documentation/devicetree/bindings/phy/st,stih407-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/st,stih407-usb2-phy.yaml
new file mode 100644
index 000000000000..1f66ceddbf81
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/st,stih407-usb2-phy.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/st,stih407-usb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STiH407 USB PHY controller
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+
+description:
+  The USB picoPHY driver is the PHY for both USB2 and USB3 host controllers
+  (when controlling usb2/1.1 devices) available on STiH407 SoC family from
+  STMicroelectronics.
+
+properties:
+  compatible:
+    const: st,stih407-usb2-phy
+
+  st,syscfg:
+    description: Phandle to the syscfg bank
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    items:
+      - description: phandle to syscfg
+      - description: phyparam register offset
+      - description: phyctrl register offset
+
+  resets:
+    items:
+      - description: Phandle and reset specifier pair for the whole phy.
+      - description: Phandle and reset specifier pair for the port.
+
+  reset-names:
+    description: List of reset signal names.
+    items:
+      - const: "global"
+      - const: "port"
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - st,syscfg
+  - resets
+  - reset-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/stih407-resets.h>
+    usb2_picophy0: usbpicophy {
+    	compatible	= "st,stih407-usb2-phy";
+    	#phy-cells	= <0>;
+    	st,syscfg	= <&syscfg_core 0x100 0xf4>;
+    	resets		= <&softreset STIH407_PICOPHY_SOFTRESET>,
+    			  <&picophyreset STIH407_PICOPHY0_RESET>;
+    	reset-names	= "global", "port";
+    };
+...
-- 
2.41.0

