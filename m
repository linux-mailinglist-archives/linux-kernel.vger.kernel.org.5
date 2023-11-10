Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262DF7E7E71
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbjKJRpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjKJRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:44:05 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E603B332
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:52:53 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9e1021dbd28so367183666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699631571; x=1700236371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oF3vJeEgIoG+9/BmmY474aPiIMICdIDrCG3fr5stXJw=;
        b=Lsm1S/Jii9RhtFx+Kb3wGdj79RWDmdM6xGZD48LkOx0rmmWIvBLQzTbuL7FRXjeBor
         EUNGkmXLPchm2oz1lK9+0FeSgXHCdThpHiiATHuoIoOGxtnH5nGa2yFZObWiwgFuKlRk
         YiqJAVl257i7XQuRunNH4IB5SdsIQBVve825FwVZspf4N7b4iYYkZIIQID5NwHJmRW4E
         CsQ9/BiTRSKy3dfGQc4agzN8IZjEPj8C6vLidm+xmjHHgqe0kkFtjbLXrRsIVw4fuz/c
         9j5ZKRpo8HELNOXrInYZeKWZvPH4wsQRw5O4j4sMsAmbBs9cORIysmgaXOMgA1OMGSR1
         03CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699631571; x=1700236371;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oF3vJeEgIoG+9/BmmY474aPiIMICdIDrCG3fr5stXJw=;
        b=wY9ZRbx7DqE9ymWrTGRksOAn0JlKESCc6dr1KhqeQjGOIJvMYWEdWejxWqqFYpV2rO
         gt9Du9iifXaRLpCa/9Rb0VYZTazjq+LNi8Qa04LHN4hf/eTs8OlHeurhlqRkTZgeuuzf
         T4TJDOZFTwES0I7bXyqpX+LoohjlXKXGaCrXb6fXispId8C8PPDPbvjOvQJQ2hhrX5lt
         aD9RyyP6X5/FWrxiXBVlX2KHBMxk4ECZA/FMdyBev8HvA/2T0L+Acvz7LeVMSJWmubhl
         Q862SpCQNGYZytEDxj67WxJjvLNwb5JGqqgaL0C6H5n4Lu1MF091q+LPCgQb64NU0Xvn
         0+XA==
X-Gm-Message-State: AOJu0Yy2XKXcPH40XSCaVHypCiD7iZZ3goFTx0NmxVxe9xv3+lBTVuIo
        s66iBEMVUDtk+cbTEFVahu080w==
X-Google-Smtp-Source: AGHT+IEqHmshTh1CPafTnDr0+YR29q1fXq/0hrKsbgRUqKb2Cg70DB+zthPvV9YN3MsTsRsELaDPxQ==
X-Received: by 2002:a17:906:26d1:b0:9e5:344f:7499 with SMTP id u17-20020a17090626d100b009e5344f7499mr2756436ejc.48.1699631571393;
        Fri, 10 Nov 2023 07:52:51 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id ty14-20020a170907c70e00b009e6af2efd77sm512886ejc.45.2023.11.10.07.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 07:52:50 -0800 (PST)
Message-ID: <1cde698d-6655-4cce-9ed6-e852b3aac8d9@linaro.org>
Date:   Fri, 10 Nov 2023 16:52:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dmaengine: fsl-edma: integrate TCD64 support for
 i.MX95
Content-Language: en-US
To:     Frank Li <Frank.li@nxp.com>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com,
        vkoul@kernel.org
References: <20231109212059.1894646-1-Frank.Li@nxp.com>
 <20231109212059.1894646-5-Frank.Li@nxp.com>
 <f095ba95-ce76-4821-87b7-083f4162fc63@linaro.org>
 <ZU5FN1dECvzDIUHb@lizhi-Precision-Tower-5810>
 <93f1625f-ce01-4628-91e2-e3bfd024466c@linaro.org>
 <ZU5OC4FqQ9DQF+Co@lizhi-Precision-Tower-5810>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZU5OC4FqQ9DQF+Co@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2023 16:36, Frank Li wrote:
> On Fri, Nov 10, 2023 at 04:10:46PM +0100, Krzysztof Kozlowski wrote:
>> On 10/11/2023 15:59, Frank Li wrote:
>>>>>
>>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>>>> ---
>>>>
>>>> Three kbuild reports with build failures.
>>>>
>>>> I have impression this was never build-tested and reviewed internally
>>>> before posting. We had such talk ~month ago and I insisted on some
>>>> internal review prior submitting to mailing list. I did not insist on
>>>> internal building of patches, because it felt obvious, so please kindly
>>>> thoroughly build, review and test your patches internally, before using
>>>> the community for this. I am pretty sure NXP can build the code they send.
>>>
>>> This build error happen at on special uncommon platform m6800. 
>>
>> Indeed csky and alpha are special. Let's see if LKP will find other
>> platforms as well.
>>
>>> Patch is tested in imx95 arm64 platform.
>>
>> That's not enough. It's trivial to build test on riscv, ppc, x86_64 and
>> i386. Building on only one platform is not that much.
>>
>>>
>>> I have not machine to cover all platform.
>>
>> I was able to do it as a hobbyist, on my poor laptop. What is exactly
>> the problem that as hobbyist I can, but NXP cannot?
> 
> There are also difference configs. I think 'kernel test robot' is very good
> tools. If there are guide to mirror it, we can try. It is not neccesary to
> duplicate to develop a build test infrastrue.

Sorry, there is no build infrastructure here. I done it on my laptop.

> 
> The issue is not that run build test. The key problem is how to know a
> protential problem will be exist, and limited a build/config scrope.

These are all the trivial configs - allyes and allmod.

> 
> Even I have risc\ppc\x86_64 built before I submmit patch, still can't
> capture build error if I missed just one platform mc6800.

So you did not read these build reports. This is not "mc6800" platform.
This is allyes and allmod, the most obvious builds, after defconfig.

> 
> For `readq` error also depend on the configs.

Read again the build reports from LKP.

> 
> Actually, we major focus on test edmav1, .... v5 at difference platforms
> before submit patches. 


Best regards,
Krzysztof

