Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497DD8085EF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjLGKxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjLGKxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:53:30 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3A910C8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:53:26 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c09b021daso10180535e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 02:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701946404; x=1702551204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpGhDHfjbYJdmNSdrByuPS2eLFJA5tXn0JMYp6tJZL8=;
        b=pGTbn1Mvu+3TUKkcYC/oUb9ePMtNlqljhXMtT76+q5BgFR6ewbrTGKu6hprEkzYK2l
         MCS5/3c2/vuMN6rDLWteiDDtkwNMJp2ZgMtdfT8fq7k2pfILXfvDtghOqtasWQodHP9c
         UxpJ8BuzQ0ficpHmTY3jvxoE2bIA+0h5E1//i0CxeSRTIDcekhYRZBUJfbMjoL/I/GC0
         r2pjgs/RqbuG4FbzMxqKY9+oPtrHjTq4FficoCOEeE8P0FC/YwWkHCbY8MJpXywtA7IA
         BCQEhtMtGx5tsS/eumulxSea6IxUl2nS+ArTyVJZhWKS2+9ypDOli7fxA4U86IC3jFWa
         fzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701946404; x=1702551204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpGhDHfjbYJdmNSdrByuPS2eLFJA5tXn0JMYp6tJZL8=;
        b=rpEVW6lQdf45AUXHVp9NLhVQSCcX36oIcCLM0XqdiKcGBbwfcSsqQPfmb+sS8ZUJbo
         zskuRlZm0kSKVqjyPfUAgqNzi69MBKPCVW5XM+EvsxXRppEbRElte0Bb1rRKO+i0hhy5
         ryKAU6OvgHbbBHdJ0nKLnjkSUIy/4r8Rq45oQOtKaD59rmRDGU82ayklBpk0ungoSend
         NBKUkmqinMHmM0fiK9bHjsce72aBqbxr9Mek5Y+ZtH3z+UR1JSgDK3ep/kaqY+R0rZzV
         we+4qtGmdFCT1BgdkAm8GCzMLHQNr+911xigpPWg8FfdDOvTR0Z+M8vx9JEhES7oYHNY
         HScw==
X-Gm-Message-State: AOJu0YwiyfbNbgVMZwjXD1M4qHgmoRoHwXAhHHAEtbkZm2CfkQrPLans
        IYI7H4272IhEFLi99KN4ptZmWg==
X-Google-Smtp-Source: AGHT+IE7bnM/WbB4xjPTysNxcDMEOoOW+DgKcUPFyZss2qPbfLz9tN/fmOii/w9Lk5KUxSxxXznWfQ==
X-Received: by 2002:a05:600c:2147:b0:40b:5876:6d8f with SMTP id v7-20020a05600c214700b0040b58766d8fmr1432657wml.20.1701946404261;
        Thu, 07 Dec 2023 02:53:24 -0800 (PST)
Received: from [10.66.66.2] (9.ip-51-91-159.eu. [51.91.159.9])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c1d8100b0040b47c69d08sm1601599wms.18.2023.12.07.02.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 02:53:23 -0800 (PST)
Message-ID: <40cc122e-e5a4-4fba-8b54-2f44d0095406@linaro.org>
Date:   Thu, 7 Dec 2023 11:53:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: qcom,qmp: Add PCIe
 qcom,refclk-always-on property
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_vpernami@quicinc.com, quic_parass@quicinc.com
References: <20231127-refclk_always_on-v3-1-26d969fa8f1d@quicinc.com>
 <78815f1b-7390-40de-8afd-ac71806f4051@linaro.org>
 <24fae40a-453b-b14c-923f-88758a246aa7@quicinc.com>
 <20231201060716.GJ4009@thinkpad>
 <166d307e-7d1b-48b5-90db-9b6df01d87c2@linaro.org>
 <20231201111033.GL4009@thinkpad>
 <f844cd1e-7e4f-4836-bc9a-2e1ed13f064f@linaro.org>
 <20231201123054.GM4009@thinkpad>
 <3a7376aa-18a2-41cb-a4c9-680e735ce75b@linaro.org>
 <c66a93fb-2729-4a86-a2db-f4692f6d0857@linaro.org>
 <20231206130746.GC12802@thinkpad>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231206130746.GC12802@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/23 14:07, Manivannan Sadhasivam wrote:
> On Fri, Dec 01, 2023 at 10:29:11PM +0100, Konrad Dybcio wrote:
>> On 1.12.2023 14:25, Krzysztof Kozlowski wrote:
>>> On 01/12/2023 13:30, Manivannan Sadhasivam wrote:
>>>>> What I said before:
>>>>> "Again, third time (once from Bjorn, once from Dmitry), rephrase
>>>>> property name and description to describe the hardware issue. I see
>>>>> description improved, but not the property name. Again in the end of
>>>>> description you say what Linux should do. Bindings do not describe Linux
>>>>> OS."
>>>>>
>>>>
>>>> You didn't answer my question:
>>>>
>>>> "I see a plenty of properties similar to this one instructing the OS to keep some
>>>> resource ON to workaround hardware issues. So they are all wrong?"
>>>
>>> They are not the best, but it all depends on the individual case.
>>>
>>>>
>>>> If you say they are wrong, why are they approved in the first place?
>>> Because we don't have time to keep digging what the driver is doing and
>>> what is claimed in DT. Some people don't even CC us on the driver.
>> Not sure if I asked this before, but can this not be set in the config
>> struct inside the driver?
>>
> 
> This cannot be the default config for any platform as keeping refclk always on
> will have some power penalty. Only if the hardware (EP or board design) has any
> issue, we can turn on this option.
So, if I'm reading this right, this concerns some but not all
8280 boards?

Konrad
