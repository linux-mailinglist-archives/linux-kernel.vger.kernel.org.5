Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA74B79B929
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbjIKWXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbjIKLc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:32:56 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C676ACDD;
        Mon, 11 Sep 2023 04:32:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rkl276NMGz4f3k5Z;
        Mon, 11 Sep 2023 19:32:47 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgAXrt3d+v5kdn3LAA--.26791S3;
        Mon, 11 Sep 2023 19:32:48 +0800 (CST)
Message-ID: <e9bafd8c-b389-845d-5fb3-8c7e05290518@huaweicloud.com>
Date:   Mon, 11 Sep 2023 19:32:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4] ata: libata-eh: Honor all EH scheduling requests
To:     Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>, luojian <luojian5@huawei.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "htejun@gmail.com" <htejun@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linan122@huawei.com" <linan122@huawei.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <20230906084212.1016634-1-linan666@huaweicloud.com>
 <202309071557.3a90e7a8-oliver.sang@intel.com> <ZPo6fXqTbmwDyopr@x1-carbon>
 <d88625ca-9bc7-cf33-2fa7-9e71d4153e7f@kernel.org>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <d88625ca-9bc7-cf33-2fa7-9e71d4153e7f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXrt3d+v5kdn3LAA--.26791S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr17uF4xWr1DZF4xur1xZrb_yoW8ur1fpF
        W8Ja4qkr4DJryqvanrZw18ZF1Yyana9a4YyF1rG34fZrn0q34rtryxKa909rZa93WxWr1j
        vw1Sqr95ZF1UXrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9qb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
        Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aV
        AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E
        8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4I
        kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWr
        Jr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjxUojjgDUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/11 15:16, Damien Le Moal 写道:
> On 9/8/23 06:02, Niklas Cassel wrote:
>> On Thu, Sep 07, 2023 at 03:43:19PM +0800, kernel test robot wrote:
> 
> I am not confident that playing with host_eh_schedule count is the right

Yeah, If there is some way can wake up EH without inc host_eh_schedule,
dec count becomes risky.

> approach. A better solution may be to change the timing of clearing
> ATA_PFLAG_EH_PENDING. Right now, this is done on entry to
> ata_scsi_port_error_handler(), unconditionally. So ata_eh_reset() should not
> need to clear the flag again. If we remove that, then a new interrupt received
> after ata_eh_thaw() and setting EH_PENDING would be cought by the retry loop in
> ata_scsi_port_error_handler(), which would run again ap->ops->error_handler(ap).
> 
> So let's try this fix instead:
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 159ba6ba19eb..d1d081aa0c95 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2807,7 +2807,6 @@ int ata_eh_reset(struct ata_link *link, int classify,
>          memset(&link->eh_info, 0, sizeof(link->eh_info));
>          if (slave)
>                  memset(&slave->eh_info, 0, sizeof(link->eh_info));
> -       ap->pflags &= ~ATA_PFLAG_EH_PENDING;
>          spin_unlock_irqrestore(link->ap->lock, flags);
> 
>          if (ata_port_is_frozen(ap))
> 
> Li,
> 
> Can you please test this ?
> 

OK, Let us test this patch.

>>
>>
>> It might be worth mentioning that the race window for the bug that the patch
>> in $subject is fixing, should be much smaller after this patch is in:
>> https://lore.kernel.org/linux-ide/20230907081710.4946-1-Chloe_Chen@asmedia.com.tw/
>>
>> Li Nan, perhaps you could see if you can still reproduce your original
>> problem with the patch from the ASMedia guys?
> 
> 
>>
>> However, even with the ASMedia patch, it should still be theoretically
>> possible to get an error irq after ata_eh_reset() has called ahci_thaw(),
>> so I suppose that this patch still makes some sense...
>>
>>
>> Kind regards,
>> Niklas
> 

-- 
Thanks,
Nan

