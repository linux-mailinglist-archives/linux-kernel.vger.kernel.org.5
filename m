Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718057BD303
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345158AbjJIGEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345135AbjJIGEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:04:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DDAB3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 23:04:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3231dff4343so2394631f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 23:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696831449; x=1697436249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DSpCFkvDliBIi94vkQb5oHZZL6VCqsWDm8gvXxfzeF0=;
        b=QuNi3Gzt8QgkuVmwmVjJrFYLHly0PZfCqj9pO+EDswg5+Gz1oKXwQFNbhKFX1kbfqu
         N/f+tpDISVNbI19vCk+3lPlZ5f/mtfKQMtq1WHHULUvAodCdcgUhOMAXyXHdauyJyjeG
         gqI+EhXeIHgxAEASDuC5J5adbfCkeDCahp4/8UtDGIHt0/wuYmk/mtKVEOXs1ua6hsX/
         PrXL0aewaIohmm9sAxon7Iu9bh75cvuqcupI0zEW4uFxzAfhNmNYBdKiyUX4lD6fwrjQ
         P7GE2QOV78CQ7D8No1Uhmp7JDQrOVlm6geWjeA6H1qQLYf2pO2blPNNArrzUBAgMTV6p
         ZDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696831449; x=1697436249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSpCFkvDliBIi94vkQb5oHZZL6VCqsWDm8gvXxfzeF0=;
        b=oZYfqTx7dCUZiG8GasO7zQpN3ofKZYMVVsRNE9fdwvUu4X0M0cbXe4QJL/JsyjCmSf
         QiYOAPelQH2vSrEA2P0UQpOkJ4V8RSFmD52JIVBOa3TPHlGdG0210q/LP9IEG8xdgBgC
         0kvmzUbiHBAB0KrStiy0nLgCHPi2Endwym1j/mOeEvs1NhgO90gXRJsDGkKFoRhCGzqQ
         Ic0UFWn1Uikaz7NSCcG8K4OnwQH/6Q65vRRwvVDimfAWbSUHrrEo4YKJlvTwcrlwPrj1
         4KUbrqzhJnFz3EwRsGUIbFs+pmDHh3PnvfMEjbF169KL51jMALydvtQCXlGqk8Asn0P+
         0g4A==
X-Gm-Message-State: AOJu0YyJb1EW/sfY0JCDiUQ5FOa3YUcTc3xcn5llg/Aqjp9YJ1TRdSaw
        AWdxPps/4Dz5wT8B33UpVHLdlNYTLNLMA/AZ0xt1Wg==
X-Google-Smtp-Source: AGHT+IHbPxGfkqj2vLj6jQjH27zfoJ5TC3rAzi5r+qOQkaCXS7zy68bLHnpYwwBPbrzkXw8hj81/7A==
X-Received: by 2002:a5d:4d86:0:b0:323:30d0:5c4d with SMTP id b6-20020a5d4d86000000b0032330d05c4dmr8676579wru.19.1696831449190;
        Sun, 08 Oct 2023 23:04:09 -0700 (PDT)
Received: from [192.168.86.24] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id c12-20020adfe74c000000b003258934a4bfsm8548517wrn.36.2023.10.08.23.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 23:04:08 -0700 (PDT)
Message-ID: <53b922b7-a87e-1447-0148-b96d51902bbf@linaro.org>
Date:   Mon, 9 Oct 2023 07:04:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/3] misc: fastrpc: Free DMA handles for RPC calls with
 no arguments
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        stable <stable@kernel.org>
References: <1695973360-14369-1-git-send-email-quic_ekangupt@quicinc.com>
 <1695973360-14369-3-git-send-email-quic_ekangupt@quicinc.com>
 <92db4a0d-c416-6a1c-ad71-15c2156d59aa@linaro.org>
 <856929f7-7e6e-8dd5-a12f-9f4de524ce61@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <856929f7-7e6e-8dd5-a12f-9f4de524ce61@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/10/2023 12:07, Ekansh Gupta wrote:
> 
> 
> On 10/2/2023 3:00 PM, Srinivas Kandagatla wrote:
>>
>>
>> On 29/09/2023 08:42, Ekansh Gupta wrote:
>>> The FDs for DMA handles to be freed is updated in fdlist by DSP over
>>> a remote call. This holds true even for remote calls with no
>>> arguments. To handle this, get_args and put_args are needed to
>>> be called for remote calls with no arguments also as fdlist
>>> is allocated in get_args and FDs updated in fdlist is freed
>>> in put_args.
>>>
>>> Fixes: 8f6c1d8c4f0c ("misc: fastrpc: Add fdlist implementation")
>>> Cc: stable <stable@kernel.org>
>>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>>> ---
>>>   drivers/misc/fastrpc.c | 23 ++++++++++-------------
>>>   1 file changed, 10 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>>> index fb92197..a52701c 100644
>>> --- a/drivers/misc/fastrpc.c
>>> +++ b/drivers/misc/fastrpc.c
>>> @@ -1091,6 +1091,7 @@ static int fastrpc_put_args(struct 
>>> fastrpc_invoke_ctx *ctx,
>>>           }
>>>       }
>>> +    /* Clean up fdlist which is updated by DSP */
>>>       for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
>>>           if (!fdlist[i])
>>>               break;
>>> @@ -1157,11 +1158,9 @@ static int fastrpc_internal_invoke(struct 
>>> fastrpc_user *fl,  u32 kernel,
>>>       if (IS_ERR(ctx))
>>>           return PTR_ERR(ctx);
>> <---
>>> -    if (ctx->nscalars) {
>>> -        err = fastrpc_get_args(kernel, ctx);
>>> -        if (err)
>>> -            goto bail;
>>> -    }
>>> +    err = fastrpc_get_args(kernel, ctx);
>>> +    if (err)
>>> +        goto bail;
>> -->
>> I dont see any point of the above change as fastrpc_internal_invoke 
>> will be called from kernel with nscalars always set.
>>
>> do you see a path that does not set this?
>>
> The context specific rpra buffer is allocated as part of 
> fastrpc_get_args and there is a possibility that the DSP intends to 
> update fdlist for a call with 0 nscalars. In that scenario, the driver 
> needs to ensure that the rpra is allocated which will carry the fdlist. 
> The same can be extended to crc and dsp perf memory(to be added, patches 
> shared for missing features) for remote calls with 0 nscalars.
> 
Yes, we need this to setup remote args.

thanks
srini
> Thanks for taking your time to review the patches Srini, please let me 
> know if you have more queries.
> 
> -ekansh
>> --srini
>>>       /* make sure that all CPU memory writes are seen by DSP */
>>>       dma_wmb();
>>> @@ -1185,14 +1184,12 @@ static int fastrpc_internal_invoke(struct 
>>> fastrpc_user *fl,  u32 kernel,
>>>       if (err)
>>>           goto bail;
>>> -    if (ctx->nscalars) {
>>> -        /* make sure that all memory writes by DSP are seen by CPU */
>>> -        dma_rmb();
>>> -        /* populate all the output buffers with results */
>>> -        err = fastrpc_put_args(ctx, kernel);
>>> -        if (err)
>>> -            goto bail;
>>> -    }
>>> +    /* make sure that all memory writes by DSP are seen by CPU */
>>> +    dma_rmb();
>>> +    /* populate all the output buffers with results */
>>> +    err = fastrpc_put_args(ctx, kernel);
>>> +    if (err)
>>> +        goto bail;
>>>   bail:
>>>       if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
