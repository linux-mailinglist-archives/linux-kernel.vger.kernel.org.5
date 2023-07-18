Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F1C757954
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGRKd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGRKd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:33:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DD4E4C;
        Tue, 18 Jul 2023 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689676433; x=1721212433;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s6mI8YfHslfKOIw00/F6WzVeMyVWya6JvmgsxQ4PDk4=;
  b=mXFsBC6k5fny7kC4xoS89Ctp65DE1zLRizdaDlxrqjt20mjUXwPA3faR
   Qw6auykdnbmR64aFpMtD1UDdIq+8365owHG65HL5e5lrcYG5p5NwlG6Ca
   FJgLbpqAIWhKEIyQsT2p4yW7UKsxH4ccH8t6vlISbe2q7xxNeeFYWJswb
   70/miESKBSkKAqsMrGJIsz+T5xJ/lviepdjSs1GhxEFsy3NH/2EoHIflh
   Q8GDNZKEpH11B9UgWi2YpJpxsMmGqQnoNFn7r0Rw5HkFWHqblREUfS+Js
   VzVD3YMRxEoSnyW3H5xCEjHNGh90NIJPR8xoq13oHqSbzpfk7WlRuOjO6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432350091"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="432350091"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 03:33:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="847646219"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="847646219"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.223.138])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 03:33:50 -0700
Message-ID: <36d52843-0070-6f34-bb73-21ecaed776a5@intel.com>
Date:   Tue, 18 Jul 2023 13:33:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] perf: doc: fix format of unordered lists
Content-Language: en-US
To:     Changbin Du <changbin.du@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230718085242.3090797-1-changbin.du@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230718085242.3090797-1-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/23 11:52, Changbin Du wrote:
> Fix the format of unordered lists so the can wrap properly.
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/Documentation/perf-ftrace.txt | 16 +++---
>  tools/perf/Documentation/perf-record.txt | 73 +++++++++++++-----------
>  2 files changed, 48 insertions(+), 41 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index df4595563801..d780b93fcf87 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -96,8 +96,9 @@ OPTIONS for 'perf ftrace trace'
>  
>  --func-opts::
>  	List of options allowed to set:
> -	  call-graph - Display kernel stack trace for function tracer.
> -	  irq-info   - Display irq context info for function tracer.
> +
> +	  - call-graph - Display kernel stack trace for function tracer.
> +	  - irq-info   - Display irq context info for function tracer.
>  
>  -G::
>  --graph-funcs=::
> @@ -118,11 +119,12 @@ OPTIONS for 'perf ftrace trace'
>  
>  --graph-opts::
>  	List of options allowed to set:
> -	  nosleep-time - Measure on-CPU time only for function_graph tracer.
> -	  noirqs       - Ignore functions that happen inside interrupt.
> -	  verbose      - Show process names, PIDs, timestamps, etc.
> -	  thresh=<n>   - Setup trace duration threshold in microseconds.
> -	  depth=<n>    - Set max depth for function graph tracer to follow.
> +
> +	  - nosleep-time - Measure on-CPU time only for function_graph tracer.
> +	  - noirqs       - Ignore functions that happen inside interrupt.
> +	  - verbose      - Show process names, PIDs, timestamps, etc.
> +	  - thresh=<n>   - Setup trace duration threshold in microseconds.
> +	  - depth=<n>    - Set max depth for function graph tracer to follow.
>  
>  
>  OPTIONS for 'perf ftrace latency'
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 9c01076f6c89..8ee5d60225ec 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -523,9 +523,10 @@ CLOCK_BOOTTIME, CLOCK_REALTIME and CLOCK_TAI.
>  Select AUX area tracing Snapshot Mode. This option is valid only with an
>  AUX area tracing event. Optionally, certain snapshot capturing parameters
>  can be specified in a string that follows this option:
> -  'e': take one last snapshot on exit; guarantees that there is at least one
> +
> +  - 'e': take one last snapshot on exit; guarantees that there is at least one
>         snapshot in the output file;
> -  <size>: if the PMU supports this, specify the desired snapshot size.
> +  - <size>: if the PMU supports this, specify the desired snapshot size.
>  
>  In Snapshot Mode trace data is captured only when signal SIGUSR2 is received
>  and on exit if the above 'e' option is given.
> @@ -572,8 +573,9 @@ providing implementation for Posix AIO API.
>  
>  --affinity=mode::
>  Set affinity mask of trace reading thread according to the policy defined by 'mode' value:
> -  node - thread affinity mask is set to NUMA node cpu mask of the processed mmap buffer
> -  cpu  - thread affinity mask is set to cpu of the processed mmap buffer
> +
> +  - node - thread affinity mask is set to NUMA node cpu mask of the processed mmap buffer
> +  - cpu  - thread affinity mask is set to cpu of the processed mmap buffer
>  
>  --mmap-flush=number::
>  
> @@ -625,16 +627,17 @@ Record timestamp boundary (time of first/last samples).
>  --switch-output[=mode]::
>  Generate multiple perf.data files, timestamp prefixed, switching to a new one
>  based on 'mode' value:
> -  "signal" - when receiving a SIGUSR2 (default value) or
> -  <size>   - when reaching the size threshold, size is expected to
> -             be a number with appended unit character - B/K/M/G
> -  <time>   - when reaching the time threshold, size is expected to
> -             be a number with appended unit character - s/m/h/d
>  
> -             Note: the precision of  the size  threshold  hugely depends
> -             on your configuration  - the number and size of  your  ring
> -             buffers (-m). It is generally more precise for higher sizes
> -             (like >5M), for lower values expect different sizes.
> +  - "signal" - when receiving a SIGUSR2 (default value) or
> +  - <size>   - when reaching the size threshold, size is expected to
> +               be a number with appended unit character - B/K/M/G
> +  - <time>   - when reaching the time threshold, size is expected to
> +               be a number with appended unit character - s/m/h/d
> +
> +               Note: the precision of  the size  threshold  hugely depends
> +               on your configuration  - the number and size of  your  ring
> +               buffers (-m). It is generally more precise for higher sizes
> +               (like >5M), for lower values expect different sizes.
>  
>  A possible use case is to, given an external event, slice the perf.data file
>  that gets then processed, possibly via a perf script, to decide if that
> @@ -680,11 +683,12 @@ choice in this option.  For example, --synth=no would have MMAP events for
>  kernel and modules.
>  
>  Available types are:
> -  'task'    - synthesize FORK and COMM events for each task
> -  'mmap'    - synthesize MMAP events for each process (implies 'task')
> -  'cgroup'  - synthesize CGROUP events for each cgroup
> -  'all'     - synthesize all events (default)
> -  'no'      - do not synthesize any of the above events
> +
> +  - 'task'    - synthesize FORK and COMM events for each task
> +  - 'mmap'    - synthesize MMAP events for each process (implies 'task')
> +  - 'cgroup'  - synthesize CGROUP events for each cgroup
> +  - 'all'     - synthesize all events (default)
> +  - 'no'      - do not synthesize any of the above events
>  
>  --tail-synthesize::
>  Instead of collecting non-sample events (for example, fork, comm, mmap) at
> @@ -736,18 +740,19 @@ ctl-fifo / ack-fifo are opened and used as ctl-fd / ack-fd as follows.
>  Listen on ctl-fd descriptor for command to control measurement.
>  
>  Available commands:
> -  'enable'           : enable events
> -  'disable'          : disable events
> -  'enable name'      : enable event 'name'
> -  'disable name'     : disable event 'name'
> -  'snapshot'         : AUX area tracing snapshot).
> -  'stop'             : stop perf record
> -  'ping'             : ping
> -
> -  'evlist [-v|-g|-F] : display all events
> -                       -F  Show just the sample frequency used for each event.
> -                       -v  Show all fields.
> -                       -g  Show event group information.
> +
> +  - 'enable'           : enable events
> +  - 'disable'          : disable events
> +  - 'enable name'      : enable event 'name'
> +  - 'disable name'     : disable event 'name'
> +  - 'snapshot'         : AUX area tracing snapshot).
> +  - 'stop'             : stop perf record
> +  - 'ping'             : ping
> +  - 'evlist [-v|-g|-F] : display all events
> +
> +                         -F  Show just the sample frequency used for each event.
> +                         -v  Show all fields.
> +                         -g  Show event group information.
>  
>  Measurements can be started with events disabled using --delay=-1 option. Optionally
>  send control command completion ('ack\n') to ack-fd descriptor to synchronize with the
> @@ -808,10 +813,10 @@ the second monitors CPUs 1 and 5-7 with the affinity mask 5-7.
>  <spec> value can also be a string meaning predefined parallel threads
>  layout:
>  
> -    cpu    - create new data streaming thread for every monitored cpu
> -    core   - create new thread to monitor CPUs grouped by a core
> -    package - create new thread to monitor CPUs grouped by a package
> -    numa   - create new threed to monitor CPUs grouped by a NUMA domain
> +    - cpu    - create new data streaming thread for every monitored cpu
> +    - core   - create new thread to monitor CPUs grouped by a core
> +    - package - create new thread to monitor CPUs grouped by a package
> +    - numa   - create new threed to monitor CPUs grouped by a NUMA domain
>  
>  Predefined layouts can be used on systems with large number of CPUs in
>  order not to spawn multiple per-cpu streaming threads but still avoid LOST

