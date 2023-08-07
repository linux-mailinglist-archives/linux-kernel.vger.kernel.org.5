Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3627E772317
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjHGLwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjHGLwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:52:51 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77969E;
        Mon,  7 Aug 2023 04:52:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VpGjZjh_1691409162;
Received: from 30.221.158.57(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VpGjZjh_1691409162)
          by smtp.aliyun-inc.com;
          Mon, 07 Aug 2023 19:52:44 +0800
Message-ID: <e9eb280b-e744-e986-f4f1-fb510a8f3862@linux.alibaba.com>
Date:   Mon, 7 Aug 2023 19:52:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v6 3/7] perf jevents: Support more event fields
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
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
References: <1691394685-61240-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1691394685-61240-4-git-send-email-renyu.zj@linux.alibaba.com>
 <50a8778a-ebe4-5b3b-9367-c8547d6d991d@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <50a8778a-ebe4-5b3b-9367-c8547d6d991d@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/7 下午5:24, John Garry 写道:
> On 07/08/2023 08:51, Jing Zhang wrote:
>> The usual event descriptions are "event=xxx" or "config=xxx", while the
>> event descriptions of CMN are "type=xxx, eventid=xxx" or more complex.
>>
>> $cat /sys/bus/event_source/devices/arm_cmn_0/events/hnf_cache_fill
>> type=0x5,eventid=0x3
>>
>> When adding aliases for events described as "event=xxx" or "config=xxx",
>> EventCode or ConfigCode can be used in the JSON files to describe the
>> events. But "eventid=xxx, type=xxx" cannot be supported at present.
>>
>> If EventCode and ConfigCode is not added in the alias JSON file, the
>> event description will add "event=0" by default. So, even if the event
>> field is added to supplement "eventid=xxx" and "type=xxx", the final
>> parsing result will be "event=0, eventid=xxx, type=xxx".
>>
>> Therefore, when EventCode and ConfigCode are missing in JSON, "event=0" is
>> no longer added by default. EventIdCode and Type are added to the event
>> field, and ConfigCode is moved into the event_field array which can also
>> guarantee its original function.
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> 
> I'll let Ian check this change as he is more familiar with this code.
> 

Ok, thanks!
