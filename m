Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7F481336D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjLNOoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjLNOoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:44:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8D512B;
        Thu, 14 Dec 2023 06:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702565059; x=1734101059;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FICAqgrBMjAmlIFhUkbff+egjDTpSE5fRShduafzR/4=;
  b=X4DSX0yqwGpJg7xNjBQgCAEv7qod0ngpn4w3tEeLrgHvF9GAjh5yKUjz
   1AxFbIENqInvrtcceJejPJml1p/3ldIlLN1qvZ1t0zmXR/QJnXfBtD77I
   1jOdE0qA0kM2ohBauy3VLX7888Pn6TOLg7vyYkwHOymKyPmq6bM3GsO20
   VVl3HLUUmDgIsVXtCmw1YcyWj//6E/EUiqiV/RRbsirWJe1eehRwtikdS
   Fqj7ywOidS2GztP62HT9+y9gw8g69hchDiclvN9/63jek/NSXx6bxBevf
   TZZ2ITg3MPTPzqIjYHgSpsYjX/8l+GIpJTEnzuNB51Tv+svWkPzNxQtGE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1963052"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1963052"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:44:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="808606240"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="808606240"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:44:18 -0800
Received: from [10.213.191.138] (kliang2-mobl1.ccr.corp.intel.com [10.213.191.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 719F6580CD0;
        Thu, 14 Dec 2023 06:44:17 -0800 (PST)
Message-ID: <23a3de90-6740-4fde-9771-4f25681f6a2d@linux.intel.com>
Date:   Thu, 14 Dec 2023 09:44:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] perf top: Uniform the event name for the hybrid
 machine
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     acme@kernel.org, irogers@google.com, mark.rutland@arm.com,
        maz@kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20231213213633.1088026-1-kan.liang@linux.intel.com>
 <20231213213633.1088026-2-kan.liang@linux.intel.com>
 <CAM9d7ch+rHDp3E40QvBu+PGs8N+5iOP3i=HmYXKshcohs05MaQ@mail.gmail.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAM9d7ch+rHDp3E40QvBu+PGs8N+5iOP3i=HmYXKshcohs05MaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-13 4:57 p.m., Namhyung Kim wrote:
> On Wed, Dec 13, 2023 at 1:36 PM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> It's hard to distinguish the default cycles events among hybrid PMUs.
>> For example,
>>
>>  $perf top
>> Available samples
>> 385 cycles:P
>> 903 cycles:P
>>
>> The other tool, e.g., perf record, uniforms the event name and adds the
>> hybrid PMU name before opening the event. So the events can be easily
>> distinguished. Apply the same methodology for the perf top as well.
>>
>> The record__uniquify_name() will be invoked by both record and top.
>> Move it to util/record.c
> 
> Maybe better to rename it to evlist__uniquify_name() and move it
> to util/evlist.c.

Sure, I will change it in V4.

Thanks,
Kan

> 
> Thanks,
> Namhyung
> 
>>
>> With the patch
>>  $perf top
>> Available samples
>> 148 cpu_atom/cycles:P/
>> 1K cpu_core/cycles:P/
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>
>> New patch to address the display concern
>> https://lore.kernel.org/lkml/e9383607-1e43-4c1a-9512-29f27784d035@linux.intel.com/
>>
>>  tools/perf/builtin-record.c | 28 +---------------------------
>>  tools/perf/builtin-top.c    |  1 +
>>  tools/perf/util/record.c    | 25 +++++++++++++++++++++++++
>>  tools/perf/util/record.h    |  2 ++
>>  4 files changed, 29 insertions(+), 27 deletions(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index dcf288a4fb9a..a096422a4a14 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -2216,32 +2216,6 @@ static void hit_auxtrace_snapshot_trigger(struct record *rec)
>>         }
>>  }
>>
>> -static void record__uniquify_name(struct record *rec)
>> -{
>> -       struct evsel *pos;
>> -       struct evlist *evlist = rec->evlist;
>> -       char *new_name;
>> -       int ret;
>> -
>> -       if (perf_pmus__num_core_pmus() == 1)
>> -               return;
>> -
>> -       evlist__for_each_entry(evlist, pos) {
>> -               if (!evsel__is_hybrid(pos))
>> -                       continue;
>> -
>> -               if (strchr(pos->name, '/'))
>> -                       continue;
>> -
>> -               ret = asprintf(&new_name, "%s/%s/",
>> -                              pos->pmu_name, pos->name);
>> -               if (ret) {
>> -                       free(pos->name);
>> -                       pos->name = new_name;
>> -               }
>> -       }
>> -}
>> -
>>  static int record__terminate_thread(struct record_thread *thread_data)
>>  {
>>         int err;
>> @@ -2475,7 +2449,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>         if (data->is_pipe && rec->evlist->core.nr_entries == 1)
>>                 rec->opts.sample_id = true;
>>
>> -       record__uniquify_name(rec);
>> +       record__uniquify_name(rec->evlist);
>>
>>         /* Debug message used by test scripts */
>>         pr_debug3("perf record opening and mmapping events\n");
>> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
>> index cce9350177e2..4e8296654280 100644
>> --- a/tools/perf/builtin-top.c
>> +++ b/tools/perf/builtin-top.c
>> @@ -1299,6 +1299,7 @@ static int __cmd_top(struct perf_top *top)
>>                 }
>>         }
>>
>> +       record__uniquify_name(top->evlist);
>>         ret = perf_top__start_counters(top);
>>         if (ret)
>>                 return ret;
>> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
>> index 9eb5c6a08999..5b4be3c72cbc 100644
>> --- a/tools/perf/util/record.c
>> +++ b/tools/perf/util/record.c
>> @@ -289,3 +289,28 @@ int record__parse_freq(const struct option *opt, const char *str, int unset __ma
>>         opts->user_freq = freq;
>>         return 0;
>>  }
>> +
>> +void record__uniquify_name(struct evlist *evlist)
>> +{
>> +       struct evsel *pos;
>> +       char *new_name;
>> +       int ret;
>> +
>> +       if (perf_pmus__num_core_pmus() == 1)
>> +               return;
>> +
>> +       evlist__for_each_entry(evlist, pos) {
>> +               if (!evsel__is_hybrid(pos))
>> +                       continue;
>> +
>> +               if (strchr(pos->name, '/'))
>> +                       continue;
>> +
>> +               ret = asprintf(&new_name, "%s/%s/",
>> +                              pos->pmu_name, pos->name);
>> +               if (ret) {
>> +                       free(pos->name);
>> +                       pos->name = new_name;
>> +               }
>> +       }
>> +}
>> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
>> index a6566134e09e..9b520ab784bc 100644
>> --- a/tools/perf/util/record.h
>> +++ b/tools/perf/util/record.h
>> @@ -8,6 +8,7 @@
>>  #include <linux/stddef.h>
>>  #include <linux/perf_event.h>
>>  #include "util/target.h"
>> +#include "util/evlist.h"
>>
>>  struct option;
>>
>> @@ -85,6 +86,7 @@ extern const char * const *record_usage;
>>  extern struct option *record_options;
>>
>>  int record__parse_freq(const struct option *opt, const char *str, int unset);
>> +void record__uniquify_name(struct evlist *evlist);
>>
>>  static inline bool record_opts__no_switch_events(const struct record_opts *opts)
>>  {
>> --
>> 2.35.1
>>
