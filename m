Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611B1786A49
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjHXIkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjHXIkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:40:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2815D1725
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:40:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98377c5d53eso822385966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692866438; x=1693471238;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/UaKcHZUhyXVf70K1/VQ6KYb+2emfl8SiMEBcp7ysLM=;
        b=F+9jiATMTuLTp0qaxdZRLbHGhZZZLdPVExbAgjK3PXtU+UWaJmNxp8p1x57WSeR+B9
         7xaTqyxBcqOsguNSMs+gwykQgTw+vJ+DtyRV2opX/f9YeV/twrYtuahlpnABE5fGUSV1
         AeDx4TtU8XZefQHPFX/9brrW+Dd4AlYfYvd1EY7H5zgdKI4tPjJf3vMMPH7AKcb15HLQ
         vOrDJpfH1xBN1TVxcMhedhmfdg2LExnFKnuk0d8OM2ELjTrOJa5S8oVARiRXQtKsBRLQ
         v0WnITphs0Z8ZI2o69OQPJhFqtD547CxHMxLnSXnIXEtRf7zLT66VMLf0nyotUjf4LA6
         F17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692866438; x=1693471238;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UaKcHZUhyXVf70K1/VQ6KYb+2emfl8SiMEBcp7ysLM=;
        b=i4ynrNu1bERSS6OTISqqyvcBKU9zZwiNuDaj8l1GPsSmWAP9C/wJGzNulm5w6uNpMo
         nIcny6x5KKToLJGJkiY/I9YZafg4Swn5rMI2lOPVoutU5O9QMqVivsvwS7ucFnDQuHb/
         6CN6BtYQIe7aJ7Kpip+/DwuuwK1gO7F7jbbRMmfqwr8vn5tjeIwZ/uZzi1EPrzYmjUTw
         A5Q35kH6IsWMD+WAkjqfHo15TCMy0HmyCiDv+9n4CQEBtIsLxX7+GJ/ONylh98+ldsO5
         e2XOAJy5YIBHNPUMjUOa94M4Iq7Q03RkEXoErcn7J1W5pwv0z/CEDae7TCH5dtYO+K8b
         QYhw==
X-Gm-Message-State: AOJu0YwJlxjYiaLdw1qBAieMidLn7L/nDA+4UEnDswHANoIWAs7HtoQd
        cs/HjcyUMSOq12t4NjyPYheWqw==
X-Google-Smtp-Source: AGHT+IHXeQMOTE1M95r0xs8MLFAmldX/W1O2dNri4siRCcZfdGqhTjoDpPRitkQ0NoG0TKPdfIXvPQ==
X-Received: by 2002:a17:906:31c1:b0:99e:6cc:79b with SMTP id f1-20020a17090631c100b0099e06cc079bmr11757741ejf.47.1692866438397;
        Thu, 24 Aug 2023 01:40:38 -0700 (PDT)
Received: from ?IPV6:2a00:f41:4882:ba34:4490:938b:eab4:c5ef? ([2a00:f41:4882:ba34:4490:938b:eab4:c5ef])
        by smtp.gmail.com with ESMTPSA id s15-20020a1709062ecf00b0099cd008c1a4sm10642446eji.136.2023.08.24.01.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:40:38 -0700 (PDT)
Message-ID: <21b57b63-c927-4d00-8327-c4105ff5e9b2@linaro.org>
Date:   Thu, 24 Aug 2023 10:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: crypto: qcom,prng: document SM8550
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Om Prakash Singh <quic_omprsing@quicinc.com>,
        neil.armstrong@linaro.org, Andy Gross <agross@kernel.org>,
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
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <6574894d-e7ba-e5cc-a03f-76f97d1403ad@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.2023 08:37, Krzysztof Kozlowski wrote:
> On 24/08/2023 01:32, Om Prakash Singh wrote:
>>
>>
>> On 8/23/2023 1:25 PM, Neil Armstrong wrote:
>>> Hi,
>>>
>>> On 23/08/2023 02:10, Om Prakash Singh wrote:
>>>>
>>>>
>>>> On 8/22/2023 9:34 PM, Konrad Dybcio wrote:
>>>>> On 22.08.2023 16:54, Om Prakash Singh wrote:
>>>>>> PRNG Block on most of newer target from Qualcomm have some 
>>>>>> configuration where clock is configured by security firmware.
>>>>>>
>>>>>> Adding separate compatible string for each platform is overhead.
>>>>>>
>>>>>> We need to introduce common compatible string that can be used for 
>>>>>> all platforms with same configuration.
>>>>>>
>>>>>> I would suggest to use "qcom,rng-ee" for newer platform, dropping 
>>>>>> "p" also signifies it is not a Pseudo Random Number Generator.
>>>>> Please reply inline and don't top-post.
>>>>>
>>>>>
>>>>> Is this what you're trying to say?
>>>>>
>>>>> 1. sort out the clock requirements for designs where Linux manages it
>>>>>     vs where the FW does so >
>>>>> 2. introduce a new compatible for SoCs implementing a TRNG
>>>>>
>>>>> 3. for SoCs in 2., register the TRNG as a hwrng device
>>>>
>>>> Yes to all
>>>
>>> I can send a proposal, but that means writing a new driver for this 
>>> compatible in drivers/char/hw_random/ right ?
>>
>> We can add hwrng support in same driver like 
>> drivers/crypto/hisilicon/trng/trng.c
>>
>> As Krzysztof is suggesting we need to have platform specific compatible 
> 
> That's independent question
> 
>> string, we can go with your change. for hwrng support I will send 
>> separate patches.
> 
> Any bindings decision should be made now. We don't produce knowingly
> incomplete bindings just to change them later. Therefore now you need to
> decide whether you call it prng-ee or something else.
Herbert already picked up the 8450 compatible last week or so.
If we decide quickly, perhaps it can be reverted and substituted
with the non-*P*RNG one. It would theoretically be an ABI break,
but:

a) it would be very very prompt
b) the dts patch hasn't been merged so there are no users

I'd be fine with that, not sure about the rest of you guys.

Konrad
