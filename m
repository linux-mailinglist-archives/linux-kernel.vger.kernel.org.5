Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8803D7AF92B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjI0EUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjI0ETM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:19:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3713C00;
        Tue, 26 Sep 2023 18:32:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c61bde0b4bso46946025ad.3;
        Tue, 26 Sep 2023 18:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695778340; x=1696383140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hP+g2Zhox+Th+oVPcl2goCX8vInD7cvVYSsX0s/QkpE=;
        b=Emoy4TuHKxJUmeFm14CrKuP4VC2roWtmNmIIEn6Wz5LLjHp6bGvaMILURLj64ptdEK
         hXsRAVkYkPEARguujKvZvu9Ro9V9coU6gmbw8fnUB7DERGuoDU6aR6qND6qGaTamT+H8
         FwD0D1oZMT9+B/Z1hz9Wy5/Xvmk0aFPJvzOZ4yrbiFZ+jA+VSzWNZv/FnuuRHRn6LjlY
         TkKwjNAtlUq48kn8hCz5Q29YCiwcz0Svq4xSbvDx3i8Yy6x+2yXYv6FyX3Bde4B0mkVP
         CVsaVHsDjmvHCtn6o9y3lGacWSIO0hXZG+A5JwvUZXBoghmdyraALaQNE7KUJDrytw9i
         9mNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695778340; x=1696383140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP+g2Zhox+Th+oVPcl2goCX8vInD7cvVYSsX0s/QkpE=;
        b=jDNje+G5N16WqGw0Dn4lv/tpGsJOKHMB1rymxHvkOv+3ItIbjVhVao/VfMRsHp9j/3
         odtbGiYF9oFJN/nLzLl99ams8LZefdIilCus8i315hjIqtSroyLwwESikUK9QypKskup
         b7NM6I1hMSO0cNsG3JgPSzFrGCpbOzdqO/+UgRaBSsWxFzzJr4TnNb/jAuwBLCa14nND
         +kWMhH4CcMWP7RM2yhj8wajD1niXP8JGEBKFgBx1NJiDxu/uKT1PDQViAMhRNFZnOseF
         3rpqVnQgeFvcN27YFlclw12XR9K+/QxUX/rpNNvoihza+fklp5Zn9fae5/aKLEgD9HiR
         1UVg==
X-Gm-Message-State: AOJu0YwZOa/QAlr4Qk/eagWb5oXQBcVAYiYlw8oq4WjD95fQV7YSdZ7R
        nXeuS5XGjH7LIf5FxUuPc3o=
X-Google-Smtp-Source: AGHT+IGPiO2n9poA5FBFxwbSW7wzdgA+aBNcevYeCBgsoPmyd4ftTzGq/klGeCdciA9mUzGWIBP/GQ==
X-Received: by 2002:a17:90a:6046:b0:25c:8b5e:814 with SMTP id h6-20020a17090a604600b0025c8b5e0814mr377145pjm.44.1695778339932;
        Tue, 26 Sep 2023 18:32:19 -0700 (PDT)
Received: from sol (60-242-83-31.tpgi.com.au. [60.242.83.31])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a004e00b0025dc5749b4csm13516723pjb.21.2023.09.26.18.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 18:32:19 -0700 (PDT)
Date:   Wed, 27 Sep 2023 09:32:11 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Yury Norov <yury.norov@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 5/5] gpiolib: cdev: Utilize more bitmap APIs
Message-ID: <ZROGG44v5kfktdVs@sol>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926052007.3917389-6-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 08:20:07AM +0300, Andy Shevchenko wrote:
> Currently we have a few bitmap calls that are open coded in the library
> module. Let's convert them to use generic bitmap APIs instead.
> 

Firstly, I didn't consider using the bitmap module here as, in my mind at
least, that is intended for bitmaps wider than 64 bits, or with variable
width. In this case the bitmap is fixed at 64 bits, so bitops seemed more
appropriate.

And I would argue that they aren't "open coded" - they are parallelized
to reduce the number of passes over the bitmap.
This change serialises them, e.g. the get used to require 2 passes over
the bitmap, it now requires 3 or 4.  The set used to require 1 and now
requires 2.
And there are additional copies that the original doesn't require.
So your change looks less efficient to me - unless there is direct
hardware support for bitmap ops??

Wrt the argument that the serialized form is clearer and more
maintainable, optimised code is frequently more cryptic - as noted in
bitmap.c itself, and this code has remained unchanged since it was merged
3 years ago, so the only maintenance it has required is to be more
maintainable??  Ok then.

Your patch is functionally equivalent and pass my uAPI tests, so 

Tested-by: Kent Gibson <warthog618@gmail.com>

but my preference is to leave it as is.

Cheers,
Kent.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 79 +++++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index e39d344feb28..a5bbbd44531f 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -1263,35 +1263,32 @@ static long linereq_get_values(struct linereq *lr, void __user *ip)
>  {
>  	struct gpio_v2_line_values lv;
>  	DECLARE_BITMAP(vals, GPIO_V2_LINES_MAX);
> +	DECLARE_BITMAP(mask, GPIO_V2_LINES_MAX);
> +	DECLARE_BITMAP(bits, GPIO_V2_LINES_MAX);
>  	struct gpio_desc **descs;
>  	unsigned int i, didx, num_get;
> -	bool val;
>  	int ret;
>  
>  	/* NOTE: It's ok to read values of output lines. */
>  	if (copy_from_user(&lv, ip, sizeof(lv)))
>  		return -EFAULT;
>  
> -	for (num_get = 0, i = 0; i < lr->num_lines; i++) {
> -		if (lv.mask & BIT_ULL(i)) {
> -			num_get++;
> -			descs = &lr->lines[i].desc;
> -		}
> -	}
> +	bitmap_from_arr64(mask, &lv.mask, GPIO_V2_LINES_MAX);
>  
> +	num_get = bitmap_weight(mask, lr->num_lines);
>  	if (num_get == 0)
>  		return -EINVAL;
>  
> -	if (num_get != 1) {
> +	if (num_get == 1) {
> +		descs = &lr->lines[find_first_bit(mask, lr->num_lines)].desc;
> +	} else {
>  		descs = kmalloc_array(num_get, sizeof(*descs), GFP_KERNEL);
>  		if (!descs)
>  			return -ENOMEM;
> -		for (didx = 0, i = 0; i < lr->num_lines; i++) {
> -			if (lv.mask & BIT_ULL(i)) {
> -				descs[didx] = lr->lines[i].desc;
> -				didx++;
> -			}
> -		}
> +
> +		didx = 0;
> +		for_each_set_bit(i, mask, lr->num_lines)
> +			descs[didx++] = lr->lines[i].desc;
>  	}
>  	ret = gpiod_get_array_value_complex(false, true, num_get,
>  					    descs, NULL, vals);
> @@ -1301,19 +1298,15 @@ static long linereq_get_values(struct linereq *lr, void __user *ip)
>  	if (ret)
>  		return ret;
>  
> -	lv.bits = 0;
> -	for (didx = 0, i = 0; i < lr->num_lines; i++) {
> -		if (lv.mask & BIT_ULL(i)) {
> -			if (lr->lines[i].sw_debounced)
> -				val = debounced_value(&lr->lines[i]);
> -			else
> -				val = test_bit(didx, vals);
> -			if (val)
> -				lv.bits |= BIT_ULL(i);
> -			didx++;
> -		}
> +	bitmap_scatter(bits, vals, mask, lr->num_lines);
> +
> +	for_each_set_bit(i, mask, lr->num_lines) {
> +		if (lr->lines[i].sw_debounced)
> +			__assign_bit(i, bits, debounced_value(&lr->lines[i]));
>  	}
>  
> +	bitmap_to_arr64(&lv.bits, bits, GPIO_V2_LINES_MAX);
> +
>  	if (copy_to_user(ip, &lv, sizeof(lv)))
>  		return -EFAULT;
>  
> @@ -1324,35 +1317,35 @@ static long linereq_set_values_unlocked(struct linereq *lr,
>  					struct gpio_v2_line_values *lv)
>  {
>  	DECLARE_BITMAP(vals, GPIO_V2_LINES_MAX);
> +	DECLARE_BITMAP(mask, GPIO_V2_LINES_MAX);
> +	DECLARE_BITMAP(bits, GPIO_V2_LINES_MAX);
>  	struct gpio_desc **descs;
>  	unsigned int i, didx, num_set;
>  	int ret;
>  
> -	bitmap_zero(vals, GPIO_V2_LINES_MAX);
> -	for (num_set = 0, i = 0; i < lr->num_lines; i++) {
> -		if (lv->mask & BIT_ULL(i)) {
> -			if (!test_bit(FLAG_IS_OUT, &lr->lines[i].desc->flags))
> -				return -EPERM;
> -			if (lv->bits & BIT_ULL(i))
> -				__set_bit(num_set, vals);
> -			num_set++;
> -			descs = &lr->lines[i].desc;
> -		}
> -	}
> +	bitmap_from_arr64(mask, &lv->mask, GPIO_V2_LINES_MAX);
> +	bitmap_from_arr64(bits, &lv->bits, GPIO_V2_LINES_MAX);
> +
> +	num_set = bitmap_gather(vals, bits, mask, lr->num_lines);
>  	if (num_set == 0)
>  		return -EINVAL;
>  
> -	if (num_set != 1) {
> +	for_each_set_bit(i, mask, lr->num_lines) {
> +		if (!test_bit(FLAG_IS_OUT, &lr->lines[i].desc->flags))
> +			return -EPERM;
> +	}
> +
> +	if (num_set == 1) {
> +		descs = &lr->lines[find_first_bit(mask, lr->num_lines)].desc;
> +	} else {
>  		/* build compacted desc array and values */
>  		descs = kmalloc_array(num_set, sizeof(*descs), GFP_KERNEL);
>  		if (!descs)
>  			return -ENOMEM;
> -		for (didx = 0, i = 0; i < lr->num_lines; i++) {
> -			if (lv->mask & BIT_ULL(i)) {
> -				descs[didx] = lr->lines[i].desc;
> -				didx++;
> -			}
> -		}
> +
> +		didx = 0;
> +		for_each_set_bit(i, mask, lr->num_lines)
> +			descs[didx++] = lr->lines[i].desc;
>  	}
>  	ret = gpiod_set_array_value_complex(false, true, num_set,
>  					    descs, NULL, vals);
> -- 
> 2.40.0.1.gaa8946217a0b
> 
