Return-Path: <linux-kernel+bounces-120434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFEE88D74D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185531F2854B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FC628DD7;
	Wed, 27 Mar 2024 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1vTzW8g"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AD320B04;
	Wed, 27 Mar 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711524754; cv=none; b=YSG057sl7wg7cnDjwLRQThEJ9GJMBDxJyh9pQExGI4gvLkk7qJOvrBUfwndRRWAQpxMhkpa1AYky4smT0I6qVL5jSDN9tx8CXXYiIieuLTd0sOpoMccgi15VTIN4cH7GBthugB74Y7ibeaaKxHcZ3oO/hgJtocL1T+6i/Xtnny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711524754; c=relaxed/simple;
	bh=B2HbK7MBRjE3MxW4U9q16RiT6GjG/1CrmnHFnGfsX/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tt7Ddv20uI6bGZHCyi6KjicNfwfo8nK+2IhxpKJPVke2EZ0FOZVz0IzqhIJ8hk49xFVr5csc8JZ885HQuPxnzT3Tq6Fr9EHCcsD3p+Dc6jy0o0kr+gsmErGYRtSOMEHoDLc2PZX/Tp6s5fqUn7nVUYKT+0boGVQboGfZGqYbyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1vTzW8g; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d687da75c4so72945991fa.0;
        Wed, 27 Mar 2024 00:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711524750; x=1712129550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WlODq7VgSFSX4CYSAEoYMDw8I+Cf+/lcILMy975jiw8=;
        b=I1vTzW8gTeQsBsuMqFVh57pexhB/ZnB7UGPDEwxGgpAOsHfsODQ8aq7RL4pZyX55Vk
         UC0oTa6HQn22/wWJgDyQPP7qS62SjNqv/h2HfP/mktQVJxxv3y6EPMgB9hYWPki1GFf7
         Wb2gvLuKzGvsl2oHYDJfhP3mz1Y7BQzacn0BD5muITo6C0wNI+yjx9B3RxIrotymiIWf
         GbN+vuEeNDsHWP3wDBpUKpOkCYixFFQPyR888PQNYbQ8VjHWXx8mYHRNM0rkW7IfkHyR
         mVr1WNz+KkKE+lIFkBH8emBYH6iGOIto/cFnYUiVRn74FaKEb28vEeuVioBTspGRYkod
         5ziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711524750; x=1712129550;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlODq7VgSFSX4CYSAEoYMDw8I+Cf+/lcILMy975jiw8=;
        b=mQc9nAujFmNcP6uYcFpkNYkUiaeAPAN+anA4nKPAEQiepSH0vqBzuAGj6H2KybDMaQ
         eS/W+LhcHcR3jVaH5JPkj1xnm3IvwASzo++gT+xSKfOF2IB4bkEim+8u1mj5JrR0GTy4
         coook2U6/fyi6nBCHO4sLh7u66hXCFjIZSieDElm6xKDVZVSOxXt3geOLskmJPSz8Cyj
         4oQyEeaGabOlU+4x4/vtjtufGc8pxe2KftczqQgTH92Ljex/NNU8hnN7qQG7hx5hDEZI
         2ffjgeU/9kfCmTc5koym9bz6ThykKQC37KJy71FRiYRsDwzW5VBib6/+jynsXP+KfuCZ
         jheg==
X-Forwarded-Encrypted: i=1; AJvYcCV0YrG/wDhPn6grg1Hras9nLdp+Xpx0v+M0ndCDQdNVIoeW80PcLFxL13CB9Fk2PwcXFb0VP95gbBV0dZ9XG//vLq50fO8rq1zjyGiGeOiBXUxwmxbpSAxk+VD0oooPpt0+9P1M0JGcAQ==
X-Gm-Message-State: AOJu0Ywb5KzQa8EGBRwzIFLq6k33/9FYGwa3vHEE4AqmhtyjC7UjJN2Q
	R9mpbphLKaK0fYWMQHImiWAFcPDIX5rWwdgvjGdW8I9vyQsp++agH5MxM/y/
X-Google-Smtp-Source: AGHT+IF8UJKU2iwWjJX5c3frm0F8YX4f24o+529I3jwh7J8Q3vCjzS2a1mci3aCONwKyLn8jZSKfEA==
X-Received: by 2002:a2e:a1c7:0:b0:2d6:c189:5dbd with SMTP id c7-20020a2ea1c7000000b002d6c1895dbdmr2155352ljm.31.1711524750102;
        Wed, 27 Mar 2024 00:32:30 -0700 (PDT)
Received: from ?IPV6:2001:14ba:7426:df00::6? (drtxq0yyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:7426:df00::6])
        by smtp.gmail.com with ESMTPSA id t4-20020a2e9c44000000b002d59af21dd8sm1990425ljj.58.2024.03.27.00.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 00:32:29 -0700 (PDT)
Message-ID: <815e1cdc-145e-4880-96a0-d9c21308b9b3@gmail.com>
Date: Wed, 27 Mar 2024 09:32:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mfd: rohm-bd71828: Add power off functionality
Content-Language: en-US, en-GB
To: Andreas Kemnade <andreas@kemnade.info>, lee@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326192258.298143-1-andreas@kemnade.info>
 <20240326192258.298143-3-andreas@kemnade.info>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240326192258.298143-3-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/24 21:22, Andreas Kemnade wrote:
> Since the chip can power off the system, add the corresponding
> functionality.
> Based on https://github.com/kobolabs/Kobo-Reader/raw/master/hw/imx6sll-clara2e/kernel.tar.bz2
> No information source about the magic numbers found.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/mfd/rohm-bd71828.c | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
> index 594718f7e8e1..8fd994664bbf 100644
> --- a/drivers/mfd/rohm-bd71828.c
> +++ b/drivers/mfd/rohm-bd71828.c
> @@ -464,6 +464,21 @@ static int set_clk_mode(struct device *dev, struct regmap *regmap,
>   				  OUT32K_MODE_CMOS);
>   }
>   
> +static struct i2c_client *bd71828_dev;
> +static void bd71828_power_off(void)
> +{
> +	while (true) {
> +		/* We are not allowed to sleep, so do not use regmap involving mutexes here. */
> +		i2c_smbus_write_byte_data(bd71828_dev, BD71828_REG_PS_CTRL_1, 0x02);

We need a read-modify-write here. All this should do is setting the 
bit[1] - which is 'state transition to HBNT_MODE'. The register has some 
other controls as well - like transitions to other low-power states 
(bit[0] = SHIP_MODE, bit[2] = LPSR_MODE and bit[3] = IDLE_MODE). These 
aren't a problem though because transition to the HBNT has the highest 
priority.

(It may be that someone somewhere would like to use some other low-power 
mode as the power-off target, but if this is needed then we can probably 
add another DT-property to tell which low-power mode the hardware is 
built to work with. In any case, implementing the HBNT is far better 
than not implementing power-off at all).

What might cause a problem is that the high bits control how the 
voltages of the output rails are controlled. (The PMIC has different 
options on this - and changing the control may change the voltages when 
PMIC is on RUN state. The write to bit[1] should start transition to 
HBNT, but I'm not 100% sure if voltage changes may take some effect 
before state transition is done, or if these settings may be carried 
over to next boot.) Better to not risk anything and leave the rest of 
the bits unchanged. Also, now that the magic value 0x02 is explained - 
we could use BD71828_MASK_STATE_HBNT BIT(1) - instead of a magic number ;)

I should've noticed this when I looked at the v1. Sorry for that :/

> +		mdelay(500);
> +	}
> +}
> +
> +static void bd71828_remove_poweroff(void *data)
> +{
> +	pm_power_off = NULL;
> +}
> +
>   static int bd71828_i2c_probe(struct i2c_client *i2c)
>   {
>   	struct regmap_irq_chip_data *irq_data;
> @@ -542,7 +557,20 @@ static int bd71828_i2c_probe(struct i2c_client *i2c)
>   	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, mfd, cells,
>   				   NULL, 0, regmap_irq_get_domain(irq_data));
>   	if (ret)
> -		dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
> +		return	dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
> +
> +	if (of_device_is_system_power_controller(i2c->dev.of_node) &&
> +	    chip_type == ROHM_CHIP_TYPE_BD71828) {

It's worth noting that there is another PMIC, BD71879, which, from the 
driver software point of view, should be (almost?) identical to the 
BD71828. I believe the BD71828 drivers should work with it as well - if 
not out of the box, at least with very minor modifications. 
Unfortunately I don't know products where the BD71879 is used or if it 
is sold via distributors - so I don't know if adding a DT 
compatible/chip type define for it would be beneficial. If someone is 
looking for information about the BD71879 and finds this mail - feel 
free to ping me :] (I expect no action from you here Andreas, just 
mentioned it for the record).

> +		if (!pm_power_off) {
> +			bd71828_dev = i2c;
> +			pm_power_off = bd71828_power_off;
> +			ret = devm_add_action_or_reset(&i2c->dev,
> +						       bd71828_remove_poweroff,
> +						       NULL);
> +		} else {
> +			dev_warn(&i2c->dev, "Poweroff callback already assigned\n");
> +		}
> +	}
>   
>   	return ret;
>   }


Just out of the curiosity... How on earth did you end up looking at this 
PMIC or kobo reader code? Do you work with a product using this PMIC, or 
do you just have the reader? No matter what the case is, I think this is 
really cool and seeing people using/improving these drivers warms my 
"open source heart" :) Almost feeling like my work has a purpose XD.

Anyways, if you add a define and change the write to rmw, and if Lee is 
ok with MFD driver hosting the power-off handler...

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


