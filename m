Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37746779755
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbjHKSvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjHKSvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:51:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF7130E7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:51:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3178fa77b27so1923391f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691779897; x=1692384697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2lYXuE02j91F0moaINbTxVB9Ro/dijvTyvH0FgFF8u0=;
        b=fdQwhjh51Ob8dONzOiJTP1pAy3TwwscvZM9WZTkAu9AGB+/RBuQnMWXQI/4cuvarSA
         NT+uXG3RNzai4GCjhM9Cs5uhCt7vkvZkgpdsG6H1Fl9dCBvf0XFWPtd60pB6TJAGV2x4
         lcZVa1EsQdA44kEMjFWev4/h/MBqoEjyYuRkLDPlfdvbFVWarkSwrF7YLScSsxWgllvp
         ihW/xNjtquXtVHbW+gCbZS6OG/qdWw2O0FVwxWf3SicxGSd9GgfQ/Jt0KbREEtUKiLmT
         kPPjSJn409MQWPiFZKhUyfBoUIWF6VS8ND2A9hlK42yiTx7S0Xw/GbuvOAa0r46ym8Q9
         rBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691779897; x=1692384697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lYXuE02j91F0moaINbTxVB9Ro/dijvTyvH0FgFF8u0=;
        b=cxxpwLvyK6cxvqrO92fwOLJkBbz5vwGulivS8rnkt7c6jkbisT7n558fQBoNauS5t5
         zOThGmgL8qLjN5Wvzz/1j+iXYHYIyDC/A4Mf2pxFOWrkAa4HB26soGLrcXGPjjHn4SXv
         8ISb30FNSRZNEiV+vSIoEVOtYNJY3LfOk4RN3Rm9KVhb/EQekXBDwNau9x/xp8YoQAn9
         N88khPoZ5q314m3WR87vWMjIk9UjdwXgYWaUqzE81j5Y0p1Og1UqYKSIJFXvrvOUVZdM
         2Yvh0rMw4ynBiW9rEH3rCF0oXJhij6Hhcf8tnNaWzFCZ15UHxVWPncl5qYZrEPe3YtK4
         eQzg==
X-Gm-Message-State: AOJu0YxiLH/YWin/lNajHl43CFF6P8o0gkFHfIUDngXbxOK6Am08gROf
        slnHDz7VEtDpIJ0z2VZiM1SdSA==
X-Google-Smtp-Source: AGHT+IEAEJuxIUKWC3WJ/HOppW6yQAqoA+RJGb5Im8zRH74d7KrLg9HqLd0jdWh1BAAFRjVjGV3Z7g==
X-Received: by 2002:adf:e8c9:0:b0:314:3985:b291 with SMTP id k9-20020adfe8c9000000b003143985b291mr2082950wrn.15.1691779897475;
        Fri, 11 Aug 2023 11:51:37 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id z4-20020a5d4d04000000b00314398e4dd4sm6191628wrt.54.2023.08.11.11.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 11:51:36 -0700 (PDT)
Message-ID: <c5f912a9-cc08-1645-ad04-c7a58c1e47ce@linaro.org>
Date:   Fri, 11 Aug 2023 19:51:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 4/4] venus: hfi_parser: Add check to keep the number of
 codecs within range
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, tfiga@chromium.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <1691634304-2158-1-git-send-email-quic_vgarodia@quicinc.com>
 <1691634304-2158-5-git-send-email-quic_vgarodia@quicinc.com>
 <fec4a8c7-206f-7af8-4ea9-c919a677bf7e@linaro.org>
 <2214c31b-eca2-012e-a100-21252a724e7c@quicinc.com>
 <8b72ce47-c338-2061-f11a-c0a608686d8c@linaro.org>
 <e880da07-ccd4-e427-ed34-20b284dc7838@quicinc.com>
 <8f1a4ca0-dde8-fa5d-bca3-d317886609de@linaro.org>
 <060f4dbe-63d6-1c60-14ca-553bf1536e5a@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <060f4dbe-63d6-1c60-14ca-553bf1536e5a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 17:02, Vikash Garodia wrote:
> 
> 
> On 8/11/2023 4:11 PM, Bryan O'Donoghue wrote:
>> On 11/08/2023 09:49, Vikash Garodia wrote:
>>>
>>> On 8/11/2023 2:12 PM, Bryan O'Donoghue wrote:
>>>> On 11/08/2023 07:04, Vikash Garodia wrote:
>>>>>
>>>>> On 8/10/2023 5:03 PM, Bryan O'Donoghue wrote:
>>>>>> On 10/08/2023 03:25, Vikash Garodia wrote:
>>>>>>> +    if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) >
>>>>>>> MAX_CODEC_NUM)
>>>>>>> +        return;
>>>>>>> +
>>>>>>
>>>>>> Shouldn't this be >= ?
>>>>> Not needed. Lets take a hypothetical case when core->dec_codecs has initial 16
>>>>> (0-15) bits set and core->enc_codecs has next 16 bits (16-31) set. The bit
>>>>> count
>>>>> would be 32. The codec loop after this check would run on caps array index
>>>>> 0-31.
>>>>> I do not see a possibility for OOB access in this case.
>>>>>
>>>>>>
>>>>>> struct hfi_plat_caps caps[MAX_CODEC_NUM];
>>>>>>
>>>>>> ---
>>>>>> bod
>>>>>>
>>>>
>>>> Are you not doing a general defensive coding pass in this series ie
>>>>
>>>> "[PATCH v2 2/4] venus: hfi: fix the check to handle session buffer requirement"
>>>
>>> In "PATCH v2 2/4", there is a possibility if the check does not consider "=".
>>> Here in this patch, I do not see a possibility.
>>>
>>>>
>>>> ---
>>>> bod
>>
>> But surely hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) ==
>> MAX_CODEC_NUM is an invalid offset ?
> 
> No, it isn't. Please run through the loop with the bitmasks added upto 32 and
> see if there is a possibility of OOB.

IDK Vikash, the logic here seems suspect.

We have two loops that check for up to 32 indexes per loop. Why not have 
a capabilities index that can accommodate all 64 bits ?

Why is it valid to have 16 encoder bits and 16 decoder bits but invalid 
to have 16 encoder bits with 17 decoder bits ? While at the same time 
valid to have 0 encoder bits but 17 decoder bits ?

---
bod
