Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74757ACADD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 19:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjIXRLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 13:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjIXRLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 13:11:38 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B05FE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 10:11:30 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 9ED6481FF1;
        Sun, 24 Sep 2023 19:11:28 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Sun, 24 Sep 2023 18:42:55 +0200
Subject: [PATCH RFC 2/6] ARM: pxa: Convert Spitz LEDs to GPIO descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230924-pxa-gpio-v1-2-2805b87d8894@skole.hr>
References: <20230924-pxa-gpio-v1-0-2805b87d8894@skole.hr>
In-Reply-To: <20230924-pxa-gpio-v1-0-2805b87d8894@skole.hr>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=02fLXHNo6SZtYq4sldyjzMDb6JVfWPhjgCG5UTkdTdY=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlEG274zYOOseY07wrIpLw55JpPY81b1O+DhHDw
 c1vQQZ2XxSJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRBtuwAKCRCaEZ6wQi2W
 4TqnD/4uQ6H9fKBhLDhKBRQmqOzNMF4vOaBCehGJ48w/HQ7SfRvR3zHESYgomDYWFePuKZ3gXlT
 Q7GErR6GxXh4Elgj4CqfwXfxS8mbYTfDagbLfH9zbfMIMN2Idz6GABC3NvPx3ikHb1F22tx+Cnd
 tek2dvcJAGVkWIFm983EQbkoFvgVrv5Qnf5ZdOPWLx7sinqxDLuVAzKxiY1nnOQNlgrECI+OEbm
 sqIOTGDa5VEu1/VzR7P8QcnzOz66Tu7+WU5iGgBHpeBXIKq/vMT9UCIerfMOadQMRUs1kjRrVOU
 NRV+DlpabQB+BXEN6+3a5AGHf9u87eevHHcNGDvUnOtf69mSg/pY+c+LtT2IPJfBjHBNPmWbfat
 LaasG70IQ+84KcMaTo0YGouUTutjCIvEn5Na/JewpnceClczrDLJtVk22jzDIrzVdQHKQL2f0t0
 AfyGggn27642yT943m+oLOCoSAxbAFhxV1+o532IS/Wktb01NpdrC4T3+3EhwAYOBMbFAy5K91P
 TOI5waIYQyOFnYBEyFrjL+51Ins5LjZz2VrPlsalW6+Ace1OLZ2kV/o9MiEXzeuP1EuFAicVPsS
 Ylt23QHqnv2Xyjj/XEMzWt1DrkXLIKUXnteuH96bBXwHRsvxXruvJgv5z/3RTt2+zavpIVsmnch
 eCX3yZVlysu31Gw==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sharp's Spitz board still uses the legacy GPIO interface for configuring
its two onboard LEDs.

Convert them to use the GPIO descriptor interface.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/mach-pxa/spitz.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 535e2b2e997b..91c4b208973c 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -452,16 +452,25 @@ static inline void spitz_keys_init(void) {}
  * LEDs
  ******************************************************************************/
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
+static struct gpiod_lookup_table spitz_led_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP("pxa-gpio", SPITZ_GPIO_LED_ORANGE, "led_orange",
+				GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("pxa-gpio", SPITZ_GPIO_LED_GREEN, "led_green",
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
 
@@ -480,6 +489,11 @@ static struct platform_device spitz_led_device = {
 
 static void __init spitz_leds_init(void)
 {
+	gpiod_add_lookup_table(&spitz_led_gpio_table);
+	spitz_gpio_leds[0].gpiod = gpiod_get(&spitz_led_device.dev,
+			"led_orange", GPIOD_ASIS);
+	spitz_gpio_leds[1].gpiod = gpiod_get(&spitz_led_device.dev,
+			"led_green", GPIOD_ASIS);
 	platform_device_register(&spitz_led_device);
 }
 #else

-- 
2.42.0


