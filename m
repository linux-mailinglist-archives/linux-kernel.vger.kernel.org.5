Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A39B7D6A66
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjJYLvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjJYLvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:51:20 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FCB12A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:51:18 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c5210a1515so86255681fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698234676; x=1698839476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Hsw0zm9eM5S+gWA6OmnIYoXsxBr0jnQpH2YM2gJKUI=;
        b=jn/WF9ZjSk0PxjD0njkzzHJnl9cIKCVnCQTqxxbplIkDJjkFBbe2qboL2E2PkQsrnP
         eCqYEjz3fvFkduU8692+vqQvyBNWpJAyRt8d/qFp7Mkff76X1V3vPCc7XIBVb52skyDJ
         wMhsudkbGRes88l90i5NmIK5QrECwKCrpuLZtGhEuP+PjDeyQ9NoMTDBPeB4N5lycFTL
         3oB9e9rNNDysjvSifMzNcJClHGLW2A4fI7ZaNL4DLFXGh+VB73qkuFFZ8qW8APipxZ8h
         2cySGzfKS//HGQdsFT9+8jPuEkZPxETo17EN4FMWiqz/KtoiDnLpDIlc/keR/NCEgoGF
         TJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698234676; x=1698839476;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Hsw0zm9eM5S+gWA6OmnIYoXsxBr0jnQpH2YM2gJKUI=;
        b=FtDjLzV+QB/4VR3hwezJJqrpGSy97lvaF/Y4LP8O0Le1YSFzkRJovVTeyQ68xG+Wq2
         5M11gD9tvEye1Re2PB/1tWTaTsMIm9C4bHzfsiqtwJ6BWGRzkxvp63oa2OcoJob2uSGk
         oXpW3qz4QrG7w9CJ3TR2SuArTfLTq1OGYf7CltDMKIRAWIsLMHKuQr/Rv6xUefSn18dU
         mfxSrw9iViVEKcqKtiY51T2QxSjFUDkOkJ6i2W0FExF8osZG10/ZrZfSebfs9K11a7VA
         RHkMKlv22195KwW8Vf1CRcBD5uuGlRVgEYowfMS5YwIyF6pYZmpbQ1LV/YqWeRaOjwTc
         ea5w==
X-Gm-Message-State: AOJu0YxcLV6F1MzM2b/31z1UV9acM6n+ih/vnnIRC7gMXou6mKB5zJLU
        vqGTznl32m3qjCvu5eUckVU3bw==
X-Google-Smtp-Source: AGHT+IHCNDC0+lPgS0jDJT3V4VlFbVtoiB+J4+5XT6STl1Pzc0zFjElf6UzhnnKU98eGFSk/iuorBw==
X-Received: by 2002:a2e:b896:0:b0:2c5:488c:aedf with SMTP id r22-20020a2eb896000000b002c5488caedfmr11637843ljp.37.1698234675797;
        Wed, 25 Oct 2023 04:51:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4b03:ec74:6374:5430? ([2a01:e0a:982:cbb0:4b03:ec74:6374:5430])
        by smtp.gmail.com with ESMTPSA id u1-20020a05600c210100b004068de50c64sm14201938wml.46.2023.10.25.04.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 04:51:15 -0700 (PDT)
Message-ID: <85f7eb5c-29ed-417a-a741-a3e7fe773d4b@linaro.org>
Date:   Wed, 25 Oct 2023 13:51:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC 3/8] arm64: dts: qcom: pm8550ve: make PMK8550VE SID
 configurable
Content-Language: en-US, fr
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231025-topic-sm8650-upstream-dt-v1-0-a821712af62f@linaro.org>
 <20231025-topic-sm8650-upstream-dt-v1-3-a821712af62f@linaro.org>
 <6cedd9fe-ae5b-4173-9a77-ef4d7813a071@linaro.org>
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
In-Reply-To: <6cedd9fe-ae5b-4173-9a77-ef4d7813a071@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 11:17, Krzysztof Kozlowski wrote:
> On 25/10/2023 09:47, Neil Armstrong wrote:
>> The pm8550ve can be found with a different SID on SM8650 platforms,
>> make it configurable.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/pm8550ve.dtsi | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/pm8550ve.dtsi b/arch/arm64/boot/dts/qcom/pm8550ve.dtsi
>> index c47646a467be..fbd8a386cef2 100644
>> --- a/arch/arm64/boot/dts/qcom/pm8550ve.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/pm8550ve.dtsi
>> @@ -6,6 +6,11 @@
>>   #include <dt-bindings/interrupt-controller/irq.h>
>>   #include <dt-bindings/spmi/spmi.h>
>>   
>> +/* (Sadly) this PMIC can be configured to be at different SIDs */
>> +#ifndef PMK8550VE_SID
>> +	#define PMK8550VE_SID 5
>> +#endif
> 
> My statement is still the same - NAK, for defines depending on ifndef. I
> believe outcome of our last discussion - including meeting in Amsterdam
> - was only to have defines in the board without any ifndef/ifdef.

As suggested by Dmitry, I'll add a define in all DT using the pm8550ve,
so this would remove any #ifndef.

Neil

> 
> Best regards,
> Krzysztof
> 

