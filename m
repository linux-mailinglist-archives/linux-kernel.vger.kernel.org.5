Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE7C7A3178
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 18:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjIPQnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 12:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIPQnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 12:43:13 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76554CCF;
        Sat, 16 Sep 2023 09:43:07 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76dc77fd01fso205726585a.3;
        Sat, 16 Sep 2023 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694882586; x=1695487386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dICxSEqqNSrxKtPaR7TehNToP9XLXC7Y2cmWjhBfv3s=;
        b=IIaac7kQrRF2yVk4ngCBTGlTJR5YO37N7Uo/RJlalxTUXOPJKmVTWXBaE1HqnCOC0W
         sSRYHQndNpGLvUDu9zMUc2WbItgVouPeFjYITdoBuAYwEJ1ek4MHVdOD5shQId0Vb62+
         6g0mQq59yEe9QpwN0sPPTjxeGb9MWlnHMd1Q99tBYhCSIEN0xGBA39EivQRR8x5Kx/Ag
         zFxBApMVTK6Iry7oTlk8uLOha7h3r3stkxHQzt0bLaGbfvZuaMf6TyoqpMzH3P0EQqt8
         ipatOSWczSqTmaPvLz6vHPNJTLSSAVbEzRRRpF5kla5oqH/hjPn/McMMVbe03EspfG64
         GAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694882586; x=1695487386;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dICxSEqqNSrxKtPaR7TehNToP9XLXC7Y2cmWjhBfv3s=;
        b=Beqxcwn1am661JbxYf9FHyEHTJK03xti/lC4b4BPiaYqwIw9tRkdnKKox/bcm6J6uk
         XQsYxhaqx26PsxZLDEjPTxk5M9MxDIDYFFeWI6bWsHllKrld4UaeRVsy+/XUz6l0r1vy
         8Wr8p6jN3m0cg1Y5NXDymugJS2vDHqpcb0/1gondKsrTYeN4MUvohtW0LSc/1eCux69D
         ntJmENz/MSJk8ZVR7PNL3KMeZ3pywCOzANGfos0oIf7gJxSdHe+Dh6xDeUHmpetuV8EA
         +XNj9AXKcoaCIDm/vADum7r9mXO1clPAEbCVOIzfj0p8Zb3r4kTifIS4bmNp2ohFcjfz
         TrAQ==
X-Gm-Message-State: AOJu0Yz4b3lftFByT/ah4aUZbEsO0lV5uaHghq3a8LEnegss8NlPRhG1
        4cXTVRHCR8vFaWds+rppGUk=
X-Google-Smtp-Source: AGHT+IFj7ZmFScOt52xKWKLrdgflr5e0M1KmYKYqBSXdPE5h0K9FTtv9XVnhIyxqA2oigMkkVfdKQw==
X-Received: by 2002:a05:620a:44d3:b0:772:5d84:36ed with SMTP id y19-20020a05620a44d300b007725d8436edmr5054230qkp.50.1694882586267;
        Sat, 16 Sep 2023 09:43:06 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id m10-20020ae9e00a000000b0076f35d17d06sm1978093qkk.69.2023.09.16.09.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 09:43:04 -0700 (PDT)
Message-ID: <3395161f-2543-46f0-83d9-b918800305e1@gmail.com>
Date:   Sat, 16 Sep 2023 09:42:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] vlynq: remove bus support
Content-Language: en-US
To:     Jonas Gorski <jonas.gorski@gmail.com>,
        Wolfram Sang <wsa@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org
References: <20230916091125.3221-1-wsa@kernel.org>
 <CAOiHx=kLQzTTzuGM0tyuv=e9J3Oi7EbWWYFRK5mEfqNrVj05NQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <CAOiHx=kLQzTTzuGM0tyuv=e9J3Oi7EbWWYFRK5mEfqNrVj05NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/2023 4:11 AM, Jonas Gorski wrote:
> On Sat, 16 Sept 2023 at 11:18, Wolfram Sang <wsa@kernel.org> wrote:
>>
>> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>
>> I'd like to clean up the 'drivers' directory and Kconfig menu, at least
>> a little. One major thing I noticed is that VLYNQ can actually be
>> removed. From patch 2:
>>
>> ---
>> There are no users with a vlynq_driver in the Kernel tree. So, remove
>> the bus driver which hardly has seen any activity since 2009. It was
>> even marked EXPERIMENTAL as long as that symbol existed. OpenWRT had
>> some out-of-tree drivers which they probably intended to upport, but AR7
>> devices are not supported anymore because they are "stuck with Kernel
>> 3.18" [1]. So, this code can go nowadays.
>>
>> [1] https://openwrt.org/docs/techref/targets/ar7
>> ---
>>
>> Patch 1 removes MIPS specific bus initialization code which is the only
>> user of the VLYNQ bus currently.
>>
>> Sending out as RFC to gather comments. Patches are based on 6.6-rc1 and
>> created with "--irreversible-delete" to save some space. They are
>> compile tested only, buildbots were happy.
>>
>> I think this mainly goes to Florian Fainelli. Florian, what do you
>> think?
> 
> I'm not Florian, but I worked a bit with AR7 as well, and going
> through the (previously) supported/known devices they topped out at 8
> MiB Flash and 32 MiB RAM, which isn't enough to run any reasonably
> modern OpenWrt even if one would be willing to re-add support for it.
> 
> So from my perspective I suggest even dropping the AR7 code entirely.
> I seriously doubt anyone is running a modern kernel on that.

Agreed, TI AR7 is nearly 25 years old now, we should be able to remove 
that. Wolfram, do you feel like doing that or would you rather have me 
do it, say next week?
-- 
Florian
