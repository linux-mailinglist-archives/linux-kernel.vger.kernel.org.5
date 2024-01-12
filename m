Return-Path: <linux-kernel+bounces-24222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D0682B94D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72BD3B230A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5147139E;
	Fri, 12 Jan 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBP/Ghlh"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DFCEA6;
	Fri, 12 Jan 2024 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d4a2526a7eso36235285ad.3;
        Thu, 11 Jan 2024 18:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705024823; x=1705629623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d8C8D0g6wmsQgqFG6zgRhQvyei84I26PEqXA/fE8F5Q=;
        b=IBP/GhlhwWsK9dqSr+2Id/2h20kACkYrBwYSITeiwZJX5DMFdClPlYExQGqlvR4CdL
         roJMo6Ifz60gClEVkWPT6vKaYgbzIAZOAQZ+aLLygN2XtN8AMj7el1dVfCVl5gsXLSNv
         6zx1nMfk4/WNuZTR/tF/jCDdIdnvDWqsDYD2+A7USUBc5Y83e3kYDKq5oUWaHWNwZDi8
         NnDAokHd6pipVQ7VcrvidLSU/sIGD0KknC61NiLnK4abQOan8n0hZ93+N2CRoFR6FzWq
         ptZYvfsEt6srdIlz4rvHZMe/mKuQtl1l77lYBurfHbQwd4WMzjhgiRJx3hThVDvHja7D
         fa/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705024823; x=1705629623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8C8D0g6wmsQgqFG6zgRhQvyei84I26PEqXA/fE8F5Q=;
        b=L6mj/GP/zcyIN7pceQR5hB0VWSa6yOJNHxvB7kMFlY2F2oVhxmY2z8huxJ+HfJoVSD
         un9OoXELRXdAhk4CLXnQu1xHobY3uawzvz/p4pdcLXg+o9xnDcJTvHavXFYvw8jsRMPE
         FjSU1jPRZilN6tK2IUz+AYJmDrWo/oGRJos0WQZzWB9UlHsWVC51NKjmuda2ySAfHlqs
         OVsPG6AmFbAFqyMvHEKvkhiHXjz93hDIG+c70MaN2vZeJ9BLTUE00iQxWQFmWfEEiQjS
         Z8TBcWE5wxutrdtsrSeHKI7MFufk7OXsM16HlJrpgwfXgfsue3XfIHHHt3WfO95otFDK
         dEBw==
X-Gm-Message-State: AOJu0YxN7Cr8x3pYnQKLnD7pV/59NMfbwirE9XFbPGEc3oupbV9aEft/
	UNwZDlqePYIaJpYZJK7EhJE=
X-Google-Smtp-Source: AGHT+IEOwfPy/eOHS6ZwloY83qyJPgqnfSE6Rm3wSNlDD8FgORnQhh+BBSCTc9QOVeukZC7qS3H8OQ==
X-Received: by 2002:a17:902:c38c:b0:1d4:b199:bca2 with SMTP id g12-20020a170902c38c00b001d4b199bca2mr194945plg.78.1705024823107;
        Thu, 11 Jan 2024 18:00:23 -0800 (PST)
Received: from localhost ([2804:30c:924:6f00:42e7:f3b7:14b8:1cbe])
        by smtp.gmail.com with ESMTPSA id d24-20020a170902aa9800b001d3563c87a6sm1851913plr.281.2024.01.11.18.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 18:00:22 -0800 (PST)
Date: Thu, 11 Jan 2024 23:00:22 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7091r8: Fix error code in
 ad7091r8_gpio_setup()
Message-ID: <ZaCdNl6S1IRjyWru@debian-BULLSEYE-live-builder-AMD64>
References: <fd905ad0-6413-489c-9a3b-90c0cdb35ec9@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd905ad0-6413-489c-9a3b-90c0cdb35ec9@moroto.mountain>

On 01/08, Dan Carpenter wrote:
> There is a copy and paste error so it accidentally returns ->convst_gpio
> instead of ->reset_gpio.  Fix it.
> 
> Fixes: 0b76ff46c463 ("iio: adc: Add support for AD7091R-8")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Oops, that also slipped through.
Thanks for the fix.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

>  drivers/iio/adc/ad7091r8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7091r8.c b/drivers/iio/adc/ad7091r8.c
> index 57700f124803..700564305057 100644
> --- a/drivers/iio/adc/ad7091r8.c
> +++ b/drivers/iio/adc/ad7091r8.c
> @@ -195,7 +195,7 @@ static int ad7091r8_gpio_setup(struct ad7091r_state *st)
>  	st->reset_gpio = devm_gpiod_get_optional(st->dev, "reset",
>  						 GPIOD_OUT_HIGH);
>  	if (IS_ERR(st->reset_gpio))
> -		return dev_err_probe(st->dev, PTR_ERR(st->convst_gpio),
> +		return dev_err_probe(st->dev, PTR_ERR(st->reset_gpio),
>  				     "Error on requesting reset GPIO\n");
>  
>  	if (st->reset_gpio) {
> -- 
> 2.42.0
> 
> 

