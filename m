Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BBB7EAD37
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjKNJo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjKNJo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:44:57 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507A7191;
        Tue, 14 Nov 2023 01:44:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 72654425C8;
        Tue, 14 Nov 2023 09:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1699955089; bh=LoayNsgjh6Dn6iZehZ5Fl+EuN1byKvLu1MmbdWR0Slk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dUcLu8j+C97zwCZwIPXHJWA1tqihkLkH8KbelZweaDqtD+2sJd2X7rdqVkaEtwuMe
         VQIAJVLtAalOTYwL0U50r4ujqmoD6BWclAWeaKe7qfavAhBoxmnXERCkaxr6I9tq42
         1/trLYeLhJvYQ7fr5sNlNdLAdsxeKu2YrsY09K7yEIKWnItVgHMbveTUu35DBrOyPO
         /6EagiTIzrLApLy23tyR+2dZMhmsZwmRhF1OKWwtcGhj7V1KLblFLrT/XO90vgDTvc
         wKqsmuo2Y5Ktdn6IxXB1qOK7rXxC9p4DeUDCRnqWSpqW3kWWpUY+umyl6PaSqX7Z+a
         9OyR++F76fhSg==
Message-ID: <03cdd06c-3991-dbf8-6068-e76384db8240@marcan.st>
Date:   Tue, 14 Nov 2023 18:44:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <22582194-DE99-45E5-ABEE-C1C7900DA523@live.com>
 <ZVKxtD2Mt_eVyttJ@archie.me>
 <MA0P287MB021794BCCCFB5EA57C1C3B69B8B2A@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <88fcc70e-9f4b-eeb9-d826-03fa4c40e7c3@marcan.st>
 <e2909986-34b5-3ae2-cf5c-a1f8c46a1e0a@marcan.st>
 <6574A65F-3C4D-4E26-8848-F12C38668478@live.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <6574A65F-3C4D-4E26-8848-F12C38668478@live.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2023 18.03, Aditya Garg wrote:
> 
> 
>> On 14-Nov-2023, at 1:28 PM, Hector Martin <marcan@marcan.st> wrote:
>>
>> On 14/11/2023 15.59, Hector Martin wrote:
>>> On 14/11/2023 15.23, Aditya Garg wrote:
>>>>
>>>>
>>>>> On 14-Nov-2023, at 5:01 AM, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>>>>
>>>>> ﻿On Mon, Nov 13, 2023 at 08:57:35PM +0000, Aditya Garg wrote:
>>>>>> Starting from kernel 6.5, a regression in the kernel is causing Bluetooth to not work on T2 Macs with BCM4377 chip.
>>>>>>
>>>>>> Journalctl of kernel 6.4.8 which has Bluetooth working is given here: https://pastebin.com/u9U3kbFJ
>>>>>>
>>>>>> Journalctl of kernel 6.5.2, which has Bluetooth broken is given here: https://pastebin.com/aVHNFMRs
>>>>>>
>>>>>> Also, the bug hasn’t been fixed even in 6.6.1, as reported by users.
>>>>>
>>>>> Can you bisect this regression please?
>>>>
>>>> Since I don't have access to this hardware, it's not possible for me to bisect this regression. Let's hope someone is able to do so though.
>>>
>>> It's not a regression, it was always broken. I'm sending a patch.
>>>
>>> - Hector
>>
>> You are quite likely conflating two problems. The ubsan issue you quoted
>> was always there and the patch I just sent fixes it, but it almost
>> certainly always worked fine in practice without ubsan.
>>
>> The Bluetooth problem you are referring to is likely *specific to
>> Bluetooth LE devices* and the regression was introduced by 288c90224e
>> and fixed by 41e9cdea9c, which is also in 6.5.11 and 6.6.1.
>>
>> If Bluetooth is broken in *some other way* in 6.6.1 then we need a
>> proper report or a bisect. Your logs don't show any issues other than
>> the ubsan noise, which is not a regression.
>>
>> - Hector
>>
> 
> UBSAN noise seems to be fixed, Bluetooth not working though
> 
> https://pastebin.com/HeVvMVk4
> 
> Ill try setting .broken_le_coded = true,

Now you have a probe timeout, which you didn't have before. That's a
different problem.

Please try this commit and see if it helps:

https://github.com/AsahiLinux/linux/commit/8ec770b4f78fc14629705206e2db54d9d6439686

If it's this then it's still not a regression, it's probably just random
chance since I think the old timeout value was borderline for the older
chips.

- Hector

