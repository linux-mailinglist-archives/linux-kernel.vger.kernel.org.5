Return-Path: <linux-kernel+bounces-51361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FECB848A22
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236691F239F6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236764C8C;
	Sun,  4 Feb 2024 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJ1YLtbE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA44685
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009938; cv=none; b=gy05NPv8kHNj8cBXZNUb4HhqAo4ce97yH+yLpLURkv0fc5whFDb8dxqV/aocjGGLGP4FQ9qcIWlEIeRtBIXCvC2Qxo6MHNVBY8YWLxL4E+PA99CUIkZrs7ssiLQYbCgle/HFaGd+dtoxPZIn75WqmCcEIdM6o8GSPMFjSedakSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009938; c=relaxed/simple;
	bh=WpCKdFqw5IN67E9Y7z93QSOdWPaN4BD4TFaa8l4D5Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITb/Sm/1v08W4/IcUNopqKB7KwJw/WfwFSyNnzTGitg3jCYYDy3LD87OcPIoJ2X2ntKREUv4NVjZU6UKWMpZ4Tq6PjWMDlhbq3MVH0KZLQtKh4yWBTdzEbtgEyrTis0imow0oHcrSb5AqQAr12m+smsPaAGaOxLnP1qoXi2f6eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJ1YLtbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A17C433F1;
	Sun,  4 Feb 2024 01:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707009937;
	bh=WpCKdFqw5IN67E9Y7z93QSOdWPaN4BD4TFaa8l4D5Cg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YJ1YLtbEjbSL8fHL6KuOOJ19qt+pEVsMiNLRnXQVX4SgbdzaW/Hm4snK4xa/04qVB
	 ra+AxK7FGu4DCkMO+BmyKcXe2KMrjctXyYPSWO3mjQtePhoUJ5lWBxvfWB4tbvO92W
	 w3FE4GBUHADVCQV9GSU6Z/S7Wel6pr9DzsosDE9voRfeLnvJqIE8kX13ZHYKGuy64T
	 Hj+AbKwJV8oidFDQm6kZ5WS5kiElX3gZ/gJVGgD5t6H9o67f4P8Z0/s9qwCASPbWCw
	 vzf+FVEHUJ4rg9nuMZd4xmWwHrE4mUMEVz6S8ejbC4Wb9bQiiJ6XguDH0jwfP/7Azy
	 gJfKBGUeRsJJw==
Message-ID: <be86741f-a3b2-4c75-b645-371761a5b99e@kernel.org>
Date: Sun, 4 Feb 2024 09:25:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] f2fs: sysfs: support gc_io_aware
Content-Language: en-US
To: liujinbao1 <jinbaoliu365@gmail.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 liujinbao1 <liujinbao1@xiaomi.corp-partner.google.com>
References: <5a4cdc020f19e136e79f9d0b6ca2adf2879db888.1706859367.git.liujinbao1@xiaomi.corp-partner.google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <5a4cdc020f19e136e79f9d0b6ca2adf2879db888.1706859367.git.liujinbao1@xiaomi.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/2 19:22, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.corp-partner.google.com>

AFAIK, this account is only used for interaction between google and
its partner, I guess you can use xiaomi's email address instead?

> 
> Currently, IO can only be ignored when GC_URGENT_HIGH is set,
> and the default algorithm used for GC_URGENT_HIGH is greedy.
> It gives a way to enable/disable IO aware feature for background
> gc, so that we can tune background gc more precisely. e.g.
> force to disable IO aware and choose more suitable algorithm
> if there are large number of dirty segments.
> 
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.corp-partner.google.com>

Ditto,

> 
> changes of v2: Improve the patch according to Chao's suggestions

Trivial thing, it's better not include above line in commit message.

Thanks,

> 
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
>   fs/f2fs/gc.c                            | 3 ++-
>   fs/f2fs/gc.h                            | 1 +
>   fs/f2fs/sysfs.c                         | 9 +++++++++
>   4 files changed, 18 insertions(+), 1 deletion(-)
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
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 309da3d0faff..0b75d37acc63 100644
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
> +	gc_th->io_aware = true;
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
> index 417fae96890f..e8d5667cfddd 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -516,6 +516,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "gc_io_aware")) {
> +		if (t > 1)
> +			return -EINVAL;
> +		*ui = t ? true : false;
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

