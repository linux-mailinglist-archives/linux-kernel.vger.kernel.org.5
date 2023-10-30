Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CCA7DBD02
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjJ3P5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjJ3P5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:57:10 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA0D9;
        Mon, 30 Oct 2023 08:57:08 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7d9d357faso43532207b3.0;
        Mon, 30 Oct 2023 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698681427; x=1699286227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KqEcy/FTVRmCJO3mUkkOypdWB4g67w6pVbljP7u/u5I=;
        b=h8trYql0ZxP6HdfYh7yhVwyHwLZ3prtBQYJD7w/7qiDC8RQ7uFn+gcRdvvFxKBy1BQ
         ZrdgiWLgvhr3vPKahrbUgrdenMoIqArVk/VJJjOeNS+xE/JZ7fObCCjeRYu1Rfvo+jYF
         ByPGL44eGWPTswlTTGK3pSE587PIipHrMrsTPXxCHo8lVO4Bb2OTxETEsB74tIHP0oHj
         HHU1RCdUMSuhPQoFnF98V5ZCmwjdIuL/WcNslkfRzQmUu70KsIeAEmqr/DENVL5pqkPb
         p55wedwO7Efd6H9YL9joFucAz6DvmOjbWy0awPQRWGU6NCPwdEeB70Cwzzy67lpi0Xmd
         Fx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698681427; x=1699286227;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqEcy/FTVRmCJO3mUkkOypdWB4g67w6pVbljP7u/u5I=;
        b=waeHTeNHlmORMGumUT7ice9VR7dDRy0NmBbNhb08DSVjHTCsv6qYpBpFolnhi7VDeM
         vNjRMhYpKsY6+Lr/CncI9lNl67OAXOFvqZobttoGQg2eLofAToNbCevrBWG46Ca7WXSU
         OEDTRC1jEbZFbshzBaRBBJXWx0bYACp8cW8AjZz0GEm9W4B9Jks2ELy9V7xde1DtaqZb
         Rw++if6Bztz/qZlssTgpdfrh1whf+EbAmKJtFKTxB9+Kr+X/qLRymI1KF+mthlroulJc
         e8YvKQONd42ACPezWNXrf483LuLFB+WAwwpxn0rJYkU2g3c8P6HjCW/tH9NxmAuWKOZq
         4/Hw==
X-Gm-Message-State: AOJu0Yz1Vh8Lk/+2dnISxD9jI/LGsJoYjai/mBj0QqNHLuRJC+bjstzr
        7xM2B2c3AR6dT7gW4jHFxkcIKuMhHgA=
X-Google-Smtp-Source: AGHT+IE18mGvNltF9lPxIh0N14wvvI4rgbcA8hodrL95HNfCOEiENG8Zx5cNXYPF5TplfgOoHdtVtA==
X-Received: by 2002:a81:5756:0:b0:5a7:a817:be43 with SMTP id l83-20020a815756000000b005a7a817be43mr10483325ywb.6.1698681427282;
        Mon, 30 Oct 2023 08:57:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c190-20020a814ec7000000b005a7bbd713ddsm4423113ywb.108.2023.10.30.08.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 08:57:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e3de2c1f-3a05-4ffc-a50e-0b5522cf7740@roeck-us.net>
Date:   Mon, 30 Oct 2023 08:57:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] hwmon: npcm750-pwm-fan: Add NPCM8xx support
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, jdelvare@suse.com,
        avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        andrew@codeconstruct.com.au, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, j.neuschaefer@gmx.net
Cc:     openbmc@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231030150119.342791-1-tmaimon77@gmail.com>
 <20231030150119.342791-2-tmaimon77@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231030150119.342791-2-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/23 08:01, Tomer Maimon wrote:
> Adding Pulse Width Modulation (PWM) and fan tacho NPCM8xx support to
> NPCM PWM and fan tacho driver.
> NPCM8xx uses a different number of PWM devices.
> 
> As part of adding NPCM8XX support:
> - Add NPCM8xx specific compatible string.
> - Add data to handle architecture-specific PWM and fan tacho parameters.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>   drivers/hwmon/npcm750-pwm-fan.c | 34 +++++++++++++++++++++++++++++----
>   1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
> index 10ed3f4335d4..765b08fa0396 100644
> --- a/drivers/hwmon/npcm750-pwm-fan.c
> +++ b/drivers/hwmon/npcm750-pwm-fan.c
> @@ -46,9 +46,9 @@
>   #define NPCM7XX_PWM_CTRL_CH3_EN_BIT		BIT(16)
>   
>   /* Define the maximum PWM channel number */
> -#define NPCM7XX_PWM_MAX_CHN_NUM			8
> +#define NPCM7XX_PWM_MAX_CHN_NUM			12
>   #define NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE	4
> -#define NPCM7XX_PWM_MAX_MODULES                 2
> +#define NPCM7XX_PWM_MAX_MODULES                 3
>   
>   /* Define the Counter Register, value = 100 for match 100% */
>   #define NPCM7XX_PWM_COUNTER_DEFAULT_NUM		255
> @@ -171,6 +171,10 @@
>   #define FAN_PREPARE_TO_GET_FIRST_CAPTURE	0x01
>   #define FAN_ENOUGH_SAMPLE			0x02
>   
> +struct npcm_hwmon_info {
> +	u32 pwm_max_channel;
> +};
> +
>   struct npcm7xx_fan_dev {
>   	u8 fan_st_flg;
>   	u8 fan_pls_per_rev;
> @@ -204,6 +208,7 @@ struct npcm7xx_pwm_fan_data {
>   	struct timer_list fan_timer;
>   	struct npcm7xx_fan_dev fan_dev[NPCM7XX_FAN_MAX_CHN_NUM];
>   	struct npcm7xx_cooling_device *cdev[NPCM7XX_PWM_MAX_CHN_NUM];
> +	const struct npcm_hwmon_info *info;
>   	u8 fan_select;
>   };
>   
> @@ -619,9 +624,13 @@ static umode_t npcm7xx_is_visible(const void *data,
>   				  enum hwmon_sensor_types type,
>   				  u32 attr, int channel)
>   {
> +	const struct npcm7xx_pwm_fan_data *hwmon_data = data;
> +
>   	switch (type) {
>   	case hwmon_pwm:
> -		return npcm7xx_pwm_is_visible(data, attr, channel);
> +		if (channel < hwmon_data->info->pwm_max_channel)
> +			return npcm7xx_pwm_is_visible(data, attr, channel);

I would have expected this check to be handled in npcm7xx_pwm_is_visible().

Guenter

