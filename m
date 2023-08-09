Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B35F775129
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 05:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjHIDDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 23:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHIDDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 23:03:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536EE1995
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 20:03:15 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLFCM6BLRztSCq;
        Wed,  9 Aug 2023 10:59:43 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 11:03:12 +0800
Subject: Re: [PATCH -next] dm: Remove unused declaration dm_get_rq_mapinfo()
To:     Hugo Villeneuve <hugo@hugovil.com>
CC:     <agk@redhat.com>, <snitzer@kernel.org>, <dm-devel@redhat.com>,
        <heinzm@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20230808150301.45196-1-yuehaibing@huawei.com>
 <20230808130333.2207c675d008fa6c808a472f@hugovil.com>
From:   Yue Haibing <yuehaibing@huawei.com>
Message-ID: <2c73f603-4c0b-36d8-df9f-be33db589c69@huawei.com>
Date:   Wed, 9 Aug 2023 11:03:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20230808130333.2207c675d008fa6c808a472f@hugovil.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/9 1:03, Hugo Villeneuve wrote:
> On Tue, 8 Aug 2023 23:03:01 +0800
> Yue Haibing <yuehaibing@huawei.com> wrote:
> 
> Hi,
> 
>> Commit ae6ad75e5c3c ("dm: remove unused dm_get_rq_mapinfo()")
>> removed the implementation but leave declaration.
> 
> Maybe change to "removed the implementation but not the declaration."

Thanks， will do this in v2.

> 
> Hugo Villeneuve.
> 
> 
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>>  include/linux/device-mapper.h | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
>> index 69d0435c7ebb..5bc69c6a64e0 100644
>> --- a/include/linux/device-mapper.h
>> +++ b/include/linux/device-mapper.h
>> @@ -502,7 +502,6 @@ int dm_post_suspending(struct dm_target *ti);
>>  int dm_noflush_suspending(struct dm_target *ti);
>>  void dm_accept_partial_bio(struct bio *bio, unsigned int n_sectors);
>>  void dm_submit_bio_remap(struct bio *clone, struct bio *tgt_clone);
>> -union map_info *dm_get_rq_mapinfo(struct request *rq);
>>  
>>  #ifdef CONFIG_BLK_DEV_ZONED
>>  struct dm_report_zones_args {
>> -- 
>> 2.34.1
>>
> 
> .
> 
