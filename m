Return-Path: <linux-kernel+bounces-158702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0848B2412
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90AF3B27AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB3714C595;
	Thu, 25 Apr 2024 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzsyKvTm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1F814A60A;
	Thu, 25 Apr 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054873; cv=none; b=U1bBJqyGwwpzc+whK/z2vyqHmToB+OdEdAHY0o80wLMO6VKD4GH8V63GEp1RgUc6CH4vJvv4A+/P0pRvZwVCZJlBGJpCcvNpw/xTirRXt+6SaZq5PL7ZyApPVomILSLXD0w7DI4bna/3iMDNw+fdrP/fsFEZlx6iGXjkfQkN9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054873; c=relaxed/simple;
	bh=v4Zk7cp/J5uIKp7aMsO/8WP6RRDSuoxJeMH6/h7FcWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AN7kKE9FqnjhwuWI2n4wiZke7ePrA9boDswMhuxLQ5qy1d0FCudtA4bCvckncRwaP28REfiP6WWS7400O7rEkEtX9jL7Ua6+yMLwfnUnRKoDBWaiyhpGwgG4EuJy2huS9z2CY5oOZOCOUJdGGaofURNrdPnAU+ph3vtqJTzHoi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzsyKvTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2B7C113CC;
	Thu, 25 Apr 2024 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714054873;
	bh=v4Zk7cp/J5uIKp7aMsO/8WP6RRDSuoxJeMH6/h7FcWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WzsyKvTmHwPQzRlLAIOkKY29XYfiuW/0qDmhR8I4Mabf9LqT3YFvdap7/N2MahDR1
	 cu1zEjG4WYBnhI+9lZB6DK+immNjkaccNBjPaa7sBioyGFiNL608Y/Val2+iGqVCGv
	 lx6c1ehaupDIloP7UiPjyAYj/91Xa+TIDINqisfIMJZH87KDRHRC357hStg7BdV8dL
	 +M1dhojEpD9+jPTtZU8PhCHiPrAwUm4vV6pDeFqRZ6yDvzo9AMxcVdDDNVlNOTedg2
	 8Np9c/oh0OAwXKfgMDNkhLfjN1U1YJeF5ik7ZcukktsPAvhsDZdiNfbown3+H3D27F
	 v4R9Hb3TtPC9w==
Date: Thu, 25 Apr 2024 11:21:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] perf record: Fix comment misspellings
Message-ID: <Zipm1B6qZ1NFANAc@x1>
References: <20240425060427.1800663-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425060427.1800663-1-howardchu95@gmail.com>

On Thu, Apr 25, 2024 at 02:04:27PM +0800, Howard Chu wrote:
> Fix comment misspellings

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/lib/perf/mmap.c       | 2 +-
>  tools/perf/builtin-record.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index 0c903c2372c9..c1a51d925e0e 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -279,7 +279,7 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map)
>  	if (!refcount_read(&map->refcnt))
>  		return NULL;
>  
> -	/* non-overwirte doesn't pause the ringbuffer */
> +	/* non-overwrite doesn't pause the ringbuffer */
>  	if (!map->overwrite)
>  		map->end = perf_mmap__read_head(map);
>  
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 3994adaf4607..34d103f4af57 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -332,7 +332,7 @@ static int record__aio_complete(struct mmap *md, struct aiocb *cblock)
>  	} else {
>  		/*
>  		 * aio write request may require restart with the
> -		 * reminder if the kernel didn't write whole
> +		 * remainder if the kernel didn't write whole
>  		 * chunk at once.
>  		 */
>  		rem_off = cblock->aio_offset + written;
> @@ -402,7 +402,7 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
>  	 *
>  	 * Coping can be done in two steps in case the chunk of profiling data
>  	 * crosses the upper bound of the kernel buffer. In this case we first move
> -	 * part of data from map->start till the upper bound and then the reminder
> +	 * part of data from map->start till the upper bound and then the remainder
>  	 * from the beginning of the kernel buffer till the end of the data chunk.
>  	 */
>  
> -- 
> 2.44.0

