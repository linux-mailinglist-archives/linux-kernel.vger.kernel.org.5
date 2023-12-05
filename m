Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A1B804470
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344049AbjLECFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjLECFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:05:44 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817F8107;
        Mon,  4 Dec 2023 18:05:49 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SkkJy355lz14L41;
        Tue,  5 Dec 2023 10:00:50 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 10:05:47 +0800
Message-ID: <d8a453b1-c77d-71b3-72cc-eaac51ef8cb8@hisilicon.com>
Date:   Tue, 5 Dec 2023 10:05:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-rc 0/6] Bugfixes and improvements for hns RoCE
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
CC:     <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
 <20231204142447.GB5136@unreal>
From:   Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20231204142447.GB5136@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.168]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/4 22:24, Leon Romanovsky wrote:
> On Wed, Nov 29, 2023 at 05:44:28PM +0800, Junxian Huang wrote:
>> Here are several bugfixes and improvements for hns RoCE.
>>
>> Chengchang Tang (4):
>>   RDMA/hns: Rename the interrupts
>>   RDMA/hns: Remove unnecessary checks for NULL in mtr_alloc_bufs()
>>   RDMA/hns: Fix memory leak in free_mr_init()
>>   RDMA/hns: Improve the readability of free mr uninit
> 
> 1. The series doesn't apply.
> ➜  kernel git:(wip/leon-for-next) ~/src/b4/b4.sh shazam -l -s https://lore.kernel.org/all/20231129094434.134528-1-huangjunxian6@hisilicon.com -P 1-5

Is this series going to be applied to -next?

> 2. Please drop patch #6 as you are deleting the code which you added in
> first patches without actual gain.

Is it better to drop it directly or merge it with the previous patch?

Thanks,
Junxian

> 
> Thanks
> 
>>
>> Junxian Huang (2):
>>   RDMA/hns: Response dmac to userspace
>>   RDMA/hns: Add a max length of gid table
>>
>>  drivers/infiniband/hw/hns/hns_roce_ah.c    |  7 ++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 87 +++++++++++++++-------
>>  drivers/infiniband/hw/hns/hns_roce_mr.c    |  2 +-
>>  include/uapi/rdma/hns-abi.h                |  5 ++
>>  4 files changed, 73 insertions(+), 28 deletions(-)
>>
>> --
>> 2.30.0
>>
>>
> 
