Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75724787F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbjHYF7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbjHYF6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:58:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E502419B5;
        Thu, 24 Aug 2023 22:58:33 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RX8NT64B8zrSVf;
        Fri, 25 Aug 2023 13:56:57 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 25 Aug 2023 13:58:29 +0800
Subject: Re: [PATCH v6 2/7] perf evlist: Add evlist__findnew_tracking_event()
 helper
To:     Ian Rogers <irogers@google.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20230821012734.18241-1-yangjihong1@huawei.com>
 <20230821012734.18241-3-yangjihong1@huawei.com>
 <CAP-5=fVw9eO=rVLHL+XuaFxsfwD+ji2f9xWdOv3AkaYj9A+w0A@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <e9c7b1f0-a8d3-3d44-7901-398928ae5fef@huawei.com>
Date:   Fri, 25 Aug 2023 13:58:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fVw9eO=rVLHL+XuaFxsfwD+ji2f9xWdOv3AkaYj9A+w0A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2023/8/25 12:55, Ian Rogers wrote:
> On Sun, Aug 20, 2023 at 6:30 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Currently, intel-bts, intel-pt, and arm-spe may add a dummy event for
>> tracking to the evlist. We may need to search for the dummy event for
>> some settings. Therefore, add evlist__findnew_tracking_event() helper.
> 
> Given the first two sentences I don't understand why this is
> evlist__findnew_tracking_event and not evlist__findnew_dummy_event?
> Are you setting tracking on other events other than dummy? If so, then
> the commit message isn't right. If not then I'd prefer not to use
> tracking event in the function name.
> 
Yes, add this helper to find tracking event for some setting, will 
modify commit message, like as follows:

Currently, intel-bts, intel-pt, and arm-spe may add tracking event to 
the evlist. We may need to search for the tracking event for
some settings. Therefore, add evlist__findnew_tracking_event() helper.

>>
>> evlist__findnew_tracking_event() also deal with system_wide maps if
>> system_wide is true.
> 
> Could you fix the explanation here, what does "deal with system_wide"
> mean? A kerneldoc comment and explanation of the system_wide argument
> would be useful.
> 
In the next version, details will be described as follows:

If system_wide is true, evlist__findnew_tracking_event() set the cpu map 
of the evsel to all online CPUs.

Is such an explanation okay?

Thanks,
Yang
