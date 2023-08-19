Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111A6781A39
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjHSOtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjHSOtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:49:06 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D498E24C2B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:49:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so17911955e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692456542; x=1693061342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Lai3lzaFQcOUlX6NwcBkA21aZzV1McYrSxoq4Xf4Is=;
        b=rBA5slir7cZwcjlaP9ww09Q0nNEk9Z0XhnobTPrvB36uqFHtJ+LAexCZlRUT9jAL+b
         vQIAa1Mt7zdsnL+hSZTQY8zWbwnvU5gfvbkcI88jNVSxg+8BsZB8K6Ru69gfT9RLCpMw
         jo3wIncGMDEPCEaw9JQLGR2Dk91ThaxnMnMG+1Fe89wfi/pIHPP+mGOwrulAldq09/wK
         G6kHLkpcwjGu2sp/kK+bLscifIPPCo+CcCAg9s9amureCazRiwzTEAqZY+EgKTGn1o70
         FXOG5JlM1r+Y/gIeOBdocI2ihY4PKC8M5VOyANWF+NZ4uqzSONOBA5g3jM4myK6titGH
         DJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692456542; x=1693061342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Lai3lzaFQcOUlX6NwcBkA21aZzV1McYrSxoq4Xf4Is=;
        b=VuOgGE+l3ZPw0Gs2Krtd6gzJEn8+rnRus4JXj10Rf9hkrXEPUeTx7YPo4MCFzLKMdv
         S/1VC5kAyApKQAhvsNF0TMfN7lx4W5Hh5u44aifT0mszv8i6VdOlLOZKPOOXdtlTi7z2
         8ky319HeK9N6mIbJuSefrwttseNeqUiirjoYJ0CRtN8SXzAieYkGyfxP6LMnR+RypSlk
         LYBD8l0ZQX+l6ptJhPuDaBQkulxxoKQPHQK0O36f5S/lhGhcEwDb1Tm1H5jiPzmkNL8d
         fpT607auyGOxAa9eEAYggPmOmlfiyDzWpFOAcyNkgSYMnT8Mtbb2c7Nd/5NeIQdCLchm
         lu5w==
X-Gm-Message-State: AOJu0Yy7wqqbPciB+DQWSc85gwA5Fmop+Xv8n8oi39b7AjYVFUUxtbij
        ARMSh7plJ52hthxUiGrYCOoa4A==
X-Google-Smtp-Source: AGHT+IHJzDhBNu7ctb++Jk4VjdxyvgJXY12TA1cbQ4ejANvmXaRByQ78dFXro7q5SEymjActnoFF4g==
X-Received: by 2002:a7b:c3c2:0:b0:3fe:df1:5b95 with SMTP id t2-20020a7bc3c2000000b003fe0df15b95mr1601934wmj.19.1692456542262;
        Sat, 19 Aug 2023 07:49:02 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s14-20020a05600c044e00b003fa96fe2bd9sm9856581wmb.22.2023.08.19.07.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 07:49:01 -0700 (PDT)
Message-ID: <9e2c597b-171c-448a-b696-382da9834a4f@linaro.org>
Date:   Sat, 19 Aug 2023 15:49:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 10/13] media: qcom: camss: Allow clocks vfeN vfe_liteN
 or vfe_lite
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230817143812.677554-1-bryan.odonoghue@linaro.org>
 <20230817143812.677554-11-bryan.odonoghue@linaro.org>
 <f0f55093-585f-4270-8ced-2c92a4808c9b@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <f0f55093-585f-4270-8ced-2c92a4808c9b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 13:30, Konrad Dybcio wrote:
> On 17.08.2023 16:38, Bryan O'Donoghue wrote:
>> The number of Video Front End - VFE or Image Front End - IFE supported
>> with new SoCs can vary both for the full and lite cases.
>>
>> For example sdm845 has one vfe_lite and two vfe interfaces with the vfe
>> clock called simply "vfe_lite" with no integer postfix. sc8280xp has four
>> vfe and four vfe lite blocks.
>>
>> We need to support the following clock name formats
>>
>> - vfeN
>> - vfe_liteN
>> - vfe_lite
>>
>> with N being any reasonably sized integer.
>>
>> There are two sites in this code which need to do the same thing,
>> constructing and matching strings with the pattern above, so encapsulate
>> the logic in one function.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   drivers/media/platform/qcom/camss/camss-vfe.c | 22 ++++++++++++++-----
>>   1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
>> index 8f48401e31cd3..73380e75dbb22 100644
>> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
>> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
>> @@ -437,6 +437,20 @@ void vfe_isr_reset_ack(struct vfe_device *vfe)
>>   	complete(&vfe->reset_complete);
>>   }
>>   
>> +static int vfe_match_clock_names(struct vfe_device *vfe,
>> +				 struct camss_clock *clock)
>> +{
>> +	char vfe_name[CAMSS_RES_MAX];
> VFE_MAX?
> 
> the current value of 17 would be very excessive for VFEs!
> 
> Konrad

Solving these generic and large struct resource strings is something I 
plan for another series.

Good enough ?

---
bod
