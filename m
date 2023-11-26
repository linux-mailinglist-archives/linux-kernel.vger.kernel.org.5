Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712407F9238
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjKZKcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKZKcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:32:20 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DE0111;
        Sun, 26 Nov 2023 02:32:25 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c115026985so3250574b3a.1;
        Sun, 26 Nov 2023 02:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700994745; x=1701599545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pYYLfoXXiYjdK9YQOq39bQN3tBvwmAisCa8zX9rA7UU=;
        b=ElM6dCpRKfVoPnqSM4o7Rzx2dxZF6QDESeq9+Ettnx+wbWXrp3HxMB5inJMxK+QRGH
         V4iL3adn9C458AX8TE8qDKA3Z9QcNQV5LH/LRWArmRWF1T48V/odvs1Iwo+I8931XXbw
         eVwv+z3XQ4pY7HPiuodW7tw7acl5Zq1lo5NAezO5V2sWUcEVdnV7l3VeMwrOsOYq5ohU
         6PiaoVauxBDF51n56VjrbM20MxUoYDlBjB8HuaYJEn8lklCO6vJM+FWtYpTFVDGYTsjO
         DKN8pdHcMwAdrTLm/c6j6EAWQRMfg4A6A00sJ6kp1aWQhOwPh6EaLL6uw1JVy6obFRfB
         T6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700994745; x=1701599545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYYLfoXXiYjdK9YQOq39bQN3tBvwmAisCa8zX9rA7UU=;
        b=D5cFqzf2NAmJJgOLz2CuWoZgl32J8PAWWkzEXRAmeOeSw72nI1xbwlE1qb+pd8Hah9
         ZoQ0oO7tDm8vpEhcW44WIwohSSjHLvMlMd67cbgKoPPtih5Rri5GZ1Hz0ERzFjgOioLz
         CQ8ivI5osWVdgY32pXw1jAQJQQLgncHIQnPT5MEU+A1WLWK4DBpVMA2atVFXgKQOT8UL
         RJ39+7i+MxVj36Pa0j/Bfvd0gBTp5yoOILFzIv/XFJGDmmQKmdO77kQ7HuiMYP3UPww7
         hOm9ZVsS9Y+X2JCQbk8f/0l71qmH4r1ZVr1/xDI4k+hHMWZdLDchVt2HcKrPbzs19eHp
         w36g==
X-Gm-Message-State: AOJu0YwdAEKarW5t4xTGJ+466Ui3CJdMrt8wEUG9wvEN4DH0vaN9/2vU
        EqlOMQO3Ewt32nIZ3WVH1+pTwlGs0hh5V8hP
X-Google-Smtp-Source: AGHT+IE67x1qv6fGGSUzhs++tms/1fww89kbm04xEbpSjMTejEHRsUZPzg8lZ6XcRVFEs4+Ywnjwjw==
X-Received: by 2002:a05:6a20:3ca5:b0:18b:3158:4231 with SMTP id b37-20020a056a203ca500b0018b31584231mr12621747pzj.16.1700994744663;
        Sun, 26 Nov 2023 02:32:24 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id s10-20020a17090aba0a00b002858612349asm3931188pjr.38.2023.11.26.02.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 02:32:24 -0800 (PST)
From:   Anshul Dalal <anshulusr@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Anshul Dalal <anshulusr@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v1] dt-bindings: input: convert gpio-mouse to json-schema
Date:   Sun, 26 Nov 2023 16:00:28 +0530
Message-ID: <20231126103029.851742-1-anshulusr@gmail.com>
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

