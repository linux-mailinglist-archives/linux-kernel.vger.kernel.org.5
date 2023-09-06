Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7BB794155
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjIFQUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239866AbjIFQUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:20:36 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06B51997;
        Wed,  6 Sep 2023 09:20:31 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34baf19955cso14533065ab.2;
        Wed, 06 Sep 2023 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694017231; x=1694622031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TMz79hxFJ9olxIr9jfYLcoGR3OAZ7+P2iKJ9lBzWAYI=;
        b=nVxklLs1lC4Zzfo/xa+vODXywjPbDc+ENZTtyzcLSzzLKCFSNxenUnPcXsUhONLgLU
         jBAWdgc+25OICuMs0mybCpVNHWNB2lTwA9UX2jMUEec8yiVghNzDTe8qm7JO3pB1qlLu
         +XwyDOnFiec8xKIk44U4JrrnK3kiWEMuH3o2B8553QQqj8iRyOfzVEUKhtBufGsK2TvQ
         S4HhaBcV6SN8y2Iz7vrH/5wMoGf4qbILAAH50CjzbOhJwcOowdsYDZvD1H/qNEmlW6lm
         uBUkyrbWLspyi13tKsWh0B14L87GqJfKfwrasCjOi9Zw7KS+SW6dLAuuksM4YEcWZO8K
         jCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694017231; x=1694622031;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMz79hxFJ9olxIr9jfYLcoGR3OAZ7+P2iKJ9lBzWAYI=;
        b=MF346SLVPqGaeaGLzyKit6/8+CnXgmPgiwlkFzBPh0eSuBMkLKSc2li4FBCwoWFVhK
         MwFJIMW5hs8u3hWSN+L0eHxQ84aLxnYb9opfokiM/Z1j1SL0xMUZYTp1i5FJyT7F3row
         O1W2kSgsviRzp3qRtM2DmNF2K56oVlTH9P0h1LYK5AcYhWqDivIU99N7NVXNhMIq0OLz
         93Z/Sl1jzsX4GvG450XSLeLDqMVvQM7MJGnX/3rl8KT6745le61LrIYj6B0LY4auz7q1
         uhEGxR2FT1hckAgi2N8Wv0kcYdVOx2UWV7tCZoNHvQFxFOLFuxwc0ebo8eR9AeBE9aO6
         9TpA==
X-Gm-Message-State: AOJu0Yz+/SbXRhKXnhh52H5wZuAHfRukaDdjsvyX2ysaSxuSI9W9y+Ld
        iNBrbo0qcMVAaGrAKnd9aAk=
X-Google-Smtp-Source: AGHT+IF753sF+R0bbfveiAP2bNpfdgjIXEKSJ2XFC4nSpweh/kXqzw1120AgkU4jF8VutN6VBXIwSw==
X-Received: by 2002:a92:c74f:0:b0:34f:2484:64ce with SMTP id y15-20020a92c74f000000b0034f248464cemr5501106ilp.23.1694017231189;
        Wed, 06 Sep 2023 09:20:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k27-20020a634b5b000000b00573db18bca2sm3478128pgl.33.2023.09.06.09.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 09:20:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8a3b41a2-0ab2-6213-04a1-54ab7263c647@roeck-us.net>
Date:   Wed, 6 Sep 2023 09:20:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230906084837.3043030-1-Delphine_CC_Chiu@wiwynn.com>
 <20230906084837.3043030-3-Delphine_CC_Chiu@wiwynn.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: max31790: support to config PWM as TACH
In-Reply-To: <20230906084837.3043030-3-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 01:48, Delphine CC Chiu wrote:
> The PWM outputs of max31790 could be used as tachometer inputs by
> setting the fan configuration register, but the driver doesn't support
> to config the PWM outputs as tachometer inputs currently.
> 
> Add a function to get properties of the setting of max31790 to config
> PWM outputs as tachometer inputs before initializing max31790.
> For example: set `pwm-as-tach = /bits/ 8 <2 5>` in DTS for max31790 and
> the driver will config PWMOUT2 and PWMOUT5 as TACH8 and TACH11.
> 

Devicetree properties have to be documented in a property file
and have to be approved by a devicetree maintainer.

Personally I don't think this is the proper way of configuring this,
but I'll let devicetree maintainers decide.

> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>   drivers/hwmon/max31790.c | 50 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
> index 0cd44c1e998a..0f8fe911539b 100644
> --- a/drivers/hwmon/max31790.c
> +++ b/drivers/hwmon/max31790.c
> @@ -480,6 +480,52 @@ static const struct hwmon_chip_info max31790_chip_info = {
>   	.info = max31790_info,
>   };
>   
> +static int max31790_config_pwm_as_tach(struct device *dev,
> +				       struct i2c_client *client)
> +{
> +	struct device_node *np = dev->of_node;
> +	int i, ret = 0, size, channel;
> +	u8 pwm_index[NR_CHANNEL] = { 0 };
> +	u8 fan_config;
> +
> +	size = of_property_count_u8_elems(np, "pwm-as-tach");
> +
> +	if ((size > 0) && (size <= NR_CHANNEL)) {

Please refrain from unnecessary ( ).

> +		ret = of_property_read_u8_array(np, "pwm-as-tach", pwm_index,
> +						size);
> +		if (ret) {
> +			dev_err(dev,
> +				"Property 'pwm-as-tach' cannot be read.\n");
> +			return ret;
> +		}
> +
> +		for (i = 0; i < size; i++) {
> +			if ((pwm_index[i] == 0) ||
> +			    (pwm_index[i] > NR_CHANNEL)) {
> +				continue;
> +			}

Silently accepting bad data seems like a bad idea to me.

> +
> +			channel = pwm_index[i] - 1;
> +			fan_config = i2c_smbus_read_byte_data(
> +				client, MAX31790_REG_FAN_CONFIG(channel));
> +			if (fan_config < 0) {

An u8 is never < 0

> +				dev_err(dev,
> +					"Read fan config for channel %d failed.\n",
> +					channel);
> +				return fan_config;
> +			}
> +
> +			fan_config |= (MAX31790_FAN_CFG_CTRL_MON |
> +				       MAX31790_FAN_CFG_TACH_INPUT);

This assumes that the channel is configured as pwm.
What if the BIOS / ROMMON configured another channel which you want as
pwm channel as fan input channel ?

> +			i2c_smbus_write_byte_data(
> +				client, MAX31790_REG_FAN_CONFIG(channel),
> +				fan_config);
> +		}
> +	}

Silently ignoring errors seems like a bad idea.

> +
> +	return 0;
> +}
> +
>   static int max31790_init_client(struct i2c_client *client,
>   				struct max31790_data *data)
>   {
> @@ -521,6 +567,10 @@ static int max31790_probe(struct i2c_client *client)
>   	data->client = client;
>   	mutex_init(&data->update_lock);
>   
> +	err = max31790_config_pwm_as_tach(dev, client);
> +	if (err)
> +		dev_crit(dev, "Config PWM as TACH failed.\n");
> +
>   	/*
>   	 * Initialize the max31790 chip
>   	 */

