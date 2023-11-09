Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2587E6286
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 04:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjKIDRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 22:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKIDRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 22:17:39 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AA326A0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 19:17:36 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5b8c39a2dceso301734a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 19:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1699499856; x=1700104656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv7JXQbjeZI6ADWBH8E3pe2DxzWo9OrlpOK1MsuTvPk=;
        b=TOybLrPTlkQ4c8SfM1/WpJXLQteENQdE/tWSlH5pBboduC4QngtSlzajxanDH8sxai
         JAHi56R0UgI9u82gHW6enhsQDWfShQDgp1bmHvCI7Cbd3YH6lH5XqyKLqcXlBWhJfPz1
         emblxdeRZ6UtNNQtifhy+szcLMWXgNQiRA4vMN0zXLZKbnum2sBRrfJCX+fIK7VoABfT
         M1GbPyFhoEdAVKGO8T3Q0rT6lKIS/ER/3w9DFyriZe6OtqfwCliSLDHPjpBrRKTVOJtt
         cNWsSJcR0v96tOXwz15yw57eO7ZBcnWX21n5U76E9d6YN7K9mkBC92Ag0/RyheDYRlXJ
         BMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699499856; x=1700104656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nv7JXQbjeZI6ADWBH8E3pe2DxzWo9OrlpOK1MsuTvPk=;
        b=eB7/ozXLSB4aZLsqNunKG8Tv80RGxdasEGnqQFxzM+dH5r9xQVNVBf+xQQS1A0q2TG
         vbyiy0U8r4hQbDrQ9Mu6ug4XHxVoiDTV/vL+trRF9xX4gHsXkF9QwCTaPngGQ/DfF7l2
         lBCIaLbUJ+2hV1z/Lkux4tjA1mR11K32xXI97tjAxjh62nBSZmPhQdSBOSq9LIjFbv4d
         IGtv7Rzb47tNm121WOuZoIu6iLKU7ZRjkWY3ovqmbd86KMrs3PTDO0yrjbTWGbP+dNuk
         QHcuBuLtSgW4Iku43/xGpEWyvPa6MbaSjWwxACUysiEGkOk1JsKU6hTeTFGgGUVCDa19
         idQQ==
X-Gm-Message-State: AOJu0Ywh1N7yK1ptaJbHBY76vsl2goKvO+aUgKamF4JI+RYdpnBRrmj+
        V/y3YyEOYDwuqzX+Gh5Khhs5srJBK0j6wm0Jrdmc0Pim
X-Google-Smtp-Source: AGHT+IEd8kNYNKCLYeCpMZuldqhIJVNyf3S4vNwef3RGDMhsrwXGCiObI+WTRE0ET4roi0L1GZkEUw==
X-Received: by 2002:a05:6a21:a596:b0:159:f71f:4083 with SMTP id gd22-20020a056a21a59600b00159f71f4083mr4579786pzc.6.1699499855904;
        Wed, 08 Nov 2023 19:17:35 -0800 (PST)
Received: from [10.54.24.52] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b001b89466a5f4sm2394076plf.105.2023.11.08.19.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 19:17:35 -0800 (PST)
Message-ID: <5086cd5b-a832-4250-9927-4b300d2f611e@shopee.com>
Date:   Thu, 9 Nov 2023 11:17:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/rwsem: Remove unnessary check in
 rwsem_down_read_slowpath()
To:     Waiman Long <longman@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org
References: <20231108105639.70088-1-haifeng.xu@shopee.com>
 <6da49b39-653a-1eda-2d21-1f1b50cb14f0@redhat.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <6da49b39-653a-1eda-2d21-1f1b50cb14f0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/8 22:04, Waiman Long wrote:
> On 11/8/23 05:56, Haifeng Xu wrote:
>> When the owner of rw_semaphore is reader, the count can't be
>> RWSEM_WRITER_LOCKED, so there is no need to check it.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>   kernel/locking/rwsem.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index 2340b6d90ec6..7a4d8a9ebd9c 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -1005,8 +1005,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>>        * waiter, don't attempt optimistic lock stealing if the lock is
>>        * currently owned by readers.
>>        */
>> -    if ((atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) &&
>> -        (rcnt > 1) && !(count & RWSEM_WRITER_LOCKED))
>> +    if ((atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) && (rcnt > 1))
>>           goto queue;
>>         /*
> 
> Unlike RWSEM_WRITER_LOCKED bit in count, the RWSEM_READER_OWNED bit in owner is just a hint, not an authoritative state of the rwsem. So it is possible that both the RWSEM_READER_OWNED bit can be set in owner and RWSEM_WRITER_LOCKED bit set in count in a transition period right after RWSEM_WRITER_LOCKED bit is set. 

reader		writer					reader

acquire		
release		
		rwsem_write_trylock
			set RWSEM_WRITER_LOCKED
							rwsem_down_read_slowpath
			set owner

If prev lock holder is a reader, when it releases the lock, the owner isn't cleared(CONFIG_DEBUG_RWSEMS isn't enabled).
A writer comes and can set the RWSEM_WRITER_LOCKED bit succsessfully, then a new reader run into slow path, before
the writer set the owner, the new reader will see that both the RWSEM_READER_OWNED bit and RWSEM_WRITER_LOCKED bit are
set.

So the above sequence could be the case, right?



So the RWSEM_WRITER_LOCKED check can still provide some value. We should probably update the comment to reflect that.
> 
> Cheers,
> Longman
> 
