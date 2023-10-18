Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C887CD1DC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344378AbjJRBiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJRBiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:38:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BE8C4;
        Tue, 17 Oct 2023 18:37:56 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S9D0Q3mghzVlJb;
        Wed, 18 Oct 2023 09:34:14 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 18 Oct 2023 09:37:53 +0800
Message-ID: <8877db4d-50e2-d814-484b-c2ec501f752b@huawei.com>
Date:   Wed, 18 Oct 2023 09:37:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 0/4] SCSI: Fix issues between removing device and error
 handle
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Wenchao Hao <haowenchao22@gmail.com>
CC:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>
References: <20231016020314.1269636-1-haowenchao2@huawei.com>
 <CAOptpSMSpuU_NDKNPKRk1ZS76KhOfCmSeB7YxbD6jvNpvNGZPg@mail.gmail.com>
 <0091a3e7-d3cf-4572-af46-79adbde42ab8@acm.org>
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <0091a3e7-d3cf-4572-af46-79adbde42ab8@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/18 5:41, Bart Van Assche wrote:
> 
> On 10/17/23 10:00, Wenchao Hao wrote:
>> On Mon, Oct 16, 2023 at 10:04 AM Wenchao Hao <haowenchao2@huawei.com> wrote:
>>>
>>> I am testing SCSI error handle with my previous scsi_debug error
>>> injection patches, and found some issues when removing device and
>>> error handler happened together.
>>>
>>> These issues are triggered because devices in removing would be skipped
>>> when calling shost_for_each_device().
>>
>> Friendly ping...
> 
> The patch series was posted on October 15, 7 PM PDT and the ping has
> been posted on October 17, 10 AM PDT. That's less than two days after
> the patch series was posted. Isn't that way too soon to post a "ping"?
> 

The previous version was posted on 2023/9/28 but not reviewed, so I ping
soon after repost.

> Thanks,
> 
> Bart.
> 
> 

