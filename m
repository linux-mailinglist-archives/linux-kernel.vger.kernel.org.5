Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED666754FEC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGPRAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 13:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjGPRAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 13:00:05 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2DF1B1;
        Sun, 16 Jul 2023 10:00:04 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso2262956b3a.3;
        Sun, 16 Jul 2023 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689526804; x=1692118804;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7RZBSC9VlSCWDDQ9NaldE02NH19Agbf9l1F2PLZ3gMU=;
        b=Xhgz+LJBK80DgVAlAdMzAf9hJLuv4SUnLFdgKVhm7CIJMmSwB4uOUnzvuj91L751x6
         BdutsfJZ8dpA+kY1eU+7kkGYO80pdi2UHVijW6BxEp+xX7MTPEezQmcZ5jLqudo034zH
         z8q56R0ND8Ev7G40aXSvWeknaOnLokeZ+dhGaCwk6E+klX2YjhVmDNIKh91EjQSRRsXn
         CvuXXqon+6/PsPOzfN1Jz6DlTG5JJBlBofVFnjUpxZ50O1dfd/g9qZcWRV2iGww2magn
         i/Iq7vuXYgcWuoWeSsGzLY73/xU4wa710bYCPOET+TD/9JV0P70gEOfIwwT8LrBWUMnU
         ypVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689526804; x=1692118804;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RZBSC9VlSCWDDQ9NaldE02NH19Agbf9l1F2PLZ3gMU=;
        b=egdKT1rcuijo3eQgzAZ3CWfMewn250aoDiOhuq9K70p/qJ/XRy1winyw6zoK/EYF7o
         cACFdjrt//8m06vKz13V90FTPstT2oedbFPOvbjnp0NSe4YMyYnLLYhipS/UkFxM8ShZ
         NEY4EMB6+4EYeamj1rcomDUnBxKcIQHKVkb1yJRS9R+kx9rGAMKGqTkqfWNo84eqQJX4
         mWuXqJJGSncKqwktbag7Zl1neqPX7qEeHjiR57LFT3qjUffFGcn/+zXNdNYIZ5h9dbQJ
         yBppmrRJOEbliuDOsaY8LaPzfPO9V1rPUGeuIfRqq9op0FEqSJtsL7a9wZwC8wy7uRYZ
         roOQ==
X-Gm-Message-State: ABy/qLYOtfbyBZLN5Yz2ln9i9hsO1XCubeE8yO35iCIPOic3bon8t566
        3+pdQieulq3U6xXO19v7XO4=
X-Google-Smtp-Source: APBJJlEf5Hxvs83+h5l+00e+naQWCiqNakhSinl9PZLGOJ0G+eMabdQR6VlF1n/dqXxDfUKPyylETg==
X-Received: by 2002:a17:903:2310:b0:1b8:7618:5414 with SMTP id d16-20020a170903231000b001b876185414mr9372013plh.60.1689526803628;
        Sun, 16 Jul 2023 10:00:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001b8a54f99d1sm11183638plb.275.2023.07.16.10.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 10:00:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7a69bda1-5f4c-5b1f-8eb6-6fd58917a9b1@roeck-us.net>
Date:   Sun, 16 Jul 2023 10:00:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?B?6JSh5om/6YGU?= <billyking19920205@gmail.com>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Billy Tsai <billy_tsai@aspeedtech.com>
References: <CAGUgbhCqOJaEPjS96o2au21uW4NhqFScm4Ayd8PzOQvqxQ94SQ@mail.gmail.com>
 <0b9dd5cf-f4ca-2e6b-624d-0b451bbc2f30@linaro.org>
 <0ba3767c-d481-6e2c-2d32-b79af0e1efd8@roeck-us.net>
 <CAGUgbhC34-pUp4ECULc0ScaN7hUF1L-z69h+ji-TiVrv4gKd3Q@mail.gmail.com>
 <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net>
 <CAGUgbhDbFedVe-pc+muD_NtDpjHpGqMDdrS3A73C-QbxeHn4oQ@mail.gmail.com>
 <cf91edc9-1093-495b-48eb-6b05198c2541@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
In-Reply-To: <cf91edc9-1093-495b-48eb-6b05198c2541@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/23 09:08, Krzysztof Kozlowski wrote:

[ ... ]

>>
>> This patch serial doesn't use to binding the fan control h/w. It is
>> used to binding the two independent h/w blocks.
>> One is used to provide pwm output and another is used to monitor the
>> speed of the input.
>> My patch is used to point out that the pwm and the tach is the
>> different function and don't need to
>> bind together. You can not only combine them as the fan usage but also
>> treat them as the individual module for
>> use. For example: the pwm can use to be the beeper (pwm-beeper.c), the
>> tach can be used to monitor the heart beat signal.
> 
> Isn't this exactly the same as in every other SoC? PWMs can be used in
> different ways?
> 

... and in every fan controller. Not that it really makes sense because
normally the pwm controller part of such chips is tied to the fan input,
to enable automatic fan control, but it is technically possible.
In many cases this is also the case in SoCs, for example, in ast2500.
Apparently this was redesigned in ast2600 where they two blocks are
only lightly coupled (there are two pwm status bits in the fan status
register, but I have no idea what those mean). If the blocks are tightly
coupled, separate drivers don't really make sense.

There are multiple ways to separate the pwm controller part from the
fan inputs if that is really necessary. One would be to provide a
sequence of address mappings, the other would be to pass the memory
region from an mfd driver. It is not necessary to have N instances
of the fan controller, even if the address space is not continuous.

Guenter

> Anyway, it is tricky to keep the discussion since you avoid posting
> entire DTS. I already said:
> 
> "I will start NAKing such patches without DTS user. It's like reviewing
> fake code for some unknown solution and trying to get from you piece of
> answers one by one, because you do not want to share entire part."
> 
> 
> 
> Best regards,
> Krzysztof
> 

