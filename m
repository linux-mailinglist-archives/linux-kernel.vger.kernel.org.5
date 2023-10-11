Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5F47C5909
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjJKQVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjJKQVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:21:11 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB46B6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:21:08 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3528b1c4977so1561275ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697041268; x=1697646068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FrKXtW+aPi7brg8nk5i96Avsz2oZOzgad82HhvhxQxU=;
        b=BIdP/AKEG63c5VNgDmN9HRR5KTx4hq9mLJcJZzvap0IMdku2CdU2Zl3JOT6tF2v1TK
         SzUpUHr6deafaH5CsHBpHlnw1dGBZAd2q40jiGInjd7ZOEygGTcTgUAD24aHfmbxclf2
         YACtO0wEGTzMKWOmC43ZmYcvGy7QBwZ7PodO2yRlRR3jFycSLQFPv0xRttiv4Rpiqs2w
         FVaR8Yi3bWk6oxIe4fnA1q87a4aB2c/nIf3ryK+6w90Z/x5OVxbcrf9GBTdtddMWySJF
         ylXz27rRINPdbqmz+VDYHiwkEoGWYUZafx+yVhycAIqwWh6GnvNK7W61Td6bAmCvs463
         PYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697041268; x=1697646068;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FrKXtW+aPi7brg8nk5i96Avsz2oZOzgad82HhvhxQxU=;
        b=AwPLpC2Gtvg1uy7f9zlLNFFClxh69qVcuQHl1+gR4CKcW241Jc5fMEhWeYcVqLZ9sv
         vvfXj/+vOEa1Ejz4E0ubVHFXxI5HEkRKvqT2dh/FfvYxAKN2hTxlda1WnKQmLlJ4EEY+
         MVQctzfvHTlg0GY4eDm3IpBdb0hjKEJlMgNDuG6imEgUf5kkdX1eYSIWbTiyO/7O4DPn
         D6MJnrqAJxl/W2DVMYZeG9MeYCVcb3dO160VtmrvajoMLEuTaTrLee9mHvOfOPGH64J6
         xb3eKskTQBcWA3qf2ErREFeeBarnzVryMPqHA+Yl7gZuvZOIifzud4oIsHmc8ectDyMg
         fTCA==
X-Gm-Message-State: AOJu0YwIyErvldXIWwE+5EYL7d/ZscBScm+4dlisaKbXZW+mVY0gHXWt
        MEtqvtAYC8ERgEkNn25+HOfEiQ==
X-Google-Smtp-Source: AGHT+IFYJgF1rRgEO6eqjzycDdrg81lvNGSKjHu/S3GpJAPriFjN41m2MBQL2/9+xRf/V9Lc89i47g==
X-Received: by 2002:a92:db4f:0:b0:34e:2a69:883c with SMTP id w15-20020a92db4f000000b0034e2a69883cmr21564981ilq.1.1697041268015;
        Wed, 11 Oct 2023 09:21:08 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h7-20020a0566380f8700b00430209d0efesm3406997jal.59.2023.10.11.09.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 09:21:07 -0700 (PDT)
Message-ID: <66e09ad5-2dcf-4159-9c98-f37ac739a445@kernel.dk>
Date:   Wed, 11 Oct 2023 10:21:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the block tree with the asm-generic
 tree
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>
References: <20231009123118.4487a0e1@canb.auug.org.au>
 <20231009084812.GB14330@noisy.programming.kicks-ass.net>
 <cb4bb8e2-7dfe-4ca4-aa70-060f7b2f8f95@app.fastmail.com>
 <20231009141351.GD14330@noisy.programming.kicks-ass.net>
 <b7c57f03-4606-4190-98c5-344c49656f9c@kernel.dk>
In-Reply-To: <b7c57f03-4606-4190-98c5-344c49656f9c@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 8:16 AM, Jens Axboe wrote:
> On 10/9/23 8:13 AM, Peter Zijlstra wrote:
>> On Mon, Oct 09, 2023 at 11:00:19AM +0200, Arnd Bergmann wrote:
>>> On Mon, Oct 9, 2023, at 10:48, Peter Zijlstra wrote:
>>>> On Mon, Oct 09, 2023 at 12:31:18PM +1100, Stephen Rothwell wrote:
>>>>> diff --cc arch/alpha/kernel/syscalls/syscall.tbl
>>>>> index 5d05ab716a74,b1865f9bb31e..000000000000
>>>>> --- a/arch/alpha/kernel/syscalls/syscall.tbl
>>>>> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
>>>>> @@@ -492,4 -492,6 +492,7 @@@
>>>>>   560	common	set_mempolicy_home_node		sys_ni_syscall
>>>>>   561	common	cachestat			sys_cachestat
>>>>>   562	common	fchmodat2			sys_fchmodat2
>>>>>  -563	common	futex_wake			sys_futex_wake
>>>>>  -564	common	futex_wait			sys_futex_wait
>>>>>  -565	common	futex_requeue			sys_futex_requeue
>>>>>  +563	common	map_shadow_stack		sys_map_shadow_stack
>>>>> ++564	common	futex_wake			sys_futex_wake
>>>>> ++565	common	futex_wait			sys_futex_wait
>>>>> ++566	common	futex_requeue			sys_futex_requeue
>>>>
>>>> So this renumbers the (futex) stuff on Alpha, does anybody care? AFAICT
>>>> Alpha does not follow the unistd order and meh.
>>>
>>> Let's not make it worse for now. All the numbers since the
>>> introduction of the time64 syscalls are offset by exactly 120
>>> on alpha, and I'd prefer to keep it that way for the moment.
>>>
>>> I still hope to eventually finish the conversion of all architectures
>>> to a single syscall.tbl for numbers >400, and if that happens before
>>> the end of alpha, a different ordering would just be extra pain.
>>
>> Fair enough; should we look at rebase those futex patches for this? (bit
>> of a pain as that would also mean rebasing block)
> 
> From my point of view, this isn't a huge problem if we do it now. The
> io_uring-futex branch is a separate branch and I have nothing on top of
> it, so I could easily just re-pull your updated branch and rebase my
> changes on top.
> 
>> Or do we want to keep this fixup in the merge resolution and make sure
>> Linus is aware?
> 
> If you're OK with it, I'd say let's rebase and save ourselves the
> trouble at merge time.

Peter, what's the verdict - do you want to rebase it, or leave it as-is?

-- 
Jens Axboe

