Return-Path: <linux-kernel+bounces-139372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 341E68A0222
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0197281ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A6D1836FA;
	Wed, 10 Apr 2024 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nar6LfZn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB528FD;
	Wed, 10 Apr 2024 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784737; cv=none; b=Jt05T9U5DJz3hUmRLmJ50GVxMog7GJ7J7QUtd9Uhxojf+fCglFGEjj+G7CjNzXPN+FMMYwvDtz5fCRChEAHgAGMWqM9NVmJBValZNu1SHIvtRdSXNhtp9Tc0z5YQi5utOXhEB51R4tekCHuxIH92nvcvhcCyQPtQ/NWQp3Kv+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784737; c=relaxed/simple;
	bh=DsgMr6BDiqsK3q9T1+THsDzho55RHG2QZeNku/055Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTGWTpixsPAa6mA2XtiCpe9FKRrcavmh3zNJPsyyY2T7ujS4+SI1VC0Usjxtr91jgYZZP60M4FMnwvEq+g1u5USxnL3ZU9rR8VrSkCitnNeRXDntUa3qiQuP+w+nPgPqUSPGjJUh+OOdHEsBMZs0QCnQRWi1FUavgaw/hksszY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nar6LfZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98312C433F1;
	Wed, 10 Apr 2024 21:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712784737;
	bh=DsgMr6BDiqsK3q9T1+THsDzho55RHG2QZeNku/055Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nar6LfZn3s7SWdDNiyIov+OYYfRtmnf9YMtFnDqTcdOvYeB9hVkF/8okAE1zTCLK1
	 rSTcbxNBXTKH8RTs5PHVrGqoyldmH7ctV7PYM9hTbT2epN/QsSl5IEPV0BDgpb4FTg
	 9es7JBpdWRjno+6WOk1T5fozW3uOKNKJig5ZX10pqTWaq40vH1EoHg86BzFXjzxvLk
	 t9fP88BA1qXdnHbm92joYzh+hWEvolvoAuLHKE1TvJe6n2Bkoz1cTrKmuuW4HmmOnv
	 md7sIv6wIpFomRuRMAUwZi1Pf0p0+mayxgeTkYXjoTKEX0s+DELPzqhZNgu8C/yb60
	 M0TvfOaScsatQ==
Date: Wed, 10 Apr 2024 18:32:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/6] perf annotate-data: Add
 hist_entry__annotate_data_tui()
Message-ID: <ZhcFXm9a2fzNeZwm@x1>
References: <20240409235000.1893969-1-namhyung@kernel.org>
 <20240409235000.1893969-4-namhyung@kernel.org>
 <Zhb0raj1yW8JhuFW@x1>
 <Zhb-17CrgZt_PdUH@x1>
 <Zhb_F6hvWrjMcoM1@x1>
 <ZhcAvddbSEcMXzvH@x1>
 <ZhcB2Vh6lAcqPasI@x1>
 <ZhcCgzslBmDK4-vn@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhcCgzslBmDK4-vn@x1>

On Wed, Apr 10, 2024 at 06:20:06PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 10, 2024 at 06:17:16PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Apr 10, 2024 at 06:12:32PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Wed, Apr 10, 2024 at 06:05:27PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Wed, Apr 10, 2024 at 06:04:26PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > On Wed, Apr 10, 2024 at 05:21:01PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > On Tue, Apr 09, 2024 at 04:49:57PM -0700, Namhyung Kim wrote:
> > > > > > > Support data type profiling output on TUI.
> > > > > > 
> > > > > > Added the follow to the commit log message, to make reviewing easier.
> > > > > > 
> > > > > > As followup patches I think having the DSO name together with the type
> > > > > > is important, also I think we could have a first menu with all the pairs
> > > > > > of DSO/type, sorted top down by the types with most samples, wdyt?
> > > > > > 
> > > > > > Applied.
> > > > > > 
> > > > > 
> > > > > There is something else here with the static build, checking...
> > > > 
> > > > Probably because of:
> > > > 
> > > > Makefile.config:810: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
> > > > 
> > > > Fixing...
> > > 
> > > Trying with:
> > 
> > Not really, I need to check for HAVE_DWARF_SUPPORT as well? Doing that
> 
> Attempting with:

Nope, the surgery needed is a bit bigger, as you made
hist_entry__annotate_data_tty dependent on DWARF but calls it without
checking HAVE_DWARF_SUPPORT from builtin-annotate.c.

I put what I have in tmp.perf-tools-next, please take a look, I'll
continue  tomorrow.

- Arnaldo
 
> ⬢[acme@toolbox perf-tools-next]$ git diff
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 458eafe65e4aa16f..521ec7e226e29e6b 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -469,7 +469,7 @@ static void hists__find_annotations(struct hists *hists,
>                                         goto find_next;
>                         }
>  
> -#ifdef HAVE_SLANG_SUPPORT
> +#if defined(HAVE_SLANG_SUPPORT) && defined(HAVE_DWARF_SUPPORT)
>                         if (use_browser == 1)
>                                 key = hist_entry__annotate_data_tui(he, evsel, NULL);
>                         else
> ⬢[acme@toolbox perf-tools-next]$

