Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3408578E4DD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 04:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245133AbjHaC5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 22:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245430AbjHaC5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 22:57:47 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7583ECE6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 19:57:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rbm6r2kGrz4f3p10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:57:40 +0800 (CST)
Received: from [10.174.177.236] (unknown [10.174.177.236])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6mjAfBkDnn5Bw--.31629S3;
        Thu, 31 Aug 2023 10:57:41 +0800 (CST)
Subject: Re: [PATCH RESEND] tools/mm: fix undefined reference to pthread_once
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, irogers@google.com, acme@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
References: <20230828122157.1541087-1-xiexiuqi@huaweicloud.com>
 <ZOyZ9FgRUOGPh3qm@casper.infradead.org>
 <e4027374-88a9-9484-1619-8c3f887a58ca@huaweicloud.com>
 <ZO/6JcbLV7+Eb0Vz@casper.infradead.org>
From:   Xie XiuQi <xiexiuqi@huaweicloud.com>
Message-ID: <f07bfca6-7b9a-8a9b-91c6-b6d7e6b161a5@huaweicloud.com>
Date:   Thu, 31 Aug 2023 10:57:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ZO/6JcbLV7+Eb0Vz@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgA3x6mjAfBkDnn5Bw--.31629S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF13Zr1rJrWkGw1kCFWDXFb_yoW8Jw43p3
        95Ga4kAF4kJrWrtr1Sq3WrXFWUKr12gr1UXr1kGr1UCa4qqr45Kryxtr429FyxWr1xG3WU
        ZrW7GFy2qF4DJwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: x0lh5xhxtlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/8/31 10:25, Matthew Wilcox wrote:
> On Thu, Aug 31, 2023 at 09:13:24AM +0800, Xie XiuQi wrote:
>> Hi,
>>
>> On 2023/8/28 20:58, Matthew Wilcox wrote:
>>> On Mon, Aug 28, 2023 at 08:21:57PM +0800, Xie XiuQi wrote:
>>>> diff --git a/tools/mm/Makefile b/tools/mm/Makefile
>>>> index 6c1da51f4177..9997b2e401ae 100644
>>>> --- a/tools/mm/Makefile
>>>> +++ b/tools/mm/Makefile
>>>> @@ -9,7 +9,7 @@ LIB_DIR = ../lib/api
>>>>  LIBS = $(LIB_DIR)/libapi.a
>>>>  
>>>>  CFLAGS += -Wall -Wextra -I../lib/
>>>> -LDFLAGS += $(LIBS)
>>>> +LDFLAGS += $(LIBS) -lpthread
>>>
>>> Is this the right fix?  I'm pretty sure you're suppose to use -pthread
>>> in CFLAGS in case there are other things the compiler/linker/whatever
>>> need.
>>>
>>
>> Thanks for your comment. I'll fix it and send v2.
> 
> You added it to LDFLAGS, not CFLAGS.

Sorry, it's my fault. I'll add it to CFALGS:

  CFLAGS += -Wall -Wextra -I../lib/ -pthread

> 
>>> '-pthread'
>>>      Define additional macros required for using the POSIX threads
>>>      library.  You should use this option consistently for both
>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>      compilation and linking.  This option is supported on GNU/Linux
>          ^^^^^^^^^^^^^^^^^^^^^^^
>>>      targets, most other Unix derivatives, and also on x86 Cygwin and
>>>      MinGW targets.
>>>
>>
>>

