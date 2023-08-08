Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA14677360B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjHHBwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHHBwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:52:04 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C8510F5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:52:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RKblg2mj6z4f3l23
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:51:59 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6m+n9FkRljFAA--.2319S3;
        Tue, 08 Aug 2023 09:52:00 +0800 (CST)
Subject: Re: [PATCH 2/2] hexdump: add a new dump prefix
 DUMP_PREFIX_ADDRESS_LOW16
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
References: <20230805072116.1260-1-thunder.leizhen@huaweicloud.com>
 <20230805072116.1260-3-thunder.leizhen@huaweicloud.com>
 <20230807211409.750c17a5@gandalf.local.home>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <73d10b7f-3cba-6897-0ff8-7759ef39a908@huaweicloud.com>
Date:   Tue, 8 Aug 2023 09:51:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230807211409.750c17a5@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgAHl6m+n9FkRljFAA--.2319S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrykKr43trWftr13Jr4Utwb_yoW8Xr18pa
        4Yqry5GF48KF4xJr1UJrWUCr1UtrZ8Ca48AFsrKw1Fka4fWFnrXw48JFW3Ga45Wr15XFnx
        Jr1UJ34Utr1qkw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/8 9:14, Steven Rostedt wrote:
> On Sat,  5 Aug 2023 15:21:16 +0800
> thunder.leizhen@huaweicloud.com wrote:
> 
>> For example:
>> dump memory at sp=ffff800080883a90:
>> ffff800080883a90: 80883ac0 ffff8000 3d8e936c ffffbd5b
>> ffff800080883aa0: 5833f000 ffff3580 00000001 00000000
>> ffff800080883ab0: 40299840 ffff3580 590dfa00 ffff3580
>> ffff800080883ac0: 80883b30 ffff8000 3d938b28 ffffbd5b
>> ffff800080883ad0: 40877180 ffff3580 590dfa00 ffff3580
>> ffff800080883ae0: 4090f600 ffff3580 80883cb0 ffff8000
>> ffff800080883af0: 00000010 00000000 00000000 00000000
>> ffff800080883b00: 4090f700 ffff3580 00000001 00000000
>>
>> Generally, we do not dump more than 64 KB memory. It is sufficient to
>> print only the lower 16 bits of the address.
>>
>> dump memory at sp=ffff800080883a90:
>> 3a90: 80883ac0 ffff8000 3d8e936c ffffbd5b
>> 3aa0: 5833f000 ffff3580 00000001 00000000
>> 3ab0: 40299840 ffff3580 590dfa00 ffff3580
>> 3ac0: 80883b30 ffff8000 3d938b28 ffffbd5b
>> 3ad0: 40877180 ffff3580 590dfa00 ffff3580
>> 3ae0: 4090f600 ffff3580 80883cb0 ffff8000
>> 3af0: 00000010 00000000 00000000 00000000
>> 3b00: 4090f700 ffff3580 00000001 00000000
> 
> I find the "before" much easier to read than the "after".

That's because you're experienced and know how to look around colons
for offsets. But I can remove "and unintuitive" from the commit message.

> 
> 
> -- Steve
> 
> .
> 

-- 
Regards,
  Zhen Lei

