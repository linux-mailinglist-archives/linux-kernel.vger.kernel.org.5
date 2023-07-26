Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16448762FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjGZIcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjGZIbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:31:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEE41BE8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:21:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9936b3d0286so1102791466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690359702; x=1690964502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNI1gYMfUzgdlqp0MRJHlpGTSqe1s86abPLCG9bb/zE=;
        b=x+h2Z+6CcTuQHGo7HALOyEvCNOsI2MoqHPdiCU/d85i/TG/p3g13cyUU53DBTyVeE6
         VHq7aILOPqBz/6EshxqIgF8zIi0BquVlrix5G49v6N9+XBqIEEvruUtlPtnNtoem+NdU
         9NPfcz2JOmcvmab7VK814KSkPR2vGlNQ5m2hW7RrICkIVDZBakmteroHuRxLedfoxJ1M
         eJktYxQwbsFj2pE+MH037OLoJ6BU45gOfIVILyBPqfzmlqxBw0F/GwxVozity27wVzmF
         E7gtvwUd6qkbgE+aMyOhu2TAzWtLRThBySKRClxqCRFMhIrnRs5OmrBoXqyp98leSEvN
         4tDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690359702; x=1690964502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNI1gYMfUzgdlqp0MRJHlpGTSqe1s86abPLCG9bb/zE=;
        b=iNu4Gc10f1XQEngwMbpSNwPg9GLsz2zxIvjue17/g6BdWTmBtLtAYu2ZXVa8nVIB8T
         wBE4y0NjWMkc24tUZ7pP0DwuFKw5HFUL91TajZU/FZ3iDZ98HrA4z0WDI6/E0drBnfIz
         rsxDLCcl404ki0MFXSOwzN4InvKLnWo3WBRT2cwqNizgox4T/QqnNxzQdcyYrGXPC82C
         cBf+S1MaAN3g5mpqjx0jnfrNi0QpnLrBaQy9hTvH5mNHtKz4+XiVCSPVO/2R0bTohGew
         A+Sc8EMhrM0yXhCUx/8zpPU85/6VkaHmAU6aPWAMr5ol4Cihoc/1d4WDLOaX29QEF4IC
         FwQQ==
X-Gm-Message-State: ABy/qLYU1aJhmZ6fuTgdnEi7Y33f55efl5Umwgf2A+0g/jA21kNU0esm
        Lk8pv52pLL77lr0mEaoNT9EP3A==
X-Google-Smtp-Source: APBJJlHzuxmXjvBJZoGswU7ssT45SHHguH52Gua3+X7x0eE1SHD0vPx55zLBSUcDbI/df5v4rHuEUg==
X-Received: by 2002:a17:906:da:b0:99b:5832:df8b with SMTP id 26-20020a17090600da00b0099b5832df8bmr1067399eji.26.1690359702650;
        Wed, 26 Jul 2023 01:21:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090606cf00b00985bdb7dd5fsm9169664ejb.201.2023.07.26.01.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 01:21:42 -0700 (PDT)
Message-ID: <6b38bf1f-600c-e6e9-ebf7-c27a06fffed1@linaro.org>
Date:   Wed, 26 Jul 2023 10:21:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] w1: ds2482: Switch back to use struct i2c_driver's
 .probe()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-i2c@vger.kernel.org
References: <20230612072807.839689-1-u.kleine-koenig@pengutronix.de>
 <6d76105f-daa1-1cd0-35b3-1727aa967bcc@linaro.org>
 <20230613070237.srqd3sy2c3lp7u5p@pengutronix.de>
 <dcc99c16-3807-1f81-03b8-86095f08258e@linaro.org>
 <20230720085253.arndjzqyhlbiioyy@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230720085253.arndjzqyhlbiioyy@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 10:52, Uwe Kleine-König wrote:
> On Tue, Jun 13, 2023 at 10:06:46AM +0200, Krzysztof Kozlowski wrote:
>> On 13/06/2023 09:02, Uwe Kleine-König wrote:
>>> Hello Krzysztof,
>>>
>>> On Mon, Jun 12, 2023 at 10:10:30PM +0200, Krzysztof Kozlowski wrote:
>>>> On 12/06/2023 09:28, Uwe Kleine-König wrote:
>>>>> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
>>>>> call-back type"), all drivers being converted to .probe_new() and then
>>>>> commit 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
>>>>> convert back to (the new) .probe() to be able to eventually drop
>>>>> .probe_new() from struct i2c_driver.
>>>>>
>>>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>>> ---
>>>>>  drivers/w1/masters/ds2482.c | 2 +-
>>>>
>>>> Thank you for the patch.
>>>> It is too late in the cycle for me to pick it up. I will take it after
>>>> the merge window.
>>>
>>> This is one of only 19 patches that are still needed on top of what is
>>> currently in next before I can drop .probe_new() which I intended to
>>> tackle after the upcoming merge window. I expect that most of these 19
>>> patches will still be picked up and go into v6.5-rc1.
>>>
>>> Assuming there are only less than 10 patches remaining on top of
>>> v6.5-rc1, I intend to create a pull request for Wolfram with the
>>> remaining bits and a patch doing
>>
>> Sure, go ahead:
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Thanks, but this didn't happen because I missed a few introductions of
> new .probe_new. My plan was rescheduled to one merge window later. So if
> you want to take this for v6.6-rc1 that would be great.
> 

I don't have anything in w1 queue, so it would be easier if you take it
with the rest.

Best regards,
Krzysztof

