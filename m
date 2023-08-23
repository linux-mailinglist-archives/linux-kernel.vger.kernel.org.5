Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8984785211
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjHWHzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjHWHzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:55:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6541FCD5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:55:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3ff7d73a6feso2127705e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692777320; x=1693382120;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRneTZRUa8cNy0srxSHuZvRzwItRI2yXoW2UtKvjV84=;
        b=zMi9Kg6JnKkiOCApN1UHZOgHFh2i6WbZwKiWfNMJhTP0YcLnPhqjYtGoHsa2KL9uCl
         ll1PppstbMvSt6v+N12uykxm05dWXOvpbJyTeWdZbscJ6r/Yto28AY9VO4WuVDmQFy/g
         hji+USfZejzfd3XLL4J8I+izrbgywVakeg++lhsfF157OFcA6OExoaoXSQu2nd4BK3LG
         CkVMSVA0Qa0r1FifISz8+3bi7xcWNIImgvxtjTTvr+MHDHpJykdDs2yskkvi9VnFEduN
         WF4ib2gwSBm9gL5ba8mPo2KB7yIvhk5uJXyV/k5cdqVJSSixxhd8qom0/WtP6fM3Nf++
         lmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692777320; x=1693382120;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LRneTZRUa8cNy0srxSHuZvRzwItRI2yXoW2UtKvjV84=;
        b=YkdkmHTtubOE7iW1Rn9FiSlnCMb+L5PjdpjMUZhIU1KFPcamxtmtgwqwTyqkrqte5A
         ZO9nu3GKW/ar840tSHWXV8ff3vZL40Bxk80zQKfTxGA7WNGoBdaSYEukGn4Ify9bv/0I
         uozHvGJAufuwJhlEztVKv8/I4rBwS+lQX7DOVPBY28RheWxXR6n8dRSi7mEzDnLDNmig
         akMz2OdXqb5t3Xx4n/1fWa3E5yNGmGQIjJzdzBUdA1qRNXwz4Uy2E1Y9aDH05cqWHHoh
         gUnDhfXBonmiCmTEU5aYmOb+dexsDXjZPkq68CG72k/1hyhwjQ4f1aE3DYzgCRpSD2mw
         4Nog==
X-Gm-Message-State: AOJu0Yz81HKikkRepbt75KFsgdSVFnWDCgtgoc4aUJHGZ3g5X+6h4e+e
        TB8Thw4mjJG6tc7iw2R5S+JbgQ==
X-Google-Smtp-Source: AGHT+IFzUCxBjFJpacEZ0cCouJ1S4MFuI4b7FnwIj+Snn5zburmfTxe9ZoVlX4tYEuogvDUfQBBXWw==
X-Received: by 2002:a05:600c:22d4:b0:3fc:f9c:a3ed with SMTP id 20-20020a05600c22d400b003fc0f9ca3edmr9798385wmg.22.1692777319859;
        Wed, 23 Aug 2023 00:55:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:c457:5132:4849:b9d9? ([2a01:e0a:cad:2140:c457:5132:4849:b9d9])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4204000000b0031c5dda3aedsm5749631wrq.95.2023.08.23.00.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 00:55:19 -0700 (PDT)
Message-ID: <dd3d28f1-ff5e-49e6-a9f7-0ec9265017cc@linaro.org>
Date:   Wed, 23 Aug 2023 09:55:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: crypto: qcom,prng: document SM8550
Content-Language: en-US, fr
To:     Om Prakash Singh <quic_omprsing@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
In-Reply-To: <f61ef601-1561-45d7-8f4a-947458472668@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/08/2023 02:10, Om Prakash Singh wrote:
> 
> 
> On 8/22/2023 9:34 PM, Konrad Dybcio wrote:
>> On 22.08.2023 16:54, Om Prakash Singh wrote:
>>> PRNG Block on most of newer target from Qualcomm have some configuration where clock is configured by security firmware.
>>>
>>> Adding separate compatible string for each platform is overhead.
>>>
>>> We need to introduce common compatible string that can be used for all platforms with same configuration.
>>>
>>> I would suggest to use "qcom,rng-ee" for newer platform, dropping "p" also signifies it is not a Pseudo Random Number Generator.
>> Please reply inline and don't top-post.
>>
>>
>> Is this what you're trying to say?
>>
>> 1. sort out the clock requirements for designs where Linux manages it
>>     vs where the FW does so >
>> 2. introduce a new compatible for SoCs implementing a TRNG
>>
>> 3. for SoCs in 2., register the TRNG as a hwrng device
> 
> Yes to all

I can send a proposal, but that means writing a new driver for this compatible in drivers/char/hw_random/ right ?

Neil

> 
>>
>>
>> ?
>>
>> Konrad
> 
> Thanks,
> Om

