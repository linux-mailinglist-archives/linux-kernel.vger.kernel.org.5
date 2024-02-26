Return-Path: <linux-kernel+bounces-80424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE905866857
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FED281E23
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC02101D5;
	Mon, 26 Feb 2024 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ld+7pNoO"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0B1798A;
	Mon, 26 Feb 2024 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708915797; cv=none; b=W+IQxJg45Z6agU+QnAN9sipVSSEaDRBHTeooqp3+x+ie7AeH8OVMcQ+v6kS4bC+ApA8xFtJL1Knba3iFf/8YOMBvIuMrpyVEDXea1ve0/woYegcHZiqoMWk7SEKDfYKzbZB+sBXEveCHSQ9CvNg2kBuJnkS4WMhOuuiM1b5hNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708915797; c=relaxed/simple;
	bh=DcMacE/T1H711vYK5u4ErqYTR46rEQvC6GPq8x7rzXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbwFIY9tqH1T+j4CA5IMAdqKTGdByrLYGwWBjRpNNdLYou8ORVho7qt9aWZrrscyhvi/ma0UCyGbz8152lxnMPcIQpw2J81+dM+E0BReYj/GW/yWBExEhyFxUr8DLGYv1uWkgxh8Gl4k3fDmlGaWhaBGlCziO1qTygBitpLRqUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ld+7pNoO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=MhQaDMhNf1pMBewPwvsaNlydCejp+LUoROz0d2JINCQ=; b=Ld+7pNoOZnggeiHJnCxAAGqS8S
	nITJ2hDxhbJ0+rZtQpiwec2j3cMW13cc7zMApsEmpBxQkzOi3PbXeFGzpqujFvhZ+bmzdo29dKYu+
	vAdQDEYgL0hB9okrXxK/W+wjETKtabIrt7nvmvitPjSMTFJGWKZPwW1LVlJIBo2kgtpxxHjR+DaNq
	kNSJ07KvX7//wxEKNGTF6roo6S0RxqI6JrxMwcYvQq8XYf/jMmmnGKLOooSNxA8UhsPu3/bIZGrNn
	yIU3a/N7QJbm9wxupceEDLel0DA6xGhESb4J90rhFq/XDHCspRIaZE4DBCHLNMUa/klSruoURJX5+
	Atf8Ok5A==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reR3v-0000000GCxT-0C2G;
	Mon, 26 Feb 2024 02:49:51 +0000
Message-ID: <7ef941f5-fd2f-4893-81e1-94f5aabf6ac3@infradead.org>
Date: Sun, 25 Feb 2024 18:49:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] auxdisplay: Add 7 segment LED display driver
Content-Language: en-US
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, ojeda@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, andy.shevchenko@gmail.com,
 geert@linux-m68k.org, pavel@ucw.cz, lee@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org
References: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
 <20240225213423.690561-2-chris.packham@alliedtelesis.co.nz>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240225213423.690561-2-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 2/25/24 13:34, Chris Packham wrote:
> Add a driver for a 7 segment LED display. At the moment only one
> character is supported but it should be possible to expand this to
> support more characters and/or 14 segment displays in the future.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  drivers/auxdisplay/Kconfig   |   7 ++
>  drivers/auxdisplay/Makefile  |   1 +
>  drivers/auxdisplay/seg-led.c | 152 +++++++++++++++++++++++++++++++++++
>  3 files changed, 160 insertions(+)
>  create mode 100644 drivers/auxdisplay/seg-led.c
> 
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index d944d5298eca..e826b5b15881 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -197,6 +197,13 @@ config ARM_CHARLCD
>  	  line and the Linux version on the second line, but that's
>  	  still useful.
>  
> +config SEG_LED
> +	bool "Generic 7 segment LED display"
> +	select LINEDISP
> +	help
> +	  This driver supports a generic 7 segment LED display made up

	                                 7-segment

> +	  of GPIO pins connected to the individual segments.
> +
>  menuconfig PARPORT_PANEL
>  	tristate "Parallel port LCD/Keypad Panel support"
>  	depends on PARPORT
> diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
> index 6968ed4d3f0a..808fdf156bd5 100644
> --- a/drivers/auxdisplay/Makefile
> +++ b/drivers/auxdisplay/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_HT16K33)		+= ht16k33.o
>  obj-$(CONFIG_PARPORT_PANEL)	+= panel.o
>  obj-$(CONFIG_LCD2S)		+= lcd2s.o
>  obj-$(CONFIG_LINEDISP)		+= line-display.o
> +obj-$(CONFIG_SEG_LED)		+= seg-led.o
> diff --git a/drivers/auxdisplay/seg-led.c b/drivers/auxdisplay/seg-led.c
> new file mode 100644
> index 000000000000..c0b302a09cbb
> --- /dev/null
> +++ b/drivers/auxdisplay/seg-led.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for a 7 segment LED display
> + *
> + * The GPIOs are wired to the 7 segments in a clock wise fashion starting from
> + * the top.
> + *
> + *      -a-
> + *     |   |
> + *     f   b
> + *     |   |
> + *      -g-
> + *     |   |
> + *     e   c
> + *     |   |
> + *      -d-
> + *
> + * The decimal point LED presnet on some devices is currently not

                            present

> + * supported.
> + *
> + * Copyright (C) Allied Telesis Labs
> + */

-- 
#Randy

