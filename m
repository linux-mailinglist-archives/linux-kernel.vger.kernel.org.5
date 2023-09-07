Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81871797D81
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 22:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbjIGUmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 16:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjIGUmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:42:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CBF1BCD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 13:42:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c93638322so284404266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694119325; x=1694724125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FcnB2B4JPj1CKIc94VubNtdCx3lpL4bBgiHUxMic53E=;
        b=Lp9JCtqYlwOU0eFTFq83b3f+EjPidwlWMsZLuh0dlidVpCk0yTvVTyyZ/nrOSYk7BL
         7jpEXx+TyDtNN6Ses08MtQ/gqBFGK5dGS7cJv4vRwRuMNGmQEvzM4ukNljombAvyWasX
         sByDYgUmSM2gnNgi0t+KjogQpnuBGlXSx4CdNmKqk6vzVvJf3GpsODsucheFv/1OAr4D
         p1QcpG3DaEC7pqBeG/+ocqo9NQflKRmKbN9tWUFmLEreFuUc8tHuxc7DLi3xcT8OTnjo
         J/59ko5wxx9MylNrX3sYNBd/SM/5bY8zZU+gnwMfJW/4F4ZzgyvIQqQXbNBFDqISct3n
         YuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694119325; x=1694724125;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcnB2B4JPj1CKIc94VubNtdCx3lpL4bBgiHUxMic53E=;
        b=ep9BSVUBD8VSRBrulFpWIqbYDSQEQsMHCYUzZrPsT2xU9KKgcvNUq4OMrLeYRc/knF
         0/lLdTN/rGjXdWZBq2cfvlpgguaB5AWDhgs/3KnZryow8MxhM7erfMDWH5ipEVmcB4TG
         NsaHoBHxMKPhO9QbMTfDS126xZAv1rfNw/vvgyw7Gii4LgFP9ML4z7LZWqxeKTtOu+I3
         lHQeJ83hdt/wYH07Bp+99D8uTzt/FvalcNFIx2b7IKjjXTxqnXwOjqKiBzGP1pQR/euH
         m3iBgE+K3nfsG9Gpyp9ghf0OC9x0i0KwOICQ/fm8ZlczMRrIedLYHPHwuzuN7+nej0R2
         h4gQ==
X-Gm-Message-State: AOJu0Yx+ZnuqKz2M/47bfHVlzWN78RuPjEqXlbrwDOjVM2Ji79lIRTlF
        R7Sjghi/YpR514EYrPFCHQfj+A==
X-Google-Smtp-Source: AGHT+IEJOjclVL4SMD7dJtIieatsHU7cbE5c0/hhtQ4Fs9aaE7BXQqpts5EpBKXktYYen78H9OkvQA==
X-Received: by 2002:a17:907:7604:b0:9a5:bceb:1cf8 with SMTP id jx4-20020a170907760400b009a5bceb1cf8mr521322ejc.3.1694119325610;
        Thu, 07 Sep 2023 13:42:05 -0700 (PDT)
Received: from [192.168.37.232] (178235177164.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.164])
        by smtp.gmail.com with ESMTPSA id ck8-20020a170906c44800b009930c80b87csm93585ejb.142.2023.09.07.13.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 13:42:05 -0700 (PDT)
Message-ID: <09109739-cb9c-42e2-80ab-e919774b4173@linaro.org>
Date:   Thu, 7 Sep 2023 22:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] leds: rgb: leds-qcom-lpg: Add support for PPG
 through single SDAM
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
        lee@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org
Cc:     luca.weiss@fairphone.com, u.kleine-koenig@pengutronix.de,
        quic_subbaram@quicinc.com, quic_gurus@quicinc.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@quicinc.com
References: <20230830180600.1865-2-quic_amelende@quicinc.com>
 <20230830180600.1865-7-quic_amelende@quicinc.com>
 <3b6f6285-ec3b-4e12-aa65-d5f61937de6f@linaro.org>
 <a9aa7bd9-7d42-3897-443e-b3ef2d73d05c@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <a9aa7bd9-7d42-3897-443e-b3ef2d73d05c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.09.2023 21:55, Anjelique Melendez wrote:
> 
> 
> On 8/30/2023 11:34 AM, Konrad Dybcio wrote:
>> On 30.08.2023 20:05, Anjelique Melendez wrote:
>>> In some PMICs like pmi632, the pattern look up table (LUT) and LPG
>>> configuration can be stored in a single SDAM module instead of LUT
>>> peripheral. This feature is called PPG. PPG uses Qualcomm Programmable
>>> Boot Sequencer (PBS) inorder to trigger pattern sequences for PMICs.
>> I still fail to understand what benefit this brings.
>>
>> Is this a "can be used", or "should be used", or maybe "must be used"?
>>
>> Are there any distinct advantages to using one over the other?
>> I see some limitations in the code below, but that's not being made
>> obvious.
>>
>> This all should be in the commit message, the current one includes
>> a lot of cryptic names that mean nothing to most people.
>>
>> [...]
> This is a must be used if you would like to trigger patterns. Will update commit message to try and 
> make that more clear for next patch.
So essentially without this patchset, PM8350C and PMI632 are not capable
of producing LED patterns. Is that correct?

[...]

>>> @@ -860,14 +1043,21 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
>>>  	 * Validate that all delta_t in the pattern are the same, with the
>>>  	 * exception of the middle element in case of ping_pong.
>>>  	 */
>>> -	delta_t = pattern[1].delta_t;
>>> -	for (i = 2; i < len; i++) {
>>> +	if (lpg->lpg_chan_nvmem) {
>>> +		i = 1;
>>> +		delta_t = pattern[0].delta_t;
>>> +	} else {
>>> +		i = 2;
>>> +		delta_t = pattern[1].delta_t;
>>> +	}
>> Why?
>>
>> What's the rationale behind this change?
> Patterns are required to have the same duration for each step of the pattern. Devices with LUT peripherals support low/high
> pause which is when the first/last entry of the pattern can have a longer duration. This loop checks that the all of the
> pattern durations are the same with the exception of the first and last entry for low/hi pause.
That's the explanation I was looking for! :)

Things like these that are only known to inside folks should
definitely be stated either as a comment, or inside the commit
message. Since you're changing the code flow in a noticeable manner,
this could probably be a good fit for a comment.

> 
> This change was made because devices that use single SDAM do not support low/high pause, so we must check every
> single pattern duration. Instead of changing the loop arguments with an if statement I was thinking we could either:
> 
> a. keep the original loop arguments and when loop exits we can check first element for single SDAM devices
> 
>    delta_t = pattern[1].delta_t;
>    for (i = 2; i < len; i++) {
> 	if (pattern[i].delta_t != delta_t) {
> + 		if (i != actual_len - 1 || lpg->lpg_chan_nvmem)
>   			goto out_free_pattern;
>   		}
>   	}
> 
> + if (lpg->lpg_chan_nvmem) {
> +	if (delta_t != pattern[0].delta_t)
> +		goto out_free_pattern
> + }
We assign hi/lo_pause a couple lines below. Moving these assignments
a bit higher up could let us make this clearer:

/* LPGs using SDAM for patterns require equal duration of all steps */
if ((delta_t != lo_pause) && lpg->lpg_chan_nvmem)
	goto out_free_pattern;

Though I think that (in a separate patch, or perhaps series), it would
be worth redoing the code such that hi/lo_pause expresses the deviation
from the duration of the rest instead of the duration itself. Then we
could just:

if ((lo_pause || hi_pause)) && lpg->lpg_chan_nvmem)
	goto out_free_pattern;

But that's just a suggestion from somebody that didn't work on this code.

Also, I think that using lpg_chan_nvmem interchangeably with SDAM is a
bit confusing. Do we expect NVMEMs/SRAMs that aren't SDAM to make an
appearence here?

> 
> b. Change the loop argument to start with i=0 and for LUT device we could just skip checking first and last element duration
>   ** We would end up checking if pattern[1].delta_t == pattern[1].delta_t inside the loop when i == 1
> 
>    delta_t = pattern[1].delta_t;
> +  for (i = 0; i < len; i++) {
> 	if (pattern[i].delta_t != delta_t) {
> +		if (lpg->lut_base && (i == 0 || i == actual_len - 1)
> +			continue;
> +               else
> +			goto out_free_pattern;
Meh, too many magic literals for my liking

Konrad
