Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D107BC9FC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 23:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344196AbjJGVrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 17:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbjJGVrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 17:47:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01933BA;
        Sat,  7 Oct 2023 14:47:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b6559cbd74so608496866b.1;
        Sat, 07 Oct 2023 14:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696715238; x=1697320038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ozk5P1ARvq5pa0uSZLFbgDtNhHn9GsrgjHS2OATiCTE=;
        b=jNhXX4WRP+zkeHQ9OYhFtqsnBKDpqxCWnQL9waYHcTh+NJrjQ9o1BZU/x6o+FjE3tB
         UtgckD6GE2wAFD8ccohkt2ZpX8uOkMjeKEQp5k/IWuySVcs99oKRDI6/ze6vuzKxhYrw
         wnKm4Ea+oaAG6KHp/9MunappGTk+dx3NC7/MgtmHOP2IbxLrSrLUFAXXuIu2P3FUoGyV
         cTlWAQvEoZeFbP6nrjjbO3NR9eBwlk0lWN2hBGPIjt5lu81rK1U38iOCRqu9CFf23Cua
         guBTKxLmeTraHBTBUKvuNChRSd4+qCMDbr2UVut6jxZHt2ozI/9hQnIV5v9nEUN7pGoM
         48oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696715238; x=1697320038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ozk5P1ARvq5pa0uSZLFbgDtNhHn9GsrgjHS2OATiCTE=;
        b=wCupaluzkCw1Cn4YkaIR/oLnfpAEQFYx1qyTW52w6UWW5UAWJhX1ofayZWqRsawvgv
         njxKkZ2uPFQdV6129CR0rBDZO0fuW2Mp5wUfspeT/3fljrVVwDFUgE/efwvNRc0xIwJA
         +F6oGe6TPf8Bp3thKqvt20EbGL0YkRB7G4CcjOFMbRju50dSgO4VrKvGvLULJiz0Sek3
         pVJ5HnHgKowrLyB2KjR8irdyYnemjEcissDD4sx8u5Q/s/+MA3VvbZh5o5jnjsZ9nRog
         qmPB1yTDkTYHH9A+e7mhrxMyO6+zygZpRSq8seqHpO1R65NTESfu/XewXyAxJU1rIIHl
         vMyA==
X-Gm-Message-State: AOJu0YyA+XAmTG6YTH5V189nOmjEznLb6PVZwoO9Bo6SVOVT7FYKC6yh
        MlN/T3U1wIFCowV3XZUs17w=
X-Google-Smtp-Source: AGHT+IHynu7hG7HAwEbgrSksRponbxwKouvULr1MH3Jog8ipaeudAz4mtz94jSnFHidQzCEAatqpbw==
X-Received: by 2002:a17:906:73d8:b0:9ae:53af:c57f with SMTP id n24-20020a17090673d800b009ae53afc57fmr11714771ejl.65.1696715238204;
        Sat, 07 Oct 2023 14:47:18 -0700 (PDT)
Received: from dell.intranet (77-255-201-154.dynamic.inetia.pl. [77.255.201.154])
        by smtp.gmail.com with ESMTPSA id p16-20020a17090628d000b009b654ba498csm4742249ejd.90.2023.10.07.14.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 14:47:17 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] ARM: OMAP1: ams-delta: Fix MODEM initialization failure
Date:   Sat,  7 Oct 2023 23:43:42 +0200
Message-ID: <20231007214640.376709-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator drivers were modified to use asynchronous device probe.  Since
then, the board .init_late hook fails to acquire a GPIO based fixed
regulator needed by an on-board voice MODEM device, and unregisters the
MODEM.  That in turn triggers a so far not discovered bug of device
unregister function called for a device with no associated release() op.

[    6.823917][    T1] serial8250 serial8250.1: incomplete constraints, dummy supplies not allowed
[    6.874117][    T1] ------------[ cut here ]------------
[    6.893918][    T1] WARNING: CPU: 0 PID: 1 at drivers/base/core.c:2486 device_release+0x98/0xa8
[    6.930626][    T1] Device 'serial8250.1' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
[    6.972106][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.6.0-rc4-amsdelta+ #66
[    7.007183][    T1] Hardware name: Amstrad E3 (Delta)
[    7.026405][    T1]  unwind_backtrace from show_stack+0x10/0x18
[    7.046645][    T1]  show_stack from dump_stack_lvl+0x28/0x34
[    7.066573][    T1]  dump_stack_lvl from __warn+0x6c/0xb8
[    7.085835][    T1]  __warn from warn_slowpath_fmt+0x90/0x110
[    7.105292][    T1]  warn_slowpath_fmt from device_release+0x98/0xa8
[    7.125325][    T1]  device_release from kobject_put+0x94/0xe0
[    7.144741][    T1]  kobject_put from put_device+0x10/0x18
[    7.163623][    T1]  put_device from platform_device_put+0x1c/0x24
[    7.183053][    T1]  platform_device_put from ams_delta_init_late+0x4c/0x68
[    7.203244][    T1]  ams_delta_init_late from init_machine_late+0x1c/0x94
[    7.223197][    T1]  init_machine_late from do_one_initcall+0x60/0x1d4
[    7.242769][    T1]  do_one_initcall from kernel_init_freeable+0x19c/0x1d8
[    7.262608][    T1]  kernel_init_freeable from kernel_init+0x10/0x10c
[    7.281897][    T1]  kernel_init from ret_from_fork+0x14/0x38
[    7.300107][    T1] Exception stack(0xc082bfb0 to 0xc082bff8)
[    7.318004][    T1] bfa0:                                     00000000 00000000 00000000 00000000
[    7.350150][    T1] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    7.382391][    T1] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    7.413505][    T1] ---[ end trace 0000000000000000 ]---

As a consequence, ASoC codec driver is no longer able to control its
device over the voice MODEM's tty interface.

[  315.302823][  T822] cx20442-codec cx20442-codec: ASoC: error at soc_component_write_no_lock on cx20442-codec for register: [0x00000000] -5
[  315.317308][  T822] cx20442-codec cx20442-codec: ASoC: error at snd_soc_component_update_bits_legacy on cx20442-codec for register: [0x00000000] -5
[  315.332809][  T822] cx20442-codec cx20442-codec: ASoC: error at snd_soc_component_update_bits on cx20442-codec for register: [0x00000000] -5

The regulator hangs of a GPIO pin controlled by basic-mmio-gpio driver.
Unlike most GPIO drivers, that driver doesn't probe for devices before
device_initcall, then GPIO pins under its control are not availabele to
majority of devices probed at that phase, including regulators.  On the
other hand, serial8250 driver used by the MODEM device neither accepts via
platform data nor handles regulators, then the board file is not able to
teach that driver to return -EPROBE_DEFER when the regulator is not ready
so the failed probe is retried after late_initcall.

Resolve the issue by extending description of the MODEM device with a
dedicated power management domain.  Acquire the regulator from the
domain's .activate hook and return -EPROBE_DEFER if the regulator is not
available.  Having that under control, add the regulator device
description to the list of platform devices initialized from .init_machine
and drop the no longer needed custom .init_late hook.

Fixes: 259b93b21a9f ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in 4.14")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org # v6.4+
---
 arch/arm/mach-omap1/board-ams-delta.c | 60 +++++++--------------------
 1 file changed, 16 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 9808cd27e2cf..67de96c7717d 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -550,6 +550,7 @@ static struct platform_device *ams_delta_devices[] __initdata = {
 	&ams_delta_nand_device,
 	&ams_delta_lcd_device,
 	&cx20442_codec_device,
+	&modem_nreset_device,
 };
 
 static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
@@ -782,26 +783,28 @@ static struct plat_serial8250_port ams_delta_modem_ports[] = {
 	{ },
 };
 
+static int ams_delta_modem_pm_activate(struct device *dev)
+{
+	modem_priv.regulator = regulator_get(dev, "RESET#");
+	if (IS_ERR(modem_priv.regulator))
+		return -EPROBE_DEFER;
+
+	return 0;
+}
+
+static struct dev_pm_domain ams_delta_modem_pm_domain = {
+	.activate	= ams_delta_modem_pm_activate,
+};
+
 static struct platform_device ams_delta_modem_device = {
 	.name	= "serial8250",
 	.id	= PLAT8250_DEV_PLATFORM1,
 	.dev		= {
 		.platform_data = ams_delta_modem_ports,
+		.pm_domain = &ams_delta_modem_pm_domain,
 	},
 };
 
-static int __init modem_nreset_init(void)
-{
-	int err;
-
-	err = platform_device_register(&modem_nreset_device);
-	if (err)
-		pr_err("Couldn't register the modem regulator device\n");
-
-	return err;
-}
-
-
 /*
  * This function expects MODEM IRQ number already assigned to the port.
  * The MODEM device requires its RESET# pin kept high during probe.
@@ -833,37 +836,6 @@ static int __init ams_delta_modem_init(void)
 }
 arch_initcall_sync(ams_delta_modem_init);
 
-static int __init late_init(void)
-{
-	int err;
-
-	err = modem_nreset_init();
-	if (err)
-		return err;
-
-	/*
-	 * Once the modem device is registered, the modem_nreset
-	 * regulator can be requested on behalf of that device.
-	 */
-	modem_priv.regulator = regulator_get(&ams_delta_modem_device.dev,
-			"RESET#");
-	if (IS_ERR(modem_priv.regulator)) {
-		err = PTR_ERR(modem_priv.regulator);
-		goto unregister;
-	}
-	return 0;
-
-unregister:
-	platform_device_unregister(&ams_delta_modem_device);
-	return err;
-}
-
-static void __init ams_delta_init_late(void)
-{
-	omap1_init_late();
-	late_init();
-}
-
 static void __init ams_delta_map_io(void)
 {
 	omap1_map_io();
@@ -877,7 +849,7 @@ MACHINE_START(AMS_DELTA, "Amstrad E3 (Delta)")
 	.init_early	= omap1_init_early,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= ams_delta_init,
-	.init_late	= ams_delta_init_late,
+	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
 	.restart	= omap1_restart,
 MACHINE_END
-- 
2.42.0

