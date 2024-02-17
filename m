Return-Path: <linux-kernel+bounces-69521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D90858A81
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D89B1C20BED
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E7F46AF;
	Sat, 17 Feb 2024 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdwPVcgb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6351F802;
	Sat, 17 Feb 2024 00:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708128420; cv=none; b=dmEAqcFZ6Qdq7LZNFFHefPLbZr/0DwYCoe3HCCupoT9djHGRWccyahudvgaDvUav0rHiYEF7zRY8nrJVkJ50b0Fno7sCZXyKErl60OvO3WT1MTsz3/3EiOMpLu+A2bt3AkmLkXe1r5lyDUKbinGD3uUzh6hl38D4cktdNn0vmAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708128420; c=relaxed/simple;
	bh=Obu3eb9mb41tU7o19CjGNQFxpVIGGPXO9igJxp99SbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frQ7seiuM4KrNxmJIAdYjsYB+LwhQG5Kt66sEj/NTLIl5hbnfuznLJFvRY2gr9kBUTzjwzOLJB/KKgAJRUTEgS74inhRpjDlPMsIFZXfJX5IzfvNNM9JL6a4J8cH8lDHZfoVwyQW7q7vKbiMNwXZWbTElEgzownG1P8n6K/CwjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdwPVcgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D67C433C7;
	Sat, 17 Feb 2024 00:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708128419;
	bh=Obu3eb9mb41tU7o19CjGNQFxpVIGGPXO9igJxp99SbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdwPVcgbE+Ufqw7cOjRjwy89sg2yYzpiCi1TSamCG3YKnazcBltY5MjPXIIDMmwtn
	 i1QkLKPUq3zu75Ckdw16oyDWM+vNLnlRUfXVJTlNd9p/dFo85VvVrZpMon9WFo5nZQ
	 oVD1MUZ+NTl3tOFlKSPhejpCvdH3OdK5BaNwsznpjEk/xFbi4/BmceN4dEszWB4kWJ
	 m8MovT0xYT036VIHi8T6UQcMndzlaMVpQxP4dObHz8ACZlriHTHujEBvQcjItNpzT7
	 fYlEMoequeJwKEDfnT+8sNSL3pwt+T7BYxwQhBdZuKT+kKigTUd37dJWlnnhy8w2QI
	 k4uQ86KDvQtbw==
Date: Fri, 16 Feb 2024 16:06:58 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf list: For metricgroup only list include
 description
Message-ID: <Zc_4orTDBzUC6cMM@google.com>
References: <20240216192044.119897-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240216192044.119897-1-irogers@google.com>

On Fri, Feb 16, 2024 at 11:20:44AM -0800, Ian Rogers wrote:
> If perf list is invoked with 'metricgroups' include the description
> unless it is invoked with flags to exclude it. Make the description of
> metricgroup dumping dependent on the desc flag in print_state as with
> metrics.
> 
> Before:
> ```
> $ perf list metricgroups
> List of pre-defined events (to be used in -e or -M):
> 
> Metric Groups:
> 
> Backend
> Bad
> BadSpec
> ...
> ```
> 
> After:
> ```
> $ perf list metricgroups
> List of pre-defined events (to be used in -e or -M):
> 
> Metric Groups:
> 
> Backend [Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet]
> Bad [Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet]
> BadSpec
> ...
> ```

When I run `perf list` and look at the Metric Groups:

  Metric Groups:
  
  Backend: [Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet]
    tma_core_bound
         [This metric represents fraction of slots where Core non-memory issues were of a bottleneck]
    tma_info_core_ilp
         [Instruction-Level-Parallelism (average number of uops executed when there is execution) per-core]
    tma_info_memory_l2mpki
         [L2 cache true misses per kilo instruction for retired demand loads]
    tma_memory_bound
         [This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck]
  
  Bad: [Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet]
    tma_info_bad_spec_branch_misprediction_cost
         [Branch Misprediction Cost: Fraction of TMA slots wasted per non-speculative branch misprediction (retired JEClear)]
    tma_info_bad_spec_ipmisp_cond_ntaken
         [Instructions per retired mispredicts for conditional non-taken branches (lower number means higher occurrence rate)]
    tma_info_bad_spec_ipmisp_cond_taken
         [Instructions per retired mispredicts for conditional taken branches (lower number means higher occurrence rate)]
    ...
 
So this change aligns with the default behavior, so

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2 rebases on top of perf-tools-next patch:
> 79bacb6ad73c perf list: Add output file option
> https://lore.kernel.org/r/20240124043015.1388867-3-irogers@google.com
> ---
>  tools/perf/builtin-list.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index e27a1b1288c2..02bf608d585e 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -208,17 +208,24 @@ static void default_print_metric(void *ps,
>  	if (!print_state->last_metricgroups ||
>  	    strcmp(print_state->last_metricgroups, group ?: "")) {
>  		if (group && print_state->metricgroups) {
> -			if (print_state->name_only)
> +			if (print_state->name_only) {
>  				fprintf(fp, "%s ", group);
> -			else if (print_state->metrics) {
> -				const char *gdesc = describe_metricgroup(group);
> +			} else {
> +				const char *gdesc = print_state->desc
> +					? describe_metricgroup(group)
> +					: NULL;
> +				const char *print_colon = "";
> +
> +				if (print_state->metrics) {
> +					print_colon = ":";
> +					fputc('\n', fp);
> +				}
>  
>  				if (gdesc)
> -					fprintf(fp, "\n%s: [%s]\n", group, gdesc);
> +					fprintf(fp, "%s%s [%s]\n", group, print_colon, gdesc);
>  				else
> -					fprintf(fp, "\n%s:\n", group);
> -			} else
> -				fprintf(fp, "%s\n", group);
> +					fprintf(fp, "%s%s\n", group, print_colon);
> +			}
>  		}
>  		zfree(&print_state->last_metricgroups);
>  		print_state->last_metricgroups = strdup(group ?: "");
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

