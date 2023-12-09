Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B545A80B205
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 05:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjLIEbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 23:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjLIEbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 23:31:40 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F60710DF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 20:31:45 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6d9d84019c5so1773017a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 20:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702096304; x=1702701104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b28s6vv0C6uA+s6bqFv7bzXxV6zMmtReGr1ej9rkon4=;
        b=jZfvM0mZcGNHwBW6YP/dPsD6oIlBGPxsVWI7TKxwqV0fN2sV63loJ+0hlcFvVkpWtV
         vyYEhncsnsnesmbqwO7RLCvWNvBJ8OGBzZqoGwcivMnKw8aSoJoXI+Wt9N6YhDUBZiZw
         P1zSe+Ru0McsAD7LtVfXUd22ELqoHjMlCevfCuQJNoT3vMZql55jHkj78IThI5CfITbv
         IrDw6qsfU+jwPH8gR0BkSFFegfyKNUganPtR08In0YD8yw1VrMD+zwrEdPNG1BdQ5dbw
         l8HAzH0Af5WRj/GOHbOTbel+LeTr/JIKAwDbp8qj3zK8L0QreRGENkEiCupRelTemrEJ
         XKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702096304; x=1702701104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b28s6vv0C6uA+s6bqFv7bzXxV6zMmtReGr1ej9rkon4=;
        b=QIuKQoC8AHZhyvRTo+L4n4FdkMZD9HHY5V5QZBTEobPHwoZGfiORDhppQAUqmuTBPZ
         oKMrJ85zizh44C/JfmUCI2YtEGz4dwGxTP0oO/w4lwc6ItlwfQsOfiLVuVyXZUbAhKvH
         tZihcQStNBjqubuV2ai1aynhoQC9sTC4S61iweFlavCJC7qHdo/zp15Hf27ToNH2mthD
         GSfvXPKrLftJWYZOqqSPMv9Se6LNAmeUrX8RaywXEkOUfBIMThuXxwVVTnoiNVjAc1ez
         bh2yUpio8dIuZpAMzZQGLNYJuZZevnx0umKbkfHb0hflv6Xs0CcJx8Wphb0kTFxaUBej
         JqUw==
X-Gm-Message-State: AOJu0Yz/6Tzt5DRtW5FN2bhVOMP0YR//UoNLF/eSzDBiM+IEmEYMK6jg
        f1HQpt22xheHVbXBtKKuqgZI2Q==
X-Google-Smtp-Source: AGHT+IG1xXzgrl8rimNnszJL2tNvTXi3FkysmV4QIH0mkuflgmihdw2q2ipRC/ctaNhztcrvNQCBug==
X-Received: by 2002:a05:6808:2f12:b0:3b9:fbfd:4f04 with SMTP id gu18-20020a0568082f1200b003b9fbfd4f04mr28153oib.57.1702096304584;
        Fri, 08 Dec 2023 20:31:44 -0800 (PST)
Received: from leoy-yangtze.lan ([94.177.131.71])
        by smtp.gmail.com with ESMTPSA id gu6-20020a056a004e4600b006ce93ff8c7esm2375116pfb.104.2023.12.08.20.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 20:31:43 -0800 (PST)
Date:   Sat, 9 Dec 2023 12:31:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mike.leach@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 2/5] perf mem: Clean up perf_mem_events__ptr()
Message-ID: <20231209043135.GA2116834@leoy-yangtze.lan>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207192338.400336-3-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 11:23:35AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The mem_events can be retrieved from the struct perf_pmu now. An ARCH
> specific perf_mem_events__ptr() is not required anymore. Remove all of
> them.
> 
> The Intel hybrid has multiple mem-events-supported PMUs. But they share
> the same mem_events. Other ARCHs only support one mem-events-supported
> PMU. In the configuration, it's good enough to only configure the
> mem_events for one PMU. Add perf_mem_events_find_pmu() which returns the
> first mem-events-supported PMU.
> 
> In the perf_mem_events__init(), the perf_pmus__scan() is not required
> anymore. It avoids checking the sysfs for every PMU on the system.
> 
> Make the perf_mem_events__record_args() more generic. Remove the
> perf_mem_events__print_unsupport_hybrid().
> 
> Since pmu is added as a new parameter, rename perf_mem_events__ptr() to
> perf_pmu__mem_events_ptr(). Several other functions also do a similar
> rename.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/arm64/util/mem-events.c |  10 +--
>  tools/perf/arch/x86/util/mem-events.c   |  18 ++---
>  tools/perf/builtin-c2c.c                |  28 +++++--
>  tools/perf/builtin-mem.c                |  28 +++++--
>  tools/perf/util/mem-events.c            | 103 ++++++++++++------------
>  tools/perf/util/mem-events.h            |   9 ++-
>  6 files changed, 104 insertions(+), 92 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
> index aaa4804922b4..2602e8688727 100644
> --- a/tools/perf/arch/arm64/util/mem-events.c
> +++ b/tools/perf/arch/arm64/util/mem-events.c
> @@ -12,17 +12,9 @@ struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
>  
>  static char mem_ev_name[100];
>  
> -struct perf_mem_event *perf_mem_events__ptr(int i)
> -{
> -	if (i >= PERF_MEM_EVENTS__MAX)
> -		return NULL;
> -
> -	return &perf_mem_events_arm[i];
> -}
> -
>  const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
>  {
> -	struct perf_mem_event *e = perf_mem_events__ptr(i);
> +	struct perf_mem_event *e = &perf_mem_events_arm[i];
>  
>  	if (i >= PERF_MEM_EVENTS__MAX)
>  		return NULL;

Nitpick: it's good to check if 'i' is a valid value and then access the
array with a valid index.

        if (i >= PERF_MEM_EVENTS__MAX)
                return NULL;

        e = &perf_mem_events_arm[i];

> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
> index 2b81d229982c..5fb41d50118d 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -28,17 +28,6 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
>  	E("mem-ldst",	"ibs_op//",	"ibs_op"),
>  };
>  
> -struct perf_mem_event *perf_mem_events__ptr(int i)
> -{
> -	if (i >= PERF_MEM_EVENTS__MAX)
> -		return NULL;
> -
> -	if (x86__is_amd_cpu())
> -		return &perf_mem_events_amd[i];
> -
> -	return &perf_mem_events_intel[i];
> -}
> -
>  bool is_mem_loads_aux_event(struct evsel *leader)
>  {
>  	struct perf_pmu *pmu = perf_pmus__find("cpu");
> @@ -54,7 +43,12 @@ bool is_mem_loads_aux_event(struct evsel *leader)
>  
>  const char *perf_mem_events__name(int i, const char *pmu_name)
>  {
> -	struct perf_mem_event *e = perf_mem_events__ptr(i);
> +	struct perf_mem_event *e;

A nitpick as well:

Given perf's mem/c2c, callers will almostly invoke a valid index via the
argument 'i', but I still think here is a best place to return NULL
pointer for an invalid index rather than returning a wild pointer.

Thus I suggest to apply checking for x86 and other archs:

        if (i >= PERF_MEM_EVENTS__MAX)
                return NULL;

> +
> +	if (x86__is_amd_cpu())
> +		e = &perf_mem_events_amd[i];
> +	else
> +		e = &perf_mem_events_intel[i];
>  
>  	if (!e)
>  		return NULL;

[...]

>  int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
>  				 char **rec_tmp, int *tmp_nr)
>  {
>  	const char *mnt = sysfs__mount();
> +	struct perf_pmu *pmu = NULL;
>  	int i = *argv_nr, k = 0;
>  	struct perf_mem_event *e;
>  
> -	for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> -		e = perf_mem_events__ptr(j);
> -		if (!e->record)
> -			continue;
>  
> -		if (perf_pmus__num_mem_pmus() == 1) {
> -			if (!e->supported) {
> -				pr_err("failed: event '%s' not supported\n",
> -				       perf_mem_events__name(j, NULL));
> -				return -1;
> -			}
> +	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL) {
> +		for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> +			e = perf_pmu__mem_events_ptr(pmu, j);
>  
> -			rec_argv[i++] = "-e";
> -			rec_argv[i++] = perf_mem_events__name(j, NULL);
> -		} else {
> -			struct perf_pmu *pmu = NULL;
> +			if (!e->record)
> +				continue;
>  
>  			if (!e->supported) {
> -				perf_mem_events__print_unsupport_hybrid(e, j);
> +				pr_err("failed: event '%s' not supported\n",
> +					perf_mem_events__name(j, pmu->name));
>  				return -1;
>  			}
>  
> -			while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> +			if (perf_pmus__num_mem_pmus() == 1) {
> +				rec_argv[i++] = "-e";
> +				rec_argv[i++] = perf_mem_events__name(j, NULL);
> +			} else {
>  				const char *s = perf_mem_events__name(j, pmu->name);
>  
>  				if (!perf_mem_event__supported(mnt, pmu, e))

I think we can improve a bit for this part.

Current implementation uses perf_pmus__num_mem_pmus() to decide if
system has only one memory PMU or multiple PMUs, and multiple PMUs
the tool iterates all memory PMUs to synthesize event options.

In this patch, it has changed to iterate all memory PMUs, no matter the
system has only one memory PMU or multiple PMUs. Thus, I don't see the
point for the condition checking for "perf_pmus__num_mem_pmus() == 1".
We can consolidate into the unified code like:

        char *copy;
        const char *s = perf_pmu__mem_events_name(j, pmu);

        if (!s)
                continue;

        if (!perf_pmu__mem_events_supported(mnt, pmu, e))
                continue;

        copy = strdup(s);
        if (!copy)
                return -1;

        rec_argv[i++] = "-e";
        rec_argv[i++] = copy;
        rec_tmp[k++] = copy;

Thanks,
Leo
