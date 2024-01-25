Return-Path: <linux-kernel+bounces-38593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF10283C2BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9697F1F253A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B94D4E1D8;
	Thu, 25 Jan 2024 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUsoiykh"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1403317586;
	Thu, 25 Jan 2024 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706186861; cv=none; b=FPq9ZfvVZ6VrK4+uPIvS6LbeF8c2X3XVtncvaTP7r75mnE4+aYm3AedgTIGPKV+Fuv+joWN0EPEI43zoL8q5khADD0ogur18HRewnxsH/cQrZrQzTRwKpQ4mhACAv3WHYiDQqODwiUWdj09rHpke8FGKvq2c13C9TkaFg6Bp77s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706186861; c=relaxed/simple;
	bh=KYDQQfPF6jtGb7HP13zF8usqEXWcBW0MxpqY1aHRz3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+2cdEJlemmwcUezFHH4xBq9WfeCEJh7DhuEflXdHNqCb5sVEyyHts3R1QT6wr9JvONmL/GFpa5gni3wYcVHGERlfj3zXmlj6ZFId/rahchltBRLWrIhctaUYGRRu5hVC/5CwHGtdnlNCeDz2mdTP9RWrEBl+eB5jWynhSez9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUsoiykh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d7431e702dso33894205ad.1;
        Thu, 25 Jan 2024 04:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706186859; x=1706791659; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C6HC37m+nA0yiS1FVPf530RnIwpAPTws2KsbIuN9ZdQ=;
        b=PUsoiykhGDmUJZRsKHzYLFugPPhvVDU7df0cMXREF8NKf2ct6aKPu13mzq391btKNu
         R6BqxSamqKaRtBOPQ2cgwrfRZEg/LtG2nagnXu20F25UWB/holQNvMjZiUXX+yJUEd9P
         f9QkRdPjUJxZGixgoLZfkNl0sPeVr26ec3YQitv+vx7YwjnELl3qUjMYG+ZAMnj/kcdO
         IhOmWYHOiwME2Gfu5vQ16XF9J72c7UUpyjcWqtWUS7Iy+SWlLXvbSH/Fip0cFXMDVqn4
         g4t6FIteCX1avrT4QtsMXWfAqK/ObjEdoJ9kxjCbmAPye67yoC9PzoTTrJL4ZmR63NYe
         ABoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706186859; x=1706791659;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6HC37m+nA0yiS1FVPf530RnIwpAPTws2KsbIuN9ZdQ=;
        b=XvFYNpStKTi02tKzqGV9Dtf+TEnHwB9wL2f8a7IA/DXHzgF+m9vBb5Z3Ku2PtgwESs
         9c/0axC7qmR1lYc9xMn6fvlq8234aZfRYKHDhGtgbj/m25rZ8BD+T342Mo2p7O21YaRt
         kjT8y176joJJbfAAuTPcaS2HjkVWiD3UCkxwBHYY5UgLdX6dkHFcgDlL8ozwR7++lVKH
         SKF2A149twUA0cfaF8TRU6q7qZxcQe6dYJe9juvtSOhYT4ulvlJKpqIQCNbI91Ix/Nqa
         UF1c1QARg46/WKz/+7MhFRScnOqOpjgt3UaiiBtbtwl3AdokccYZrlFbX9JZbxx7zUZ3
         hIPg==
X-Gm-Message-State: AOJu0Yy1eBBea0yNvHHZFCUVApYbf4OBWGTYdyJNUsn0erw1cxA1kFEK
	cs3Zz/sDWBXS+z9zv6gtEHfp+SlhxUrJs1uQSK6N6w89sit2TFLr
X-Google-Smtp-Source: AGHT+IHr4RP3jVmirHf6cmxoGTRvzKHCJ2UWquKoZZKyufKiGqFimwDqtVvIdGXwI4LK3debjwd9kg==
X-Received: by 2002:a17:902:bd0a:b0:1d7:3223:e9dd with SMTP id p10-20020a170902bd0a00b001d73223e9ddmr504401pls.102.1706186859159;
        Thu, 25 Jan 2024 04:47:39 -0800 (PST)
Received: from rigel ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id ay4-20020a1709028b8400b001d71f037ffdsm10066235plb.214.2024.01.25.04.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 04:47:38 -0800 (PST)
Date: Thu, 25 Jan 2024 20:47:34 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	=?iso-8859-1?Q?Jos=E9?= Guilherme de Castro Rodrigues <joseguilhermebh@hotmail.com>
Subject: Re: [PATCH v2] gpio: improve the API contract for setting direction
Message-ID: <20240125124734.GB99216@rigel>
References: <20240125083507.25213-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240125083507.25213-1-brgl@bgdev.pl>

On Thu, Jan 25, 2024 at 09:35:07AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> If a GPIO driver returns a positive integer from one of the direction
> setter callbacks, we'll end up propagating it to user-space. Whether we
> should sanitize the values returned by callbacks is a different question
> but let's first improve the documentation and fortify the contract with
> GPIO providers.
>
> Reported-by: José Guilherme de Castro Rodrigues <joseguilhermebh@hotmail.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Kent Gibson <warthog618@gmail.com>

> ---
> v1 -> v2:
> - add a mention of 0 being return on success
>
>  include/linux/gpio/driver.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 9a5c6c76e653..90cd57796b36 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -335,10 +335,12 @@ struct gpio_irq_chip {
>   *	(same as GPIO_LINE_DIRECTION_OUT / GPIO_LINE_DIRECTION_IN),
>   *	or negative error. It is recommended to always implement this
>   *	function, even on input-only or output-only gpio chips.
> - * @direction_input: configures signal "offset" as input, or returns error
> - *	This can be omitted on input-only or output-only gpio chips.
> - * @direction_output: configures signal "offset" as output, or returns error
> - *	This can be omitted on input-only or output-only gpio chips.
> + * @direction_input: configures signal "offset" as input, returns 0 on success
> + *	or a negative error number. This can be omitted on input-only or
> + *	output-only gpio chips.
> + * @direction_output: configures signal "offset" as output, returns 0 on
> + *	success or a negative error number. This can be omitted on input-only
> + *	or output-only gpio chips.
>   * @get: returns value for signal "offset", 0=low, 1=high, or negative error
>   * @get_multiple: reads values for multiple signals defined by "mask" and
>   *	stores them in "bits", returns 0 on success or negative error
> --
> 2.40.1
>

