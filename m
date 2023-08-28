Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F3A78B608
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjH1RJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjH1RJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:09:21 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2371BE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:08:38 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so51267401fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693242491; x=1693847291;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJ0nWzzimdg838fa/lzoTVDxFGZxON94cAcpz1zfgRE=;
        b=DLCWu4qssYAxO6MpNH7v985v2dDP3T9gYeek8LCjZThUXgz5fxyKzreeWppQjmloxL
         71ehSFk3Hr/A7WDYapYYHueXbu4tSPYY886yeYVzTxTa1SphD4ep2Im/ogxE2vEDGoGT
         JcfRZKDU0squBVCwHKAlNqKDUD5D3ZhmI56R+pXe3dgk0leNcAx82Leww8t7ux03hoa+
         aHhwj5vijuts4QOYB+uwsmueid58WCJo/K+yxrEiH+VfruxWeTdqyVONEASnAs7vkmqY
         0Cs0v/ah6AT/lcH+fuH8+nTJQSVJuG3wehIzywwc4U5X6gHdWXLEkTqXO9MA/m6PMZ7H
         o9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693242491; x=1693847291;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJ0nWzzimdg838fa/lzoTVDxFGZxON94cAcpz1zfgRE=;
        b=as/MJl33cw08jxdyQmRsmZjBuHRFsUnRWnggQtrceuoxDqjhi3Z+TbrUnfqUcT5CjW
         M3CFXINKH+EshnrXoq4zKe9ow4Jr00jRbhxxKohyZtB5MfBtqmEskZVe4sOxbrrpOQ1v
         SBSE0OzC1CobwyCGGXH2V5QgVJP/+cSRMV6vv6pNqZONChyXgXTsjfFMAt1/ntxt+irp
         u/n1dFXkwliDr3n/3Rs27IpfYKFKGLlZglxpl/lSVDb5MDww59SJQ3AMHEQe5P0Nl+le
         AJGe2bsVaAdSmm7ZHfShtXNbbxrWqXBAoJGXRNFnlGfjptvU6njw5A93kYwBkXOW32nb
         qMsA==
X-Gm-Message-State: AOJu0Yxq74+A8rtPEY6ZGo118IaJFG7PF6t/Rk0Tom651PP/onxFnre7
        aULY2jcbLdwEtc3xRcxbdtDCYA==
X-Google-Smtp-Source: AGHT+IEcPUROefoidY84rNmIPDcccxjgx8VyhG+jU810O5raCTKXVm4HvVuhMFOnJHbYLVNBvJkswA==
X-Received: by 2002:a05:651c:2045:b0:2bc:fb79:d165 with SMTP id t5-20020a05651c204500b002bcfb79d165mr5073014ljo.39.1693242491588;
        Mon, 28 Aug 2023 10:08:11 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id rs25-20020a170907037900b0099bd1a78ef5sm4826212ejb.74.2023.08.28.10.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 10:08:11 -0700 (PDT)
Message-ID: <3f26449e-4208-f1a2-dd3c-3ecc095f4ea0@linaro.org>
Date:   Mon, 28 Aug 2023 19:08:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] misc: bm92txx: Add driver for the ROHM BM92Txx
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     azkali <a.ffcc7@gmail.com>, Adam Jiang <chaoj@nvidia.com>,
        CTCaer <ctcaer@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230824153059.212244-1-linkmauve@linkmauve.fr>
 <20230824153059.212244-3-linkmauve@linkmauve.fr>
 <f79087c0-cc44-4fb6-fa2e-b43db5dfd6d4@linaro.org> <ZOy33RB8aj3455ZQ@desktop>
 <faf53a03-341c-994e-e66f-46cf88aeaa8e@linaro.org>
In-Reply-To: <faf53a03-341c-994e-e66f-46cf88aeaa8e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 19:05, Krzysztof Kozlowski wrote:
> On 28/08/2023 17:06, Emmanuel Gil Peyrot wrote:
>> Hi,
>>
>> On Thu, Aug 24, 2023 at 06:28:07PM +0200, Krzysztof Kozlowski wrote:
>>> On 24/08/2023 17:30, Emmanuel Gil Peyrot wrote:
>>>> From: azkali <a.ffcc7@gmail.com>
>>>>
>>>> This is used as the USB-C Power Delivery controller of the Nintendo
>>>> Switch.
>>>>
>>>> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
>>>> Signed-off-by: azkali <a.ffcc7@gmail.com>
>>>> Signed-off-by: Adam Jiang <chaoj@nvidia.com>
>>>> Signed-off-by: CTCaer <ctcaer@gmail.com>
>>>
>>> These do not look like real identities. In this and previous patchset
>>> your author emails bounces, so I propose to drop all stale addresses and
>>> all anonymous entries.
>>
>> I and the authors find that policy inacceptable, our work should be
>> credited and our copyright should hold despite our choice of name.
> 
> Which authors? The ones who do not want to give real, working email? Or
> the ones who do not want to provide known identity, which is required by
> our submission process?
> 

BTW, you mistake copyrights with DCO... DCO does not automatically give
any of the intermediate people copyrights.

Best regards,
Krzysztof

