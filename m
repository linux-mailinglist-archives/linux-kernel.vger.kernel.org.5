Return-Path: <linux-kernel+bounces-46935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F66844683
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2141C22A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B39012F5A5;
	Wed, 31 Jan 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="imI1Q0fQ"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDDD12F592
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723468; cv=none; b=cw0BdBa2qmqxV2H+ft65NdCmfZeqBoZK00nxnaLWEGotYArZiDIhithUdVLNg616D8sCXJdgkFfsIWQQIBvvUtfViUpcsZOP+uQyoCffluWvH0PIqygmSh6vsO6+08MDrtwb6oq2YxHvEG3+V+VPyiA4YNetpMKquZBPT/wD2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723468; c=relaxed/simple;
	bh=qJY4oRkVrk63MTvWpmtZEcGr0Puj9gAd9LCVvTivDTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3eoiv4ETFYeXYNmAxhOJ3emg/wFhiPLf1Y4hBsxAl63Npt9xmJUZxIDLtQBnxwOD8EBn3+jj6LlpqbPgSw/cpDKafgo2hfBNrVvEPkupiBlaupiBHbMrA/lf1Q1oG1QIRrfe/UrI4qKEgxny3TuoG2QllCSFpza5nPzp/NB8hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=imI1Q0fQ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68009cb4669so300706d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706723464; x=1707328264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bSf7bOhErvUGe8OSqVrxrzA9YWlx2blDsXOWDY7bWc=;
        b=imI1Q0fQ0TFCzbPLlXIOhyFsYz9Xz5OyOAWLhgwBTNLULEC9/2PjJjJKUlcsdYt/AW
         v4E0DpnV14qFnqhnG846f6ymb9m2nWqBWEDsMKzBrTpy48CtcT2gcvtVducJJTY5SY9V
         wyyPvbdXjzIzTYejZ9QPl3mRqtPLp7H5pSeK9JiOk5GQ85GVhjQ63sn47MCuUIfIwgC2
         RgzTypAyOuUO3eIaZoGFMF6+/aYiLg8xUeFAkrwmjUDvqykVIs9/6Da3/LWyC8pUY3XB
         8OAJKgRzYUkXCndzeNBXBidipshHrmEEWdgnER0hhRSvx+ctvU6ay/Qb4Kee2ccf0s7v
         IeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706723464; x=1707328264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bSf7bOhErvUGe8OSqVrxrzA9YWlx2blDsXOWDY7bWc=;
        b=eT3bIpFojhh1HyNYgujZ0/Zgu+QtvttTWPotRKgXgM0eyCSTNQKUdCTtvtH0UiRSMp
         Ux3mMDUVxFDv1dyYy6wGjz2tSX7X/0pTkkwzvj55gWB2I4jRKrZydKFuo24EVcbaszos
         C8F/Wo7PwiOVxkRjVDDHcJziqiKKO6awdev+/V/9ulwm4FbjK2YWR31VnGIP1zu+l89U
         9Z6qbs7p5oNBrwfShFtUTyAtKkMaA9lWMS8MtFNuBBYnvHHBV54lFwdbHXyRvMYmPY01
         26XLC77MZnDuZyfACJk2hlxZnpGuNuchoXxC3CdNBMtb5OaSwOIPob37YbS8x1ERd+GR
         Z3RA==
X-Gm-Message-State: AOJu0Yxtv07bNrw+Xw6DUkWi0sbwbT1X/FHtuebBIw7A/Bh6KYNOxUEy
	UcKHKtocGtxFb6kWS6u7XpbBOjsdpkOyi7/wWM0WY/1Y7e22FfDY8k78WI+eG3A=
X-Google-Smtp-Source: AGHT+IERMm2HQiYN0C0bnn9l10JBozKMVH89zidARxsELO0u19TRMBEjLyabrSRSAjMEl9ErpOfjNg==
X-Received: by 2002:a05:6214:d87:b0:681:77d9:c405 with SMTP id e7-20020a0562140d8700b0068177d9c405mr2344836qve.33.1706723464493;
        Wed, 31 Jan 2024 09:51:04 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id s12-20020ad4500c000000b0068c510634d1sm2968358qvo.108.2024.01.31.09.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 09:51:04 -0800 (PST)
Date: Wed, 31 Jan 2024 12:50:59 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Efly Young <yangyifei03@kuaishou.com>, android-mm@google.com,
	yuzhao@google.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: Use larger chunks for proactive reclaim
Message-ID: <20240131175059.GC1227330@cmpxchg.org>
References: <20240131162442.3487473-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131162442.3487473-1-tjmercier@google.com>

On Wed, Jan 31, 2024 at 04:24:41PM +0000, T.J. Mercier wrote:
> Before 388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive
> reclaim") we passed the number of pages for the reclaim request directly
> to try_to_free_mem_cgroup_pages, which could lead to significant
> overreclaim in order to achieve fairness. After 0388536ac291 the number
> of pages was limited to a maxmimum of 32 (SWAP_CLUSTER_MAX) to reduce
> the amount of overreclaim. However such a small chunk size caused a
> regression in reclaim performance due to many more reclaim start/stop
> cycles inside memory_reclaim.
> 
> Instead of limiting reclaim chunk size to the SWAP_CLUSTER_MAX constant,
> adjust the chunk size proportionally with number of pages left to
> reclaim. This allows for higher reclaim efficiency with large chunk
> sizes during the beginning of memory_reclaim, and reduces the amount of
> potential overreclaim by using small chunk sizes as the total reclaim
> amount is approached. Using 1/4 of the amount left to reclaim as the
> chunk size gives a good compromise between reclaim performance and
> overreclaim:
> 
> root - full reclaim       pages/sec   time (sec)
> pre-0388536ac291      :    68047        10.46
> post-0388536ac291     :    13742        inf
> (reclaim-reclaimed)/4 :    67352        10.51
> 
> /uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (MiB)
> pre-0388536ac291      :    258822       1.12            107.8
> post-0388536ac291     :    105174       2.49            3.5
> (reclaim-reclaimed)/4 :    233396       1.12            -7.4
> 
> /uid_0 - full reclaim     pages/sec   time (sec)
> pre-0388536ac291      :    72334        7.09
> post-0388536ac291     :    38105        14.45
> (reclaim-reclaimed)/4 :    72914        6.96
> 
> Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive reclaim")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  mm/memcontrol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 46d8d02114cf..d68fb89eadd2 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6977,7 +6977,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  			lru_add_drain_all();
>  
>  		reclaimed = try_to_free_mem_cgroup_pages(memcg,
> -					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
> +					max((nr_to_reclaim - nr_reclaimed) / 4,
> +					    (nr_to_reclaim - nr_reclaimed) % 4),

I don't see why the % 4 is needed. It only kicks in when the delta
drops below 4, but try_to_free_mem_cgroup_pages() already has

		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),

so it looks like dead code.

