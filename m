Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C3478648D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbjHXBTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239003AbjHXBTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:19:06 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93530DB;
        Wed, 23 Aug 2023 18:19:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RWQGC0NPtz4f3jLG;
        Thu, 24 Aug 2023 09:18:59 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAH5KYCsOZkIO_ABQ--.2269S3;
        Thu, 24 Aug 2023 09:18:59 +0800 (CST)
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle"
 transition
To:     Dragan Stancevic <dragan@stancevic.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     buczek@molgen.mpg.de, guoqing.jiang@linux.dev,
        it+raid@molgen.mpg.de, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, msmith626@gmail.com,
        "yangerkun@huawei.com" <yangerkun@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <CAPhsuW6R11y6vETeZ4vmFGmV6DRrj2gwhp1-Nm+csvtHb2nQYg@mail.gmail.com>
 <20230822211627.1389410-1-dragan@stancevic.com>
 <ab757e2b-3ff0-33d9-d30c-61669b738664@huaweicloud.com>
 <2061b123-6332-1456-e7c3-b713752527fb@stancevic.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <07d5c7c2-c444-8747-ed6d-ca24231decd8@huaweicloud.com>
Date:   Thu, 24 Aug 2023 09:18:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2061b123-6332-1456-e7c3-b713752527fb@stancevic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAH5KYCsOZkIO_ABQ--.2269S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr15AFW8uF17GF4kuryUKFg_yoWxWw1rpr
        ykJFy3tr45Cr4kAr17Kr1xWFy8tryUXw15Xr1UJF18JrZFqr1Ygr1UXr4q9a4kJr4Fkr1U
        tr15Ja47Zr4UZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/23 23:33, Dragan Stancevic 写道:
> Hi Kuai-
> 
> On 8/22/23 20:22, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/08/23 5:16, Dragan Stancevic 写道:
>>> On Tue, 3/28/23 17:01 Song Liu wrote:
>>>> On Thu, Mar 16, 2023 at 8:25=E2=80=AFAM Marc Smith 
>>>> <msmith626@gmail.com>
>>>> wr=
>>>> ote:
>>>>   >
>>>>   > On Tue, Mar 14, 2023 at 10:45=E2=80=AFAM Marc Smith
>>>> <msmith626@gmail.com>=
>>>>    wrote:
>>>>   > >
>>>>   > > On Tue, Mar 14, 2023 at 9:55=E2=80=AFAM Guoqing Jiang
>>>> <guoqing.jiang@li=
>>>> nux.dev> wrote:
>>>>   > > >
>>>>   > > >
>>>>   > > >
>>>>   > > > On 3/14/23 21:25, Marc Smith wrote:
>>>>   > > > > On Mon, Feb 8, 2021 at 7:49=E2=80=AFPM Guoqing Jiang
>>>>   > > > > <guoqing.jiang@cloud.ionos.com> wrote:
>>>>   > > > >> Hi Donald,
>>>>   > > > >>
>>>>   > > > >> On 2/8/21 19:41, Donald Buczek wrote:
>>>>   > > > >>> Dear Guoqing,
>>>>   > > > >>>
>>>>   > > > >>> On 08.02.21 15:53, Guoqing Jiang wrote:
>>>>   > > > >>>>
>>>>   > > > >>>> On 2/8/21 12:38, Donald Buczek wrote:
>>>>   > > > >>>>>> 5. maybe don't hold reconfig_mutex when try to 
>>>> unregister
>>>>   > > > >>>>>> sync_thread, like this.
>>>>   > > > >>>>>>
>>>>   > > > >>>>>>           /* resync has finished, collect result */
>>>>   > > > >>>>>>           mddev_unlock(mddev);
>>>>   > > > >>>>>>           md_unregister_thread(&mddev->sync_thread);
>>>>   > > > >>>>>>           mddev_lock(mddev);
>>>>   > > > >>>>> As above: While we wait for the sync thread to terminate,
>>>> would=
>>>> n't it
>>>>   > > > >>>>> be a problem, if another user space operation takes 
>>>> the mutex?
>>>>   > > > >>>> I don't think other places can be blocked while hold 
>>>> mutex,
>>>> othe=
>>>> rwise
>>>>   > > > >>>> these places can cause potential deadlock. Please try 
>>>> above
>>>> two =
>>>> lines
>>>>   > > > >>>> change. And perhaps others have better idea.
>>>>   > > > >>> Yes, this works. No deadlock after >11000 seconds,
>>>>   > > > >>>
>>>>   > > > >>> (Time till deadlock from previous runs/seconds: 1723, 37,
>>>> 434, 12=
>>>> 65,
>>>>   > > > >>> 3500, 1136, 109, 1892, 1060, 664, 84, 315, 12, 820 )
>>>>   > > > >> Great. I will send a formal patch with your reported-by and
>>>> tested=
>>>> -by.
>>>>   > > > >>
>>>>   > > > >> Thanks,
>>>>   > > > >> Guoqing
>>>>   > > > > I'm still hitting this issue with Linux 5.4.229 -- it looks
>>>> like 1/=
>>>> 2
>>>>   > > > > of the patches that supposedly resolve this were applied 
>>>> to the
>>>> sta=
>>>> ble
>>>>   > > > > kernels, however, one was omitted due to a regression:
>>>>   > > > > md: don't unregister sync_thread with reconfig_mutex held
>>>> (upstream
>>>>   > > > > commit 8b48ec23cc51a4e7c8dbaef5f34ebe67e1a80934)
>>>>   > > > >
>>>>   > > > > I don't see any follow-up on the thread from June 8th 2022
>>>> asking f=
>>>> or
>>>>   > > > > this patch to be dropped from all stable kernels since it 
>>>> caused a
>>>>   > > > > regression.
>>>>   > > > >
>>>>   > > > > The patch doesn't appear to be present in the current 
>>>> mainline
>>>> kern=
>>>> el
>>>>   > > > > (6.3-rc2) either. So I assume this issue is still present
>>>> there, or=
>>>>    it
>>>>   > > > > was resolved differently and I just can't find the 
>>>> commit/patch.
>>>>   > > >
>>>>   > > > It should be fixed by commit 9dfbdafda3b3"md: unlock mddev 
>>>> before
>>>> rea=
>>>> p
>>>>   > > > sync_thread in action_store".
>>>>   > >
>>>>   > > Okay, let me try applying that patch... it does not appear to be
>>>>   > > present in my 5.4.229 kernel source. Thanks.
>>>>   >
>>>>   > Yes, applying this '9dfbdafda3b3 "md: unlock mddev before reap
>>>>   > sync_thread in action_store"' patch on top of vanilla 5.4.229 
>>>> source
>>>>   > appears to fix the problem for me -- I can't reproduce the issue 
>>>> with
>>>>   > the script, and it's been running for >24 hours now. (Previously 
>>>> I was
>>>>   > able to induce the issue within a matter of minutes.)
>>>>
>>>> Hi Marc,
>>>>
>>>> Could you please run your reproducer on the md-tmp branch?
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/log/?h=3Dmd-tmp 
>>>>
>>>>
>>>> This contains a different version of the fix by Yu Kuai.
>>>>
>>>> Thanks,
>>>> Song
>>>>
>>>
>>> Hi Song, I can easily reproduce this issue on 5.10.133 and 5.10.53. 
>>> The change
>>> "9dfbdafda3b3 "md: unlock mddev before reap" does not fix the issue 
>>> for me.
>>>
>>> But I did pull the changes from the md-tmp branch you are refering:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/log/?h=3Dmd-tmp 
>>>
>>>
>>> I was not totally clear on which change exactly to pull, but I pulled
>>> the following changes:
>>> 2023-03-28 md: enhance checking in md_check_recovery()md-tmp    Yu 
>>> Kuai    1 -7/+15
>>> 2023-03-28 md: wake up 'resync_wait' at last in 
>>> md_reap_sync_thread()    Yu Kuai    1 -1/+1
>>> 2023-03-28 md: refactor idle/frozen_sync_thread()    Yu Kuai    2 -4/+22
>>> 2023-03-28 md: add a mutex to synchronize idle and frozen in 
>>> action_store()    Yu Kuai    2 -0/+8
>>> 2023-03-28 md: refactor action_store() for 'idle' and 'frozen'    Yu 
>>> Kuai    1 -16/+45
>>>
>>> I used to be able to reproduce the lockup within minutes, but with those
>>> changes the test system has been running for more than 120 hours.
>>>
>>> When you said a "different fix", can you confirm that I grabbed the 
>>> right
>>> changes and that I need all 5 of them.
>>
>> Yes, you grabbed the right changes, and these patches is merged to
>> linux-next as well.
>>>
>>> And second question was, has this fix been submitted upstream yet?
>>> If so which kernel version?
>>
>> This fix is currently in linux-next, and will be applied to v6.6-rc1
>> soon.
> 
> Thank you, that is great news. I'd like to see this change backported to 
> 5.10 and 6.1, do you have any plans of backporting to any of the 
> previous kernels?
> 
> If not, I would like to try to get your changes into 5.10 and 6.1 if 
> Greg will accept them.
> 

I don't have plans yet, so feel free to do this, I guess these patches
won't be picked automatically due to the conflict. Feel free to ask if
you meet any problems.

Thanks,
Kuai

> 
> Four out of five of your changes were a straight cherry-pick into 5.10, 
> one needed a minor conflict resolution. But I can definitely confirm 
> that your changes fix the lockup issue on 5.10
> 
> I am now switching to 6.1 and will test the changes there too.
> 
> 
> Thanks
> 
> 
> -- 
> Peace can only come as a natural consequence
> of universal enlightenment -Dr. Nikola Tesla
> 
> 
> .
> 

