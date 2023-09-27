Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37A17AF870
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjI0DHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjI0DFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:05:01 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50BA1F15;
        Tue, 26 Sep 2023 17:46:09 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-493a661d7b6so7255141e0c.1;
        Tue, 26 Sep 2023 17:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695775569; x=1696380369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HGaAz2NGUFdNbG0DXs3PklSqzmoBdhiDuIki8POO1ik=;
        b=BFzewfOo/M5ven7KsW0HCwrj0h7Q8EFnSNlYJSNHLHaq1py4ZD0WhQ65JsgolBBi/y
         0kjrM1UOIslwdQx0Y3aBetOHaC895xN4BwV0Zq8hIAOqfMFFX/YUQ7D+8JzMOe5/T2Ue
         +ibpqYCDdQHfliGK7kP3Hen5yMAMrPxZbhQcUhOYqmlYuiXh7FD7bBCwx6mlm4QzzWpR
         kwvguqQZSpOud8O/xrWsUf3qaMtWPs+qoD7uIJhwhJtwWzq9kEAuVPqaI+jFMZVkaHzh
         G+Kb4MfvoQ/IVsZVsXDRuNpknbedDTSKWmqpGTe6baG8WAJHPLznKcf6wUV0tHhhNo41
         q/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695775569; x=1696380369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGaAz2NGUFdNbG0DXs3PklSqzmoBdhiDuIki8POO1ik=;
        b=eqC5KFc5+Z95/oK4tnsaZ8riuNDndu0U7dglrtZ2488YRUO76FdcwOOBiy9DPaV5jT
         C0jkGt3Oe1NwNB0V9NGVC1PIAVRi2HPVjYXEeffP2EtkG89niMAC0IhpPUDrmHlPaqu0
         ANfuNkxfWAGHD88NRYDMowDtjYD6gSE5kKbYe/iVAKZHhAcX1NVGFGDV7dkKZz94rPd6
         GNW1dJ0AIm3bJ0+WC41KamBa+ovDIstmPmjgsh1dftVRAK5C0OO5fo9NK4hheWCLpe8a
         vNYwQjyuYCllCopA0qFQmWG2pF3+4Tqo+7u1gmS0Gv5SQpFnfRVP4aWq1I60KP2O4+cE
         hhjw==
X-Gm-Message-State: AOJu0YxMo3SGlfk13N87zLtR9Uk5Nn3ky0FEL36iNqOLkes+XWXxD9FR
        6Z69kmXR3fgx3JqXrZqEjZU=
X-Google-Smtp-Source: AGHT+IFBvdJTSeQQkUFB331UVlztzI9EhJYGCrQ9pKM8x8/SSRO3ME3CjPGO44EizXbaPnBD8sbz3g==
X-Received: by 2002:a1f:db44:0:b0:48e:1463:914e with SMTP id s65-20020a1fdb44000000b0048e1463914emr275544vkg.7.1695775568826;
        Tue, 26 Sep 2023 17:46:08 -0700 (PDT)
Received: from localhost ([2607:fb90:be31:4195:3f3f:56b1:2bbb:65e2])
        by smtp.gmail.com with ESMTPSA id 4-20020a0561220b4400b00495ce48c8adsm2174997vko.16.2023.09.26.17.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 17:46:08 -0700 (PDT)
Date:   Tue, 26 Sep 2023 17:46:07 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 5/5] gpiolib: cdev: Utilize more bitmap APIs
Message-ID: <ZRN7FRWvZnmpDD/v@yury-ThinkPad>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926052007.3917389-6-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 08:20:07AM +0300, Andy Shevchenko wrote:
> Currently we have a few bitmap calls that are open coded in the library
> module. Let's convert them to use generic bitmap APIs instead.
> 
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

It looks like GPIO_V2_LINES_MAX is always 64, and so I wonder: is
my understanding correct that all bits in ->mask and ->bits beyond
lr->num_lines are clear?

If so, you can seemingly pass the GPIO_V2_LINES_MAX instead of
lr->num_lines, and that way it will be small_cons_nbits()-optimized.

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
