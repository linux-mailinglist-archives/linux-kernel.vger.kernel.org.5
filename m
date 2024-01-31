Return-Path: <linux-kernel+bounces-46154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02431843B50
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350F21C245FA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61A56994F;
	Wed, 31 Jan 2024 09:42:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339756994C;
	Wed, 31 Jan 2024 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694159; cv=none; b=XpTBihI6AVp6F8W+uud8FlStHkKRFd0vHTXfK484Oiyfkk4NcSwZM6MgghLevQLTAcowsBOWveIOidxeLLQyYbctV6DM716dudgwzMsgwHFZHjIPptKymtUFWTkbbpecZMEvUY4ctpPJLSZxDa1aH7mUOpjrv5hn2Zna2n1E8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694159; c=relaxed/simple;
	bh=/jxUhiLW2aIZc2umOiEd/PmyEOR+s6ajMKSA4LwywJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=EvOqbkh10YTLkvpdmDz3cShPl39JK2/Q4MyQIEpp+Or6Ycx3cLV1AtC/iK5yndjecYFlcu9qBmn9NoN8f/1XC38b2m9IAkBc73Ef1jHhMMt3NBE3jQ5doCe7OlC+qeQnZEyf4oBi3xyawVYO3bdXhRxkLYJnGTSF6JqO6uQMDtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6053DA7;
	Wed, 31 Jan 2024 01:43:18 -0800 (PST)
Received: from [192.168.1.216] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 736AC3F738;
	Wed, 31 Jan 2024 01:42:32 -0800 (PST)
Message-ID: <4b69537a-db1c-5940-b096-04eb818f2ca8@arm.com>
Date: Wed, 31 Jan 2024 09:42:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/2] perf tsc: Add missing newlines to debug statements
To: Ian Rogers <irogers@google.com>
References: <20240131063048.492010-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, tchen168@asu.edu,
 Michael Petlan <mpetlan@redhat.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240131063048.492010-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31/01/2024 06:30, Ian Rogers wrote:
> It is assumed that debug statements always print a newline, fix two
> missing ones.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> This patch was inspired by bad debug output in:
> https://lore.kernel.org/linux-perf-users/CAGjhMsg_bVKJ_zfsLUR32+oZwGDr3OiBHV_BJ3QtFjyKAs7Sgg@mail.gmail.com/
> ---
>  tools/perf/arch/x86/util/tsc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
> index 9b99f48b923c..e2d6cfe21057 100644
> --- a/tools/perf/arch/x86/util/tsc.c
> +++ b/tools/perf/arch/x86/util/tsc.c
> @@ -33,7 +33,7 @@ static double cpuinfo_tsc_freq(void)
>  
>  	cpuinfo = fopen("/proc/cpuinfo", "r");
>  	if (!cpuinfo) {
> -		pr_err("Failed to read /proc/cpuinfo for TSC frequency");
> +		pr_err("Failed to read /proc/cpuinfo for TSC frequency\n");
>  		return NAN;
>  	}
>  	while (getline(&line, &len, cpuinfo) > 0) {
> @@ -48,7 +48,7 @@ static double cpuinfo_tsc_freq(void)
>  	}
>  out:
>  	if (fpclassify(result) == FP_ZERO)
> -		pr_err("Failed to find TSC frequency in /proc/cpuinfo");
> +		pr_err("Failed to find TSC frequency in /proc/cpuinfo\n");
>  
>  	free(line);
>  	fclose(cpuinfo);


Reviewed-by: James Clark <james.clark@arm.com>

