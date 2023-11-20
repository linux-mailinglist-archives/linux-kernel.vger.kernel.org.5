Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AEA7F115B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjKTLJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjKTLHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:07:53 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A1AD4D;
        Mon, 20 Nov 2023 03:07:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 766F34195A;
        Mon, 20 Nov 2023 11:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1700478458; bh=StbzyAS5+LLhtN73q/gFPznopbGCKLhwnROcQMkw3Hw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BZKXe/i2Iu9fxFblxAq/aMYbruLvqE/BYFshIMAmLgr1icRClZBpLOmCVRcVZt+g5
         JTC2ZsCZGPCBOiJKKMQX7WeGvbRhWgKY7Qv2rxJHTNcUL2Gc357hnq38wwdU0bNqph
         suSgy0SSE/YK5UWxiz1rH7nwfxy64lAj/Zc/hjkWJYLId0UeE4vfmBRdeGtkgYZwIP
         IMvqBxg1s9vqRTUGTkxbgEHDZCxV+6vEqoJ5BDuGKQKu/NRWK7Sjp8nJi/P2/gLRdJ
         1u07INrpu/vgeDgPdF5UBq8J+s/AeeEF7lZvqRWONGtHBLJ9u40eiptteIxz5Rch3X
         hyC0kJlGOjSbQ==
Message-ID: <3b5aedb4-da00-4ae2-a60f-685dba949223@marcan.st>
Date:   Mon, 20 Nov 2023 20:07:32 +0900
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
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <0900292C-5E74-471A-B789-A1D35D1BBBF7@live.com>
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



On 2023/11/19 4:31, Aditya Garg wrote:
> 
> 
>> On 14-Nov-2023, at 3:14 PM, Hector Martin <marcan@marcan.st> wrote:
>>
>> On 14/11/2023 18.03, Aditya Garg wrote:
>>>
>>>
>>>> On 14-Nov-2023, at 1:28 PM, Hector Martin <marcan@marcan.st> wrote:
>>>>
>>>> On 14/11/2023 15.59, Hector Martin wrote:
>>>>> On 14/11/2023 15.23, Aditya Garg wrote:
>>>>>>
>>>>>>
>>>>>>> On 14-Nov-2023, at 5:01 AM, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>>>>>>
>>>>>>> ﻿On Mon, Nov 13, 2023 at 08:57:35PM +0000, Aditya Garg wrote:
>>>>>>>> Starting from kernel 6.5, a regression in the kernel is causing Bluetooth to not work on T2 Macs with BCM4377 chip.
>>>>>>>>
>>>>>>>> Journalctl of kernel 6.4.8 which has Bluetooth working is given here: https://pastebin.com/u9U3kbFJ
>>>>>>>>
>>>>>>>> Journalctl of kernel 6.5.2, which has Bluetooth broken is given here: https://pastebin.com/aVHNFMRs
>>>>>>>>
>>>>>>>> Also, the bug hasn’t been fixed even in 6.6.1, as reported by users.
>>>>>>>
>>>>>>> Can you bisect this regression please?
>>>>>>
>>>>>> Since I don't have access to this hardware, it's not possible for me to bisect this regression. Let's hope someone is able to do so though.
>>>>>
>>>>> It's not a regression, it was always broken. I'm sending a patch.
>>>>>
>>>>> - Hector
>>>>
>>>> You are quite likely conflating two problems. The ubsan issue you quoted
>>>> was always there and the patch I just sent fixes it, but it almost
>>>> certainly always worked fine in practice without ubsan.
>>>>
>>>> The Bluetooth problem you are referring to is likely *specific to
>>>> Bluetooth LE devices* and the regression was introduced by 288c90224e
>>>> and fixed by 41e9cdea9c, which is also in 6.5.11 and 6.6.1.
>>>>
>>>> If Bluetooth is broken in *some other way* in 6.6.1 then we need a
>>>> proper report or a bisect. Your logs don't show any issues other than
>>>> the ubsan noise, which is not a regression.
>>>>
>>>> - Hector
>>>>
>>>
>>> UBSAN noise seems to be fixed, Bluetooth not working though
>>>
>>> https://pastebin.com/HeVvMVk4
>>>
>>> Ill try setting .broken_le_coded = true,
>>
>> Now you have a probe timeout, which you didn't have before. That's a
>> different problem.
>>
>> Please try this commit and see if it helps:
>>
>> https://github.com/AsahiLinux/linux/commit/8ec770b4f78fc14629705206e2db54d9d6439686
>>
>> If it's this then it's still not a regression, it's probably just random
>> chance since I think the old timeout value was borderline for the older
>> chips.
>>
>> - Hector
>>
> 
> 
> Hi
> 
> I recently got a kernel tested with this patch as well as with .broken_le_coded = true,
> Here are the logs: https://pastebin.com/BpfJuJKY
> 
> Also, without .broken_le_coded = true, the bluetooth doesn't work, as specified in my previous email.

So are you saying everything works now? If not, what doesn't work?
"Bluetooth doesn't work" isn't useful information, especially in the
absence of any useful error messages. You can't just dump dmesg logs at
us, you have to *describe* what the problem is.

If broken_le_coded = true "fixed" it then "bluetooth doesn't work" was a
terrible bug report. What that quirk does is make *connecting/pairing to
Bluetooth LE devices* work. Non-BLE devices already worked, the
controller worked, scanning worked, etc. All that is useful information
if you want to get support for issues. We can't magically divine what's
wrong if you just send us a dmesg and say "it's broken". We need
detailed information about exactly what works and what doesn't (e.g. the
controller not showing up at all is VERY different from it showing up
but not finding your device). The only reason we guessed this here is
that this was a known issue that affected other chips. If we ever run
into a 4377-specific issue that only you can reproduce, "bluetooth
doesn't work" and no error logs really isn't going to get it fixed.

- Hector
