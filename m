Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7327A16DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjIOHFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjIOHFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:05:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FACDE0;
        Fri, 15 Sep 2023 00:05:27 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rn4rz0ztdz1N85b;
        Fri, 15 Sep 2023 15:02:59 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 15 Sep
 2023 15:04:57 +0800
Message-ID: <5ec151a4-5e2c-7745-c8ef-1edc5e7ef157@huawei.com>
Date:   Fri, 15 Sep 2023 15:04:57 +0800
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
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230914161335.rz6fn4w2pqzz4wdp@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/9/15 0:13, Sudeep Holla 写道:
> On Thu, Sep 14, 2023 at 07:57:53PM +0800, Huisong Li wrote:
>> As stated in APCI spec, the size of the subspace shared memory region may
>> be different for different types. So it is useful for driver to fill PCC
>> communication space. But the driver used this PCC channel doesn't know what
>> is the subspace type of the channel.
>>
>> So export the PCC subspace type by requesting PCC channel.
>>
> I would prefer to avoid this, but please post it with user to get better
> understanding of it.
Hi Sudeep,

Thanks for your fast review.
Sorry, I cannot fully understand what you mean. What should I do for it?
Currently, it seems that the subspace type in all drivers used PCC is 
fixed and not obtained from their platform.
IMO, PCCT is a best natural way to export it.

/Huisong
