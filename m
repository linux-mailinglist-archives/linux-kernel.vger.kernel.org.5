Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A4F7896A3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 14:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjHZMRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 08:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjHZMQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 08:16:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF489F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 05:16:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso11004755e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 05:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693052200; x=1693657000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=is7919QAVdROPrOGDGxar6Xf6Q+UtUlpIpadh5E/y74=;
        b=fi8J4JKS6HF94EZuHPwhOsQI5Xt6q2BwOSZwuzEyEbqVlBYrdg66/tHuVcGqMmrMy4
         DSNXH3hwdfT5UTPfFy/HRZyE2XxvK7HsgL7Dn+yLV+3wB/hEht5MXAXeshSJANRwe7Ir
         8WdfqO6ebPtJPpwLaPWU9oapPL4Y7Rdd58TdgWuuQ7Ca+OYaf4n3tRWaltDxfy4CJUtv
         LbL7MaKYB7zANs7Sr2DYKA12HPRL+dX/f7Ycgh+GyP0wwt8+QSJQl/JpJUW8vkGZEZS1
         xdY2NBz7Rh0IHCaYu5rN18FK/exxIeU32f+nxA7CR7SjVT9rHKKc4dsWKIMPEcqoYcop
         kgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693052200; x=1693657000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=is7919QAVdROPrOGDGxar6Xf6Q+UtUlpIpadh5E/y74=;
        b=Txiqgx4oZzkKkbk21BaDf4zUsSuAzjHP8meS+zhbk4I8oHtcDWnm8oQK3KnCSdkL3m
         YUOlQuSwC5OXhGF8b/GO/rOicfQQHonnoGNTRxtcrM+8bFvLACobzydkpV43kqYEk1pn
         8SAcmQ6L/2uI8aXoSlbnyNBlwYiQQO3m/fKF2TsKQymtl7/0v1LueaSp93j1HzwN1VCh
         uG/lC1oRax3rkaZTHSoH2jxGzsDLxTQrcqFp3HLoZaOdEDK8zMouAFqmt76/2KdzljRg
         HuJ79+0AK/OD2tQwK+9Syu3W+DsSzdoW+sbxKmkS6tpWv5J75CPAx4QjPmoqK5QeCZVP
         cOWA==
X-Gm-Message-State: AOJu0YwgEyWNMfIrI/mRw+QA+2wHR/7GisvfXB5r1i3tsOdeDrRsPhLN
        RpyYdE/N8Iu80Wzig8HEWkeY7A==
X-Google-Smtp-Source: AGHT+IF7xMd7p8vk7bHF3KFH1XI0K9COZJPYWGxhtXO/nFSQsqpVQmkZQ/P08vbjbkAAM32fsw8LZg==
X-Received: by 2002:a1c:7907:0:b0:400:ce4f:f184 with SMTP id l7-20020a1c7907000000b00400ce4ff184mr6499950wme.41.1693052200436;
        Sat, 26 Aug 2023 05:16:40 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c029500b003fe1a96845bsm8062462wmk.2.2023.08.26.05.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 05:16:39 -0700 (PDT)
Message-ID: <4d4da439-a3a9-4a28-bac4-91de694e9cb9@linaro.org>
Date:   Sat, 26 Aug 2023 13:16:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 07/15] media: qcom: camss: Capture VFE CSID dependency
 in a helper function
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-8-bryan.odonoghue@linaro.org>
 <a84f33f5-cf46-48ef-a9a9-01acb926c145@linaro.org>
 <b2f8285d-30af-c8b1-92ce-f9370ac55a98@linaro.org>
 <95db5a14-87dc-4f08-b8e2-52bce140354d@linaro.org>
 <bf419311-5931-e8d9-a785-0bf9df3c884d@linaro.org>
 <e2741c4a-983f-4039-b25f-6d3bad1c6cee@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <e2741c4a-983f-4039-b25f-6d3bad1c6cee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2023 13:13, Konrad Dybcio wrote:
> On 26.08.2023 14:12, Bryan O'Donoghue wrote:
>> On 26/08/2023 13:04, Konrad Dybcio wrote:
>>>>>>    From sdm845 onwards we need to ensure the VFE is powered on prior to
>>>>>> switching on the CSID.
>>>>> And what's the symptom if we fail to ensure this? How can someone
>>>>> adding support for another platform tell whether the match-list
>>>>> should be expanded?
>>>> That person has to understand the dependency.
>>> If we need this workaround, there surely must be something that doesn't
>>> work without it, a measurable symptom. What is it?
>>
>> The CSID lives inside of the VFE therefore the VFE must be power prior to the CSID.
>>
>> The symptom will be .. the CSID doesn't come out of reset.
> Good, that's what I needed to know.
> 
> Now we can rename that function to something like camss_csid_inside_vfe()
> to make it more meaningful

If you feel there is a meaningful distinction between 
"csid_depends_vfe()" and "camss_csid_inside_vfe()"

I'm happy to humour you.

---
bod


