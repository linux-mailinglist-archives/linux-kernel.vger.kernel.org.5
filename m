Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000A777EEAB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 03:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347491AbjHQBXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 21:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347490AbjHQBWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:22:42 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0244FD;
        Wed, 16 Aug 2023 18:22:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RR6gd2t4Cz4f3tpq;
        Thu, 17 Aug 2023 09:22:37 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgDHVqlbdt1kzWWQAw--.63661S3;
        Thu, 17 Aug 2023 09:22:36 +0800 (CST)
Message-ID: <ae62f34f-149c-77df-f864-2db653774715@huaweicloud.com>
Date:   Thu, 17 Aug 2023 09:22:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/4] block/badblocks: fix badblocks setting error
To:     axboe@kernel.dk, vishal.l.verma@intel.com,
        dan.j.williams@intel.com, ashok_raj@linux.intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
References: <20230626080913.3493135-1-linan666@huaweicloud.com>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <20230626080913.3493135-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHVqlbdt1kzWWQAw--.63661S3
X-Coremail-Antispam: 1UD129KBjvJXoWrKryxKw13ZF4rZF13GF1kGrg_yoW8JF4UpF
        Z5Ga1fWr40gr97ZFn3Zw17Xr1rC3WxJF4UWa13tw18u34UAw1xJrn2gr1rtryqqrWIkFWq
        vF90gry5uryDG37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
        Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aV
        AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E
        8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4I
        kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWr
        Zr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_Gr
        UvcSsGvfC2KfnxnUUI43ZEXa7IUbJ73PUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/26 16:09, linan666@huaweicloud.com 写道:
> From: Li Nan <linan122@huawei.com>
> 
> This patch series fixes some simple bugs of setting badblocks and
> optimizing struct badblocks. Coly Li has been trying to refactor badblocks
> in patch series "badblocks improvement for multiple bad block ranges"
> (https://lore.kernel.org/all/20220721121152.4180-1-colyli@suse.de). but the

Coly has sent the lastest version of his patch series.

Now this patch series can be discarded.

> workload is significant. Before that, I will fix some easily triggered
> issues and optimize some code that does not conflict with Coly's changes.
> 
> Changes in v4:
>   - patch 1, remove the part of reorder fields
>   - patch 3/4, improve commit log.
> 
> Changes in v3:
>   - delete patchs with significant changes.
> 
> Li Nan (4):
>    block/badblocks: change some members of badblocks to bool
>    block/badblocks: only set bb->changed/unacked_exist when badblocks
>      changes
>    block/badblocks: fix badblocks loss when badblocks combine
>    block/badblocks: fix the bug of reverse order
> 
>   include/linux/badblocks.h |  9 +++++----
>   block/badblocks.c         | 38 ++++++++++++++++++++++----------------
>   2 files changed, 27 insertions(+), 20 deletions(-)
> 

-- 
Thanks,
Nan

