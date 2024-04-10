Return-Path: <linux-kernel+bounces-139304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F16C8A012E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B290A1C2284F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E8E18133A;
	Wed, 10 Apr 2024 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKaqfThl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D751E877;
	Wed, 10 Apr 2024 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780464; cv=none; b=JF6F6gnS8YvNeswz7zbEo3vXSvDONiA1PfrZyWZvIZRy8j27Qvr0bnPOrHoZr+65tVkYzhxjvDqCm9eZf083SK30y0YklwaT28wkW+DEXDO3Aj38wAmz9F6LLyXTAGeJIa7Nk117oWEJOS9FGoz5NXjkZF9aZDt8CtvZAHkbkxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780464; c=relaxed/simple;
	bh=nwj/ym2BMb/ls5M/c2QwWdyrTcQXD+wxxpng485Us40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPf1JfwopvUBJnvtjLuZvHmTh/Ul5AZEYbOqmqt58Ja43jOzP2sF8sEGyjJUOlHoxF/uwIRvrrgZ7rQWh84BAk2fXMqL1yvXp2yV28NISQJh1uNHBmP/Wvo/l989Rj1qgUYXxa0Dfmo1S0Zy1837zsPhUHy2G9q2md5nMbzphBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKaqfThl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EE1C433C7;
	Wed, 10 Apr 2024 20:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712780464;
	bh=nwj/ym2BMb/ls5M/c2QwWdyrTcQXD+wxxpng485Us40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aKaqfThlAWGOcFBS000v8BhmfUly6R4SDLGf6MW/M1NmemrRf9zQTHpnR4J7h8Hsp
	 kiHWAX8zLatMUdpdSJAqYlRx1xQILXxrII3TwABagq/JXrHg63Wxu1JtGJ2bY0jP2g
	 COjvxSrzeObglnOanP7R3W+QrSwT+brPQje9CrS1MVRCCSxBaM29Lzt5fs4914R9e1
	 FPwM7QWzOSsOilzATyA7F+QIzQLmC1KDIJrSTrD20fWgLS1gHGcyVRe2ENwLjr3wp6
	 vO6MNOsGb7grHLxPy3B7Czb3ktQXwrhVURR48LK3867RFb7oiDUTN04WAF0vD4bn51
	 Y6P+KBOTcppgA==
Date: Wed, 10 Apr 2024 17:21:01 -0300
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
Message-ID: <Zhb0raj1yW8JhuFW@x1>
References: <20240409235000.1893969-1-namhyung@kernel.org>
 <20240409235000.1893969-4-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409235000.1893969-4-namhyung@kernel.org>

On Tue, Apr 09, 2024 at 04:49:57PM -0700, Namhyung Kim wrote:
> Support data type profiling output on TUI.

Added the follow to the commit log message, to make reviewing easier.

As followup patches I think having the DSO name together with the type
is important, also I think we could have a first menu with all the pairs
of DSO/type, sorted top down by the types with most samples, wdyt?

Applied.

- Arnaldo

Committer testing:

First make sure that the debug information for your workload binaries
in embedded in them by building it with '-g' or install the debuginfo
packages, since our workload is 'find':

  root@number:~# type find
  find is hashed (/usr/bin/find)
  root@number:~# rpm -qf /usr/bin/find
  findutils-4.9.0-5.fc39.x86_64
  root@number:~# dnf debuginfo-install findutils
  <SNIP>
  root@number:~#

Then collect some data:

  root@number:~# echo 1 > /proc/sys/vm/drop_caches
  root@number:~# perf mem record find / > /dev/null
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.331 MB perf.data (3982 samples) ]
  root@number:~#

Finally do data-type annotation with the following command, that will
default, as 'perf report' to the --tui mode, with lines colored to
highlight the hotspots, etc.

  root@number:~# perf annotate --data-type
  Annotate type: 'struct predicate' (58 samples)
      Percent     Offset       Size  Field annotate --data-type
       100.00          0        312  struct predicate {
         0.00          0          8      PRED_FUNC        pred_func;
         0.00          8          8      char*    p_name;
         0.00         16          4      enum predicate_type      p_type;
         0.00         20          4      enum predicate_precedence        p_prec;
         0.00         24          1      _Bool    side_effects;
         0.00         25          1      _Bool    no_default_print;
         0.00         26          1      _Bool    need_stat;
         0.00         27          1      _Bool    need_type;
         0.00         28          1      _Bool    need_inum;
         0.00         32          4      enum EvaluationCost      p_cost;
         0.00         36          4      float    est_success_rate;
         0.00         40          1      _Bool    literal_control_chars;
         0.00         41          1      _Bool    artificial;
         0.00         48          8      char*    arg_text;
  <SNIP>

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-annotate.c          |  30 ++-
>  tools/perf/ui/browsers/Build           |   1 +
>  tools/perf/ui/browsers/annotate-data.c | 282 +++++++++++++++++++++++++
>  tools/perf/util/annotate-data.c        |   5 +-
>  tools/perf/util/annotate-data.h        |   5 +-
>  5 files changed, 317 insertions(+), 6 deletions(-)
>  create mode 100644 tools/perf/ui/browsers/annotate-data.c
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 0812664faa54..6f7104f06c42 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -469,8 +469,32 @@ static void hists__find_annotations(struct hists *hists,
>  					goto find_next;
>  			}
>  
> -			hist_entry__annotate_data_tty(he, evsel);
> -			goto find_next;
> +			if (use_browser == 1)
> +				key = hist_entry__annotate_data_tui(he, evsel, NULL);
> +			else
> +				key = hist_entry__annotate_data_tty(he, evsel);
> +
> +			switch (key) {
> +			case -1:
> +				if (!ann->skip_missing)
> +					return;
> +				/* fall through */
> +			case K_RIGHT:
> +			case '>':
> +				next = rb_next(nd);
> +				break;
> +			case K_LEFT:
> +			case '<':
> +				next = rb_prev(nd);
> +				break;
> +			default:
> +				return;
> +			}
> +
> +			if (next != NULL)
> +				nd = next;
> +
> +			continue;
>  		}
>  
>  		if (use_browser == 2) {
> @@ -873,9 +897,7 @@ int cmd_annotate(int argc, const char **argv)
>  		use_browser = 2;
>  #endif
>  
> -	/* FIXME: only support stdio for now */
>  	if (annotate.data_type) {
> -		use_browser = 0;
>  		annotate_opts.annotate_src = false;
>  		symbol_conf.annotate_data_member = true;
>  		symbol_conf.annotate_data_sample = true;
> diff --git a/tools/perf/ui/browsers/Build b/tools/perf/ui/browsers/Build
> index 7a1d5ddaf688..2608b5da3167 100644
> --- a/tools/perf/ui/browsers/Build
> +++ b/tools/perf/ui/browsers/Build
> @@ -1,4 +1,5 @@
>  perf-y += annotate.o
> +perf-y += annotate-data.o
>  perf-y += hists.o
>  perf-y += map.o
>  perf-y += scripts.o
> diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
> new file mode 100644
> index 000000000000..fefacaaf16db
> --- /dev/null
> +++ b/tools/perf/ui/browsers/annotate-data.c
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <inttypes.h>
> +#include <string.h>
> +#include <sys/ttydefaults.h>
> +
> +#include "ui/browser.h"
> +#include "ui/helpline.h"
> +#include "ui/keysyms.h"
> +#include "ui/ui.h"
> +#include "util/annotate.h"
> +#include "util/annotate-data.h"
> +#include "util/evsel.h"
> +#include "util/sort.h"
> +
> +struct annotated_data_browser {
> +	struct ui_browser b;
> +	struct list_head entries;
> +};
> +
> +struct browser_entry {
> +	struct list_head node;
> +	struct annotated_member *data;
> +	struct type_hist_entry hists;
> +	int indent;
> +};
> +
> +static void update_hist_entry(struct type_hist_entry *dst,
> +			      struct type_hist_entry *src)
> +{
> +	dst->nr_samples += src->nr_samples;
> +	dst->period += src->period;
> +}
> +
> +static int get_member_overhead(struct annotated_data_type *adt,
> +			       struct browser_entry *entry,
> +			       struct evsel *evsel)
> +{
> +	struct annotated_member *member = entry->data;
> +	int i;
> +
> +	for (i = 0; i < member->size; i++) {
> +		struct type_hist *h;
> +		int offset = member->offset + i;
> +
> +		h = adt->histograms[evsel->core.idx];
> +		update_hist_entry(&entry->hists, &h->addr[offset]);
> +	}
> +	return 0;
> +}
> +
> +static int add_child_entries(struct annotated_data_browser *browser,
> +			     struct annotated_data_type *adt,
> +			     struct annotated_member *member,
> +			     struct evsel *evsel, int indent)
> +{
> +	struct annotated_member *pos;
> +	struct browser_entry *entry;
> +	int nr_entries = 0;
> +
> +	entry = zalloc(sizeof(*entry));
> +	if (entry == NULL)
> +		return -1;
> +
> +	entry->data = member;
> +	entry->indent = indent;
> +	if (get_member_overhead(adt, entry, evsel) < 0) {
> +		free(entry);
> +		return -1;
> +	}
> +
> +	list_add_tail(&entry->node, &browser->entries);
> +	nr_entries++;
> +
> +	list_for_each_entry(pos, &member->children, node) {
> +		int nr = add_child_entries(browser, adt, pos, evsel, indent + 1);
> +
> +		if (nr < 0)
> +			return nr;
> +
> +		nr_entries += nr;
> +	}
> +
> +	/* add an entry for the closing bracket ("}") */
> +	if (!list_empty(&member->children)) {
> +		entry = zalloc(sizeof(*entry));
> +		if (entry == NULL)
> +			return -1;
> +
> +		entry->indent = indent;
> +		list_add_tail(&entry->node, &browser->entries);
> +		nr_entries++;
> +	}
> +
> +	return nr_entries;
> +}
> +
> +static int annotated_data_browser__collect_entries(struct annotated_data_browser *browser)
> +{
> +	struct hist_entry *he = browser->b.priv;
> +	struct annotated_data_type *adt = he->mem_type;
> +	struct evsel *evsel = hists_to_evsel(he->hists);
> +
> +	INIT_LIST_HEAD(&browser->entries);
> +	browser->b.entries = &browser->entries;
> +	browser->b.nr_entries = add_child_entries(browser, adt, &adt->self,
> +						  evsel, /*indent=*/0);
> +	return 0;
> +}
> +
> +static void annotated_data_browser__delete_entries(struct annotated_data_browser *browser)
> +{
> +	struct browser_entry *pos, *tmp;
> +
> +	list_for_each_entry_safe(pos, tmp, &browser->entries, node) {
> +		list_del_init(&pos->node);
> +		free(pos);
> +	}
> +}
> +
> +static unsigned int browser__refresh(struct ui_browser *uib)
> +{
> +	return ui_browser__list_head_refresh(uib);
> +}
> +
> +static int browser__show(struct ui_browser *uib)
> +{
> +	struct hist_entry *he = uib->priv;
> +	struct annotated_data_type *adt = he->mem_type;
> +	const char *help = "Press 'h' for help on key bindings";
> +	char title[256];
> +
> +	snprintf(title, sizeof(title), "Annotate type: '%s' (%d samples)",
> +		 adt->self.type_name, he->stat.nr_events);
> +
> +	if (ui_browser__show(uib, title, help) < 0)
> +		return -1;
> +
> +	/* second line header */
> +	ui_browser__gotorc_title(uib, 0, 0);
> +	ui_browser__set_color(uib, HE_COLORSET_ROOT);
> +
> +	if (symbol_conf.show_total_period)
> +		strcpy(title, "Period");
> +	else if (symbol_conf.show_nr_samples)
> +		strcpy(title, "Samples");
> +	else
> +		strcpy(title, "Percent");
> +
> +	ui_browser__printf(uib, " %10s %10s %10s  %s",
> +			   title, "Offset", "Size", "Field");
> +	ui_browser__write_nstring(uib, "", uib->width);
> +	return 0;
> +}
> +
> +static void browser__write_overhead(struct ui_browser *uib,
> +				    struct type_hist *total,
> +				    struct type_hist_entry *hist, int row)
> +{
> +	u64 period = hist->period;
> +	double percent = total->period ? (100.0 * period / total->period) : 0;
> +	bool current = ui_browser__is_current_entry(uib, row);
> +	int nr_samples = 0;
> +
> +	ui_browser__set_percent_color(uib, percent, current);
> +
> +	if (symbol_conf.show_total_period)
> +		ui_browser__printf(uib, " %10" PRIu64, period);
> +	else if (symbol_conf.show_nr_samples)
> +		ui_browser__printf(uib, " %10d", nr_samples);
> +	else
> +		ui_browser__printf(uib, " %10.2f", percent);
> +
> +	ui_browser__set_percent_color(uib, 0, current);
> +}
> +
> +static void browser__write(struct ui_browser *uib, void *entry, int row)
> +{
> +	struct browser_entry *be = entry;
> +	struct annotated_member *member = be->data;
> +	struct hist_entry *he = uib->priv;
> +	struct annotated_data_type *adt = he->mem_type;
> +	struct evsel *evsel = hists_to_evsel(he->hists);
> +
> +	if (member == NULL) {
> +		bool current = ui_browser__is_current_entry(uib, row);
> +
> +		/* print the closing bracket */
> +		ui_browser__set_percent_color(uib, 0, current);
> +		ui_browser__write_nstring(uib, "", 11);
> +		ui_browser__printf(uib, " %10s %10s  %*s};",
> +				   "", "", be->indent * 4, "");
> +		ui_browser__write_nstring(uib, "", uib->width);
> +		return;
> +	}
> +
> +	/* print the number */
> +	browser__write_overhead(uib, adt->histograms[evsel->core.idx],
> +				&be->hists, row);
> +
> +	/* print type info */
> +	if (be->indent == 0 && !member->var_name) {
> +		ui_browser__printf(uib, " %10d %10d  %s%s",
> +				   member->offset, member->size,
> +				   member->type_name,
> +				   list_empty(&member->children) ? ";" : " {");
> +	} else {
> +		ui_browser__printf(uib, " %10d %10d  %*s%s\t%s%s",
> +				   member->offset, member->size,
> +				   be->indent * 4, "", member->type_name,
> +				   member->var_name ?: "",
> +				   list_empty(&member->children) ? ";" : " {");
> +	}
> +	/* fill the rest */
> +	ui_browser__write_nstring(uib, "", uib->width);
> +}
> +
> +static int annotated_data_browser__run(struct annotated_data_browser *browser,
> +				       struct evsel *evsel __maybe_unused,
> +				       struct hist_browser_timer *hbt)
> +{
> +	int delay_secs = hbt ? hbt->refresh : 0;
> +	int key;
> +
> +	if (browser__show(&browser->b) < 0)
> +		return -1;
> +
> +	while (1) {
> +		key = ui_browser__run(&browser->b, delay_secs);
> +
> +		switch (key) {
> +		case K_TIMER:
> +			if (hbt)
> +				hbt->timer(hbt->arg);
> +			continue;
> +		case K_F1:
> +		case 'h':
> +			ui_browser__help_window(&browser->b,
> +		"UP/DOWN/PGUP\n"
> +		"PGDN/SPACE    Navigate\n"
> +		"</>           Move to prev/next symbol\n"
> +		"q/ESC/CTRL+C  Exit\n\n");
> +			continue;
> +		case K_LEFT:
> +		case '<':
> +		case '>':
> +		case K_ESC:
> +		case 'q':
> +		case CTRL('c'):
> +			goto out;
> +		default:
> +			continue;
> +		}
> +	}
> +out:
> +	ui_browser__hide(&browser->b);
> +	return key;
> +}
> +
> +int hist_entry__annotate_data_tui(struct hist_entry *he, struct evsel *evsel,
> +				  struct hist_browser_timer *hbt)
> +{
> +	struct annotated_data_browser browser = {
> +		.b = {
> +			.refresh = browser__refresh,
> +			.seek	 = ui_browser__list_head_seek,
> +			.write	 = browser__write,
> +			.priv	 = he,
> +			.extra_title_lines = 1,
> +		},
> +	};
> +	int ret;
> +
> +	ui_helpline__push("Press ESC to exit");
> +
> +	ret = annotated_data_browser__collect_entries(&browser);
> +	if (ret == 0)
> +		ret = annotated_data_browser__run(&browser, evsel, hbt);
> +
> +	annotated_data_browser__delete_entries(&browser);
> +
> +	return ret;
> +}
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 99c5dcdfc9df..1cd857400038 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1814,9 +1814,12 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
>  	printf(";\n");
>  }
>  
> -void hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel)
> +int hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel)
>  {
>  	print_annotated_data_header(he, evsel);
>  	print_annotated_data_type(he->mem_type, &he->mem_type->self, evsel, 0);
>  	printf("\n");
> +
> +	/* move to the next entry */
> +	return '>';
>  }
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index 037e2622b7a3..9a6d9b519724 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -11,6 +11,7 @@ struct annotated_op_loc;
>  struct debuginfo;
>  struct evsel;
>  struct hist_entry;
> +struct hist_browser_timer;
>  struct map_symbol;
>  struct thread;
>  
> @@ -141,7 +142,9 @@ struct annotated_data_stat {
>  };
>  extern struct annotated_data_stat ann_data_stat;
>  
> -void hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel);
> +int hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel);
> +int hist_entry__annotate_data_tui(struct hist_entry *he, struct evsel *evsel,
> +				  struct hist_browser_timer *hbt);
>  
>  #ifdef HAVE_DWARF_SUPPORT
>  
> -- 
> 2.44.0.478.gd926399ef9-goog
> 

