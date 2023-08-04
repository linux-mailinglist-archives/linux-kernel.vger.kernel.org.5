Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEE3770A18
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjHDUvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjHDUvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:51:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20784C38
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:51:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso23329325e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 13:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691182284; x=1691787084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytf0fYl7y3s90xE10GWsqr8qlrP5SU3wZD0qdEGlqoc=;
        b=WMUbMmCHym2MWewUEGEymY2vgE0ilbwjsaA1pKhhgapZV6TqtVkRpDzrtMUbIN2dyz
         kJeFNOM9GvuMSEZU800iXAru7Y07uX1MbrUic1GH/U9E92lP+GZp7dF5YLPJZP/k1crr
         bgI9xA3hgJu360BLHjUCy38lwhj2r4i3KW+5zNVsfnzyct1j69gMMVrzjDyae/0IZPjK
         V1iD0ckcPsQfLy90X0mxyrTwCI1CPlAGNNsqkzxFvG/dnRGF8Efq1cMS3e2/0EHL64no
         qaXYXrXKq5VN8/c91Mzh3dECKNowQCN8tvqn+gZ7tlSw3DoCH8rFbG7WU6jiL0K3r2zN
         DrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691182284; x=1691787084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytf0fYl7y3s90xE10GWsqr8qlrP5SU3wZD0qdEGlqoc=;
        b=av2+bJOEzuSOFk9mXl9apXk1+IftZhtgPxor386e4xc2ZyF3CSYEjsdrHfZfxiw5A7
         8RkbCMSijNhsrVHJhNiQ7XdxyeMj5ogVcl82XNh2UDH/svPtupytu4uAbEemmi91hFtx
         mSWgjriEjKUkBXD2VwOLVHiqEsltzUG0Uh5vinH5nCrQhPlTjNhRn3hVI3vZdz/fb3JG
         yGGzA7Z0VkyHir30Ufsn6AqRnx9/6wrCz475C71QhXcjBtRNnCz8VpWdwWY/hnqtmxO7
         J7NBpigLdqZAtVoTRkNLxu7HQWXFWpglxAY/JlCdNUR3K6gs1m6aH7uwCPAdnmE1abNH
         0Y9w==
X-Gm-Message-State: AOJu0Yz3bEEu8ESMRVFU9UMPghYW9kWKjFg4RmmEsCu8Yk/BdjbNZhke
        xxEn+HOpQVgJpkIBt0CJkZSUtA==
X-Google-Smtp-Source: AGHT+IGzxeyhmK9nqilKsYEKNHXLOAEigw+w5l8VPYbY1weIKK21xhMMkz5L+XIn0AsFjtgXRkwi8g==
X-Received: by 2002:a5d:4a81:0:b0:317:5b76:826 with SMTP id o1-20020a5d4a81000000b003175b760826mr1826052wrq.0.1691182284080;
        Fri, 04 Aug 2023 13:51:24 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d4009000000b00317a04131c5sm3355263wrp.57.2023.08.04.13.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 13:51:23 -0700 (PDT)
Message-ID: <fdbdbf61-e372-b81d-3a14-7ed27b1249a3@linaro.org>
Date:   Fri, 4 Aug 2023 21:51:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/6] media: venus: hfi_venus: Support only updating
 certain bits with presets
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
 <20230731-topic-8280_venus-v1-3-8c8bbe1983a5@linaro.org>
 <ef61906d-98f2-2806-9ad7-2a99f7928bb1@nexus-software.ie>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ef61906d-98f2-2806-9ad7-2a99f7928bb1@nexus-software.ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 21:50, Bryan O'Donoghue wrote:
> On 04/08/2023 21:09, Konrad Dybcio wrote:
>> On some platforms (like SM8350) we're expected to only touch certain bits
>> (such as 0 and 4 corresponding to mask 0x11). Add support for doing so.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/core.h      |  1 +
>>   drivers/media/platform/qcom/venus/hfi_venus.c | 15 ++++++++++++---
>>   2 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.h 
>> b/drivers/media/platform/qcom/venus/core.h
>> index d996abd339e1..2999c24392f5 100644
>> --- a/drivers/media/platform/qcom/venus/core.h
>> +++ b/drivers/media/platform/qcom/venus/core.h
>> @@ -38,6 +38,7 @@ struct freq_tbl {
>>   struct reg_val {
>>       u32 reg;
>>       u32 value;
>> +    u32 mask;
>>   };
>>   struct bw_tbl {
>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c 
>> b/drivers/media/platform/qcom/venus/hfi_venus.c
>> index 19fc6575a489..d4bad66f7293 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
>> @@ -349,10 +349,19 @@ static void venus_set_registers(struct 
>> venus_hfi_device *hdev)
>>       const struct venus_resources *res = hdev->core->res;
>>       const struct reg_val *tbl = res->reg_tbl;
>>       unsigned int count = res->reg_tbl_size;
>> -    unsigned int i;
>> +    unsigned int i, val;
> 
> u32 val;
> 
>> +
>> +    for (i = 0; i < count; i++) {
>> +        val = tbl[i].value;
> 
> struct reg_val looks like this
> 
> struct reg_val {
>          u32 reg;
>          u32 value;
> };
> 
> val should be declared a u32
> 
>> -    for (i = 0; i < count; i++)
>> -        writel(tbl[i].value, hdev->core->base + tbl[i].reg);
>> +        /* In some cases, we only want to update certain bits */
> 
> I'll trust this is a legitimate and true statement.
> 
>> +        if (tbl[i].mask) {
>> +            val = readl(hdev->core->base + tbl[i].reg);
>> +            val = (val & ~tbl[i].mask) | (tbl[i].value & tbl[i].mask);
> 
> feels like something regmap_update_bits() already does though, I prefer 
> this because there's less code in it.
> 
>> +        }
>> +
>> +        writel(val, hdev->core->base + tbl[i].reg);
>> +    }
> 
> With the val declaration fix
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
