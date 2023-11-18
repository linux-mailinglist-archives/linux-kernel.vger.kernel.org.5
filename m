Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817BC7EFD57
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 03:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjKRC7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 21:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRC7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 21:59:33 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9F9B0;
        Fri, 17 Nov 2023 18:59:29 -0800 (PST)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SXJLW63cXzsR6T;
        Sat, 18 Nov 2023 10:56:03 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 18 Nov 2023 10:59:27 +0800
Subject: Re: [GIT PULL] perf tools changes for v6.7
To:     =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <20231102150620.940538-1-namhyung@kernel.org>
 <CAEUSe78g5XUpQ19t4LbeGK4v_PZNTDZ=wjRM325Bm8haiUCoXA@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <63a2652b-e62a-348e-e92b-47d3c86461ae@huawei.com>
Date:   Sat, 18 Nov 2023 10:59:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAEUSe78g5XUpQ19t4LbeGK4v_PZNTDZ=wjRM325Bm8haiUCoXA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/11/14 3:28, Daniel Díaz wrote:
> Hello!
> 
> On Thu, 2 Nov 2023 at 09:06, Namhyung Kim <namhyung@kernel.org> wrote:
>> Hi Linus,
>>
>> Please consider pulling the latest perf tools changes.
>>
>> Thanks,
>> Namhyung
> [...]
>> Yang Jihong (29):
>>        perf evlist: Add perf_evlist__go_system_wide() helper
>>        perf evlist: Add evlist__findnew_tracking_event() helper
>>        perf record: Move setting tracking events before record__init_thread_masks()
>>        perf record: Track sideband events for all CPUs when tracing selected CPUs
>>        perf test: Add test case for record sideband events
>>        perf test: Add perf_event_attr test for record dummy event
>>        perf kwork: Fix incorrect and missing free atom in work_push_atom()
>>        perf kwork: Add the supported subcommands to the document
>>        perf kwork: Set ordered_events to true in 'struct perf_tool'
>>        perf kwork: Add `kwork` and `src_type` to work_init() for 'struct kwork_class'
>>        perf kwork: Overwrite original atom in the list when a new atom is pushed.
>>        perf kwork: Set default events list if not specified in setup_event_list()
>>        perf kwork: Add sched record support
>>        perf kwork: Add `root` parameter to work_sort()
>>        perf kwork top: Introduce new top utility
> [...]
> 
> We have found some build regressions on yesterday's 6.7-rc1:
> -----8<-----
>    builtin-kwork.c: In function 'top_print_work':
>    builtin-kwork.c:1646:28: error: format '%ld' expects argument of
> type 'long int', but argument 3 has type 'u64' {aka 'long long
> unsigned int'} [-Werror=format=]
>     1646 |         ret += printf(" %*ld ", PRINT_PID_WIDTH, work->id);
>          |                         ~~~^                     ~~~~~~~~
>          |                            |                         |
>          |                            long int                  u64
> {aka long long unsigned int}
>          |                         %*lld
>    cc1: all warnings being treated as errors
>    make[3]: *** [/builds/linux/tools/build/Makefile.build:106:
> /home/tuxbuild/.cache/tuxmake/builds/1/build/builtin-kwork.o] Error 1
> ----->8-----
> 
> This is when building for Arm (32-bits) and i386. Bisection points to
> commit 55c40e505234 ("perf kwork top: Introduce new top utility").
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> To reproduce locally,
>    tuxmake \
>      --runtime podman \
>      --target-arch arm \
>      --toolchain gcc-13 \
>      --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2Y6I5Blgre1fELnAgUTZxqjByvv/config
> \
>      debugkernel dtbs dtbs-legacy headers kernel modules perf
> 
> Greetings!
> 
Thanks for informing of build error, has send fix patch for it:
https://lore.kernel.org/all/20231118024858.1567039-2-yangjihong1@huawei.com/


Thanks,
Yang
.
