Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB2A809D98
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573351AbjLHHwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573336AbjLHHwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:52:37 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA1A1712;
        Thu,  7 Dec 2023 23:52:43 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d05e4a94c3so16209855ad.1;
        Thu, 07 Dec 2023 23:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702021963; x=1702626763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jnJ6XwvpjbxwbP8d9dhoDJBnR66AamT1l+ZC7uW8glY=;
        b=l9zxM5YBVBnbdO/eIjXJMFeSNqMYcE8weurIk6PSVoOEU8BTXUzWC5pNvitOrCWLe/
         l9f7kPxy6BQjV1qYAW0ARNd4+at4CRg4gkLwmY3rSpKTuLnfjYFfbdGXLQnTYqQiACiG
         UhkFEBn+gViAqIHH2In8P8fBswK3H7HgloO1lhSlxFynh9Cl0VhnTEmPjGOILpJwY69I
         kM68YTGoI0EZ5DgEORoAO9jAWQRnuPpoGGhnNZnouooe/fyXKBaAYsC6CLWctuRLm9rX
         2BEYEL+QdQU7Kq6wwltWSVX/yh5VWlYswz1zytZ8U54ecVvJRP3QHfUQ17KNTxCqAIIU
         Ztiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702021963; x=1702626763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnJ6XwvpjbxwbP8d9dhoDJBnR66AamT1l+ZC7uW8glY=;
        b=b/0lVuFM/B/FCsWYuz3RWjmmXcCJX58qZ+DLJYLsU5AhHiPrJx5UPlZ6NKVMcKuFEU
         x3TloFAM0qjm+5MezHyXrcIxS00zhyxkOw1Y8kdr7Y5Qt2XRZXNjQsW8/3wdCeij25Id
         +J5MYoeNQvuAlySHc7SO0Fkz29bocXtTjoSLmdG06SerkiGGvfBytTAR+3vHU/0HHIHt
         TnRIv7rVMXFX/3H9E73MpJ+8mxLpPft9a/T2L4fZXQRaxaq9+K7OlWM5o5m2fvCRABZV
         W4tl8pEneo1GPjNuPRljBI4f4jjkJLNcMjrUtNGYUUzyC147ZxWjyqJ5y3tngkMW6mi9
         7pRg==
X-Gm-Message-State: AOJu0YyZMX+PtPXS+2aJlgO8PUVGI3iSU0plQ5T9rhDWolqdIeTdJ6C/
        3s32fdAwvYS0qSAhYMzQ4nnEZDJwBXpR7R/3
X-Google-Smtp-Source: AGHT+IF54PYlnGCJpAmNVLe/3ul/Libt8yVj5HcHU8Kmm1Fq4rt1bVUHsYiPTxpmgxZ20YeobsKPJg==
X-Received: by 2002:a17:902:f68d:b0:1d0:977e:29b0 with SMTP id l13-20020a170902f68d00b001d0977e29b0mr4184857plg.49.1702021962887;
        Thu, 07 Dec 2023 23:52:42 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:6277:8af4:45bc:8bc9:c94a:54d2])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c08300b001bf52834696sm1028228pld.207.2023.12.07.23.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 23:52:42 -0800 (PST)
From:   Anshul Dalal <anshulusr@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Anshul Dalal <anshulusr@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v1] dt-bindings: input: convert gpio-mouse to json-schema
Date:   Fri,  8 Dec 2023 13:20:35 +0530
Message-ID: <20231208075037.114598-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.1
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

Convert device tree binding documentation for GPIO attached mouse to
json-schema.

Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/input/gpio-mouse.txt  | 32 ---------
 .../devicetree/bindings/input/gpio-mouse.yaml | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/gpio-mouse.txt
 create mode 100644 Documentation/devicetree/bindings/input/gpio-mouse.yaml

diff --git a/Documentation/devicetree/bindings/input/gpio-mouse.txt b/Documentation/devicetree/bindings/input/gpio-mouse.txt
deleted file mode 100644
index 519510a11af9..000000000000
--- a/Documentation/devicetree/bindings/input/gpio-mouse.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Device-Tree bindings for GPIO attached mice
-
-This simply uses standard GPIO handles to define a simple mouse connected
-to 5-7 GPIO lines.
-
-Required properties:
-	- compatible: must be "gpio-mouse"
-	- scan-interval-ms: The scanning interval in milliseconds
-	- up-gpios: GPIO line phandle to the line indicating "up"
-	- down-gpios: GPIO line phandle to the line indicating "down"
-	- left-gpios: GPIO line phandle to the line indicating "left"
-	- right-gpios: GPIO line phandle to the line indicating "right"
-
-Optional properties:
-	- button-left-gpios: GPIO line handle to the left mouse button
-	- button-middle-gpios: GPIO line handle to the middle mouse button
-	- button-right-gpios: GPIO line handle to the right mouse button
-Example:
-
-#include <dt-bindings/gpio/gpio.h>
-
-gpio-mouse {
-	compatible = "gpio-mouse";
-	scan-interval-ms = <50>;
-	up-gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
-	down-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
-	left-gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
-	right-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
-	button-left-gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
-	button-middle-gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
-	button-right-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
-};
diff --git a/Documentation/devicetree/bindings/input/gpio-mouse.yaml b/Documentation/devicetree/bindings/input/gpio-mouse.yaml
new file mode 100644
index 000000000000..3928ec6aff1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/gpio-mouse.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/gpio-mouse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO attached mouse
+
+description: |
+  This simply uses standard GPIO handles to define a simple mouse connected
+  to 5-7 GPIO lines.
+
+maintainers:
+  - Anshul Dalal <anshulusr@gmail.com>
+
+properties:
+  compatible:
+    const: gpio-mouse
+
+  scan-interval-ms:
+    maxItems: 1
+
+  up-gpios:
+    maxItems: 1
+
+  down-gpios:
+    maxItems: 1
+
+  left-gpios:
+    maxItems: 1
+
+  right-gpios:
+    maxItems: 1
+
+  button-left-gpios:
+    maxItems: 1
+
+  button-middle-gpios:
+    maxItems: 1
+
+  button-right-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - scan-interval-ms
+  - up-gpios
+  - down-gpios
+  - left-gpios
+  - right-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    gpio-mouse {
+        compatible = "gpio-mouse";
+        scan-interval-ms = <50>;
+        up-gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
+        down-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+        left-gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
+        right-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
+        button-left-gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
+        button-middle-gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
+        button-right-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
+    };
-- 
2.42.1

