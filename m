Return-Path: <linux-kernel+bounces-77418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8398604F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1FF1F24361
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F5A12D1E6;
	Thu, 22 Feb 2024 21:40:38 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA5F73F13
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708638038; cv=none; b=k2zd0DrX8/c7tQm0wv1Vdz3DtyeWPOcbRiBlYKfj0xQIiqjcXetRV/xyT1anxRc4RnNy02EeaMK2MuzWLmLob7u/96EnBu/6vgekTvCIearteMmRkiWJfMJ2tiVKMgTmMIzkTgJiorZGfnb3uiSxNtsd2Hi3VqxQVV+gAybT+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708638038; c=relaxed/simple;
	bh=FskGyQM0hnrRbCG067LMBsXVFuEu0IODjENfPSTN1Xc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVj1cmjAy+pTJa8Vuc/KSvn4KQTzz1MmXxtMooF7EKLoHvyQs+2tWY8k8++kIqASHN1MIVgLsTleVP6MqFiGUhPpf7j7hSwYGPGPfSqkXbOWkXX4QDT2yfByD5eGLiR7UMAXBchIkREtlzcS8/DrNQib8n5OZvrkaGKb1YREcm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id fe9fe7f5-d1ca-11ee-abf4-005056bdd08f;
	Thu, 22 Feb 2024 23:40:28 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Thu, 22 Feb 2024 23:40:27 +0200
To: Xing Tong Wu <xingtong_wu@163.com>
Cc: lee@kernel.org, Pavel Machek <pavel@ucw.cz>,
	Hans de Goede <hdegoede@redhat.com>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
	Xing Tong Wu <xingtong.wu@siemens.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Henning Schild <henning@hennsch.de>
Subject: Re: [RESEND PATCH v2 1/1] leds: simatic-ipc-leds-gpio: add support
 for module BX-59A
Message-ID: <Zde_S6X8OdEDyxDy@surfacebook.localdomain>
References: <20240208120901.GL689448@google.com>
 <20240218062806.3932-1-xingtong_wu@163.com>
 <20240218062806.3932-2-xingtong_wu@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218062806.3932-2-xingtong_wu@163.com>

Sun, Feb 18, 2024 at 02:28:06PM +0800, Xing Tong Wu kirjoitti:
> From: Xing Tong Wu <xingtong.wu@siemens.com>
> 
> This is used for the Siemens Simatic IPC BX-59A, which has its LEDs
> connected to GPIOs provided by the Nuvoton NCT6126D

MIssing period at the end of the sentence.

..

>  static int simatic_ipc_leds_gpio_f7188x_probe(struct platform_device *pdev)
>  {
> +	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;

dev_get_platdata()

> +	struct simatic_ipc_led_tables *led_tables;
> +
> +	led_tables = devm_kzalloc(&pdev->dev, sizeof(*led_tables), GFP_KERNEL);
> +	if (!led_tables)
> +		return -ENOMEM;
> +
> +	switch (plat->devmode) {
> +	case SIMATIC_IPC_DEVICE_227G:
> +		led_tables->led_lookup_table = &simatic_ipc_led_gpio_table_227g;
> +		led_tables->led_lookup_table_extra = &simatic_ipc_led_gpio_table_extra_227g;
> +		break;
> +	case SIMATIC_IPC_DEVICE_BX_59A:
> +		led_tables->led_lookup_table = &simatic_ipc_led_gpio_table_bx_59a;
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	dev_set_drvdata(&pdev->dev, led_tables);

platform_set_drvdata()

> +	return simatic_ipc_leds_gpio_probe(pdev, led_tables->led_lookup_table,
> +					   led_tables->led_lookup_table_extra);
>  }

..

>  static void simatic_ipc_leds_gpio_f7188x_remove(struct platform_device *pdev)
>  {
> +	struct simatic_ipc_led_tables *led_tables;

> +	led_tables = dev_get_drvdata(&pdev->dev);

platform_get_drvdata()

> +	simatic_ipc_leds_gpio_remove(pdev, led_tables->led_lookup_table,
> +				     led_tables->led_lookup_table_extra);
>  }

-- 
With Best Regards,
Andy Shevchenko



