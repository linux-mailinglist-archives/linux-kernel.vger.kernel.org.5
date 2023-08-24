Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B00786FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbjHXMvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241361AbjHXMv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:51:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6742ECD0;
        Thu, 24 Aug 2023 05:51:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ff9abf18f9so10344047e87.2;
        Thu, 24 Aug 2023 05:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692881480; x=1693486280;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxaN86uxdQ2hIjLtCcmkw3T1a4Gg2HerW4j/yXNxBOs=;
        b=QPqpJCibFwuicCtOjT0g5X1VoXn30IZEZVZ/2B9hq6U9JYnNHPSkG7r+p/uCtvfEW9
         iyrv6Z4cCb9pDoWZS/aA5S4wsfQTFcrdsJhjkp/5zM/vkTA05lVNvTLWvqj/auwEVXq+
         WgBRP92gXoyTdZVw/4TXgEVcgzgmsxXkZsg0zDgJxm9Xo2fnnS7o/27ac6rMPhaZ/TV9
         VHzIarpWwzrhwUZWrZlgjel4tT/tPj3I7oRNdQosRKatQe8+wkNPUUKVxxffuUP9NrNF
         CF8i692LVuN9W/L9KtXsyA7r2/3rZ86E8Ckh/6LSgIWAcY01wqoh6C2cwT//qrQ4OZyU
         fh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692881480; x=1693486280;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxaN86uxdQ2hIjLtCcmkw3T1a4Gg2HerW4j/yXNxBOs=;
        b=N7m+YwaIgesn3KGccMSaox53YMPsF7YFmEoscfXLhDqAdLuknzgFo97GgVS5EcTUEY
         /bWZ360X9nqYeR+tEbdWGCz03tL1mV9FL4rYeGtnf769NKdGnn48zdIY9oW0jBbXZTMB
         2XUx4MuAOUd4qrPy4CSrLjtxa1+2FlBQdw7XNe7n4KDnnmITSYV+aVAOxl3gBhFNaTwJ
         Ls1rg8tXSs1GK3qQq+8amkgDtbw+/Ev35ZUnEKU60ESEI3MYkYKoUaFhlczfjoQYga13
         6eQR623a1f35gS2nS7HgsxyS/Y9Ey5EQHYfjNg4AHj4MMjIObReXfY/rLzs7+BIIJWGX
         9Hlg==
X-Gm-Message-State: AOJu0YzA5L6/nSGG/d1CnA+28SFw4+6kg1kCleqX9gBfykxbosLUsEWF
        f6kH3dHrrkO81vXc+IQkEfw=
X-Google-Smtp-Source: AGHT+IGVo9is3ndYCWhXdlmusr+UH2e1O0U6g9Q19q1m8p5cozyfz2lOlrnGuqg/9TazaKOaBX4lEQ==
X-Received: by 2002:a05:6512:12c4:b0:4fb:9712:a717 with SMTP id p4-20020a05651212c400b004fb9712a717mr12351733lfg.13.1692881479841;
        Thu, 24 Aug 2023 05:51:19 -0700 (PDT)
Received: from [172.16.196.206] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24259000000b004fe4811d382sm3130885lfl.85.2023.08.24.05.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 05:51:18 -0700 (PDT)
Message-ID: <a3c2e506-3840-0136-a28f-a50eb0fdf72d@gmail.com>
Date:   Thu, 24 Aug 2023 15:51:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
 <c41ed69af6432298cbd82896328333f31d41dda0.1692824815.git.mehdi.djait.k@gmail.com>
 <ZOdG1wFo892bJU53@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v8 7/7] iio: accel: Add support for Kionix/ROHM KX132-1211
 accelerometer
In-Reply-To: <ZOdG1wFo892bJU53@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 15:02, Andy Shevchenko wrote:
> On Wed, Aug 23, 2023 at 11:16:41PM +0200, Mehdi Djait wrote:
>> Kionix KX132-1211 is a tri-axis 16-bit accelerometer that can support
>> ranges from ±2G to ±16G, digital output through I²C/SPI.
>> Add support for basic accelerometer features such as reading acceleration
>> via IIO using raw reads, triggered buffer (data-ready), or the WMI IRQ.
> 
> ...
> 
>>   	help
>> -	  Enable support for the Kionix KX022A digital tri-axis
>> -	  accelerometer connected to I2C interface.
>> +	  Enable support for the Kionix KX022A, KX132-1211 digital tri-axis
>> +	  accelerometers connected to SPI interface.
> 
> I know I have given a tag, but since it most likely require a new version,
> this can be amended for the better maintenance as
> 
> 	  Enable support for the Kionix digital tri-axis accelerometers
> 	  connected to SPI interface. Supported devices are:
> 	    KX022A, KX132-1211
> 
> ...
> 
>>   	help
>> -	  Enable support for the Kionix KX022A digital tri-axis
>> -	  accelerometer connected to I2C interface.
>> +	  Enable support for the Kionix KX022A, KX132-1211 digital tri-axis
>> +	  accelerometers connected to I2C interface.
> 
> Ditto.
> 
> ...
> 
>> +static const struct regmap_access_table kx132_volatile_regs = {
>> +	.yes_ranges = &kx132_volatile_ranges[0],
> 
> 
> This should be the same as
> 
> 	.yes_ranges = kx132_volatile_ranges,
> 

The driver uses &kx132_volatile_ranges[0] in a few places (for kx022a) 
so I believe this is okay. Well, I know I am biased as I do personally 
find &kx132_volatile_ranges[0] clearer. Here we point to the first 
element in an array - and yes, it may be I am minority here - but at 
least I wouldn't ask for changing this.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

