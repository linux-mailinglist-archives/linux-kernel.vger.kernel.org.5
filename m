Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0B57B1E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjI1N3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjI1N3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:29:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D59198;
        Thu, 28 Sep 2023 06:29:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso2561657266b.0;
        Thu, 28 Sep 2023 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695907747; x=1696512547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ROU8+ExR4QbhUibvmX7F0zp678ehgrkdHVtekRiu3/c=;
        b=K+gB6NHK7HDUKbX7ZlC0/7sh79v6fhP3ca/DGRnsUPDrRbbG491YhIrA7rwFS7eg+m
         mAsWOvOSY6d7NdnIJucOornadTX2SYeslZsX/j+4q6G7qz2MMbyloDeOOoZkq1cf+i3M
         owr+4P1xV9cO97aG+2WT7KwpTadmgM+pQUc1JY3HQesK1Sju/yKA1tfIkPsuAn1ZjkLi
         srCyWv/R/ZS/7V1ZFSPMi6KrxHRbmJBxA7U35HhDXkp5BbgAgepT+aQ01RkKEK5OOpia
         4k7IxJDY/hOUyACNQKI5pa4jlOUJj+rxTWcBQDAsJO6kE6aKoZAt8afli6Qh/quS6dIN
         O/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695907747; x=1696512547;
        h=content-transfer-encoding:in-reply-to:from:references:cc
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROU8+ExR4QbhUibvmX7F0zp678ehgrkdHVtekRiu3/c=;
        b=Ca6H+ZjaA0RCiVX5PvCmbRQPcoPFogyFbA84HTANZBERyI4tkH00k7mmE/6Z+dKsNO
         FCtsOCibf+bRwYtILHXjrYbNZraNuJQjV2K4TRntqQ2mp09EVCHQPA27sy0HLO9Cn1IE
         NrkeRKBsd3y74qjbSQV6ra03VgFgKbhb9unOikyNXOsoF3Gts/snYa6eKFtuLsyzirGV
         /z7uLhSpzM1jZ9v0lEFAnDbwM/v2g61Mhbq0AUA1HXx7SQ/T1i3WpFkjwzOc0APwvH+6
         lhezhEmxM5T9dbQXURDt259IUoDO+0l1ph3pf7xEdawEVq0MYywH0xnhm22tBJ3ZSSeB
         D8RQ==
X-Gm-Message-State: AOJu0YwQJvqZO1XjPIIxcmnp3u5rMIJPAWoWVz41LdAj+CQIYdCvpBtR
        q3kZ0xiVpYjC3Le419k7Dds=
X-Google-Smtp-Source: AGHT+IHJJy/exKddlnMOuyJmSuJkajIryMA/BQi30k2HkEvqF/moQuCSzUvwJ9e/9jpcsu+5cwhmSQ==
X-Received: by 2002:a17:906:5a46:b0:9ae:5513:e475 with SMTP id my6-20020a1709065a4600b009ae5513e475mr1377678ejc.9.1695907746714;
        Thu, 28 Sep 2023 06:29:06 -0700 (PDT)
Received: from [10.76.84.110] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id gy18-20020a170906f25200b009a9fbeb15f5sm10868883ejb.46.2023.09.28.06.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 06:29:05 -0700 (PDT)
Message-ID: <823f03d7-2af4-f4f6-4e74-9beb299ab0e8@gmail.com>
Date:   Thu, 28 Sep 2023 16:29:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] iio: adc: ad7173: add AD7173 driver
Content-Language: en-US
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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
From:   Ceclan Dumitru-Ioan <mitrutzceclan@gmail.com>
In-Reply-To: <20230928125443.615006-2-mitrutzceclan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 15:54, Dumitru Ceclan wrote:
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>

Forgot changelog
V1 -> V2

 - keep original out-of-tree AD7173 naming
 - remove gpio_cleanup
 - handle 32bit realbits offset case
 - use iio_device_claim_direct_mode, drop own mutex
 - use dev_err_probe
 - cleanup headers include
 - use GENMASK() and FIELD_PREP()
 - use HZ_PER_MHZ
 - change #ifdef GPIOLIB to if( IS_ENABLED(CONFIG_GPIOLIB)) 
 - use gpio-regmap
 - change boolean flag in info struct to number of gpios
 - NIH memset64
 - use struct pointers for config comparison
 - use spi_write_then_read for ADC reset
 - use stack allocated buffer for reset
 - define constant for reset sequence size
 - use kcalloc instead of kzalloc
 - change of naming to fw of dt parse function
 - change de-referencing chain to local variable dev in multiple locations
 - drop write_raw_get_fmt
 - add driver private data to spi_device_id table
 - use fsleep() instead of usleep_range()
 - put config value inline
 - align read/write raw arguments
 - remove zeroed values from channel templates structure
 - define constants for temperature sensor positive and negative inputs
 - always enable temperature channel
 - configure spi clock phase and polarity from driver

 misc changes (test bit, return disable all, indentation fix, change statements to single line)


