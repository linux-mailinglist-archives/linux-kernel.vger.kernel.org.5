Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5122C7F0E74
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjKTJGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjKTJGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:06:19 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9DAE5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:06:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32d81864e3fso2584569f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700471174; x=1701075974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bC/rGeM/33vQDapK1XI1tnjvO92LcZ0a3nZ21d8K84o=;
        b=vCvinn266WFEw+q+BrdSSfa+qw+yU8JzTu4yl4Oe7EUf1QnFplLvzP8MRu+nGSEXOc
         tqu9aq3zj2eu/8IDUhUUazBoKOoMIgDYw7NWzEdiSI+NSBzNlVw0v86fW1RUk2NSPQu8
         KEzsWGZ8r0hLlUj2fs0heTD+kM2ZIe7BayYnU/7ulinXcH7oHbXvJkeWam0RGb7IkJ+R
         zM6Gz8IwCLGRHHpFdV0UJGwQssb6J+QTOwxMXomY70emOy1PTAeNH3xJMM7jITQIFVb2
         yEJUPWNpSk4nQFW4VtoaIGSnpTa2VKBvDLGFM6VxLN1/ly3TKwWlf4c37ICMTWl2c2YK
         l6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700471174; x=1701075974;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bC/rGeM/33vQDapK1XI1tnjvO92LcZ0a3nZ21d8K84o=;
        b=hospmVNvWbM2bKJPoG18bX3XEcpsWqaHxepGkxQcgqcWzq8Hwv9gSIaBE14Zxc1TVp
         o16XMz/XzocupEWns0EwwqsEWGSRnCmnlJQGuNK2Ehf1B3rtzz+82u/OZf6ETA6le4T+
         sS77evXvFvXAiazc34zeAp9N4SSHZS3Xros0iV3BxOIn/2HY/IMmpBnyI2eLXQiQJIFQ
         rWSSwxFXNuoROzor6n5moIvSZFMAoa7RolOKVlZmcLKmyNVhQkZ8jCm75PJ0d72SMpZO
         YoRDk7k0eXxvjTMoNGVCtqbHvqvKbnQ6jYvRgCusMgM6vJIFMb1EUP/qOicif3HuQwfX
         Z3HQ==
X-Gm-Message-State: AOJu0Yy92MRitxArClbI0SOfMOcZTMH85Co73lHpQ+EgPE0xlJE0l58C
        GoGJno0esu3WZwAKnaUFfAhNyA==
X-Google-Smtp-Source: AGHT+IFsv2MJWFQsxVKkw28H4OgAfes9Qy+8Z0gn43QAHJuzgjQZ6uqgve42b0SpETJnEX95Niu3WA==
X-Received: by 2002:a5d:610d:0:b0:332:ca56:3ca1 with SMTP id v13-20020a5d610d000000b00332ca563ca1mr778633wrt.13.1700471173162;
        Mon, 20 Nov 2023 01:06:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d6a05000000b0032d2489a399sm10386318wru.49.2023.11.20.01.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 01:06:12 -0800 (PST)
Message-ID: <bafc3707-8eae-4d63-bc64-8d415d32c4b9@linaro.org>
Date:   Mon, 20 Nov 2023 10:06:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: virtual_ncidev: Add variable to check if ndev is
 running
Content-Language: en-US
To:     bongsu.jeon@samsung.com, Nguyen Dinh Phi <phind.uet@gmail.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com" 
        <syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>
References: <20231119164705.1991375-1-phind.uet@gmail.com>
 <CGME20231119164714epcas2p2c0480d014abc4f0f780c714a445881ca@epcms2p4>
 <20231120044706epcms2p48c4579db14cc4f3274031036caac4718@epcms2p4>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231120044706epcms2p48c4579db14cc4f3274031036caac4718@epcms2p4>
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

On 20/11/2023 05:47, Bongsu Jeon wrote:
> 
> On 20/11/2023 01:47, Nguyen Dinh Phi wrote:
> 
>> syzbot reported an memory leak that happens when an skb is add to
>> send_buff after virtual nci closed.
>> This patch adds a variable to track if the ndev is running before
>> handling new skb in send function.
>>
>> Reported-by: syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/lkml/00000000000075472b06007df4fb@google.com
>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>> ---
>>  drivers/nfc/virtual_ncidev.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
>> index b027be0b0b6f..ac8226db54e2 100644
>> --- a/drivers/nfc/virtual_ncidev.c
>> +++ b/drivers/nfc/virtual_ncidev.c
>> @@ -20,26 +20,31 @@
>>                                   NFC_PROTO_ISO14443_MASK | \
>>                                   NFC_PROTO_ISO14443_B_MASK | \
>>                                   NFC_PROTO_ISO15693_MASK)
>> +#define NCIDEV_RUNNING 0
> This define isn't used.
> 
>>  
>>  struct virtual_nci_dev {
>>          struct nci_dev *ndev;
>>          struct mutex mtx;
>>          struct sk_buff *send_buff;
>>          struct wait_queue_head wq;
>> +        bool running;
>>  };
>>  
>>  static int virtual_nci_open(struct nci_dev *ndev)
>>  {
>> +        struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
>> +
>> +        vdev->running = true;
>>          return 0;
>>  }
>>  
>>  static int virtual_nci_close(struct nci_dev *ndev)
>>  {
>>          struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
>> -
>>          mutex_lock(&vdev->mtx);
>>          kfree_skb(vdev->send_buff);
>>          vdev->send_buff = NULL;
>> +        vdev->running = false;
>>          mutex_unlock(&vdev->mtx);
>>  
>>          return 0;
>> @@ -50,7 +55,7 @@ static int virtual_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
>>          struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
>>  
>>          mutex_lock(&vdev->mtx);
>> -        if (vdev->send_buff) {
>> +        if (vdev->send_buff || !vdev->running) {
> 
> Dear Krzysztof,
> 
> I agree this defensive code.
> But i think NFC submodule has to avoid this situation.(calling send function of closed nci_dev)
> Could you check this?

This code looks not effective. At this point vdev->send_buff is always
false, so the additional check would not bring any value.

I don't see this fixing anything. Syzbot also does not seem to agree.

Nguyen, please test your patches against syzbot *before* sending them.
If you claim this fixes the report, please provide me the link to syzbot
test results confirming it is fixed.

I looked at syzbot dashboard and do not see this issue fixed with this
patch.

Best regards,
Krzysztof

