Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC4075A476
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 04:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGTCiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 22:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTCip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 22:38:45 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9582106
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 19:38:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R5xhH6Pjfz4f3m7Z
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:38:39 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgBnHLAvnrhkPIJ+OQ--.56340S2;
        Thu, 20 Jul 2023 10:38:40 +0800 (CST)
Subject: Re: [PATCH 0/3] add page_ext_data to get client data in page_ext
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230718145812.1991717-1-shikemeng@huaweicloud.com>
 <20230719094421.GI1901145@kernel.org>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <aa2134aa-3767-b9fe-1504-d6945e8c2f7b@huaweicloud.com>
Date:   Thu, 20 Jul 2023 10:38:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230719094421.GI1901145@kernel.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBnHLAvnrhkPIJ+OQ--.56340S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr4kCw1fCr4kJFyrZFykuFg_yoWkCwb_uw
        1fJwnrGrs7KF9Iv3W29w47trWvkayrCr15Arn7GrWakryfJFZrZFnrtwsagFn5XrsIqF95
        Gan8ZrnIvw129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 7/19/2023 5:44 PM, Mike Rapoport wrote:
> On Tue, Jul 18, 2023 at 10:58:09PM +0800, Kemeng Shi wrote:
>> Current client get data from page_ext by adding offset which is auto
>> generated in page_ext core and expose the data layout design insdie
>> page_ext core. This series adds a page_ext_data to hide offset from
>> client. Thanks!
> 
> Implementers of page_ext_operations are anyway intimately related to
> page_ext, so I'm not convinced this has any value.
>  
Hi Mike, thanks for reply. I thinks page_ext_operations can be futher splited
into public part which used by client to simply register and private part which
only page_ext core cares and should not be accessed by client directly
to reduce decoupling. This series makes offset to be private which client
doesn't really care to hide data layout inside page_ext core from client.
There are some concrete gains I can list for now:
1. Future client cound call page_ext_data directly instead of define a
new function like get_page_owner to get it's data.
2. No change to client if layout of page_ext data change.
I hope this could be more convincing to you now.
Thanks!

-- 
Best wishes
Kemeng Shi

