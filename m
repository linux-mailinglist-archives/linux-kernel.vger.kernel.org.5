Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5B97FEB9A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjK3JNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjK3JNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:13:10 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EFA10D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:13:15 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32fdc5be26dso483461f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701335594; x=1701940394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JucOyRuowajl55FaVJkCJ+iCL38xKPC8u2xNBw30DGI=;
        b=c0i4MU6QzP0MJUj2ZYWRVGa+OwtTAapjrUJ3aqOremBwnYUgGKl3w4D7oTK201OXOi
         KJ/xiQ8z2nfkDTqwWOhdFpuyEY/mf6WkLSS+tcwgQ3gYZY5PU3FLAgO5JWfkNnNltrlq
         KFyAVuJ8edVots+IV5UTbsABqgZ3nq8wabj0pXYE2MwT5h925xta4ouZNNGQmLEMOW3q
         lsCC0UKWHtRqGjYOWuZ1vmugFUfpRTC3Q0h6GbVR0Crx4ij5ILzMnFb2Alm6KSUH8GEp
         Zmq9M0+3EJ00hDqKsRlhW+KD9QgweOzWErIlk/x25nizaEQcpgVflDqpfvYIzL5l6ZUs
         kMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701335594; x=1701940394;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JucOyRuowajl55FaVJkCJ+iCL38xKPC8u2xNBw30DGI=;
        b=TQuJsXqolG0kAIghXTB6v9eCmOqX2WMBiChBsZZRVw0llz+TsOsQw49/DcPetbZOb2
         KaIxU7oOG0Tz172Ril5+mO+LTIMM5JSZYj4/sZJQw3GldltRoYibxngfdpxat1+X4o6n
         4oIW7mMFN15/jAn6JYDd2eF/3/gW/LVdZl8/ijGt/A0rX/fHwVyxyDCXKW/v7d12pUVP
         DtOTQioB+C7t2Y1AljW8YDuBG48ygHH1ilymvT2pIoGAIy9gP6Wq32Gmm6i0WeUWdt3k
         udMyjgJtUe108gqY10y7+BpzgxaPG1dXp/8WcT8G3Xh+X0EEw5niyiDBdHV7NSZKabYI
         qthg==
X-Gm-Message-State: AOJu0YwNOBWlgV63u36LcjRrrp8WvIdc5fD8q30adDzfILBNqxQIUGsw
        QrMqXBdZKTODTCLnLlCKFChOMQ==
X-Google-Smtp-Source: AGHT+IEwXMs51EeZF9IX22o6sl11L9KxmNjzlGnL8883eDT+U1ZjMdU5LdOCDfssHg7g38EHbxJtHg==
X-Received: by 2002:adf:ea84:0:b0:332:eb80:874a with SMTP id s4-20020adfea84000000b00332eb80874amr16055939wrm.1.1701335594169;
        Thu, 30 Nov 2023 01:13:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:41c9:3acd:a6e2:5242? ([2a01:e0a:982:cbb0:41c9:3acd:a6e2:5242])
        by smtp.gmail.com with ESMTPSA id r13-20020adfe68d000000b00333040a4752sm954872wrm.114.2023.11.30.01.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:13:13 -0800 (PST)
Message-ID: <f572c729-d007-46b4-b7ac-442f96b23969@linaro.org>
Date:   Thu, 30 Nov 2023 10:13:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/4] dt-bindings: pwm: amlogic: add new compatible for
 meson8 pwm type
Content-Language: en-US, fr
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        JunYi Zhao <junyi.zhao@amlogic.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <20231129134004.3642121-1-jbrunet@baylibre.com>
 <20231129134004.3642121-3-jbrunet@baylibre.com>
 <8e78be99-3d4d-4f79-9791-404e60bcb67c@linaro.org>
 <1jfs0ojz1a.fsf@starbuckisacylon.baylibre.com>
 <11f8d986-3e97-4191-b46c-ad3166ee6dc7@linaro.org>
 <e127dcef-3149-443a-9a8c-d24ef4054f09@linaro.org>
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
In-Reply-To: <e127dcef-3149-443a-9a8c-d24ef4054f09@linaro.org>
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

On 30/11/2023 09:36, Krzysztof Kozlowski wrote:
> On 29/11/2023 17:41, neil.armstrong@linaro.org wrote:
>>>>>     .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 52 ++++++++++++++++---
>>>>>     1 file changed, 46 insertions(+), 6 deletions(-)
>>>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>>>>> b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>>>>> index 387976ed36d5..eece390114a3 100644
>>>>> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>>>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>>>>> @@ -21,23 +21,35 @@ properties:
>>>>>               - amlogic,meson-g12a-ee-pwm
>>>>>               - amlogic,meson-g12a-ao-pwm-ab
>>>>>               - amlogic,meson-g12a-ao-pwm-cd
>>>>> -          - amlogic,meson-s4-pwm
>>>>> +        deprecated: true
>>>>>           - items:
>>>>>               - const: amlogic,meson-gx-pwm
>>>>>               - const: amlogic,meson-gxbb-pwm
>>>>> +        deprecated: true
>>>>>           - items:
>>>>>               - const: amlogic,meson-gx-ao-pwm
>>>>>               - const: amlogic,meson-gxbb-ao-pwm
>>>>> +        deprecated: true
>>>>>           - items:
>>>>>               - const: amlogic,meson8-pwm
>>>>>               - const: amlogic,meson8b-pwm
>>>>> +        deprecated: true
>>>>
>>>> I think deprecated should be moved in a third patch
>>>
>>> The complain on v2 was that it was not clear the new binding was making
>>> the old one obsolete. It looked to me that the deprecation old bindings
>>> needed to go together with the introduction of the new.
>>>
>>> I don't mind one way or the other
>>>
>>> Is there a rule somewhere about this ?
>>
>> Not sure about that, I don't think it's a problem to have both valid
>> at the same time, setting them deprecated afterwards looks cleaner
>> to avoid mixing too much changes at the same time.
> 
> For me current order is correct and intuitive: you add new binding,
> because old binding was wrong, so the old binding should be deprecated.
> Otherwise you have a state with both new and old binding and one could
> question - why did we need new binding? For dtschema it does not matter,
> but it matters how we read the code.

Ack thx for the clarification

> 
> Best regards,
> Krzysztof
> 

Thanks,
Neil

