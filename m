Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57087AFAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjI0GHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjI0GH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:07:28 -0400
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D421E11D;
        Tue, 26 Sep 2023 23:07:26 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5043a01ee20so14389328e87.0;
        Tue, 26 Sep 2023 23:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695794845; x=1696399645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7ZyTS+6OkRT4rkQ1RkeoSytMaHEOzDK9fhK7Tz2pPo=;
        b=drwWkYPCQWrrDuqPmfsEyN0Xb2u1tH2I+heVF+D5pGi3cbuwM3EvebcUqO01gdtWrY
         tj9gMAMNNaWeJRo9Usrdnit0g4h+u8y5oQOU1La7ntQEfJZmrQt0jt8zmMYzs8OkBx7U
         Ip1EqA3oaQaJTo/ycQLuhBCrnMtwpe01FMzBZqGSYB85r2Pn2C5LLf9D/7uYO9io4xbf
         +0ivFMcHMIR9YhXq921c1+aahGfG8zkGkrOmkyBFgYlxk9ZZyYqhVUQ9HCdbJdlXXsqX
         bn6+KGY/fYvsGzx9ylBrqwdXj+pjqF8kSbYwGCi7UyVMWBB4KkZgPr9GDaHRkwT1b9ig
         AIMw==
X-Gm-Message-State: AOJu0YwM1PJy7g/0qijAn9RtJvW6rdIkQ+nnPNx0N08xrBEnEQOm3c9X
        6P600fZSqnYDnlKpR4JvIO4=
X-Google-Smtp-Source: AGHT+IGnJUBQAaYrmBopold+rBN/H15acJmyCp3yp3et0TZubBafpuWrwo+aEKuXo3YoVGEbaS/mFQ==
X-Received: by 2002:a05:6512:3412:b0:4ff:a04c:8a5b with SMTP id i18-20020a056512341200b004ffa04c8a5bmr1020765lfr.47.1695794844646;
        Tue, 26 Sep 2023 23:07:24 -0700 (PDT)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b0040550c20cbcsm12015055wmo.24.2023.09.26.23.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 23:07:24 -0700 (PDT)
Message-ID: <1abcf806-de65-45a9-a5f3-bec3322cca4a@linux.com>
Date:   Wed, 27 Sep 2023 07:07:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] irqchip: Add support for Amlogic-T7 SoCs
Content-Language: en-US
To:     neil.armstrong@linaro.org, Huqiang Qin <huqiang.qin@amlogic.com>,
        tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, hkallweit1@gmail.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20230913080924.3336391-1-huqiang.qin@amlogic.com>
 <20230913080924.3336391-3-huqiang.qin@amlogic.com>
 <93bb0a7e-3f58-4755-bf31-a694e60760d0@linaro.org>
From:   Lucas Tanure <tanure@linux.com>
In-Reply-To: <93bb0a7e-3f58-4755-bf31-a694e60760d0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-09-2023 09:26, neil.armstrong@linaro.org wrote:
> On 13/09/2023 10:09, Huqiang Qin wrote:
>> The Amlogic-T7 SoCs support 12 GPIO IRQ lines compared with previous
>> serial chips and have something different, details are as below.
>>
>> IRQ Number:
>> - 156      1 pin  on bank TESTN
>> - 155:148  8 pins on bank H
>> - 147:129 19 pins on bank Y
>> - 128:115 14 pins on bank M
>> - 114:91  24 pins on bank T
>> - 90:77   14 pins on bank Z
>> - 76:70    7 pins on bank E
>> - 69:57   13 pins on bank D
>> - 56:40   17 pins on bank W
>> - 39:20   20 pins on bank X
>> - 19:13    7 pins on bank C
>> - 12:0    13 pins on bank B
>>
>> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
>> ---
>>   drivers/irqchip/irq-meson-gpio.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-meson-gpio.c 
>> b/drivers/irqchip/irq-meson-gpio.c
>> index f88df39f4129..9a1791908598 100644
>> --- a/drivers/irqchip/irq-meson-gpio.c
>> +++ b/drivers/irqchip/irq-meson-gpio.c
>> @@ -154,6 +154,10 @@ static const struct meson_gpio_irq_params 
>> c3_params = {
>>       INIT_MESON_S4_COMMON_DATA(55)
>>   };
>> +static const struct meson_gpio_irq_params t7_params = {
>> +    INIT_MESON_S4_COMMON_DATA(157)
>> +};
>> +
>>   static const struct of_device_id meson_irq_gpio_matches[] 
>> __maybe_unused = {
>>       { .compatible = "amlogic,meson8-gpio-intc", .data = 
>> &meson8_params },
>>       { .compatible = "amlogic,meson8b-gpio-intc", .data = 
>> &meson8b_params },
>> @@ -165,6 +169,7 @@ static const struct of_device_id 
>> meson_irq_gpio_matches[] __maybe_unused = {
>>       { .compatible = "amlogic,meson-a1-gpio-intc", .data = &a1_params },
>>       { .compatible = "amlogic,meson-s4-gpio-intc", .data = &s4_params },
>>       { .compatible = "amlogic,c3-gpio-intc", .data = &c3_params },
>> +    { .compatible = "amlogic,t7-gpio-intc", .data = &t7_params },
>>       { }
>>   };
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.orgTested-by: Lucas Tanure <tanure@linux.com>
