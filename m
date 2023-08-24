Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B779F786795
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbjHXGiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbjHXGhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:37:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438CB10F9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:37:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bed101b70so827259666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692859061; x=1693463861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5fZt6Ihkc3G2cDG6LVOei+M0bpuMD5Ug5ycUdw4MKc=;
        b=wx45oOvnvkIna3h2LmYOLydvEnXg4o46Qs99Rkl3mS6KUN/wwOirMjfMi1lppx+HS2
         OAufrP5OD4sc1QbIxkXhFfAJxxsdTiKrcDeduQ3yXzO+7LCc9m4Gi2t/wOwBb325g1Bu
         QksGYMpB5QpFBjtyk8n7f8832dbhzPKbb9liqtMxod7Xdi7IQIOeRDo8sHYeRNumD7tm
         YCQ90uZ9IUVHQIzxSS3UbkhSaujbed52S2Sfdh9szzbYCmls7Eq6mYKFc+wSCb/M5pjV
         iGmmLof3Wf3Le3rabIyaTScmSAhXoFtI9n+IDiiuPB6MONRQHc23/u7HBwX4mj42CrrI
         yQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692859061; x=1693463861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5fZt6Ihkc3G2cDG6LVOei+M0bpuMD5Ug5ycUdw4MKc=;
        b=ZJfPcXG+JzZb6Ht9p9xpUIm+byQ8Xi11JS1oqDC/E6s+bvzZF0X9zumULd6T+kLOsV
         FLZEa06NFtPosxo4h8A5YYBWswcRYcbW0s0K+Atj/twurKMnLn2Ga3jpKMuez+3IYNQ5
         Wz/6FtR2PubaAVxnUSZ1OhhJC5kJ41vQwdlaXExuj9po0SIvLu7Kpz5j+oiY79u5+b2z
         rdcqoi8LXUk1h8fGvTVT8dJINqAAS8X8BQaOhRrbF9Z4GZMsx1x0Ze83kEvj7m7/H8J5
         kCnW4JKVdeD8YfWiyLtTVYyu78JMVXXn6ZjBJva9O0pAaYCpepm7uHUTf67TvOSLjRst
         TZFQ==
X-Gm-Message-State: AOJu0YwwUKab8DezaaCDieakGHGNajkzbXbmN8s7j7SuS2hoc8C8sYLv
        02gcq3MVpmGYnL3mRWeosMlBUw==
X-Google-Smtp-Source: AGHT+IGoDmzSJBNnU9nBS0McctkvqxjQkn8ai4uzfqjiY8PRizioW/1k/iggqzE+u4Fi0nsu6nS7+w==
X-Received: by 2002:a17:906:5347:b0:9a1:ec69:23ec with SMTP id j7-20020a170906534700b009a1ec6923ecmr2562516ejo.17.1692859061599;
        Wed, 23 Aug 2023 23:37:41 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709064f1000b0099297c99314sm9616794eju.113.2023.08.23.23.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 23:37:41 -0700 (PDT)
Message-ID: <6574894d-e7ba-e5cc-a03f-76f97d1403ad@linaro.org>
Date:   Thu, 24 Aug 2023 08:37:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: crypto: qcom,prng: document SM8550
Content-Language: en-US
To:     Om Prakash Singh <quic_omprsing@quicinc.com>,
        neil.armstrong@linaro.org,
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
 <dd3d28f1-ff5e-49e6-a9f7-0ec9265017cc@linaro.org>
 <d44be821-228b-4035-aa1e-c4f58db90422@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d44be821-228b-4035-aa1e-c4f58db90422@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 01:32, Om Prakash Singh wrote:
> 
> 
> On 8/23/2023 1:25 PM, Neil Armstrong wrote:
>> Hi,
>>
>> On 23/08/2023 02:10, Om Prakash Singh wrote:
>>>
>>>
>>> On 8/22/2023 9:34 PM, Konrad Dybcio wrote:
>>>> On 22.08.2023 16:54, Om Prakash Singh wrote:
>>>>> PRNG Block on most of newer target from Qualcomm have some 
>>>>> configuration where clock is configured by security firmware.
>>>>>
>>>>> Adding separate compatible string for each platform is overhead.
>>>>>
>>>>> We need to introduce common compatible string that can be used for 
>>>>> all platforms with same configuration.
>>>>>
>>>>> I would suggest to use "qcom,rng-ee" for newer platform, dropping 
>>>>> "p" also signifies it is not a Pseudo Random Number Generator.
>>>> Please reply inline and don't top-post.
>>>>
>>>>
>>>> Is this what you're trying to say?
>>>>
>>>> 1. sort out the clock requirements for designs where Linux manages it
>>>>     vs where the FW does so >
>>>> 2. introduce a new compatible for SoCs implementing a TRNG
>>>>
>>>> 3. for SoCs in 2., register the TRNG as a hwrng device
>>>
>>> Yes to all
>>
>> I can send a proposal, but that means writing a new driver for this 
>> compatible in drivers/char/hw_random/ right ?
> 
> We can add hwrng support in same driver like 
> drivers/crypto/hisilicon/trng/trng.c
> 
> As Krzysztof is suggesting we need to have platform specific compatible 

That's independent question

> string, we can go with your change. for hwrng support I will send 
> separate patches.

Any bindings decision should be made now. We don't produce knowingly
incomplete bindings just to change them later. Therefore now you need to
decide whether you call it prng-ee or something else.


Best regards,
Krzysztof

