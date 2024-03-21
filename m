Return-Path: <linux-kernel+bounces-110146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C16885A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5881F22835
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3E68527B;
	Thu, 21 Mar 2024 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sC3ZqBRp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6284A5A;
	Thu, 21 Mar 2024 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031140; cv=none; b=m0olSNhRzyhxwaAFf8C+sg3NoVxjQ38YOQefwl0JZS+VjRtdv8h3Ekadpj3Z0x9HfgPlrMddMIUOsTmGFaSNKa/sFVuY9wbSSt23gJwjhs3wSTiVhB1JTH9ySzrvfpmunzCMSJ0SiTD00Abqx/pAjj0a6VVUkN+oKAkLrish3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031140; c=relaxed/simple;
	bh=sD/KIQEO+fx6yqY2lQN2AMCQqENRl5eMUN8NxSIl674=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ymu2Ud0xxitUna2jH3sccbVfGtcrWp8T55IDLY4guOODSizg2Dw29fXfjOPvD/tJILepPmFpArItecImmR3Kn7GkZoovt2BfyG8zcop7wrXk0Ag3AD2yHiABuLDel4Z4HkHn85jF21m1WDEN9NrKgYpGU7SduvtwFUR+WXdg11k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sC3ZqBRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CA6C433F1;
	Thu, 21 Mar 2024 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711031140;
	bh=sD/KIQEO+fx6yqY2lQN2AMCQqENRl5eMUN8NxSIl674=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sC3ZqBRps+8ys6X1NNGzTrU+QUtWFoxPRaru2zaweD36ssvox7vckG/unwY4jJoUA
	 dxIsS3BU2/TNj+vlxn7vpLblGDyRBYrTJ9/uk8aFP/lkw50WHDQzcqZssHwPLru0mN
	 X6RPiDnVrJC8l10Y2FopRhOTyARR0L1pWdtluGfhCtbU8AsZXW7SCP8O3M9YVHtdyL
	 gs1zbMHMCEeLNni8t4JAUzPN290G0xWFueYcqMuoZQEXDaVnqNiKXhdjccVc2YDE5h
	 5Qk1BByVQbd2wUzsKBrPKA2F2JSplJ+HWQkCz3ht7QMwOewNg581QlMtISSwh9NDvk
	 CPhB1+kRJJcKg==
Date: Thu, 21 Mar 2024 11:25:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kan Liang <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Edward Baker <edward.baker@intel.com>
Subject: Re: [PATCH v1 00/12] perf vendor events intel update
Message-ID: <ZfxDX--WFVDlGad5@x1>
References: <20240321060016.1464787-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321060016.1464787-1-irogers@google.com>

On Wed, Mar 20, 2024 at 11:00:04PM -0700, Ian Rogers wrote:
> Update events to the latest on:
> https://github.com/intel/perfmon
> 
> Using the converter script:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Kan,

	Can you please take a look and provide an Acked or Reviewed-by?

Thanks!

- Arnaldo
 
> Ian Rogers (12):
>   perf vendor events intel: Update cascadelakex to 1.21
>   perf vendor events intel: Update emeraldrapids to 1.06
>   perf vendor events intel: Update grandridge to 1.02
>   perf vendor events intel: Update icelakex to 1.24
>   perf vendor events intel: Update lunarlake to 1.01
>   perf vendor events intel: Update meteorlake to 1.08
>   perf vendor events intel: Update sapphirerapids to 1.20
>   perf vendor events intel: Update sierraforest to 1.02
>   perf vendor events intel: Update skylakex to 1.33
>   perf vendor events intel: Update skylake to v58
>   perf vendor events intel: Update snowridgex to 1.22
>   perf vendor events intel: Remove info metrics erroneously in TopdownL1
> 
>  .../arch/x86/broadwellx/bdx-metrics.json      |  35 +++---
>  .../arch/x86/cascadelakex/clx-metrics.json    |  85 +++++--------
>  .../arch/x86/cascadelakex/frontend.json       |  10 +-
>  .../arch/x86/cascadelakex/memory.json         |   2 +-
>  .../arch/x86/cascadelakex/other.json          |   2 +-
>  .../arch/x86/cascadelakex/pipeline.json       |   2 +-
>  .../x86/cascadelakex/uncore-interconnect.json |  14 +--
>  .../arch/x86/cascadelakex/virtual-memory.json |   2 +-
>  .../arch/x86/emeraldrapids/frontend.json      |   2 +-
>  .../arch/x86/emeraldrapids/memory.json        |   1 +
>  .../arch/x86/emeraldrapids/pipeline.json      |   3 +
>  .../arch/x86/emeraldrapids/uncore-cache.json  | 112 ++++++++++++++++-
>  .../emeraldrapids/uncore-interconnect.json    |  26 ++--
>  .../arch/x86/grandridge/pipeline.json         |  43 ++++++-
>  .../arch/x86/grandridge/uncore-cache.json     |  28 ++++-
>  .../arch/x86/haswellx/hsx-metrics.json        |  35 +++---
>  .../arch/x86/icelakex/frontend.json           |   2 +-
>  .../arch/x86/icelakex/icx-metrics.json        |  95 ++++++--------
>  .../pmu-events/arch/x86/icelakex/memory.json  |   1 +
>  .../arch/x86/icelakex/uncore-cache.json       |  22 +++-
>  .../x86/icelakex/uncore-interconnect.json     |  64 +++++-----
>  .../arch/x86/icelakex/uncore-io.json          |  11 --
>  .../pmu-events/arch/x86/lunarlake/cache.json  |  24 ++--
>  .../arch/x86/lunarlake/frontend.json          |   2 +-
>  .../pmu-events/arch/x86/lunarlake/memory.json |   4 +-
>  .../pmu-events/arch/x86/lunarlake/other.json  |   4 +-
>  .../arch/x86/lunarlake/pipeline.json          | 109 +++++++++++++---
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |  20 +--
>  .../pmu-events/arch/x86/meteorlake/cache.json |  30 +++++
>  .../arch/x86/meteorlake/frontend.json         |   4 +-
>  .../arch/x86/meteorlake/memory.json           |  20 +++
>  .../pmu-events/arch/x86/meteorlake/other.json |  42 ++++++-
>  .../arch/x86/meteorlake/pipeline.json         |  44 +++++--
>  .../x86/meteorlake/uncore-interconnect.json   |  22 +++-
>  .../arch/x86/sapphirerapids/cache.json        |   1 +
>  .../arch/x86/sapphirerapids/frontend.json     |   2 +-
>  .../arch/x86/sapphirerapids/memory.json       |   1 +
>  .../arch/x86/sapphirerapids/pipeline.json     |  19 +--
>  .../arch/x86/sapphirerapids/spr-metrics.json  | 119 +++++++-----------
>  .../arch/x86/sapphirerapids/uncore-cache.json | 112 ++++++++++++++++-
>  .../sapphirerapids/uncore-interconnect.json   |  26 ++--
>  .../arch/x86/sierraforest/pipeline.json       |  36 +++++-
>  .../pmu-events/arch/x86/skylake/frontend.json |  10 +-
>  .../pmu-events/arch/x86/skylakex/cache.json   |   9 ++
>  .../arch/x86/skylakex/frontend.json           |  10 +-
>  .../pmu-events/arch/x86/skylakex/memory.json  |   2 +-
>  .../pmu-events/arch/x86/skylakex/other.json   |   2 +-
>  .../arch/x86/skylakex/pipeline.json           |   2 +-
>  .../arch/x86/skylakex/skx-metrics.json        |  85 +++++--------
>  .../x86/skylakex/uncore-interconnect.json     |  14 +--
>  .../arch/x86/skylakex/uncore-io.json          |   2 +-
>  .../arch/x86/skylakex/virtual-memory.json     |   2 +-
>  .../arch/x86/snowridgex/uncore-cache.json     |   4 +-
>  .../x86/snowridgex/uncore-interconnect.json   |   6 +-
>  .../arch/x86/snowridgex/uncore-io.json        |  11 --
>  55 files changed, 911 insertions(+), 486 deletions(-)
> 
> -- 
> 2.44.0.396.g6e790dbe36-goog
> 

