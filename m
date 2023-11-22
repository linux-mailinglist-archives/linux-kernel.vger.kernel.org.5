Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A5A7F49E7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344340AbjKVPKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344039AbjKVPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:10:12 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD5A11F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:10:08 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-778927f2dd3so347495985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700665807; x=1701270607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tg8v0wjgB6LXPnF0igxmM4a2qP5aiK535KGZNUnjRw=;
        b=b5i0gmLuO7KgYH1gQQSLuz0OjuW+d0MWOiV2nOf7BKd9G7OqGTWAYFsz6f/as/jxxm
         EokEqU9aZuuzENZsrFtuJH4NWXCu573KICZN85C40MwC75LZi/baZI1j9DXSDw4hPZIh
         CG+egyK1V13w3QhWsMCBozBS7ijS2eXbTK3MSMri2/Sjq3uAvhyop3RzJ9xyzOs7on/U
         /TnYBKzJwjhlOVYfkcscTXuaKwLqZlLajtmDu3xcTYWcBbVymr1YkK5H+kalKzrfWKNd
         V2QmhN/N8itZ8dlCGrRcNtM68hBkZLNyZa4qoyi9s887KVxlO9nTWKUfkXCJlYj9yF+k
         I3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700665807; x=1701270607;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tg8v0wjgB6LXPnF0igxmM4a2qP5aiK535KGZNUnjRw=;
        b=LmOdf8jtZufB0DUEsw8DEZxwt1grRfYN4waFSNosHLnTnVQzizq6MqE6aUmEbFgAjs
         8/yz5tNAPR0ox962zlsU1Emo3fAF5FlCuFGzmN4nRin2sfx4qvQT+0gGK9MUOnDgJAPL
         TSHQp10J7fjAVyuTU5DxL9oHOBkgKuFzDg0i90xcTOPbm/U7rSMOfhNmkagV0K+8InBf
         SXJZoZLKUAaT5dSX0IJfYvXXqWPBY4do2rzKhcd1asq8o4jNL6ba9X9FVxpTFtmIT7ee
         6q4MDdXeoHgfwQ7I9vuxE/VMpL/lw1OKDBQv8787rzNsRy6L5pyhDnyJTTBAmEORFxs8
         B3Ng==
X-Gm-Message-State: AOJu0YxPoTTiO+ddCaJz9n4PsAugjsYLOcvrQ6HOO/7RjthTybp8IAUq
        LekNpPZL1Gg9wT6a3sTvhQYtsA==
X-Google-Smtp-Source: AGHT+IEuFT6h2b6jLXcvAMUG78/b/s/0PQ98pgAIrmfCulB9BuSVvha7x2D+Hk3/bEppyd5PyhrAEw==
X-Received: by 2002:a05:620a:4482:b0:775:985e:f5c2 with SMTP id x2-20020a05620a448200b00775985ef5c2mr2681917qkp.17.1700665807502;
        Wed, 22 Nov 2023 07:10:07 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id b3-20020ac86783000000b004196a813639sm4480285qtp.17.2023.11.22.07.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 07:10:07 -0800 (PST)
Message-ID: <8a3a44b4-adef-4872-b08e-fbde3f563858@linaro.org>
Date:   Wed, 22 Nov 2023 16:10:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm: dts: amlogic: migrate pwms to new meson8 v2
 binding
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        JunYi Zhao <junyi.zhao@amlogic.com>
References: <20231117125919.1696980-1-jbrunet@baylibre.com>
 <20231117125919.1696980-6-jbrunet@baylibre.com>
 <f04d8ad1-4411-4334-8d22-0aa757bf227c@linaro.org>
 <1jsf4xeskb.fsf@starbuckisacylon.baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1jsf4xeskb.fsf@starbuckisacylon.baylibre.com>
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

On 22/11/2023 15:52, Jerome Brunet wrote:
> 
> On Wed 22 Nov 2023 at 09:39, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 17/11/2023 13:59, Jerome Brunet wrote:
>>> Update Amlogic based SoC PWMs to meson8-pwm-v2 compatible
>>
>> Why? Your commit msg must explain this. You break users of this DTS on
>> older kernels and also this makes it impossible to apply via different
>> branches in the same cycle. All this needs explanation and proper
>> justification. Your message tells here nothing, because "what" is quite
>> obvious.
>>
> 
> I provided all the explanation possible through the different commits of
> this series. I can re-state here if it helps

DTS commits stand on their own and must not go via same branch as
driver, so how does driver commit msg help Git history?

> 
>>>
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>> ---
>>>  arch/arm/boot/dts/amlogic/meson.dtsi           |  4 ++--
>>>  arch/arm/boot/dts/amlogic/meson8.dtsi          | 16 +++++++++++++---
>>>  arch/arm/boot/dts/amlogic/meson8b-ec100.dts    |  2 --
>>>  arch/arm/boot/dts/amlogic/meson8b-mxq.dts      |  2 --
>>>  arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts |  2 --
>>>  arch/arm/boot/dts/amlogic/meson8b.dtsi         | 16 +++++++++++++---
>>>  6 files changed, 28 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/amlogic/meson.dtsi b/arch/arm/boot/dts/amlogic/meson.dtsi
>>> index 8e3860d5d916..80cc004ad5fe 100644
>>> --- a/arch/arm/boot/dts/amlogic/meson.dtsi
>>> +++ b/arch/arm/boot/dts/amlogic/meson.dtsi
>>> @@ -83,14 +83,14 @@ i2c_A: i2c@8500 {
>>>  			};
>>>  
>>>  			pwm_ab: pwm@8550 {
>>> -				compatible = "amlogic,meson-pwm";
>>> +				compatible = "amlogic,meson8-pwm-v2";
>>
>> That's breaking users of this DTS (old kernel, out of tree, other
>> projects) for no real reasons without explanation.
> 
> "amlogic,meson-pwm" will continue to match, meaning of bindings is unchanged

No, because new DTS does not have amlogic,meson-pwm, thus all existing
users see breakage.

> 
> How do you propose to fix badly designed bindings then ?

Justify and introduce incompatible changes, breaking the ABI. Anyway
this is a requirement, because, as I said in other reply, you cannot
have compatible for software model!

> 
> if we cant even introduce a new compatible to fix things up. It is supposed to
> stay and broken till the end of time ?

No, you cannot introduce new compatible for new OS.

Fix the bindings instead with proper justification. We did it many
times, what's the problem here?

Best regards,
Krzysztof

