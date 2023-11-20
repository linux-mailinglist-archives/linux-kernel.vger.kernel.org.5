Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A727F1087
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjKTKj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjKTKjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:39:53 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AD1CA;
        Mon, 20 Nov 2023 02:39:50 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cb7951d713so733817b3a.1;
        Mon, 20 Nov 2023 02:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700476790; x=1701081590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtGGo061f2WLq9ZLa8o2ICbUORkS2hheIq/oEVkB6Kk=;
        b=Qu8fla+c/RSPB78V0wBKbGu3voQMw9ke2/RHsHMtSmuqEcOcmv21YhOU5ZPPeJN6hY
         Sv1DJL8FOH76T+uw3BzZbmNeB+1pvkMbfxy6iVCLUawYXGlOgG3NsIxG2Ma1qmDEtCeU
         X8VBkmFe97jls1QBZ5gQDzJUjtYVIgIEe+1bxZhT30fmCRpOYKx3N3D671jWLv0u2hm2
         OOqu0I5GMKyrZTD/gf0gUf3cX8ZytmbiqGYij1xUykCAOxJIrhWGrhF+F1bH0NnY4BrE
         cl0tziUeWdBrat/3D4DXZyxtQgNEXqNvSeiT+hyeyq/yRMTv7E73BiZdHKte5KB7yRvl
         IL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700476790; x=1701081590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XtGGo061f2WLq9ZLa8o2ICbUORkS2hheIq/oEVkB6Kk=;
        b=P/34tuOaTryRetGKJwawFZAnhAjErSLaE88pluzToeU/fVlvPmNpu4a1kr51p5k/jS
         igvXbZx6oUvX+HeHg/ckjUNSdYsNy6JRQ8mvxUEtXTVb8TXrHEOVu21Fyl25XK33YKSX
         PQBp+oBA/X1IFU8LgQc8t9d54oc2DIkGQrS5fL0VQUzBQG3yWFLKhhhHhSqPeLbFppXK
         zEMOAcq4vfTXWWoRjoJ/0akLEtriWxmjcBr0GyAPkzrK2j1dfVCUEcuhsQ9eUo6GtPTJ
         z5+1RGyaQsoAl5kGeLlwG8wYhRr/nk+JLiDS3M1D1ejYqPEj69rmy6YMilZcjbTlClJU
         QSQg==
X-Gm-Message-State: AOJu0YymXxt5Y+tpxUBMxbmGQznvxd3ERLXf5cHykGbQsja8+CBqGoG9
        t7icrTUusn13a0bXoFIog3GvGCXOYEnZcA==
X-Google-Smtp-Source: AGHT+IGO8mgfpnclh/QMCKbAYzY+SEuOzgS/o9v3Mwbk4WJmXk77yN9OElYeMACTlb0XmPSW5UEeLg==
X-Received: by 2002:a05:6a00:310f:b0:6c4:d6fa:ee9d with SMTP id bi15-20020a056a00310f00b006c4d6faee9dmr16513072pfb.1.1700476789595;
        Mon, 20 Nov 2023 02:39:49 -0800 (PST)
Received: from [10.22.76.35] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00218a00b006cb4ad55fbasm4172931pfi.179.2023.11.20.02.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 02:39:49 -0800 (PST)
Message-ID: <20d93e83-66c0-28d9-4426-a0d4c098f303@gmail.com>
Date:   Mon, 20 Nov 2023 18:39:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.0
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
From:   Nguyen Dinh Phi <phind.uet@gmail.com>
In-Reply-To: <bafc3707-8eae-4d63-bc64-8d415d32c4b9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/11/23 5:06 pm, Krzysztof Kozlowski wrote:
> On 20/11/2023 05:47, Bongsu Jeon wrote:
>>
>> On 20/11/2023 01:47, Nguyen Dinh Phi wrote:
>>
>>> syzbot reported an memory leak that happens when an skb is add to
>>> send_buff after virtual nci closed.
>>> This patch adds a variable to track if the ndev is running before
>>> handling new skb in send function.
>>>
>>> Reported-by: syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/lkml/00000000000075472b06007df4fb@google.com
>>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>>> ---
>>>   drivers/nfc/virtual_ncidev.c | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
>>> index b027be0b0b6f..ac8226db54e2 100644
>>> --- a/drivers/nfc/virtual_ncidev.c
>>> +++ b/drivers/nfc/virtual_ncidev.c
>>> @@ -20,26 +20,31 @@
>>>                                    NFC_PROTO_ISO14443_MASK | \
>>>                                    NFC_PROTO_ISO14443_B_MASK | \
>>>                                    NFC_PROTO_ISO15693_MASK)
>>> +#define NCIDEV_RUNNING 0
>> This define isn't used.
>>
>>>   
>>>   struct virtual_nci_dev {
>>>           struct nci_dev *ndev;
>>>           struct mutex mtx;
>>>           struct sk_buff *send_buff;
>>>           struct wait_queue_head wq;
>>> +        bool running;
>>>   };
>>>   
>>>   static int virtual_nci_open(struct nci_dev *ndev)
>>>   {
>>> +        struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
>>> +
>>> +        vdev->running = true;
>>>           return 0;
>>>   }
>>>   
>>>   static int virtual_nci_close(struct nci_dev *ndev)
>>>   {
>>>           struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
>>> -
>>>           mutex_lock(&vdev->mtx);
>>>           kfree_skb(vdev->send_buff);
>>>           vdev->send_buff = NULL;
>>> +        vdev->running = false;
>>>           mutex_unlock(&vdev->mtx);
>>>   
>>>           return 0;
>>> @@ -50,7 +55,7 @@ static int virtual_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
>>>           struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
>>>   
>>>           mutex_lock(&vdev->mtx);
>>> -        if (vdev->send_buff) {
>>> +        if (vdev->send_buff || !vdev->running) {
>>
>> Dear Krzysztof,
>>
>> I agree this defensive code.
>> But i think NFC submodule has to avoid this situation.(calling send function of closed nci_dev)
>> Could you check this?
> 
> This code looks not effective. At this point vdev->send_buff is always
> false, so the additional check would not bring any value.
> 
> I don't see this fixing anything. Syzbot also does not seem to agree.
> 
> Nguyen, please test your patches against syzbot *before* sending them.
> If you claim this fixes the report, please provide me the link to syzbot
> test results confirming it is fixed.
> 
> I looked at syzbot dashboard and do not see this issue fixed with this
> patch.
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,

I've submitted it to syzbot, it is the test request that created at 
[2023/11/20 09:39] in dashboard link 
https://syzkaller.appspot.com/bug?extid=6eb09d75211863f15e3e

Best regards,
Phi
