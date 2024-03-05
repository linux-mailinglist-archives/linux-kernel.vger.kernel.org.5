Return-Path: <linux-kernel+bounces-91868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126FA8717A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C99FB217F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45077F7C5;
	Tue,  5 Mar 2024 08:10:29 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5507F46B;
	Tue,  5 Mar 2024 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626229; cv=none; b=X2OdA5lzHRWvtEq0DpxIPRUMOuIeMT/01Ep6y/jwEj9k7EUiLqkCjEziC1zap4UHfE7nj16GUO4iYlnEXbxsx8NcJK+ErO+RHREP/1hLxK2iSnJ4KaVRVgCrTEj4SO5Ewq2HyI/9JTe+uBpTU0RUvm0LytPjF6dqIzAOaG3Em8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626229; c=relaxed/simple;
	bh=iAFz1Dwqp2+si5SzlNkTHCdkyeUK8/aZtCcMKnD2piU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pciLBrpHXdQPtRPa9K+oThiL2y8JV1Fy/pHyGuSZKBRw/N+jdgOgxm/Q2w1zkso7qQr5y1oQOs9SYeBCYtq/b5QV/+n6eOKIhfGXZvZ2UZLUnQy8DOBN3ZkYY/wr97e7zIUYLjVRG4TGgXNHl3M2wBzn0T676oGyWyDtTeYx1Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.12.27] (g027.RadioFreeInternet.molgen.mpg.de [141.14.12.27])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6C11361E5FE01;
	Tue,  5 Mar 2024 09:08:30 +0100 (CET)
Message-ID: <c0e648ea-d73e-4805-a2bb-b02ddd3ca4e2@molgen.mpg.de>
Date: Tue, 5 Mar 2024 09:08:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH md-6.8 v2 2/9] md: export helpers to stop sync_thread
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: xni@redhat.com, zkabelac@redhat.com, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, dm-devel@lists.linux.dev, song@kernel.org,
 yukuai3@huawei.com, heinzm@redhat.com, jbrassow@redhat.com, neilb@suse.de,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com
References: <20240305072306.2562024-1-yukuai1@huaweicloud.com>
 <20240305072306.2562024-3-yukuai1@huaweicloud.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240305072306.2562024-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kuai,


Thank you for your patch.

Am 05.03.24 um 08:22 schrieb Yu Kuai:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> The new heleprs will be used in dm-raid in later patches to fix

hel*pe*rs

> regressions and prevent calling md_reap_sync_thread() directly.

Please list the new functions.

1.  md_idle_sync_thread(struct mddev *mddev);
2.  md_frozen_sync_thread(struct mddev *mddev);
3.  md_unfrozen_sync_thread(struct mddev *mddev);

I do not like the naming so much. `md_reap_sync_thread()` has the verb 
in imperative mood. At least myself, I would not know what the functions 
do exactly without looking at the implementation.


Kind regards,

Paul


> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Xiao Ni <xni@redhat.com>
> Acked-by: Mike Snitzer <snitzer@kernel.org>
> ---
>   drivers/md/md.c | 29 +++++++++++++++++++++++++++++
>   drivers/md/md.h |  3 +++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 23f31fd1d024..22e7512a5b1e 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4919,6 +4919,35 @@ static void stop_sync_thread(struct mddev *mddev, bool locked, bool check_seq)
>   		mddev_lock_nointr(mddev);
>   }
>   
> +void md_idle_sync_thread(struct mddev *mddev)
> +{
> +	lockdep_assert_held(&mddev->reconfig_mutex);
> +
> +	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +	stop_sync_thread(mddev, true, true);
> +}
> +EXPORT_SYMBOL_GPL(md_idle_sync_thread);
> +
> +void md_frozen_sync_thread(struct mddev *mddev)
> +{
> +	lockdep_assert_held(&mddev->reconfig_mutex);
> +
> +	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +	stop_sync_thread(mddev, true, false);
> +}
> +EXPORT_SYMBOL_GPL(md_frozen_sync_thread);
> +
> +void md_unfrozen_sync_thread(struct mddev *mddev)
> +{
> +	lockdep_assert_held(&mddev->reconfig_mutex);
> +
> +	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
> +	md_wakeup_thread(mddev->thread);
> +	sysfs_notify_dirent_safe(mddev->sysfs_action);
> +}
> +EXPORT_SYMBOL_GPL(md_unfrozen_sync_thread);
> +
>   static void idle_sync_thread(struct mddev *mddev)
>   {
>   	mutex_lock(&mddev->sync_mutex);
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 8d881cc59799..437ab70ce79b 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -781,6 +781,9 @@ extern void md_rdev_clear(struct md_rdev *rdev);
>   extern void md_handle_request(struct mddev *mddev, struct bio *bio);
>   extern int mddev_suspend(struct mddev *mddev, bool interruptible);
>   extern void mddev_resume(struct mddev *mddev);
> +extern void md_idle_sync_thread(struct mddev *mddev);
> +extern void md_frozen_sync_thread(struct mddev *mddev);
> +extern void md_unfrozen_sync_thread(struct mddev *mddev);
>   
>   extern void md_reload_sb(struct mddev *mddev, int raid_disk);
>   extern void md_update_sb(struct mddev *mddev, int force);

