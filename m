Return-Path: <linux-kernel+bounces-37413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF8C83AFE5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B2A7B2614A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D224128371;
	Wed, 24 Jan 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IoD76UXl"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B14E1272D0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116798; cv=none; b=cGXt1GZKzbC775uCjJnJODklGGncsTWBDHsxUnNu9ShZvwE2CVcoeEHS9jT44jbsWZjEzYPqdYyCXZ0M/b1Bg/ElhOhm/GLMCSrWZBuhXYlSCuOLVEIt+KBq2ogUFJLYTsGfhG76dEIc9Zcq9fyTTdcMD8EQ0FwkQYaIixPz+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116798; c=relaxed/simple;
	bh=R6A7ukuw2BnIoPYwMMFegYFd5aofoPlUPz7xmyPKcKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txO779iyvuJai3H/Y566IzsUr2gRzQN+I329NUdFjnI6ECc3UfEYo+4arwjKS37yHdE8ktW/v7CvxjisipDy2UrPlAim4dg8P40bWQ4sYDVH8Wf9cEZ+iSL9uEN+VOtsMoclSmYq4UnjFaTaQw11BsG8qGhFX8UNAsEHVEWXq1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IoD76UXl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-337cf4eabc9so4632784f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706116795; x=1706721595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3a+DNtECmvubjsLdhByFOruS2nKP6Q4o/Q4YSoYzCk=;
        b=IoD76UXlrbbbbDmg9z990p1j/PZyGEts+W3nkLeT/qxbl134ukM9aVMcw0by6H3Pb2
         NrBzYEeLWIRB0aHHRC8R0en1KHMpaXXHNlsKjwYnDZH2+P7mzpF/sGTVliPZPLeQOCV3
         TykLOhqIX0jCe6cFl7TjBkBmw0paV4xmKPav+c9W0SR2ksPo6Bc7tERLFK7aih+C9n9X
         T/DrI6eC9IEaJ3ZJv86f+db8a5TfsVEoCkAkwqJzDT++vAT6iPRqlOBvOC2Fh3up/7T+
         WUPiacb+cTsPHyqqC0og/aqfvC12gLfAI/x8R2+7l0OyGP5sbeqliWfJ5d+0rAG+3r3+
         MfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116795; x=1706721595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3a+DNtECmvubjsLdhByFOruS2nKP6Q4o/Q4YSoYzCk=;
        b=gYdPBTc9w6H+XdLMhxeVX0ZoiQacz/Y6ZKrGcMBbgMbCP6Ov/aAJy9cLWxceFOhmKM
         MQfjrPeRuIiZ2b6C/iGEw4uqsFnQTgcwMbLGUmFk8gU9EcdOOYxqo4RTdPEEMmx70Li9
         wCr94bZ/AqcXczxQ7MIWLDwCEBq75pHhX4bbHepjjYcxkh7E/Sokd0oqhwrJ60UF2Gn0
         TC1ds7TzSOONHJ8viDq4W+m+9uOtSd3hNSldxMtEAwsWQo9TgLCOMfkYqpAptfufvFyT
         2phu4V/BZHmlfWIc3xosjJSJIw4sRQvvpYq94san2s5h3fyi2Vd44bin0Au2+CNM02Dl
         gXsQ==
X-Gm-Message-State: AOJu0YxXUneEbF/aC/NlIKiwfGF/4FiZLETTsQz4ubar4xOAZndKYI80
	bOBbXQaPjEb+PkfFyFAnAIdgpcDx/99JCcLwk0SrE92JqhcO8zha98UGZ8ZHZkc=
X-Google-Smtp-Source: AGHT+IF2PLiH41Eqpuhe6kbhSpWxzeOappELX/qRauwkSGF7Z3O3gB6rW0/YAAZnyx7oHR8llwr4WQ==
X-Received: by 2002:adf:f345:0:b0:339:359c:3d3d with SMTP id e5-20020adff345000000b00339359c3d3dmr752932wrp.14.1706116795299;
        Wed, 24 Jan 2024 09:19:55 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d4904000000b0033928514699sm11805827wrq.2.2024.01.24.09.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:54 -0800 (PST)
Date: Wed, 24 Jan 2024 17:19:53 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 1/4] backlight: hx8357: Make use of device properties
Message-ID: <20240124171953.GA15539@aspen.lan>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240114152759.1040563-2-andriy.shevchenko@linux.intel.com>

On Sun, Jan 14, 2024 at 05:25:08PM +0200, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
>
> Include mod_devicetable.h explicitly to replace the dropped of.h
> which included mod_devicetable.h indirectly.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/video/backlight/hx8357.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
> index bf18337ff0c2..c7fd10d55c5d 100644
> --- a/drivers/video/backlight/hx8357.c
> +++ b/drivers/video/backlight/hx8357.c
> @@ -8,9 +8,9 @@
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/lcd.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/property.h>
>  #include <linux/spi/spi.h>
>
>  #define HX8357_NUM_IM_PINS	3
> @@ -564,6 +564,8 @@ static struct lcd_ops hx8357_ops = {
>  	.get_power	= hx8357_get_power,
>  };
>
> +typedef int (*hx8357_init)(struct lcd_device *);
> +
>  static const struct of_device_id hx8357_dt_ids[] = {
>  	{
>  		.compatible = "himax,hx8357",
> @@ -582,7 +584,7 @@ static int hx8357_probe(struct spi_device *spi)
>  	struct device *dev = &spi->dev;
>  	struct lcd_device *lcdev;
>  	struct hx8357_data *lcd;
> -	const struct of_device_id *match;
> +	hx8357_init init;

As somewhere else in this thread, I'd find this a lot more readable
as:
	hx8357_init_fn init_fn;

Other than that, LGTM.


Daniel.

