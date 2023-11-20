Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD687F109D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjKTKmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjKTJzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:55:48 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25093CD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:55:45 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40859c466efso14334425e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700474143; x=1701078943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/fgPwc0eJeHKzVZ0LNgK+ADmeLq8vaZ9kNwx7EAjKs=;
        b=AB0Iitxw53fCH9ooiW/8SIFAIVxzKpYQOOZZMw20FcVtE5SwwNure6nZ/6H3U6C0xR
         G2Y2GRsJLBonA1hoWzzOYuuqFDSN5WaiRDqfiJ8sLNoHJX2WDMq0IjFcji2THqTn4RNL
         6ULKTgfhNYfA13qPutCOGRqySZiZwHmzRN5fY62UrJm8Y9AFRSM9jvP/gWityNeuNuIR
         wY2d+5OtAXwaeMi9tfhaiFF6vianLD85eD7URuSWwNWPYcHA7la1ZRS8XRkUqq/0y5Mm
         h0hpW9yxhP6BixjU6wSJP5HqS0BGB2iFfPnpLYocmgY/9F2RUZ8O/XrsfgpRHAr6Bbcn
         A7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700474143; x=1701078943;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z/fgPwc0eJeHKzVZ0LNgK+ADmeLq8vaZ9kNwx7EAjKs=;
        b=w6nsBaAE6G56vjF0eaPGRc/FQD1joeetK47IqsNXsQH2UZINFExN8qseHuK5xwczMI
         p7K5SSpREAWbSDmDFj550gfHxgW0NV59tmgZmUdiTlZqI7x2kmQ6iY8O4WH5QMwR+fMG
         Ps/VZXQcFPH5pcQ9MOljaGIz9cNvzIkX+s4Dczm8d1zd/8jR/nHjv7rR+U/T/lanJshm
         SuPsdTm0z4cU9jnCz8KRKvTw0tIgZc7xz5OKQFztW8iQu5E/rDpGAVQgC91W8ilhegQB
         FbRRsh+qMocsOL5Ya2VSqlG9LJvdsXQX6llHvprCpGQQybFQR6cIVuVYl+eUqUfe8B4R
         o6Gg==
X-Gm-Message-State: AOJu0Ywfig/dUOztIZcuLws9iLc7QWqWIYK9UR+EsWTrehsvfiSVDXb/
        1gFNFhRE2TYPWgfv6JK8EssX2Q==
X-Google-Smtp-Source: AGHT+IFu375tvhXordR9b+2N0jAh7Rh1Ee35XAPBSYiGksbXeGO3wKimM4WedQWg6uHqfyibQIPx1A==
X-Received: by 2002:a05:600c:4507:b0:408:55f8:7de with SMTP id t7-20020a05600c450700b0040855f807demr4971695wmo.28.1700474143458;
        Mon, 20 Nov 2023 01:55:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f04:f84b:d87d:1d06? ([2a01:e0a:982:cbb0:f04:f84b:d87d:1d06])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b003fee567235bsm17489914wmo.1.2023.11.20.01.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 01:55:43 -0800 (PST)
Message-ID: <2e7a65da-5c1d-4dd4-ac69-7559a53afdf3@linaro.org>
Date:   Mon, 20 Nov 2023 10:55:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/6] dt-bindings: pwm: amlogic: add new compatible for
 meson8 pwm type
Content-Language: en-US, fr
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Rob Herring <robh@kernel.org>, JunYi Zhao <junyi.zhao@amlogic.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20231117125919.1696980-1-jbrunet@baylibre.com>
 <20231117125919.1696980-3-jbrunet@baylibre.com>
 <170040994064.269288.960284011884896046.robh@kernel.org>
 <4608012c-059f-4d6a-914b-e85ad0c32ff0@linaro.org>
 <1j5y1wg3sb.fsf@starbuckisacylon.baylibre.com>
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
In-Reply-To: <1j5y1wg3sb.fsf@starbuckisacylon.baylibre.com>
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

Hi Jerome,

On 20/11/2023 10:18, Jerome Brunet wrote:
> 
> On Mon 20 Nov 2023 at 09:27, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> Hi Rob,
>>
>> On 19/11/2023 17:05, Rob Herring wrote:
>>> On Fri, 17 Nov 2023 13:59:12 +0100, Jerome Brunet wrote:
>>>> Add a new compatible for the pwm found in the meson8 to sm1 Amlogic SoCs.
>>>>
>>>> The previous clock bindings for these SoCs described the driver and not the
>>>> HW itself. The clock provided was used to set the parent of the input clock
>>>> mux among the possible parents hard-coded in the driver.
>>>>
>>>> The new bindings allows to describe the actual clock inputs of the PWM in
>>>> DT, like most bindings do, instead of relying of hard-coded data.
>>>>
>>>> The new bindings make the old one deprecated.
>>>>
>>>> There is enough experience on this HW to know that the PWM is exactly the
>>>> same all the supported SoCs. There is no need for a per-SoC compatible.
>>>>
>>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>>> ---
>>>>    .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 36 +++++++++++++++++--
>>>>    1 file changed, 34 insertions(+), 2 deletions(-)
>>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>
>>
>> I'm puzzled, isn't it recommended to have a per-soc compatible now ?
> 
> I have specifically addressed this matter in the description,
> haven't I ? What good would it do in this case ?

Yes you did but I was asked for the last year+ that all new compatible
should be soc specific (while imprecise, in our care soc family should be ok),
with a possible semi-generic callback with an IP version or a first soc
implementing the IP.

> 
> Plus the definition of a SoC is very vague. One could argue that
> the content of the list bellow are vaguely defined families. Should we
> add meson8b, gxl, gxm, sm1 ? ... or even the actual SoC reference ?
> This list gets huge for no reason.

I think in our case soc family is reasonable since they share same silicon
design.

> 
> We know all existing PWM of this type are the same. We have been using
> them for years. It is not a new support we know nothing about.
> 
>>
>> I thought something like:
>> - items:
>>      - enum:
>>          - amlogic,gxbb-pwm
>>          - amlogic,axg-pwm
>>          - amlogic,g12a-pwm
>>      - const: amlogic,pwm-v1
> 
> I'm not sure I understand what you are suggesting here.
> Adding a "amlogic,pwm-v1" for the obsolete compatible ? No amlogic DT
> has that and I'm working to remove this type, so I don't get the point.
> 
>>
>> should be preferred instead of a single amlogic,meson8-pwm-v2 ?
> 
> This is named after the first SoC supporting the type.
> 
> Naming it amlogic,pwm-v2 would feel weird with the s4 coming after.
> Plus the doc specifically advise against this type of names.

The -v2 refers to a pure software/dt implementation versioning and not
an HW version, so I'm puzzled and I requires DT maintainers advice here.

Yes meson8b is the first "known" platform, even if I'm pretty sure meson6 has
the same pwm architecture, this is why "amlogic,pwm-v1" as fallback seems more
reasonable and s4 and later pwm could use the "amlogic,pwm-v2" fallback.

Neil
> 
>>
>> Neil
> 

