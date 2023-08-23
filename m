Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A835784E32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 03:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjHWB2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 21:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjHWB2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 21:28:33 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA895E45;
        Tue, 22 Aug 2023 18:28:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RVpWY1QMfz4f403L;
        Wed, 23 Aug 2023 09:28:25 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6m7YOVkVzFxBQ--.15372S3;
        Wed, 23 Aug 2023 09:28:28 +0800 (CST)
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
To:     Carlos Carvalho <carlos@fisica.ufpr.br>, Song Liu <song@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>, AceLan Kao <acelan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
 <CAPhsuW5Od9tczboEBxC8gn+2XLkEbirfCUm7WuJBey5MKQjwDA@mail.gmail.com>
 <ZOUI9yDzjxuFP68E@fisica.ufpr.br>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <909a6669-01af-dbe7-b64b-84a5f3bc75a3@huaweicloud.com>
Date:   Wed, 23 Aug 2023 09:28:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZOUI9yDzjxuFP68E@fisica.ufpr.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6m7YOVkVzFxBQ--.15372S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4DKrW3Xry5JF4fKFy3Jwb_yoW8tr43p3
        yI9FZ8KrnrXF4qqr4vya4xXryY9ryv9an8AFy7uF1UZ398ZrnrCr1rtr90gw1UA34rur4j
        qa10vayUuFZrAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUOyCJDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/23 3:13, Carlos Carvalho 写道:
> Song Liu (song@kernel.org) wrote on Tue, Aug 22, 2023 at 03:56:04PM -03:
>> >From systemd code, i.e. function delete_md(), this error:
>>
>> [ 205.957004] systemd-shutdown[1]: Stopping MD /dev/md124p1 (259:6).
>> [ 205.964177] systemd-shutdown[1]: Could not stop MD /dev/md124p1:
>> Device or resource busy
>>
>> is most likely triggered by ioctl(STOP_ARRAY).
>>
>> And based on the code, I think the ioctl fails here:
>>
>>          if (cmd == STOP_ARRAY || cmd == STOP_ARRAY_RO) {
>>                  /* Need to flush page cache, and ensure no-one else opens
>>                   * and writes
>>                   */
>>                  mutex_lock(&mddev->open_mutex);
>>                  if (mddev->pers && atomic_read(&mddev->openers) > 1) {
>>                          mutex_unlock(&mddev->open_mutex);
>>                          err = -EBUSY;
>>                          goto out;        ////////////////////// HERE

Yes, I suspect here as well, but I do some test with error injection to
gurantee that ioctl(STOP_ARRAY) always return -EBUSY, but I found that
system reboot didn't hang, it'll try a few times but eventually reboot
finished.

>>                  }
>>                  if (test_and_set_bit(MD_CLOSING, &mddev->flags)) {
>>                          mutex_unlock(&mddev->open_mutex);
>>                          err = -EBUSY;
>>                          goto out;
>>                  }
>>                  did_set_md_closing = true;
>>                  mutex_unlock(&mddev->open_mutex);
>>                  sync_blockdev(bdev);
>>          }
> 
> Probably. The problem is why doesn't it manage to flush the page cache? I find
> strange that the problem appears only when trying to stop the array, I get it
> when trying to umount the filesystem, where it also hangs because of the same
> reason. The kworker thread runs continuously using 100% cpu of only 1 core.

The kworker do you mean the daemon thread or the sync thread?  runs
continuously using 100% cpu doen't sounds correct to me.

Thanks,
Kuai

> 
> These are all similar symptoms of the underlying problem which I complained
> about days ago: the system doesn't manage to write to the disks, which stay
> nearly idle. If you wait long enough without issuing writes, which can be
> several hours, it'll eventually flush the page cache and proceed to a "normal"
> umount or reboot.
> 
> The bug is dependent on the rate of writes and also on uptime; it rarely
> appears soon after boot, and increases as times passes.
> 
> .
> 

