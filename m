Return-Path: <linux-kernel+bounces-57331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FAD84D712
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A1CB226A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543B612E61;
	Thu,  8 Feb 2024 00:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPv10eP+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D11C11737
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351682; cv=none; b=kXFom+CS+dNRhL19qH0gZeeHi5lQoJBg1nxFfgc70vcTegDVuWkHOxHYV8gLUlWrOcVdPeXh7RG2zrpQJrPAtaDy4DzUi2funB1mlr89BakSfl8aOvu7Mz4rC+aOso7GrloWqLK/dOgiCNSkwNZh72n4e2W5Abgn6+LqprHHknc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351682; c=relaxed/simple;
	bh=ib1sOSEkwlcTgn6HtFduVrZxSUlkTx/HR6aWFwOhyE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eftSOvxf+oEOc2QGi3O6qNzKKdDDwaKKK9dRzjxrPgWX/W/ROCBJaKRouckG6jfwoR9OF2S8l03VsqaHx7sgZANUrK5vaJ5LwJbsgWyMp7CZkl284ejGqyDOmZgDZ6Tr3kcxEtVhiiY9M1BFcnNUFtpxAJmj1BF2hd0mcfZXjxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPv10eP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3649C433C7;
	Thu,  8 Feb 2024 00:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707351682;
	bh=ib1sOSEkwlcTgn6HtFduVrZxSUlkTx/HR6aWFwOhyE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPv10eP+1Kuvx108Ty5qI0u4aD60WvLRHAkucg9+OPZuUkqlPpPmLpXubvi0FWpva
	 fog7/UhT9NLyuzCmvXEYdfcwXFX5H/NguG+rNqSBt/KYCZ0f6oB64OqkiEXhVWIcQy
	 FBZzuJI629UqeuxI/e3tNVJROXTaI4pj2y7v2URkLjpVLga1q6DtF8DSyMbkYIKy78
	 MaXpN3cZUsh3xhwj0QNoqkOefyfu9H2LckwV+UC+rNVr5csHkWjGbSa/+9huTxf6Jz
	 uvIEXxx5QRRvuEO5dfDosh9IsfGRnsm+2Fro14EVV9rUb3jhaza7ChkH85R5L2tKpL
	 y6op9hBt52KwA==
Date: Wed, 7 Feb 2024 16:21:20 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: liujinbao1 <jinbaoliu365@gmail.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, liujinbao1 <liujinbao1@xiaomi.com>
Subject: Re: [PATCH v3] f2fs: sysfs: support gc_io_aware
Message-ID: <ZcQegCzMgIFjgtGW@google.com>
References: <3b2852b3d404ecbb53d9affa781d12d0e9ea3951.1707022643.git.liujinbao1@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b2852b3d404ecbb53d9affa781d12d0e9ea3951.1707022643.git.liujinbao1@xiaomi.com>

On 02/04, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> Currently, IO can only be ignored when GC_URGENT_HIGH is set,
> and the default algorithm used for GC_URGENT_HIGH is greedy.
> It gives a way to enable/disable IO aware feature for background
> gc, so that we can tune background gc more precisely. e.g.
> force to disable IO aware and choose more suitable algorithm
> if there are large number of dirty segments.
> 
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
>  fs/f2fs/gc.c                            | 3 ++-
>  fs/f2fs/gc.h                            | 1 +
>  fs/f2fs/sysfs.c                         | 9 +++++++++
>  4 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 36c3cb547901..47f02fa471fe 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -16,6 +16,12 @@ Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
>  Description:	Controls the default sleep time for gc_thread. Time
>  		is in milliseconds.
>  
> +What:		/sys/fs/f2fs/<disk>/gc_io_aware
> +Date:		January 2024
> +Contact:	"Jinbao Liu" <liujinbao1@xiaomi.com>
> +Description:	It controls to enable/disable IO aware feature for background gc.
> ++		By default, the value is 1 which indicates IO aware is on.
> +
>  What:		/sys/fs/f2fs/<disk>/gc_idle
>  Date:		July 2013
>  Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 309da3d0faff..0b75d37acc63 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -109,7 +109,7 @@ static int gc_thread_func(void *data)
>  			goto next;
>  		}
>  
> -		if (!is_idle(sbi, GC_TIME)) {
> +		if (gc_th->io_aware && !is_idle(sbi, GC_TIME)) {

This voids GC_URGENT_HIGH, which looks wrong?

>  			increase_sleep_time(gc_th, &wait_ms);
>  			f2fs_up_write(&sbi->gc_lock);
>  			stat_io_skip_bggc_count(sbi);
> @@ -182,6 +182,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
>  	gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
>  	gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
>  	gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
> +	gc_th->io_aware = true;
>  
>  	gc_th->gc_wake = false;
>  
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 28a00942802c..51d6ad26b76a 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -41,6 +41,7 @@ struct f2fs_gc_kthread {
>  	unsigned int min_sleep_time;
>  	unsigned int max_sleep_time;
>  	unsigned int no_gc_sleep_time;
> +	bool io_aware;
>  
>  	/* for changing gc mode */
>  	bool gc_wake;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 417fae96890f..e8d5667cfddd 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -516,6 +516,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  		return count;
>  	}
>  
> +	if (!strcmp(a->attr.name, "gc_io_aware")) {
> +		if (t > 1)
> +			return -EINVAL;
> +		*ui = t ? true : false;
> +		return count;
> +	}
> +
>  	if (!strcmp(a->attr.name, "migration_granularity")) {
>  		if (t == 0 || t > sbi->segs_per_sec)
>  			return -EINVAL;
> @@ -906,6 +913,7 @@ GC_THREAD_RW_ATTR(gc_urgent_sleep_time, urgent_sleep_time);
>  GC_THREAD_RW_ATTR(gc_min_sleep_time, min_sleep_time);
>  GC_THREAD_RW_ATTR(gc_max_sleep_time, max_sleep_time);
>  GC_THREAD_RW_ATTR(gc_no_gc_sleep_time, no_gc_sleep_time);
> +GC_THREAD_RW_ATTR(gc_io_aware, io_aware);
>  
>  /* SM_INFO ATTR */
>  SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
> @@ -1061,6 +1069,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(gc_min_sleep_time),
>  	ATTR_LIST(gc_max_sleep_time),
>  	ATTR_LIST(gc_no_gc_sleep_time),
> +	ATTR_LIST(gc_io_aware),
>  	ATTR_LIST(gc_idle),
>  	ATTR_LIST(gc_urgent),
>  	ATTR_LIST(reclaim_segments),
> -- 
> 2.43.0

