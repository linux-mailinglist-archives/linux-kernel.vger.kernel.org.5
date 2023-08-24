Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72996786A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjHXIry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240542AbjHXIre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:47:34 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FFD1BC5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:47:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fef56f7222so31128215e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692866820; x=1693471620;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4W0wShPxj970HM+vO+J4VpqUX1dY6k+EF1YYQxuqvko=;
        b=ZOtAkIPQipX4ZbkwqQQd3xISKpVJlbetKmrUU95QRB8DRuA7OMKfBuv7zqZ+xT3fqt
         5aFE6ogPhvfL8BXvsQfnx/J6CCgDwVeVWj6IiTAMCpZyrjCYOdf5JmGMg/b55Dz4HnYB
         cE039L0bWXoTtlQQBZAkgitDJeb7DuNhq73K/jBPmtxPJbCyhFTi/G+esVYMXZAyGsZa
         goE/bFRtfSXO2IwBRMqhuCJP3Uuxh6LgZCDONmoTGz94R691tiFx2qKI8it0blQQWELQ
         VKQ9BQHDupP2G3vCQ33MaIm7km7ex2I3oWGMTG1Mf3G/ywM4nQpnYj9tL6B23o52SHRY
         vq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692866820; x=1693471620;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4W0wShPxj970HM+vO+J4VpqUX1dY6k+EF1YYQxuqvko=;
        b=B+xWUkNN+OOFWl1d2/8zKxmoVWPtwJUYcxQRAD3sNOQ32042l4s5jfpWyaxygJPuNI
         EE6TMkx6rseFMFyy1ZShoINhDnNV0la7vovdkJweeeAzttTNt+r/4ec42ZEofgsIeOZk
         zE0Zs6q0dabVVBW5Bwg4zcqOstTtvo0orJlzKrjN8ZxFjEkNUpoiRXALB8zKTQ+g3fPr
         c6Lh0BocQhFILMOtJWq/3MAV5eNzanXIxy0yBbFDV533uZCLt2RsC6E2IWNNZmODoZNI
         aseU5Li9BisDZJIiGTE0xURj2rA/03Y6ucdUgWd3JqEck1cRv0LoRpt2tzagPyjsMcY2
         k+Ow==
X-Gm-Message-State: AOJu0YyCVd7TE4+z4OZIArM16YI44pTTLj0tVbfX/HIbDzGX2P1d5fC5
        E02Pgny3ZGOV2UamKNDSObM5Hg==
X-Google-Smtp-Source: AGHT+IE3cdl3KGPJ6VTg6TUCJ/y3ymati1svSewwlzS6TTay9/VfYjNWVgFG38dB93X3kLM40xlG6Q==
X-Received: by 2002:a05:600c:3654:b0:3fb:b5dc:dab1 with SMTP id y20-20020a05600c365400b003fbb5dcdab1mr10332470wmq.39.1692866820089;
        Thu, 24 Aug 2023 01:47:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e6d5:d4d4:f3a1:e44b? ([2a01:e0a:982:cbb0:e6d5:d4d4:f3a1:e44b])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c020600b003fc04d13242sm2016890wmi.0.2023.08.24.01.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:46:59 -0700 (PDT)
Message-ID: <08e4a3b2-0943-4e22-957e-37079184b48b@linaro.org>
Date:   Thu, 24 Aug 2023 10:46:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: crypto: qcom,prng: document SM8550
Content-Language: en-US, fr
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Om Prakash Singh <quic_omprsing@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230822-topic-sm8550-rng-v1-0-8e10055165d1@linaro.org>
 <20230822-topic-sm8550-rng-v1-1-8e10055165d1@linaro.org>
 <8479869b-9984-41e3-9812-c7f5727cfd2c@linaro.org>
 <b73106c5-74e4-479d-8733-b99454768c15@quicinc.com>
 <26bae022-c114-4871-8715-73d7e8aeaa52@linaro.org>
 <f61ef601-1561-45d7-8f4a-947458472668@quicinc.com>
 <dd3d28f1-ff5e-49e6-a9f7-0ec9265017cc@linaro.org>
 <d44be821-228b-4035-aa1e-c4f58db90422@quicinc.com>
 <6574894d-e7ba-e5cc-a03f-76f97d1403ad@linaro.org>
 <21b57b63-c927-4d00-8327-c4105ff5e9b2@linaro.org>
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
In-Reply-To: <21b57b63-c927-4d00-8327-c4105ff5e9b2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 10:40, Konrad Dybcio wrote:
> On 24.08.2023 08:37, Krzysztof Kozlowski wrote:
>> On 24/08/2023 01:32, Om Prakash Singh wrote:
>>>
>>>
>>> On 8/23/2023 1:25 PM, Neil Armstrong wrote:
>>>> Hi,
>>>>
>>>> On 23/08/2023 02:10, Om Prakash Singh wrote:
>>>>>
>>>>>
>>>>> On 8/22/2023 9:34 PM, Konrad Dybcio wrote:
>>>>>> On 22.08.2023 16:54, Om Prakash Singh wrote:
>>>>>>> PRNG Block on most of newer target from Qualcomm have some
>>>>>>> configuration where clock is configured by security firmware.
>>>>>>>
>>>>>>> Adding separate compatible string for each platform is overhead.
>>>>>>>
>>>>>>> We need to introduce common compatible string that can be used for
>>>>>>> all platforms with same configuration.
>>>>>>>
>>>>>>> I would suggest to use "qcom,rng-ee" for newer platform, dropping
>>>>>>> "p" also signifies it is not a Pseudo Random Number Generator.
>>>>>> Please reply inline and don't top-post.
>>>>>>
>>>>>>
>>>>>> Is this what you're trying to say?
>>>>>>
>>>>>> 1. sort out the clock requirements for designs where Linux manages it
>>>>>>      vs where the FW does so >
>>>>>> 2. introduce a new compatible for SoCs implementing a TRNG
>>>>>>
>>>>>> 3. for SoCs in 2., register the TRNG as a hwrng device
>>>>>
>>>>> Yes to all
>>>>
>>>> I can send a proposal, but that means writing a new driver for this
>>>> compatible in drivers/char/hw_random/ right ?
>>>
>>> We can add hwrng support in same driver like
>>> drivers/crypto/hisilicon/trng/trng.c
>>>
>>> As Krzysztof is suggesting we need to have platform specific compatible
>>
>> That's independent question
>>
>>> string, we can go with your change. for hwrng support I will send
>>> separate patches.
>>
>> Any bindings decision should be made now. We don't produce knowingly
>> incomplete bindings just to change them later. Therefore now you need to
>> decide whether you call it prng-ee or something else.
> Herbert already picked up the 8450 compatible last week or so.
> If we decide quickly, perhaps it can be reverted and substituted
> with the non-*P*RNG one. It would theoretically be an ABI break,
> but:
> 
> a) it would be very very prompt
> b) the dts patch hasn't been merged so there are no users
> 
> I'd be fine with that, not sure about the rest of you guys.

I'm fine for that aswell, this can be done quickly without the
hwrng part

I can quickly refresh this serie with :
1) introduce a new "qcom,trng" and move "qcom,sm8450-prng-ee" to "qcom,sm8450-trng"
2) add qcom,sm8550-prng-ee
3) add "qcom,trng"  to the driver compatible list

then afterwards, the hwrng part can be added in a separate serie.

Neil

> 
> Konrad

