Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405FE785933
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbjHWN1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbjHWN1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:27:08 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E06D10FC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:26:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-991c786369cso749287966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797202; x=1693402002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FegUU4ad3bNa0M2oa4ub/QTdyOF5+IqE39ddtHoPMWo=;
        b=qSz7hr2ovv6zjfjn7Whwq0PjB0NYdF8ObICTeD6kq2a5zpjdEma08N9a0IvprtMbrf
         rWGd+ogzPf9b0PWzyVPQTwRVO54yTkYMc61Opn3ibzihFjFrM7YUL3+sG5TsYVs3AaTr
         OyLls8SzCkcSpU/0Dh5DRy8fLzR2RhXyYMfpliNprjOo+MbkXwpAkDfBsS7WuGYs6970
         qL5VFB1drU+FSA7fm9t/qRFAr4HxfelOKCPb28/bBUJDrvmVpvkVMkuiNTT681tSaJZN
         nTojmyWFoLPfbgtvBZSnAOfYGwj067e3U0YuPmLFzxS+lU+Pj9Dl1mG+gmY/R1vGStR3
         L/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797202; x=1693402002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FegUU4ad3bNa0M2oa4ub/QTdyOF5+IqE39ddtHoPMWo=;
        b=YBAHCUoYOtOG1JQmzqnfKofJoy/2Ki9KZrQKhGaf1QTkkVfrSl16jro9ZXeL1LTQ0B
         XyamXllyKJ7pOBVVYKTRjv/V+XB65MLK38UNJlZnWpX+vb/dcXBevimJRxhHEwCF1/Ne
         SbA8/cxtxbPjQ2EeJD4eASCa7xZsxGp5gbpve+o3ZqbKgS6ME9OBqISUdCQvRa/gM4WI
         v3bDxZJMxispxNyxh6Bsp7m9qssRBgNUG4c2/AKJGXRFvN2L+jUiNZiumIJQQGEW117c
         ExKn9mCLxA/V1ma+Jx/vkGK6MWsfjaN1alRns24M7eKTkN7+n1YNmfH9gIFYG3SDYTBm
         TRAQ==
X-Gm-Message-State: AOJu0Yx6sg8jHTbk/P/oktfNKWXJwe4L8KhOAQBn/U1LiBDAf4rK7qaw
        FVW5o1FrlVp1jFIcFbRoL60rog==
X-Google-Smtp-Source: AGHT+IF6KeOfFQ9Fws+2+hH7VsfJon8Bi62N30oYOXOPn9AzIKVtUsngiCFkWx99mukh96xzXE2nCA==
X-Received: by 2002:a17:907:60c7:b0:99c:da06:bca with SMTP id hv7-20020a17090760c700b0099cda060bcamr8988022ejc.4.1692797202257;
        Wed, 23 Aug 2023 06:26:42 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id um6-20020a170906cf8600b0098d2f703408sm9818212ejb.118.2023.08.23.06.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 06:26:41 -0700 (PDT)
Message-ID: <1abdb67b-6efd-474c-ef50-abd8cebe3803@linaro.org>
Date:   Wed, 23 Aug 2023 14:26:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/22] nvmem: patches for v6.6
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
 <2023082217-banter-craftwork-281a@gregkh>
 <6e3b58d0-4017-9051-9337-7d86a6be55de@linaro.org>
 <2023082220-cavalry-litigate-9fe3@gregkh>
 <a2cd120c-f09e-de58-b3a6-beaadb199ae4@linaro.org>
 <2023082305-nutlike-omen-13ca@gregkh>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <2023082305-nutlike-omen-13ca@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/2023 09:59, Greg KH wrote:
> On Wed, Aug 23, 2023 at 09:54:04AM +0100, Srinivas Kandagatla wrote:
>>
>>
>> On 22/08/2023 18:37, Greg KH wrote:
>>> On Tue, Aug 22, 2023 at 06:29:54PM +0100, Srinivas Kandagatla wrote:
>>>>
>>>>
>>>> On 22/08/2023 15:34, Greg KH wrote:
>>>>> On Mon, Aug 14, 2023 at 05:52:30PM +0100, Srinivas Kandagatla wrote:
>>>>>> Here are some nvmem patches slightly more than usual for 6.6 that includes
>>>>>>
>>>>>> - Support for NXP eFuse, qcom secure qfprom, QCM2290 nvmem providers
>>>>>> - core level cleanup around error handling and layout creation.
>>>>>> - few minor cleanups across providers drivers to use better
>>>>>>      apis and a typo fix.
>>>>>>
>>>>>> Can you please queue them up for 6.6.
>>>>>
>>>>> I did, thanks, but your email system needs to be fixed:
>>>>
>>>>
>>>> Do you mean Attestation failing part or something else?
>>>
>>> Yes:
>>>
>> I did not setup patatt in my workflow yet, which is why this is failing
>> attestation.
> 
> No, this is not for patatt (which would be good to have, I agree.)  This
> is due to Linaro, or you, not setting up DKIM properly.
> 
> As this works for other Linaro developers, you might want to ask them
> how they resolved it.
> 
some interestingly results.

I tried to validate DKIM using https://dkimvalidator.com which passes 
the validation.

Also checked my older patches mboxes which also passes DKIM.

Am not sure what went wrong with the previous patches.

Am hoping that the issue is fixed given that https://dkimvalidator.com 
seems to indicate that DKIM is passing, I will send v2 patches.


thanks,
Srini

> thanks,
> 
> greg k-h
