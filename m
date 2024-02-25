Return-Path: <linux-kernel+bounces-80165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81684862B45
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B991F21628
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A6B168DD;
	Sun, 25 Feb 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UWOhwDlb"
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E542215E86
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708875753; cv=none; b=jzs3Fpd/aQQYbP8X/GsjjBMK8+n5iM3zdhNy/92tYS3X0hgyOhmPqGdKti5Kh0DhA3ZBtnzYqTlPUZsG/wiudlPd4ovkEf6pnwE99+A/BePAkGc5V5TxLfzQTZo2601zS7D6MoN43+FpMRl4/MSjaniO27wlV/WCm9Bw2pi3mS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708875753; c=relaxed/simple;
	bh=gsM9a6Mc7KRpO2GMiLUk350/Meg4kzVFv8IZGDNJ0fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPAfuORoH2Mi1pOd5Ir5gi4Wqxm/B1li5PRpvJgjJDxqyTJzU7dodB75oWBbDTazD4zBdzGE9SW6pJVC6UtUreUwNuVJi3dlp2pLNk/aT7FzBZ4IOOZVUPbLXUnczR6shWGp9iYyiEmmO4iVAAjFCzWZvu8Aik+S4I1lPOIuV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UWOhwDlb; arc=none smtp.client-ip=80.12.242.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id eGdsrKKdF2O9zeGdsrr969; Sun, 25 Feb 2024 16:42:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1708875742;
	bh=9e1FNx9pudMReeRV6NQ804WVGDMkcO8ttobtPAafOyU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UWOhwDlbWx7TnTuJvKnzyuzsrX9Qbky0ZpXBCY2f54IMnBPMS2cU/3/QXECRKpBQ+
	 CmZ4jNgMx9qsHVG0Jg/mFV6xbcMT5nrY13JkWA5WPL9D+DTi23QiFqH78rIHymPK/E
	 EjdSoGsXSYF+s46aekLHj4QjmbXwjSITy7gm6jwItsg8NzLCeHy/cFl4hksxZkdC/c
	 JEi1hbEPtmmv12iSpxJJBdN9FOhqY9GoSExA16u7Ss/hXW6ZxrPSx+LGxFN1u83dvB
	 QXZlbCv4z7kWcCg8W2L50rlYBPWkiyP/gDtLJLQEDnILIv+wE9rLRW+Lng74e6xRe+
	 nCZWix0zKqcmQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 25 Feb 2024 16:42:22 +0100
X-ME-IP: 92.140.202.140
Message-ID: <3e1ed5a3-55dc-4652-936d-fd36e0442d79@wanadoo.fr>
Date: Sun, 25 Feb 2024 16:42:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf pmu: Fix a potential memory leak in
 perf_pmu__lookup()
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org
References: <9538b2b634894c33168dfe9d848d4df31fd4d801.1693085544.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <9538b2b634894c33168dfe9d848d4df31fd4d801.1693085544.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 26/08/2023 à 23:32, Christophe JAILLET a écrit :
> The commit in Fixes has reordered some code, but missed an error handling
> path.
> 
> 'goto err' now, in order to avoid a memory leak in case of error.
> 
> Fixes: f63a536f03a2 ("perf pmu: Merge JSON events with sysfs at load time")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Hi,

polite reminder.

CJ


>   tools/perf/util/pmu.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index bb2ca29cd7bd..8dfce84ad9fe 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1018,10 +1018,9 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
>   	 * type value and format definitions. Load both right
>   	 * now.
>   	 */
> -	if (pmu_format(pmu, dirfd, name)) {
> -		free(pmu);
> -		return NULL;
> -	}
> +	if (pmu_format(pmu, dirfd, name))
> +		goto err;
> +
>   	pmu->is_core = is_pmu_core(name);
>   	pmu->cpus = pmu_cpumask(dirfd, name, pmu->is_core);
>   


