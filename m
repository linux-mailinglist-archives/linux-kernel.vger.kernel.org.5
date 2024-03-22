Return-Path: <linux-kernel+bounces-110858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A187E8864D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183521F2126E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5121A38FE;
	Fri, 22 Mar 2024 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8k7JGDN"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4BB79CC;
	Fri, 22 Mar 2024 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711071043; cv=none; b=FgRvHaUqLOW8PFiYIP7/dtdPXr6yf0LrUz577UQ/PIKh77wXDNh/LvtMWdBzHwt4hurs9MAOycE9yTewXKvFvEGW0BTgQxLOyxFSK1YRHJ4iUmB6VQK+HDNf+hX0Lso0rak8OaAmksMBIHzJGZfXlBPJJR8sGu+m0SItRelVvfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711071043; c=relaxed/simple;
	bh=L4H2OIzcFi/Upeqi8RJMwIMMLktMyEWStGT9y+AnqxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldhUEmGS6xCRPwugu6Ud20T8uE1Lnkn44ViToOr06SaYu+/Y4yTiBCCqUyfJy52Mv/IvfPUmY+P4EemD7EtNRV3EzXhlU78klnHSVw/8IkWbTxyoiwMznbq+iD5AeA4BTJBJGof3HUMQSwGzD51v2YKqAWfjnOiZ0TUPDNdy3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8k7JGDN; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29fbe140c24so1168258a91.0;
        Thu, 21 Mar 2024 18:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711071041; x=1711675841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XzHinso5/JUUGnSlekarpcGaX3E/1CBp5+bzHJh1IoM=;
        b=E8k7JGDNCv+G9NHAO5uJH3Od/qRRk8ysPX/kGoViKnhEM7Mn/GBEbqzkSOdi4ZxIaC
         dlA0S8ZljA3iOLZs1F9pPHVAsZQRh03W1ZjKxUi3T19aO+lKyk2SUuR8AGaYOV9LLYbV
         J5YQ9Z9idg3IBiB7DrwH2gfGTsbuL2N3Sh/xO+Rf/fZvkTEJY4sEySvPFWGtcf4IGXEh
         0gaU19yTz0b//Jx9KNah3ZxtQ1FKAv/elnnK6uSMupf1cyh36vFAGt4VLd1FcXSvPXn4
         RW/g5wZE4Ym/XRWtvlgBfS1LhgHuC87ZrvBil2bNlS5YAPoP/W9fv104Swb1d9/uhr9u
         XkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711071041; x=1711675841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzHinso5/JUUGnSlekarpcGaX3E/1CBp5+bzHJh1IoM=;
        b=xOGFcd6YfLz5zLs7n4DlnIff93waV0XvTMuxJFo5DhQQFbPceBF8brurYC6poQPg3X
         YlpZazJV2dpRfxeFZb87rk5pun18eLI7pXC+/gt9OmfxKm4BK9byUROwHiPb6fKJqFmv
         wkbDK7TgYftGo63LdWfvXJKuri83aFKH6gPl6kwNpiSUqwBzu7zqGqO1L91W1rogvK3y
         UYO90UTfk4gVs3WbZZKMNn7vz+YRLASu3T6fbcK0vhi8OmFbKWOlNYw4jiIW5jO4n6tL
         AW2PBENRyZFjkFFzz5nfrp0dgcYJdJTDzXBkw8XEEM8V+kj5TOjJJvSbZXKZp1Y+4Ehd
         xtBw==
X-Forwarded-Encrypted: i=1; AJvYcCU/R/h/R7g3D3nOYxaa8HoD/6CMrXyFUI8ODU3h0Ue7JuYzg9RuM/mYbtFy6dW1w72482kmJk+UB3jPQhgEbyn/y4C/Y4V5T1b2bK+uiMhEDFBRWAjy4BUXIVVr91ewyTpHPbM8bIKDNJVwOFNbK3/+GiGs7HU98Ov3/W3vC2rOLA==
X-Gm-Message-State: AOJu0YzWoRptpQb860ftJaN7RwLJhXL+UCXjTy0yaA7f0B67XoIxZQ+/
	d7Mh5PQWU8GJGYKACpjKQG8civHr363lC9u7nK1qwboP+L4VsPsr
X-Google-Smtp-Source: AGHT+IH523s7JMx0VTlc7UDTF2uadhc38cgIfTF0Th5iaDs2m1VjYnMjufR/R+w4ZvelWolMQe8UVA==
X-Received: by 2002:a17:90a:4412:b0:29c:7a27:8e39 with SMTP id s18-20020a17090a441200b0029c7a278e39mr948329pjg.33.1711071041314;
        Thu, 21 Mar 2024 18:30:41 -0700 (PDT)
Received: from rigel (110-175-159-48.tpgi.com.au. [110.175.159.48])
        by smtp.gmail.com with ESMTPSA id n31-20020a17090a5aa200b002a02f8d350fsm671308pji.53.2024.03.21.18.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 18:30:40 -0700 (PDT)
Date: Fri, 22 Mar 2024 09:30:34 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH] gpio: cdev: sanitize the label before requesting the
 interrupt
Message-ID: <20240322013034.GA4572@rigel>
References: <20240320125945.16985-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320125945.16985-1-brgl@bgdev.pl>

On Wed, Mar 20, 2024 at 01:59:44PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> When an interrupt is requested, a procfs directory is created under
> "/proc/irq/<irqnum>/<label>" where <label> is the string passed to one of
> the request_irq() variants.
>
> What follows is that the string must not contain the "/" character or
> the procfs mkdir operation will fail. We don't have such constraints for
> GPIO consumer labels which are used verbatim as interrupt labels for
> GPIO irqs. We must therefore sanitize the consumer string before
> requesting the interrupt.
>

As previously mentioned, it would be nice for that constraint to be
documented in the irq header to help prevent others falling into the
same trap.  Else a short comment in the code here to explain the
need for sanitization.

> Let's replace all "/" with "-".
>

I actually prefer the ":" you originally suggested, as it more clearly
indicates a tier separation, whereas a hyphen is commonly used for
multi-word names. And as the hyphen is more commonly used the sanitized
name is more likely to conflict.

> Cc: stable@vger.kernel.org
> Reported-by: Stefan Wahren <wahrenst@gmx.net>
> Closes: https://lore.kernel.org/linux-gpio/39fe95cb-aa83-4b8b-8cab-63947a726754@gmx.net/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib-cdev.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index f384fa278764..8b5e8e92cbb5 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -1083,10 +1083,20 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
>  	return 0;
>  }
>
> +static inline char *make_irq_label(const char *orig)
> +{
> +	return kstrdup_and_replace(orig, '/', '-', GFP_KERNEL);
> +}
> +
> +static inline void free_irq_label(const char *label)
> +{
> +	kfree(label);
> +}
> +
>  static void edge_detector_stop(struct line *line)
>  {
>  	if (line->irq) {
> -		free_irq(line->irq, line);
> +		free_irq_label(free_irq(line->irq, line));
>  		line->irq = 0;
>  	}
>
> @@ -1110,6 +1120,7 @@ static int edge_detector_setup(struct line *line,
>  	unsigned long irqflags = 0;
>  	u64 eflags;
>  	int irq, ret;
> +	char *label;
>
>  	eflags = edflags & GPIO_V2_LINE_EDGE_FLAGS;
>  	if (eflags && !kfifo_initialized(&line->req->events)) {
> @@ -1146,11 +1157,17 @@ static int edge_detector_setup(struct line *line,
>  			IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
>  	irqflags |= IRQF_ONESHOT;
>
> +	label = make_irq_label(line->req->label);
> +	if (!label)
> +		return -ENOMEM;
> +
>  	/* Request a thread to read the events */
>  	ret = request_threaded_irq(irq, edge_irq_handler, edge_irq_thread,
> -				   irqflags, line->req->label, line);
> -	if (ret)
> +				   irqflags, label, line);
> +	if (ret) {
> +		free_irq_label(label);
>  		return ret;
> +	}
>
>  	line->irq = irq;
>  	return 0;
> @@ -1973,7 +1990,7 @@ static void lineevent_free(struct lineevent_state *le)
>  		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
>  						   &le->device_unregistered_nb);
>  	if (le->irq)
> -		free_irq(le->irq, le);
> +		free_irq_label(free_irq(le->irq, le));
>  	if (le->desc)
>  		gpiod_free(le->desc);
>  	kfree(le->label);
> @@ -2114,6 +2131,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
>  	int fd;
>  	int ret;
>  	int irq, irqflags = 0;
> +	char *label;
>
>  	if (copy_from_user(&eventreq, ip, sizeof(eventreq)))
>  		return -EFAULT;
> @@ -2198,12 +2216,16 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
>  	if (ret)
>  		goto out_free_le;
>
> +	label = make_irq_label(le->label);
> +	if (!label)
> +		goto out_free_le;
> +

Need to set ret = -ENOMEM before the goto, else you will return 0.

Cheers,
Kent.

>  	/* Request a thread to read the events */
>  	ret = request_threaded_irq(irq,
>  				   lineevent_irq_handler,
>  				   lineevent_irq_thread,
>  				   irqflags,
> -				   le->label,
> +				   label,
>  				   le);
>  	if (ret)
>  		goto out_free_le;
> --
> 2.40.1
>

