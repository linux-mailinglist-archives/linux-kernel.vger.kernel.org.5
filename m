Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A061877B5CE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjHNJym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjHNJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:54:33 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5FACC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:54:32 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9cd6a554cso60237211fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692006870; x=1692611670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28r2pJeGKF+Nj7tQ8NZm8iRX5hOV9+jRJrS/4OwhvYw=;
        b=zLsZ8OEuubBKzckY2Tk8QPmxwikTiY9w+efEHShcrN3DUdnBR3pD2FZWKbCy3O2OJa
         vRtTPzKXPBWrIrEb1bsa8c5Ty8O7Ad2DyWjbmHemvw6PdJrbkD31LOj/b4xAYOXF2z7f
         dhQOxHE5YfGkX5kn5osL20Pr0bJkA2zYlF5x/KRAO+Pw0H+yl7KTYDcfM3UVE+H2LEJW
         J1Pt4t8g2XJFuclFEmHJZvLda7lAyNbbjH5c6qNIR23Dz869bEPVb9EZcmxvoCQZOsR4
         mkqY/bJe67ddEwonaTOaMOV9OyZEVC9ADGNk76mXsTJV+aZr65SX5c7ZtL7MPGZxJgef
         2HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692006870; x=1692611670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28r2pJeGKF+Nj7tQ8NZm8iRX5hOV9+jRJrS/4OwhvYw=;
        b=FKMgm52widAEFZrO5LrylFclvJVWV9bE+6R5/49DcLfWAOSBgKt3jIjSRkEUzAXik/
         qmHPmF3WS8DStq+XiV4PgBnQKxmbJX37/4FviWUy+PYM0BXRMK73f/lxkQErf2TBDL9n
         PrESdEgGus8NJQYZl/kCJVuHW+Hj3WJTgR4lseQ7fCmBxRGvrJt2e6iRWhRI+JB5DKoL
         qjtIXPpPOByWXdajYOxlpB7kr22RbjyZIM7cznPNEPIJUr4drgfwWLL9eEKYIzDktopR
         cm/P/935Mbp8dqnTBvsaROTBWxbdKtan3eARxOsCahZy98qoskYfInR5trUWvgBQzsey
         7jrg==
X-Gm-Message-State: AOJu0YxpPiULgbCRqDC28YlBnVd3qS8OZQTUT99KldDwPCw8HzIBfM0y
        WAqVrpqrg8GCSO6TLCawoIQC5w==
X-Google-Smtp-Source: AGHT+IGREUQUkqbDDursHPSY7fT/NJCyzfd1fnr8TTbZukLXMUYAhwvAdEeWnvJ9Uqk7ZlEUTHzOlw==
X-Received: by 2002:a05:651c:110:b0:2b6:ecdd:16cf with SMTP id a16-20020a05651c011000b002b6ecdd16cfmr5661023ljb.40.1692006870309;
        Mon, 14 Aug 2023 02:54:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003fe15ac0934sm11449006wmo.1.2023.08.14.02.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 02:54:29 -0700 (PDT)
Message-ID: <40a88b27-9095-96f2-44df-0ac0cd1c6e3a@linaro.org>
Date:   Mon, 14 Aug 2023 11:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 04/15] hwmon: (ina2xx) fix Wvoid-pointer-to-enum-cast
 warning
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Andi Shyti <andi.shyti@kernel.org>
References: <20230810093157.94244-1-krzysztof.kozlowski@linaro.org>
 <20230810093157.94244-4-krzysztof.kozlowski@linaro.org>
 <e13c70334dce4bfa9e5ea11126d4eb86@AcuMS.aculab.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e13c70334dce4bfa9e5ea11126d4eb86@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 10:33, David Laight wrote:
> From: Krzysztof Kozlowski
>> Sent: 10 August 2023 10:32
>>
>> 'chip' is an enum, thus cast of pointer on 64-bit compile test with W=1
>> causes:
>>
>>   ina2xx.c:627:10: error: cast to smaller integer type 'enum ina2xx_ids' from 'const void *' [-
>> Werror,-Wvoid-pointer-to-enum-cast]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/hwmon/ina2xx.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
>> index a47973e2d606..d8415d1f21fc 100644
>> --- a/drivers/hwmon/ina2xx.c
>> +++ b/drivers/hwmon/ina2xx.c
>> @@ -624,7 +624,7 @@ static int ina2xx_probe(struct i2c_client *client)
>>  enum ina2xx_ids chip;
>>
>>  if (client->dev.of_node)
>> -chip = (enum ina2xx_ids)of_device_get_match_data(&client->dev);
>> +chip = (uintptr_t)of_device_get_match_data(&client->dev);
> 
> The kernel type would be 'long' not uintptr_t.

Yeah, Greg also pointed out. It was applied, so no sure if it is worth
to change to kernel_ulong_t.

> But this all looks like something horrid is being done.

Why exactly? This is pretty often pattern, code is correct and easy to
understand.

> 
> (And you've clearly lost all the tabs)

It's your email client who lost them:
https://lore.kernel.org/all/20230810093157.94244-4-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

