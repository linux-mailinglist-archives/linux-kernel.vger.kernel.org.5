Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6EA7DED1D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjKBHMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjKBHME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:12:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EB8185
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 00:11:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99357737980so84569766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 00:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698909114; x=1699513914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XLLO2ZSj14ek5f9/G5cjQHYdHWJXlHxtegw6xtGQB1Q=;
        b=h/8USqGETnfqV9O+2GuVzAJGlLcJ+QHGlzat+4iRoCFbAw2uL2dqizOBRdHOWLbHCb
         uoBvOdOZqi86uNAeF9OR/Xuv0I2HjgVZs6QqZX6fxUFZgJcWTsj73pbDZO38ZTHnTSSZ
         HjEHs7J8f1CZWFDavOuH1KF+QuI9gt32M5U8fLxMPIYv0rbl6TLk2JwMGFGbVLOwoT/w
         sKzJGif2q53DlG4c9ZgtWzONeLRM64OtYJRMWNBg05l0thtsYjEMIsgif1TJ27IsuxaD
         luKO9ovhirAyVvpeck+PQ8blVTZmWeNMYKm03co5tRu/+cNv3FzYUhVH5eMVV+/a7hxa
         ZTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698909114; x=1699513914;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLLO2ZSj14ek5f9/G5cjQHYdHWJXlHxtegw6xtGQB1Q=;
        b=Twxpe7HbeI/xLZNJQSsXqGkTl4ni0Ypfl4eXDV+G7uk1IVf4mCE5QeOoG3igEZns6B
         0w1IOWRt6kndSLa8CW08tdfT9k4NXli4ePPXOmP+6pSXPjQQYM1OKWbfDmeEaDRsQzTK
         Nce98HXYUacs14PmQZep1eMvyNEGsveQa+ZizCurVkGgHK/fMUlw7UnpUEMSUE1yFj+T
         1GPQX3ZycGg1uytlWWcD6OhWVscsqvEGV4kdq7gSujUpcE7mEH/MMuR07XuAs4hHPFaL
         mV/q7WACPbKNPMlCl7NDhsWLahGu5SAcWXENjDapVvHGvNX1KTtq5iq1KCom0HjOhf7Z
         Cycw==
X-Gm-Message-State: AOJu0Yw3puMnrxjoGGNiU9mkuW0qGbRUGXwM1nv0BZTRZR6+M53p8Xew
        ggvjA0njlk14US7KVUENqx3c0w==
X-Google-Smtp-Source: AGHT+IFz3lqUCJbyM8gNJLVuu/e8iat9+bi5NZqTUB9AyPOtTnX6IbvZh5qzTZ1imC2JPhfNcs3Uzw==
X-Received: by 2002:a17:906:6a15:b0:9c7:69d4:b264 with SMTP id qw21-20020a1709066a1500b009c769d4b264mr2938876ejc.77.1698909114191;
        Thu, 02 Nov 2023 00:11:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id la22-20020a170906ad9600b009b8a4f9f20esm768710ejb.102.2023.11.02.00.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 00:11:53 -0700 (PDT)
Message-ID: <4fc3fafa-6c9b-440a-99fe-1332cd3d5b1d@linaro.org>
Date:   Thu, 2 Nov 2023 08:11:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gpio: realtek: Add GPIO support for RTD SoC variants
To:     =?UTF-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231101025802.3744-1-tychang@realtek.com>
 <20231101025802.3744-2-tychang@realtek.com>
 <e18a7ee0-a5e3-4180-9f8a-99b21d1303e6@linaro.org>
 <8e4c8676acaf4ba6bf3f57451b2eab40@realtek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <8e4c8676acaf4ba6bf3f57451b2eab40@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2023 04:30, TY_Chang[張子逸] wrote:
> Hi Krzysztof,
> 
>> On 01/11/2023 03:58, Tzuyi Chang wrote:
>>> This commit adds GPIO support for Realtek DHC RTD SoCs.
>>
>> Please do not use "This commit/patch", but imperative mood. See longer
>> explanation here:
>> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-
>> patches.rst#L95
>>
> 
> I will remove these words.
> 
>>> +static int rtd_gpio_probe(struct platform_device *pdev) {
>>> +     struct rtd_gpio *data;
>>> +     const struct of_device_id *match;
>>> +     struct device_node *node;
>>> +     int ret;
>>> +     int i;
>>> +
>>> +     node = pdev->dev.of_node;
>>> +     match = of_match_node(rtd_gpio_of_matches, pdev->dev.of_node);
>>> +     if (!match || !match->data)
>>> +             return -EINVAL;
>>> +
>>> +     data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>>> +     if (!data)
>>> +             return -ENOMEM;
>>> +
>>> +     data->assert_irq = irq_of_parse_and_map(node, 0);
>>> +     if (!data->assert_irq)
>>> +             goto deferred;
>>> +
>>> +     data->deassert_irq = irq_of_parse_and_map(node, 1);
>>> +     if (!data->deassert_irq)
>>> +             goto deferred;
>>
>> So this goes to cleanup path...
>>
> 
> Since there is no need to do devm_free, I will directly return -EPROBE_DEFER here.

That's not a correct return value. You do not return DEFER on missing
IRQ. This should anyway be different call: platform_get_irq().


Best regards,
Krzysztof

