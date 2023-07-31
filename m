Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7CD769081
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjGaIlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjGaIkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:40:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C128719A8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:39:01 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso48816185e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690792738; x=1691397538;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8iu5cp8Y1GY0uNruSlKQJ5tGFR1JHk9Mos4NpUwA/wg=;
        b=yZuwdwFmisXPSEluH2zX2tYetrzxIzHXt9nfphWuS3Rf5Lu8PgHpR7Qs8WYXv3VWFr
         szsvlIuBbmmG26gM7Ig8uuqXbYTresYPNFI6yPhCcQ+Y3igG/69JB0BZvn5DTWAd6ZEl
         PHzI/u0UNIJcHWOh9VAWUZHJAdzKhql0+6yEPoPqdG3OZh7zu0+qZliBxy/xdyPpgj6a
         NviyD9nIPsiYeY5C7rJRYzw/L6tFxcbyl3QvZbTVBqDIud09m89s3KY7FZ357dlwJc/d
         8LNMNMiQQ+RS1qb+ebVDqhabrperJaDIDJgkhGfSOSQ6LwDE7GD7uKjpZN23CG8trwqL
         caGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690792738; x=1691397538;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8iu5cp8Y1GY0uNruSlKQJ5tGFR1JHk9Mos4NpUwA/wg=;
        b=WKadIhgBIz9VHzFrTFsbQsH4e6lBZ7q2r7zlBu8R+2t3FEYSgjODSXf4ptl4e8tGI7
         hpGtdR6tDvHrq4L3TndouVWPhkf9w5ZJNmO1S011iahDBHDrw5tFRFrL2Lvy2ifiGL9y
         YLPBQcHea7suBzZPqoTOd0vFEVAwrdhNwXWvLqrWGg1+V11WIf6vF0q3USW5bZXCPULh
         HeXybnZv9aRpsQqtnAPGsg9w7bKwKf4yBruIevnmAwqeXshs33YsvCeKoXBz/ZPIv9Sx
         +0hPCm4DOixRyL47Y4Dppkpvs9PKn9MWKqjCNoPeRyGlkd7PLqn5woQpE1saF13kWS8J
         giOQ==
X-Gm-Message-State: ABy/qLbJ4f8ERWqc3n225pA+lyRLQH9wWqm+gkGY1qDJ9a3C2YHj1LAJ
        o4QReBQqI8qOglafYM/LupYNrQ==
X-Google-Smtp-Source: APBJJlGe9+f3abgBiBGI/g3dK5e3z6k6mz+gPWGjUfyhIP1sP/oWUqrsh6ruhgXBgfkMGwgCW1OLrw==
X-Received: by 2002:a1c:f70c:0:b0:3fc:80a:cf63 with SMTP id v12-20020a1cf70c000000b003fc080acf63mr7980848wmh.38.1690792737906;
        Mon, 31 Jul 2023 01:38:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d? ([2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003fe1cb874afsm3963566wmi.18.2023.07.31.01.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:38:57 -0700 (PDT)
Message-ID: <aee8b25a-217d-a63c-d2b9-3b7a9c4cd248@linaro.org>
Date:   Mon, 31 Jul 2023 10:38:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] usb: typec: nb7vpq904m: Add an error handling path in
 nb7vpq904m_probe()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <9118954765821ea9f1179883602b4eca63e91749.1689716381.git.christophe.jaillet@wanadoo.fr>
Organization: Linaro Developer Services
In-Reply-To: <9118954765821ea9f1179883602b4eca63e91749.1689716381.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 23:40, Christophe JAILLET wrote:
> In case of error in the nb7vpq904m_probe() probe function, some resources
> need to be freed, as already done in the remove function.
> 
> Add the missing error handling path and adjust code accordingly.
> 
> Fixes: 88d8f3ac9c67 ("usb: typec: add support for the nb7vpq904m Type-C Linear Redriver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This changes the order with some devm_ allocated resources. I hope this is
> fine. At least it is consistent with the remove function.
> ---
>   drivers/usb/typec/mux/nb7vpq904m.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
> index 80e580d50129..4d1122d95013 100644
> --- a/drivers/usb/typec/mux/nb7vpq904m.c
> +++ b/drivers/usb/typec/mux/nb7vpq904m.c
> @@ -463,16 +463,18 @@ static int nb7vpq904m_probe(struct i2c_client *client)
>   
>   	ret = nb7vpq904m_register_bridge(nb7);
>   	if (ret)
> -		return ret;
> +		goto err_disable_gpio;
>   
>   	sw_desc.drvdata = nb7;
>   	sw_desc.fwnode = dev->fwnode;
>   	sw_desc.set = nb7vpq904m_sw_set;
>   
>   	nb7->sw = typec_switch_register(dev, &sw_desc);
> -	if (IS_ERR(nb7->sw))
> -		return dev_err_probe(dev, PTR_ERR(nb7->sw),
> -				     "Error registering typec switch\n");
> +	if (IS_ERR(nb7->sw)) {
> +		ret = dev_err_probe(dev, PTR_ERR(nb7->sw),
> +				    "Error registering typec switch\n");
> +		goto err_disable_gpio;
> +	}
>   
>   	retimer_desc.drvdata = nb7;
>   	retimer_desc.fwnode = dev->fwnode;
> @@ -480,12 +482,21 @@ static int nb7vpq904m_probe(struct i2c_client *client)
>   
>   	nb7->retimer = typec_retimer_register(dev, &retimer_desc);
>   	if (IS_ERR(nb7->retimer)) {
> -		typec_switch_unregister(nb7->sw);
> -		return dev_err_probe(dev, PTR_ERR(nb7->retimer),
> -				     "Error registering typec retimer\n");
> +		ret = dev_err_probe(dev, PTR_ERR(nb7->retimer),
> +				    "Error registering typec retimer\n");
> +		goto err_switch_unregister;
>   	}
>   
>   	return 0;
> +
> +err_switch_unregister:
> +	typec_switch_unregister(nb7->sw);
> +
> +err_disable_gpio:
> +	gpiod_set_value(nb7->enable_gpio, 0);
> +	regulator_disable(nb7->vcc_supply);
> +
> +	return ret;
>   }
>   
>   static void nb7vpq904m_remove(struct i2c_client *client)


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
