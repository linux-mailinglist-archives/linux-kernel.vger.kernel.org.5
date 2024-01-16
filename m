Return-Path: <linux-kernel+bounces-27907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217F882F79F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7112851E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79547225A1;
	Tue, 16 Jan 2024 19:48:55 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0585067;
	Tue, 16 Jan 2024 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434534; cv=none; b=cQa3RT2WxB8ctZHlgmLA7o5EdIaeR/lSJzyGd5ypwUWu8bfiE+5Xj0TO0uc8qyPzYVEgMi2bkX6uH2Cnc2C+r/c4cUwUlY8Vr8FCwbe5R/ofm7b2G99q55p5ko0uEh591Z9qUxEitA+Z5hfAw5dfCjo2B45p4SgKzgRQgTkn2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434534; c=relaxed/simple;
	bh=sdWyjEoKGif6/an2B7pign3iWqkXxNa4bb//3OW/Wz8=;
	h=Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key; b=AAg5sBHjPARdX67MttRXwj/QJdFmyAJGYQIPzCKeA9B267v4VKR+OdSiWsZG+qxB1qTNO+JNmJQl623dAEe8ZmJOh6pb55ksZbHLAOdyBloNSFrx9tOojirUqZaOMrgZXmvsc0pDatFWEnD/iEgd52ebu6gopDjRf3OSc5kFwaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 380BF8C322;
	Tue, 16 Jan 2024 20:48:49 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Tue, 16 Jan 2024 20:48:07 +0100
Subject: [PATCH v2 2/2] input/navpoint: remove driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240116-navpoint-removal-v2-2-e566806f1009@skole.hr>
References: <20240116-navpoint-removal-v2-0-e566806f1009@skole.hr>
In-Reply-To: <20240116-navpoint-removal-v2-0-e566806f1009@skole.hr>
To: Russell King <linux@armlinux.org.uk>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=12529;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=sdWyjEoKGif6/an2B7pign3iWqkXxNa4bb//3OW/Wz8=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlpt1/PYsBOfwQrJPbFxyzg3EBHI8uxcRHYMH0F
 shOSb2DS9CJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZabdfwAKCRCaEZ6wQi2W
 4YlkEACmgaSauSumMhdTFFLn37ENNRD6pz9Q6p1mgdSnn3ccVofFdmIXe/kTjPMIvEi8C5+6ZWz
 zbTSn7fjzBoKELEpO0Luac4m7t8+sIyQNkP/T4O5JWny9hfplYUvY2iTQsCRsJnuKCYz5zWj5Jv
 w2j+b3viCr91kDrcXmTz3zM6kXp3jbyB3TLWwwakWCROdOb0t/Y9yDYmb9r7RI3iRpW2H8Ayki1
 LGjsLVbw9nN9eEy0bc8cFDHncGiMYRpnUGgQUK46bTmHParaErrqOSRhZ+a6J+ijFyZPKPU4Ug3
 Pz7I7Ha5s4GuI3WFI9TNQjHYKLW5bary/n6etxWoKfWU6ru6VN5Tjc8f5pvfcBP76fnEksEJ+Hv
 LMDtaHjOasaxsNxOHZcz2qTaa9iNiSuJMb9yxbQ1KNvZBZSx6rdBQcqah7a6Xvqq9WEWLpvc1wM
 NKP6ePEPEdVR7aFGJpFdp3pEZVQ9vjnkbaiEChbZ9oKr3oftgtuAtKFOP9ZL/NAyDyZ/KHFWt2w
 SF2tuUV4INjBj6tXD+VGt2ppx52C6hqz38dn22lZ4VYMPdujoTZ78S+iZqUzrnAXchjOEdrgj0F
 d9HCQ5rMDpUleNfNF8+iplmXbBp9OPfwk66OaCzTc0t03vIrOMf7hcZ0XJQGZp37SvZ5iQPlVtg
 +lynkH4IfT+v2OQ==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

This driver does not use the SPI core as it should, instead tampering
with the SSP registers manually. Refactoring the driver is almost
certainly not worth it as the hardware seems to have been designed for
and used only in the HP iPAQ hx4700 removed more than a year ago in
d6df7df7ae5a ("ARM: pxa: remove unused board files"), so let's remove
it.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/input/mouse/Kconfig    |  12 --
 drivers/input/mouse/Makefile   |   1 -
 drivers/input/mouse/navpoint.c | 350 -----------------------------------------
 include/linux/input/navpoint.h |   8 -
 4 files changed, 371 deletions(-)

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 32cc4c62a716..833b643f0616 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -439,16 +439,4 @@ config MOUSE_SYNAPTICS_USB
 	  To compile this driver as a module, choose M here: the
 	  module will be called synaptics_usb.
 
-config MOUSE_NAVPOINT_PXA27x
-	tristate "Synaptics NavPoint (PXA27x SSP/SPI)"
-	depends on PXA27x && PXA_SSP
-	help
-	  This driver adds support for the Synaptics NavPoint touchpad connected
-	  to a PXA27x SSP port in SPI slave mode. The device emulates a mouse;
-	  a tap or tap-and-a-half drag gesture emulates the left mouse button.
-	  For example, use the xf86-input-evdev driver for an X pointing device.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called navpoint.
-
 endif
diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
index 92b3204ce84e..a1336d5bee6f 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -15,7 +15,6 @@ obj-$(CONFIG_MOUSE_GPIO)		+= gpio_mouse.o
 obj-$(CONFIG_MOUSE_INPORT)		+= inport.o
 obj-$(CONFIG_MOUSE_LOGIBM)		+= logibm.o
 obj-$(CONFIG_MOUSE_MAPLE)		+= maplemouse.o
-obj-$(CONFIG_MOUSE_NAVPOINT_PXA27x)	+= navpoint.o
 obj-$(CONFIG_MOUSE_PC110PAD)		+= pc110pad.o
 obj-$(CONFIG_MOUSE_PS2)			+= psmouse.o
 obj-$(CONFIG_MOUSE_RISCPC)		+= rpcmouse.o
diff --git a/drivers/input/mouse/navpoint.c b/drivers/input/mouse/navpoint.c
deleted file mode 100644
index ba757783c258..000000000000
--- a/drivers/input/mouse/navpoint.c
+++ /dev/null
@@ -1,350 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Synaptics NavPoint (PXA27x SSP/SPI) driver.
- *
- * Copyright (C) 2012 Paul Parsons <lost.distance@yahoo.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/gpio/consumer.h>
-#include <linux/input.h>
-#include <linux/input/navpoint.h>
-#include <linux/interrupt.h>
-#include <linux/mutex.h>
-#include <linux/pxa2xx_ssp.h>
-#include <linux/slab.h>
-
-/*
- * Synaptics Modular Embedded Protocol: Module Packet Format.
- * Module header byte 2:0 = Length (# bytes that follow)
- * Module header byte 4:3 = Control
- * Module header byte 7:5 = Module Address
- */
-#define HEADER_LENGTH(byte)	((byte) & 0x07)
-#define HEADER_CONTROL(byte)	(((byte) >> 3) & 0x03)
-#define HEADER_ADDRESS(byte)	((byte) >> 5)
-
-struct navpoint {
-	struct ssp_device	*ssp;
-	struct input_dev	*input;
-	struct device		*dev;
-	struct gpio_desc	*gpiod;
-	int			index;
-	u8			data[1 + HEADER_LENGTH(0xff)];
-};
-
-/*
- * Initialization values for SSCR0_x, SSCR1_x, SSSR_x.
- */
-static const u32 sscr0 = 0
-	| SSCR0_TUM		/* TIM = 1; No TUR interrupts */
-	| SSCR0_RIM		/* RIM = 1; No ROR interrupts */
-	| SSCR0_SSE		/* SSE = 1; SSP enabled */
-	| SSCR0_Motorola	/* FRF = 0; Motorola SPI */
-	| SSCR0_DataSize(16)	/* DSS = 15; Data size = 16-bit */
-	;
-static const u32 sscr1 = 0
-	| SSCR1_SCFR		/* SCFR = 1; SSPSCLK only during transfers */
-	| SSCR1_SCLKDIR		/* SCLKDIR = 1; Slave mode */
-	| SSCR1_SFRMDIR		/* SFRMDIR = 1; Slave mode */
-	| SSCR1_RWOT		/* RWOT = 1; Receive without transmit mode */
-	| SSCR1_RxTresh(1)	/* RFT = 0; Receive FIFO threshold = 1 */
-	| SSCR1_SPH		/* SPH = 1; SSPSCLK inactive 0.5 + 1 cycles */
-	| SSCR1_RIE		/* RIE = 1; Receive FIFO interrupt enabled */
-	;
-static const u32 sssr = 0
-	| SSSR_BCE		/* BCE = 1; Clear BCE */
-	| SSSR_TUR		/* TUR = 1; Clear TUR */
-	| SSSR_EOC		/* EOC = 1; Clear EOC */
-	| SSSR_TINT		/* TINT = 1; Clear TINT */
-	| SSSR_PINT		/* PINT = 1; Clear PINT */
-	| SSSR_ROR		/* ROR = 1; Clear ROR */
-	;
-
-/*
- * MEP Query $22: Touchpad Coordinate Range Query is not supported by
- * the NavPoint module, so sampled values provide the default limits.
- */
-#define NAVPOINT_X_MIN		1278
-#define NAVPOINT_X_MAX		5340
-#define NAVPOINT_Y_MIN		1572
-#define NAVPOINT_Y_MAX		4396
-#define NAVPOINT_PRESSURE_MIN	0
-#define NAVPOINT_PRESSURE_MAX	255
-
-static void navpoint_packet(struct navpoint *navpoint)
-{
-	int finger;
-	int gesture;
-	int x, y, z;
-
-	switch (navpoint->data[0]) {
-	case 0xff:	/* Garbage (packet?) between reset and Hello packet */
-	case 0x00:	/* Module 0, NULL packet */
-		break;
-
-	case 0x0e:	/* Module 0, Absolute packet */
-		finger = (navpoint->data[1] & 0x01);
-		gesture = (navpoint->data[1] & 0x02);
-		x = ((navpoint->data[2] & 0x1f) << 8) | navpoint->data[3];
-		y = ((navpoint->data[4] & 0x1f) << 8) | navpoint->data[5];
-		z = navpoint->data[6];
-		input_report_key(navpoint->input, BTN_TOUCH, finger);
-		input_report_abs(navpoint->input, ABS_X, x);
-		input_report_abs(navpoint->input, ABS_Y, y);
-		input_report_abs(navpoint->input, ABS_PRESSURE, z);
-		input_report_key(navpoint->input, BTN_TOOL_FINGER, finger);
-		input_report_key(navpoint->input, BTN_LEFT, gesture);
-		input_sync(navpoint->input);
-		break;
-
-	case 0x19:	/* Module 0, Hello packet */
-		if ((navpoint->data[1] & 0xf0) == 0x10)
-			break;
-		fallthrough;
-	default:
-		dev_warn(navpoint->dev,
-			 "spurious packet: data=0x%02x,0x%02x,...\n",
-			 navpoint->data[0], navpoint->data[1]);
-		break;
-	}
-}
-
-static irqreturn_t navpoint_irq(int irq, void *dev_id)
-{
-	struct navpoint *navpoint = dev_id;
-	struct ssp_device *ssp = navpoint->ssp;
-	irqreturn_t ret = IRQ_NONE;
-	u32 status;
-
-	status = pxa_ssp_read_reg(ssp, SSSR);
-	if (status & sssr) {
-		dev_warn(navpoint->dev,
-			 "unexpected interrupt: status=0x%08x\n", status);
-		pxa_ssp_write_reg(ssp, SSSR, (status & sssr));
-		ret = IRQ_HANDLED;
-	}
-
-	while (status & SSSR_RNE) {
-		u32 data;
-
-		data = pxa_ssp_read_reg(ssp, SSDR);
-		navpoint->data[navpoint->index + 0] = (data >> 8);
-		navpoint->data[navpoint->index + 1] = data;
-		navpoint->index += 2;
-		if (HEADER_LENGTH(navpoint->data[0]) < navpoint->index) {
-			navpoint_packet(navpoint);
-			navpoint->index = 0;
-		}
-		status = pxa_ssp_read_reg(ssp, SSSR);
-		ret = IRQ_HANDLED;
-	}
-
-	return ret;
-}
-
-static void navpoint_up(struct navpoint *navpoint)
-{
-	struct ssp_device *ssp = navpoint->ssp;
-	int timeout;
-
-	clk_prepare_enable(ssp->clk);
-
-	pxa_ssp_write_reg(ssp, SSCR1, sscr1);
-	pxa_ssp_write_reg(ssp, SSSR, sssr);
-	pxa_ssp_write_reg(ssp, SSTO, 0);
-	pxa_ssp_write_reg(ssp, SSCR0, sscr0);	/* SSCR0_SSE written last */
-
-	/* Wait until SSP port is ready for slave clock operations */
-	for (timeout = 100; timeout != 0; --timeout) {
-		if (!(pxa_ssp_read_reg(ssp, SSSR) & SSSR_CSS))
-			break;
-		msleep(1);
-	}
-
-	if (timeout == 0)
-		dev_err(navpoint->dev,
-			"timeout waiting for SSSR[CSS] to clear\n");
-
-	gpiod_set_value(navpoint->gpiod, 1);
-}
-
-static void navpoint_down(struct navpoint *navpoint)
-{
-	struct ssp_device *ssp = navpoint->ssp;
-
-	gpiod_set_value(navpoint->gpiod, 0);
-
-	pxa_ssp_write_reg(ssp, SSCR0, 0);
-
-	clk_disable_unprepare(ssp->clk);
-}
-
-static int navpoint_open(struct input_dev *input)
-{
-	struct navpoint *navpoint = input_get_drvdata(input);
-
-	navpoint_up(navpoint);
-
-	return 0;
-}
-
-static void navpoint_close(struct input_dev *input)
-{
-	struct navpoint *navpoint = input_get_drvdata(input);
-
-	navpoint_down(navpoint);
-}
-
-static int navpoint_probe(struct platform_device *pdev)
-{
-	const struct navpoint_platform_data *pdata =
-					dev_get_platdata(&pdev->dev);
-	struct ssp_device *ssp;
-	struct input_dev *input;
-	struct navpoint *navpoint;
-	int error;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data\n");
-		return -EINVAL;
-	}
-
-	ssp = pxa_ssp_request(pdata->port, pdev->name);
-	if (!ssp)
-		return -ENODEV;
-
-	/* HaRET does not disable devices before jumping into Linux */
-	if (pxa_ssp_read_reg(ssp, SSCR0) & SSCR0_SSE) {
-		pxa_ssp_write_reg(ssp, SSCR0, 0);
-		dev_warn(&pdev->dev, "ssp%d already enabled\n", pdata->port);
-	}
-
-	navpoint = kzalloc(sizeof(*navpoint), GFP_KERNEL);
-	input = input_allocate_device();
-	if (!navpoint || !input) {
-		error = -ENOMEM;
-		goto err_free_mem;
-	}
-
-	navpoint->gpiod = gpiod_get_optional(&pdev->dev,
-					     NULL, GPIOD_OUT_LOW);
-	if (IS_ERR(navpoint->gpiod)) {
-		error = PTR_ERR(navpoint->gpiod);
-		dev_err(&pdev->dev, "error getting GPIO\n");
-		goto err_free_mem;
-	}
-	gpiod_set_consumer_name(navpoint->gpiod, "SYNAPTICS_ON");
-
-	navpoint->ssp = ssp;
-	navpoint->input = input;
-	navpoint->dev = &pdev->dev;
-
-	input->name = pdev->name;
-	input->dev.parent = &pdev->dev;
-
-	__set_bit(EV_KEY, input->evbit);
-	__set_bit(EV_ABS, input->evbit);
-	__set_bit(BTN_LEFT, input->keybit);
-	__set_bit(BTN_TOUCH, input->keybit);
-	__set_bit(BTN_TOOL_FINGER, input->keybit);
-
-	input_set_abs_params(input, ABS_X,
-			     NAVPOINT_X_MIN, NAVPOINT_X_MAX, 0, 0);
-	input_set_abs_params(input, ABS_Y,
-			     NAVPOINT_Y_MIN, NAVPOINT_Y_MAX, 0, 0);
-	input_set_abs_params(input, ABS_PRESSURE,
-			     NAVPOINT_PRESSURE_MIN, NAVPOINT_PRESSURE_MAX,
-			     0, 0);
-
-	input->open = navpoint_open;
-	input->close = navpoint_close;
-
-	input_set_drvdata(input, navpoint);
-
-	error = request_irq(ssp->irq, navpoint_irq, 0, pdev->name, navpoint);
-	if (error)
-		goto err_free_mem;
-
-	error = input_register_device(input);
-	if (error)
-		goto err_free_irq;
-
-	platform_set_drvdata(pdev, navpoint);
-	dev_dbg(&pdev->dev, "ssp%d, irq %d\n", pdata->port, ssp->irq);
-
-	return 0;
-
-err_free_irq:
-	free_irq(ssp->irq, navpoint);
-err_free_mem:
-	input_free_device(input);
-	kfree(navpoint);
-	pxa_ssp_free(ssp);
-
-	return error;
-}
-
-static void navpoint_remove(struct platform_device *pdev)
-{
-	struct navpoint *navpoint = platform_get_drvdata(pdev);
-	struct ssp_device *ssp = navpoint->ssp;
-
-	free_irq(ssp->irq, navpoint);
-
-	input_unregister_device(navpoint->input);
-	kfree(navpoint);
-
-	pxa_ssp_free(ssp);
-}
-
-static int navpoint_suspend(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct navpoint *navpoint = platform_get_drvdata(pdev);
-	struct input_dev *input = navpoint->input;
-
-	mutex_lock(&input->mutex);
-	if (input_device_enabled(input))
-		navpoint_down(navpoint);
-	mutex_unlock(&input->mutex);
-
-	return 0;
-}
-
-static int navpoint_resume(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct navpoint *navpoint = platform_get_drvdata(pdev);
-	struct input_dev *input = navpoint->input;
-
-	mutex_lock(&input->mutex);
-	if (input_device_enabled(input))
-		navpoint_up(navpoint);
-	mutex_unlock(&input->mutex);
-
-	return 0;
-}
-
-static DEFINE_SIMPLE_DEV_PM_OPS(navpoint_pm_ops,
-				navpoint_suspend, navpoint_resume);
-
-static struct platform_driver navpoint_driver = {
-	.probe		= navpoint_probe,
-	.remove_new	= navpoint_remove,
-	.driver = {
-		.name	= "navpoint",
-		.pm	= pm_sleep_ptr(&navpoint_pm_ops),
-	},
-};
-
-module_platform_driver(navpoint_driver);
-
-MODULE_AUTHOR("Paul Parsons <lost.distance@yahoo.com>");
-MODULE_DESCRIPTION("Synaptics NavPoint (PXA27x SSP/SPI) driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:navpoint");
diff --git a/include/linux/input/navpoint.h b/include/linux/input/navpoint.h
deleted file mode 100644
index 5192ae3f5ec1..000000000000
--- a/include/linux/input/navpoint.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  Copyright (C) 2012 Paul Parsons <lost.distance@yahoo.com>
- */
-
-struct navpoint_platform_data {
-	int		port;		/* PXA SSP port for pxa_ssp_request() */
-};

-- 
2.43.0



