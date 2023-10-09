Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35827BE250
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345420AbjJIOQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjJIOQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:16:31 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEA88E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:16:29 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79fb8f60374so42293939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696860989; x=1697465789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3CL2Vsvye/9pVnH25rVvTF1B/6x3fN55VPakRDUa0k=;
        b=eUFxlNZUxg+8/yBT6Cb/KwsdtN6e8NMRXMlghRkthSmq9s6+DWp/aLvkoCrZD8+Kc9
         00OH9a5xQ38cT/H10+/XezhXYW/jgIBBsu81BieIN8TK1RSvbP+eqWLlXrdBHyFRXdzn
         6Jd1tIsGsIbQXmW9kxWUa/PgmUUZarxkC2DfR8kw2DKcBr3FxMRPcDbhnT3lxVCplod7
         crKg0G8dBpyBu/PS/sjUiYNpKhHGEQL5MdSm5GSZl/G4KlfpmlGwnQ/+afrPxI1FTzyX
         L+5auTY1Yam7J/uNwUFIgxYU3FKKCzGfgkwvMfNK5vjt3oOJqrDHsC6n/Ge2N2bXjJEu
         qz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696860989; x=1697465789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3CL2Vsvye/9pVnH25rVvTF1B/6x3fN55VPakRDUa0k=;
        b=FTPmMDyu39RgYdLDvjy6KJJ7Wo9pV2eExNIbyfz9CU3QgR3V+0/PK5QP4E2/mmDZ6O
         WkvtD3dVQQmxLqQhTRkZgP1YQESaoRn5HyL/+AZ0XAqJLX6B95XNUNEOTtI6nN/nAAb/
         ftES/e3cnnvZMkyJ+Ml+FLd/ZtuCENNueManrN2eNLIxBAlLmpJAXbd7HFNhjz2Pi2Bf
         eET8kotuwGJs60jgHyozxmh0TEm4L21rpGNfJkyzw9a6yNSDw1ju+lXrVKVAhsjmcjEW
         IacuK5JcGi1re/J3BSjH9ypCw6LY1OQAYJQYnpu8no7NDS7ZIO7+7f5sKKI08CEf5XTW
         Cubg==
X-Gm-Message-State: AOJu0Ywo8xMtjtLpy+gMqIar8ZFvBLxfP6Nha02cE1oGdoYepnSxKiYf
        9Tr7SbelwURFhbmk4/eiuUe6nA==
X-Google-Smtp-Source: AGHT+IGyQihtEKFDfuV5sMByUJ7RrB6sEgUY6ckgJswVb7s+JxoCLyjgWCrLDzgV2SbTSQNAgVbm1Q==
X-Received: by 2002:a05:6602:3a05:b0:792:6be4:3dcb with SMTP id by5-20020a0566023a0500b007926be43dcbmr15858067iob.2.1696860987627;
        Mon, 09 Oct 2023 07:16:27 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c16-20020a02a410000000b0042b3042ccd8sm2107645jal.13.2023.10.09.07.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 07:16:26 -0700 (PDT)
Message-ID: <b7c57f03-4606-4190-98c5-344c49656f9c@kernel.dk>
Date:   Mon, 9 Oct 2023 08:16:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the block tree with the asm-generic
 tree
Content-Language: en-US
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
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231009141351.GD14330@noisy.programming.kicks-ass.net>
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

On 10/9/23 8:13 AM, Peter Zijlstra wrote:
> On Mon, Oct 09, 2023 at 11:00:19AM +0200, Arnd Bergmann wrote:
>> On Mon, Oct 9, 2023, at 10:48, Peter Zijlstra wrote:
>>> On Mon, Oct 09, 2023 at 12:31:18PM +1100, Stephen Rothwell wrote:
>>>> diff --cc arch/alpha/kernel/syscalls/syscall.tbl
>>>> index 5d05ab716a74,b1865f9bb31e..000000000000
>>>> --- a/arch/alpha/kernel/syscalls/syscall.tbl
>>>> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
>>>> @@@ -492,4 -492,6 +492,7 @@@
>>>>   560	common	set_mempolicy_home_node		sys_ni_syscall
>>>>   561	common	cachestat			sys_cachestat
>>>>   562	common	fchmodat2			sys_fchmodat2
>>>>  -563	common	futex_wake			sys_futex_wake
>>>>  -564	common	futex_wait			sys_futex_wait
>>>>  -565	common	futex_requeue			sys_futex_requeue
>>>>  +563	common	map_shadow_stack		sys_map_shadow_stack
>>>> ++564	common	futex_wake			sys_futex_wake
>>>> ++565	common	futex_wait			sys_futex_wait
>>>> ++566	common	futex_requeue			sys_futex_requeue
>>>
>>> So this renumbers the (futex) stuff on Alpha, does anybody care? AFAICT
>>> Alpha does not follow the unistd order and meh.
>>
>> Let's not make it worse for now. All the numbers since the
>> introduction of the time64 syscalls are offset by exactly 120
>> on alpha, and I'd prefer to keep it that way for the moment.
>>
>> I still hope to eventually finish the conversion of all architectures
>> to a single syscall.tbl for numbers >400, and if that happens before
>> the end of alpha, a different ordering would just be extra pain.
> 
> Fair enough; should we look at rebase those futex patches for this? (bit
> of a pain as that would also mean rebasing block)

From my point of view, this isn't a huge problem if we do it now. The
io_uring-futex branch is a separate branch and I have nothing on top of
it, so I could easily just re-pull your updated branch and rebase my
changes on top.

> Or do we want to keep this fixup in the merge resolution and make sure
> Linus is aware?

If you're OK with it, I'd say let's rebase and save ourselves the
trouble at merge time.

-- 
Jens Axboe

