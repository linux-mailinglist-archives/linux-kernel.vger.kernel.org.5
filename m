Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F58E7B66EF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbjJCK6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjJCK57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:57:59 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83D7DD;
        Tue,  3 Oct 2023 03:57:53 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7a269637b98so24786939f.3;
        Tue, 03 Oct 2023 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696330673; x=1696935473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qThTQ2EndUgzuynlyMsCB3sIEKXBzP2bceTtmpfh6iQ=;
        b=ATa9ZjEq6U2y9yUCTuJ5G9b9vdDkS73kO3fA+7g2pwHxQouLw3BqTe8DuLbjL2WPs0
         9hrcvSEncSiBqmFTxn6Xz1VQ8vKDD0DLSx1h3q++2qw8t9voImMnrKaiekUwYDa7ORen
         UeOcBnJr/yqi9Fym7EICwtbJqBfT9MzcABgEngpsD9zslqg2V2qXfyo7L6xmwVWNQItp
         /WS+VsV7yVXOPvXEqQzKpE6W6UbQYglU6zGk5IqKZncLICF62m8R30GpHKuV62oohw+k
         DtlubXn3AEX2FSj89jvk4WY5XpuFlh9NuecBcEDggqDo8WpF+OKNpafB+gMO8K5u6Z/B
         3M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696330673; x=1696935473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qThTQ2EndUgzuynlyMsCB3sIEKXBzP2bceTtmpfh6iQ=;
        b=oujiQNuc0GKpt61NhrXfyVB6o0Ox5vWLLuIviOEwAnoOAo8B2YEvMFBQjyZINf9jtE
         wOSQ3bCfMGFaX5Nr/C1947CuRxwVqdB+37Hd3Q9PcnL4Uz6Euz++L3g16YoaWTwPDU91
         4WuY99OnWJnoSEPqFoHzaFRWHQR0XfW81o2Hg7965burA3qYU8QxoON8RQgmUX9CnEUZ
         leDh3ZYuEbhWUAatn8F9r4wxNDw6KGdeEw/XHapNlz5RT/1DfU46LKxKWbNrBijWj43b
         fo82V/8ACA+z4WMJFRsN9yTyAsgihyL08TTWpGd37+mpQAckaiwNHvVG0cISknv7H+fs
         aPoQ==
X-Gm-Message-State: AOJu0YzQz0ohupq0HbX7G3Njr3G3oM0ia4C6VmLFHUdBHaZkeRM50WAI
        eYFU1IOWBLyE72+Xv5qTdnM=
X-Google-Smtp-Source: AGHT+IGttW4UKMJ5ur0fccwnHqXX3X6oJOU8nZcdsSYnBv+UUPjdTwMwO+7FbE7T/xEg3gJRLc9FhA==
X-Received: by 2002:a5d:9cd5:0:b0:786:2125:a034 with SMTP id w21-20020a5d9cd5000000b007862125a034mr15217606iow.18.1696330672860;
        Tue, 03 Oct 2023 03:57:52 -0700 (PDT)
Received: from [10.76.84.110] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id p18-20020a0566380e9200b00430bb70004dsm280745jas.103.2023.10.03.03.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 03:57:52 -0700 (PDT)
Message-ID: <303d2869-2273-f643-e8ff-e27675f929dc@gmail.com>
Date:   Tue, 3 Oct 2023 13:57:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] iio: adc: ad7173: add AD7173 driver
Content-Language: en-US
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230928125443.615006-1-mitrutzceclan@gmail.com>
 <20230928125443.615006-2-mitrutzceclan@gmail.com>
 <20230930150531.083c51d4@jic23-huawei>
 <c52afe87-eaa0-eb7f-090f-b22aec95e49d@gmail.com>
 <ZRvwrDcT770sJXkd@smile.fi.intel.com>
From:   Ceclan Dumitru-Ioan <mitrutzceclan@gmail.com>
In-Reply-To: <ZRvwrDcT770sJXkd@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 13:45, Andy Shevchenko wrote:
> Subject:
> Re: [PATCH v2 2/2] iio: adc: ad7173: add AD7173 driver
> From:
> Andy Shevchenko <andy@kernel.org>
> Date:
> 10/3/23, 13:45
> 
> To:
> Ceclan Dumitru-Ioan <mitrutzceclan@gmail.com>
> CC:
> Jonathan Cameron <jic23@kernel.org>, linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard Göhrs <l.goehrs@pengutronix.de>, Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
> 
> 
> On Tue, Oct 03, 2023 at 01:33:36PM +0300, Ceclan Dumitru-Ioan wrote:
>> On 9/30/23 17:05, Jonathan Cameron wrote:
>>> On Thu, 28 Sep 2023 15:54:43 +0300
>>> Dumitru Ceclan <mitrutzceclan@gmail.com> wrote>> +config AD7173
>>>> +	tristate "Analog Devices AD7173 driver"
>>>> +	depends on SPI_MASTER
>>>> +	select AD_SIGMA_DELTA
>>>> +	select GPIO_REGMAP
>>> If you are selecting it, why does it have if guards in the driver.
>>> I prefer the select here, so drop this if guards.
>> From what i checked, selecting GPIO_REGMAP does not select GPIOLIB but only REGMAP.
>>
>> Also, in the thread from V1 Arnd Bergmann suggested:
>> 	" I think the best way to handle these is to remove both
>> 	 the 'select' and the #ifdef in the driver and instead use
>> 	 'if (IS_ENABLED(CONFIG_GPIOLIB))' to handle optional gpio
>> 	 providers in the code. "
> Why not simply to be dependent on GPIOLIB like other drivers do in this folder?

I followed the suggestion given by Arnd. The full argument:

"From a Kconfig perspective, any user-visible symbol ideally only uses
'depends on', while hidden symbols usually use 'select'.

For the GPIOLIB symbol specifically, we have a mix of both, but the
overall usage is that gpio consumers only use 'depends on',
while some of the providers use 'select'. This risks causing build
breakage from a dependency loop when combined with other symbols
that have the same problem (e.g. I2C), but it tends to work out
as long as a strong hierarchy is kept. In particular, using 'select'
from an arch/*/Kconfig platform option is generally harmless as
long as those don't depend on anything else.

The new driver is a gpio provider and at least ad4130 and
ad5592r uses 'select' here, but then again ad74115 and
ad74113 use 'depends on' and ads7950 uses neither.

I think the best way to handle these is to remove both
the 'select' and the #ifdef in the driver and instead use
'if (IS_ENABLED(CONFIG_GPIOLIB))' to handle optional gpio
providers in the code."

I do not have a lot of experience with this subject.
As such, if you consider the argument invalid, mention it and i will
change to 'depends on'.
