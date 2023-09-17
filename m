Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F037A35C9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 16:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbjIQOLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 10:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbjIQOLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 10:11:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2F611D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 07:11:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3159b524c56so695547f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 07:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694959861; x=1695564661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iIK8KrcUKgh5UQCSYe1MCVGWo9nmkIhTMbVaXMG9OPM=;
        b=xcIY+bcjY3hDXY439dnrIpl5RZIhE04SUYxjuCQFDcKlo85Kcn88Vmo2474/pojIa5
         2vkVsAsVR9uWVSn7Ras+P/8/WoO5ijyMG+h0WAp0v8RSJFU9MkKuNCh/lXIsOwoHTgM1
         oncDnSLO9DG7/Jf7kEHZfueywQJj9u9i1h4mfzXdm43i3nO63TXpKhpPlKYZ3vgkpv5v
         4rsjuCOG/Pj/ravZsdaT/j36z2KADpCJfLJruDZqo1+04Hg1XdrYWniEec4KZZyadpef
         onaX5HwtwgdD4LjJRQLZOzFt6t4iBY2hUWkh7A2QJVQjwimykPLS81rGfkuQrZb0SiFg
         nCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694959861; x=1695564661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIK8KrcUKgh5UQCSYe1MCVGWo9nmkIhTMbVaXMG9OPM=;
        b=vJtK13F9O6SKGyEpxSjCdHwsvZlm/K8bMWNXiQ/RLCimeylYgJv1LCQUKJVqX/CvLl
         mCd/tDBk/G97j3YXir9GXtwh1j2apuu6N4Tq/601D2uPtBV9nXu5LNXKyNVQNFF41fq+
         MSkmCIerBMnZD8aeE7kJZXpyD3WZuWfsQE0lkywNJYMugaMT54MbushVyJLwMNYNqu31
         2aRe5Er5/kGgD5p2pcC+ZouHIAT++sJhm99LOsDiS0ryuPQDf+u5Jn0h1lstejaOKK13
         WXeNwlR/pxt3QtNSlvdI/d5/nlxAPVkepDkCBBmFXQ1qjQb8HNJKH05F87IXpV4hqTrX
         3UvA==
X-Gm-Message-State: AOJu0YyBv4//OWAW0tw4zdQ+R5FUaUkbi/Bcxx7hW/itpQu/E9pRnm6A
        h71tH+Q+Plv5EMYMl6hXE4/7+w==
X-Google-Smtp-Source: AGHT+IF05yt+SS1h19dUi36BjWkETqgsFnNrdJeOH5lnXlR6pxR9iMLfNebUDG8HUbKAh14gGlGzpw==
X-Received: by 2002:adf:f742:0:b0:31a:e29f:5eab with SMTP id z2-20020adff742000000b0031ae29f5eabmr5187153wrp.7.1694959861090;
        Sun, 17 Sep 2023 07:11:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:9f43:3ca4:162c:d540? ([2a01:e0a:999:a3a0:9f43:3ca4:162c:d540])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d4d91000000b0031c855d52efsm9740257wru.87.2023.09.17.07.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 07:11:00 -0700 (PDT)
Message-ID: <6098915f-c5ac-40dc-80af-026891e92d4d@rivosinc.com>
Date:   Sun, 17 Sep 2023 16:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/user_events: align uaddr on unsigned long
 alignment
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Beau Belgrave <beaub@linux.microsoft.com>
References: <20230914131102.179100-1-cleger@rivosinc.com>
 <20230915115449.3d7103b841cd593d1a09a129@kernel.org>
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20230915115449.3d7103b841cd593d1a09a129@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/09/2023 04:54, Masami Hiramatsu (Google) wrote:
> On Thu, 14 Sep 2023 15:11:02 +0200
> Clément Léger <cleger@rivosinc.com> wrote:
> 
>> enabler->uaddr can be aligned on 32 or 64 bits. If aligned on 32 bits,
>> this will result in a misaligned access on 64 bits architectures since
>> set_bit()/clear_bit() are expecting an unsigned long (aligned) pointer.
>> On architecture that do not support misaligned access, this will crash
>> the kernel. Align uaddr on unsigned long size to avoid such behavior.
>> This bug was found while running kselftests on RISC-V.
>>
>> Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  kernel/trace/trace_events_user.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
>> index 6f046650e527..580c0fe4b23e 100644
>> --- a/kernel/trace/trace_events_user.c
>> +++ b/kernel/trace/trace_events_user.c
>> @@ -479,7 +479,7 @@ static int user_event_enabler_write(struct user_event_mm *mm,
>>  				    bool fixup_fault, int *attempt)
>>  {
>>  	unsigned long uaddr = enabler->addr;
>> -	unsigned long *ptr;
>> +	unsigned long *ptr, bit_offset;
>>  	struct page *page;
>>  	void *kaddr;
>>  	int ret;
>> @@ -511,13 +511,19 @@ static int user_event_enabler_write(struct user_event_mm *mm,
>>  	}
>>  
>>  	kaddr = kmap_local_page(page);
>> +
>> +	bit_offset = uaddr & (sizeof(unsigned long) - 1);
>> +	if (bit_offset) {
>> +		bit_offset *= 8;
>> +		uaddr &= ~(sizeof(unsigned long) - 1);
>> +	}
>>  	ptr = kaddr + (uaddr & ~PAGE_MASK);
>>  
>>  	/* Update bit atomically, user tracers must be atomic as well */
>>  	if (enabler->event && enabler->event->status)
>> -		set_bit(ENABLE_BIT(enabler), ptr);
>> +		set_bit(ENABLE_BIT(enabler) + bit_offset, ptr);
>>  	else
>> -		clear_bit(ENABLE_BIT(enabler), ptr);
>> +		clear_bit(ENABLE_BIT(enabler) + bit_offset, ptr);
> 
> What we need are generic set_bit_aligned() and clear_bit_aligned(), which align the ptr
> by unsigned long. (I think it should be done in set_bit/clear_bit, for architecture
> which requires aligned access...)
> 
> #define LONG_ALIGN_DIFF(p)	(p) & (sizeof(long) -1)
> #define LONG_ALINGNED(p)		(p) & ~(sizeof(long) - 1)
> 
> static inline void set_bit_aligned(int bit, unsigned long *ptr)
> {
> 	int offs = LONG_ALIGN_DIFF(ptr) * 8;
> 
> #ifdef __BIGENDIAN
> 	if (bit >= offs) {
> 		set_bit(bit - offs, LONG_ALIGNED(ptr));
> 	} else {
> 		set_bit(bit + BITS_PER_LONG - offs, LONG_ALIGNED(ptr) + 1);
> 	}
> #else
> 	if (bit < BITS_PER_LONG - offs) {
> 		set_bit(bit + offs, LONG_ALIGNED(ptr));
> 	} else {
> 		set_bit(bit - BITS_PER_LONG + offs, LONG_ALIGNED(ptr) + 1);
> 	}
> #endif
> }

Hi Masami,

Indeed, that is a more elegant version, thanks for the snippet.

Clément

> 
> And use it.
> 
> Thank you,
> 
>>  
>>  	kunmap_local(kaddr);
>>  	unpin_user_pages_dirty_lock(&page, 1, true);
>> -- 
>> 2.40.1
>>
> 
> 
