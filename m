Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F94F7A89C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjITQzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbjITQzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:55:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B8CD6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:54:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-404732a0700so473775e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695228895; x=1695833695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kA3YlJpKr1DDa6ZpJWFWDHbXpM12AnWtX48T6/GwQ7I=;
        b=sssZiDMsTHXVwW5qQe6LuvJzG1bXkI1M+1Xl4As077nFgdwRjkB+x2xR8L6HZbP4xk
         aFldgRzQPH8cLfsOJcelu6z9k5jKcYNsKFfWRNd845TogwgpKe72SuLlD6ffE5+Ayhd1
         uNZMegEGZVidtS9Ie17fAX2gXztvVn/Olzci291yXKBud6+tW3QkmPxzunxw8TfyOa+t
         t2/ztr1puoP1PvS3flS+So4kV3rqsqc1LknSJlVaI1Z1PwKjAyhzE2FqQRgVW5d5t50P
         BZ6qjtXRsdd8jqKetXsG5S0KGA5WeyDLyCYwd5qDTtNB2Co5yTpdgVixMGaOcr15oo9P
         5YLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695228895; x=1695833695;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kA3YlJpKr1DDa6ZpJWFWDHbXpM12AnWtX48T6/GwQ7I=;
        b=lD0bbA+yX7IS2RBEw8mbGcxJHoYn203ZFYumrktpWm9M7hyu+E2cZPIs2uz5uIXAJd
         ErRWZMfejqqk0/ThMk0TaEaJNFOLfNPUjjnPwkUbs+7gNhUDSFPlME/WkKJqsN7BBq4G
         f++rPicg3hgHL5fmq51qyJ6lXSZy08EBJ5GIsQagJgq57kGqXhf7do/b/ezAKuAnKk9C
         bfDciWfiACUNmjWZeo4skv/xkosEpWeJbH2fNDcZTZi7TmUwj0SLHkZ7H/ADMiQT8DCi
         AsURpIYdjTltfZ7zgGeYFgVVpczjhlpUZO0oYIU2Z+r7EMZHdaHtRdy0QwmNFB1izpjW
         OFsg==
X-Gm-Message-State: AOJu0YyBTVKdt2XpGKmL081ndlF3fVhwDuZW9pgnRT1IK7exZg9/gpo/
        bJGHwaoabKen+uRHafphzyZXzg==
X-Google-Smtp-Source: AGHT+IHSqZ/BU4JZQRrKEFMrxGVXWNuvDGeAaaBSjq8JVTT9sYmoLarXjOwjgcGJGySWZ5C8AZylbA==
X-Received: by 2002:a5d:4588:0:b0:31f:ef77:67ee with SMTP id p8-20020a5d4588000000b0031fef7767eemr2999973wrq.40.1695228895427;
        Wed, 20 Sep 2023 09:54:55 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c020f00b00401d8810c8bsm2448052wmi.15.2023.09.20.09.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 09:54:54 -0700 (PDT)
Message-ID: <c1611e72-aace-4386-b239-91f49e8dd26c@linaro.org>
Date:   Wed, 20 Sep 2023 18:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/4] dt-bindings: soc: qcom: qcom,pmic-glink: add a gpio
 used to determine the Type-C port plug orientation
Content-Language: en-US, fr
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230804-topic-sm8550-upstream-type-c-orientation-v1-0-36dd3edec7bf@linaro.org>
 <20230804-topic-sm8550-upstream-type-c-orientation-v1-1-36dd3edec7bf@linaro.org>
 <zhm72wrjg7yazutkinv5lx55dgqtm4hmuexw2ht24fu6txxk3d@oum27inbk7si>
 <7fc7371a-1b2d-ccce-1e73-6bfe70ea2b20@linaro.org>
 <zigqqjepj54v5vnmhm3r3knwrjd2rfw2njds4ul7vmxq3nfrua@rkupccyyxziw>
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
In-Reply-To: <zigqqjepj54v5vnmhm3r3knwrjd2rfw2njds4ul7vmxq3nfrua@rkupccyyxziw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2023 18:50, Bjorn Andersson wrote:
> On Mon, Aug 14, 2023 at 10:09:41AM +0200, Neil Armstrong wrote:
>> On 04/08/2023 18:03, Bjorn Andersson wrote:
>>> On Fri, Aug 04, 2023 at 03:50:07PM +0200, Neil Armstrong wrote:
>>>> On SM8450 and SM8550 based platforms, the Type-C plug orientation is given on a
>>>> GPIO line set by the PMIC.
>>>>
>>>> Document this optional Type-C connector property, and take the
>>>> assumption an active level represents an inverted/flipped orientation.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml  | 18 ++++++++++++++++++
>>>>    1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>>>> index bceb479f74c5..1b0a00b19a54 100644
>>>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>>>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>>>> @@ -35,6 +35,11 @@ properties:
>>>>      '#size-cells':
>>>>        const: 0
>>>> +  orientation-gpios:
>>>> +    description: An input gpio for Type-C connector orientation, used to detect orientation
>>>> +      of the Type-C connector. GPIO active level means "CC2" or Reversed/Flipped orientation.
>>>
>>> This is a per-connector/port property, as such be part of the connector
>>> sub nodes rather than as a property of the shared pmic_glink entity.
>>
>> This has been rejected by Rob, Dmitry & Krzysztof in:
>> https://lore.kernel.org/all/0fbf55e7-2140-751d-5347-f907a46ef78c@linaro.org/
>> &
>> https://lore.kernel.org/all/20230608154751.GA2750742-robh@kernel.org/
>>
>> Indeed the "GPIO" is not part of the physical USB-C connector, but a property,
>> and it's not part of the PMIC GLINK firmware either, so ?
>>
>> The PMIC function which generates this signal is handled by the PMIC GLINK
>> firmware, so this representation is the most accurate.
>>
> 
> I don't think we reached a conclusion on the discussion that followed.
> If this indeed is the path forward, please document clearly how the next
> person should proceed when the need for handling multiple ports with
> this scheme arise.

Sure, I'll explicit this is an array of gpios, one for each port, I thought I wrote
it but seems I forgot to add it to the description.

Neil

> 
> Thanks,
> Bjorn
> 
>> Neil
>>
>>>
>>> Regards,
>>> Bjorn
>>>
>>>> +    maxItems: 1
>>>> +
>>>>    patternProperties:
>>>>      '^connector@\d$':
>>>>        $ref: /schemas/connector/usb-connector.yaml#
>>>> @@ -44,6 +49,19 @@ patternProperties:
>>>>    required:
>>>>      - compatible
>>>> +allOf:
>>>> +  - if:
>>>> +      not:
>>>> +        properties:
>>>> +          compatible:
>>>> +            contains:
>>>> +              enum:
>>>> +                - qcom,sm8450-pmic-glink
>>>> +                - qcom,sm8550-pmic-glink
>>>> +    then:
>>>> +      properties:
>>>> +        orientation-gpios: false
>>>> +
>>>>    additionalProperties: false
>>>>    examples:
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>

