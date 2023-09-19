Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F577A61B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjISLv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISLvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:51:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B85F0;
        Tue, 19 Sep 2023 04:51:17 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rqfys3JN8ztSvR;
        Tue, 19 Sep 2023 19:47:01 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 19 Sep
 2023 19:51:14 +0800
Message-ID: <52ebd11b-eeb7-4316-84be-b8e7f2022621@huawei.com>
Date:   Tue, 19 Sep 2023 19:51:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mailbox: pcc: export the PCC subspace type
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liuyonglong@huawei.com>
References: <20230914115753.9064-1-lihuisong@huawei.com>
 <20230914161335.rz6fn4w2pqzz4wdp@bogus>
 <5ec151a4-5e2c-7745-c8ef-1edc5e7ef157@huawei.com>
 <20230918084355.rzh7k6y7uuaitanj@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230918084355.rzh7k6y7uuaitanj@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/9/18 16:43, Sudeep Holla 写道:
> On Fri, Sep 15, 2023 at 03:04:57PM +0800, lihuisong (C) wrote:
>> 在 2023/9/15 0:13, Sudeep Holla 写道:
>>> On Thu, Sep 14, 2023 at 07:57:53PM +0800, Huisong Li wrote:
>>>> As stated in APCI spec, the size of the subspace shared memory region may
>>>> be different for different types. So it is useful for driver to fill PCC
>>>> communication space. But the driver used this PCC channel doesn't know what
>>>> is the subspace type of the channel.
>>>>
>>>> So export the PCC subspace type by requesting PCC channel.
>>>>
>>> I would prefer to avoid this, but please post it with user to get better
>>> understanding of it.
>> Hi Sudeep,
>>
>> Thanks for your fast review.
>> Sorry, I cannot fully understand what you mean. What should I do for it?
>> Currently, it seems that the subspace type in all drivers used PCC is fixed
>> and not obtained from their platform.
>> IMO, PCCT is a best natural way to export it.
>>
> OK, but please post the changes in the *driver* you ought to use this channel
> type. Your change just allows the drivers to use it but it doesn't contain
> any driver making use of it. So please post that change as well to understand
> the issue better. It helps in the review.
All right, I will post it ASAP.
>
