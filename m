Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7785F75A7C3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjGTH11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGTH1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:27:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1473A19A4;
        Thu, 20 Jul 2023 00:27:24 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R644X1BRPzrRqV;
        Thu, 20 Jul 2023 15:26:36 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 15:27:21 +0800
Subject: Re: [PATCH v2 7/7] perf test: Add test case for record sideband
 events
To:     Ian Rogers <irogers@google.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20230715032915.97146-1-yangjihong1@huawei.com>
 <20230715032915.97146-8-yangjihong1@huawei.com>
 <CAP-5=fXANQvgd96=hi2j7touCex0UQ9GsUB0cL1018KfeZPqzg@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <cc21dd22-1951-d4f6-b7d7-db9ef8860404@huawei.com>
Date:   Thu, 20 Jul 2023 15:27:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fXANQvgd96=hi2j7touCex0UQ9GsUB0cL1018KfeZPqzg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/7/20 0:48, Ian Rogers wrote:
> On Fri, Jul 14, 2023 at 8:31 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Add a new test case to record sideband events for all CPUs when tracing
>> selected CPUs
>>
>> Test result:
>>
>>    # ./perf test list 2>&1 | grep 'perf record sideband tests'
>>     95: perf record sideband tests
>>    # ./perf test 95
>>     95: perf record sideband tests                                      : Ok
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>   tools/perf/tests/shell/record_tracking.sh | 44 +++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>   create mode 100755 tools/perf/tests/shell/record_tracking.sh
>>
>> diff --git a/tools/perf/tests/shell/record_tracking.sh b/tools/perf/tests/shell/record_tracking.sh
> 
> Could this be record_sideband.sh ? It will be more consistent with the
> test output...
> 
OK, will be changed to "record_sideband.sh" in the next version.

Thanks,
Yang
