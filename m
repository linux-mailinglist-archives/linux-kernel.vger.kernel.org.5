Return-Path: <linux-kernel+bounces-139282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADC28A00E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0191F24C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA8A18133F;
	Wed, 10 Apr 2024 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/tyxoTy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B477828FD;
	Wed, 10 Apr 2024 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778763; cv=none; b=dCZrMORbmyW+JGyY900zv/juCAwRYOM5IFUm4/lz0/wjeZTMjzI7r14REM3n4xpCmwXkoIH42usjUWmYun099tEUDsuW4jLu+Ry1tXo1dfg33OdQ77UB9sLtujwkwHyFuxNUaucjCXMat7wa4Yzk+p7Eq0O0Ct71wEAQc2YReVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778763; c=relaxed/simple;
	bh=HmV0bjsSlKEC99Ik9DKscFRJxpEuP1+26uWiLWV86jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1OXK0mXevcfHFQH0pklayi+MCULiPCXzgo26Sks+CGJtLKlwMVgfrvGkTztemaqPhvDpTxXVPmmueITNOYzZ3k9tkGOFP+N2R8LKJH4le9zX3qwXVGMhqEhZc9oqJuXzCZPQ0KSNaE9K2sIRjoad1dl88FQLOCUkETUxC8AV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/tyxoTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26F5C433C7;
	Wed, 10 Apr 2024 19:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712778763;
	bh=HmV0bjsSlKEC99Ik9DKscFRJxpEuP1+26uWiLWV86jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/tyxoTy/wuuYMKP78XeK61XHpz9pROlv6nWW9vTKwTHvf1DS88n6UIxf0OMt8S5R
	 jLU0JkE0nfbSjxFqtXDW/9hP+yq1A2HP9iyi0rc6EyQR33e+ETOcat1uP94YUU9+rm
	 cXpAsO2b+czJCIm2sojByH4QjLw/N+phz1WYVo5DsgthysWkNb2wwQPdoF6agtJ1a+
	 jMr+Zj1y3f6uD05OZRRpeN5B7ueMW1Hl+tLpD4s/IYxAdFBVsus8zaNLXDLI1whaJU
	 K7L5W/xUlRFdy6EBazve70BsqgVQ3ZdXx2B8g+EUAJ4BMYI0n3RJskmO3+1L6j+5Ko
	 vB/ePzX/EKBZQ==
Date: Wed, 10 Apr 2024 16:52:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/6] perf annotate-data: Support event group display in
 TUI
Message-ID: <ZhbuB43qQXzfUT14@x1>
References: <20240409235000.1893969-1-namhyung@kernel.org>
 <20240409235000.1893969-5-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409235000.1893969-5-namhyung@kernel.org>

On Tue, Apr 09, 2024 at 04:49:58PM -0700, Namhyung Kim wrote:
> Like in stdio, it should print all events in a group together.

Please provide the desired output, i.e. the "like in stdio", together
with the 'perf record' that creates a perf.data file that will then be
used with 'perf annotate' to produce the old output and then the new,
I'm trying to do that now to review the patch.

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate-data.c | 50 ++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
> index fefacaaf16db..a4a0f042f201 100644
> --- a/tools/perf/ui/browsers/annotate-data.c
> +++ b/tools/perf/ui/browsers/annotate-data.c
> @@ -10,20 +10,27 @@
>  #include "util/annotate.h"
>  #include "util/annotate-data.h"
>  #include "util/evsel.h"
> +#include "util/evlist.h"
>  #include "util/sort.h"
>  
>  struct annotated_data_browser {
>  	struct ui_browser b;
>  	struct list_head entries;
> +	int nr_events;
>  };
>  
>  struct browser_entry {
>  	struct list_head node;
>  	struct annotated_member *data;
> -	struct type_hist_entry hists;
> +	struct type_hist_entry *hists;
>  	int indent;
>  };
>  
> +static struct annotated_data_browser *get_browser(struct ui_browser *uib)
> +{
> +	return container_of(uib, struct annotated_data_browser, b);
> +}
> +
>  static void update_hist_entry(struct type_hist_entry *dst,
>  			      struct type_hist_entry *src)
>  {
> @@ -33,17 +40,21 @@ static void update_hist_entry(struct type_hist_entry *dst,
>  
>  static int get_member_overhead(struct annotated_data_type *adt,
>  			       struct browser_entry *entry,
> -			       struct evsel *evsel)
> +			       struct evsel *leader)
>  {
>  	struct annotated_member *member = entry->data;
> -	int i;
> +	int i, k;
>  
>  	for (i = 0; i < member->size; i++) {
>  		struct type_hist *h;
> +		struct evsel *evsel;
>  		int offset = member->offset + i;
>  
> -		h = adt->histograms[evsel->core.idx];
> -		update_hist_entry(&entry->hists, &h->addr[offset]);
> +		for_each_group_evsel(evsel, leader) {
> +			h = adt->histograms[evsel->core.idx];
> +			k = evsel__group_idx(evsel);
> +			update_hist_entry(&entry->hists[k], &h->addr[offset]);
> +		}
>  	}
>  	return 0;
>  }
> @@ -61,6 +72,12 @@ static int add_child_entries(struct annotated_data_browser *browser,
>  	if (entry == NULL)
>  		return -1;
>  
> +	entry->hists = calloc(browser->nr_events, sizeof(*entry->hists));
> +	if (entry->hists == NULL) {
> +		free(entry);
> +		return -1;
> +	}
> +
>  	entry->data = member;
>  	entry->indent = indent;
>  	if (get_member_overhead(adt, entry, evsel) < 0) {
> @@ -113,6 +130,7 @@ static void annotated_data_browser__delete_entries(struct annotated_data_browser
>  
>  	list_for_each_entry_safe(pos, tmp, &browser->entries, node) {
>  		list_del_init(&pos->node);
> +		free(pos->hists);
>  		free(pos);
>  	}
>  }
> @@ -126,6 +144,7 @@ static int browser__show(struct ui_browser *uib)
>  {
>  	struct hist_entry *he = uib->priv;
>  	struct annotated_data_type *adt = he->mem_type;
> +	struct annotated_data_browser *browser = get_browser(uib);
>  	const char *help = "Press 'h' for help on key bindings";
>  	char title[256];
>  
> @@ -146,7 +165,8 @@ static int browser__show(struct ui_browser *uib)
>  	else
>  		strcpy(title, "Percent");
>  
> -	ui_browser__printf(uib, " %10s %10s %10s  %s",
> +	ui_browser__printf(uib, "%*s %10s %10s %10s  %s",
> +			   11 * (browser->nr_events - 1), "",
>  			   title, "Offset", "Size", "Field");
>  	ui_browser__write_nstring(uib, "", uib->width);
>  	return 0;
> @@ -175,18 +195,20 @@ static void browser__write_overhead(struct ui_browser *uib,
>  
>  static void browser__write(struct ui_browser *uib, void *entry, int row)
>  {
> +	struct annotated_data_browser *browser = get_browser(uib);
>  	struct browser_entry *be = entry;
>  	struct annotated_member *member = be->data;
>  	struct hist_entry *he = uib->priv;
>  	struct annotated_data_type *adt = he->mem_type;
> -	struct evsel *evsel = hists_to_evsel(he->hists);
> +	struct evsel *leader = hists_to_evsel(he->hists);
> +	struct evsel *evsel;
>  
>  	if (member == NULL) {
>  		bool current = ui_browser__is_current_entry(uib, row);
>  
>  		/* print the closing bracket */
>  		ui_browser__set_percent_color(uib, 0, current);
> -		ui_browser__write_nstring(uib, "", 11);
> +		ui_browser__write_nstring(uib, "", 11 * browser->nr_events);
>  		ui_browser__printf(uib, " %10s %10s  %*s};",
>  				   "", "", be->indent * 4, "");
>  		ui_browser__write_nstring(uib, "", uib->width);
> @@ -194,8 +216,12 @@ static void browser__write(struct ui_browser *uib, void *entry, int row)
>  	}
>  
>  	/* print the number */
> -	browser__write_overhead(uib, adt->histograms[evsel->core.idx],
> -				&be->hists, row);
> +	for_each_group_evsel(evsel, leader) {
> +		struct type_hist *h = adt->histograms[evsel->core.idx];
> +		int idx = evsel__group_idx(evsel);
> +
> +		browser__write_overhead(uib, h, &be->hists[idx], row);
> +	}
>  
>  	/* print type info */
>  	if (be->indent == 0 && !member->var_name) {
> @@ -267,11 +293,15 @@ int hist_entry__annotate_data_tui(struct hist_entry *he, struct evsel *evsel,
>  			.priv	 = he,
>  			.extra_title_lines = 1,
>  		},
> +		.nr_events = 1,
>  	};
>  	int ret;
>  
>  	ui_helpline__push("Press ESC to exit");
>  
> +	if (evsel__is_group_event(evsel))
> +		browser.nr_events = evsel->core.nr_members;
> +
>  	ret = annotated_data_browser__collect_entries(&browser);
>  	if (ret == 0)
>  		ret = annotated_data_browser__run(&browser, evsel, hbt);
> -- 
> 2.44.0.478.gd926399ef9-goog

