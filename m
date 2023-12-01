Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A70800E28
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379390AbjLAPLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379377AbjLAPK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:10:58 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1028D1734;
        Fri,  1 Dec 2023 07:10:57 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a195e0145acso188044766b.2;
        Fri, 01 Dec 2023 07:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701443455; x=1702048255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DaM9RASwKYMsF2RkG0zP3ipZyconGd1Ye0p9jQM07EM=;
        b=RRkTxIrr0xzBRKtHXghGRgOJGqzMhtUG4F1LUdmTiC6mAz2NqUntAnq41fh7E7gIGn
         yyDeQ4HmhvuKS86BtSueQ6C2YSfDQ6gsWwmjpiJGzNCvH70zfEsYFOVy1ILJ+sj1sd5K
         VuzreWki1AMxZOS4PyH3vkCRN+oErvPneXhqgsxOhQdf7kDuzzJ+3Tnj9uNCkyBbui0R
         X2uAeui77bAAYiWdMEkJsYAMcxZRRPryFtYGWePcLGisJFqLGqiDLpgaeN7OP27ca8aQ
         yUZyWZMyrkhE3fI88zmmXBawT1nJ1ztSNdJH6cuw2eBHYboBJ368ZlAU8K2eZTwbYvZg
         WMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443455; x=1702048255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DaM9RASwKYMsF2RkG0zP3ipZyconGd1Ye0p9jQM07EM=;
        b=VzSfuDjA3GizyDWxgpaiHdNqNDEwt2V5QNwClZnLyiXhMSnnfXv4CeE5fSQUWex4ov
         lTg6kPB9C7i67bANUJjV1EcBYzVcmN4GbepNKFFXRCakF8urLJlYOCcbOcbwTHMCSVvZ
         mkfakAzlmYN16gy8C9kkKwsqkJ9C+czPy4A4bGMH2ju4mAxHq/DwqwIoqwE2ur07wt2J
         K9QQQb1gwt2j+LHzQsQaj3mwkubNRzy6XxS1G7afH3hGQZTPAocBZlblIsftKrbjjQ/n
         bMEniRz6nKLNFeLv4RVMmugJjLx0m6NAYcClZDPY1P9QN/wR8XtDHn4ePee5QBUFec4C
         gwkg==
X-Gm-Message-State: AOJu0YzGW83vPNp5nOVYnggg+cze9275UknpEh2nBw3Fqn/vd5h9adZo
        +z6Ve9xI9n5bRZOaHRzs7MY=
X-Google-Smtp-Source: AGHT+IFQEGOI3+ormciAyeWHdSH8rkMITKUwFkc5tT/OFoFB3zPnCAZBWjjY6vfqiSpKSNzvTxsk9Q==
X-Received: by 2002:a17:906:f2c4:b0:a04:7e8a:dc2f with SMTP id gz4-20020a170906f2c400b00a047e8adc2fmr571379ejb.70.1701443455232;
        Fri, 01 Dec 2023 07:10:55 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id m6-20020a170906580600b00a101edb159csm2042332ejq.18.2023.12.01.07.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 07:10:54 -0800 (PST)
Message-ID: <b0288a8f-d16c-4db6-a4f9-32050531feb0@gmail.com>
Date:   Fri, 1 Dec 2023 16:10:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] leds: trigger: netdev: add 2500 link speed mode
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231201150247.4556-1-ericwouds@gmail.com>
From:   Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <20231201150247.4556-1-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Never mind, thanks, I see just a few days ago this is already send in.

On 12/1/23 16:02, Eric Woudstra wrote:
> This will be useful for PHY leds where the PHY supports 2500Mbps.
> 
>  Changes to be committed:
> 	modified:   drivers/leds/trigger/ledtrig-netdev.c
> 	modified:   include/linux/leds.h
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  drivers/leds/trigger/ledtrig-netdev.c | 12 +++++++++++-
>  include/linux/leds.h                  |  1 +
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
> index e358e77e4b38..66dfd327ee5b 100644
> --- a/drivers/leds/trigger/ledtrig-netdev.c
> +++ b/drivers/leds/trigger/ledtrig-netdev.c
> @@ -99,6 +99,10 @@ static void set_baseline_state(struct led_netdev_data *trigger_data)
>  		    trigger_data->link_speed == SPEED_1000)
>  			blink_on = true;
>  
> +		if (test_bit(TRIGGER_NETDEV_LINK_2500, &trigger_data->mode) &&
> +		    trigger_data->link_speed == SPEED_2500)
> +			blink_on = true;
> +
>  		if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &trigger_data->mode) &&
>  		    trigger_data->duplex == DUPLEX_HALF)
>  			blink_on = true;
> @@ -286,6 +290,7 @@ static ssize_t netdev_led_attr_show(struct device *dev, char *buf,
>  	case TRIGGER_NETDEV_LINK_10:
>  	case TRIGGER_NETDEV_LINK_100:
>  	case TRIGGER_NETDEV_LINK_1000:
> +	case TRIGGER_NETDEV_LINK_2500:
>  	case TRIGGER_NETDEV_HALF_DUPLEX:
>  	case TRIGGER_NETDEV_FULL_DUPLEX:
>  	case TRIGGER_NETDEV_TX:
> @@ -316,6 +321,7 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
>  	case TRIGGER_NETDEV_LINK_10:
>  	case TRIGGER_NETDEV_LINK_100:
>  	case TRIGGER_NETDEV_LINK_1000:
> +	case TRIGGER_NETDEV_LINK_2500:
>  	case TRIGGER_NETDEV_HALF_DUPLEX:
>  	case TRIGGER_NETDEV_FULL_DUPLEX:
>  	case TRIGGER_NETDEV_TX:
> @@ -334,7 +340,8 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
>  	if (test_bit(TRIGGER_NETDEV_LINK, &mode) &&
>  	    (test_bit(TRIGGER_NETDEV_LINK_10, &mode) ||
>  	     test_bit(TRIGGER_NETDEV_LINK_100, &mode) ||
> -	     test_bit(TRIGGER_NETDEV_LINK_1000, &mode)))
> +	     test_bit(TRIGGER_NETDEV_LINK_1000, &mode) ||
> +	     test_bit(TRIGGER_NETDEV_LINK_2500, &mode)))
>  		return -EINVAL;
>  
>  	cancel_delayed_work_sync(&trigger_data->work);
> @@ -364,6 +371,7 @@ DEFINE_NETDEV_TRIGGER(link, TRIGGER_NETDEV_LINK);
>  DEFINE_NETDEV_TRIGGER(link_10, TRIGGER_NETDEV_LINK_10);
>  DEFINE_NETDEV_TRIGGER(link_100, TRIGGER_NETDEV_LINK_100);
>  DEFINE_NETDEV_TRIGGER(link_1000, TRIGGER_NETDEV_LINK_1000);
> +DEFINE_NETDEV_TRIGGER(link_2500, TRIGGER_NETDEV_LINK_2500);
>  DEFINE_NETDEV_TRIGGER(half_duplex, TRIGGER_NETDEV_HALF_DUPLEX);
>  DEFINE_NETDEV_TRIGGER(full_duplex, TRIGGER_NETDEV_FULL_DUPLEX);
>  DEFINE_NETDEV_TRIGGER(tx, TRIGGER_NETDEV_TX);
> @@ -422,6 +430,7 @@ static struct attribute *netdev_trig_attrs[] = {
>  	&dev_attr_link_10.attr,
>  	&dev_attr_link_100.attr,
>  	&dev_attr_link_1000.attr,
> +	&dev_attr_link_2500.attr,
>  	&dev_attr_full_duplex.attr,
>  	&dev_attr_half_duplex.attr,
>  	&dev_attr_rx.attr,
> @@ -519,6 +528,7 @@ static void netdev_trig_work(struct work_struct *work)
>  			 test_bit(TRIGGER_NETDEV_LINK_10, &trigger_data->mode) ||
>  			 test_bit(TRIGGER_NETDEV_LINK_100, &trigger_data->mode) ||
>  			 test_bit(TRIGGER_NETDEV_LINK_1000, &trigger_data->mode) ||
> +			 test_bit(TRIGGER_NETDEV_LINK_2500, &trigger_data->mode) ||
>  			 test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &trigger_data->mode) ||
>  			 test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &trigger_data->mode);
>  		interval = jiffies_to_msecs(
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index aa16dc2a8230..c2ae68df50e2 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -588,6 +588,7 @@ enum led_trigger_netdev_modes {
>  	TRIGGER_NETDEV_LINK_10,
>  	TRIGGER_NETDEV_LINK_100,
>  	TRIGGER_NETDEV_LINK_1000,
> +	TRIGGER_NETDEV_LINK_2500,
>  	TRIGGER_NETDEV_HALF_DUPLEX,
>  	TRIGGER_NETDEV_FULL_DUPLEX,
>  	TRIGGER_NETDEV_TX,
