Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72AC7AD48E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjIYJdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjIYJdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:33:04 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5531ADA;
        Mon, 25 Sep 2023 02:32:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RvHjJ6gBlz4f3pC8;
        Mon, 25 Sep 2023 17:32:52 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBn+djEUxFlNbFlBQ--.26897S3;
        Mon, 25 Sep 2023 17:32:53 +0800 (CST)
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle"
 transition
To:     Donald Buczek <buczek@molgen.mpg.de>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Dragan Stancevic <dragan@stancevic.com>, song@kernel.org
Cc:     guoqing.jiang@linux.dev, it+raid@molgen.mpg.de,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        msmith626@gmail.com, "yangerkun@huawei.com" <yangerkun@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <CAPhsuW6R11y6vETeZ4vmFGmV6DRrj2gwhp1-Nm+csvtHb2nQYg@mail.gmail.com>
 <20230822211627.1389410-1-dragan@stancevic.com>
 <ab757e2b-3ff0-33d9-d30c-61669b738664@huaweicloud.com>
 <2061b123-6332-1456-e7c3-b713752527fb@stancevic.com>
 <07d5c7c2-c444-8747-ed6d-ca24231decd8@huaweicloud.com>
 <cf765117-7270-1b98-7e82-82a1ca1daa2a@stancevic.com>
 <0d79d1f9-00e8-93be-3c7c-244030521cd7@huaweicloud.com>
 <ff996ffb-cba5-cc9b-2740-49ba4a1869b5@huaweicloud.com>
 <07ef7b78-66d4-d3de-4e25-8a889b902e14@stancevic.com>
 <63c63d93-30fc-0175-0033-846b93fe9eff@molgen.mpg.de>
 <de7f6fba-c6e0-7549-199e-36548b68a862@stancevic.com>
 <d48c6c4a-9b0e-20bc-7d40-2a88aa37524a@molgen.mpg.de>
 <f79867f5-befb-0d7d-0c01-a42caa5d1466@molgen.mpg.de>
 <fb261b77-4859-07bb-e586-8589741e0c9e@molgen.mpg.de>
 <80e0f8aa-6d53-3109-37c0-b07c5a4b558c@huaweicloud.com>
 <aef8af9e-a9bb-20ac-12b4-3e57e6062bd8@molgen.mpg.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <326fefc1-93a1-8dd8-e9ca-36d87d3c1c23@huaweicloud.com>
Date:   Mon, 25 Sep 2023 17:32:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <aef8af9e-a9bb-20ac-12b4-3e57e6062bd8@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn+djEUxFlNbFlBQ--.26897S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWxurW7Gw13ArWrGF4fGrg_yoW3Jr4fpr
        ySqF15Kr4kArW8Zw4jkwn7X340qa1kXw15Wr93Jr13Kan09ryFvrW3ZayY9a4UAw4rWFy7
        XFW5GasxZrWDJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUq38nUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/09/25 17:11, Donald Buczek 写道:
> On 9/25/23 03:11, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/09/24 22:35, Donald Buczek 写道:
>>> On 9/17/23 10:55, Donald Buczek wrote:
>>>> On 9/14/23 08:03, Donald Buczek wrote:
>>>>> On 9/13/23 16:16, Dragan Stancevic wrote:
>>>>>> Hi Donald-
>>>>>> [...]
>>>>>> Here is a list of changes for 6.1:
>>>>>>
>>>>>> e5e9b9cb71a0 md: factor out a helper to wake up md_thread directly
>>>>>> f71209b1f21c md: enhance checking in md_check_recovery()
>>>>>> 753260ed0b46 md: wake up 'resync_wait' at last in 
>>>>>> md_reap_sync_thread()
>>>>>> 130443d60b1b md: refactor idle/frozen_sync_thread() to fix deadlock
>>>>>> 6f56f0c4f124 md: add a mutex to synchronize idle and frozen in 
>>>>>> action_store()
>>>>>> 64e5e09afc14 md: refactor action_store() for 'idle' and 'frozen'
>>>>>> a865b96c513b Revert "md: unlock mddev before reap sync_thread in 
>>>>>> action_store"
>>>>>
>>>>> Thanks!
>>>>>
>>>>> I've put these patches on v6.1.52. I've started a script which 
>>>>> transitions the three md-devices of a very active backup server 
>>>>> through idle->check->idle every 6 minutes a few ours ago.  It went 
>>>>> through ~400 iterations till now. No lock-ups so far.
>>>>
>>>> Oh dear, looks like the deadlock problem is _not_fixed with these 
>>>> patches.
>>>
>>> Some more info after another incident:
>>>
>>> - We've hit the deadlock with 5.15.131 (so it is NOT introduced by 
>>> any of the above patches)
>>> - The symptoms are not exactly the same as with the original year-old 
>>> problem. Differences:
>>> - - mdX_raid6 is NOT busy looping
>>> - - /sys/devices/virtual/block/mdX/md/array_state says "active" not 
>>> "write pending"
>>> - - `echo active > /sys/devices/virtual/block/mdX/md/array_state` 
>>> does not resolve the deadlock
>>> - - After hours in the deadlock state the system resumed operation 
>>> when a script of mine read(!) lots of sysfs files.
>>> - But in both cases, `echo idle > 
>>> /sys/devices/virtual/block/mdX/md/sync_action` hangs as does all I/O 
>>> operation on the raid.
>>>
>>> The fact that we didn't hit the problem for many month on 5.15.94 
>>> might hint that it was introduced between 5.15.94 and 5.15.131
>>>
>>> We'll try to reproduce the problem on a test machine for analysis, 
>>> but this make take time (vacation imminent for one...).
>>>
>>> But its not like these patches caused the problem. Any maybe they 
>>> _did_ fix the original problem, as we didn't hit that one.
>>
>> Sorry for the late reply, yes, this looks like a different problem. I'm
>> pretty confident that the orignal problem is fixed since that echo
>> idle/frozen doesn't hold the lock 'reconfig_mutex' to wait for
>> sync_thread to be done.
>>
>> I'll check patches between 5.15.94 and 5.15.131.
> 
> We've got another event today. Some more information to save you work. 
> I'm sorry, this comes dripping in, but as I said, currently we can't 
> reproduce it and hit it on production machines only, where we have 
> limited time to analyze:

There is a way to clarify if io is stuck in underlying disks:

Once the problem is triggered and there are no disk activity:

cat /sys/kernel/debug/block/[disk]/hctx*/sched_tags | grep busy
cat /sys/kernel/debug/block/[disk]/hctx*/tags | grep busy

If busy is not 0, means that io is stuck in underlying disk, then this
problem is not related to raid, otherwise raid doesn't issue any io to
underlyiung dikss and this problem is related to raid.

> 
> * In the last two events, "echo idle > 
> sys/devices/virtual/block/mdX/md/sync_action" was not even executing. 
> This is not a trigger, but was a random victim when it happened the 
> first time. This deceived me to believe this is some variation of the 
> old problem.
> 
> * It's not filesystem related, yesterday `blkid -o value -s LABEL 
> /dev/md1` was hanging, too, and today, for example, `df`.
> 
> * /sys/devices/virtual/block/md0/inflight today was (frozen at) "2      
> 579"
> 
> * iotop showed no disk activity (on the raid) at all. Only a single 
> member device had activity from time to time (usually after ~30 seconds, 
> but sometimes after a few seconds) with usually 1-4 tps, but sometimes 
> more, max 136 tps.
> 
> * As I said, I use a script to take a snapshot of various /sys and /proc 
> information and running this script resolved the deadlock twice.
> 
> * The recorded stack traces of mdX_raid6 of the hanging raid recorded in 
> the two events were
> 
>      [<0>] md_bitmap_unplug.part.0+0xce/0x100
>      [<0>] raid5d+0xe4/0x5a0
>      [<0>] md_thread+0xab/0x160
>      [<0>] kthread+0x127/0x150
>      [<0>] ret_from_fork+0x22/0x30
> 
> and
> 
>      [<0>] md_super_wait+0x72/0xa0
>      [<0>] md_bitmap_unplug.part.0+0xce/0x100
>      [<0>] raid5d+0xe4/0x5a0
>      [<0>] md_thread+0xab/0x160
>      [<0>] kthread+0x127/0x150
>      [<0>] ret_from_fork+0x22/0x30

Above stack shows that raid issue bitmap io to underlying disk and is
waiting for such io to be done, except for bitmap io is broken in raid,
this problem should not related to raid, above debugfs can help to
clarify this.

Thanks,
Kuai

> 
> But note, that these probably were taken after the previous commands in 
> the script already unfroze the system. Today I've manually looked at the 
> stack while the system was still frozen, and it was just
> 
>      [<0>] md_thread+0x122/0x160
>      [<0>] kthread+0x127/0x150
>      [<0>] ret_from_fork+0x22/0x30
> 
> * Because I knew that my script seems to unblock the system, I've run it 
> slowly line by line to see what actually unfreezes the system. There is 
> one loop which takes "comm" "cmdline" and "stack" of all threads:
> 
>      for task in /proc/*/task/*; do
>          echo  "# # $task: $(cat $task/comm) : $(cat $task/cmdline | 
> xargs -0 echo)"
>          cmd cat $task/stack
>      done
> 
> I've added a few "read" to single-step it. Unfortunately, when it came 
> to the 64 nfsd threads, I've got a bit impatient and hit "return" faster 
> then I should have and when the unfreeze happened, I couldn't say 
> exactly were it was triggered. But it must have been somewhere in this 
> tail:
> 
> # # /proc/1299/task/1299: nfsd
> 
> [<0>] svc_recv+0x7a7/0x8c0 [sunrpc]
> [<0>] nfsd+0xd6/0x140 [nfsd]
> [<0>] kthread+0x127/0x150
> [<0>] ret_from_fork+0x22/0x30
> 
> # # /proc/13/task/13: ksoftirqd/0
> 
> [<0>] smpboot_thread_fn+0xf3/0x140
> [<0>] kthread+0x127/0x150
> [<0>] ret_from_fork+0x22/0x30
> 
> # # /proc/130/task/130: cpuhp/22
> 
> [<0>] smpboot_thread_fn+0xf3/0x140
> [<0>] kthread+0x127/0x150
> [<0>] ret_from_fork+0x22/0x30
> 
> # # /proc/1300/task/1300: nfsd
> 
> [<0>] svc_recv+0x7a7/0x8c0 [sunrpc]
> [<0>] nfsd+0xd6/0x140 [nfsd]
> [<0>] kthread+0x127/0x150
> [<0>] ret_from_fork+0x22/0x30
> 
> ## (3 more repetitions of other nfsd threads which exactly the same 
> stack skipped here ##
> 
> So it appears, that possibly a cat /proc/PID/stack of a "ksoftirqd" or a 
> (maybe) a "cpuhp" thread unblocks the system. "nfsd" seems unlikely, as 
> there shouldn't and wasn't anything nfs-mounted from this system.
> 
> Conclusion: This is probably not related to mdraid at all and might be a 
> problem of the block or some infrastructure subsystem. Do you agree?
> 
> Best
> 
>    Donald

