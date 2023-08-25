Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C6A788210
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240809AbjHYI2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243840AbjHYI1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:27:39 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Aug 2023 01:27:28 PDT
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com [115.236.118.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0B62108;
        Fri, 25 Aug 2023 01:27:28 -0700 (PDT)
Received: from [172.16.12.69] (unknown [58.22.7.114])
        by mail-m11880.qiye.163.com (Hmail) with ESMTPA id E4E1620B33;
        Fri, 25 Aug 2023 16:11:49 +0800 (CST)
Message-ID: <c8c059ce-53a9-3627-8984-dff771dff1de@rock-chips.com>
Date:   Fri, 25 Aug 2023 16:11:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     shawn.lin@rock-chips.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 1/1] mmc: Set optimal I/O size when mmc_setip_queue
To:     =?UTF-8?B?U2hhcnAgWGlhICjlpI/lroflvawp?= <Sharp.Xia@mediatek.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
References: <20230818022817.3341-1-Sharp.Xia@mediatek.com>
 <CAPDyKFqN0K=2e4rijUBz=9LXVfhEVvDzNgqXTyTgvaPRK-PBNQ@mail.gmail.com>
 <f71672cc699900b57d257c56b325e185f2b6fdd9.camel@mediatek.com>
Content-Language: en-GB
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <f71672cc699900b57d257c56b325e185f2b6fdd9.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhkdS1ZJHUMdGh9MSR0eGR9VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
        tLWQY+
X-HM-Tid: 0a8a2bbfe2152eb6kusne4e1620b33
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M006Hhw5DD0BLz8BLUsSDgsM
        AQswFDBVSlVKTUJJQk5KSkpLTENKVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU5ISEg3Bg++
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sharp,

On 2023/8/25 15:10, Sharp Xia (夏宇彬) wrote:
> On Thu, 2023-08-24 at 12:55 +0200, Ulf Hansson wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>   On Fri, 18 Aug 2023 at 04:45, <Sharp.Xia@mediatek.com> wrote:
>>>
>>> From: Sharp Xia <Sharp.Xia@mediatek.com>
>>>
>>> MMC does not set readahead and uses the default VM_READAHEAD_PAGES
>>> resulting in slower reading speed.
>>> Use the max_req_size reported by host driver to set the optimal
>>> I/O size to improve performance.
>>
>> This seems reasonable to me. However, it would be nice if you could
>> share some performance numbers too - comparing before and after
>> $subject patch.
>>
>> Kind regards
>> Uffe
>>
>>>
>>> Signed-off-by: Sharp Xia <Sharp.Xia@mediatek.com>
>>> ---
>>>   drivers/mmc/core/queue.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
>>> index b396e3900717..fc83c4917360 100644
>>> --- a/drivers/mmc/core/queue.c
>>> +++ b/drivers/mmc/core/queue.c
>>> @@ -359,6 +359,7 @@ static void mmc_setup_queue(struct mmc_queue
>> *mq, struct mmc_card *card)
>>>                  blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
>>>          blk_queue_max_hw_sectors(mq->queue,
>>>                  min(host->max_blk_count, host->max_req_size /
>> 512));
>>> +       blk_queue_io_opt(mq->queue, host->max_req_size);
>>>          if (host->can_dma_map_merge)
>>>                  WARN(!blk_queue_can_use_dma_map_merging(mq->queue,
>>>                                                          mmc_dev(hos
>> t)),
>>> --
>>> 2.18.0
>>>
> 
> I test this patch on internal platform(kernel-5.15).

I patched this one and the test shows me a stable 11% performance drop.

Before:
echo 3 > proc/sys/vm/drop_caches && dd if=/data/1GB.img of=/dev/null 

2048000+0 records in
2048000+0 records out
1048576000 bytes (0.9 G) copied, 3.912249 s, 256 M/s

After:
echo 3 > proc/sys/vm/drop_caches && dd if=/data/1GB.img of=/dev/null
2048000+0 records in
2048000+0 records out
1048576000 bytes (0.9 G) copied, 4.436271 s, 225 M/s

> 
> Before:
> console:/ # echo 3 > /proc/sys/vm/drop_caches
> console:/ # dd if=/mnt/media_rw/8031-130D/super.img of=/dev/null
> 4485393+1 records in
> 4485393+1 records out
> 2296521564 bytes (2.1 G) copied, 37.124446 s, 59 M/s
> console:/ # cat /sys/block/mmcblk0/queue/read_ahead_kb
> 128
> 
> After:
> console:/ # echo 3 > /proc/sys/vm/drop_caches
> console:/ # dd if=/mnt/media_rw/8031-130D/super.img of=/dev/null
> 4485393+1 records in
> 4485393+1 records out
> 2296521564 bytes (2.1 G) copied, 28.956049 s, 76 M/s
> console:/ # cat /sys/block/mmcblk0/queue/read_ahead_kb
> 1024
> 
