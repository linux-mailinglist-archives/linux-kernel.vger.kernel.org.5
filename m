Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80B8764FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjG0JcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjG0Jbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:31:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE232D7B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:22:50 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-522382c4840so951735a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690449769; x=1691054569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wWq2qcXELyjYs8kivGpWt0fmM+O79pgdalmeBrWboJM=;
        b=aAwmD3jyJ9ZtjCjJDAQtaLUEYeocUAu7OD9C/M36ms0/qiZXtNU8ZP7eW5TPP4Lb26
         XjeHvA+1PrWhvATzm6lasKVMXTOh8LOckI34cr482ejNI2u8Rl7cIQYP5wgVJTihsXLr
         C0eoNna88fH+oyYWMz9ffbCMC2Xa8l+kBk3MFDplzEb7ekpf+KWGgmfpCzh2Gspe7wzY
         kEfRUCVaNWPhDu1UUIelVJyRkI+ayVtoPT5pGXb9FzWeJwsaPs3aJX4uu2TURbEtxyl9
         qVn4wKoPOoehVlSB9kOh+x9ilNSiIMtSywaws2hpykFWYxwP35ovt0vDRvDEECkoyGKW
         LmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690449769; x=1691054569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWq2qcXELyjYs8kivGpWt0fmM+O79pgdalmeBrWboJM=;
        b=ChtmaA5me0RDiYLWC6ryYtIxsXcCY/Xe/aqe7S8jVQ4aSBQufe1AVOm/OKAThST8T5
         /V3TIQDq1S5dnMigmG7qU3SeAFXrOZTZ/EcasfUas9v8jmFDGhzPAetWnb/1/cboeyk7
         C12xHc/aSU6zGhvSO+lzbV+SIp4Ad5AkOUC3IWsL1zurgyRF497eZE+a5uhApmwQvrFG
         JOTvaOWyhkSsLswbr1IRhwJ9pt8O9HjoZcwGGW6ySEndj++l2zgqom0+F9wCGRe/E9DN
         yorJsnaGooS7QljAXfCzEdNmI554GyAIiQhqwC7zPEBLN4MeTYGw/TaYZb6V4e4tMUYl
         2zrg==
X-Gm-Message-State: ABy/qLb5gXKAbzwICEyD2JUvGQ7C+w4PPP794p9GDnsMgO2jK+pHxI9h
        Lfs/oKacqtZuFRJsVUazAiRygQ==
X-Google-Smtp-Source: APBJJlEDlcOoXaBbJWsdekUHxxD/5D8F/XozEaYq6JRjSZCXlthM2wfd1BMxYLK+BMKQclJesZ1Phw==
X-Received: by 2002:a17:906:7a5d:b0:993:e9b8:90ec with SMTP id i29-20020a1709067a5d00b00993e9b890ecmr1437323ejo.22.1690449768676;
        Thu, 27 Jul 2023 02:22:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id va16-20020a17090711d000b0099bc0daf3d7sm529996ejb.182.2023.07.27.02.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 02:22:48 -0700 (PDT)
Message-ID: <a27ad44c-bbc9-0a2e-44fe-ee9b787d0cd4@linaro.org>
Date:   Thu, 27 Jul 2023 11:22:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/3] input: pm8xxx-vib: refactor to easily support new
 SPMI vibrator
Content-Language: en-US
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org,
        dmitry.baryshkov@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_kamalw@quicinc.com, jestar@qti.qualcomm.com
References: <20230725054138.129497-1-quic_fenglinw@quicinc.com>
 <20230725054138.129497-2-quic_fenglinw@quicinc.com>
 <5dd56c31-7ca3-dd39-0623-e4fd18ac6f68@linaro.org>
 <053c9571-d709-2826-fced-a00dd7255b8b@quicinc.com>
 <2a09e743-7423-65b0-c70d-87ae8105182a@linaro.org>
 <4e416602-8dea-fa6d-d083-f93b730552c3@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4e416602-8dea-fa6d-d083-f93b730552c3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 09:43, Fenglin Wu wrote:
> 
> 
> On 7/27/2023 3:07 PM, Krzysztof Kozlowski wrote:
>> On 25/07/2023 08:16, Fenglin Wu wrote:
>>>>>    
>>>>> -static const struct pm8xxx_regs pm8058_regs = {
>>>>> -	.drv_addr = 0x4A,
>>>>> -	.drv_mask = 0xf8,
>>>>> -	.drv_shift = 3,
>>>>> -	.drv_en_manual_mask = 0xfc,
>>>>> +static struct reg_field ssbi_vib_regs[VIB_MAX_REG] = {
>>>>
>>>> Change from const to non-const is wrong. How do you support multiple
>>>> devices? No, this is way too fragile now.
>>>>
>>>
>>> The register definition is no longer used as the match data, hw_type is
>>> used.
>>>
>>> The last suggestion was getting the register base address from the DT
>>> and it has to be added into the offset of SPMI vibrator registers
>>> (either in the previous hard-coded format or the later the reg_filed
>>> data structure), so it's not appropriated to make it constant.
>>>
>>> I don't understand this question: "How do you support multiple devices?"
>>> For SSBI vibrator, since all the registers are fixed, and I would assume
>>> that there is no chance to support multiple vibrator devices on the same
>>> SSBI bus. If they are not on the same bus, the regmap device will be
>>> different while the registers definition is the same, and we are still
>>> able to support multiple devices, right?
>>
>> No, you have static memory. One device probes and changes static memory
>> to reg+=base1. Second device probes and changes the same to reg+=base2.
> 
> Thanks, got it.  I can update it with following 2 options:
> 
> 1) keep the register definition in 'reg_filed' data structure and make 
> it constant, copy it to a dynamically allocated memory before adding the 
> 'reg_base' to the '.reg' variable.
> 
> 2) Define the register offsets as constant data and add the 'reg_base' 
> to the 'reg' while using 'regmap_read()'/'regmap_write()' functions.
> 
> which one is the preferred way?

Depends on the code. I am not sure if 2 would work with regmap_fields.
OTOH, I wonder if the device could just create its own regmap instead of
using parents? Then there would be no need of this offset dance.

Anyway, adding offset only for some variants seems also not needed. You
should add offset to each variant, because each device has this offset.

Best regards,
Krzysztof

