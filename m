Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E257AFAB5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjI0GGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjI0GGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:06:34 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5010DD;
        Tue, 26 Sep 2023 23:06:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VszD1U6_1695794786;
Received: from 30.39.241.218(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VszD1U6_1695794786)
          by smtp.aliyun-inc.com;
          Wed, 27 Sep 2023 14:06:29 +0800
Message-ID: <3ce74666-7db9-f043-8004-b1cec050188a@linux.alibaba.com>
Date:   Wed, 27 Sep 2023 14:06:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v10 0/7] Add metrics for Arm CMN
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1695621444-56530-1-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fWuaii1rOOvN7rJDo3UoQvkEtiJv3QiBhLRhYk1_Se7ew@mail.gmail.com>
 <f4812cce-14d2-9771-233f-b0db5af449be@linux.alibaba.com>
 <CAM9d7cjjSJybJEbSdBkVH3qx7RDqriv4tqBCNw1Yi9bAeUf3Yw@mail.gmail.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAM9d7cjjSJybJEbSdBkVH3qx7RDqriv4tqBCNw1Yi9bAeUf3Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/27 上午9:00, Namhyung Kim 写道:
> Hello,
> 
> On Mon, Sep 25, 2023 at 8:15 PM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>
>>
>>
>> 在 2023/9/26 上午12:37, Ian Rogers 写道:
>>> On Sun, Sep 24, 2023 at 10:58 PM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>>>
>>>> Changes since v8:
>>>> - Add fully match identifier check as suggested by Ian.
>>>> - Link: https://lore.kernel.org/lkml/1695037955-107983-1-git-send-email-renyu.zj@linux.alibaba.com/
>>>>
>>>> Jing Zhang (7):
>>>>   perf pmu: "Compat" supports regular expression matching identifiers
>>>>   perf metric: "Compat" supports regular expression matching identifiers
>>>>   perf jevents: Support EventidCode and NodeType
>>>>   perf test: Make matching_pmu effective
>>>>   perf test: Add pmu-event test for "Compat" and new event_field.
>>>>   perf jevents: Add support for Arm CMN PMU aliasing
>>>>   perf vendor events: Add JSON metrics for Arm CMN
>>>
>>> Thanks for the patience with all the to and fro. I was able to test
>>> the series with "git am -3" to get around a merge issue on
>>> perf-tools-next.
>>>
>>> Reviewed-by: Ian Rogers <irogers@google.com>
>>> Tested-by: Ian Rogers <irogers@google.com>
>>>
>>
>> Thank you for following this series and providing many valuable suggestions.
> 
> It's not applied cleanly.  Can you please rebase onto the current
> tmp.perf-tools-next branch in the following tree?
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
> 

Hi Namhyung,

I have sent v11[1] which rebase onto latest tmp.perf-tools-next branch. Please help to apply it, thanks.

[1] https://lore.kernel.org/all/1695794391-34817-1-git-send-email-renyu.zj@linux.alibaba.com/


Thanks,
Jing

> Thanks,
> Namhyung
