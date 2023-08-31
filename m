Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06678E435
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345484AbjHaBNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345477AbjHaBNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:13:53 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B2DE46
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 18:13:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RbjpZ018xz4f3mWP
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:13:25 +0800 (CST)
Received: from [10.174.177.236] (unknown [10.174.177.236])
        by APP4 (Coremail) with SMTP id gCh0CgAXp6k06e9kAX3zBw--.4999S3;
        Thu, 31 Aug 2023 09:13:26 +0800 (CST)
Subject: Re: [PATCH RESEND] tools/mm: fix undefined reference to pthread_once
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, irogers@google.com, acme@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
References: <20230828122157.1541087-1-xiexiuqi@huaweicloud.com>
 <ZOyZ9FgRUOGPh3qm@casper.infradead.org>
From:   Xie XiuQi <xiexiuqi@huaweicloud.com>
Message-ID: <e4027374-88a9-9484-1619-8c3f887a58ca@huaweicloud.com>
Date:   Thu, 31 Aug 2023 09:13:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ZOyZ9FgRUOGPh3qm@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgAXp6k06e9kAX3zBw--.4999S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XF48ur45trW8XF1rtry5Jwb_yoWfZwcE9a
        yIqr47Ww4UurZ7Jrs0krsxKryvkFnY9rn5AF4rJr1Svry5GrykXF4v9FnavF4YqF4v9asx
        KFyrZFn8uw1xKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JrC_JFWl1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
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

On 2023/8/28 20:58, Matthew Wilcox wrote:
> On Mon, Aug 28, 2023 at 08:21:57PM +0800, Xie XiuQi wrote:
>> diff --git a/tools/mm/Makefile b/tools/mm/Makefile
>> index 6c1da51f4177..9997b2e401ae 100644
>> --- a/tools/mm/Makefile
>> +++ b/tools/mm/Makefile
>> @@ -9,7 +9,7 @@ LIB_DIR = ../lib/api
>>  LIBS = $(LIB_DIR)/libapi.a
>>  
>>  CFLAGS += -Wall -Wextra -I../lib/
>> -LDFLAGS += $(LIBS)
>> +LDFLAGS += $(LIBS) -lpthread
> 
> Is this the right fix?  I'm pretty sure you're suppose to use -pthread
> in CFLAGS in case there are other things the compiler/linker/whatever
> need.
> 

Thanks for your comment. I'll fix it and send v2.

> '-pthread'
>      Define additional macros required for using the POSIX threads
>      library.  You should use this option consistently for both
>      compilation and linking.  This option is supported on GNU/Linux
>      targets, most other Unix derivatives, and also on x86 Cygwin and
>      MinGW targets.
> 

