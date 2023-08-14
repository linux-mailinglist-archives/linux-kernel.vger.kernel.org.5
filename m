Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482A877B3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjHNIRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbjHNIQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:16:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C93E5F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:16:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe426b86a8so37396085e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692001009; x=1692605809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Pe1G74CKDr0t/c1R/w4mEAZ9khtDQBENUlvIvkgD0Y=;
        b=AlsIJ3Hli4koRHVo52AcOzcNnCXIWjQM425mlvpdhezGEMAvL2WOVDVfnz0GbdwguD
         slNTc8BpKMYe9aETDR8Gsq+9hVOg16dvGjCdsOgJILRqSdwHxNBkTDGSEZYFHcrBYg4Q
         MMjJVZQjSm5cbYDgA10Tn//NrYfa8VtJA4kl5zfOunBe2UCryxwW0jqKTWfZUo1VibUj
         kD8kg+6pcxGH+kqoikv2bBl/DFLkMX8CCXROpGp5fugNmf+nTpzMs3RKz1Rv6bw3VUof
         a5Ln5S3ah8//ts7AUyLGHrcbl77zahiKqDGvgJwC/rR+C1l4+eyEteRmSSgEwrXwDBN2
         HWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692001009; x=1692605809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Pe1G74CKDr0t/c1R/w4mEAZ9khtDQBENUlvIvkgD0Y=;
        b=XhSHvZQFdlAG7OeVNpk+Xo6GyDi5F5f71+lKQMWPhNKmXUAsyBPIs+Bl22vKrVORve
         16WmiOLs/m1RTi7WU4zn659z3oY8wtkzo7L7mitCPxwsR+2Qf/3H2GmVRqxwgOU26pmV
         i8fO5sQqm0Yu1vsTIcFxjUJX4scZPilEq7J8WgCsXuCFZjOnZgiqMSP00PR0EgnYgGJD
         TFD9zSs6u/2rQxVAbIOl+6/g059qqbf1edLoFKwS6cWn60EWodzatth7ERFlao9e9rjL
         RzuViKQ3t6Nx+04yPLVNfdKELYFNUtNC0sWhPZvI/y9IFt3DSjaoAB37A7IV9u7QUxCS
         Khwg==
X-Gm-Message-State: AOJu0Yy+uoINtB2gM9VLtGQ9wq8bvrMuS0nx2X0+jg3Wx6cO73YjXA+w
        I5mpraiCR3o1aiW0JaGMg2vmvw==
X-Google-Smtp-Source: AGHT+IFxoZYypMWMApyftvpZB+eRWVc7nLZT8b8RmwQysm55SPF8kxFmUC8yXR5M66sqVwKCaSHESw==
X-Received: by 2002:a1c:ed15:0:b0:3fb:e206:ca5f with SMTP id l21-20020a1ced15000000b003fbe206ca5fmr7168108wmh.31.1692001008961;
        Mon, 14 Aug 2023 01:16:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d4281000000b00317a29af4b2sm13542994wrq.68.2023.08.14.01.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 01:16:48 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 14 Aug 2023 10:16:39 +0200
Subject: [PATCH v3 3/3] dt-bindings: gpio: gpio_oxnas: remove obsolete
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-topic-oxnas-upstream-remove-v3-3-04a0c5cdda52@linaro.org>
References: <20230814-topic-oxnas-upstream-remove-v3-0-04a0c5cdda52@linaro.org>
In-Reply-To: <20230814-topic-oxnas-upstream-remove-v3-0-04a0c5cdda52@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2444;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jE6ByQZPyn94kajLMkmmnkKqcK01TK88XsXfpl+GUMQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk2eLrjDbTfAEmzdlc5+OVy72+nkloYG/jlpD4hbXa
 p3OXVuyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZNni6wAKCRB33NvayMhJ0XR6EA
 CgJ78xhOK89ymzp6lmIQDll16C4q2KKUwZpYLi19PkP5CHYpod1KfImzp6DZMipWgeNV5BXID4vbFc
 QmdNIQkTjkK9dA8Hf5Qz5Eg4OEOBW5AtBRZqaYxTEZY7lAAx10WH6ykM9DJ1JsvrjqvefO1PunTVKo
 ebeaG0C7j/zmILuEyedPLzWe9pRbSJ0YAeitBmOl2m7NzBdEo9T5foRIK2tp7tWfOrsagovPAiE2cq
 LQeNLBsZuhVYSmoeexUC9oTAq8A0DJBD03OtYj7ypPFc0SKyxvsZ7VDXpj07abZAvv7X1tHKyPfBoD
 KL09HCmsLKWO8qqR0F3JjoVv8L9T7MpfdXbbxtWJWCjVYghU4gN4g9M9yoez6+cz9mB9YFmwlrhDJz
 0SY3yGvAWAi2GGQeJRPWzs4bm7a3LTsQpvi/w1F9/6vdoTdbdf4DbWNpnxa3/0R9j4X8Nn6ZBkh0b/
 TyDymJbacbClLxEvtE4KyVzDjEbbLXYZK9DhhQ3v/5jQetF6u1P0Cq00antay22GdXUDJu4tpo8kg6
 OAs+/3tH4J6VdE7bVpxEobtPrbVIvRn3Rf7CYOJsFlb53iKgcTQwe7sMQa9r94rRtZgWBnlHhdSzfA
 6qH0uQAbjStD4KwG92omB0aHYoteiIuTHrJOW/JCQcTtwvbIgmtNltRr1vGQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove the
OX810 and OX820 gpio bindings.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/gpio/gpio_oxnas.txt        | 47 ----------------------
 1 file changed, 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt b/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
deleted file mode 100644
index 966514744df4..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-* Oxford Semiconductor OXNAS SoC GPIO Controller
-
-Please refer to gpio.txt for generic information regarding GPIO bindings.
-
-Required properties:
- - compatible: "oxsemi,ox810se-gpio" or "oxsemi,ox820-gpio"
- - reg: Base address and length for the device.
- - interrupts: The port interrupt shared by all pins.
- - gpio-controller: Marks the port as GPIO controller.
- - #gpio-cells: Two. The first cell is the pin number and
-   the second cell is used to specify the gpio polarity as defined in
-   defined in <dt-bindings/gpio/gpio.h>:
-      0 = GPIO_ACTIVE_HIGH
-      1 = GPIO_ACTIVE_LOW
- - interrupt-controller: Marks the device node as an interrupt controller.
- - #interrupt-cells: Two. The first cell is the GPIO number and second cell
-   is used to specify the trigger type as defined in
-   <dt-bindings/interrupt-controller/irq.h>:
-      IRQ_TYPE_EDGE_RISING
-      IRQ_TYPE_EDGE_FALLING
-      IRQ_TYPE_EDGE_BOTH
- - gpio-ranges: Interaction with the PINCTRL subsystem, it also specifies the
-   gpio base and count, should be in the format of numeric-gpio-range as
-   specified in the gpio.txt file.
-
-Example:
-
-gpio0: gpio@0 {
-	compatible = "oxsemi,ox810se-gpio";
-	reg = <0x000000 0x100000>;
-	interrupts = <21>;
-	#gpio-cells = <2>;
-	gpio-controller;
-	interrupt-controller;
-	#interrupt-cells = <2>;
-	gpio-ranges = <&pinctrl 0 0 32>;
-};
-
-keys {
-	...
-
-	button-esc {
-		label = "ESC";
-		linux,code = <1>;
-		gpios = <&gpio0 12 0>;
-	};
-};

-- 
2.34.1

