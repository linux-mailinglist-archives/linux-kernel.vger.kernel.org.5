Return-Path: <linux-kernel+bounces-47692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9367684515B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFA3284F21
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1950C7E573;
	Thu,  1 Feb 2024 06:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JskVz43S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE936519D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 06:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706768965; cv=none; b=t6WXDoWhzgq86ns5MeY42aMFtWsQjLjgU3kxtc2kq0lODu1uAb5SW2G2JIoUALy5Q11/FUulVbJAQHR3G5HH0bwFEVcnzYxzOO9x44bMfBcu2FO/XldNW9QonM3o+MG200upR/EbAxec8rAFs8yexMQSsl98yibHKiZ2ve2XYdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706768965; c=relaxed/simple;
	bh=1BN6jfhT/gk45R5CPCVJSrOjxfYN0aiySJzxnvTLL9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyIB5JLbCI9X6U+cnqEppGTTgMZQQg2bw9ZnSfUOGwKLi5yXd+uzZZ3JVtg1xHB4XSkYIhL/h67jpfM2iyzmMsQjcGDixk9ZB8nDLp77nqjKPMsNDhJ5zQEysgWg01fuUyocF3T5Xyi25PGDelz9axoFExZvNKfDtkjA+/b14wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JskVz43S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E97C433F1;
	Thu,  1 Feb 2024 06:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706768964;
	bh=1BN6jfhT/gk45R5CPCVJSrOjxfYN0aiySJzxnvTLL9I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JskVz43SXLur011T8ECNrlujln8yf0cbj2eLQ/8L+LzS/RKAXRgtfcHTotBopzob3
	 Wlf6HNLdn2ERNJfUAEbpVsMg/4X+psQruWFS8EylML+D8qf0VZFSd7AzkSiY1of0ET
	 d4fh85DrXTL1nTgPyN5cPHwUABlE6GyZyW0jDTRnsg489WY/7xZ1wVc348nrZy0/sD
	 uvfinO86U48GprfFn99SqrAEhUh3fzXZ0FYkYuJoSKBGMM0PMCyT8izcQqSkr/5cpa
	 VMjOwhbQsCwgBRJbowJPOV9yKuvAQ2DQQwMjyOtItyS5CoTpGBMy7J2d/EIgBotWbr
	 thl2W3EjiHqAQ==
Message-ID: <0477240f-9f52-4418-9a2d-7a5a598cd0a9@kernel.org>
Date: Thu, 1 Feb 2024 14:29:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] UPSTREAM: f2fs: sysfs: support gc_io_aware
Content-Language: en-US
To: liujinbao1 <jinbaoliu365@gmail.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 liujinbao1 <liujinbao1@xiaomi.corp-partner.google.com>
References: <20240130125113.14081-1-jinbaoliu365@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240130125113.14081-1-jinbaoliu365@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/30 20:51, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.corp-partner.google.com>
> 
> Currently, IO can only be ignored when GC_URGENT_HIGH is set,
>   and the default algorithm used for GC_URGENT_HIGH is greedy.
> It gives a way to enable/disable IO aware feature for background
> gc, so that we can tune background gc more precisely. e.g.
> force to disable IO aware and choose more suitable algorithm
> if there are large number of dirty segments.
> 
> Change-Id: Ic0ea1bf8fb6602f0dd88b924088f1c1b33fcd809

Should remove Change-Id line.

> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.corp-partner.google.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
>   fs/f2fs/f2fs.h                          | 6 ++++++
>   fs/f2fs/gc.c                            | 3 ++-
>   fs/f2fs/gc.h                            | 1 +
>   fs/f2fs/sysfs.c                         | 9 +++++++++
>   5 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 36c3cb547901..47f02fa471fe 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -16,6 +16,12 @@ Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
>   Description:	Controls the default sleep time for gc_thread. Time
>   		is in milliseconds.
>   
> +What:		/sys/fs/f2fs/<disk>/gc_io_aware
> +Date:		January 2024
> +Contact:	"Jinbao Liu" <liujinbao1@xiaomi.com>
> +Description:	It controls to enable/disable IO aware feature for background gc.
> ++		By default, the value is 1 which indicates IO aware is on.
> +
>   What:		/sys/fs/f2fs/<disk>/gc_idle
>   Date:		July 2013
>   Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 214fdd590fdf..ebe953e7459e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -374,6 +374,12 @@ enum {
>   	MAX_DPOLICY,
>   };
>   
> +enum {
> +	GC_IO_AWARE_DISABLE,	/* force to not be aware of IO */
> +	GC_IO_AWARE_ENABLE,	/* force to be aware of IO */
> +	GC_IO_AWARE_MAX,
> +};

Not needed.

> +
>   struct discard_policy {
>   	int type;			/* type of discard */
>   	unsigned int min_interval;	/* used for candidates exist */
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 309da3d0faff..34a1e6b35af6 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -109,7 +109,7 @@ static int gc_thread_func(void *data)
>   			goto next;
>   		}
>   
> -		if (!is_idle(sbi, GC_TIME)) {
> +		if (gc_th->io_aware && !is_idle(sbi, GC_TIME)) {
>   			increase_sleep_time(gc_th, &wait_ms);
>   			f2fs_up_write(&sbi->gc_lock);
>   			stat_io_skip_bggc_count(sbi);
> @@ -182,6 +182,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
>   	gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
>   	gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
>   	gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
> +	gc_th->io_aware = GC_IO_AWARE_ENABLE;

gc_th->io_aware = true;

>   
>   	gc_th->gc_wake = false;
>   
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 28a00942802c..51d6ad26b76a 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -41,6 +41,7 @@ struct f2fs_gc_kthread {
>   	unsigned int min_sleep_time;
>   	unsigned int max_sleep_time;
>   	unsigned int no_gc_sleep_time;
> +	bool io_aware;
>   
>   	/* for changing gc mode */
>   	bool gc_wake;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 417fae96890f..95409cfc48f4 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -516,6 +516,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "gc_io_aware")) {
> +		if (t >= GC_IO_AWARE_MAX)

	if (t > 1)

> +			return -EINVAL;
> +		*ui = t;

	*ui = t ? true : false;

Thanks,

> +		return count;
> +	}
> +
>   	if (!strcmp(a->attr.name, "migration_granularity")) {
>   		if (t == 0 || t > sbi->segs_per_sec)
>   			return -EINVAL;
> @@ -906,6 +913,7 @@ GC_THREAD_RW_ATTR(gc_urgent_sleep_time, urgent_sleep_time);
>   GC_THREAD_RW_ATTR(gc_min_sleep_time, min_sleep_time);
>   GC_THREAD_RW_ATTR(gc_max_sleep_time, max_sleep_time);
>   GC_THREAD_RW_ATTR(gc_no_gc_sleep_time, no_gc_sleep_time);
> +GC_THREAD_RW_ATTR(gc_io_aware, io_aware);
>   
>   /* SM_INFO ATTR */
>   SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
> @@ -1061,6 +1069,7 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(gc_min_sleep_time),
>   	ATTR_LIST(gc_max_sleep_time),
>   	ATTR_LIST(gc_no_gc_sleep_time),
> +	ATTR_LIST(gc_io_aware),
>   	ATTR_LIST(gc_idle),
>   	ATTR_LIST(gc_urgent),
>   	ATTR_LIST(reclaim_segments),

