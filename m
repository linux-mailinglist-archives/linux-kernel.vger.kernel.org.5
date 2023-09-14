Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B06779FFA8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbjINJIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbjINJIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:08:35 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC4F30D8;
        Thu, 14 Sep 2023 02:08:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso1169107e87.0;
        Thu, 14 Sep 2023 02:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694682485; x=1695287285; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hl4nS3eJDv9omiSZ8gxu5sTzl2Wgv9hxhPxCWSjSJ1s=;
        b=hV5XB5KU7hYTYQ+6+ObPIMPfrmO2wbbV8gW8vnRqvOgvqVbF4CVf2Y/Owikfy+oLK7
         FwMhkfgMJ4rY8nYgLlPiL/iXxiO0cRAE6oE+0o+7qJyofrxktu8mSsE2M9sQxuvrkemH
         5EOAwrQ0KqDRk/Si+z+JVS8tGJplcsGQYqzmgJFnDLHuQU8YjslvDrCUEt2csUbBiQoU
         JJgt9kg7mt7w/GqUntMDz8Ad36xKY4OouWOCTBZeISiO04EWhYoMrclr0JyBDJjwDpQ0
         5QywF4vaxC5MbDcWku/su3Tqjc4IAOltmvuBq4DfjHtHqvjewmYX3HW8beUwQ7zFzYDD
         45xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694682485; x=1695287285;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hl4nS3eJDv9omiSZ8gxu5sTzl2Wgv9hxhPxCWSjSJ1s=;
        b=Wlae0zJbISoEQfJrxN/2fetIXiy2ZfvxF7B4MgPql3x1roxvgvORGC5KmAXNcHRZZx
         KXtCYRyE5TseP4OCj/N/jGf7i9Lc8tRC1xX3cEwUg8Fv5nCxoLlXaeFI1n8CqZwgI64C
         8SiAfbiPCOK0rM9d8JnVt3JUW5VvKsDSp4VrldCXNYKAHaOLbWO84GDQTy73OJ7944D0
         Er9SFpp+O7Hw6MoVYMhO5ngT8eXp8LNKhMqVBgJaP9zHBqB+zBR0EUaRd8LsfZ3xz3Ga
         8YbWeGrpOt8Ssedg6PxeV7HER4Er6F1Qy1OYltQ47dKR9m1vghY2gRhJinw5StPZk5y5
         oHTw==
X-Gm-Message-State: AOJu0YxCyek32vJrA/7O2cbt26l/U3FCsshljdJMoLpByANBG95AIeQo
        4mkLGzVIfNQG4o2uir76QSQ=
X-Google-Smtp-Source: AGHT+IHLnjQEvTVqllIsWA9wQwovx+WXjA9Q9csjJqXlqqN5zknxPu0RnvVF3c4cQBI53rSnWtLViA==
X-Received: by 2002:a05:6512:250c:b0:500:a3be:1ab6 with SMTP id be12-20020a056512250c00b00500a3be1ab6mr4502063lfb.6.1694682484578;
        Thu, 14 Sep 2023 02:08:04 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41b4-ce80-b80d-9e19-c65b-2777.cable.dynamic.v6.surfer.at. [2a02:8389:41b4:ce80:b80d:9e19:c65b:2777])
        by smtp.gmail.com with ESMTPSA id eg33-20020a05640228a100b0053030c3355asm110004edb.75.2023.09.14.02.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:08:03 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Thu, 14 Sep 2023 11:07:59 +0200
Subject: [PATCH v2] dt-bindings: rtc: pcf2123: convert to YAML
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230907-topic-pcf2123_yaml-v2-1-ea87a8e12190@gmail.com>
X-B4-Tracking: v=1; b=H4sIAG7NAmUC/32NQQqDMBBFryKzbkoyWtN21XsUKTGOOmCMJCIV8
 e6NHqDL9z+Pt0GkwBThmW0QaOHIfkyAlwxsb8aOBDeJASXm8iG1mP3EVky2RYX5ZzVuEGjpptu
 CtG40JLE2kUQdzGj7Q3UmzhSOYwrU8vesvavEPcfZh/WML+pY/3YWJZQoJN2xpgZlWb46Z3i4W
 u+g2vf9B12npZ/NAAAA
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694682483; l=3111;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=a4kY+3LJ7mblDfdCMOJy32yH7TjpqB1j+vQT54tBpGc=;
 b=JpYphy5LylWIl5uPUDKvy5rXLIywSFJGJ7LgyLxwF8VpgzPYkzVb4T8UUgfTDbpxeYy358tRZ
 7v0i+ZvztNACKW/xYRCwBosjxqyYC589djkVwsDXpAkKm5RjPBnxzt8
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the existing txt binding to the preferred YAML format.

The pcf2123 node may contain SPI settings such as spi-cs-high and
spi-max-frequency, which keeps it from being added to the trivial-rtc
binding with its current definition. Add a reference to
spi-peripheral-props.yaml to account for that.

The "interrupts" property was missing in the binding although it is
already supported. Add the missing property in the new binding.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v2:
- Added interrupt to the example
- Changed maintainer to Javier Carrasco (maintainer from v1 no longer
  reachable)
- Link to v1: https://lore.kernel.org/r/20230907-topic-pcf2123_yaml-v1-1-40e82bed2066@gmail.com
---
 .../devicetree/bindings/rtc/nxp,pcf2123.yaml       | 47 ++++++++++++++++++++++
 .../devicetree/bindings/rtc/nxp,rtc-2123.txt       | 17 --------
 2 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2123.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2123.yaml
new file mode 100644
index 000000000000..96e377a4d1bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2123.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nxp,pcf2123.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PCF2123 SPI Real Time Clock
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nxp,pcf2123
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@3 {
+            compatible = "nxp,pcf2123";
+            reg = <3>;
+            interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_LOW>;
+            spi-cs-high;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt b/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt
deleted file mode 100644
index 7371f525a687..000000000000
--- a/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-NXP PCF2123 SPI Real Time Clock
-
-Required properties:
-- compatible: should be: "nxp,pcf2123"
-                      or "microcrystal,rv2123"
-- reg: should be the SPI slave chipselect address
-
-Optional properties:
-- spi-cs-high: PCF2123 needs chipselect high
-
-Example:
-
-pcf2123: rtc@3 {
-	compatible = "nxp,pcf2123"
-	reg = <3>
-	spi-cs-high;
-};

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230907-topic-pcf2123_yaml-2ce57f4e77d7

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

