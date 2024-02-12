Return-Path: <linux-kernel+bounces-61566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F09C28513B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F2C282E56
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DB33A1C8;
	Mon, 12 Feb 2024 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rh4+6E6f"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6083A1BC
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741876; cv=none; b=m7nPvNp4Tj2SMHoyOnKCfe52shBZSkbiz7b5mp1mLdRuFhOTxhvKducOdWBJRa5yupaB6VDQsc1jSdUMRMhRFInXt9ghLufWeuhYM7jtoWuLhFCI6Fur+tdvkuhi8QsYpV4rbG7puWQJIe+fcsuu/vmLlv1WSZU2ZwDhEptKQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741876; c=relaxed/simple;
	bh=H0znO3eD0oSu7G2J3b6kxDLB0YQVdKOrJ9kPYa67HqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nqd5AzgSLnVnKxS5JqUZnyzcvOM32Rr4Vc+kPDxLTKjpseEMAqt88uluk0Bprg1RHkHUZSrJ/Pynd3CktAtEN26m8u4eWQPKa9OY2nCpLeLpqpogE9Uc1ZtuEYP8rg/rRAMo4gdIwPYZXZ47nzIyibQF3arfzAiS7WKX7wKyDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rh4+6E6f; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51187830d6dso1117270e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 04:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707741872; x=1708346672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XvN0mE8+X+sOTUoptopXTmTpNcPMMCKjy4OSqGx44gE=;
        b=Rh4+6E6fwgcRwJDaunQ0v7cCn4neZhhZv4vrCeBWm6MsGcVJw/LrAjRM8aUY7FBVX5
         7B8qVCLolVerLarDzHRR7VpzvyoJ2jOzT2W+AyWcL0Ct9BT2s22wdZuoaPLRD8ncH0uf
         gLyBKTdkpoY1leM9mZuX3e0yn/dDo5c0VBZvWiqmfXJgqNQOA3lJsQgqPiNOCcAjRj2s
         dJBsL7TTwFioi5FlkX0yWJByRU41VAHrjZaSAvLQgwJfRTTq2zLOlYh72mHSer1TLFyy
         ISuw3MZPRkVArCNCUWbhWtRymzLoRJcc3LhXsz0r8rA4l7rjvp9rE4eBrTT32PhmBxjF
         PDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707741872; x=1708346672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvN0mE8+X+sOTUoptopXTmTpNcPMMCKjy4OSqGx44gE=;
        b=EnsNkrpe6oU7iyUFjB1ltTfVR337XUT7dZJm4WrmRaW7L07cGGqTn0+YqlBpX/xMWr
         bc3WqqUHFiVv0u9oO6wwoekUQMrKmGe4Q8MUk4S3vyXpoopONecz3+L+q2cecC0GpO8y
         /rv2FkgQR9S5II4KAso4pIDyC2l63pIu0FjWnr0saX6XdCPobCCx52cWglULWQBAUWbU
         JyWpQtPPG6Eamc6OqdmeJGpIpj4NKbHQYqmgRDnTjhagfB11oZLwsyARFHdcglogtNKX
         yIMqW8f8kVJLgadlNhbbRaQnGJhgcDVh+WHRX05sDD8/eZetzgRt/aHipWVpRUg2i8+O
         SfJA==
X-Forwarded-Encrypted: i=1; AJvYcCWTjVIxiJ+VbSIFd9zlQi2TM/mo1hJntq9nYXHdz5YV8eL7cktKr2yFyLd8E85NkRR2D3RYBH8aFJn0rku5SM6sdZh/tJyqseSHZNFE
X-Gm-Message-State: AOJu0Yy76KpcTVD59l48VHm5F7uFNHf34KrNHPYW2Z9PvKDPWGCYXhLz
	nhhYArnP7V370dm7R/dnjlkqC2m/PuJVson1A4r57iXTriGio7KcUUz6Uahbqf4=
X-Google-Smtp-Source: AGHT+IECaQR8SxGdAuBdoh2ITf4ZKxq5Ebe9H8QzZh9YQ3kzq6zuiVOl/DFf3eiPYe3IBXg8A7rqMw==
X-Received: by 2002:a05:6512:12cc:b0:511:86f8:f6a9 with SMTP id p12-20020a05651212cc00b0051186f8f6a9mr3076899lfg.22.1707741872466;
        Mon, 12 Feb 2024 04:44:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQsyLmcNz7AYCWiLFIm8eWdCgWxh+lwKbempYrtW3ICNHWg++T6oOCAsu15mIwbSj7xBE5Pml36z949yFxdSfbFZiOJHiSd2jMydY2g0oJNeQb3u0ojclTjj/XA2C6BydwAX5Q441VrduzhUdJlOuZB3hd1Mhu8CFIqwY2KC5ggXBixcxSjrWAOOt8IA/2aJu461D76jqi5nX48TALXh322aRUgGDRcmslPG9Mnlezh9zHHqhO/wDGkJefoc1aCgdO6iO+XygCM3w2dt7QyWon1GSITb66+vzDNlKwG8Ti1so6E8m9Zn2+m0CdUgSoV1zPZGZkGDmlOBROoPt9dXJWJIfYs/sTLnrTxbMVr12ASfOEKLTUG/khxdb94p9GDw8ToaLtpn6BqfkWIRFfsJwhJrF8FsZA4i2PAHhpwjNLA8RpGjtpWA==
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c248700b0040fddaf9ff4sm8470964wms.40.2024.02.12.04.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 04:44:30 -0800 (PST)
Date: Mon, 12 Feb 2024 12:44:28 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Flavio Suligoi <f.suligoi@asem.it>,
	Hans de Goede <hdegoede@redhat.com>,
	Jianhua Lu <lujianhua000@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: ktd2801: fix LED dependency
Message-ID: <20240212124428.GB4593@aspen.lan>
References: <20240212111819.936815-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212111819.936815-1-arnd@kernel.org>

On Mon, Feb 12, 2024 at 12:18:12PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The new backlight driver unconditionally selects LEDS_EXPRESSWIRE, which
> is in a different subsystem that may be disabled here:
>
> WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
>   Depends on [n]: NEW_LEDS [=n] && GPIOLIB [=y]
>   Selected by [y]:
>   - BACKLIGHT_KTD2801 [=y] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE [=y]
>
> Change the select to depends, to ensure the indirect dependency is
> met as well even when LED support is disabled.
>
> Fixes: 66c76c1cd984 ("backlight: Add Kinetic KTD2801 backlight support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/video/backlight/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 230bca07b09d..f83f9ef037fc 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -185,7 +185,7 @@ config BACKLIGHT_KTD253
>
>  config BACKLIGHT_KTD2801
>  	tristate "Backlight Driver for Kinetic KTD2801"
> -	select LEDS_EXPRESSWIRE
> +	depends on LEDS_EXPRESSWIRE

As far as I can tell this resolves the warning by making it impossible
to enable BACKLIGHT_KTD2801 unless a largely unrelated driver
(LEDS_KTD2692) is also enabled!

A better way to resolve this problem might be to eliminate the NEW_LEDS
dependency entirely:
~~~
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 64bb2de237e95..a08816cde78ae 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -186,10 +186,6 @@ config LEDS_EL15203000
          To compile this driver as a module, choose M here: the module
          will be called leds-el15203000.

-config LEDS_EXPRESSWIRE
-       bool
-       depends on GPIOLIB
-
 config LEDS_TURRIS_OMNIA
        tristate "LED support for CZ.NIC's Turris Omnia"
        depends on LEDS_CLASS_MULTICOLOR
@@ -936,3 +932,10 @@ comment "Simple LED drivers"
 source "drivers/leds/simple/Kconfig"

 endif # NEW_LEDS
+
+# This is library code that is useful for LEDs but can be enable/disabled
+# independently of NEW_LEDS. In fact it must be independent so it can be
+# selected from other sub-systems.
+config LEDS_EXPRESSWIRE
+       bool
+       depends on GPIOLIB
~~~

Alternatively we could add a "depends on NEW_LEDS" alongside the
existing select or just make LEDS_EXPRESSWIRE user selectable.

It also looks like we should put back the GPIOLIB dependency to both
 KTD2801 and KTD2692... and I'll take a mea-culpa for providing bad
 advice during the review cycles!


Daniel.

