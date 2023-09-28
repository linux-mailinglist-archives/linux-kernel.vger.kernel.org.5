Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2A57B11DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjI1E4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjI1E4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:56:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FD7122
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:56:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso1287379866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695876989; x=1696481789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4iB1nWfdkplR5rehtoms0dHBmNKDO/VCIkn0MwaJ4k=;
        b=LqNEXjBeyF4lV5C5u0CEZGWHHhX1G/fGTcULMw0WV6fnaTo3yckC5WrmrKyD9S7izR
         dv9l/QuFR1V1AtmyPPM7FocK1pKnY5hZhsKWD9RAF+4tfyyEDRGUFbpfG92hvBijaHPD
         kalIGw/gaj05/85kV6R5e3mousfc+8cvVNk77KHpl2S5vfWXzz/7+oYX2VvqCjlKUgVI
         2QBpdhd80/GHkEvJnLeemumtfXaFXvKDMP/OHv9AVY4BHe3N/0/WKp9LEO3YgysHP+bF
         0nwkz2HQVD26s4edy9si44DGqX74zH79LtgEuW/QWcPDrPVD6Qn5MRSIU5VSnZfJu/Vz
         U/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695876989; x=1696481789;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4iB1nWfdkplR5rehtoms0dHBmNKDO/VCIkn0MwaJ4k=;
        b=n74mKhXkrjAKR8+dOzciewMHK9BQR8UIp1oFSFpuPO3OFr16q+lQXd+vwgraLSrBKN
         bQ5Ajk78mIRCHH7lXU/Fw7LK3zMZxid5cNtqbNqjjECb+wnS30TYG5qzdsrZbAWNCoQM
         3RMlSljfB42KB2QJaAUQBwVvuqgaDTUAIWrXh6xEYYTGTpFEaBQYjG6WeJYTKPHmno/C
         GbFcxkKwzUxoFg9DIh7CdNlEbLY/uHDGqk2o/TVKW6TWwl0NlKQ1nGEDBf8IamsPu8Y8
         OvkTSDP4X9GY765BjQtEYsWaCXmYWH84AK6Cg3LHG18otZQ1NvrVV9xyG26/lTWFK1D1
         0eCg==
X-Gm-Message-State: AOJu0YxXbk3YbHsyTB1v9hhVVafP0WLt3AzHikAsXkflKkImS5o+yj4L
        29AwT785rJQZjOivPAVYheHuRA==
X-Google-Smtp-Source: AGHT+IGBNcWBnssmUYK1CVxXXzPy5SGtc5layIFYw2T+7vdDrI0iDtAYykd2rupwlwEhj3HMCFjZeA==
X-Received: by 2002:a17:906:cc14:b0:9ad:cf30:10c with SMTP id ml20-20020a170906cc1400b009adcf30010cmr162908ejb.46.1695876989019;
        Wed, 27 Sep 2023 21:56:29 -0700 (PDT)
Received: from [192.168.1.231] (host-87-4-82-94.retail.telecomitalia.it. [87.4.82.94])
        by smtp.gmail.com with ESMTPSA id y22-20020a170906449600b009adc77fe165sm10082708ejo.118.2023.09.27.21.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 21:56:28 -0700 (PDT)
Message-ID: <3c2a0e56-7e94-4497-9577-eb24922ff8c6@linaro.org>
Date:   Thu, 28 Sep 2023 06:56:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/3] dt-bindings: pinctrl: Add support for Amlogic T7
 SoCs
Content-Language: en-US
To:     tanure@linux.com
Cc:     Huqiang Qin <huqiang.qin@amlogic.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20230922094342.637251-1-huqiang.qin@amlogic.com>
 <20230922094342.637251-2-huqiang.qin@amlogic.com>
 <ff2c6d41-7c9a-4633-8343-eb94404de6e8@linux.com>
 <2d7eac30-480c-49a4-903c-d4f2b3cdfc8d@linaro.org>
 <CAJX_Q+2vpMM78DA_Q1YLddwogW_vHLDLQbO_mnBk_zMNg7V8KA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAJX_Q+2vpMM78DA_Q1YLddwogW_vHLDLQbO_mnBk_zMNg7V8KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2023 12:54, Lucas Tanure wrote:
> On Wed, Sep 27, 2023 at 8:48 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 27/09/2023 08:08, Lucas Tanure wrote:
>>> On 22-09-2023 10:43, Huqiang Qin wrote:
>>>> Add a new compatible name for Amlogic T7 pin controller, and add
>>>> a new dt-binding header file which document the detail pin names.
>>>>
>>>> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
>>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>>> ---
>>>>
>>>> V1 -> V2: Rename amlogic-t7-gpio.h to amlogic,t7-periphs-pinctrl.h
>>>>            Corrected indentation format.
>>>> V2 -> V3: Updated subject.
>>>>
>>>>   .../pinctrl/amlogic,meson-pinctrl-a1.yaml     |   1 +
>>>>   .../gpio/amlogic,t7-periphs-pinctrl.h         | 179 ++++++++++++++++++
>>
>> ...
>>
>>>> +#define GPIOH_0             148
>>>> +#define GPIOH_1             149
>>>> +#define GPIOH_2             150
>>>> +#define GPIOH_3             151
>>>> +#define GPIOH_4             152
>>>> +#define GPIOH_5             153
>>>> +#define GPIOH_6             154
>>>> +#define GPIOH_7             155
>>>> +
>>>> +#define GPIO_TEST_N 156
>>>> +
>>>> +#endif /* _DT_BINDINGS_AMLOGIC_T7_GPIO_H */
>>> Tested-by: Lucas Tanure <tanure@linux.com>
>>
>> How can you test bindings?
>>
>> Best regards,
>> Krzysztof
>>
> Sure!
> make dt_binding_check  dtbs_check don't flag any issues with T7 bindings.

Rob's bot does it... anyway this is ehich is equivalent to compile
testing of C. This is not testing and we do no credit compile tests with
"Tested-by". Otherwise dozens of build-bots would had to receive it.

Best regards,
Krzysztof

