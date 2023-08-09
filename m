Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251DB77537D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjHIHFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjHIHFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:05:14 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865211FC3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:05:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RLLfV44n4z4f3s5q
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:05:06 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgD3hqmjOtNk7C8lAQ--.11494S3;
        Wed, 09 Aug 2023 15:05:09 +0800 (CST)
Subject: Re: [PATCH 2/2] hexdump: add a new dump prefix
 DUMP_PREFIX_ADDRESS_LOW16
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
References: <20230805072116.1260-1-thunder.leizhen@huaweicloud.com>
 <20230805072116.1260-3-thunder.leizhen@huaweicloud.com>
 <20230807211409.750c17a5@gandalf.local.home>
 <73d10b7f-3cba-6897-0ff8-7759ef39a908@huaweicloud.com>
 <319df959-5be9-66c5-680f-4a5ae59019b9@huaweicloud.com>
 <20230809041057.GB681074@google.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <f15515fa-f89d-7e9b-6d4f-cf6c49b43687@huaweicloud.com>
Date:   Wed, 9 Aug 2023 15:05:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230809041057.GB681074@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgD3hqmjOtNk7C8lAQ--.11494S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWfZrWrtFy5uF4kXFyftFb_yoW8XF4rpr
        y3Kw1UKF4kX3WDKFsFqFyUGw15Cr48Ca45Gr95Cry8Ars8Xr9Fkr18Gr13Gr1UAryvvF13
        tr9Iy345KF1UWw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/9 12:10, Sergey Senozhatsky wrote:
> On (23/08/08 15:52), Leizhen (ThunderTown) wrote:
>>>> I find the "before" much easier to read than the "after".
>>
>> I added the boot option no_hash_pointers, so "before" can print the
>> address. Otherwise, just print the 32-bit hash value, as shown below:
> 
> 
>> [   14.872153] dump memory at sp=ffff800080903aa0:
> 
> This line is not guaranteed to be printed. If you get
> "** N printk messages dropped **" instead then the
> ADDRESS_LOW16 math doesn't work.

Anyone is vulnerable in the face of nature. Even DUMP_PREFIX_ADDRESS,
without the preface, no one know what's dumped. In any case,
DUMP_PREFIX_ADDRESS_LOW16 has its own unique value in this ecosystem.
The only regret is that it has a slightly longer name than others.
Maybe it could be DUMP_PREFIX_ADDRLOW or something.

By the way, would you consider changing %p to %px in case DUMP_PREFIX_ADDRESS?

> 
>> Actually, I added DUMP_PREFIX_ADDRESS_LOW16 because of another scene:
>> slab kmalloc-512 start ffff3b3c0094e800 pointer offset 168 size 512
>> e888: 00400000 00000000 000f7704 00000000
>> e898: 000f7704 00000000 12345678 00000000
>> e8a8: 00000000 00000000 00000000 00000000
>> e8b8: 9abcdef0 00000000 00507dd0 00000000
>>
>> Here, the start address ffff3b3c0094e800 of slab object is printed by %px,
>> the address of the error data is at p=ffff3b3c0094e8a8 = ffff3b3c0094e800 + offset 168.
>> To locate the problem, dump up to 64 bytes centered on 'p'.
> .
> 

-- 
Regards,
  Zhen Lei

