Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E756A77E039
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244553AbjHPLZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244540AbjHPLY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:24:58 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C552112;
        Wed, 16 Aug 2023 04:24:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RQm503Hx6z4f3rNy;
        Wed, 16 Aug 2023 19:24:52 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgD3hqkBstxkfflhAw--.56897S3;
        Wed, 16 Aug 2023 19:24:50 +0800 (CST)
Subject: Re: [PATCH v3 2/2] hexdump: add a new dump prefix DUMP_PREFIX_CUSTOM
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
References: <20230811074922.1388-1-thunder.leizhen@huaweicloud.com>
 <20230811074922.1388-3-thunder.leizhen@huaweicloud.com>
 <ZNuMGyJ2x21RpVyR@alley>
 <167a4aee-7a9d-a024-7594-97b84146196c@huaweicloud.com>
 <ZNyRC9wHuLTDZVQV@alley>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <9891fbb1-dc9a-7be4-f505-4dc08d8effbf@huaweicloud.com>
Date:   Wed, 16 Aug 2023 19:24:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZNyRC9wHuLTDZVQV@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3hqkBstxkfflhAw--.56897S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDtr4UKF4DZFWDJF48tFb_yoWrtryUpa
        45K3WUKF4kJw17Aw12qF48Gr10yrZ8Ca48Wr9Yyr18Cw4qgF9rJr17GFW7C345uryFv3ZF
        yr17try2qr1UGw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/16 17:04, Petr Mladek wrote:
> On Wed 2023-08-16 11:20:32, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2023/8/15 22:30, Petr Mladek wrote:
>>> Added Kees and hardening mailing list into Cc.
>>>
>>> On Fri 2023-08-11 15:49:21, thunder.leizhen@huaweicloud.com wrote:
>>>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>>>
>>>> Currently, function print_hex_dump() supports three dump prefixes:
>>>> DUMP_PREFIX_NONE, DUMP_PREFIX_ADDRESS and DUMP_PREFIX_OFFSET. But for some
>>>> usage scenarios, they don't work perfectly. For example, dump the content
>>>> of one task's stack. In order to quickly identify a stack frame,
>>>> DUMP_PREFIX_ADDRESS is preferred. But without boot option no_hash_pointers
>>>> , DUMP_PREFIX_ADDRESS just print the 32-bit hash value.
>>>>
>>>> dump memory at sp=ffff800080903aa0:
>>>> 00000000a00a1d32: 80903ac0 ffff8000 8feeae24 ffffc356
>>>> 000000007993ef27: 9811c000 ffff0d98 8ad2e500 ffff0d98
>>>> 00000000b1a0b2de: 80903b30 ffff8000 8ff3a618 ffffc356
>>>> ... ...
>>>> 00000000a7a9048b: 9810b3c0 ffff0d98 00000000 00000000
>>>> 0000000011cda415: 80903cb0 ffff8000 00000000 00000000
>>>> 000000002dbdf9cd: 981f8400 ffff0d98 00000001 00000000
>>>>
>>>> On the other hand, printing multiple 64-bit addresses is redundant when
>>>> the 'sp' value is already printed. Generally, we do not dump more than
>>>> 64 KiB memory. It is sufficient to print only the lower 16 bits of the
>>>> address.
>>>>
>>>> dump memory at sp=ffff800080883a90:
>>>> 3a90: 80883ac0 ffff8000 3d8e936c ffffbd5b
>>>> 3aa0: 5833f000 ffff3580 00000001 00000000
>>>> 3ab0: 40299840 ffff3580 590dfa00 ffff3580
>>>> 3ac0: 80883b30 ffff8000 3d938b28 ffffbd5b
>>>> 3ad0: 40877180 ffff3580 590dfa00 ffff3580
>>>> 3ae0: 4090f600 ffff3580 80883cb0 ffff8000
>>>> 3af0: 00000010 00000000 00000000 00000000
>>>> 3b00: 4090f700 ffff3580 00000001 00000000
>>>>
>>>> Let's add DUMP_PREFIX_CUSTOM, allows users to make some adjustments to
>>>> their needs.
>>>>
>>>> For example:
>>>> pr_info("dump memory at sp=%px:\n", sp);
>>>> print_hex_dump(KERN_INFO, "%s%16hx: %s\n",
>>>>                DUMP_PREFIX_CUSTOM, 16, 1, sp, 16, false);
>>>> print_hex_dump(KERN_INFO, "%s%16x: %s\n",
>>>>                DUMP_PREFIX_CUSTOM, 16, 1, sp, 16, false);
>>>> print_hex_dump(KERN_INFO, "%s%px: %s\n",
>>>>                DUMP_PREFIX_CUSTOM, 16, 1, sp, 16, false);
>>>
>>> IMHO, this is pretty bad interface.
>>>
>>>   + From the user POV:
>>>
>>>     It is far from clear what values will be passed for the given
>>>     printf format. It can be docummented but...
>>>
>>>
>>>   + From the security POV:
>>>
>>>     The compiler could not check if the printk() parameters
>>>     match the format. I mean if the number of types of
>>>     the parameters are correct.
>>
>> Yes, it has these problems. So, back to v2, how about add DUMP_PREFIX_ADDRESS_LOW16?
>> Or named DUMP_PREFIX_ADDR16 or others. Or change the format of DUMP_PREFIX_ADDRESS
>> from "%p" to "%px"，Or add DUMP_PREFIX_RAWADDR. Or keep the status quo.
> 
> I would personally keep the status quo.
> 
> First, raw address should not be printed unless no_hash_pointers is
> used. Otherwise, it would be a security hole. Yes, printing the last
> 16b is less risky. But it is still part of the puzzle. And for
> debugging, people want/need to set "no_hash_pointers" anyway.
> 
> Second, IMHO, printing only the last 16b of the address is not much
> useful for debugging. It can't be compared easily against other
> addresses.
> 
> Third, 00000000a00a1d32 can be interpreted more easily than 1d32.
> I mean, it is much more obvious that it is an "hashed" address.
> Of course, this is less important for people who analyze hex
> dumps on daily basis.
> 
> That said, the above would be valid when DUMP_PREFIX_ADDRESS_LOW16
> is used in plain kernel sources. I understand that it might be
> useful for temporary added debug messages. I am not sure what
> was the use case which motivated this patch.

https://www.spinics.net/lists/rcu/msg13545.html
Printing the address will save us some time. Of course, if we don't print the address,
we can manually calculate it again according to the calculation method in the code.

> 
>> Also, do you have any comments on patch 1/2?
> 
> I do not have strong opinion.
> 
> The auto adjusting of the width makes it easier to read for humans.
> But it might complicate some post-processing using a script.

The script should split the data based on the colon and then use a function like
strtoul() to convert it. It seems that we do not have to worry too much about
the script.

> 
> Best Regards,
> Petr
> .
> 

-- 
Regards,
  Zhen Lei

