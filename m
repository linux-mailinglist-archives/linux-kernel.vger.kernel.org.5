Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01BB7AC6CA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 08:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjIXG3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 02:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXG3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 02:29:23 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B426107;
        Sat, 23 Sep 2023 23:29:16 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rtbbg0lrXzMlfk;
        Sun, 24 Sep 2023 14:25:35 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sun, 24 Sep 2023 14:29:13 +0800
Message-ID: <f2fb9e25-c022-58d2-ac56-db35c2edfedf@huawei.com>
Date:   Sun, 24 Sep 2023 14:29:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] scsi: Add comment of target_destroy in
 scsi_host_template
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>
References: <20230922093842.2646157-1-haowenchao2@huawei.com>
 <20230922093842.2646157-3-haowenchao2@huawei.com>
 <9567a78a-baf8-432b-b279-cfc56d370a1d@acm.org>
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <9567a78a-baf8-432b-b279-cfc56d370a1d@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/22 22:53, Bart Van Assche wrote:
> On 9/22/23 02:38, Wenchao Hao wrote:
>> Add comment to tell callback function target_destroy of
>> scsi_host_template is called in atomic context.
>>
>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
>> ---
>>   include/scsi/scsi_host.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
>> index 49f768d0ff37..a72248fa5adf 100644
>> --- a/include/scsi/scsi_host.h
>> +++ b/include/scsi/scsi_host.h
>> @@ -245,6 +245,9 @@ struct scsi_host_template {
>>        * midlayer calls this point so that the driver may deallocate
>>        * and terminate any references to the target.
>>        *
>> +     * Note: this callback in called with spin_lock held, so donot
>> +     * call functions might cause schedule
>> +     *
> 
> This comment should mention which spinlock is held.
> 

Would update, thanks for your review suggestion.

> Thanks,
> 
> Bart.
> 
> 

