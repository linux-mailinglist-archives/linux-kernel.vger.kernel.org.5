Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AAD7BE97D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378063AbjJISeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377501AbjJISeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:34:18 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFA6A3;
        Mon,  9 Oct 2023 11:34:16 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 369F084A5E;
        Mon,  9 Oct 2023 20:34:15 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Mon, 09 Oct 2023 20:33:59 +0200
Subject: [PATCH RFT v7 2/6] ARM: pxa: Convert Spitz LEDs to GPIO
 descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231009-pxa-gpio-v7-2-c8f5f403e856@skole.hr>
References: <20231009-pxa-gpio-v7-0-c8f5f403e856@skole.hr>
In-Reply-To: <20231009-pxa-gpio-v7-0-c8f5f403e856@skole.hr>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=1yohBJVEfo/Ind1Hy9PsJ4oqUarD4e31qtGoJ3pSoVs=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlJEebN4SaAkwbFMrouTWoLrPxDXVIwqGRBrDWP
 T7+X4lCGGSJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZSRHmwAKCRCaEZ6wQi2W
 4YnTD/9TbKA78usjrLVWzYn9dLTIC4KdDQgikMTjRVQOAVbRYlss86P3CeKlsB5ZFqC0/TJHPrr
 fEWfYLaxdi2WeaDUqyVQRMxkAH2LB0NY6vdZD7qXi+gFhEhV5hhmAI0ePxcloR+iUXi75dM65W4
 XR7TqoDRK8VWqOr4CEr/6SUnlzie2FgjMhWHZv8l8JwcZrWEVCEt0qpPh5//TGcbzcUT5MKrmaJ
 z4kS+/hSiY/vXVuZ2YfYA+jxk2kQ/u8sOZ8Dg+37uVYRJJaevxXWmT6jHIJng6BEkqp/VQnatfr
 kD5q/+dRRpxVDqkt09i13ejeCkG4IHv/VidcpJbccv2FKqdd8SMywmVxgLMrlstOxFuodl19vaX
 3xahrJ/po+rZO87FFR7uC6H5mPOUSPRKZziGZZPx+RXv0RIy7hWgzVv6MKBf8rsdWngEm2LLkHx
 nNAF4IcXUoQXiYt2a8H2EGTaA37ccrKH6ZlpjfpnG0MDkQ9cTP+TvuifoveZ+32Yhh7AYTuSha+
 /ZxRixBZUV49nvkwfJ8KyD7FLRaqqJNDZG1b5Sis2N9DhExqnWoKpZxzaKkIrJdN1nkQeTfiSKZ
 GfYYS256QOkH48AS0O9Fr+9YpTmOUthr9Pz/+GZO7zhYbMCCIw9ING02edmdxEWrh1dLNUV5khg
 zXFzN58cPTKJ36Q==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sharp's Spitz board still uses the legacy GPIO interface for configuring
its two onboard LEDs.

Convert them to use the GPIO descriptor interface.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/mach-pxa/spitz.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 535e2b2e997b..29907abc4513 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -452,16 +452,25 @@ static inline void spitz_keys_init(void) {}
  * LEDs
  ******************************************************************************/
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
+static struct gpiod_lookup_table spitz_led_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("pxa-gpio", SPITZ_GPIO_LED_ORANGE, NULL, 0,
+				GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("pxa-gpio", SPITZ_GPIO_LED_GREEN, NULL, 1,
+				GPIO_ACTIVE_HIGH),
+		{ }
+	}
+};
+
 static struct gpio_led spitz_gpio_leds[] = {
 	{
 		.name			= "spitz:amber:charge",
 		.default_trigger	= "sharpsl-charge",
-		.gpio			= SPITZ_GPIO_LED_ORANGE,
 	},
 	{
 		.name			= "spitz:green:hddactivity",
 		.default_trigger	= "disk-activity",
-		.gpio			= SPITZ_GPIO_LED_GREEN,
 	},
 };
 
@@ -478,9 +487,16 @@ static struct platform_device spitz_led_device = {
 	},
 };
 
+static struct gpio_descs *leds;
+
 static void __init spitz_leds_init(void)
 {
+	gpiod_add_lookup_table(&spitz_led_gpio_table);
 	platform_device_register(&spitz_led_device);
+	leds = gpiod_get_array_optional(&spitz_led_device.dev,
+			NULL, GPIOD_ASIS);
+	spitz_gpio_leds[0].gpiod = leds->desc[0];
+	spitz_gpio_leds[1].gpiod = leds->desc[1];
 }
 #else
 static inline void spitz_leds_init(void) {}

-- 
2.42.0


