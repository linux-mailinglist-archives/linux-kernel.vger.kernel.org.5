Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1946C7B6299
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjJCHjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjJCHi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:38:58 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0C090
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:38:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-405361bb94eso6324985e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 00:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696318732; x=1696923532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2zaEJuMhIXZx+nYYP28IqzkKzzc2Oq+CJMYbt4pRr4=;
        b=XpDqpWyUIouN9riV7lhbA22P+Io2ohpQcibw2tSiJUE2VW+DgErkR7CFO1VWVgrwlR
         jzmuk83YLqklHDA9X/IaqhTuk9POeqFoPgeUPMYF+21MFuP33uOqDa6GzICfqIJHVOgG
         dzKffwvd9iw/i1VLT6mxb2/xHnD6jdypH6IbDzytCRufI6M+NbAYyu6vHk1zchPsZD9c
         SIVvp3Hha69rpNnpWkio/P1VhPsu7lnnETBvZO7h9WgZFYHqs1KUdSV0VHLAKOEknoc3
         N88Sv0NSj4jFl4b0a2/HaRLRSRtkZGC0empAZfoC10u0lA/fIJFl0gLOOCuKjTMkoIVu
         L8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696318732; x=1696923532;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/2zaEJuMhIXZx+nYYP28IqzkKzzc2Oq+CJMYbt4pRr4=;
        b=staNDv7T59F0sifAOdDE3vcWdqmLpFiL+TE1HqP1F2XnvVUCbrtX/VqUsskdLwkkaI
         sqMOlqsCUR02cKIvb7nNSj/DyJgzxOwthVd8ub02XaN8LXuGgCdFO4e4Mrcz94bQMCra
         gNMQA0skSpyfXdtkjB80649KRFPPmoN+GS1Kbml70M/vgaHhgCiJlGiQ/85m0i4eekAo
         ic5a3I3LaNlNWyoJHij6KxoFYVGaQo3FwjqhH+BFquf4Y8wZXWUtY+t9uWQtcweo+HyQ
         Tygsi2YC8DuKFUt3NfMDWWOfmgN4mzMS8knXtlaKI1302TIgqqNg3pa5/yB6Yid2+/Md
         dTvg==
X-Gm-Message-State: AOJu0YzA9+miSoz14qRhHe1+R33+y+gRBkU+P1oIcZyijeT3pIWaUi0x
        dgkJlnXv/S0M7PgLMKeKtELBnA==
X-Google-Smtp-Source: AGHT+IG6ZuhB5Ba66MQyZQ1zB2heVFV/sP35jhRiX5ppQH8wYVBmIaBHmHpdMC5YHNEH4K3Ugp199Q==
X-Received: by 2002:a7b:ce98:0:b0:3fe:2bb1:11ba with SMTP id q24-20020a7bce98000000b003fe2bb111bamr12780977wmj.27.1696318732102;
        Tue, 03 Oct 2023 00:38:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e31a:fe1c:e925:9858? ([2a01:e0a:982:cbb0:e31a:fe1c:e925:9858])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600012c700b0031c52e81490sm884647wrx.72.2023.10.03.00.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 00:38:51 -0700 (PDT)
Message-ID: <57059b74-9442-4657-a4ef-22a84d228356@linaro.org>
Date:   Tue, 3 Oct 2023 09:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] arm64: dts: amlogic: add libretech cottonwood support
Content-Language: en-US, fr
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Da Xue <da@lessconfused.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Da Xue <da.xue@libretech.co>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-amlogic@lists.infradead.org
References: <20231002141020.2403652-1-jbrunet@baylibre.com>
 <20231002141020.2403652-3-jbrunet@baylibre.com>
 <b81a296d-0640-4b2e-aab6-c9de37d10206@linaro.org>
 <1j5y3ozvmk.fsf@starbuckisacylon.baylibre.com>
 <CACdvmAgzBxja-oJkS9c88=P0Wmc1ptkJExz6YjaJUyyv6yxh0Q@mail.gmail.com>
 <DF61DA82-29E4-4504-B548-14F880A6221E@gmail.com>
 <1j1qecyxt4.fsf@starbuckisacylon.baylibre.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <1j1qecyxt4.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2023 09:21, Jerome Brunet wrote:
> 
> On Tue 03 Oct 2023 at 05:23, Christian Hewitt <christianshewitt@gmail.com> wrote:
> 
>>> On 3 Oct 2023, at 1:15 am, Da Xue <da@lessconfused.com> wrote:
>>>
>>> On Tue, Oct 3, 2023 at 3:13 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>>>>
>>>>
>>>> On Mon 02 Oct 2023 at 18:45, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> On 02/10/2023 16:10, Jerome Brunet wrote:
>>>>>> Add support for the Libretech cottonwood board family.
>>>>>> These 2 boards are based on the same PCB, with an RPi B form factor.
>>>>>> The "Alta" board uses an a311d while the "Solitude" variant uses an
>>>>>> s905d3.
>>>>>> Co-developed-by: Da Xue <da.xue@libretech.co>
>>>>>> Signed-off-by: Da Xue <da.xue@libretech.co>
>>>>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>>>>> ---
>>>>>>   arch/arm64/boot/dts/amlogic/Makefile          |   2 +
>>>>>>   .../amlogic/meson-g12b-a311d-libretech-cc.dts | 133 ++++
>>>>>>   .../amlogic/meson-libretech-cottonwood.dtsi   | 610 ++++++++++++++++++
>>>>>>   .../amlogic/meson-sm1-s905d3-libretech-cc.dts |  89 +++
>>>>>>   4 files changed, 834 insertions(+)
>>>>>>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts
>>>>>>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
>>>>>>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dts
>>>>>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile
>>>>>> b/arch/arm64/boot/dts/amlogic/Makefile
>>>>>> index 4ce401d17b63..cc8b34bd583d 100644
>>>>>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>>>>>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>>>>>> @@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12b-bananapi-cm4-cm4io.dtb
>>>>>>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gsking-x.dtb
>>>>>>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
>>>>>>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
>>>>>> +dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-libretech-cc.dtb
>>>>>>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-go-ultra.dtb
>>>>>>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2-plus.dtb
>>>>>>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
>>>>>> @@ -73,6 +74,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m2-pro.dtb
>>>>>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m5.dtb
>>>>>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-h96-max.dtb
>>>>>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
>>>>>> +dtb-$(CONFIG_ARCH_MESON) += meson-sm1-s905d3-libretech-cc.dtb
>>>>>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
>>>>>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
>>>>>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
>>>>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts
>>>>>> new file mode 100644
>>>>>> index 000000000000..fc890e235dbd
>>>>>> --- /dev/null
>>>>>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts
>>>>>> @@ -0,0 +1,133 @@
>>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>>> +/*
>>>>>> + * Copyright (c) 2023 BayLibre, SAS.
>>>>>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>>>>>> + */
>>>>>> +
>>>>>> +/dts-v1/;
>>>>>> +
>>>>>> +#include <dt-bindings/clock/g12a-clkc.h>
>>>>>> +#include "meson-g12b-a311d.dtsi"
>>>>>> +#include "meson-libretech-cottonwood.dtsi"
>>>>>> +
>>>>>> +/ {
>>>>>> +    compatible = "libretech,aml-a311d-cc", "amlogic,a311d", "amlogic,g12b";
>>>>>> +    model = "Libre Computer AML-A311D-CC Alta";
>>>>>> +
>>>>>> +    vddcpu_a: regulator-vddcpu-a {
>>>>>> +            compatible = "pwm-regulator";
>>>>>> +            regulator-name = "VDDCPU_A";
>>>>>> +            regulator-min-microvolt = <730000>;
>>>>>> +            regulator-max-microvolt = <1011000>;
>>>>>> +            regulator-boot-on;
>>>>>> +            regulator-always-on;
>>>>>> +            pwm-supply = <&dc_in>;
>>>>>> +            pwms = <&pwm_ab 0 1250 0>;
>>>>>> +            pwm-dutycycle-range = <100 0>;
>>>>>> +    };
>>>>>> +
>>>>>> +    sound {
>>>>>> +            model = "Alta";
>>>>>
>>>>> I think those sound model properties should be coherent with the
>>>>> other Libre Computer boards:
>>>>> arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi:         model = "LIBRETECH-PC";
>>>>> arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts:           model = "LIBRETECH-AC";
>>>>> arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts:                model = "LIBRETECH-CC-V2";
>>>>> arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts:           model = "LIBRETECH-CC";
>>>>
>>>> "LIBRETECH-CC-" leave very little room to play with
>>>> That's not really something that could have been anticipated 5+ years ago
>>>>
>>>
>>> I think the formal model name is best, maybe with LC prefix.
>>> eg. LC-AML-A311D-CC and LC-AML-S905D3-CC
>>
>> The first is valid. The second will be truncated to LC-AML-S905D3-C by the
>> alsa 15-character naming limit (mentioned below).
>>
>> So name/rename them to:
>>
>> LC-XXXXXXXXXXXX <= MAX SIZE (15 Chars)
>> LC-LEPOTATO
>> LC-LEPOTATO-V2
>> LC-LAFRITE
>> LC-TARTIFLETTE
>> LC-ALTA
>> LC-SOLITUDE
>>
>> Personally I think the plain codenames (no "LC-“) work best as they are all
>> distinctive. Whenever I see lists of the official board names they look/read
>> the same at first glance and then I have to spot-the-difference to tell them
>> apart.
>>
>> At the moment AFAIK these names are just cosmetic as there’s no Amlogic alsa
>> ucm confs using board model (only downstream confs based on driver name). So
>> IMHO rework the names now before the confs go upstream.
>>
> 
> No they are not cosmetic. It can be used to match the card.
> Changing old names may break userspace.

We changed them already because there was a clash from the 15 characters max width,
but now it's different.

So I think it's time to start a new clean scheme for the future LC boards, so:
LC-ALTA
LC-SOLITUDE

seems ok for me.

Using LC-AML-A311D-CC and LC-AML-S905D3-CC goes beyond the 15 chars limit.

Neil

> 
>> CH.
>>
>>> https://hub.libre.computer/t/libre-computer-board-naming-and-conventions/100
>>>
>>>>>
>>>>> It's ok to change the scheme since it's tried to keep the name under the 15 characters limit,
>>>>> will the next board keep this naming ?
>>>>
>>>> I don't know what the next board will be so I can hardly make any prediction
>>>> I'm open to suggestion if you prefer something else
>>>>
>>>>>
>>>>>
>>>>>> +            audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
>>>>>> +                            "TDMOUT_A IN 1", "FRDDR_B OUT 0",
>>>>>> +                            "TDMOUT_A IN 2", "FRDDR_C OUT 0",
>>>>>> +                            "TDM_A Playback", "TDMOUT_A OUT",
>>>>>> +                            "TDMOUT_B IN 0", "FRDDR_A OUT 1",
>>>>>> +                            "TDMOUT_B IN 1", "FRDDR_B OUT 1",
>>>>>> +                            "TDMOUT_B IN 2", "FRDDR_C OUT 1",
>>>>>> +                            "TDM_B Playback", "TDMOUT_B OUT",
>>>>>> +                            "TDMOUT_C IN 0", "FRDDR_A OUT 2",
>>>>>> +                            "TDMOUT_C IN 1", "FRDDR_B OUT 2",
>>>>>> +                            "TDMOUT_C IN 2", "FRDDR_C OUT 2",
>>>>>> +                            "TDM_C Playback", "TDMOUT_C OUT",
>>>>>> +                            "TDMIN_A IN 0", "TDM_A Capture",
>>>>>> +                            "TDMIN_B IN 0", "TDM_A Capture",
>>>>>> +                            "TDMIN_C IN 0", "TDM_A Capture",
>>>>>> +                            "TDMIN_A IN 3", "TDM_A Loopback",
>>>>>> +                            "TDMIN_B IN 3", "TDM_A Loopback",
>>>>>> +                            "TDMIN_C IN 3", "TDM_A Loopback",
>>>>>> +                            "TDMIN_A IN 1", "TDM_B Capture",
>>>>>> +                            "TDMIN_B IN 1", "TDM_B Capture",
>>>>>> +                            "TDMIN_C IN 1", "TDM_B Capture",
>>>>>> +                            "TDMIN_A IN 4", "TDM_B Loopback",
>>>>>> +                            "TDMIN_B IN 4", "TDM_B Loopback",
>>>>>> +                            "TDMIN_C IN 4", "TDM_B Loopback",
>>>>>> +                            "TDMIN_A IN 2", "TDM_C Capture",
>>>>>> +                            "TDMIN_B IN 2", "TDM_C Capture",
>>>>>> +                            "TDMIN_C IN 2", "TDM_C Capture",
>>>>>> +                            "TDMIN_A IN 5", "TDM_C Loopback",
>>>>>> +                            "TDMIN_B IN 5", "TDM_C Loopback",
>>>>>> +                            "TDMIN_C IN 5", "TDM_C Loopback",
>>>>>> +                            "TODDR_A IN 0", "TDMIN_A OUT",
>>>>>> +                            "TODDR_B IN 0", "TDMIN_A OUT",
>>>>>> +                            "TODDR_C IN 0", "TDMIN_A OUT",
>>>>>> +                            "TODDR_A IN 1", "TDMIN_B OUT",
>>>>>> +                            "TODDR_B IN 1", "TDMIN_B OUT",
>>>>>> +                            "TODDR_C IN 1", "TDMIN_B OUT",
>>>>>> +                            "TODDR_A IN 2", "TDMIN_C OUT",
>>>>>> +                            "TODDR_B IN 2", "TDMIN_C OUT",
>>>>>> +                            "TODDR_C IN 2", "TDMIN_C OUT",
>>>>>> +                            "Lineout", "ACODEC LOLP",
>>>>>> +                            "Lineout", "ACODEC LORP";
>>>>>> +    };
>>>>>> +};
>>>>>> +

<snip>

