Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EF475716E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGRBmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGRBmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:42:49 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E90B19B;
        Mon, 17 Jul 2023 18:42:48 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R4hWv6Cq7z18Lfx;
        Tue, 18 Jul 2023 09:42:03 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 18 Jul
 2023 09:42:44 +0800
Date:   Tue, 18 Jul 2023 09:42:27 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Changbin Du <changbin.du@huawei.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hw.huiwang@huawei.com>
Subject: Re: [PATCH] perf/doc: revise the description about
 PR_TASK_PERF_EVENTS_{ENABLE,DISABLE}
Message-ID: <20230718014227.r5kmib2nqo3soyik@M910t>
References: <20230612023523.3918618-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230612023523.3918618-1-changbin.du@huawei.com>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,
Could you pick this? So I can update the prctl man pages as well.

On Mon, Jun 12, 2023 at 10:35:23AM +0800, Changbin Du wrote:
> The behavior of PR_TASK_PERF_EVENTS_{ENABLE,DISABLE} has been changed
> since v2.6.30, commit 082ff5a2767a ("perf_counter: Change pctrl()
> behaviour").
> 
> This patch revises the documentation about these two prctl options to match
> the real behavior. The linux man pages should also be updated.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/design.txt | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/design.txt b/tools/perf/design.txt
> index aa8cfeabb743..cc9a2716d5ec 100644
> --- a/tools/perf/design.txt
> +++ b/tools/perf/design.txt
> @@ -439,16 +439,15 @@ Additionally, non-inherited overflow counters can use
>  
>  to enable a counter for 'nr' events, after which it gets disabled again.
>  
> -A process can enable or disable all the counter groups that are
> -attached to it, using prctl:
> +A thread can enable or disable all the counter groups that are
> +created by itself, using prctl:
>  
>  	prctl(PR_TASK_PERF_EVENTS_ENABLE);
>  
>  	prctl(PR_TASK_PERF_EVENTS_DISABLE);
>  
> -This applies to all counters on the current process, whether created
> -by this process or by another, and doesn't affect any counters that
> -this process has created on other processes.  It only enables or
> +This applies to all counters created by this thread, and doesn't affect any
> +counters that created by other processes or threads.  It only enables or
>  disables the group leaders, not any other members in the groups.
>  
>  
> -- 
> 2.25.1
> 

-- 
Cheers,
Changbin Du
