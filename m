Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EE67F6F37
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjKXJMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjKXJMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:12:32 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C477FD6C;
        Fri, 24 Nov 2023 01:12:35 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sc8Q42hZLz4f3m6s;
        Fri, 24 Nov 2023 17:12:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id AD7EF1A0498;
        Fri, 24 Nov 2023 17:12:32 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgDX2xH_aGBl5AQvBw--.26609S3;
        Fri, 24 Nov 2023 17:12:32 +0800 (CST)
Subject: Re: [PATCH -next v2 1/6] md: remove useless debug code to print
 configuration
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20231021102059.3198284-1-yukuai1@huaweicloud.com>
 <20231021102059.3198284-2-yukuai1@huaweicloud.com>
 <CAPhsuW5=fDpsAofik+4jHObFkRMcTTeQPbtXSBG_KAes0YgQGA@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1f3080ca-cde6-2473-4679-a79fa744eb70@huaweicloud.com>
Date:   Fri, 24 Nov 2023 17:12:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5=fDpsAofik+4jHObFkRMcTTeQPbtXSBG_KAes0YgQGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2xH_aGBl5AQvBw--.26609S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWrXFyDAw43XrWxAFy3XFb_yoW8Xw4fp3
        y3Ka4ayr4kCr4Fy3yDJw4fCFyfua98Jr45Kr9agryUZwn8CryI9r13Gryj9Fy5ur4vqrs0
        9395XF4fWa48AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/11/24 16:17, Song Liu 写道:
> On Fri, Oct 20, 2023 at 7:25 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> One the one hand, print_conf() can be called without grabbing
>> 'reconfig_mtuex' and current rcu protection to access rdev through 'conf'
>> is not safe. Fortunately, there is a separate rcu protection to access
>> rdev from 'mddev->disks', and rdev is always removed from 'conf' before
>> 'mddev->disks'.
>>
>> On the other hand, print_conf() is just used for debug,
>> and user can always grab such information(/proc/mdstat and mdadm).
>>
>> There is no need to always enable this debug and try to fix misuse rcu
>> protection for accessing rdev from 'conf', hence remove print_conf().
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> I wouldn't call these debug functions useless. There is probably some
> users who use them for debugging (or even in some automations).
> How hard is it to keep these functions? Can we just add some lockdep
> to these functions to make sure they are called from safe places?

Okay, I can keep these debug code, and since these code are
dereferencing rdev from conf, and they need new syncronization:

1) dereference rdev from mddev->disks instead of conf, and use
rdev->raid_disk >= 0 to judge if this rdev is in conf. There might
be a race window that rdev can be removed from conf, however, I think
this dones't matter. Or:

2) grab 'active_io' before print_conf(), to make sure rdev won't be
removed from conf.

Thanks,
Kuai

> 
> Thanks,
> Song
> 
> [...]
> .
> 

