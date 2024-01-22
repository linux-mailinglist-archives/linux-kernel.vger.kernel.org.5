Return-Path: <linux-kernel+bounces-32723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBCA835F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE371F21CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280463AC19;
	Mon, 22 Jan 2024 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WtQICkc8"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B003A8EA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918773; cv=none; b=lEASb4JzMEqTJzZkEVnJuE1m2xupGapk7OyqR8Qd5z5+aermKBvOEKWz8W1E/EQxUg0s9+h99bWKUINBbgM6uf0ibPBJdYC0TWVW2x8VuRgmmSq8mlGXF2kY80KW8Ckx+Pb22sLKhLpURy0FnlBoESWqVuLfgwGuthuhd5P+BY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918773; c=relaxed/simple;
	bh=/SNLHHN7xOHjhgf5Ka2VMBrDa6pANZCIGYnQJH8RKpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMQ9Tqr1PA88a1o2UqVmbWyETUQzQm6tt/OIzV0os2OlnwoPOwrLRdA3sCZsRoXGivaiOT1OTrCy5YYetCOExAJqdJqcVVih31VVlSls1usICFqcmlczKSi94C7MZ55JBxQYbCEsJ7k2vzfRkjqic9A1sdFOuyUoc14+lKKf4WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WtQICkc8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40eacb4bfa0so9126355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705918769; x=1706523569; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6CUlLsOEJCO3o0htEYr8Lbj/bayNpoeF4Yah4if4kLc=;
        b=WtQICkc8gaYMT3ZMfWqXR1v+0Gf5KtlFeiUD0rSgSx1nNdGnGlNSiQoENFBZDtuSYq
         Vh4ac5BIzGlq+mCzcF5KE8sMLXnrc7ELMooSqig/dh8wzf6GNTJs4QmwFvegB37gEJv2
         fInxTyv3cuKkKkYhS4+wJHJeSZqYaTzhJQfoyReb4l6VQpSJNrmbor2NWKf5vzXT61ER
         oky1p/zXf5u8pkjGH23oAg33Yd3/gwThAjN7XAZWKSkb40qIEHJxY6aF/Jz43P83fX4k
         N9an9FzAJFBiXe0MOsKBR8DQ6jJXWm2gT5pEcEn0m8zDPBHsXGbZLv1FMXqmiqk9GrwA
         QRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705918769; x=1706523569;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6CUlLsOEJCO3o0htEYr8Lbj/bayNpoeF4Yah4if4kLc=;
        b=W/eWEDyhtxYJWah5GwCqgnX4uGqFk11O56HECl1h+WNde80kzbQSe4MUe1IGNWyny3
         Zu/phgbD1IMI1vJAiuyWlye2LBTSe0q6tgAFuP/yum7mG249DD66t1KhrWKcA9OWHVpk
         kERoeiLooNsGjNrgp5MFtQscP375wwhmvumCIPgeaLfaLZS9fj8aOhL1BcWTVD1pQ9FJ
         2IJRtVl9ft7PtpjSGjZhHhiO0zLFa4GtmwCZ/Y3i9QXWBPtvlR7UY1OY+cik3g8Nii4Z
         8mAnHBWj9DuB4IFYGiZF7HvmedC5w5HsCdfpua+NJwpR2DQO3Ut9DroFWHmpLPbN7qT/
         l+iw==
X-Gm-Message-State: AOJu0YyDakKbedZMZ2B7P6VVSpg0F7/MpLwY6sVYnDfYBja1TXjJ5Nex
	vHWXV0VO3NjHe9gKakMKkTH2DKKkAvWD9oa5TwZ9lQVFIRKpVAN4SMVcQu5lq5w=
X-Google-Smtp-Source: AGHT+IGiXCkeFT62mIizDAGCPWlt7/MMpjwMRYs+WW2Kwg136ect9locc0HoNUSbJlXRnS59IcBghQ==
X-Received: by 2002:a05:600c:5486:b0:40e:7c23:898d with SMTP id iv6-20020a05600c548600b0040e7c23898dmr2156961wmb.102.1705918769050;
        Mon, 22 Jan 2024 02:19:29 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0040d8ff79fd8sm38663573wmb.7.2024.01.22.02.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:19:28 -0800 (PST)
Date: Mon, 22 Jan 2024 10:19:26 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Karel Balej <balejk@matfyz.cz>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/3] leds: ktd2692: move ExpressWire code to library
Message-ID: <20240122101926.GA8596@aspen.lan>
References: <20240120-ktd2801-v3-0-fe2cbafffb21@skole.hr>
 <20240120-ktd2801-v3-1-fe2cbafffb21@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240120-ktd2801-v3-1-fe2cbafffb21@skole.hr>

On Sat, Jan 20, 2024 at 10:26:43PM +0100, Duje Mihanović wrote:
> The ExpressWire protocol is shared between at least KTD2692 and KTD2801
> with slight differences such as timings and the former not having a
> defined set of pulses for enabling the protocol (possibly because it
> does not support PWM unlike KTD2801). Despite these differences the
> ExpressWire handling code can be shared between the two, so move it into
> a library in preparation for adding KTD2801 support.
>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
>  MAINTAINERS                       |  7 +++
>  drivers/leds/Kconfig              |  3 ++
>  drivers/leds/Makefile             |  3 ++
>  drivers/leds/flash/Kconfig        |  1 +
>  drivers/leds/flash/leds-ktd2692.c | 91 +++++++++++----------------------------
>  drivers/leds/leds-expresswire.c   | 59 +++++++++++++++++++++++++
>  include/linux/leds-expresswire.h  | 35 +++++++++++++++
>  7 files changed, 132 insertions(+), 67 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a7c4cf8201e0..87b12d2448a0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7902,6 +7902,13 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
>  F:	fs/exfat/
>
> +EXPRESSWIRE PROTOCOL LIBRARY
> +M:	Duje Mihanović <duje.mihanovic@skole.hr>
> +L:	linux-leds@vger.kernel.org
> +S:	Maintained
> +F:	drivers/leds/leds-expresswire.c
> +F:	include/linux/leds-expresswire.h
> +
>  EXT2 FILE SYSTEM
>  M:	Jan Kara <jack@suse.com>
>  L:	linux-ext4@vger.kernel.org
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 6292fddcc55c..d29b6823e7d1 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -181,6 +181,9 @@ config LEDS_EL15203000
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called leds-el15203000.
>
> +config LEDS_EXPRESSWIRE
> +	bool
> +

Shouldn't there be a "select GPIOLIB" here? It seems odd to make the
clients responsible for the dependencies.

BTW there seems to be very little consistency across the kernel between
"depends on GPIOLIB" and "select GPIOLIB".. but select is marginally
more popular (283 vs. 219 in the kernel I checked).


> diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-ktd2692.c
> index 598eee5daa52..8c17de3d621f 100644
> --- a/drivers/leds/flash/leds-ktd2692.c
> +++ b/drivers/leds/flash/leds-ktd2692.c
>  <snip>
>  static void ktd2692_expresswire_write(struct ktd2692_context *led, u8 value)
>  {
>  	int i;
>
> -	ktd2692_expresswire_start(led);
> +	expresswire_start(&led->props);
>  	for (i = 7; i >= 0; i--)
> -		ktd2692_expresswire_set_bit(led, value & BIT(i));
> -	ktd2692_expresswire_end(led);
> +		expresswire_set_bit(&led->props, value & BIT(i));
> +	expresswire_end(&led->props);
>  }

Is there any reason not to have an expresswire_write_u8() method in the
library code? It is a concept that appears in both drivers.


Daniel.

