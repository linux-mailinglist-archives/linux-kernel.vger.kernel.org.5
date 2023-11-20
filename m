Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B509F7F1C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjKTSYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjKTSX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:23:59 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC8AC8;
        Mon, 20 Nov 2023 10:23:54 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc9b626a96so34069135ad.2;
        Mon, 20 Nov 2023 10:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700504634; x=1701109434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KWt2/ngqRZl5QuD4sv4zP0M/aVeTZYIc/05gHj626E0=;
        b=S+wdhtbzJQrxem8qosDtNISOLMdN7jSlgRs/qcGbAgyPbiLaTxuztYL7g5cI6KDv2D
         oVGLsOECLBx98DXzTGPIra3OV6LdwcL0ZVk9npVhQkhp59NimQYjQ/WpRjx/CY0vF+ap
         kP8Hcx38memWh2BV4d9MCI82dj+an5eXJlZcsVOARD6ed3G1yencgRtlMe6nREmbdZ99
         1NUjUDCwGFnPbUrmjHHc53bjc4lL++j1MCg+dOlCmZGwZL/cE/M6koJhu6cSobegVwy2
         ES0MjgFSI1LVrPNTnYL+m4Gok4uUZw0YPyT/NLL5H6S637+Rp4EWN8Kl97jXWYm60TM1
         HyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700504634; x=1701109434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWt2/ngqRZl5QuD4sv4zP0M/aVeTZYIc/05gHj626E0=;
        b=R35lBeKCHS+S/5UvFWYIE3AKOqMYO2vWOrBauHy78IkdJqJNF4cveaAO4f9yORAA1Z
         jvJLhfIwJUZwuInychpcMYyTXXuUSPMFN2tpf/MyN0TnryDded6d6JuRDU2IFXn3kk0F
         3V74dw1d//27qiRV3FEeBZvwt1g2MRAx+0GknbCoG92/qSH7xddmeL9h5qaddJ2QmEc2
         f6EGa/Zz00mjBqiGvm5SiodtoNZ94/5EIWz4clRo3FsJytJPvtmwGdd3DifqVmSuwtab
         lzOhbd7B2yjKRkAtlR9lOWILbLuuNybIqdRY0SJNnHFpmNotjxmsFrBTXSkx0TufWY9b
         4hpw==
X-Gm-Message-State: AOJu0YxgZw4WZ4ee4qGTowbVQr3/Rsm4MIQnBD+qVmuO/IMPp7a66m6/
        CRhVA0fB/UE2vAQ1K+gORYg=
X-Google-Smtp-Source: AGHT+IHrha1hJaeUAEfyDeFwDKziEKc0iFZt+aGntiYuaF6IHyvLDYgaoz7VSZSlPyBlwO1InKAh6w==
X-Received: by 2002:a17:902:ecd0:b0:1ce:6687:c93e with SMTP id a16-20020a170902ecd000b001ce6687c93emr7650636plh.69.1700504633709;
        Mon, 20 Nov 2023 10:23:53 -0800 (PST)
Received: from [192.168.1.100] (bb220-255-254-193.singnet.com.sg. [220.255.254.193])
        by smtp.gmail.com with ESMTPSA id bj11-20020a170902850b00b001c739768214sm6401716plb.92.2023.11.20.10.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 10:23:53 -0800 (PST)
Message-ID: <8bce1251-7a6b-4b4c-b700-9d97c664689f@gmail.com>
Date:   Tue, 21 Nov 2023 02:23:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: virtual_ncidev: Add variable to check if ndev is
 running
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        bongsu.jeon@samsung.com
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
Content-Language: en-US
From:   Phi Nguyen <phind.uet@gmail.com>
In-Reply-To: <d82e5a5f-1bbc-455e-b6a7-c636b23591f7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2023 6:45 PM, Krzysztof Kozlowski wrote:
> On 20/11/2023 11:39, Nguyen Dinh Phi wrote:
>>>>>            mutex_lock(&vdev->mtx);
>>>>>            kfree_skb(vdev->send_buff);
>>>>>            vdev->send_buff = NULL;
>>>>> +        vdev->running = false;
>>>>>            mutex_unlock(&vdev->mtx);
>>>>>    
>>>>>            return 0;
>>>>> @@ -50,7 +55,7 @@ static int virtual_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
>>>>>            struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
>>>>>    
>>>>>            mutex_lock(&vdev->mtx);
>>>>> -        if (vdev->send_buff) {
>>>>> +        if (vdev->send_buff || !vdev->running) {
>>>>
>>>> Dear Krzysztof,
>>>>
>>>> I agree this defensive code.
>>>> But i think NFC submodule has to avoid this situation.(calling send function of closed nci_dev)
>>>> Could you check this?
>>>
>>> This code looks not effective. At this point vdev->send_buff is always
>>> false, so the additional check would not bring any value.
>>>
>>> I don't see this fixing anything. Syzbot also does not seem to agree.
>>>
>>> Nguyen, please test your patches against syzbot *before* sending them.
>>> If you claim this fixes the report, please provide me the link to syzbot
>>> test results confirming it is fixed.
>>>
>>> I looked at syzbot dashboard and do not see this issue fixed with this
>>> patch.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Hi Krzysztof,
>>
>> I've submitted it to syzbot, it is the test request that created at
>> [2023/11/20 09:39] in dashboard link
>> https://syzkaller.appspot.com/bug?extid=6eb09d75211863f15e3e
> 
> ...and I see there two errors.
> 
These are because I sent email wrongly and syzbot truncates the patch 
and can not compile

> I don't know, maybe I miss something obvious (our brains like to do it
> sometimes), but please explain me how this could fix anything?
> 
> Best regards,
> Krzysztof
> 

The issue arises when an skb is added to the send_buff after invoking 
ndev->ops->close() but before unregistering the device. In such cases, 
the virtual device will generate a copy of skb, but with no consumer 
thereafter. Consequently, this object persists indefinitely.

This problem seems to stem from the existence of time gaps between 
ops->close() and the destruction of the workqueue. During this interval, 
incoming requests continue to trigger the send function.

best regards,
Phi
