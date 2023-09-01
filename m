Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D7078FEE0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349944AbjIAOTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349939AbjIAOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:19:41 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C68110F0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:19:35 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 501)
        id 37F211007FB; Fri,  1 Sep 2023 15:19:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1693577964; bh=Lbm8wzOKC2M9GeSPbw06e8KPiOFgpvPECNpJXbRnIo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OR/WtiAGuMKYxvf8uQg/v/LcwgzCqcfQeQwtjWN1P/XAXpiUqnVCw1bqZ1m46Z2pd
         ZRfvNTR31CfeB3FWXaYYK8HSYRPj6GEZ7lSzdTvZcsLaoS5Zyx0Y9GQkpzLSWIR7Zr
         Tjye0gETkda+BrjYmukIM/gFAxuIcMHJcNJKyB9zP7346F2u64M0hLibr4N4I1pyvA
         ye2fPxbJZ1bLOwPi7yNyS4zcdkJPYkKUjI9RD5Gan/pi4Gxtoj8sAizvyB8xW09TZc
         fYLBZze8QleCNfx2a/VKxk3agUvxYsGmaO/3BDsIg9EhFwjL/gEyITxK3kNb74xXbp
         wLd7fBIPNP5Kw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
Received: from localhost.localdomain (bigcore.mess.org [IPv6:2a02:8011:d000:212:44e0:1480:5a2d:d8ed])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id CB23E1007F5;
        Fri,  1 Sep 2023 15:19:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1693577962; bh=Lbm8wzOKC2M9GeSPbw06e8KPiOFgpvPECNpJXbRnIo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mTjVgXPwKuo4921vycPIOm2LJTc7VMoFgoMgAKciGPX9RJuSuxbA5qXdHuiBoie4m
         +SLlaXXO/jTkWO1u+X4xKCcgMEIxG5SEfHOQ6i6kBIZOZDFQaGx+lDUnQwMl0uP9Mt
         238pRWyiJAxl3zpG5ZEyV71jK9A0mdFe4gwcfkoEJiU46PjeVnvK2vS0Z0+B/0pdLk
         EqqOfPxfW23k8KE+zx7xh3YGYJF4ZU3WGie6AXC/hNt1WXrhLfG2JL5s8CrsAukcfc
         ka0hYlbrcATg3vXSbWQLEuN/QXzwyGFxXApwR0UYJVZsJhiuLi9ZrrBwERuf5kjZ5s
         58oYuDkVQasoQ==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: media: remove nokia,n900-ir as pwm-ir-tx is compatible
Date:   Fri,  1 Sep 2023 15:18:55 +0100
Message-ID: <25e8f2626d15199a1bf727fee375b5b149004c8e.1693577725.git.sean@mess.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693577725.git.sean@mess.org>
References: <cover.1693577725.git.sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic pwm-ir-tx driver works for the Nokia n900, so nokia,n900-ir
can be removed.

Signed-off-by: Sean Young <sean@mess.org>
---
 .../bindings/leds/irled/pwm-ir-tx.yaml        |  5 ++++-
 .../devicetree/bindings/media/nokia,n900-ir   | 20 -------------------
 2 files changed, 4 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/nokia,n900-ir

diff --git a/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml b/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
index f2a6fa140f38..7526e3149f72 100644
--- a/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
+++ b/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
@@ -15,7 +15,10 @@ description:
 
 properties:
   compatible:
-    const: pwm-ir-tx
+    oneOf:
+      - const: pwm-ir-tx
+      - const: nokia,n900-ir
+        deprecated: true
 
   pwms:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/media/nokia,n900-ir b/Documentation/devicetree/bindings/media/nokia,n900-ir
deleted file mode 100644
index 13a18ce37dd1..000000000000
--- a/Documentation/devicetree/bindings/media/nokia,n900-ir
+++ /dev/null
@@ -1,20 +0,0 @@
-Device-Tree bindings for LIRC TX driver for Nokia N900(RX51)
-
-Required properties:
-	- compatible: should be "nokia,n900-ir".
-	- pwms: specifies PWM used for IR signal transmission.
-
-Example node:
-
-	pwm9: dmtimer-pwm@9 {
-		compatible = "ti,omap-dmtimer-pwm";
-		ti,timers = <&timer9>;
-		ti,clock-source = <0x00>; /* timer_sys_ck */
-		#pwm-cells = <3>;
-	};
-
-	ir: n900-ir {
-		compatible = "nokia,n900-ir";
-
-		pwms = <&pwm9 0 26316 0>; /* 38000 Hz */
-	};
-- 
2.42.0

