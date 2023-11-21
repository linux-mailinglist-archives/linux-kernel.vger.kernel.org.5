Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C027F2CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjKUMQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjKUMQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:16:53 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E987137;
        Tue, 21 Nov 2023 04:16:49 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4C73F41D83;
        Tue, 21 Nov 2023 12:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1700569008; bh=iMeRzervuoudDuGdhL6yX2feFImvQm3SAtDHF37I57s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=r2IeCQq429ic+JyT9x/9Ch2c+AqAnZ2/FRs8iJmEjkL5FDbywPnA8ojG3Rjd9q1w7
         p8qCWUCIcbEJhe1F+aLxTAXUlvmwNTlQus1DMprVEqaRatWfi6i673AHnZaQ5Lj68t
         iXRTwlXGZioyvc62UBVZ29XnGCkD6a/F5H6o8LOQT6UxpqJik76oxJaWwWqHxtHkKF
         zfrOW8pd5gKp9V2tZXqehSeJuWO09yunle0lRdUDfoMOhpQKmv2hOtPi0zLBH9XHTZ
         ii6X/0OfRUjOFjuJkZdM0/wKrcjqUwJYwK2CwwnzzFWIm1HqzzZcnoRBAXvaQyV4+E
         kZ83sgdG3BEtQ==
Message-ID: <e4d254a6-3244-4b0b-a2bb-f48824e02995@marcan.st>
Date:   Tue, 21 Nov 2023 21:16:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Bluetooth is not working on Macs with BCM4377 chip
 starting from kernel 6.5
Content-Language: en-US
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Asahi Linux Mailing List <asahi@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        "j@jannau.net" <j@jannau.net>
References: <22582194-DE99-45E5-ABEE-C1C7900DA523@live.com>
 <ZVKxtD2Mt_eVyttJ@archie.me>
 <MA0P287MB021794BCCCFB5EA57C1C3B69B8B2A@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <88fcc70e-9f4b-eeb9-d826-03fa4c40e7c3@marcan.st>
 <e2909986-34b5-3ae2-cf5c-a1f8c46a1e0a@marcan.st>
 <6574A65F-3C4D-4E26-8848-F12C38668478@live.com>
 <03cdd06c-3991-dbf8-6068-e76384db8240@marcan.st>
 <0900292C-5E74-471A-B789-A1D35D1BBBF7@live.com>
 <3b5aedb4-da00-4ae2-a60f-685dba949223@marcan.st>
 <MA0P287MB0217A68FDF5E0DC22F19D3DCB8BBA@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <MA0P287MB0217A68FDF5E0DC22F19D3DCB8BBA@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/21 20:42, Aditya Garg wrote:
> 
> 
>> On 20-Nov-2023, at 4:37 PM, Hector Martin <marcan@marcan.st> wrote:
>>
>> ﻿
>>
>>> On 2023/11/19 4:31, Aditya Garg wrote:
>>>
>>>
>>>>> On 14-Nov-2023, at 3:14 PM, Hector Martin <marcan@marcan.st> wrote:
>>>>
>>>> On 14/11/2023 18.03, Aditya Garg wrote:
>>>>>
>>>>>
>>>>>> On 14-Nov-2023, at 1:28 PM, Hector Martin <marcan@marcan.st> wrote:
>>>>>>
>>>>>> On 14/11/2023 15.59, Hector Martin wrote:
>>>>>>> On 14/11/2023 15.23, Aditya Garg wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>> On 14-Nov-2023, at 5:01 AM, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> ﻿On Mon, Nov 13, 2023 at 08:57:35PM +0000, Aditya Garg wrote:
>>>>>>>>>> Starting from kernel 6.5, a regression in the kernel is causing Bluetooth to not work on T2 Macs with BCM4377 chip.
>>>>>>>>>>
>>>>>>>>>> Journalctl of kernel 6.4.8 which has Bluetooth working is given here: https://pastebin.com/u9U3kbFJ
>>>>>>>>>>
>>>>>>>>>> Journalctl of kernel 6.5.2, which has Bluetooth broken is given here: https://pastebin.com/aVHNFMRs
>>>>>>>>>>
>>>>>>>>>> Also, the bug hasn’t been fixed even in 6.6.1, as reported by users.
>>>>>>>>>
>>>>>>>>> Can you bisect this regression please?
>>>>>>>>
>>>>>>>> Since I don't have access to this hardware, it's not possible for me to bisect this regression. Let's hope someone is able to do so though.
>>>>>>>
>>>>>>> It's not a regression, it was always broken. I'm sending a patch.
>>>>>>>
>>>>>>> - Hector
>>>>>>
>>>>>> You are quite likely conflating two problems. The ubsan issue you quoted
>>>>>> was always there and the patch I just sent fixes it, but it almost
>>>>>> certainly always worked fine in practice without ubsan.
>>>>>>
>>>>>> The Bluetooth problem you are referring to is likely *specific to
>>>>>> Bluetooth LE devices* and the regression was introduced by 288c90224e
>>>>>> and fixed by 41e9cdea9c, which is also in 6.5.11 and 6.6.1.
>>>>>>
>>>>>> If Bluetooth is broken in *some other way* in 6.6.1 then we need a
>>>>>> proper report or a bisect. Your logs don't show any issues other than
>>>>>> the ubsan noise, which is not a regression.
>>>>>>
>>>>>> - Hector
>>>>>>
>>>>>
>>>>> UBSAN noise seems to be fixed, Bluetooth not working though
>>>>>
>>>>> https://pastebin.com/HeVvMVk4
>>>>>
>>>>> Ill try setting .broken_le_coded = true,
>>>>
>>>> Now you have a probe timeout, which you didn't have before. That's a
>>>> different problem.
>>>>
>>>> Please try this commit and see if it helps:
>>>>
>>>> https://github.com/AsahiLinux/linux/commit/8ec770b4f78fc14629705206e2db54d9d6439686
>>>>
>>>> If it's this then it's still not a regression, it's probably just random
>>>> chance since I think the old timeout value was borderline for the older
>>>> chips.
>>>>
>>>> - Hector
>>>>
>>>
>>>
>>> Hi
>>>
>>> I recently got a kernel tested with this patch as well as with .broken_le_coded = true,
>>> Here are the logs: https://pastebin.com/BpfJuJKY
>>>
>>> Also, without .broken_le_coded = true, the bluetooth doesn't work, as specified in my previous email.
>>
>> So are you saying everything works now? If not, what doesn't work?
>> "Bluetooth doesn't work" isn't useful information, especially in the
>> absence of any useful error messages. You can't just dump dmesg logs at
>> us, you have to *describe* what the problem is.
>>
> My bad for not specifying that. The user reports that the Bluetooth device is not recognised at all.
> 
> Also, broken_le_coded = true did not "fix" it.
> 
> Talking about dmesg, well not getting any logs regarding this message indeed is a frustrating thing for me, and bisecting seems to be the only option in my mind rn.
> 

What does that mean? The controller or the device? Can you initiate a
scan? Does it find any devices? Is pairing broken or just connecting?
Was the device paired before or after the breaking change? *What* device
are you trying to use/pair?

What do these commands say?

$ bluetoothctl show
$ bluetoothctl devices

Since the kernel isn't logging any errors, have you looked at syslog to
see what the whole userspace side has to say? If an operation is failing
*something* should be logging an error.

*Please*, we need proper detailed bug reports if you want this to get
fixed. I'm sure you're aware of what a reasonable bug report is. Please
teach your user how to provide useful information. Otherwise yes, it's
going to be on you to bisect it since there's nothing we can do with
zero details and useful logs.

- Hector
