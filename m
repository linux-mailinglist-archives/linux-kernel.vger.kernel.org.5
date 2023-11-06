Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021DA7E1D25
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjKFJZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjKFJZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:25:08 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B57BAB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 01:25:03 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so7162307a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 01:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699262701; x=1699867501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1MoY1fVCRAbq5Lml/6r1WQBnV1piHLAXm79P6FYzBM=;
        b=IaDOXoQvl6gQWM70nWyZlh6x7PfQQlYOlPboK2AelfqZQD78xTmBzgOqKz54CiXYi1
         rD0DWEAOETK/yVHe2C3ydqligBiTsjt1p+6i1JU74lv2C9daSASfvfbyy+AqqJvSOih6
         sXAvppGFu0KPh8pG8dxY1IdIzfYXPzhtQaLaTp4RsTj7bSrxurdvTP7TAcT0OUGGvwqe
         H59/jPPgPE8D4tXbEMc0Lpl3shcvAe1xMvSeq5d8g7ha0wjCeSP7kk6t0JGldRegsGPB
         6TOnvDq+7LTtI1GPO8UMHkKZspkaqGNLvlbzpWWX5Knyr0Iyai4fhC9xF1jWBFOkCFiF
         QcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699262701; x=1699867501;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1MoY1fVCRAbq5Lml/6r1WQBnV1piHLAXm79P6FYzBM=;
        b=AJzsszohleJR9wonVDay52MGveZiMJ2MZu+7++DSZtJCHN1Lujda8IuUchAtD+P1ue
         BrrEyzaT5kFGbvrmQ5jtfpQIVKw4cIB7F0ijuetgDXvm2cGN2/yH6r5ApstTXoP3JrmF
         2PNKUz7fd8fY7EOOan+LppayIGvridcx1DqGz4SULxPd8xY9AWLtC3VwyIkv38Niy7oj
         nEdoH9b2+zSY2kH1Lx5m9aKU9uV1Zl+b9p4Qs9oUAapBFonjU4jg0mCVzptOI+9pgXUm
         MKtXOAGC4sbhVgBxScKmxbO6yqQTpvc/HgY70wOJXqNTSNIYelB21pVxUQ8BOuEbJWG4
         +cCA==
X-Gm-Message-State: AOJu0YwTt0cbnf6FVS0ADFsgKsLB5TVPdOgOeA2XKRE2U9a+eV3+yLC+
        hO6FtUKu7et5jbZiTAns1v2vTA==
X-Google-Smtp-Source: AGHT+IGk8Yc9+u3aRLu4K9qNGa0a/pdC8bafPfQPcVt2EX0XGyyeVfLzD7sXeegMCIDOcF68SzNjng==
X-Received: by 2002:a05:6402:520d:b0:53b:3225:93c2 with SMTP id s13-20020a056402520d00b0053b322593c2mr29658511edd.8.1699262701479;
        Mon, 06 Nov 2023 01:25:01 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id v28-20020a50a45c000000b0053f10da1105sm4234700edb.87.2023.11.06.01.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 01:25:01 -0800 (PST)
Message-ID: <8fae735c-c227-4f60-8ba8-8cb13dfb2626@linaro.org>
Date:   Mon, 6 Nov 2023 10:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iio: adc: ad7192: Use device api
Content-Language: en-US
To:     alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Beguin <liambeguin@gmail.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231105193132.47009-1-alisadariana@gmail.com>
 <20231105193132.47009-2-alisadariana@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231105193132.47009-2-alisadariana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2023 20:31, alisadariana@gmail.com wrote:
> From: Alisa-Dariana Roman <alisa.roman@analog.com>
> 
> Replace of.h and corresponding functions with preferred device specific
> functions.
> 
> Also replace of_device_get_match_data function with
> spi_get_device_match_data.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  drivers/iio/adc/ad7192.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index adc3cbe92d6e..48e0357564af 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -17,7 +17,6 @@
>  #include <linux/err.h>
>  #include <linux/sched.h>
>  #include <linux/delay.h>
> -#include <linux/of.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -364,19 +363,19 @@ static inline bool ad7192_valid_external_frequency(u32 freq)
>  		freq <= AD7192_EXT_FREQ_MHZ_MAX);
>  }
>  
> -static int ad7192_of_clock_select(struct ad7192_state *st)
> +static int ad7192_device_clock_select(struct ad7192_state *st)
>  {
> -	struct device_node *np = st->sd.spi->dev.of_node;
> +	struct device *dev = &st->sd.spi->dev;
>  	unsigned int clock_sel;
>  
>  	clock_sel = AD7192_CLK_INT;
>  
>  	/* use internal clock */
>  	if (!st->mclk) {
> -		if (of_property_read_bool(np, "adi,int-clock-output-enable"))
> +		if (device_property_read_bool(dev, "adi,int-clock-output-enable"))
>  			clock_sel = AD7192_CLK_INT_CO;
>  	} else {
> -		if (of_property_read_bool(np, "adi,clock-xtal"))
> +		if (device_property_read_bool(dev, "adi,clock-xtal"))
>  			clock_sel = AD7192_CLK_EXT_MCLK1_2;
>  		else
>  			clock_sel = AD7192_CLK_EXT_MCLK2;
> @@ -385,9 +384,10 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
>  	return clock_sel;
>  }
>  
> -static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
> +static int ad7192_setup(struct iio_dev *indio_dev)
>  {
>  	struct ad7192_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->sd.spi->dev;
>  	bool rej60_en, refin2_en;
>  	bool buf_en, bipolar, burnout_curr_en;
>  	unsigned long long scale_uv;
> @@ -416,26 +416,26 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
>  
>  	st->conf = FIELD_PREP(AD7192_CONF_GAIN_MASK, 0);
>  
> -	rej60_en = of_property_read_bool(np, "adi,rejection-60-Hz-enable");
> +	rej60_en = device_property_read_bool(dev, "adi,rejection-60-Hz-enable");

Not strictly related to your patch, but where are these properties
documented?


Best regards,
Krzysztof

