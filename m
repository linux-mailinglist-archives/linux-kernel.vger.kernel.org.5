Return-Path: <linux-kernel+bounces-163417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF03D8B6A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43631F21854
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8559B199B4;
	Tue, 30 Apr 2024 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dPnWd5/x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E120B18030;
	Tue, 30 Apr 2024 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459025; cv=none; b=GkcsF0YGp6eyKMaLKihHCfdUpJ+Ir7+mRudoatsZZ3Yrh36eNaHyd4y/QQBO6DfFFhBO0eXnm8EZM5qJrqaL3zKrgnNsfXzcKohlMqTKMtVngVae8JvlUqOoUAGIRh8XHieY29bp6WIu4Ehmaipav2UOADLXL2syi3t1TCMx2aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459025; c=relaxed/simple;
	bh=KGo6hIvlY2DFfXRayOwhLfEDabosAECVdBp2tiThtkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNTPE4gT7vHOZLPd8PwO76bt6+vO5A5uKyEagq/op592y8plSs8Mc8ETd6yiwngDt5cNXGqTCYU9EBpOdiP5o/KuGiuIpgy7k5MXWMNJujxJXeQWndem2NTnxhnkFEEquzmF16ZkbqHA+qsgU6PVI5qL/4XV6TkJNI9e27GHjJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dPnWd5/x; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714459024; x=1745995024;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KGo6hIvlY2DFfXRayOwhLfEDabosAECVdBp2tiThtkc=;
  b=dPnWd5/xeYkPlqxRHYfq0ExU1qCfMTDM84c7I1GonJSy+PuOXOIcwQxE
   Qw0CmqTGxmPXCoAu1SosSmCpPfWID7+Krn8Xy6nu+iuykHTEWnz3uFd5G
   8jT2mKuC9+nU054yhcos3jd3YeaahZLrb2T+bGAzKurXpr36okRX7ulIS
   1W2J9wEZ1oh9GSYNqUM69ZPxjOhatgJM9PJzf2/Qpfa7Y/F+jc+B2HL05
   z3ZPMUGQnVejPq4O1+olotS2oVnr7gWYKgq/YSckxlY3Ial57tIZe1Avm
   /fZioxOKlvEBvBgROlF0kH/cm6f/wbjjHL6LMC61rMTmA1XW01KJQik9u
   w==;
X-CSE-ConnectionGUID: SgMZENu0SwaZsTGMeNxM2g==
X-CSE-MsgGUID: O6Vl92QJR2ab17VoNjb3Mg==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10316006"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10316006"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 23:37:03 -0700
X-CSE-ConnectionGUID: kgMW4csVRV6x1K/Yr6uucg==
X-CSE-MsgGUID: 8JTDsJIoQByUwUenbUVmng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26973237"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.27])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 23:36:53 -0700
Message-ID: <a9b176c7-60e8-4793-a056-4ad9219fbe32@intel.com>
Date: Tue, 30 Apr 2024 09:36:48 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] perf auxtrace: Allow number of queues to be
 specified
To: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, scclevenger@os.amperecomputing.com,
 coresight@lists.linaro.org, suzuki.poulose@arm.com, mike.leach@linaro.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240429152207.479221-1-james.clark@arm.com>
 <20240429152207.479221-3-james.clark@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240429152207.479221-3-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/24 18:21, James Clark wrote:
> Currently it's only possible to initialize with the default number of
> queues and then use auxtrace_queues__add_event() to grow the array. But
> that's problematic if you don't have a real event to pass into that
> function yet.
> 
> The queues hold a void *priv member to store custom state, and for
> Coresight we want to create decoders upfront before receiving data, so
> add a new function that allows pre-allocating queues. One reason to do
> this is because we might need to store metadata (HW_ID events) that
> effects other queues, but never actually receive auxtrace data on that
> queue.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/auxtrace.c | 9 +++++++--
>  tools/perf/util/auxtrace.h | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 3684e6009b63..563b6c4fca31 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -218,15 +218,20 @@ static struct auxtrace_queue *auxtrace_alloc_queue_array(unsigned int nr_queues)
>  	return queue_array;
>  }
>  
> -int auxtrace_queues__init(struct auxtrace_queues *queues)
> +int auxtrace_queues__init_nr(struct auxtrace_queues *queues, int nr_queues)
>  {
> -	queues->nr_queues = AUXTRACE_INIT_NR_QUEUES;
> +	queues->nr_queues = nr_queues;
>  	queues->queue_array = auxtrace_alloc_queue_array(queues->nr_queues);
>  	if (!queues->queue_array)
>  		return -ENOMEM;
>  	return 0;
>  }
>  
> +int auxtrace_queues__init(struct auxtrace_queues *queues)
> +{
> +	return auxtrace_queues__init_nr(queues, AUXTRACE_INIT_NR_QUEUES);
> +}
> +
>  static int auxtrace_queues__grow(struct auxtrace_queues *queues,
>  				 unsigned int new_nr_queues)
>  {
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 55702215a82d..8a6ec9565835 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -521,6 +521,7 @@ int auxtrace_mmap__read_snapshot(struct mmap *map,
>  				 struct perf_tool *tool, process_auxtrace_t fn,
>  				 size_t snapshot_size);
>  
> +int auxtrace_queues__init_nr(struct auxtrace_queues *queues, int nr_queues);
>  int auxtrace_queues__init(struct auxtrace_queues *queues);
>  int auxtrace_queues__add_event(struct auxtrace_queues *queues,
>  			       struct perf_session *session,


