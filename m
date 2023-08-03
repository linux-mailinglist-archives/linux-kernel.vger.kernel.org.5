Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C0176ECC3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbjHCOhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbjHCOhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:37:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5311A4C3B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:36:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso10890345e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691073379; x=1691678179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzLqXdsOToTJCAjPdHmcMFH6VhO+zYxqzF/B4ldzHXs=;
        b=U313M1uzbuFj9Z1IG4LRMxUJXR3GU1wWRSg7e1fxJ1c3MDiZjviBufqo15cfY83nYs
         DrLL7FrL5Nu1Mv6iwBGRiL9o26dYlu+qbZDIId7hlX6czuNisGoMCyF8qBJz+f50T9eH
         Wos40edfnFTEZ+o4kosi+XQvZnBXD9/uWrZLkb3j/1RCo/vAhuFt64vB7LOU29Ma8xjc
         A7BxW+HR9IOuAsvwRfZyxeYXICoO2E78WAb2Kur3LhZ0i0O2c4sFqHhhLf4lSOXxbrtP
         MyWDnOljnzMdRS9W/PELffcyrW1LLQAadBpiknpiJccOcYgzdt5m5Bnd56NMqzvNfAwp
         MzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691073379; x=1691678179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzLqXdsOToTJCAjPdHmcMFH6VhO+zYxqzF/B4ldzHXs=;
        b=Yzq10C4twPiv3k4pOr9sJvDUuEKxbFTvJUmJdH5GK0JTVrcQJRVsWvQonlpMad1o4F
         FOR+pd2xOJiWDWODaUYdka7oRgioSX0Y9cvfWCtDF4qDJmv6N48zUtq7ULXBuQNPKxUQ
         mbf4aUUnTHQydh1kv3E3eT5/9JqrdBoZqLGDRhB8eU5EGRn6AvwVbEvo5kFaDq8qYnhl
         pCYG633Ea9uHlLUHTku/SgF6/tlu0JEzeF2ZizLJLfZhROAqbgfQeHMCnlZQuqSC7Paf
         /toLiu1SPyVfVEZQW10cBVedRgcpUtVzBx8ktkv8/5fEsl9NNVyOCJia/oN1X+SoT+b3
         P7eg==
X-Gm-Message-State: ABy/qLZRDVRMcmXi4CJjl3JKP5m5dgOuVtMtQlynkQ0+V8lKyUn3oP/O
        8pjDJ3PCU7xyQQTYoRBgaGEKkxXT5oA=
X-Google-Smtp-Source: APBJJlFn5pw7orVnGePFk3OzEZU0DDmLkD9qYF0MPhdQ8N1oP0zaleo8LZHSSHCjDwjVUP2T2X1XoA==
X-Received: by 2002:a05:600c:2048:b0:3fe:2bb1:11ba with SMTP id p8-20020a05600c204800b003fe2bb111bamr6644892wmg.27.1691073378979;
        Thu, 03 Aug 2023 07:36:18 -0700 (PDT)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id s4-20020a05600c044400b003fe24681b10sm4441228wmb.28.2023.08.03.07.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 07:36:18 -0700 (PDT)
Message-ID: <87d361ca-7512-4451-016e-6c2e3cec2bfe@gmail.com>
Date:   Thu, 3 Aug 2023 15:36:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fwd: crash/hang in mm/swapfile.c:718 add_to_avail_list when
 exercising stress-ng
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <43765f2d-f486-8b00-7fb9-9eaea5045bfe@gmail.com>
 <20230803060646.GA87850@ziqianlu-dell>
 <20230803134106.GA130558@ziqianlu-dell>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <20230803134106.GA130558@ziqianlu-dell>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

Thanks for the speedy fix. I've tested this for a couple of 10 minute 
soak test and can't reproduce the issue with the fix, so it looks good 
to me, so please add:

Tested-by: Colin Ian King <colin.i.king@gmail.com>

Colin

On 03/08/2023 14:41, Aaron Lu wrote:
> On Thu, Aug 03, 2023 at 02:06:46PM +0800, Aaron Lu wrote:
>> On Wed, Aug 02, 2023 at 07:54:38PM +0700, Bagas Sanjaya wrote:
>>> Hi,
>>>
>>> I notice a bug report on Bugzilla [1]. Quoting from it:
>>>
>>>> How to reproduce:
>>>>
>>>> Had 24 CPU Alderlake 16GB debian12 system running with default kernel (from makecondig) on 6.5-rc4, exercised with no swap to start with.
>>>>
>>>> using stress-ng tip commit 0f2ef02e9bc5abb3419c44be056d5fa3c97e0137
>>>> (see https://github.com/ColinIanKing/stress-ng )
>>>>
>>>> build and run stress-ng for say 60 minutes:
>>>>
>>>> ./stress-ng --cpu-online 50 --brk 50 --swap 50 --vmstat 1 -t 60m
>>>>
>>>> Will hang in mm/swapfile.c:718 add_to_avail_list+0x93/0xa0
>>>>
>>>> See attached file for an image of the console on the hang (I'm trying to get the full stack dump).
>>>
>>> See Bugzilla for the full thread and attached console image.
>>>
>>> FWIW, I have to forward this bug report to the mailing lists because
>>> Thorsten noted that many developers don't take a look on Bugzilla
>>> (see the BZ thread).
>>
>> Thanks.
>>
>> I can reproduce this issue using below cmdline:
>> $ sudo ./stress-ng --brk 50 --swap 5 --vmstat 1 -t 60m
>>
>> I'll investigate what is happening.
> 
> Hi Colin,
> 
> Can you try the below diff on top of v6.5-rc4? It works for me here
> although I got the warn in a different place in get_swap_pages():
> 
>                          WARN(!si->highest_bit,
>                               "swap_info %d in list but !highest_bit\n",
>                               si->type);
> 
> I think the warn you got in add_to_avail_list() due to the swap device
> is already in the list is similar, see below explanation.
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 8e6dde68b389..cb7e93ec1933 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2330,7 +2330,8 @@ static void _enable_swap_info(struct swap_info_struct *p)
>   	 * swap_info_struct.
>   	 */
>   	plist_add(&p->list, &swap_active_head);
> -	add_to_avail_list(p);
> +	if (p->highest_bit)
> +		add_to_avail_list(p);
>   }
>   
>   static void enable_swap_info(struct swap_info_struct *p, int prio,
> 
> The finding is, if a swap device failed to be swapoff, then it will be
> reinsert_swap_info() -> _enable_swap_info() -> add_to_avail_list(). The
> problem is, this swap device may run out of space with its highest_bit
> being 0 and shouldn't be added to avail list. In your case, once its
> highest_bit becomes non-zero, it will go through add_to_avail_list()
> and since it's already in the list, thus the warn.
> 
> If it works for you, I'll prepare a patch. Thanks.

