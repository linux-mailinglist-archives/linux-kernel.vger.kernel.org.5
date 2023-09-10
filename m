Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA53799DCB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 13:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345174AbjIJLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 07:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjIJLBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 07:01:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA48CCC;
        Sun, 10 Sep 2023 04:01:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso60635121fa.1;
        Sun, 10 Sep 2023 04:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694343696; x=1694948496; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HBkpEqUb+78mNZeKD0UcDWXhyqQzEoqyYm5VM9b2Bq0=;
        b=o7RhsfKknjbiAwXeeXgYbjCzcQVFtxerzPODUJvutlXTHU51ZA2P57fTGRrHqrrq42
         fUb2JJCv9fnDxJyvhGV5dGVyYlZk2Ayvs6fugOWiyfAVhTVCh6SKYa/fBacdIGq+Ajfa
         fn5ONSPXISe7rf7wUks1IjbPE7h3BMkbSpV1Jt4Lu4W+60xjSJluXGXtHEM1Zy3GBgLE
         5iD71+D2R27riY44toRBs2i0aIQKjAtIw0qidW0tp9kfiLtCZdjfQU0s3cranG0uh8da
         s/WCBzYO7TuJdBv4Deaqn5nUushmzKhcGW/JtwnbQpUngNP3DrOhzSNJ1j2QTbQYl5MU
         /sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694343696; x=1694948496;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBkpEqUb+78mNZeKD0UcDWXhyqQzEoqyYm5VM9b2Bq0=;
        b=Z/L96y23H+bYZaSdVF1wV306DmsDFI1CuVRd2u8KOAfgUiFjS0sVcIPV2zRHcIMN/2
         IwXSxsfijjmKyG0iblqNB8LnsjYjnC5mg1tLLJAlZ3o/7Zi7Buj+p8LfQUFiX46KRaka
         rNqp1lEYgR80+SL0mGB/2bjWxLg35j4xIyAN4w3w80gfVDyN22oJBpxJat3iVogmOoUP
         HsGKgn1oXGpN8zBxwWmvlc/W0LACNP4lSfgPBhj26POP3nFTK+w/5tWzgxzTWlSWto/z
         4cvsSrLRCmWgZoDcbvzSzniDQMB6Q1+zdvz0pS2jTKKh5I0IUqFd52QA6WlA9HY7dTZA
         8jVQ==
X-Gm-Message-State: AOJu0YwbBsPPbtVS8FprGMjqYr5UsduuPOdeDYKp2DMaqmvMNpYHWhYW
        rWoyGR79JNxbTRtxnj2HFsc=
X-Google-Smtp-Source: AGHT+IGOXs+af2H/WM6i72c3ovfgngRuyQhC73lGFtAS5Zrg3rPugKF1E13QWMEBTCRSMkndrQlO4g==
X-Received: by 2002:a2e:b247:0:b0:2b9:c046:8617 with SMTP id n7-20020a2eb247000000b002b9c0468617mr4917864ljm.5.1694343695412;
        Sun, 10 Sep 2023 04:01:35 -0700 (PDT)
Received: from [127.0.1.1] (ip-185-104-138-31.ptr.icomera.net. [185.104.138.31])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090637c600b00991e2b5a27dsm3651710ejc.37.2023.09.10.04.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 04:01:34 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Sun, 10 Sep 2023 13:00:27 +0200
Subject: [PATCH] dt-bindings: rtc: pcf2123: convert to YAML
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230907-topic-pcf2123_yaml-v1-1-40e82bed2066@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMqh/WQC/x2N0QrCMAwAf2Xk2UDXKUF/RWR0WeoCrivNEGXs3
 +18PI7jNjApKga3ZoMibzVdUoX21ABPIT0FdawM3vnOXR3humRlzBx967v+G+YXepYLxbMQjQQ
 1HIIJDiUkno50DrZKOUQuEvXzv90f+/4DSG6k3X0AAAA=
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chris Verges <chrisv@cyberswitching.com>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694343655; l=2678;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=tdwkiF5gV6ILncjzIuPpYriuqRSejpFZSQyqazCIw5s=;
 b=VFJXtuw2LwhPo0MUvkIDPH2ip7Ft/WHz0YtAyksfg1RZpQ0/yVAt7I0HKpCLhlmVjyBuF0QNU
 ezqow81GuXjCAZRFR+bMZxF8/w5dNd0dg8eVSAkc+GC+mzVYOC5oSvo
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
---
 .../devicetree/bindings/rtc/nxp,pcf2123.yaml       | 45 ++++++++++++++++++++++
 .../devicetree/bindings/rtc/nxp,rtc-2123.txt       | 17 --------
 2 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2123.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2123.yaml
new file mode 100644
index 000000000000..013e5e5dc0ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2123.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nxp,pcf2123.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PCF2123 SPI Real Time Clock
+
+maintainers:
+  - Chris Verges <chrisv@cyberswitching.com>
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
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@3 {
+            compatible = "nxp,pcf2123";
+            reg = <3>;
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
base-commit: 535a265d7f0dd50d8c3a4f8b4f3a452d56bd160f
change-id: 20230907-topic-pcf2123_yaml-2ce57f4e77d7

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

