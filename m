Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC67758D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGSGPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjGSGPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:15:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7C52710
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:15:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992b2249d82so908451966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689747302; x=1692339302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QMvfRl+bFLnpDnr5W6RMYDLuRVuKpZRmCG+6llzz95M=;
        b=VLTH+DOnshchuB2xlx/FFJgRWxt/YD2QgTnB0I1yKYULYkkhwdFJDLCIxORtuad49n
         k9BU7OTaFXzCOlBQlCzUi4pkjcMk/TiLheks4ICpbHTyzEPC1HDAeChcn1Ua3aWJ4HzW
         MjrqEg6y0cfbFoYhseMFk5lFfkK8ckfXaSLHOIA/p63zGbIMQX3wcVvE10fYWpwnFI+M
         NCLnIGlMZr40VAHZf3B1ma+wC3NGRQNpkWScRUXpqF9jtxv9Zl3+CaA68q8I42Y8XLcG
         A8EkQmM1lMfQ+P2OHodMKG1TKW4H1VZJTIJpZih1B6Z4rA0yXbKD1ssk1VEvDcwCY6KK
         IBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689747302; x=1692339302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMvfRl+bFLnpDnr5W6RMYDLuRVuKpZRmCG+6llzz95M=;
        b=g5UbM3mUsmNsWSGsnqP0MVBUeTBEuEXJ8aJHBOH85US2xeBCvj2UfYodoISs3Ibf8m
         s51M+74dN80WUW7MFxXWJO/eclR1vneClaFpvbCFPvI7X7FqJREGGlDxo4Hrib8PwffS
         qW6w8I1C32W4onBnKW4DrbrRdZ22hXgOKkOZilGvHZOH2CuDgKP092S5hYNb/75Iw4bm
         qU4EsK+0tlQ96FTqHerAu7IntkpIjw1v0giCicQ92sNGPmUh+sFUQ2wnkrIdbrCLKY1f
         YkVYIuOj9i1GZQz5bOovbxYXHmnR/5sWlgl70CU+mPMBdIiJZpnY5j0LWe1deI5Q8sAU
         Fsqg==
X-Gm-Message-State: ABy/qLbWBX69Qyd+7iQvPWT3Rahx5FDTAq5g0CSnmj+FI1pCi2teiLJV
        r3bTmxYhfQbNlz+R/Rlha5VHLw==
X-Google-Smtp-Source: APBJJlGRZZZmnc820slF8HKlmYeUENYJ9xkHTkllvLchrlFNSUlR/DU+Ey8nLunz22xs2vX6ELok7g==
X-Received: by 2002:a17:906:5303:b0:992:6064:f32b with SMTP id h3-20020a170906530300b009926064f32bmr1240291ejo.46.1689747302125;
        Tue, 18 Jul 2023 23:15:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709065e4a00b00992d122af63sm1858050eju.89.2023.07.18.23.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 23:15:01 -0700 (PDT)
Message-ID: <6faf3d1d-f05f-4d28-82d9-32c8e22fd29b@linaro.org>
Date:   Wed, 19 Jul 2023 08:15:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Add qcom hvc/shmem transport
To:     Nikunj Kela <quic_nkela@quicinc.com>, sudeep.holla@arm.com
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230718160833.36397-3-quic_nkela@quicinc.com>
 <d9d5ffd5-6f85-f091-5d69-12cdd8d04c99@linaro.org>
 <3ae2d618-490a-06da-b4b6-b5a24b0a9747@quicinc.com>
 <ec3d7769-8a5f-d938-7f77-351ddfe6fb45@linaro.org>
 <e8399fcf-e0d8-cc31-d9a7-b0f4f7cc3e71@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e8399fcf-e0d8-cc31-d9a7-b0f4f7cc3e71@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 23:16, Nikunj Kela wrote:
> 
> On 7/18/2023 11:42 AM, Krzysztof Kozlowski wrote:
>> On 18/07/2023 20:25, Nikunj Kela wrote:
>>>>> +
>>>>> +	scmi_info = devm_kzalloc(dev, sizeof(*scmi_info), GFP_KERNEL);
>>>>> +	if (!scmi_info)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	np = of_parse_phandle(cdev->of_node, "shmem", 0);
>>>>> +	if (!of_device_is_compatible(np, "arm,scmi-shmem"))
>>>> You leak here reference.
>>> Wouldn't the devm_* API take care of that implicitly? It is same in
>>> smc.c as well.
>> Thanks for bringing my attention to this. I sent a fix for smc.c. Fix
>> your patch as well, please.
> Thanks, I thought you were referring to kzalloc cleanup. Will include 
> this fix. BTW, you may need to fix mailbox.c as well.

Indeed, thanks.

Best regards,
Krzysztof

