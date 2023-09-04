Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680EA791CA5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbjIDSQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjIDSQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:16:12 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9E212A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:16:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50098cc8967so2684137e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693851365; x=1694456165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wR4BXGPTZ7jEwQgwR6LtNXRwZm81M4EzJdY3O3FTYcE=;
        b=qIiyKogZAcWQDObmdrrhVDa+c5nfjD0qJVeWyvssGgdAWVbkWyDsM3pMBFNbhcjmr/
         NXBs4cQpDmA6MPghxyJ5mE+EWZnP+M0I1dQELfwdjVJTsa1OcBdJ8C/OvmmRXxgRtNHr
         aNz0TLUbfbLiKZ0XgPF49Ls+H8yvFTXsDTVKU1+s/CEBB/zjvwX/h2+w46A/9sxqaUyX
         1mo5Q2s5M8qpI51oaBHAWrar++cdAD0lfPJOgsoxfZN+5eUxXO/haFyqeYwO+XbbjYZI
         dSX24agy4mrdofbPut1jymhBvhkRQvLq+4VIzLlEEg1903V1NOl4tSoUSHUHXaBqHVco
         8+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693851365; x=1694456165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wR4BXGPTZ7jEwQgwR6LtNXRwZm81M4EzJdY3O3FTYcE=;
        b=Lw/rS+9Sa3gSIPfic0cfzhEf8BC/XpQ/RUL+gKgwa89FcRNaAePhOXZYQekzLa2dYC
         WmiRPii3QM0DgBlQwZLI927t/uk0YTL/QBTAKPVVVH/Gb/6xsVK9/UHGLkbKsLGeGy9j
         PGNbJR0kajnUPQ1Qh5Lm++MVMXkBriHQRs7fusnDFMGUflU1auJnkJH1av/BibWBYxqZ
         OrpDaS8uQhwbXtTmkjMTaThnG45P+p3aYS0CSFj8YR0Ix5u6P5VOjy0JMopQ7sbgIGwQ
         JNNQhG2cIIbR2qkdn3vVc24BBeG5VIwZPOCaj6Mr7MROH3zCzZ/79ygaE7OmW3pJiA2X
         /yfg==
X-Gm-Message-State: AOJu0YyrmS5NOr5/o2XkKGEtqdTWZ1D/P28RGcUXbUP/WJVzFbaoRyhn
        OIQXKHVvYEEqBdOM5d+Hlw21jw==
X-Google-Smtp-Source: AGHT+IGOzVvReOCQRwsTm34zqkP1CrT7EuD+QTmlY3J+mbZpQaV3Dv35X98KyzB9hnzgcZ0+juBbGA==
X-Received: by 2002:a05:6512:108d:b0:4ff:7f57:facd with SMTP id j13-20020a056512108d00b004ff7f57facdmr8447633lfg.54.1693851365059;
        Mon, 04 Sep 2023 11:16:05 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id kt8-20020a170906aac800b0099cb1a2cab0sm6512298ejb.28.2023.09.04.11.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 11:16:04 -0700 (PDT)
Message-ID: <246760a3-3230-e14d-0541-72d8f0da5fd2@linaro.org>
Date:   Mon, 4 Sep 2023 20:16:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] hwspinlock: qcom: Drop unused qcom,ipq6018-tcsr-mutex
To:     Vignesh Viswanathan <quic_viswanat@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ohad@wizery.com,
        baolin.wang@linux.alibaba.com, linux-remoteproc@vger.kernel.org
Cc:     quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
References: <20230904055010.4118982-1-quic_viswanat@quicinc.com>
 <20230904055010.4118982-3-quic_viswanat@quicinc.com>
 <17c8ba39-2bcf-5799-13ff-bb96249dbf61@linaro.org>
 <880706cd-0987-47c7-8785-f8e4cb1c1907@linaro.org>
 <90795790-a5e4-419f-9e40-989731c1c685@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <90795790-a5e4-419f-9e40-989731c1c685@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 18:09, Vignesh Viswanathan wrote:
> 
> 
> On 9/4/2023 9:31 PM, Konrad Dybcio wrote:
>> On 4.09.2023 08:42, Krzysztof Kozlowski wrote:
>>> On 04/09/2023 07:50, Vignesh Viswanathan wrote:
>>>> qcom,ipq6018-tcsr-mutex maps to incorrect config of IPQ6018 and is
>>>> dropped from the devictree.
>>>
>>> No, it is not dropped.
>>>
>>>
>>>> IPQ6018 will use qcom,tcsr-mutex compatible
>>>> string.
>>>
>>> No, it will not.
>>>
>>>>
>>>> Drop qcom,ipq6018-tcsr-mutex compatible string from
>>>> qcom_hwspinlock_of_match table.
>>>
>>> Why? Do not write what you are doing here, but why you are doing it.
>> More importantly, looks like the ipq6018 compatible was added after
>> support for this SoC was introduced (see f5e303aefc06 and 5bf635621245a),
>> so if it's going to use of_tcsr_mutex data with the fallback compat, the
>> SoC-specific compatible can be removed from the driver.
>>
> Hi Konrad, Krzysztof,
> 
> I was planning to update the SOC-specific compatible for IPQ6018
> qcom,ipq6018-tcsr-mutex to point to of_tcsr_mutex data in the of_match
> table in the hwspinlock driver in V2.
> 
> Do you think this would be okay? or should I go ahead with removal of
> IPQ6018 specific compatible so that it falls back to of_tcsr_mutex?

Remove, it's not needed in the driver.

Best regards,
Krzysztof

