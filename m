Return-Path: <linux-kernel+bounces-139358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B201D8A01D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680AB1F24687
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BCB1836D9;
	Wed, 10 Apr 2024 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHDKT34r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD415AAD6;
	Wed, 10 Apr 2024 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783837; cv=none; b=hfJNnbH0WPWUTGIE6RRxqszisAvmAJPPWSedbozn2srHpS1uN/KUxe3taQHk+ACHal/aUh3wQNXKfqpmTSNOhi9pU9t+CcxDyOZJ617uvTLwnxJgRkqgtevxF23oepx9sGy0UD0Yy6AsLMIyipj3OWMGBMKX1VYdY88xUvGrRs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783837; c=relaxed/simple;
	bh=FQ5Wqoh4cq0nJmBRJCK5eYR0utN+IWYq6E2MoFSmXIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaNihN0rArvyMsFS+Iu6QUzDOKuM0ahjXs3S/DXps7txxpJbkz2SppbP/xL4aJ5jItCoSEUKKlE7QWuZrSc7xS6UTNO10HSPXBXSR7ewq8l+Cpeg1rgPYP5lpeZhCZoYxk1ktBxoX4fusVGxXnfnHSmEAhajzvVcP7Th0t81oHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHDKT34r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E997AC433C7;
	Wed, 10 Apr 2024 21:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712783836;
	bh=FQ5Wqoh4cq0nJmBRJCK5eYR0utN+IWYq6E2MoFSmXIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHDKT34r85zeEyeIj5dbbqlATvmjM0HLkWr+kqkwrBOGW9+1s1LsynG8asMAlL7tb
	 RR+m02zE8zPY7LQO2K05eUC+I7+E1Kq8j1MlIiZwY99RCI99gupZBvOCBwr1yA9/Yw
	 dge2J54HO4pjLbGs7hhvntCKkh1ExGEJhN8z6z9XPW6jx0FWm907yZJBUmNYaYFTVG
	 QoARcbGS1onlkcPN2Xxpqbv8rN6jx5OWMAoq25DzXEP59VIpuZoUO6D3/6MVAq+XFn
	 Y/f9kMuVEvqYWahd0aY1SdROjdolWY720x+KA0CWNG3oeq8SRZrVfPxc00beR5uG4X
	 FNwWxgV08pYng==
Date: Wed, 10 Apr 2024 18:17:13 -0300
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
Message-ID: <ZhcB2Vh6lAcqPasI@x1>
References: <20240409235000.1893969-1-namhyung@kernel.org>
 <20240409235000.1893969-4-namhyung@kernel.org>
 <Zhb0raj1yW8JhuFW@x1>
 <Zhb-17CrgZt_PdUH@x1>
 <Zhb_F6hvWrjMcoM1@x1>
 <ZhcAvddbSEcMXzvH@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhcAvddbSEcMXzvH@x1>

On Wed, Apr 10, 2024 at 06:12:32PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 10, 2024 at 06:05:27PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Apr 10, 2024 at 06:04:26PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Wed, Apr 10, 2024 at 05:21:01PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Tue, Apr 09, 2024 at 04:49:57PM -0700, Namhyung Kim wrote:
> > > > > Support data type profiling output on TUI.
> > > > 
> > > > Added the follow to the commit log message, to make reviewing easier.
> > > > 
> > > > As followup patches I think having the DSO name together with the type
> > > > is important, also I think we could have a first menu with all the pairs
> > > > of DSO/type, sorted top down by the types with most samples, wdyt?
> > > > 
> > > > Applied.
> > > > 
> > > 
> > > There is something else here with the static build, checking...
> > 
> > Probably because of:
> > 
> > Makefile.config:810: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
> > 
> > Fixing...
> 
> Trying with:

Not really, I need to check for HAVE_DWARF_SUPPORT as well? Doing that

- Arnaldo
 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 6f7104f06c42d98a..458eafe65e4aa16f 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -469,9 +469,11 @@ static void hists__find_annotations(struct hists *hists,
>  					goto find_next;
>  			}
>  
> +#ifdef HAVE_SLANG_SUPPORT
>  			if (use_browser == 1)
>  				key = hist_entry__annotate_data_tui(he, evsel, NULL);
>  			else
> +#endif
>  				key = hist_entry__annotate_data_tty(he, evsel);
>  
>  			switch (key) {

