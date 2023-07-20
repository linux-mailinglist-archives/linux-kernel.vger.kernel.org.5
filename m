Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0034C75B4BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGTQmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGTQmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:42:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0CF1995
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:41:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-66c729f5618so873971b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689871304; x=1690476104;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cVHbUjXF0YLHeF4YMD6YjzSs+Wnxz3r6yxn2Rof2/Z4=;
        b=iXUm1PtANb3Uk5V2tu5fMiMS2EwwWz9zvnLxTN5AShlBlM1wugceG+++bTtVfqrOHK
         8U6R7Zc2e2TN4rDCJFCoGBBnRsPT72AjPAmFW4rezLe5vAA2mLe4M7GP5MDhbmVArlUy
         /wwAsBeK+3rWbLsNaBqU444k96tHgI9KgHFlNagp4hLelAJPKrV7mkf5Ee3uyTTfh/7c
         HQmioRMLCDa32Pm6pP+k0WYmfmuK9T7F9Y7VdNNCUBqp1Ele4PF4JeSL9K6VNZRmsIs3
         tgMdVh+oMsgcb69zUQFXfUGVEOY4tAloB5kIkZZs4cdy2VSC9lFvjoD5zXZj88Ae2XKx
         B8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689871304; x=1690476104;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVHbUjXF0YLHeF4YMD6YjzSs+Wnxz3r6yxn2Rof2/Z4=;
        b=LmmYQ/tLIPrdBPc0QBrJrPWLLFA6wVcKulnAvpQ5ROjgayp6qMGlaydbyURXXiH/As
         5n+u3SFpWwv6sZYFAdVgRPHEnYLDYue8aKTH5YRfa5sKVyqgnGMQ8NBr6+j8pDHqpD2U
         3yn8pQE8aPvaqLA27aMBxu66SyAvVsrcXF/d5fUjblGiyYf1ERoEjUBNZE8l32FYLw15
         hZT7bbGm2T4LMPmR9hx90gAkKLxhALOs0DUNDJVXd9a0dYrHSp6PatPtmb2mZ2RzqEqx
         W/c9i5k0vHUyDmDPEpr9QhLiHC8zju1YmSQcEjHxtCNMmLVUwgpLFaOdSL6Bcxpf8icG
         OL8w==
X-Gm-Message-State: ABy/qLYucFgZtSAyU02nvWVxALQ0j8zRdWtjLiqzVE8cUSzSZFgLgrx6
        0GmMh2zsFUYAI50fuFjBmVk=
X-Google-Smtp-Source: APBJJlEvHT4c1sNZE1w7sNXsHH3WvSu5hNXSBfXu176nMcmhGWujpb6gLVVyH3/uizlS7WoixgvhQg==
X-Received: by 2002:a05:6a21:3393:b0:137:3b34:93e5 with SMTP id yy19-20020a056a21339300b001373b3493e5mr7040264pzb.59.1689871303794;
        Thu, 20 Jul 2023 09:41:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x8-20020aa793a8000000b0065dd1e7c2c1sm1426599pff.63.2023.07.20.09.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 09:41:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9595effb-e01c-6c5c-362e-b8e8ad364fd7@roeck-us.net>
Date:   Thu, 20 Jul 2023 09:41:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <ee59d128-413c-48ad-a3aa-d9d350c80042@roeck-us.net>
 <336fc14e-f734-49ea-97ce-802f03fa4422@kadam.mountain>
 <198c4edf-045c-8d85-1d5c-018378eeb490@roeck-us.net>
 <055f2564-551d-4b5f-a6e3-d54ae104d5c9@sirena.org.uk>
 <d29552c2-f20c-cf68-76ae-e03a2cc7e0ba@roeck-us.net>
 <12e6144c-0d24-4556-beef-d754273992e4@sirena.org.uk>
 <e3799cbf-daf2-c805-4c70-09679c4b6cf5@roeck-us.net>
Subject: Re: Traceback with CONFIG_REGMAP_KUNIT=y+CONFIG_DEBUG_ATOMIC_SLEEP=y
In-Reply-To: <e3799cbf-daf2-c805-4c70-09679c4b6cf5@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 09:25, Guenter Roeck wrote:
> On 7/20/23 08:07, Mark Brown wrote:
>> On Thu, Jul 20, 2023 at 08:03:13AM -0700, Guenter Roeck wrote:
>>> On 7/20/23 07:31, Mark Brown wrote:
>>
>>>> They're both independently fine, but I wouldn't expect anything that's
>>>> running in atomic context to be actually using dynamic allocations.
>>
>>> Which one do you prefer ? As I mentioned in my second patch, there are
>>> two drivers which use fast_io together with REGCACHE_RBTREE and thus
>>> are likely affected by this problem. Dan's solution would cover that,
>>> while my current RFC patch would likely cause those drivers to fail.
>>> Plus, of course, they could get stuck if they actually end up trying to
>>> sleep while allocating memory.
>>
>> Like I say I don't think it's an either/or - we can do both
>> independently, they both make sense standalone and don't conflict with
>> each other.
> 
> I guess I am missing something. I have not tried it, but wouldn't my patches
> be unnecessary if Dan's patch is applied ?
> 

Actually, Dan's patch isn't complete. With it applied:

[    4.816104]     # Subtest: regmap
[    4.816175]     1..22
[    4.816266]         KTAP version 1
[    4.816343]         # Subtest: basic_read_write
[    4.821773]         ok 1 none
[    4.827032]         ok 2 flat
[    4.832404]         ok 3 rbtree
[    4.834664] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[    4.834935] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 167, name: kunit_try_catch
[    4.835059] preempt_count: 1, expected: 0
[    4.835198] 1 lock held by kunit_try_catch/167:
[    4.835297]  #0: 838e9c10 (regmap_kunit:86:(config)->lock){....}-{2:2}, at: regmap_lock_spinlock+0x14/0x1c
[    4.835980] irq event stamp: 146
[    4.836057] hardirqs last  enabled at (145): [<8078bfa8>] crng_make_state+0x1a0/0x294
[    4.836176] hardirqs last disabled at (146): [<80c5f62c>] _raw_spin_lock_irqsave+0x7c/0x80
[    4.836297] softirqs last  enabled at (0): [<80110cc4>] copy_process+0x810/0x216c
[    4.836413] softirqs last disabled at (0): [<00000000>] 0x0
[    4.836628] CPU: 0 PID: 167 Comm: kunit_try_catch Tainted: G                 N 6.5.0-rc1-00028-gc4be22597a36-dirty #6
[    4.836809] Hardware name: Generic DT based system
[    4.837002]  unwind_backtrace from show_stack+0x18/0x1c
[    4.837134]  show_stack from dump_stack_lvl+0x38/0x5c
[    4.837229]  dump_stack_lvl from __might_resched+0x188/0x2d0
[    4.837325]  __might_resched from __kmem_cache_alloc_node+0x1f4/0x258
[    4.837426]  __kmem_cache_alloc_node from __kmalloc+0x48/0x170
[    4.837521]  __kmalloc from regcache_maple_write+0x194/0x248
[    4.837617]  regcache_maple_write from _regmap_write+0x88/0x140
[    4.837711]  _regmap_write from regmap_write+0x44/0x68
[    4.837797]  regmap_write from basic_read_write+0x8c/0x27c
[    4.837889]  basic_read_write from kunit_generic_run_threadfn_adapter+0x1c/0x28
[    4.837996]  kunit_generic_run_threadfn_adapter from kthread+0xf8/0x120
[    4.838099]  kthread from ret_from_fork+0x14/0x3c
[    4.838214] Exception stack(0x881a5fb0 to 0x881a5ff8)
[    4.838346] 5fa0:                                     00000000 00000000 00000000 00000000
[    4.838465] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.838576] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    4.841868]         ok 4 maple
[    4.841923]     # basic_read_write: pass:4 fail:0 skip:0 total:4
[    4.842022]     ok 1 basic_read_write

It would have to be extended to also address the same problem in the maple tree
code. Also, the change would probably not be needed in regcache_rbtree_init().

After adding the GFP_KERNEL -> map->alloc_flags changes to the maple tree
code while skipping the init functions, I no longer see the traceback.
This is without my patches.

Thanks,
Guenter

