Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0A47B39AB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjI2SGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjI2SGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:06:52 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2761B0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:06:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5347e657a11so7931253a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1696010809; x=1696615609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+NzcmzL/mi2gPiTFAUFYkfHbta1h+i/9QHJGacVCRM=;
        b=BZKNrOmSg1BH7CoL61tNBoDEDwQvSZi8Sza/jLsnR8XayIHxZOygi98si1PFY9sNro
         C0a6bs4DRDLuoYjStNQFQSu0zqnfAUXLlBgyrfALemVvzdDtZ0E8/ZMt2h+2MySHtUnD
         KbQN+t7BuUbxxxwgJOXqFoazCSgdCDDmt7485dZ6RgtKlxnD/1yofJcebiRIXSrdloer
         JrMeTVftAtgAmdg2LFJtbA9ujEg003grUJK/WomgGwPzlDfpBCLydxmtenhlO8L27Vcu
         ud1R/Hksl0o9h6d0+gQJIEfnJCwazZeF7KiVIUYv4FtGtGDccSItSYGbBnQQKmS3uhbe
         9N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010809; x=1696615609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+NzcmzL/mi2gPiTFAUFYkfHbta1h+i/9QHJGacVCRM=;
        b=E4vuAgxFb+oXdCmVJqBmSujTaaN4zpNi1GFYHZ4o8XprMjpDquwAcUqpDU6eI0+TS/
         V4EympTuotY5LuqXagNoklNgrCkoJil2eYtCnqC0BlRJWwZ+uuUg+CkwJxqdRNHIHgk9
         0Tk4IWh5ytnSRZeA7TUaTlWoDpTBanZlZkz6x5Ic4uzuugRyqOJAoV3T0wY7/rXsY+Ev
         oIZp5hiVnxvxyd/Z9qCcfsINDyWR7HZCpC7B6IHRSAR/rUttzkCA4Xo9XW/axXGwVxLf
         cb/f/DuXoHE7SRGuhaCdzDXeYDPZcPd7EB7f8WqB0vW5yF2nyq/d9Ydbo8w2/7qnrVbV
         pQYg==
X-Gm-Message-State: AOJu0YxtEgbH/3Jm1lMBNeYt5GGRoEmq//U/j1d9K5TSSi4lE6ZqhRaQ
        zK/utzvSl7odbjAxR3k7y6R/kA==
X-Google-Smtp-Source: AGHT+IExPWQ+RwFB1vD0UeGPtfnIxlYQrpNuAp/izAsodjrWvv4TjZPjVZRtMzXuUq1PQZMEim+oTQ==
X-Received: by 2002:aa7:c507:0:b0:530:be79:49e7 with SMTP id o7-20020aa7c507000000b00530be7949e7mr4640326edq.37.1696010808720;
        Fri, 29 Sep 2023 11:06:48 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.190])
        by smtp.gmail.com with ESMTPSA id m4-20020a056402430400b00536031525e5sm3607619edc.91.2023.09.29.11.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 11:06:48 -0700 (PDT)
Message-ID: <81b39049-f78e-148c-c901-5733c4894c83@tuxon.dev>
Date:   Fri, 29 Sep 2023 21:06:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ARM: dts: at91: sam9x60_curiosity: Add mandatory dt
 property for RTT
Content-Language: en-US
To:     nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
References: <20230928143644.208515-1-nicolas.ferre@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230928143644.208515-1-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.09.2023 17:36, nicolas.ferre@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> atmel,rtt-rtc-time-reg is a mandatory property and encodes the GPBR
> register used to store the time base when the RTT is used as an RTC.
> Align the RTT with what's currently done for sam9x60ek and sama7g5ek,
> and enable it by default even if RTC is also enabled.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> [nicolas.ferre@microchip.com: adapt to newer kernel]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
> index cb86a3a170ce..83372c1f291b 100644
> --- a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
> @@ -439,6 +439,10 @@ &pwm0 {
>  	status = "okay";
>  };
>  
> +&rtt {
> +	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> +};
> +
>  &sdmmc0 {
>  	bus-width = <4>;
>  	pinctrl-names = "default";
