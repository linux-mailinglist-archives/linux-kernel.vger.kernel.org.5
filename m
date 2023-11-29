Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0617FD2FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjK2Jlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjK2Jlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:41:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87BE1998;
        Wed, 29 Nov 2023 01:41:42 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-285b88b9917so2808531a91.1;
        Wed, 29 Nov 2023 01:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701250902; x=1701855702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EQNEFsWHsZRWCwYLGHFgRX0do5+liJ+UIAaNWpJ61ok=;
        b=A0hWP0EJJOStSSy8weaLobar7GUc248SlHAXbFaLM92tU3B0Zs+C0imMVBMxayvYoS
         y9JlE+DiDIrphWYwJtr4CZa52LoN5vK2G0QaflPunTpH5ZG6BsZUjv9+Gy+Rre7GiCvr
         DghoSW71sDJojv+/JfUYvoUaQBWj9xImlOXy4go7lOSidzHcPoNs03OBTBar0Td174hU
         rStvGvcuyheN81CgGX+v+UBW+wlkCwV+oEp1PWlJC2O6TZgcmoWXLIEZadnUiD5rypz4
         vALuTibRPE6ifO+1tVqurjv9owTufv42EgmzoCC7zgDdDnmvd5+dihuCnPrRzb/C+gIU
         Y6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701250902; x=1701855702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQNEFsWHsZRWCwYLGHFgRX0do5+liJ+UIAaNWpJ61ok=;
        b=JY+tpNEfVaKD5/hkl9y4/3XikVuyTORFn3ToY9JQGCa5X/onQ1u0/Iw2HmNbBtm1ii
         Nn7HOVlq6oI/AfaxB7XACh3IsVV9VGzZG6yzBMMZbsbCyS7U0Ir/sPtUbkQUA88dWCM+
         A0jhhPtK/YQhfj7JJXWwWogmx0wfSbd4uIqIL+C9E5hiekWqPzzCUG97Nxe7rGJ1KNt2
         16OPoJuv4X0MN5oV4qmi9fGr6aPXK35kQJZnXLkaB/wy1EOM3sfkLyrbwjQo7f860Q//
         PgPtQR1mrlWe/vBFP88vXgkoCevv5qux+16ZOib1fN9YNi65ZIXEzYcWHt3yg/tguT0I
         qmeQ==
X-Gm-Message-State: AOJu0YzL4kSOfvqYj/cg3WPZbuFxa3TgP7ywrrAdt0frasb+xQ9E+3JC
        q6foP/ZM+PukxoMD2Mr/24k=
X-Google-Smtp-Source: AGHT+IFIUAMtaYPdy5RnRVfUH0pKxDBacYW354Bc+S/FigwG2ezbs33hnbDN3bsL12JW5T5Im8lPew==
X-Received: by 2002:a17:90b:380b:b0:285:da91:69d3 with SMTP id mq11-20020a17090b380b00b00285da9169d3mr7774153pjb.49.1701250901992;
        Wed, 29 Nov 2023 01:41:41 -0800 (PST)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id lj13-20020a17090b344d00b00285be64e529sm925899pjb.39.2023.11.29.01.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 01:41:41 -0800 (PST)
Message-ID: <4b00c41c-7751-40ca-bf2d-53f1179772d4@gmail.com>
Date:   Wed, 29 Nov 2023 17:41:37 +0800
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
 <8663d26e-32b8-4f2b-b497-9efa7440f070@gmail.com>
 <2fab32e6-23a4-41bb-b47b-4f993fc590dc@linaro.org>
 <ff83f0f2-541a-4677-a247-5f47fdcca3f1@gmail.com>
 <db3ede63-8708-469f-8e7b-aca798ed50e0@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <db3ede63-8708-469f-8e7b-aca798ed50e0@linaro.org>
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


On 2023/11/29 下午 04:11, Krzysztof Kozlowski wrote:
> On 29/11/2023 04:35, Jacky Huang wrote:
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>> Yes, it did pass the 'dtbs_check'. I guess the tool does not detect such
>>>> issues.
>>>> Anyway, I will fix it in the next version.
>>> Hm, I see your bindings indeed allow pin-.* and unit addresses, so it is
>>> the binding issue.
>>>
>>> The examples you used as reference - xlnx,zynqmp-pinctrl.yaml and
>>> realtek,rtd1315e-pinctrl.yaml - do not mix these as you do.
>>>
>>> I don't understand why do you need them yet. I don't see any populate of
>>> children. There are no compatibles, either.
>>>
>>> Which part of your driver uses them exactly?
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> I will move the 'pcfg_default: pin-default' from dtsi to dts, like this:
>>
>> &pinctrl {
>>       pcfg_default: pin-default {
>>           slew-rate = <0>;
>>           input-schmitt-disable;
>>           bias-disable;
>>           power-source = <1>;
>>           drive-strength = <17100>;
>>       };
> This solves nothing. It's the same placement.
>
>
> Best regards,
> Krzysztof
>

OK, it stil be the binding issues.
For "^pin-[a-z0-9]+$", I reference to the "pcfg-[a-z0-9-]+$" of 
rockchip,pinctrl.yaml.

My intention is to describe a generic pin configuration, aiming to make 
the pin
description more concise. In actual testing, it proves to be effective.


Best Regards,
Jacky Huang


