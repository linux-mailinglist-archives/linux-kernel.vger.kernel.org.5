Return-Path: <linux-kernel+bounces-79463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB090862296
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 05:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69638285747
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 04:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7388514AA9;
	Sat, 24 Feb 2024 04:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrW/X6P9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879A12E51;
	Sat, 24 Feb 2024 04:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708748146; cv=none; b=m/UMa85zbxbZlYGn6xd3y/KFI1twOLiw47M1G8F/Cf2P7rBH/1MQVwOQxqwQWEfB+NNGlk13CtqRecsZOP99f+6lnUzF4Oa6SzgSEw3jgZmB+pZE63Y3UZZSKHfUJm9ftnfuS2W+laqzY5vvOwm7OGQPAAbOmuk0cBRLBZPx9RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708748146; c=relaxed/simple;
	bh=Y1QHX51XD00kV5oc4mKEfXtZpXu11m0GfYW/q0nli28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luq48E6EEnkDPyeKm2mBxjjLJtoX+Tta6HsSUi9Ix7EfR2m0F387UVivJ1lCDjKjOVVcTueCfBAM8hOP4J+vGoYyvYXJUbbZgvTi5FLJnRQTDiFMGqmDpsqEsqQ9PGBUu9ApQzwkd+UukyGaeL22qaYtMygOO9ESgrKpS50Mp7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrW/X6P9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2109C433C7;
	Sat, 24 Feb 2024 04:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708748145;
	bh=Y1QHX51XD00kV5oc4mKEfXtZpXu11m0GfYW/q0nli28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrW/X6P9cy1P94wJNK9yiOk7VMZJucfVbOvymRcirzT0mTM5xnrFHHn6DH+2gVN+x
	 J9IBr0xlvmaK0KTQjtZsDag0A3an0QTAfdZtPCDcaHQKGJ0G27Sq3ElT8LXjNlcN/K
	 Nf4AkRRcNnvP5g8QmoJw55QwjjKr8NZPXrhC2iNCseM6XfmNxI67/gQRu6KYu9/KSr
	 /UrHpi/cY/jhCpb7DUpXFS/51PIf4ixGisfiO/DSzPnMG4EFu6X0+Xw8uNVcXeM+1z
	 OZP1i7DR7j19lAU0I9u2MrhbYtpYnwTP174vISnubdATWTvyOk79tYgYhSrqGT/uad
	 uuLR5UxxgXm2A==
Date: Fri, 23 Feb 2024 20:15:45 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] time_stats: report information in json format
Message-ID: <20240224041545.GC616564@frogsfrogsfrogs>
References: <170873667916.1860949.11027844260383646446.stgit@frogsfrogsfrogs>
 <170873668085.1860949.11659237532415596101.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170873668085.1860949.11659237532415596101.stgit@frogsfrogsfrogs>

On Fri, Feb 23, 2024 at 05:12:26PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Export json versions of time statistics information.  Given the tabular
> nature of the numbers exposed, this will make it a lot easier for higher
> (than C) level languages (e.g. python) to import information without
> needing to write yet another clumsy string parser.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  include/linux/time_stats.h |    2 +
>  lib/time_stats.c           |   87 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
> 
> 
> diff --git a/include/linux/time_stats.h b/include/linux/time_stats.h
> index b3c810fff963a..4e1f5485ed039 100644
> --- a/include/linux/time_stats.h
> +++ b/include/linux/time_stats.h
> @@ -156,6 +156,8 @@ static inline bool track_event_change(struct time_stats *stats, bool v)
>  struct seq_buf;
>  void time_stats_to_seq_buf(struct seq_buf *, struct time_stats *,
>  		const char *epoch_name, unsigned int flags);
> +void time_stats_to_json(struct seq_buf *, struct time_stats *,
> +		const char *epoch_name, unsigned int flags);
>  
>  void time_stats_exit(struct time_stats *);
>  void time_stats_init(struct time_stats *);
> diff --git a/lib/time_stats.c b/lib/time_stats.c
> index 0fb3d854e503b..c0f209dd9f6dd 100644
> --- a/lib/time_stats.c
> +++ b/lib/time_stats.c
> @@ -266,6 +266,93 @@ void time_stats_to_seq_buf(struct seq_buf *out, struct time_stats *stats,
>  }
>  EXPORT_SYMBOL_GPL(time_stats_to_seq_buf);
>  
> +void time_stats_to_json(struct seq_buf *out, struct time_stats *stats,
> +		const char *epoch_name, unsigned int flags)
> +{
> +	struct quantiles *quantiles = time_stats_to_quantiles(stats);
> +	s64 f_mean = 0, d_mean = 0;
> +	u64 f_stddev = 0, d_stddev = 0;
> +
> +	if (stats->buffer) {
> +		int cpu;
> +
> +		spin_lock_irq(&stats->lock);
> +		for_each_possible_cpu(cpu)
> +			__time_stats_clear_buffer(stats, per_cpu_ptr(stats->buffer, cpu));
> +		spin_unlock_irq(&stats->lock);
> +	}
> +
> +	if (stats->freq_stats.n) {
> +		/* avoid divide by zero */
> +		f_mean = mean_and_variance_get_mean(stats->freq_stats);
> +		f_stddev = mean_and_variance_get_stddev(stats->freq_stats);
> +		d_mean = mean_and_variance_get_mean(stats->duration_stats);
> +		d_stddev = mean_and_variance_get_stddev(stats->duration_stats);
> +	} else if (flags & TIME_STATS_PRINT_NO_ZEROES) {
> +		/* unless we didn't want zeroes anyway */
> +		return;
> +	}
> +
> +	seq_buf_printf(out, "{\n");
> +	seq_buf_printf(out, "  \"epoch\":       \"%s\",\n", epoch_name);
> +	seq_buf_printf(out, "  \"count\":       %llu,\n", stats->duration_stats.n);
> +
> +	seq_buf_printf(out, "  \"duration_ns\": {\n");
> +	seq_buf_printf(out, "    \"min\":       %llu,\n", stats->min_duration);
> +	seq_buf_printf(out, "    \"max\":       %llu,\n", stats->max_duration);
> +	seq_buf_printf(out, "    \"total\":     %llu,\n", stats->total_duration);
> +	seq_buf_printf(out, "    \"mean\":      %llu,\n", d_mean);
> +	seq_buf_printf(out, "    \"stddev\":    %llu\n", d_stddev);
> +	seq_buf_printf(out, "  },\n");
> +
> +	d_mean = mean_and_variance_weighted_get_mean(stats->duration_stats_weighted, TIME_STATS_MV_WEIGHT);
> +	d_stddev = mean_and_variance_weighted_get_stddev(stats->duration_stats_weighted, TIME_STATS_MV_WEIGHT);
> +
> +	seq_buf_printf(out, "  \"duration_ewma_ns\": {\n");
> +	seq_buf_printf(out, "    \"mean\":      %llu,\n", d_mean);
> +	seq_buf_printf(out, "    \"stddev\":    %llu\n", d_stddev);
> +	seq_buf_printf(out, "  },\n");
> +
> +	seq_buf_printf(out, "  \"frequency_ns\": {\n");

I took the variable names too literally here; these labels really ought
to be "between_ns" and "between_ewma_ns" to maintain consistency with
the labels in the table format.

> +	seq_buf_printf(out, "    \"min\":       %llu,\n", stats->min_freq);
> +	seq_buf_printf(out, "    \"max\":       %llu,\n", stats->max_freq);
> +	seq_buf_printf(out, "    \"mean\":      %llu,\n", f_mean);
> +	seq_buf_printf(out, "    \"stddev\":    %llu\n", f_stddev);
> +	seq_buf_printf(out, "  },\n");
> +
> +	f_mean = mean_and_variance_weighted_get_mean(stats->freq_stats_weighted, TIME_STATS_MV_WEIGHT);
> +	f_stddev = mean_and_variance_weighted_get_stddev(stats->freq_stats_weighted, TIME_STATS_MV_WEIGHT);
> +
> +	seq_buf_printf(out, "  \"frequency_ewma_ns\": {\n");
> +	seq_buf_printf(out, "    \"mean\":      %llu,\n", f_mean);
> +	seq_buf_printf(out, "    \"stddev\":    %llu\n", f_stddev);
> +
> +	if (quantiles) {
> +		u64 last_q = 0;
> +
> +		/* close frequency_ewma_ns but signal more items */

(also this comment)

> +		seq_buf_printf(out, "  },\n");
> +
> +		seq_buf_printf(out, "  \"quantiles_ns\": [\n");
> +		eytzinger0_for_each(i, NR_QUANTILES) {
> +			bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
> +
> +			u64 q = max(quantiles->entries[i].m, last_q);
> +			seq_buf_printf(out, "    %llu", q);
> +			if (!is_last)
> +				seq_buf_printf(out, ", ");
> +			last_q = q;
> +		}
> +		seq_buf_printf(out, "  ]\n");
> +	} else {
> +		/* close frequency_ewma_ns without dumping further */

(this one too)

Kent, would you mind making that edit the next time you reflow your
branch?

--D

> +		seq_buf_printf(out, "  }\n");
> +	}
> +
> +	seq_buf_printf(out, "}\n");
> +}
> +EXPORT_SYMBOL_GPL(time_stats_to_json);
> +
>  void time_stats_exit(struct time_stats *stats)
>  {
>  	free_percpu(stats->buffer);
> 
> 

