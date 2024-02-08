Return-Path: <linux-kernel+bounces-58622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FABC84E8F2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C792D28A100
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6C73770B;
	Thu,  8 Feb 2024 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdmB5ITf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD72149DFF;
	Thu,  8 Feb 2024 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420602; cv=none; b=SWUK+vyapKypuqJkrziJlaH843mW/II1Mybm5PTNB0m7BL5prFPH88PuAkJ9hg2lRyDP55hyImgHXMCVTe6laxkLoFEK1bVmffUqQ032yoW8wFfNbYZG7xMlAb8fas0J/RSZXYlorGdYzwQkdFGjxMEnqFDBosa6CZZZYfPAEdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420602; c=relaxed/simple;
	bh=qDuY1sZc8FECI71ZxaRlmE/Z2fjxukMPw+3Pk8ldjF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FB8mwUE/zzKAtU3zqvIUW2pi+ZPP8KrJhNKjFBugmwWJd823sJDCSIIv7MsluKOy105YozxtrjF4aMYFLS+hEBgb4H6rDsn0H6LFkkIYZ+578/w8fMOcyUVfZPh50PCzAhJD4p/8tGyK1AtP6W2IcDP8ZzfqQ7eA4MhCI0AQgAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdmB5ITf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3423AC433F1;
	Thu,  8 Feb 2024 19:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707420601;
	bh=qDuY1sZc8FECI71ZxaRlmE/Z2fjxukMPw+3Pk8ldjF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FdmB5ITfUKL9YuHuneEFiXbDqF0ncKkuZfoKEbe04ZmtOnPA7+lYwJrmNdvY6hkTM
	 sd000YRvl2/3zRa9WGWwvydHvLIys+xVCMMj0EmP62rs6ami50HJqsoFGA79p59qBl
	 c+jFuMswzmbP3FllHL7EH4oFvO6Us+0Qo3nxzNWs2B5kM2VLIHJcE/3d/MHsrpy72K
	 tefzh6hZ7oLAZN+O8bbI165GFDQ7jQg9+DjH6k6FQvcOk8eYi8ltv0RbTtFq00gtlS
	 7t/vNbNRG0SrXuHTdE7HO1SwOKDnijpCYJENruXbcARfrkCT0qp/ZaLeLNxg1RCMOt
	 QnwxW02HcAF+A==
Date: Thu, 8 Feb 2024 16:29:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf tools: Remove misleading comments on map functions
Message-ID: <ZcUrtpnj7jx9X2kd@x1>
References: <20240208181025.1329645-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208181025.1329645-1-namhyung@kernel.org>

On Thu, Feb 08, 2024 at 10:10:25AM -0800, Namhyung Kim wrote:
> When it converts sample IP to or from objdump-capable one, there's a
> comment saying that kernel modules have DSO_SPACE__USER.  But commit
> 02213cec64bb ("perf maps: Mark module DSOs with kernel type") changed
> it and makes the comment confusing.  Let's get rid of it.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/map.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index cf5a15db3a1f..14a5ea70d81e 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -553,10 +553,6 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
>  	if (dso->rel)
>  		return rip - map__pgoff(map);
>  
> -	/*
> -	 * kernel modules also have DSO_TYPE_USER in dso->kernel,
> -	 * but all kernel modules are ET_REL, so won't get here.
> -	 */
>  	if (dso->kernel == DSO_SPACE__USER)
>  		return rip + dso->text_offset;
>  
> @@ -585,10 +581,6 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
>  	if (dso->rel)
>  		return map__unmap_ip(map, ip + map__pgoff(map));
>  
> -	/*
> -	 * kernel modules also have DSO_TYPE_USER in dso->kernel,
> -	 * but all kernel modules are ET_REL, so won't get here.
> -	 */
>  	if (dso->kernel == DSO_SPACE__USER)
>  		return map__unmap_ip(map, ip - dso->text_offset);
>  
> -- 
> 2.43.0.687.g38aa6559b0-goog

