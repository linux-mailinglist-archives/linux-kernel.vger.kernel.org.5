Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAEF787FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242591AbjHYGbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbjHYGan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:30:43 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600AE1FDA;
        Thu, 24 Aug 2023 23:30:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VqW2KOL_1692945017;
Received: from 30.221.145.196(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VqW2KOL_1692945017)
          by smtp.aliyun-inc.com;
          Fri, 25 Aug 2023 14:30:19 +0800
Message-ID: <e3c50560-c53c-5cda-8d26-e5427a2200e4@linux.alibaba.com>
Date:   Fri, 25 Aug 2023 14:30:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v7 5/8] perf test: Make matching_pmu effective
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1692606977-92009-6-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fVfc1RQO_OnSFAU4rtKfSTiWpS5PghovFjuPxruty19LQ@mail.gmail.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAP-5=fVfc1RQO_OnSFAU4rtKfSTiWpS5PghovFjuPxruty19LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/25 下午12:27, Ian Rogers 写道:
> On Mon, Aug 21, 2023 at 1:36 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>
>> The perf_pmu_test_event.matching_pmu didn't work. No matter what its
>> value is, it does not affect the test results. So let matching_pmu be
>> used for matching perf_pmu_test_pmu.pmu.name.
> 
> Could you rebase this onto the latest perf-tools-next, I'd like to test this.
> 

Ok, I will rebase it onto the latest perf-tools-next in next version.

Thanks,
Jing

> Thanks,
> Ian
> 
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> Reviewed-by: John Garry <john.g.garry@oracle.com>
>> ---
>>  tools/perf/tests/pmu-events.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
>> index 1dff863b..3204252 100644
>> --- a/tools/perf/tests/pmu-events.c
>> +++ b/tools/perf/tests/pmu-events.c
>> @@ -238,7 +238,7 @@ struct perf_pmu_test_pmu {
>>         },
>>         .alias_str = "event=0x2b",
>>         .alias_long_desc = "ddr write-cycles event. Unit: uncore_sys_ddr_pmu ",
>> -       .matching_pmu = "uncore_sys_ddr_pmu",
>> +       .matching_pmu = "uncore_sys_ddr_pmu0",
>>  };
>>
>>  static const struct perf_pmu_test_event sys_ccn_pmu_read_cycles = {
>> @@ -252,7 +252,7 @@ struct perf_pmu_test_pmu {
>>         },
>>         .alias_str = "config=0x2c",
>>         .alias_long_desc = "ccn read-cycles event. Unit: uncore_sys_ccn_pmu ",
>> -       .matching_pmu = "uncore_sys_ccn_pmu",
>> +       .matching_pmu = "uncore_sys_ccn_pmu4",
>>  };
>>
>>  static const struct perf_pmu_test_event *sys_events[] = {
>> @@ -599,6 +599,11 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
>>                         struct pmu_event const *event = &test_event->event;
>>
>>                         if (!strcmp(event->name, alias->name)) {
>> +                               if (strcmp(pmu_name, test_event->matching_pmu)) {
>> +                                       pr_debug("testing aliases uncore PMU %s: mismatched matching_pmu, %s vs %s\n",
>> +                                                       pmu_name, test_event->matching_pmu, pmu_name);
>> +                                       continue;
>> +                               }
>>                                 if (compare_alias_to_test_event(alias,
>>                                                         test_event,
>>                                                         pmu_name)) {
>> --
>> 1.8.3.1
>>
