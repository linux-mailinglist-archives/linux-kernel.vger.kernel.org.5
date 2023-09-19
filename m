Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D947A5723
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 03:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjISBuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 21:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjISBuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 21:50:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BEE94;
        Mon, 18 Sep 2023 18:50:13 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RqPfp3ClfzVk0r;
        Tue, 19 Sep 2023 09:47:14 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 19 Sep 2023 09:50:09 +0800
Subject: Re: [PATCH] perf jevents: Fix segfault in perf_pmu__find_events_table
To:     Namhyung Kim <namhyung@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230918030304.24832-1-yangjihong1@huawei.com>
 <CAM9d7cjCwykJ+9oB_u1cP+qgLNbwUCFhR31iK9rfjfSFxs13fg@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <10d67fbc-49b2-25ff-6d02-e13d6a22bced@huawei.com>
Date:   Tue, 19 Sep 2023 09:50:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cjCwykJ+9oB_u1cP+qgLNbwUCFhR31iK9rfjfSFxs13fg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/9/19 7:55, Namhyung Kim wrote:
> Hello,
> 
> On Sun, Sep 17, 2023 at 8:05 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Before caching the JSON events table, perf_pmu__find_events_table() need
>> to check whether table is empty.
>>
>> For example, AuthenticAMD-15-6B-1 is used. The matching events table cannot
>> be found. As a result, a null pointer is accessed when caching JSON events
>> table, causing segfault.
>>
>> Before:
>>    # perf record -vv true
>>    DEBUGINFOD_URLS=
>>    Using CPUID AuthenticAMD-15-6B-1
>>    Segmentation fault (core dumped)
>>
>> After:
>>    # perf record -vv true
>>    DEBUGINFOD_URLS=
>>    Using CPUID AuthenticAMD-15-6B-1
>>    <SNIP>
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 0.005 MB perf.data ]
>>
>> Fixes: 7c52f10c0d4d ("perf pmu: Cache JSON events table")
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> 
> Thanks for the fix but please see
> 
> https://lore.kernel.org/all/20230913125157.2790375-1-tmricht@linux.ibm.com/
> 

Uh.. no notice that there is already a fix, please ignore it.

Thanks,
Yang
