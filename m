Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019F6787F91
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbjHYGJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241397AbjHYGJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:09:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3911BF2;
        Thu, 24 Aug 2023 23:09:18 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RX8cv1JYnzrSjK;
        Fri, 25 Aug 2023 14:07:43 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 25 Aug 2023 14:09:14 +0800
Subject: Re: [PATCH v6 5/7] perf test: Update base-record & system-wide-dummy
 attr expected values for test-record-C0
To:     Ian Rogers <irogers@google.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20230821012734.18241-1-yangjihong1@huawei.com>
 <20230821012734.18241-6-yangjihong1@huawei.com>
 <CAP-5=fWK=vd4H6_SHpDw4rMN4eODSM5hmBY=rJ5F9fQMq-HcUg@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <0dbca9a3-f377-cd46-b1c4-e0742a94fbb5@huawei.com>
Date:   Fri, 25 Aug 2023 14:09:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fWK=vd4H6_SHpDw4rMN4eODSM5hmBY=rJ5F9fQMq-HcUg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/8/25 13:22, Ian Rogers wrote:
> On Sun, Aug 20, 2023 at 6:30 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> 1. Because a dummy sideband event is added to the sampling of specified
>>     CPUs. When evlist contains evsel of different sample_type,
>>     evlist__config() will change the default PERF_SAMPLE_ID bit to
>>     PERF_SAMPLE_IDENTIFICATION bit.
>>     The attr sample_type expected value of base-record and system-wide-dummy
>>     in test-record-C0 needs to be updated.
>>
>> 2. The perf record uses evlist__add_aux_dummy() instead of
>>     evlist__add_dummy() to add a dummy event.
>>     The expected value of system-wide-dummy attr needs to be updated.
>>
>> The perf test result is as follows:
>>
>>    # ./perf test list  2>&1 | grep 'Setup struct perf_event_attr'
>>     17: Setup struct perf_event_attr
>>    # ./perf test 17
>>     17: Setup struct perf_event_attr                                    : Ok
> 
> Will the kernel test robot complain about the previous patches
> breaking this test? It may be best to update the test while changing
> the behavior in those patches.
> 
Okay, it'll be modified in the next version.

Thanks,
Yang
