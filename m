Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035117608CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 06:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjGYEn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 00:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGYEn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 00:43:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB45710E7;
        Mon, 24 Jul 2023 21:43:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90D1112FC;
        Mon, 24 Jul 2023 21:44:08 -0700 (PDT)
Received: from [10.163.51.115] (unknown [10.163.51.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2574E3F67D;
        Mon, 24 Jul 2023 21:43:17 -0700 (PDT)
Message-ID: <04bc4e49-8633-63db-5c13-12953f3349bc@arm.com>
Date:   Tue, 25 Jul 2023 10:13:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/4] perf: Remove unused
 PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        will@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230724134500.970496-1-james.clark@arm.com>
 <20230724134500.970496-5-james.clark@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230724134500.970496-5-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/23 19:14, James Clark wrote:
> Since commit bd2756811766 ("perf: Rewrite core context handling") the
> relationship between perf_event_context and PMUs has changed so that
> the error scenario that PERF_PMU_CAP_HETEROGENEOUS_CPUS originally
> silenced no longer exists.
> 
> Remove the capability to avoid confusion that it actually influences
> any perf core behavior and shift down the following capability bits to
> fill in the unused space. This change should be a no-op.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  include/linux/perf_event.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 2166a69e3bf2..c617badd1e76 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -288,10 +288,9 @@ struct perf_event_pmu_context;
>  #define PERF_PMU_CAP_EXTENDED_REGS		0x0008
>  #define PERF_PMU_CAP_EXCLUSIVE			0x0010
>  #define PERF_PMU_CAP_ITRACE			0x0020
> -#define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x0040
> -#define PERF_PMU_CAP_NO_EXCLUDE			0x0080
> -#define PERF_PMU_CAP_AUX_OUTPUT			0x0100
> -#define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0200
> +#define PERF_PMU_CAP_NO_EXCLUDE			0x0040
> +#define PERF_PMU_CAP_AUX_OUTPUT			0x0080
> +#define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
>  
>  struct perf_output_handle;
>  
