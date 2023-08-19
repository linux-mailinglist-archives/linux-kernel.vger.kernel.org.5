Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0307819FA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjHSOWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjHSOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:22:11 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AEC61B7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:22:00 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so17209985e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692454919; x=1693059719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAc6qOkjy0rFtaDwsZVWmbF6XPQ2JnI6jdGxzBgS0C0=;
        b=Pl1a4O5dMHVgND2Zxh/FLx+LzcCFwOkjSVL0gC45HVqncybh72Ji6ywdb7C7sSywxh
         tvoq1FKiznHOM29kb6D0YBvIq9MG3JmUapYuP3Ve1JQDHgjc1dgGjFfYVCNztuvZfoED
         lZhtXthP/XKP2uNgi4ziRz5MaR35+xwjwmK2fQ0JA8rRW+wK8pMH7UC2Aaw2FhK50E4G
         5ktm5Xn55gk+++lzeg28gkj0YFP/UfUf6/c/ODb0gQQzTqlsjYgetgJa5zfeZryCjEGs
         EDYH6Yof3rb9XhkTKFHWdVUERY/d1q4mNCPhwoPopaOa7HA9KjqajCKmK2AvFrDFP9eb
         /Y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692454919; x=1693059719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAc6qOkjy0rFtaDwsZVWmbF6XPQ2JnI6jdGxzBgS0C0=;
        b=AghkfUqobZs0GG3NLCX/Pcyo+MPjq1+simD+lb56dy9n4RguAneK2QdegcWjGWEuT9
         qklJ47L2Y0weCbNDbXPmJM2zWIlXC0wdHMlLQT3zXfSBkuESh83xf4DKr6YnTqtjkhvJ
         krizsnI4I6rdChvZphA4OM9VP7MaqiFXIwfgp86+WDbBuK4lPAELomTRhJr+lt3Q+/wK
         E1Bzo1ejlLMiCYWCLdIdtW0oZpfx4EMSrgbLfcaZfV/CTAFNEO6oTZtNTuAcWOUYGJkd
         XtZryg1GSToM37wwbz49K5G58Wl6IclSLdXwUfA7eVGA8geTCB0Ns1BnJKIY1eAcajxi
         pjIA==
X-Gm-Message-State: AOJu0Yx3tyfHoOuMlIoJGVxslQ5If/jHVr2Ie2O1HZgducQuWHKUBa8K
        tF9W8ervgfyQVlQAfpuZTdm8lw==
X-Google-Smtp-Source: AGHT+IHh30rvDXYKhYF93M7r7DS9miQDSTeGLQ293BUQP20NDDVnbhx3Nu3zvHyBroD9wVkQX+U4/g==
X-Received: by 2002:a05:600c:c5:b0:3fe:dcd0:2e32 with SMTP id u5-20020a05600c00c500b003fedcd02e32mr1463788wmm.19.1692454918857;
        Sat, 19 Aug 2023 07:21:58 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c231000b003fc00212c1esm6308313wmo.28.2023.08.19.07.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 07:21:58 -0700 (PDT)
Message-ID: <179d22c0-c20f-7190-0dce-f439669dc232@linaro.org>
Date:   Sat, 19 Aug 2023 15:21:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 12/13] media: qcom: camss: Add support for setting
 CSIPHY clock name csiphyX
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230817143812.677554-1-bryan.odonoghue@linaro.org>
 <20230817143812.677554-13-bryan.odonoghue@linaro.org>
 <5ad949d3-1776-4345-9fdc-99b3dba10bd7@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <5ad949d3-1776-4345-9fdc-99b3dba10bd7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 13:32, Konrad Dybcio wrote:
> On 17.08.2023 16:38, Bryan O'Donoghue wrote:
>> Several of our upstream and soon-to-be upstream SoC CAMSS dtsi declare
>> csiphyX as opposed to the older clock name csiX_phy.
>>
>> For newer SoCs csiphyX turns out to be a clock you really need to set.
>>
>> On sc8280xp for example we will encounter difficult to track down and
>> root-cause RX CRC errors without setting the csiX_phy clock. On sdm845 and
>> sm8250 we declare the csiXphy clock but seem to get away with not setting
>> it.
>>
>> The right approach here is to set the clock when it is declared. If a SoC
>> doesn't require or a SoC driver implementer doesn't think we need, then the
>> clock ought to simply be omitted from the clock list.
>>
>> Include csiphyX in the set of permissible strings which will subsequently
>> lead to the csiphyX clock being set during csiphy_set_clock_rates() phase.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
> So.. is this just a namechange? Is it really necessary?
> 
> Konrad

Not at all no.

We currently don't set csiphyX clocks. That's "not a problem" on sdm845 
and sm8250 "because" but on sc8280xp if you don't set that clock you'll 
get all sorts of RX CRC errors.

Obvs my extensive and detailed commit log transmits exactly no detail.

Let me fix that in the next version.

;)

---
bod
