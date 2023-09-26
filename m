Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509547AEFF3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbjIZPrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjIZPqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:46:54 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B15126;
        Tue, 26 Sep 2023 08:46:46 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 7BABD836FC;
        Tue, 26 Sep 2023 17:46:36 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Tue, 26 Sep 2023 17:46:27 +0200
Subject: [PATCH RFC v2 6/6] ARM: pxa: Convert gumstix Bluetooth to GPIO
 descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230926-pxa-gpio-v2-6-984464d165dd@skole.hr>
References: <20230926-pxa-gpio-v2-0-984464d165dd@skole.hr>
In-Reply-To: <20230926-pxa-gpio-v2-0-984464d165dd@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=H9m5GKPOjDqHvnoQunanjp8s8qAFx4LJD9KoCMZ/UEw=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlEvzXcuEUSDa/D4G1iSz3FE96zRXUsszhKfvO/
 cfAj0gBIZWJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRL81wAKCRCaEZ6wQi2W
 4T5tD/9Sqn/4LVKN8ztfsrZ5hkncZIFXvDxSfs5cOa2nTPv38vr826JczlpZafwRDsS8+m5RD6M
 pzXm4nww5abZCdDcJTjAOyh+G2Jr0Sukz/NUu3780UqtwoQ+Jdw62DMHDR1a+C5mLROhhpiwF4u
 5ZbYAok22ye3Bu4GCTkJYXO88pqUbQz+/7fE/hDRVubiGxgTkkctd7zspd/yc3a9FFGMfqvASoB
 ZkPrDWyeQLAk8kjERXayQ1lXmkwkCf0XfecgtURaxZ8W9XAkLgZD1hLKoJJE06Ef9P0AlqBKzv/
 boRgyucdS8SOG3tyvZa8ZYBNlIp1clSVAAh0yYrxjWluTWIZVVtcPkr3qpPXd1DdZqgvxZKlq4s
 AWNWUgDIN6KblADH5NVyy7tL+Pt3AtDKM/h75b03cnvrD7r33DG0oymTR4zDJ7WaZMs2mp7eNc1
 BuY0jk+gbzDrZf3a355NboaHrrr5LgKV9XVWicQ/Ru/EWi27TIuEn+4chKdAq6v9RAXzREL64EX
 FKevE9Kkoj2eLNkT/yXAWz7AP7op8fVP/KkyvlG84Fvyn9quSOuYkYclYvzCpj/LljmKvywccGa
 HL9Oyy5lEqU5oCMNzgE+K+B49J7FNd8aE61WT87uPQWJlpxA5NciewsTw/5M4+83IvI9dcQmUdl
 oVVYhEoJPJdNUFA==
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

Gumstix still uses the legacy GPIO interface for resetting the Bluetooth
device.

Convert it to use the GPIO descriptor interface.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/mach-pxa/gumstix.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index c9f0f62187bd..14e1b9274d7a 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -20,8 +20,8 @@
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
-#include <linux/gpio.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 
@@ -129,6 +129,9 @@ static void gumstix_udc_init(void)
 #endif
 
 #ifdef CONFIG_BT
+GPIO_LOOKUP_SINGLE(gumstix_bt_gpio_table, "pxa2xx-uart.1", "pxa-gpio",
+		GPIO_GUMSTIX_BTRESET, "BTRST", GPIO_ACTIVE_LOW);
+
 /* Normally, the bootloader would have enabled this 32kHz clock but many
 ** boards still have u-boot 1.1.4 so we check if it has been turned on and
 ** if not, we turn it on with a warning message. */
@@ -153,24 +156,23 @@ static void gumstix_setup_bt_clock(void)
 
 static void __init gumstix_bluetooth_init(void)
 {
-	int err;
+	struct gpio_desc *desc;
+
+	gpiod_add_lookup_table(&gumstix_bt_gpio_table);
 
 	gumstix_setup_bt_clock();
 
-	err = gpio_request(GPIO_GUMSTIX_BTRESET, "BTRST");
-	if (err) {
+	desc = gpiod_get(&pxa_device_btuart.dev, "BTRST", GPIOD_OUT_HIGH);
+	if (IS_ERR(desc)) {
 		pr_err("gumstix: failed request gpio for bluetooth reset\n");
 		return;
 	}
 
-	err = gpio_direction_output(GPIO_GUMSTIX_BTRESET, 1);
-	if (err) {
-		pr_err("gumstix: can't reset bluetooth\n");
-		return;
-	}
-	gpio_set_value(GPIO_GUMSTIX_BTRESET, 0);
+	gpiod_set_value(desc, 0);
 	udelay(100);
-	gpio_set_value(GPIO_GUMSTIX_BTRESET, 1);
+	gpiod_set_value(desc, 1);
+
+	gpiod_put(desc);
 }
 #else
 static void gumstix_bluetooth_init(void)

-- 
2.42.0


