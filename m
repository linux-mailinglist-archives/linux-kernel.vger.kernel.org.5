Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FE37F1C68
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjKTS34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKTS3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:29:54 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F86C8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:29:50 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ffef4b2741so119554966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700504989; x=1701109789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7S1tKK+JLZHxsOf8xPtpSYx7utqfH0QNLzA9k3diLo=;
        b=g7sECBqAstEOEgofsFN6uMCIFGnpEMaOagoJzTE/bH5H+M7+B8mNuL1OJkhCIjXtY6
         iBLpI5G8gTEuymAxZyXJNdsin9bo9invE3G2q3p7K8/wmDmCoJPDXQDhlfi5AeZCHE5g
         SIp8tE9CMRqo+a/yDLR0wQN5YnjlIw5c+lmxOw4Mev8ha6i7k0l+0j3x9IPjo4cT+4IO
         wbN+YsaBcnqCnhPXiy1X5CgS8gv4cQkdR0teQfxADP3FAc45bxvwiUWIsPbWFL8qMqtO
         jHuTbZFndysdqKVTqLak/+ilS/Z0fvAhPEMrmpTazaVLLynIrGmDHk2Nx51Ti0nC7p+z
         PU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700504989; x=1701109789;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7S1tKK+JLZHxsOf8xPtpSYx7utqfH0QNLzA9k3diLo=;
        b=VIbTtJ/AbYMwghlDcQlTiVO0h1TE1dp35vibejq3SMZ5iu0MUzgFkEuE+4l3TCW65b
         SVY+I2MMgTQeDnYkxPx88TdlDzORJ9rgWTN4RqyrA8KNXqcSrsvoEG+HKyN4Aar/MqNF
         3Zd3l7UAXfLtFHvyzsq84aS81uhw4M6/cj5ThwJaeEXg9B6nSGAfTqMa3z/UIw64WI2r
         LHcyN+svZRuBralKHfl6NY3CaeFJ7q144E+m73O10bhtB6LrKc3wj3XlvlGdZ4ycvIrS
         ZQ2fmqVdQfmzZEN5k4FTUNPHicx7v8FJ3GhCnP5kraSp1WA9aJpE7+DqbMFZL2fVKVJs
         Y65w==
X-Gm-Message-State: AOJu0YzstH1NEjNpa4jk3fkXS1uuVnWeH+WOaf5AasM4qWXyCAylsApw
        NjFYFxdQut22Bn6GmewBVfamqg==
X-Google-Smtp-Source: AGHT+IE5ANvtJBiIRAvI+sDwfMSShU7ATXSXYCrOdCoztcxu5imohR3W7YEf1+eByesWMdoxDd9G5g==
X-Received: by 2002:a17:906:10b:b0:9d3:85b9:afdf with SMTP id 11-20020a170906010b00b009d385b9afdfmr5459912eje.3.1700504989258;
        Mon, 20 Nov 2023 10:29:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id x26-20020a1709065ada00b009fd04a1a1dfsm1880622ejs.40.2023.11.20.10.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 10:29:48 -0800 (PST)
Message-ID: <9db5e25f-9fe1-45d9-9a3b-91c45c6cdddf@linaro.org>
Date:   Mon, 20 Nov 2023 19:29:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: virtual_ncidev: Add variable to check if ndev is
 running
Content-Language: en-US
To:     Phi Nguyen <phind.uet@gmail.com>, bongsu.jeon@samsung.com
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com" 
        <syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>
References: <20231119164705.1991375-1-phind.uet@gmail.com>
 <CGME20231119164714epcas2p2c0480d014abc4f0f780c714a445881ca@epcms2p4>
 <20231120044706epcms2p48c4579db14cc4f3274031036caac4718@epcms2p4>
 <bafc3707-8eae-4d63-bc64-8d415d32c4b9@linaro.org>
 <20d93e83-66c0-28d9-4426-a0d4c098f303@gmail.com>
 <d82e5a5f-1bbc-455e-b6a7-c636b23591f7@linaro.org>
 <8bce1251-7a6b-4b4c-b700-9d97c664689f@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <8bce1251-7a6b-4b4c-b700-9d97c664689f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2023 19:23, Phi Nguyen wrote:
> On 11/20/2023 6:45 PM, Krzysztof Kozlowski wrote:
>> On 20/11/2023 11:39, Nguyen Dinh Phi wrote:
>>>>>>            mutex_lock(&vdev->mtx);
>>>>>>            kfree_skb(vdev->send_buff);
>>>>>>            vdev->send_buff = NULL;
>>>>>> +        vdev->running = false;
>>>>>>            mutex_unlock(&vdev->mtx);
>>>>>>    
>>>>>>            return 0;
>>>>>> @@ -50,7 +55,7 @@ static int virtual_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
>>>>>>            struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
>>>>>>    
>>>>>>            mutex_lock(&vdev->mtx);
>>>>>> -        if (vdev->send_buff) {
>>>>>> +        if (vdev->send_buff || !vdev->running) {
>>>>>
>>>>> Dear Krzysztof,
>>>>>
>>>>> I agree this defensive code.
>>>>> But i think NFC submodule has to avoid this situation.(calling send function of closed nci_dev)
>>>>> Could you check this?
>>>>
>>>> This code looks not effective. At this point vdev->send_buff is always
>>>> false, so the additional check would not bring any value.
>>>>
>>>> I don't see this fixing anything. Syzbot also does not seem to agree.
>>>>
>>>> Nguyen, please test your patches against syzbot *before* sending them.
>>>> If you claim this fixes the report, please provide me the link to syzbot
>>>> test results confirming it is fixed.
>>>>
>>>> I looked at syzbot dashboard and do not see this issue fixed with this
>>>> patch.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> Hi Krzysztof,
>>>
>>> I've submitted it to syzbot, it is the test request that created at
>>> [2023/11/20 09:39] in dashboard link
>>> https://syzkaller.appspot.com/bug?extid=6eb09d75211863f15e3e
>>
>> ...and I see there two errors.
>>
> These are because I sent email wrongly and syzbot truncates the patch 
> and can not compile
> 
>> I don't know, maybe I miss something obvious (our brains like to do it
>> sometimes), but please explain me how this could fix anything?
>>
>> Best regards,
>> Krzysztof
>>
> 
> The issue arises when an skb is added to the send_buff after invoking 
> ndev->ops->close() but before unregistering the device. In such cases, 
> the virtual device will generate a copy of skb, but with no consumer 
> thereafter. Consequently, this object persists indefinitely.
> 
> This problem seems to stem from the existence of time gaps between 
> ops->close() and the destruction of the workqueue. During this interval, 
> incoming requests continue to trigger the send function.

I asked how this could fix anything. Can you respond to my original comment?

Look:

>>>> This code looks not effective. At this point vdev->send_buff is always
>>>> false, so the additional check would not bring any value.

Best regards,
Krzysztof

