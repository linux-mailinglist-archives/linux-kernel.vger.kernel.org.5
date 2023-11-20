Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB807F0D87
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjKTI2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjKTI1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:27:52 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10417107
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:27:48 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c5028e5b88so55609931fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700468866; x=1701073666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zUGH0c4GY6lD98Q6lqE8V3ux67qaNFVeyeN6TZqzhM=;
        b=pvTkfhkRIe6IGoueGgn1c+GH1ywYThIZ1yDt8r+/UiBd3FRoh41iTPvtnXJIJCVlXi
         dhQ01jfX6LaEuLcbA8yU4R+LS4AEEHwjF6iqnDFUP2Jr6JbY7gHcKTgbXh2sSY697CVN
         kGDzMCIxs82dx8yjegUMBHO5bzayUhjJyniQ+X2D6vVpms90Y3oA6ws5n3Wawe3x65Nw
         Jm3Mr9RnLVRKFblec9I6xxI1d4SGhZBEfXBrUd/dE0TWJRUWqrKB+F7ZTq4L3BS1DxIX
         jYEkf19E7XRyQUh2YHoCuq7iSyclgkO/GgY27SLtNheHHmVgR6qLjgOzJEO12+B+UbZj
         G4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700468866; x=1701073666;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3zUGH0c4GY6lD98Q6lqE8V3ux67qaNFVeyeN6TZqzhM=;
        b=lUVhizM0/9kly16lqKRmjDaA3ro+8WQhOJW8bymbtePwnC0LjQKRHjPWg/3QqnuvK1
         ZK3CsfM5rWSiojBc92iYwpf92L7oBPPDpM3BKYi7rL9texsj9ydu9Wo1z7F4dQzcQ0x5
         Tx7MfL49VyXU6EARXOnnKNVMq4orVIj6wWpsJ+mYwWBFigPGaJ5MQegggppiMQQyYiza
         R2RVr4gmdgzsxa/0o7hD6vnY8jD75TmV26iJruNRsNW3k5yUgIbYym32QFOKQo6rcW6Q
         FqUNPBZfnI/dEWs+oxNJgZlhZ4sR/M9Zi6cs0ZFqASq2xtkvyQ/jFsn7iCzEEKts/utK
         gHWw==
X-Gm-Message-State: AOJu0YwGVbqImB2oFLvJLfCFVgdG1OFYERH8V3yAT+FTl30t88O3PVf9
        RCV0l6Gcjo4/m2g9lYF5jcBzOQ==
X-Google-Smtp-Source: AGHT+IEyiy5b3nZjrxUqCLi8UtuOkrr6suPn1vwp5RodoSz2UKg8GWMKoGwtKyNFwtH6O+JddbUpwQ==
X-Received: by 2002:a2e:86d5:0:b0:2c5:183d:42bf with SMTP id n21-20020a2e86d5000000b002c5183d42bfmr3998771ljj.45.1700468866186;
        Mon, 20 Nov 2023 00:27:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f04:f84b:d87d:1d06? ([2a01:e0a:982:cbb0:f04:f84b:d87d:1d06])
        by smtp.gmail.com with ESMTPSA id je12-20020a05600c1f8c00b0040839fcb217sm12641000wmb.8.2023.11.20.00.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 00:27:45 -0800 (PST)
Message-ID: <4608012c-059f-4d6a-914b-e85ad0c32ff0@linaro.org>
Date:   Mon, 20 Nov 2023 09:27:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/6] dt-bindings: pwm: amlogic: add new compatible for
 meson8 pwm type
Content-Language: en-US, fr
To:     Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>
Cc:     JunYi Zhao <junyi.zhao@amlogic.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20231117125919.1696980-1-jbrunet@baylibre.com>
 <20231117125919.1696980-3-jbrunet@baylibre.com>
 <170040994064.269288.960284011884896046.robh@kernel.org>
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
In-Reply-To: <170040994064.269288.960284011884896046.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Rob,

On 19/11/2023 17:05, Rob Herring wrote:
> 
> On Fri, 17 Nov 2023 13:59:12 +0100, Jerome Brunet wrote:
>> Add a new compatible for the pwm found in the meson8 to sm1 Amlogic SoCs.
>>
>> The previous clock bindings for these SoCs described the driver and not the
>> HW itself. The clock provided was used to set the parent of the input clock
>> mux among the possible parents hard-coded in the driver.
>>
>> The new bindings allows to describe the actual clock inputs of the PWM in
>> DT, like most bindings do, instead of relying of hard-coded data.
>>
>> The new bindings make the old one deprecated.
>>
>> There is enough experience on this HW to know that the PWM is exactly the
>> same all the supported SoCs. There is no need for a per-SoC compatible.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>   .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 36 +++++++++++++++++--
>>   1 file changed, 34 insertions(+), 2 deletions(-)
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

I'm puzzled, isn't it recommended to have a per-soc compatible now ?

I thought something like:
- items:
     - enum:
         - amlogic,gxbb-pwm
         - amlogic,axg-pwm
         - amlogic,g12a-pwm
     - const: amlogic,pwm-v1

should be preferred instead of a single amlogic,meson8-pwm-v2 ?

Neil
