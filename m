Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F37C75A3F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGTB3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGTB25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:28:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436FF2686;
        Wed, 19 Jul 2023 18:28:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b89114266dso2004995ad.0;
        Wed, 19 Jul 2023 18:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689816516; x=1690421316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PknmXnQirEOnubVOauabc0cJvIl8m6tNpWyxQZCD0N0=;
        b=HlYK066kywXFDcqXfpN2MS//uTAgfYqt5W28/6QC2VM5BWYvB9bkuxwbgRlpf1fMew
         Tm/pCbdMEnTe3tOBySqaUMHvkByNcNOlFFGdNmLrhU4bFI4TOTJGS2knR7XmWOHKbpoW
         /I+38ci00HljLjTLHrsLSNgjGqduuZlVU25broSFKNElvothWFoMJ0GGG4N9GDbZa/Zl
         nZGOHUmJPM8x9+tnsBOBKYEu8HcGaSGhp/4V5d/wjxEjYWzo8jZMH04YE/zRlgl3UbQc
         vLFf+m/2YS5qKN7Nf8ri2iyYAeRf+BcDIcQidasUU4L9RVBAyNJoZIwQUS7dcD5JOiAr
         rtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689816516; x=1690421316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PknmXnQirEOnubVOauabc0cJvIl8m6tNpWyxQZCD0N0=;
        b=WkJSdyWosqbKiywAxNW8D+Um/hXQbrdoi2Et4ZyI2JCGNeY3TkGZ3Gfq3Qf9LyzyRl
         7dbf3/mv5ERjoXwUjXvJOvumDVYT8KyziqzQGThSqOcTBhNgD2ZbuDx8jUDjKeCdtnXl
         xFRtsFy0I0FoDqOian6fxdaOPC5r39wv+et0j3ZosWjIGliAIRzerHSnsK7GRIyap+44
         sveOO4eMLAmTJFmlqzzcgQXqIxaWTrcWGIPqoqm9IRTW+CDOWSVzvFqubgndt7Fr0NKf
         Rlxa6TE36se2lnXY01G4y/XNkBNL/QSYr+RL3TEdlDNHYkBK19b96p7S6zO48v5MTPMU
         2ntw==
X-Gm-Message-State: ABy/qLYK3u1EDOCMuVvX385zx2TDmQTgBvX+s6OL1cnrlwXD2vp9ZvHG
        FqpwRViaC+dc06B9sqkQ8xTS4tikTfA=
X-Google-Smtp-Source: APBJJlGSks9Rg5tIlI14bZPE81Pyz9Tcv/KMpi5HUYJgRIUzBSJhe/UXuN78EoamwuQ5FKB1bcIDJw==
X-Received: by 2002:a17:902:e548:b0:1b8:b29e:b47b with SMTP id n8-20020a170902e54800b001b8b29eb47bmr5402474plf.44.1689816515718;
        Wed, 19 Jul 2023 18:28:35 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jc18-20020a17090325d200b001b1a2c14a4asm4673998plb.38.2023.07.19.18.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 18:28:35 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 1/3] dt-bindings: rtc: Document nuvoton ma35d1 rtc driver
Date:   Thu, 20 Jul 2023 01:28:24 +0000
Message-Id: <20230720012826.430026-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720012826.430026-1-ychuang570808@gmail.com>
References: <20230720012826.430026-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add documentation to describe nuvoton ma35d1 rtc driver.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../bindings/rtc/nuvoton,ma35d1-rtc.yaml      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml b/Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml
new file mode 100644
index 000000000000..08c30f3018fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nuvoton,ma35d1-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Read Time Clock
+
+maintainers:
+  - Min-Jen Chen <mjchen@nuvoton.com>
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35d1-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    rtc@40410000 {
+        compatible = "nuvoton,ma35d1-rtc";
+        reg = <0x40410000 0x200>;
+        interrupts = <GIC_SPI 5 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clk RTC_GATE>;
+    };
+
+...
-- 
2.34.1

