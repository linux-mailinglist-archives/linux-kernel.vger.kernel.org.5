Return-Path: <linux-kernel+bounces-129443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E87896AE7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB05AB283EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4A3134759;
	Wed,  3 Apr 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnCkfYt/"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841696EB73;
	Wed,  3 Apr 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137333; cv=none; b=DDLSJBviuJxlvRyOMF2H3EALepJKnigTFVZAjW5/lqbiMTw3+Tbjsnbeo/JbkABQO4ubfoU12FXcjSsNuDlfjFri5XxdfCzGOF9UVnGQAXLhLI3RJox83vTx4JseT+zcL3twGgNMrqiun3AEuz0zL3LuYTd09kWFj085Isteoz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137333; c=relaxed/simple;
	bh=+ej/TWizrI+era82uq7nCvFBl8kRFoOo2CvsTpNzVDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VA4p8+lwHhBOSCLPDkCMUf8AFi0KQTYxBp5t9HGNKDiYSVWiraU6Cfli4NyLHH2iTGmj21zYW4p9kGI+JNfnQzdUD3hAFmPdeXdbJ0rgSpKWhMFiHb9HpOjWmafHSFSMs8v8kdEVnUm2obPi01+Blx+KZH2yJyB7gaE2j7+Xs+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnCkfYt/; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so4698703a12.1;
        Wed, 03 Apr 2024 02:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712137332; x=1712742132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7bU382ztyspHGb0aCvHLVuPZy5Tv25ydMKByJLrVwNE=;
        b=HnCkfYt/yWdxFNjR31alY6fCzVMEjEyGcKqbUZ2a2GloxUtelcZ1HihxocK6M35hX+
         p95yiFhkIwcloXbY78u9xqDoUWDKCnBqrbptUPKgR1mYKrdZjTa/t7IkvEjIMOZf+WjQ
         g1a0i2hGiXrVNAbmITF/wtfVP9LlXFq72LKwcH9o9wAMSl9M/cgujxrZv7/qELiwtb7E
         OBmDNcHuHnJ18kP1nzp9WUx4SZErdg9XmdW+cJKCBuuK5dkbG8rBEdXFLZP4aJxLs1hF
         CJD0F+AxnXWBbxH7AQ2mBmeHgBtJ0eR4PgF5iWloCLi+VB/0/DuCQLkvI4Kkr1d9fM7O
         Nt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712137332; x=1712742132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bU382ztyspHGb0aCvHLVuPZy5Tv25ydMKByJLrVwNE=;
        b=ZqeYrhNdHdPcOmxbt8tu/sdUIoeLxL7IG3aV2h+x/JoiQIaTQZk3Yp5jd3dhQPnKuP
         MyoqXbiMsiS4lHsuX9N2XSW7ReXp1DsPhJpHGnIoqybhBjyYAazL1NcTZdCjXVnAdnjU
         T5MGbfxxs5Ax05kJJJEY7u/zU+oV3znMA2UHKhXCr1fw/HhKMjsi/lMnj6kW71JnGIIf
         oi0cz3BD8cFlBuPWequq8FMX6rg1ZWQAc6jaJ2yXzf3rBmSZhhFR3RG5qp4SWdQkSkC/
         TLoMrV70w4pm2g5OH+DmeCfi3mqy0p/ZM5JID1GeZbQcn7PoSB8mtc7ydpRW+PzndMVJ
         MSTw==
X-Forwarded-Encrypted: i=1; AJvYcCUVvpxjEU4lobwDh4MG4wI+OQRrivRIvDaIe4qr8KYi6IimUHgIEg+SNA6rzxmuRv5SdghG78ZfNBDKOLYwHK5c6rCsg8V46Vs3jOoi97D/2sJYtwM8Ooi3sYP8yHXtrWPZn2AnfzcleN/W5/p54+/wLnX3CIeWPLSX/Pidxf99EQ==
X-Gm-Message-State: AOJu0YyGMX4R1UpimGFm3IB8wjdO8vcjzV7cEipCKvzvZVabxvsCSvvH
	iK27l0MyzbJQQZmAY7e1X+FGsZa8AtTNY366TWFSpiwet+LyHJJr
X-Google-Smtp-Source: AGHT+IHpJ0K/xMKP4U0Tu9R6gv2om8QoE6M+2UXMzFJ1UrVKKlOnJnxE/pVxvp9DUAR/JwjArMHNTA==
X-Received: by 2002:a05:6a20:d498:b0:1a7:1695:2c19 with SMTP id im24-20020a056a20d49800b001a716952c19mr8355503pzb.33.1712137331716;
        Wed, 03 Apr 2024 02:42:11 -0700 (PDT)
Received: from rigel (194-223-186-215.tpgi.com.au. [194.223.186.215])
        by smtp.gmail.com with ESMTPSA id v65-20020a626144000000b006e6854d45afsm12072926pfb.97.2024.04.03.02.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 02:42:11 -0700 (PDT)
Date: Wed, 3 Apr 2024 17:42:05 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
	stable@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] gpio: cdev: check for NULL labels when sanitizing them
 for irqs
Message-ID: <20240403094205.GA158151@rigel>
References: <20240402114159.32920-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402114159.32920-1-brgl@bgdev.pl>

On Tue, Apr 02, 2024 at 01:41:59PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We need to take into account that a line's consumer label may be NULL
> and not try to kstrdup() it in that case but rather pass the NULL
> pointer up the stack to the interrupt request function.
>
> To that end: let make_irq_label() return NULL as a valid return value
> and use ERR_PTR() instead to signal an allocation failure to callers.
>
> Cc: stable@vger.kernel.org
> Fixes: b34490879baa ("gpio: cdev: sanitize the label before requesting the interrupt")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/lkml/20240402093534.212283-1-naresh.kamboju@linaro.org/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib-cdev.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index fa9635610251..1426cc1c4a28 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -1085,7 +1085,16 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
>
>  static inline char *make_irq_label(const char *orig)
>  {
> -	return kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
> +	char *new;
> +
> +	if (!orig)
> +		return NULL;
> +
> +	new = kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
> +	if (!new)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return new;
>  }
>
>  static inline void free_irq_label(const char *label)
> @@ -1158,8 +1167,8 @@ static int edge_detector_setup(struct line *line,
>  	irqflags |= IRQF_ONESHOT;
>
>  	label = make_irq_label(line->req->label);
> -	if (!label)
> -		return -ENOMEM;
> +	if (IS_ERR(label))
> +		return PTR_ERR(label);
>
>  	/* Request a thread to read the events */
>  	ret = request_threaded_irq(irq, edge_irq_handler, edge_irq_thread,
> @@ -2217,8 +2226,8 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
>  		goto out_free_le;
>
>  	label = make_irq_label(le->label);
> -	if (!label) {
> -		ret = -ENOMEM;
> +	if (IS_ERR(label)) {
> +		ret = PTR_ERR(label);
>  		goto out_free_le;
>  	}
>

It occurred to me that none of my tests cover this case, as they always
request edges with the consumer set, so I added some and can confirm both
the problem and the fix.

In the process I found another bug - we overlooked setting up the irq
label in debounce_setup() - the alternate path in edge_detector_setup()
that performs sw debounce.  That results in a double free of the
req->label and memory corruption hilarity follows.

I've got a patch for that - the unfortunate part being that
debounce_setup() is earlier in the file than make_irq_label() and
free_irq_label().  Those will need to be pushed earlier, so it is
sure to conflict with this patch.
How would you prefer to proceed?

Cheers,
Kent.


