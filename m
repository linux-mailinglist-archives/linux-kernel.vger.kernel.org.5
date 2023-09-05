Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6D57927C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244615AbjIEQTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344611AbjIEDuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 23:50:21 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E20E6;
        Mon,  4 Sep 2023 20:50:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rfs38422bz4f3vdX;
        Tue,  5 Sep 2023 11:50:12 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3hqlypfZkvoWYCQ--.31883S3;
        Tue, 05 Sep 2023 11:50:11 +0800 (CST)
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle"
 transition
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Dragan Stancevic <dragan@stancevic.com>, song@kernel.org
Cc:     buczek@molgen.mpg.de, guoqing.jiang@linux.dev,
        it+raid@molgen.mpg.de, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, msmith626@gmail.com,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <CAPhsuW6R11y6vETeZ4vmFGmV6DRrj2gwhp1-Nm+csvtHb2nQYg@mail.gmail.com>
 <20230822211627.1389410-1-dragan@stancevic.com>
 <ab757e2b-3ff0-33d9-d30c-61669b738664@huaweicloud.com>
 <2061b123-6332-1456-e7c3-b713752527fb@stancevic.com>
 <07d5c7c2-c444-8747-ed6d-ca24231decd8@huaweicloud.com>
 <cf765117-7270-1b98-7e82-82a1ca1daa2a@stancevic.com>
 <0d79d1f9-00e8-93be-3c7c-244030521cd7@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ff996ffb-cba5-cc9b-2740-49ba4a1869b5@huaweicloud.com>
Date:   Tue, 5 Sep 2023 11:50:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0d79d1f9-00e8-93be-3c7c-244030521cd7@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3hqlypfZkvoWYCQ--.31883S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4DXF1UuFWUXrW3GrW7Arb_yoW8JFy7pF
        WrXa1akw4UZrnrA34xJr4q9a409wsxAr9xGrn5Gw4xAay5uF9F9FWI9a1YgF9xGrs2gr90
        vwnaqF1Dtry8X3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/30 9:36, Yu Kuai 写道:
> Hi,
> 
> 在 2023/08/29 4:32, Dragan Stancevic 写道:
> 
>> Just a followup on 6.1 testing. I tried reproducing this problem for 5 
>> days with 6.1.42 kernel without your patches and I was not able to 
>> reproduce it.

oops, I forgot that you need to backport this patch first to reporduce
this problem:

https://lore.kernel.org/all/20230529132037.2124527-2-yukuai1@huaweicloud.com/

The patch fix the deadlock as well, but it introduce some regressions.

Thanks,
Kuai

>>
>> It seems that 6.1 has some other code that prevents this from happening.
>>
> 
> I see that there are lots of patches for raid456 between 5.10 and 6.1,
> however, I remember that I used to reporduce the deadlock after 6.1, and
> it's true it's not easy to reporduce, see below:
> 
> https://lore.kernel.org/linux-raid/e9067438-d713-f5f3-0d3d-9e6b0e9efa0e@huaweicloud.com/ 
> 
> 
> My guess is that 6.1 is harder to reporduce than 5.10 due to some
> changes inside raid456.
> 
> By the way, raid10 had a similiar deadlock, and can be fixed the same
> way, so it make sense to backport these patches.
> 
> https://lore.kernel.org/r/20230529132037.2124527-5-yukuai1@huaweicloud.com
> 
> Thanks,
> Kuai
> 
> 
>> On 5.10 I can reproduce it within minutes to an hour.
>>
> 
> .
> 

