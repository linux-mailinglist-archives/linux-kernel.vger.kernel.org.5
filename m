Return-Path: <linux-kernel+bounces-139326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1339E8A0171
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443A51C2466D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6735C181CEF;
	Wed, 10 Apr 2024 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLggDbpN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA8217F37A;
	Wed, 10 Apr 2024 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712781967; cv=none; b=B1Pxtmtp6FCRYp4pRupjdmK9R4tbjOSygwQO25VblvM8VPe0vSjloknfh7YZKokpgnygzNw1G/+Xz1gIbksV+zdN7wdQX78BPsb38SmvGLoitt2/G9GRX5WYZb1H5Ib9LvJKkIzKfVI3J8gBPiCAeqY6ZZLOSinEQegdpWtvAM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712781967; c=relaxed/simple;
	bh=0QSCL/hvtLmpjs+qXUf272DGb1S3kZzbWCaWKPOZaIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVZa+RGlV5hipmrkAl2CPeFssGIphcl76546dD0zepD0iTIiRohfjpLg64T1rfww9rhLjhMNnYbwQfs3kY96/YBboDfPOjl8X91ljcDYmxuTT7WoGc2s6wWrOU2HNGWrou/jtAIPG8SpfWO/VXQM4MtdjrYvTIWxkG+/t5TfRCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLggDbpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92181C433F1;
	Wed, 10 Apr 2024 20:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712781967;
	bh=0QSCL/hvtLmpjs+qXUf272DGb1S3kZzbWCaWKPOZaIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLggDbpN2wo5Za26GyXDFPLOx+lCzdCEKofCRFCr5iXTlB0rCLS6EY1hnnlmpcL55
	 vbubcMbdKpB/D/HPWMnyNAqfPhnZ3CT6zTrTWWF1ZMCWKx5qoS1IEFy7sF/we7LNSp
	 jBLQW3R7cymmVILjfG54rZ5qHRdzHvPTt+LbPOnWXexpAKFJArlC+aCDAf+ajhXiSQ
	 L3QrEPhLQQhG67lJnhADcfJLePucmAn9P4tUwGRYwGpPp0ZBWry2PWFZyZpNLDLBXr
	 uPcWypVYPOjjDqq++cOL+w4nCv6ux5FrmAly1gCry3FPeARaOg9H3pTxFjr3xJzF3C
	 yADTLxqgSLrUA==
Date: Wed, 10 Apr 2024 17:46:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 5/6] perf report: Add a menu item to annotate data type
 in TUI
Message-ID: <Zhb6jJneP36Z-or0@x1>
References: <20240409235000.1893969-1-namhyung@kernel.org>
 <20240409235000.1893969-6-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409235000.1893969-6-namhyung@kernel.org>

On Tue, Apr 09, 2024 at 04:49:59PM -0700, Namhyung Kim wrote:
> When the hist entry has the type info, it should be able to display the
> annotation browser for the type like in `perf annotate --data-type`.

Trying to test this with:

root@number:~# perf report --header-only |& grep "perf record"
# cmdline : /home/acme/bin/perf record -a -e {cpu_core/mem-loads,ldlat=30/P,cpu_core/mem-stores/P} 
root@number:~# perf evlist -v
cpu_core/mem-loads,ldlat=30/P: type: 4 (cpu_core), size: 136, config: 0x1cd (mem-loads), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, precise_ip: 2, sample_id_all: 1, { bp_addr, config1 }: 0x1f
cpu_core/mem-stores/P: type: 4 (cpu_core), size: 136, config: 0x2cd (mem-stores), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, inherit: 1, freq: 1, precise_ip: 3, sample_id_all: 1
dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
root@number:~# perf report -s type

And when I press ESC to exit:

root@number:~# perf report -s type
perf: Segmentation fault
-------- backtrace --------
perf[0x61326b]
/lib64/libc.so.6(+0x3e9a0)[0x7f7173a5c9a0]
/lib64/libc.so.6(free+0x25)[0x7f7173abd385]
perf[0x5d5002]
perf[0x4fd007]
perf[0x523ce0]
perf[0x525ad4]
perf[0x503f43]
perf[0x557ad4]
perf[0x557eeb]
perf[0x4e5355]
perf[0x4dea42]
perf[0x528aad]
perf[0x42b559]
perf[0x4c39e9]
perf[0x4c3cf9]
perf[0x410e47]
/lib64/libc.so.6(+0x2814a)[0x7f7173a4614a]
/lib64/libc.so.6(__libc_start_main+0x8b)[0x7f7173a4620b]
perf[0x4113e5]
root@number:~#

Trying to build with debug info...

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-report.c    |  5 +++++
>  tools/perf/ui/browsers/hists.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index dcd93ee5fc24..aaa6427a1224 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1694,6 +1694,11 @@ int cmd_report(int argc, const char **argv)
>  	else
>  		use_browser = 0;
>  
> +	if (report.data_type && use_browser == 1) {
> +		symbol_conf.annotate_data_member = true;
> +		symbol_conf.annotate_data_sample = true;
> +	}
> +
>  	if (sort_order && strstr(sort_order, "ipc")) {
>  		parse_options_usage(report_usage, options, "s", 1);
>  		goto error;
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index 0c02b3a8e121..71b32591d61a 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -38,6 +38,7 @@
>  #include "../ui.h"
>  #include "map.h"
>  #include "annotate.h"
> +#include "annotate-data.h"
>  #include "srcline.h"
>  #include "string2.h"
>  #include "units.h"
> @@ -2505,6 +2506,32 @@ add_annotate_opt(struct hist_browser *browser __maybe_unused,
>  	return 1;
>  }
>  
> +static int
> +do_annotate_type(struct hist_browser *browser, struct popup_action *act)
> +{
> +	struct hist_entry *he = browser->he_selection;
> +
> +	hist_entry__annotate_data_tui(he, act->evsel, browser->hbt);
> +	ui_browser__handle_resize(&browser->b);
> +	return 0;
> +}
> +
> +static int
> +add_annotate_type_opt(struct hist_browser *browser,
> +		      struct popup_action *act, char **optstr,
> +		      struct hist_entry *he)
> +{
> +	if (he == NULL || he->mem_type == NULL || he->mem_type->histograms == NULL)
> +		return 0;
> +
> +	if (asprintf(optstr, "Annotate type %s", he->mem_type->self.type_name) < 0)
> +		return 0;
> +
> +	act->evsel = hists_to_evsel(browser->hists);
> +	act->fn = do_annotate_type;
> +	return 1;
> +}
> +
>  static int
>  do_zoom_thread(struct hist_browser *browser, struct popup_action *act)
>  {
> @@ -3307,6 +3334,10 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
>  						       browser->he_selection->ip);
>  		}
>  skip_annotation:
> +		nr_options += add_annotate_type_opt(browser,
> +						    &actions[nr_options],
> +						    &options[nr_options],
> +						    browser->he_selection);
>  		nr_options += add_thread_opt(browser, &actions[nr_options],
>  					     &options[nr_options], thread);
>  		nr_options += add_dso_opt(browser, &actions[nr_options],
> -- 
> 2.44.0.478.gd926399ef9-goog

