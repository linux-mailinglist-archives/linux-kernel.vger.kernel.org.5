Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B75D7F6261
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345969AbjKWPLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWPLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:11:10 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0C3C1;
        Thu, 23 Nov 2023 07:11:17 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54acdd65c88so30664a12.2;
        Thu, 23 Nov 2023 07:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700752276; x=1701357076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfaUbBDL6J7sHACYIZEBt2YZRifprtYpbRWDHsO+BsE=;
        b=Pt3jcRhjT8ZlvX5L9+y9AMLt27BmbHZIh9MazM6Yi9UCw3rlNc3DHkGjfXJBRHiAE5
         EboqnmNu5c3+UfSWnDwE9JoYK7kADr6MRGL5f3z7RUs/m6HNpEaDSg61vu14h9AA6u32
         U1tYgdUKw6evXYsz2or2s3qer7pVcwmm5hAcGRavXJR2wtnV7k1pv1BjCh032VaZLrNH
         VdlIO59Ffwnzw3cPVlccO42kwMC/3+mx06QkDQqYUTY2Yn0NRXoQqV4APtDxLg1S+JA0
         uODZEs/Wu9EHMgvpg79SSWGu5vM1aTZD0w/gAgOM7SCsXfuU8Ah1Fcoh67NHb7sgsXwc
         gcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700752276; x=1701357076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfaUbBDL6J7sHACYIZEBt2YZRifprtYpbRWDHsO+BsE=;
        b=tKJh7D12N/bl0UuF/XZh4tAtZPrEfpyZ4cCsC4uOOXku8vnOqZPBI5dDJLMb4fQ+f/
         dDUnchvCzPyg4hMGwtvKE0Y3mS0cK69I+sTR8NxXxoK1Y3CTjhuMR2vSSUKh4fupL4Vn
         yTyU85DTQpArvBdEFYx2B3dDOEiAOLaXkMl2upYfa+DJz1wnwMae9m0g+AA5Pr5XeW04
         pcYEumnSyxKtHafty9fOa39KJf/AykmjCkZ4mE3DOWDBnRt4zloH3hVOjHexbCSvRoPz
         YS3VY5AILDz7A78Nb9rEP7eqyDy07f1kziYCdKN8fmT6wbxX9UylI15K9IUtTEwgbl8p
         6qRg==
X-Gm-Message-State: AOJu0YwkRk/KM5KFj5IjfKw+ZQb1D6bkUfK+0odd1waOqCn8BBpNzVVe
        R8PXZ3IHfeq7BANkIbXYLNw=
X-Google-Smtp-Source: AGHT+IHUPpxomXsKOEep71Ej9/P2tEhZdTvJPslUAXGC0AoBOSj5SuA1LtnVROIaShOBJ75p/FkCbg==
X-Received: by 2002:a17:907:cbc4:b0:a00:152a:1efa with SMTP id vk4-20020a170907cbc400b00a00152a1efamr5322703ejc.3.1700752275393;
        Thu, 23 Nov 2023 07:11:15 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906119400b009fbdacf9363sm887518eja.21.2023.11.23.07.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 07:11:14 -0800 (PST)
Message-ID: <643753e7-6f97-4c38-b21e-e95573f60f85@gmail.com>
Date:   Thu, 23 Nov 2023 17:11:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: adc: add AD7173
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231123140320.30409-1-user@HYB-hhAwRlzzMZb>
 <6882a92f-1a15-4ea5-be1e-9d56afc0ce5d@linaro.org>
Content-Language: en-US
From:   Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <6882a92f-1a15-4ea5-be1e-9d56afc0ce5d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/23 16:26, Krzysztof Kozlowski wrote:
> On 23/11/2023 15:02, mitrutzceclan wrote:
>> +  Bindings for the Analog Devices AD717X ADC's. Datasheets for supported chips:
> 
> Drop "Bindings for" and instead describe hardware.
> 

Okay

...

>> +  avdd-supply:
>> +    description: avdd supply, can be used as reference for conversion.
>> +
>> +  required:
> 
> Please test your code before sending. You ignored my comment. This has
> both wrong indentation and wrong placement - should be after all
> properties and patternProperties.
> 
> Do not ignore comments but respond to them.
> 

There were no errors while testing the yaml binding (with
DT_CHECKER_FLAGS=-m dt_binding_check - to make sure that this is how
bindings should be tested). Indeed I did not test the yaml if the
required properties are missing from the example. What is indicative in
this patch that it was not tested?

I did not ignore your comment. I did not have questions about it. I
missed the indentation. Sorry about that.

But about the placement of 'required': the example-schema does not have
the exact case of pattern properties. Also, there are multiple iio/adc
(ad4130, ad7124, ad7292) bindings that place required before
patternProperties. I assumed that this placement is correct.

Will move it in next version.

In regards to responding to comments: if there are no questions about a
comment and will fix in next version, should there be a response anyway
just confirming it?
