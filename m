Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF59680B25A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 07:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjLIG1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 01:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLIG1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 01:27:19 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3130121
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 22:27:25 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so2325220a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 22:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702103245; x=1702708045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOywlATSaLLTLIkfA5QrbrC4pRY38TI520iihL5e3qI=;
        b=VyT/tVB6HmkoGkkl7flJwE3lbmlmTs4zIoQBfOfY7qVyu3KYSRKDrW6J8TfZvYIC/4
         ggF207DLRC0i2cmlF9fMci3nB6WedTypdjQ4yRtif27OSR2srAZjRgHIpBcVngt/8YB+
         21293DC4V0QnmCvjjHaNsjNnC/1MYD54IN9jK7SmJC14zRIzpyFx/0/tELEW4lbNHzMo
         Y5do5IfaLBS53QIGYkscUr4q6SwjfiJyvbdDdFWgg4xckF1BtcjOAtdhMbG5A7mwBEPa
         hQLVsKxhtDxSUas2YnE5/tuXypJPjTpsoC6CPXzsPojqqdRaSkCH/UYa30hJv1KAFlZ1
         2TkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702103245; x=1702708045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOywlATSaLLTLIkfA5QrbrC4pRY38TI520iihL5e3qI=;
        b=iVTSeScG2W2QtNDJeFmIbplu20MO7GBakiiOpQcEau9++D8gIKYfBvo8gAXKP3H8xa
         DAgppiyGM3bH0sPJZk1r0kCmUeVmEOX1+ekJ9ZOYS5lIEZo0wh7TGrrOK7x6ehIJTsd7
         btPGFI/05xsTr/UbRn1PKMI+7KSIbsddArtJURykbcXk/rCUe2T7OQyXC5lp7YRXOtKK
         uC9x2wr9jcdK6ur3PTaHcbTQOCQF0/fxZ6chn8S9ADu0/hVUx2E0u4tG5ksnZmUaqyJk
         j6/CVdGv+QVaqBN9Y/vfkzBSYppPgRJpHw3WMkIOKOGdxtG5evC88diedZIIc5jk+oyx
         xKtQ==
X-Gm-Message-State: AOJu0Yy1nPT3af2ykUejKGiQhc8oBSkaA6AnfBPCSJbzGoTFi98b+MLV
        FjDfMTbwURIyT0RziCpnO04fJg==
X-Google-Smtp-Source: AGHT+IG9nHpHovhaTeu532zPZLD/DDj4SvRjGeL7lzhycSyevoMivwHnKhcOWE0TbNrPry+h/gO4sw==
X-Received: by 2002:a05:6a21:339b:b0:18b:30e2:7e55 with SMTP id yy27-20020a056a21339b00b0018b30e27e55mr1463576pzb.46.1702103245352;
        Fri, 08 Dec 2023 22:27:25 -0800 (PST)
Received: from leoy-yangtze.lan ([94.177.131.71])
        by smtp.gmail.com with ESMTPSA id a4-20020aa78644000000b006ce36ffb0cfsm2579290pfo.33.2023.12.08.22.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 22:27:24 -0800 (PST)
Date:   Sat, 9 Dec 2023 14:27:09 +0800
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
Subject: Re: [PATCH V2 5/5] perf mem: Clean up is_mem_loads_aux_event()
Message-ID: <20231209062709.GD2116834@leoy-yangtze.lan>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-6-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207192338.400336-6-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 11:23:38AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The aux_event can be retrieved from the perf_pmu now. Implement a
> generic support.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/mem-events.c | 23 ++++-------------------
>  tools/perf/util/mem-events.c          | 14 ++++++++++++--
>  2 files changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
> index b776d849fc64..62df03e91c7e 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -1,11 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "util/pmu.h"
> -#include "util/pmus.h"
> -#include "util/env.h"
> -#include "map_symbol.h"
> -#include "mem-events.h"
>  #include "linux/string.h"
> -#include "env.h"
> +#include "util/map_symbol.h"
> +#include "util/mem-events.h"
> +#include "mem-events.h"
> +
>  
>  #define MEM_LOADS_AUX		0x8203
>  
> @@ -28,16 +26,3 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
>  	E(NULL,		NULL,		NULL,	false,	0),
>  	E("mem-ldst",	"%s//",		NULL,	false,	0),
>  };
> -
> -bool is_mem_loads_aux_event(struct evsel *leader)
> -{
> -	struct perf_pmu *pmu = perf_pmus__find("cpu");
> -
> -	if (!pmu)
> -		pmu = perf_pmus__find("cpu_core");
> -
> -	if (pmu && !perf_pmu__have_event(pmu, "mem-loads-aux"))
> -		return false;
> -
> -	return leader->core.attr.config == MEM_LOADS_AUX;
> -}
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 0d174f161034..d418320e52e3 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -103,9 +103,19 @@ static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
>  	return NULL;
>  }
>  
> -__weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
> +bool is_mem_loads_aux_event(struct evsel *leader)
>  {
> -	return false;
> +	struct perf_pmu *pmu = leader->pmu;
> +	struct perf_mem_event *e;
> +
> +	if (!pmu || !pmu->mem_events)
> +		return false;
> +
> +	e = &pmu->mem_events[PERF_MEM_EVENTS__LOAD];
> +	if (!e->aux_event)
> +		return false;
> +
> +	return leader->core.attr.config == e->aux_event;
>  }

I am wandering if we need to set the field 'aux_event' for Arm SPE.

So a quesiton maybe is not relevant with this patch actually, we can
see is_mem_loads_aux_event() is invoked in the file util/record.c:

  static struct evsel *evsel__read_sampler(struct evsel *evsel, struct evlist *evlist)
  {
          struct evsel *leader = evsel__leader(evsel);

          if (evsel__is_aux_event(leader) || arch_topdown_sample_read(leader) ||
              is_mem_loads_aux_event(leader)) {
              ...
          }
  
          return leader;
  }

Has evsel__is_aux_event() covered the memory load aux event?  If it's,
then is_mem_loads_aux_event() is not needed anymore.

Thanks,
Leo
