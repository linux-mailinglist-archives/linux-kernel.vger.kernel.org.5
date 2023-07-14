Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CFF75380C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjGNK1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjGNK1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:27:16 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E51A30EB;
        Fri, 14 Jul 2023 03:26:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666ecf9a081so1681995b3a.2;
        Fri, 14 Jul 2023 03:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689330405; x=1691922405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OeDz9XOyO2BYg3Fsp6L2LMwg9YaX4dzxFbvqddCCNbc=;
        b=ex+LPH8wvfjEVCF0n3s6EmyDriahHf0k8cD+7xAUFjd8g86YStOQQ0TcV5a0oQOcnA
         yCdYEJt6bY1tHGnCKAoKi4J/e3jxJgGwhKlideP6K8PcX63uEh+tI7Buyzfj03/3AJGv
         cqEiPEpYBs1pjLKPJ4Y56tlxv/BmWZWFHsWT7jsajd+NQCHCuVxTnRX9sZBEnD+6yt/3
         Ni8+jTItOOTK7vmKAZg42GqkwxBQu8myDkQ8RGChgRrcvrY0qTKa9I8s119YcaCj9Epk
         RgTgNibToeN8Zi4jd6SLISN0wsoNTVbrjLlQ/8qZu/vkJoIqO2zs1PVE1vaYWHq/GDMd
         KFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689330405; x=1691922405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OeDz9XOyO2BYg3Fsp6L2LMwg9YaX4dzxFbvqddCCNbc=;
        b=AQ4dP6VZy5QQuF4KeZmQM9oEM3NqMxFs0RRuVbeVtDE4QCa951tBVSO0Bxr2A8MywZ
         CvO8j1EVBRkGZWQxRX35QZLRdpq0SSujZN757gTkfaMY5sLma5wwQessXW39WVF2Mi+9
         0jGLQWoQudvKEWXEEYx4tYdRmhZsdL3T+gPw+0kgV2YEhorvavir8kvhsW16XDsmmSwX
         STZ50N03Y89WEbsc3RTJjeYG5pVYlNvKv11RjW7X0yRomA4kYtTGfiIiMUO70LVtt0nM
         RxCCKKY4CvVu/WQ+ZkW3H/rymPAHF7R+vo0qf5Gpx/Hz75j0tdIoeWaSCP/2cTxtshtT
         QxGg==
X-Gm-Message-State: ABy/qLb4z9Yzb0zmuD9k1adBy4PAcupO2pSvx+NH+t4sKLpSjqzMBvlW
        DwZrbyARImR+mPryPF+Dcas=
X-Google-Smtp-Source: APBJJlGPzXvxtEOFuHaJbQ4dhtA0fv1hirhejLpmoI89mcWrV+4LLQ+oGeZ2UFuMoX7KIEqT4a96/w==
X-Received: by 2002:a05:6a00:17a6:b0:666:e42c:d5fb with SMTP id s38-20020a056a0017a600b00666e42cd5fbmr6488013pfg.32.1689330405421;
        Fri, 14 Jul 2023 03:26:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s10-20020a62e70a000000b006687b41c4dasm6869160pfh.110.2023.07.14.03.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 03:26:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net>
Date:   Fri, 14 Jul 2023 03:26:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
Content-Language: en-US
To:     =?UTF-8?B?6JSh5om/6YGU?= <billyking19920205@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
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
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAGUgbhC34-pUp4ECULc0ScaN7hUF1L-z69h+ji-TiVrv4gKd3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 03:18, 蔡承達 wrote:
> Guenter Roeck <linux@roeck-us.net> 於 2023年7月14日 週五 下午5:59寫道：
>>
>> On 7/14/23 00:13, Krzysztof Kozlowski wrote:
>>> On 14/07/2023 09:04, 蔡承達 wrote:
>>>
>>>>           > This is because our register layout for PWM and Tach is not
>>>> continuous.
>>>>
>>>>           > PWM0 used 0x0 0x4, Tach0 used 0x8 0xc
>>>>
>>>>           > PWM1 used 0x10 0x14, Tach1 used 0x18 0x1c
>>>>
>>>>           > ...
>>>>
>>>>           > Each PWM/Tach instance has its own controller register and is not
>>>> dependent on others.
>>>
>>> Your email reply quoting style is very difficult to read.
>>>
>>>>
>>>>
>>>>
>>>> Hi Guenter,
>>>>
>>>>
>>>>
>>>> Did you receive a response to my previous email?
>>>>
>>>> I would like to inquire if you have any further concerns regarding the PWM
>>>> and Tach with 16 instances.
>>>
>>> But isn't like this in all PWMs in all SoCs?
>>>
>>
>> Correct, pretty much every fan controller is implemented that way.
>> I don't understand the logic.
>>
> 
> Hi Krzysztof and Guenter,
> 
> Apologies for any confusion earlier.
> So, you think that the implementation with 16 instances of TACH/PWM
> device nodes in dts instead of one is ok to you, right?
> 

Did I say that ? No, it is not ok with me. It is confusing and doesn't make
sense to me. This is one fan controller with 16 channels, not 16 separate
controllers.

Guenter

