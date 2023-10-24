Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A317D4480
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjJXBH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjJXBHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:07:55 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AB8E8;
        Mon, 23 Oct 2023 18:07:53 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SDv762jysz4f3nTp;
        Tue, 24 Oct 2023 09:07:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
        by mail.maildlp.com (Postfix) with ESMTP id 8DF721A016E;
        Tue, 24 Oct 2023 09:07:49 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgB3BdXjGDdlJFchDw--.42414S3;
        Tue, 24 Oct 2023 09:07:49 +0800 (CST)
Subject: Re: [PATCH RFC v2 8/8] blk-mq-tag: allow shared queue/hctx to get
 more driver tags
To:     Bart Van Assche <bvanassche@acm.org>,
        Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de,
        kbusch@kernel.org, ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
 <20231021154806.4019417-9-yukuai1@huaweicloud.com>
 <d8b5db3c-cd0a-4e88-ae08-e17b97bdfc55@acm.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c8fb8f4e-2982-0fce-e226-7fe9be91e211@huaweicloud.com>
Date:   Tue, 24 Oct 2023 09:07:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d8b5db3c-cd0a-4e88-ae08-e17b97bdfc55@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3BdXjGDdlJFchDw--.42414S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWUXFyfuw4ruw1DCF17Jrb_yoWkGwb_uw
        4jgF1DXr13JayUKr1DK34DZ3y7JF1jvw1kJr45Ary7AFy5GFnYyr43Xws3u3W5Cr47JFn8
        Ar45Was3tFyUXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/10/24 4:46, Bart Van Assche 写道:
> On 10/21/23 08:48, Yu Kuai wrote:
>> +    if (!busy) {
>> +        ctl->timer_running = false;
>> +    } else {
>> +        ctl->timer.expires = jiffies + HZ;
>> +        add_timer(&ctl->timer);
>> +    }
>> +    spin_unlock_irq(&tags->lock);
> 
> [ ... ]
> 
>> +inc_busy:
>> +    atomic_inc(&info->busy_count);
>> +    if (!tags->ctl.timer_running &&
>> +        try_cmpxchg_relaxed(&tags->ctl.timer_running, &timer_running, 
>> true)) {
>> +        tags->ctl.timer.expires = jiffies + HZ;
>> +        add_timer(&tags->ctl.timer);
>> +    }
>>   }
> 
> So the choice has been made to let the timer expire after one second? I
> think the choice of the timer value is important enough to mention it in
> the patch description.

Yes, I agree, I admit that I was not that cautious while choose 1 HZ in
this version, I'm not quite sure is this approch will be accepted yet,
while this is the best(simple and workable) way that I can think of.

Thanks,
Kuai

> 
> Thanks,
> 
> Bart.
> 
> 
> .
> 

