Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573737EB180
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjKNOGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjKNOGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:06:21 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A5F18C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:06:17 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4084b0223ccso44099125e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699970776; x=1700575576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrai/sdbc7ZGz/hysCFLS6pOSapKhsTENd3DlRn0qxg=;
        b=J5hhVxcWwBTeZKFT2pGYnN/NobIrCkWzoChkvIuC8bI1z5JioKcL/kAJEzi1/L3/gs
         avsh/qhuSsPPavfSfLk+HkxQDFsHfrjFMVrfWkwyExNC6bsg1+elTvyDEiNfRlKECZLX
         T9QZLE5k8mjRvHfrDmJvnRjbOFPzLZjFnicGxpL/q5pfWXajxHNRn/LL2iUD3y/fmH8h
         +Xfb7ZpUKYDGHjOGKdnFGDQ9K5jGMQVpCwCWajS7b2SeifSfAvvuTgPIVAklqfGQG85q
         ZgArmNS2im4n9NI/2vBPknxfUPp1MOVeJtOa6knZ1dp/fmzKYlM2aPn4TYOqtFPQ6zIO
         bczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699970776; x=1700575576;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jrai/sdbc7ZGz/hysCFLS6pOSapKhsTENd3DlRn0qxg=;
        b=CoFhmwhqm089trRbuzct41BzTD+4rcNa871UIL8Xe6AQYMvBaU5QqEoCn8CWiLEwqI
         v6byOigFQMYRHsMimmp1PFM3mgdmQmGXujzXI9G+oX9/6nd6FpsGJuxnESWKnzXOicCO
         n89l5wdruT7BQNPBziQQW0f6I1vjRj6SaNhvRlY7DxC2l+rjDUjirje9yYWgG3d4dfoB
         z2rOBAj8LLWqvNHXTcuBjD5Bbq7BsvLdyGfw1ffica8tIJTFSyZ6WL6oR4kzAPc4eQQc
         /9gfM5fnDEHHFRMrsKm6alsEtewJlILO6hVyXs7Hx27nLmHWi5iR9dRaSR0yMaHYRpQr
         KsjA==
X-Gm-Message-State: AOJu0Yw9ydrNG9Mbq0Up8laO98AkhmtKaOr1D5FkKtG6RSlTSBIBZnpu
        NJ03yXRUDb+EqplhS7sUyZ5rZQ==
X-Google-Smtp-Source: AGHT+IGlem3kpd2X8ZlXv4Krn4u2fmtehWx3hmyYlycOZ7Roa+TUkZU62aQgD9nsCpgXZU089vjG5g==
X-Received: by 2002:a05:600c:474e:b0:401:b2c7:34a8 with SMTP id w14-20020a05600c474e00b00401b2c734a8mr8235339wmo.7.1699970775714;
        Tue, 14 Nov 2023 06:06:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a90d:d9d5:9399:5adf? ([2a01:e0a:982:cbb0:a90d:d9d5:9399:5adf])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600c330900b0040a3f9862e3sm627965wmp.1.2023.11.14.06.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 06:06:15 -0800 (PST)
Message-ID: <1fd6bc47-0044-44c8-ac53-b9b7262606b1@linaro.org>
Date:   Tue, 14 Nov 2023 15:06:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v8 02/12] dt-bindings: soc: amlogic,meson-gx-hhi-sysctrl:
 add example covering meson-axg-hhi-sysctrl
Content-Language: en-US, fr
To:     Rob Herring <robh@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
References: <20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-0-81e4aeeda193@linaro.org>
 <20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-2-81e4aeeda193@linaro.org>
 <20231110201223.GA347493-robh@kernel.org>
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
In-Reply-To: <20231110201223.GA347493-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2023 21:12, Rob Herring wrote:
> On Thu, Nov 09, 2023 at 10:00:03AM +0100, Neil Armstrong wrote:
>> Add a thirst example covering the meson-axg-hhi-sysctrl variant and more
>> importantly the phy subnode.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  | 41 ++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
>> index 16977e4e4357..2edf4ccea845 100644
>> --- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
>> +++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
>> @@ -158,3 +158,44 @@ examples:
>>               };
>>           };
>>       };
>> +
> 
> New example should be separate starting with a '-|'.
> 
>> +    bus@ff63c000 {
>> +        compatible = "simple-bus";
>> +        reg = <0xff63c000 0x1c00>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges = <0x0 0xff63c000 0x1c00>;
> 
> Why do you need all this? 1 cell is the default for examples.

Bad copy-pasta from previous examples, I'll fix all that and separate examples with '-|'

> 
>> +
>> +        system-controller@0 {
>> +            compatible = "amlogic,meson-axg-hhi-sysctrl", "simple-mfd", "syscon";
>> +            reg = <0 0x400>;
>> +
>> +            clock-controller {
>> +                compatible = "amlogic,axg-clkc";
>> +                #clock-cells = <1>;
>> +                clocks = <&xtal>;
>> +                clock-names = "xtal";
>> +            };
>> +
>> +            power-controller {
>> +                compatible = "amlogic,meson-axg-pwrc";
>> +                #power-domain-cells = <1>;
>> +                amlogic,ao-sysctrl = <&sysctrl_AO>;
>> +
>> +                resets = <&reset_viu>,
>> +                         <&reset_venc>,
>> +                         <&reset_vcbus>,
>> +                         <&reset_vencl>,
>> +                         <&reset_vid_lock>;
>> +                reset-names = "viu", "venc", "vcbus", "vencl", "vid_lock";
>> +                clocks = <&clk_vpu>, <&clk_vapb>;
>> +                clock-names = "vpu", "vapb";
>> +            };
>> +
>> +            phy {
>> +                compatible = "amlogic,axg-mipi-pcie-analog-phy";
>> +                #phy-cells = <0>;
>> +                status = "disabled";
> 
> Examples should not be disabled.

Err, thx I 'll fix this

> 
>> +            };
>> +        };
>> +    };
>>
>> -- 
>> 2.34.1
>>

