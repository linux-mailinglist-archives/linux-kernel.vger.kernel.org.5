Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B2F78A6FB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjH1ICL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjH1IBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:01:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB95114
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:01:32 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bd0d135ca3so11381501fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693209691; x=1693814491;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzA+Pcb496ZNITWGLYBbGlGwRmGMM9hWWTkk9F3cf9o=;
        b=nZ7/49DSXK2COmjX4pXkI7rbI4ywI47IQcBiUIe3bMHd0D5HJ+lw9435RGpMjnBb8J
         R3fA1KZN5gDXDlZigY/S0hTAQIPIzhdjXQvTHwubiI3jisyzO3xZlaeI6+Olg/Lv9TrH
         9Q58H2vAdQGZMJmRVea6xEGwjjdnWqPI0UwB1t/FbFCZA0QWIl99NXmUnmoEIPvSOaQ8
         0HZvRnw5GaOj5RovxAJFnH6IOiN2agYAhCmP9DFH/Z8n8ouJwB+ZEpNwIdoR7GJ6fpdt
         /VmKa9ObQnoNFoI8YLBnNF63Tbn4FvoRnwwgsxzjfaCftAENl4d7dOpxLubCIP7/OBfk
         tNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693209691; x=1693814491;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yzA+Pcb496ZNITWGLYBbGlGwRmGMM9hWWTkk9F3cf9o=;
        b=XVF7g/QSqA6NUZxJDTyHCUOoqvd5ln20qw/c6fMoU5GHB/ZS48YCKEGVSdOZJV0F8X
         KVnCyKvjbhtcSA/gis5x8HoKDmjzqFWsUrdhUwlD+QIt9bxLZ5HW8LZ4oKZXwMKZJPf6
         M8Twqa8Cc+DeF9d5e1VZ5V62KhCyfWDeyoxWnlSUD90PZtK0RyZQerQQV34HS22aQNM5
         c9rCccVFkLgiDWCCpXsifALNqW4TeqgEshQvJnfJ03oI7ThJEzAPYZ2hXkvCSr9s0pEp
         wtYvJNVGQGGE3aoQD0fXEngt9O06e/+M/GjCNo5s7FNO0wKxF/iIHDQfWwUbsVjiSWik
         Aa9Q==
X-Gm-Message-State: AOJu0YyZ99R7MRyQ9FFG0zlv7k+8s8o1Bi6NCIwEa+hkbrnV813ihK5y
        UVqNW26TGWci67wd5/JPZGKIDA==
X-Google-Smtp-Source: AGHT+IGYAvLKiXg4lwCUIbQDVIyGOwJSoywiHGhA+NsggymdBRdZU3wars3lwUxUjAzWuxK5p5hoOQ==
X-Received: by 2002:a2e:8e97:0:b0:2bb:aaab:b42f with SMTP id z23-20020a2e8e97000000b002bbaaabb42fmr17455993ljk.49.1693209690894;
        Mon, 28 Aug 2023 01:01:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5e59:c27b:747a:3f52? ([2a01:e0a:982:cbb0:5e59:c27b:747a:3f52])
        by smtp.gmail.com with ESMTPSA id j11-20020adfe50b000000b003143867d2ebsm9792691wrm.63.2023.08.28.01.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 01:01:30 -0700 (PDT)
Message-ID: <b6c48249-7e3e-4786-88f6-25b17ae7a932@linaro.org>
Date:   Mon, 28 Aug 2023 10:01:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/7] Revert "dt-bindings: crypto: qcom,prng: Add
 SM8450"
Content-Language: en-US, fr
To:     Om Prakash Singh <quic_omprsing@quicinc.com>,
        Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230824-topic-sm8550-rng-v2-0-dfcafbb16a3e@linaro.org>
 <20230824-topic-sm8550-rng-v2-1-dfcafbb16a3e@linaro.org>
 <20230824212903.GA1453763-robh@kernel.org>
 <a9fa63e1-dcc4-4f44-97b0-03d5afd6435a@quicinc.com>
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
In-Reply-To: <a9fa63e1-dcc4-4f44-97b0-03d5afd6435a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/08/2023 08:25, Om Prakash Singh wrote:
> 
> 
> On 8/25/2023 2:59 AM, Rob Herring wrote:
>> On Thu, Aug 24, 2023 at 01:33:20PM +0200, Neil Armstrong wrote:
>>> This reverts commit b9296bb41275 ("dt-bindings: crypto: qcom,prng: Add SM8450"),
>>> since the RNG HW on the SM8450 SoC is in fact a True Random Number Generator,
>>> a more appropriate compatible should be instead as reported at [1].
>>>
>>> [1] https://lore.kernel.org/all/20230818161720.3644424-1-quic_omprsing@quicinc.com/
>>>
>>> Suggested-by: ￼Om Prakash Singh <quic_omprsing@quicinc.com>
>>> Suggested-by: ￼Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> Is it just me or looks like an unrenderable character in these.
> Yes there are spacial character before Om and Konrad that should have been removed.

Let me resend a v2 without this space and the review tags.

Neil

>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   .../devicetree/bindings/crypto/qcom,prng.yaml      | 24 +++++-----------------
>>>   1 file changed, 5 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
>>> index 36b0ebd9a44b..bb42f4588b40 100644
>>> --- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
>>> +++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
>>> @@ -11,13 +11,9 @@ maintainers:
>>>   properties:
>>>     compatible:
>>> -    oneOf:
>>> -      - enum:
>>> -          - qcom,prng  # 8916 etc.
>>> -          - qcom,prng-ee  # 8996 and later using EE
>>> -      - items:
>>> -          - const: qcom,sm8450-prng-ee
>>> -          - const: qcom,prng-ee
>>> +    enum:
>>> +      - qcom,prng  # 8916 etc.
>>> +      - qcom,prng-ee  # 8996 and later using EE
>>>     reg:
>>>       maxItems: 1
>>> @@ -32,18 +28,8 @@ properties:
>>>   required:
>>>     - compatible
>>>     - reg
>>> -
>>> -allOf:
>>> -  - if:
>>> -      not:
>>> -        properties:
>>> -          compatible:
>>> -            contains:
>>> -              const: qcom,sm8450-prng-ee
>>> -    then:
>>> -      required:
>>> -        - clocks
>>> -        - clock-names
>>> +  - clocks
>>> +  - clock-names
>>>   additionalProperties: false
>>>
>>> -- 
>>> 2.34.1
>>>

