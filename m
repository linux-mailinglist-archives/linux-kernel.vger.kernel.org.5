Return-Path: <linux-kernel+bounces-49852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B807C847082
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7287F2932EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B2517D2;
	Fri,  2 Feb 2024 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMWZWDzU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BD15C3;
	Fri,  2 Feb 2024 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877726; cv=none; b=jP7Rdm17LZlfBPd/IHTb+Fu8vJwMrwIIPFLFGVaq3GV5yrj8TRGyo2FCytxHODIYqE+ucJUC8wHJPtUPPC3r206DkvrEwOmDlfqeX5rDXlkkSuUwbk1jmL109niB3iUao05Y6hmwTvKXNY7ZcX+H2hv62Q/GiIdqWeRKurb0x14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877726; c=relaxed/simple;
	bh=N9Gnq6soIeqbrsWD9myMLZqlJRlR1CNafdpXtCuLg9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVlpYc/Np8H5RVPxzeaLOFpHXDZFLRmUKXBHW6ySY/CTAmN8o9KJcvDS0Ljz75alvXcxiARsPu4M3+2wWrVnMDfnf1Hs6/SEpRyis2nlfKhAAt5vfRWcl8TKLzRkLNQJGWi/EOUtXqWcqG2WVk2YHLo70SJWnvCoKBT4qrDUtHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMWZWDzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4454FC433C7;
	Fri,  2 Feb 2024 12:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706877726;
	bh=N9Gnq6soIeqbrsWD9myMLZqlJRlR1CNafdpXtCuLg9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMWZWDzUwCZ7FSItV20S6xS2m7NmjioiaHchXA6pqFULzdRvCXAtMAbrlgj1LtajR
	 kOXRSZ24bnXImJbZC+UteGA3rdkWiN+2KGqN5GojwXNhpUWGLHg9Egqj2+/nwpIzUU
	 7wwiKa7jJi2B2oB8qL5AViM7XUbbOGAWV3q9nmdM6a/XP+OI+kkNT4jMe2TBQY/DE6
	 r+y//tsfhuCltXal6BpUSUZuQAI8WlkeiEg/JizlalfvPz4E06LUKaMcKZq93SLbIi
	 moh5SsYaRolKTG0cBE6V7w+62MXzsrbSnLrMJCLZJeXHR9az07By6fvZKbyPef7Jre
	 uKzSPkxVDlWRQ==
Date: Fri, 2 Feb 2024 12:42:01 +0000
From: Lee Jones <lee@kernel.org>
To: "xingtong.wu" <xingtong_wu@163.com>
Cc: hdegoede@redhat.com, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, pavel@ucw.cz, xingtong.wu@siemens.com,
	tobias.schaffner@siemens.com, gerd.haeussler.ext@siemens.com,
	henning@hennsch.de
Subject: Re: [PATCH 2/3] leds: simatic-ipc-leds-gpio: add support for module
 BX-59A
Message-ID: <20240202124201.GC1379817@google.com>
References: <20230731071424.4663-1-xingtong_wu@163.com>
 <20230731071833.4725-1-xingtong_wu@163.com>
 <58d93fe1.336d.18d67e31aaa.Coremail.xingtong_wu@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58d93fe1.336d.18d67e31aaa.Coremail.xingtong_wu@163.com>

On Fri, 02 Feb 2024, xingtong.wu wrote:

> At 2023-07-31 15:18:33, xingtong_wu@163.com wrote:
> >From: "xingtong.wu" <xingtong.wu@siemens.com>
> >
> >This is used for the Siemens Simatic IPC BX-59A, which has its LEDs
> >connected to GPIOs provided by the Nuvoton NCT6126D
> >
> >Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
> >---
> > .../leds/simple/simatic-ipc-leds-gpio-core.c  |  1 +
> > .../simple/simatic-ipc-leds-gpio-f7188x.c     | 42 ++++++++++++++++---
> > 2 files changed, 37 insertions(+), 6 deletions(-)
> >
> >diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
> >index c552ea73ed9d..10dca208d8cc 100644
> >--- a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
> >+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
> >@@ -58,6 +58,7 @@ int simatic_ipc_leds_gpio_probe(struct platform_device *pdev,
> > 	case SIMATIC_IPC_DEVICE_127E:
> > 	case SIMATIC_IPC_DEVICE_227G:
> > 	case SIMATIC_IPC_DEVICE_BX_21A:
> >+	case SIMATIC_IPC_DEVICE_BX_59A:
> > 		break;
> > 	default:
> > 		return -ENODEV;
> >diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
> >index 583a6b6c7c22..a5b544b20857 100644
> >--- a/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
> >+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
> >@@ -17,7 +17,10 @@
> > 
> > #include "simatic-ipc-leds-gpio.h"
> > 
> >-static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
> >+static struct gpiod_lookup_table *led_lookup_table;
> >+static struct gpiod_lookup_table *led_lookup_table_extra;
> >+
> >+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
> > 	.dev_id = "leds-gpio",
> > 	.table = {
> > 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_LOW),
> >@@ -30,7 +33,7 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
> > 	},
> > };
> > 
> >-static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra = {
> >+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra_227g = {
> > 	.dev_id = NULL, /* Filled during initialization */
> > 	.table = {
> > 		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
> >@@ -39,16 +42,43 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra = {
> > 	},
> > };
> > 
> >+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_bx_59a = {
> >+	.dev_id = "leds-gpio",
> >+	.table = {
> >+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_LOW),
> >+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 1, GPIO_ACTIVE_LOW),
> >+		GPIO_LOOKUP_IDX("gpio-f7188x-5", 3, NULL, 2, GPIO_ACTIVE_LOW),
> >+		GPIO_LOOKUP_IDX("gpio-f7188x-5", 2, NULL, 3, GPIO_ACTIVE_LOW),
> >+		GPIO_LOOKUP_IDX("gpio-f7188x-7", 7, NULL, 4, GPIO_ACTIVE_LOW),
> >+		GPIO_LOOKUP_IDX("gpio-f7188x-7", 4, NULL, 5, GPIO_ACTIVE_LOW),
> >+		{} /* Terminating entry */
> >+	}
> >+};
> >+
> > static int simatic_ipc_leds_gpio_f7188x_probe(struct platform_device *pdev)
> > {
> >-	return simatic_ipc_leds_gpio_probe(pdev, &simatic_ipc_led_gpio_table,
> >-					   &simatic_ipc_led_gpio_table_extra);
> >+	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
> >+
> >+	switch (plat->devmode) {
> >+	case SIMATIC_IPC_DEVICE_227G:
> >+		led_lookup_table = &simatic_ipc_led_gpio_table_227g;
> >+		led_lookup_table_extra = &simatic_ipc_led_gpio_table_extra_227g;
> >+		break;
> >+	case SIMATIC_IPC_DEVICE_BX_59A:
> >+		led_lookup_table = &simatic_ipc_led_gpio_table_bx_59a;
> >+		break;
> >+	default:
> >+		return -ENODEV;
> >+	}
> >+
> >+	return simatic_ipc_leds_gpio_probe(pdev, led_lookup_table,
> >+					   led_lookup_table_extra);
> > }
> > 
> > static int simatic_ipc_leds_gpio_f7188x_remove(struct platform_device *pdev)
> > {
> >-	return simatic_ipc_leds_gpio_remove(pdev, &simatic_ipc_led_gpio_table,
> >-					    &simatic_ipc_led_gpio_table_extra);
> >+	return simatic_ipc_leds_gpio_remove(pdev, led_lookup_table,
> >+					    led_lookup_table_extra);
> > }
> > 
> > static struct platform_driver simatic_ipc_led_gpio_driver = {
> >-- 
> >2.25.1
> 
> Hi
> 
> After engaging in a thorough discussion, it appears that we have
> reached a consensus to merge this patch.

I have no idea what you're referring to here.

> Considering the considerable
> duration that has passed, I am sending this email as a gentle reminder,
> in case there is a possibility that it may have slipped your mind.

Please resubmit all unmerged patches as a [RESEND].

-- 
Lee Jones [李琼斯]

