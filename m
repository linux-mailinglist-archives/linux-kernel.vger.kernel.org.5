Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC167C4236
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbjJJVRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjJJVRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:17:45 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40EB99
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:17:42 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c16757987fso77458011fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696972661; x=1697577461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sfPPZRlM0sZJ4h/LKs3xYdXAHRzh/EkwJVhNrGIegO4=;
        b=PRPJAzIl3OSfyWPD+RROliQUJclRflqJjOIGsnhKgrW8xIm2LsoQhCSjA0KFWEg3wf
         ZdjH2SAB5vapBHo907gptGVcQfpYNGEtthxHkjr+8N4O8/QzeL02Epd9KcJM2cj28oOV
         W1H2vW9K8X8JcVIhgpusAERTvNvLLKzOr1+FjSqldxg1tA2PPYdaJM84kE01inWthGuK
         5jHr2hWJrQRgercPhq3XMVrr3uxVmdQlOda5RMX5uOd+7uizgUEE09nDHH9bJau0B+0X
         GbexbUYaZsuOSVx/Vam7WaGw64e72dUO5VF+v2CCDfPTlasElzKhs0IUU6XyCC7a9KNP
         WCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696972661; x=1697577461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sfPPZRlM0sZJ4h/LKs3xYdXAHRzh/EkwJVhNrGIegO4=;
        b=wMDyMD2TaIHBal+9KMVQw5uu42fKCx1796HK+cs16ncPEYMwJZu//COEbfapy9lyNU
         bCd5lMjZ510007JVISRkrGXKZa9aBr+50I/6ZdcVdMYUWs/S4a07bB4HcJ/TPjj5Ghw5
         qYf2pvdljx7IDA5OGY5Md7meWNtEKSQv9K9H8938TnbWfSuSiF6U+OCLIEoEPQnEqJWm
         /jVMCJxGa/4mWqOPeCkoeqoJlXlACI7EOuYFvZEDk0H07M4+CgzhO97SnHyU0GUEd5po
         jOg9qry1JyXwRDSkUuvIZXuTHqBxFqAmAg0H6X4cyA5Cf+b87ihonnhLxX8aJSYfg9Px
         6wIw==
X-Gm-Message-State: AOJu0Yw7Zm9rdgwkUJUXQC6z6epqQ0rXVSnkpaZwRKj/j2D/bdZTuDek
        hNA57HPAboK4YXW4FJE4qLoaeQ==
X-Google-Smtp-Source: AGHT+IE17AcOeX7TjeVmVy16OgaWTbvrISmCORBUxeyPmJNXOebBZLa36qc+DxwvzaNoWReKy2wgog==
X-Received: by 2002:a05:6512:3ca4:b0:500:b5db:990b with SMTP id h36-20020a0565123ca400b00500b5db990bmr20891808lfv.47.1696972660557;
        Tue, 10 Oct 2023 14:17:40 -0700 (PDT)
Received: from ?IPV6:2a00:f41:8004:ab80:24a8:5e5d:e0b2:5884? ([2a00:f41:8004:ab80:24a8:5e5d:e0b2:5884])
        by smtp.gmail.com with ESMTPSA id z3-20020ac24183000000b0050335c6d091sm1959755lfh.79.2023.10.10.14.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 14:17:40 -0700 (PDT)
Message-ID: <3c3c80da-8986-4a8b-8b53-c33b36107e95@linaro.org>
Date:   Tue, 10 Oct 2023 23:17:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] ARM: dts: qcom: ipq8064: Add CPU OPP table
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230930102218.229613-1-robimarko@gmail.com>
 <20230930102218.229613-4-robimarko@gmail.com>
 <e255dcbd-6342-49e6-9bfe-17a47b2a3c8a@linaro.org>
 <65255c81.050a0220.141f8.7b8f@mx.google.com>
 <1aea4a86-7f7c-46ee-9cbe-655eb7663c2a@linaro.org>
 <6525ad59.1c0a0220.e3509.8545@mx.google.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <6525ad59.1c0a0220.e3509.8545@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/23 22:00, Christian Marangi wrote:
> On Tue, Oct 10, 2023 at 09:52:50PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 10/10/23 16:15, Christian Marangi wrote:
>>> On Tue, Oct 10, 2023 at 03:40:32PM +0200, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 9/30/23 12:21, Robert Marko wrote:
>>>>> From: Christian Marangi <ansuelsmth@gmail.com>
>>>>>
>>>>> Add CPU OPP table for IPQ8062, IPQ8064 and IPQ8065 SoC.
>>>>> Use opp-supported-hw binding to correctly enable and disable the
>>>>> frequency as IPQ8062 supports up to 1.0Ghz, IPQ8064 supports up to
>>>>> 1.4GHz with 1.2GHz as an additional frequency and IPQ8065 supports
>>>>> 1.7GHZ but doesn't have 1.2GHZ frequency and has to be disabled.
>>>>>
>>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>>>> ---
>>>> Christian/Robert, can you provide a downstream source for this?
>>>>
>>>
>>> Sure, consider that everything is with +/-5%.
>> Hm, so you're e.g. putting ipq8062 384MHz voltage for PVS3 equal to
>> 0.95*800000 = 760000, but I'm not sure if it's a good idea?
>>
>> The comment in downstream:
>>
>> "These are based on +/-5% Margin on the VDD_APCx that is advertised in our
>> Datasheet across Temperature"
>>
>> suggests this is already not very accurate, and betting that the lower
>> threshold works on all chips is probably not the best idea.
>>
> 
> Consider that everything is driven by the rpm. The original qsdk used the
> same approach of taking the value, apply +-5% and pass it as a voltage
> triplet to the rpm regulator. Also the driver have ranges so it
> autodecide the best voltage in the range of the voltage triplet based on
> the one supported by the regulator. Normally the normal voltage is
> always used.
Eeh? So you pass any half-random value to it and RPM edits it in flight?

Please be more specific, I'm not very familiar with this platform

Konrad
