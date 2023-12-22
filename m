Return-Path: <linux-kernel+bounces-9228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9028C81C299
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30750B23674
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07B5EB8;
	Fri, 22 Dec 2023 01:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYYkGRtE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DDBA23;
	Fri, 22 Dec 2023 01:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d411636a95so1831119b3a.0;
        Thu, 21 Dec 2023 17:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703207563; x=1703812363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8XuQK3WEeqQ95hCzJILUp+ds678rIHjNbCC/oCpzKbY=;
        b=kYYkGRtEZjCRSqQf+I9fNnQYSkN7o62A9I0mE61xukErmv7iAT8CbnUYPZWo6EEZ6m
         CpbK6V2+uEZSnHRaDMdoURth/OkXnq9wjvb3sGlZ2hMI2JsfMTBFRO64pL36gCPrP9FW
         2Omtpubj8f/KMLQ1fwNJrJep3waJFCBhPb07UKXVTndfRW+Vep+vZvSUEChdWZ8+uSnF
         uxn+ST9jPnN6sMPOCtHpV8M54iMaldvas0PppDhlK3L9XU8KvpV+K7vsx1o/LDJrxFH3
         5QMBBmXFtOoo3WYdvtYKZH/FQFeNw1AvPYUklk5t3l6K25TpKYCkTzcYv2Y258jfa5aj
         699Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703207563; x=1703812363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XuQK3WEeqQ95hCzJILUp+ds678rIHjNbCC/oCpzKbY=;
        b=w66G/Mn5uA41MhrkuzsXZEVMyqRWiAIj9kbhpGEoVkfppoEzUc2xraF7izWDOdztA8
         0r1c11VaDcJrLb81QPk40Nk3tDutUEygzaM965ZeoVOq/r8PXivNtJ1RnFN7zHuTWMcI
         oh2M9veYD3oiXd+z0rKL8fJOJbtAPbWA0vPxQ0X/OWZIWgiCGhcR0lZykWpypvltFOYn
         I3GMnN5OZv/Qg1hcBzW7XeXR6HY/GAuIqyvQ0R1UYd9a9uRjIFj2ICsMmyIsPAdg2jGm
         z1oWqh6BlI2AW1Qtm+RSBkyrWtlpCK0SOydw2/6d8Q4HoDvgfkTegCFDGokBVDmW6I0H
         Eo7A==
X-Gm-Message-State: AOJu0Yx4FJjLyvuFvho02nib+2zvdP1No5EUSWLERqV0WXNCZY92TfKl
	24k9ZEA439rfeRtEd2GTrEE=
X-Google-Smtp-Source: AGHT+IEIlzwmnSH/AdSLn8H/xRhFOT9tz98PD3p9EDbhfBSETlZlNuQ6l8LHqcrytQoIhh/i1bVYDA==
X-Received: by 2002:a05:6a20:a105:b0:195:12d8:a95c with SMTP id q5-20020a056a20a10500b0019512d8a95cmr819564pzk.41.1703207562888;
        Thu, 21 Dec 2023 17:12:42 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id f22-20020aa78b16000000b006d0d90edd2csm2222149pfd.42.2023.12.21.17.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 17:12:42 -0800 (PST)
Date: Fri, 22 Dec 2023 09:12:37 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Split line_get_debounce_period()
 and use
Message-ID: <ZYTihbWMcHMHSkC_@rigel>
References: <20231221175527.2814506-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221175527.2814506-1-andriy.shevchenko@linux.intel.com>

On Thu, Dec 21, 2023 at 07:55:27PM +0200, Andy Shevchenko wrote:
> Instead of repeating the same code and reduce possible miss
> of READ_ONCE(), split line_get_debounce_period() heler out
> and use in the existing cases.
>

helper


Not a fan of this change.

So using READ_ONCE() is repeating code??
Doesn't providing a wrapper around READ_ONCE() just rename that repitition?
What of all the other uses of READ_ONCE() in cdev (and there are a lot) -
why pick on debounce_period?

The line_set_debounce_period() is necessary as the set is now a
multi-step process as it can impact whether the line is contained
in the supinfo_tree.  The get is just a get.

And you could've included me in the Cc so I didn't just find it by
accident.

Cheers,
Kent.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 744734405912..c573820d5722 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -651,6 +651,16 @@ static struct line *supinfo_find(struct gpio_desc *desc)
>  	return NULL;
>  }
>
> +static unsigned int line_get_debounce_period(struct line *line)
> +{
> +	return READ_ONCE(line->debounce_period_us);
> +}
> +
> +static inline bool line_has_supinfo(struct line *line)
> +{
> +	return line_get_debounce_period(line);
> +}
> +
>  static void supinfo_to_lineinfo(struct gpio_desc *desc,
>  				struct gpio_v2_line_info *info)
>  {
> @@ -665,15 +675,10 @@ static void supinfo_to_lineinfo(struct gpio_desc *desc,
>
>  	attr = &info->attrs[info->num_attrs];
>  	attr->id = GPIO_V2_LINE_ATTR_ID_DEBOUNCE;
> -	attr->debounce_period_us = READ_ONCE(line->debounce_period_us);
> +	attr->debounce_period_us = line_get_debounce_period(line);
>  	info->num_attrs++;
>  }
>
> -static inline bool line_has_supinfo(struct line *line)
> -{
> -	return READ_ONCE(line->debounce_period_us);
> -}
> -
>  /*
>   * Checks line_has_supinfo() before and after the change to avoid unnecessary
>   * supinfo_tree access.
> @@ -846,7 +851,7 @@ static enum hte_return process_hw_ts(struct hte_ts_data *ts, void *p)
>  		line->total_discard_seq++;
>  		line->last_seqno = ts->seq;
>  		mod_delayed_work(system_wq, &line->work,
> -		  usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
> +				 usecs_to_jiffies(line_get_debounce_period(line)));
>  	} else {
>  		if (unlikely(ts->seq < line->line_seqno))
>  			return HTE_CB_HANDLED;
> @@ -987,7 +992,7 @@ static irqreturn_t debounce_irq_handler(int irq, void *p)
>  	struct line *line = p;
>
>  	mod_delayed_work(system_wq, &line->work,
> -		usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
> +			 usecs_to_jiffies(line_get_debounce_period(line)));
>
>  	return IRQ_HANDLED;
>  }
> @@ -1215,7 +1220,7 @@ static int edge_detector_update(struct line *line,
>  			gpio_v2_line_config_debounce_period(lc, line_idx);
>
>  	if ((active_edflags == edflags) &&
> -	    (READ_ONCE(line->debounce_period_us) == debounce_period_us))
> +	    (line_get_debounce_period(line) == debounce_period_us))
>  		return 0;
>
>  	/* sw debounced and still will be...*/
> --
> 2.43.0.rc1.1.gbec44491f096
>

