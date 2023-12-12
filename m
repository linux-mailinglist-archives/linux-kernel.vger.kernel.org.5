Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCBE80E676
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjLLIni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjLLIng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:43:36 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57198A1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:43:42 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c3f68b649so30524815e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702370621; x=1702975421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCwIaPG18IlZaPGE6LfSCnWOUQMM+WHpG8E21UYkoJA=;
        b=WERJZuafQW7j/TkPM5AffkBdaasbIZFl9ZHyNNP8wrUMceGt8JDLH5dshncTh8QOYe
         Z4r/eg6RrcJ76oCbaj94YHrjlpNz9AeKVk5C+nXuMByGlVHtp9H51oGwd7xbprAxKUVC
         RYeZx3ursJ4VC2sTeRsf92yQXA7kObqcl6JKspAteB99lVsMhuyG28OigbAB48nrH+iX
         ggv2a3qdfd3pNA5EaPq4wXcWcW96wPx+uv4s2hnWAsW7B4NjOqP2k+YoTb5v+a0kK3K0
         kbksbG7PIV8RhaQ9rwlsO0jn6x4q3hw3GnZZsGxQ498EblUJc7jcmsxpL/pBtx6Vun3M
         t+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702370621; x=1702975421;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCwIaPG18IlZaPGE6LfSCnWOUQMM+WHpG8E21UYkoJA=;
        b=K1WpPPggGlzLZhVwg3l53kbHlEgRFqC/rC0CJ4v38TX9BvJqhe1qOsbYqWAqLFQZ2X
         678eqELfm39ukmeSCsYyqmqvUxPF/RV4j2uvIhSeUIiF5e6eknjIRi5zbFy+zaRFUATi
         KRaXxeIMeolmPlHOpFYJKYjMHnNH3XQm3dhQenkdCdJcc9DqHWoYiE9lpEokDNxBfw3Z
         4a00ejHvILu74fM1sYRAKSjKx/iLTa+Fy2DuG12QW8ducUTWEQY8MarK4XG5m0yoVwoA
         pXrOfG4sNTi/IhLCyYIQ9ou3YUaiOcIDB5QhvdxCcZ3Lv6/wa0n9JYcRUU2zLxMHjemc
         hM9g==
X-Gm-Message-State: AOJu0YzXadGWOi17YWWT2rEaM/H8tpW2Ni+POV17TG27SVmAlCqVGJ5v
        vhkpa/3idBrzoF1EoNWFPWMprA==
X-Google-Smtp-Source: AGHT+IEOh5cRXARBdKt6ygYMhgJIHQ0YSMV4AkJkVu8QHu7IL2UTMXCadXGm3UFAUSLrFATweQuB/A==
X-Received: by 2002:a05:600c:4384:b0:40c:2417:3b51 with SMTP id e4-20020a05600c438400b0040c24173b51mr2117769wmn.74.1702370620788;
        Tue, 12 Dec 2023 00:43:40 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d56c3000000b003334520e49bsm10326308wrw.53.2023.12.12.00.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 00:43:40 -0800 (PST)
Message-ID: <e8c60424-21c7-4f64-9e47-8c4183510162@linaro.org>
Date:   Tue, 12 Dec 2023 09:43:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 16/16] riscv: dts: starfive: jh8100: Add clocks and
 resets nodes
Content-Language: en-US
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "conor@kernel.org" <conor@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "emil.renner.berthing@canonical.com" 
        <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
 <20231206115000.295825-17-jeeheng.sia@starfivetech.com>
 <4dd53599-5e80-4a00-a708-507c9c2e7b6b@linaro.org>
 <62705afb652e416695aa26e3bdb2500e@EXMBX066.cuchost.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <62705afb652e416695aa26e3bdb2500e@EXMBX066.cuchost.com>
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

On 12/12/2023 03:58, JeeHeng Sia wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Saturday, December 9, 2023 1:57 AM
>> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>; kernel@esmil.dk; conor@kernel.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu;
>> mturquette@baylibre.com; sboyd@kernel.org; p.zabel@pengutronix.de; emil.renner.berthing@canonical.com; Hal Feng
>> <hal.feng@starfivetech.com>; Xingyu Wu <xingyu.wu@starfivetech.com>
>> Cc: linux-riscv@lists.infradead.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-clk@vger.kernel.org; Leyfoon Tan
>> <leyfoon.tan@starfivetech.com>
>> Subject: Re: [PATCH v1 16/16] riscv: dts: starfive: jh8100: Add clocks and resets nodes
>>
>> On 06/12/2023 12:50, Sia Jee Heng wrote:
>>> Add SYSCRG/SYSCRG-NE/SYSCRG-NW/SYSCRG-SW/AONCRG clock and reset
>>> nodes for JH8100 RISC-V SoC.
>>>
>>> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
>>> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
>>
>> Really? Looks automated... Care to provide any links to effects of
>> internal review?
> https://gitlab.starfivetech.com/jeeheng.sia/linux/-/commits/JH8100_Upstream/
>>
>>> ---
>>>  arch/riscv/boot/dts/starfive/jh8100-clk.dtsi | 180 +++++++++++++++++++
>>>  arch/riscv/boot/dts/starfive/jh8100.dtsi     | 115 ++++++++++++
>>>  2 files changed, 295 insertions(+)
>>>  create mode 100644 arch/riscv/boot/dts/starfive/jh8100-clk.dtsi
>>>
>>> diff --git a/arch/riscv/boot/dts/starfive/jh8100-clk.dtsi b/arch/riscv/boot/dts/starfive/jh8100-clk.dtsi
>>> new file mode 100644
>>> index 000000000000..27ba249f523e
>>> --- /dev/null
>>> +++ b/arch/riscv/boot/dts/starfive/jh8100-clk.dtsi
>>> @@ -0,0 +1,180 @@
>>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>>> +/*
>>> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
>>> + */
>>> +
>>> +/ {
>>> +	clk_osc: clk_osc {
>>
>> No underscores in node names.
> Noted.
>>
>>> +		compatible = "fixed-clock";
>>> +		#clock-cells = <0>;
>>> +		clock-frequency = <24000000>;
>>> +	};
>>> +
>>
>> ...
>>
>>> diff --git a/arch/riscv/boot/dts/starfive/jh8100.dtsi b/arch/riscv/boot/dts/starfive/jh8100.dtsi
>>> index f26aff5c1ddf..9863c61324a0 100644
>>> --- a/arch/riscv/boot/dts/starfive/jh8100.dtsi
>>> +++ b/arch/riscv/boot/dts/starfive/jh8100.dtsi
>>> @@ -4,6 +4,9 @@
>>>   */
>>>
>>>  /dts-v1/;
>>> +#include <dt-bindings/clock/starfive,jh8100-crg.h>
>>> +#include <dt-bindings/reset/starfive,jh8100-crg.h>
>>> +#include "jh8100-clk.dtsi"
>>>
>>>  / {
>>>  	compatible = "starfive,jh8100";
>>> @@ -357,6 +360,104 @@ uart4: serial@121a0000  {
>>>  			status = "disabled";
>>>  		};
>>>
>>> +		syscrg_ne: syscrg_ne@12320000 {
>>
>> clock-controller@
>>
>> Just open your bindings and take a look how it is done there...
>>
>> This applies everywhere

I assume you did not ignore all the other comments you did not respond to.

Best regards,
Krzysztof

