Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF517FB867
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjK1KqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344408AbjK1Kpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:45:52 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC911B6;
        Tue, 28 Nov 2023 02:45:59 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cf5901b4c8so45396125ad.1;
        Tue, 28 Nov 2023 02:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701168358; x=1701773158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axHHm0upojX+NkxnTw2dMgh1LmY4IcJLQ0+nxnTcPrI=;
        b=h/zCIiMDIPfLG8+CAu4d01shDJ5nJ1DMKhG2GsvMdbsg8K/cB5u5E1wjA+3+8Lcyrp
         JYPfxWTG+5cmtNV18J9SFsP1L/AO8UVIXsqdJor9e28H+63X9PMH18csXGYCHHISd/eG
         Hs0KxIj8NG5VuDhEHAKaochw6DS+tVh7YuHXQX++mrtCbwUhDazWJHdcE+6Tj/cacVPi
         ZXCH8X7hIyH3kEYwOSvkYm2km7jAx+UIN+qwUUYG51dY02hNM6mT2OQsCnxunDEzqbHl
         O+bs/DrEOavwsFn0BWUuEKfzARRA2Rm6XluQBhzDrl/30XAIoJomTIlV6mYnbNcRcXdz
         JpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701168358; x=1701773158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axHHm0upojX+NkxnTw2dMgh1LmY4IcJLQ0+nxnTcPrI=;
        b=Wvr0VU60yMJomxchy2Vf1rN16uxATz6Y8CFVvctmVTw9y4lYErWIuze+dZHs25NQT7
         ZUFPYj6VghW/J8xKcMY+Yo63bWJG70D4RN1JpRTUcFH6yZ3MJJYNYM0D2HgijnQb//VG
         Rjr9MimfhkFKoTYxEQupXqF8ed1xCbKDzCEPYB2Go4U0pE9s2yFDH2fRgWYrV7E37xyD
         OYGQtOr0TH8QPYVU7EliyWHhW20SzQqOr41x3a5HrICqp2rVcodcbSkFd6e3y3YwHmB0
         oBeTpW1HA43XACTOL5+CXaunQs+N0eMqQfYMwaYESnkOn3WpjN/58G600vU4KoCHYT/f
         0LZw==
X-Gm-Message-State: AOJu0YxGDMHorFKHwkS3VoEr0ZcJ97jQcB4p6t7NtOckFMYuBqHH8b1f
        ls18Vgz+ilE7kbBOndOaCs8=
X-Google-Smtp-Source: AGHT+IE2ryZOAavEOhPVMSyPf+b+1lrzfNk7TtsWvxOd0+20KhYqr6UDYRSkwc1yFEVl2o4BVlXUgw==
X-Received: by 2002:a17:902:7483:b0:1cc:6ec2:d24e with SMTP id h3-20020a170902748300b001cc6ec2d24emr16322324pll.53.1701168358334;
        Tue, 28 Nov 2023 02:45:58 -0800 (PST)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001cf68d103easm6990918plr.46.2023.11.28.02.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:45:57 -0800 (PST)
Message-ID: <8663d26e-32b8-4f2b-b497-9efa7440f070@gmail.com>
Date:   Tue, 28 Nov 2023 18:45:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: nuvoton: Add pinctrl support for
 ma35d1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ychuang3@nuvoton.com, schung@nuvoton.com
References: <20231128061118.575847-1-ychuang570808@gmail.com>
 <20231128061118.575847-4-ychuang570808@gmail.com>
 <7edda3ca-b98a-4125-979f-3ee7ac718a9a@linaro.org>
 <a0be9aaa-290d-450e-b0b8-d87453bcaaa0@gmail.com>
 <7fed5d90-da04-40fb-8677-b807b6f51cc9@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <7fed5d90-da04-40fb-8677-b807b6f51cc9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,

Thanks for your review.

On 2023/11/28 下午 05:34, Krzysztof Kozlowski wrote:
> On 28/11/2023 09:37, Jacky Huang wrote:
>>>> +			gpion: gpio@40040340 {
>>>> +				reg = <0x340 0x40>;
>>>> +				interrupts = <GIC_SPI  105 IRQ_TYPE_LEVEL_HIGH>;
>>>> +				clocks = <&clk GPN_GATE>;
>>>> +				gpio-controller;
>>>> +				#gpio-cells = <2>;
>>>> +				interrupt-controller;
>>>> +				#interrupt-cells = <2>;
>>>> +			};
>>>> +
>>>> +			pcfg_default: pin-default {
>>>> +				slew-rate = <0>;
>>>> +				input-schmitt-disable;
>>>> +				bias-disable;
>>>> +				power-source = <1>;
>>>> +				drive-strength = <17100>;
>>>> +			};
>>> It does not look like you tested the DTS against bindings. Please run
>>> `make dtbs_check W=1` (see
>>> Documentation/devicetree/bindings/writing-schema.rst or
>>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>>> for instructions).
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> I forgot to remove 'ma35d1-pinfunc.h' from my local copy.
>> After remove the '#include <dt-bindings/pinctrl/ma35d1-pinfunc.h>', it
>> can pass
>> the `make dtbs_check W=1` check.
>> I will fix it in the next version.
> Really? Then your bindings look wrong. Why do you mix MMIO nodes and
> non-MMIO in one device node?
>
> Best regards,
> Krzysztof
>

Yes, it did pass the 'dtbs_check'. I guess the tool does not detect such 
issues.
Anyway, I will fix it in the next version.


Best Regards,
Jacky Huang


