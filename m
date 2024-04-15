Return-Path: <linux-kernel+bounces-145916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74118A5CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4508AB22EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C38156C53;
	Mon, 15 Apr 2024 21:14:58 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE591DFEB;
	Mon, 15 Apr 2024 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215698; cv=none; b=VuT2t2qhJ3LI5UEUyiOsjFQccgWjZe1qBuTpu03SwJvWW2vV3x3DhDaihB6Ff/TSn41+kt9UFL0y96lIXmURJsb2kR24l/89HuE+bixmOkmdoTATwggAvrGv2ELe5cw7qcXGas1ETVmpttzrPbY7ZQc+DkN8LJ6V9OeNA7AUFS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215698; c=relaxed/simple;
	bh=09bE2/BS5OWQjR9LPthBK2eEF2k/z7JUHoHNRW90vWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIleCUc8gFRLsCCE4bZ2arSxxT5L3CFRutRBJXzTXqCmV5n8Y/rnU2PLuhHccwFx8xJI1Wv3ZzvoQ4bjtGNcrFDKhMTVxkPn6kod8Q08yZJ08HKnTMqhgBgPywMdQflHuE7rWqie6/4MCDePNerMX5KD/+OZv9aD/yR9d16coVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.18.169.210] (ip-185-104-138-49.ptr.icomera.net [185.104.138.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CBD9161E5FE06;
	Mon, 15 Apr 2024 23:14:12 +0200 (CEST)
Message-ID: <207dd4f9-f399-40db-b91e-df649f2c52d2@molgen.mpg.de>
Date: Mon, 15 Apr 2024 23:14:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] md: Added journal count to md_u.h
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: song@kernel.org, yukuai3@huawei.com, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
References: <20240415160818.8276-1-jain.abhinav177@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240415160818.8276-1-jain.abhinav177@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Abhinav,


Thank you for your patch. Some formal nits. Could you please use 
imperative mood in the commit message summary/title?

Am 15.04.24 um 18:08 schrieb Abhinav Jain:
> This patch addresses TODO in "./drivers/md/md.c:6752".

Maybe quote the to-do?

> Add journal struct member to mdu_array_info_t in "md_u.h".
> Add the journal field in get_array_info function in "md.c".

I wouldn’t break the line, just because a sentence ends, and use 75 
characters per line. Or make it a list/enumeration.

> Need feedback on if the update_array_info function needs to be updated.

If you need feedback, please tag the patch, that means, add [RFC] to the 
subject/summary/title.

How did you test this?


Kind regards,

Paul


> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>   drivers/md/md.c                | 8 ++++----
>   include/uapi/linux/raid/md_u.h | 1 +
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index e575e74aabf5..4958d6e21923 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -6735,10 +6735,10 @@ static int get_version(void __user *arg)
>   static int get_array_info(struct mddev *mddev, void __user *arg)
>   {
>   	mdu_array_info_t info;
> -	int nr,working,insync,failed,spare;
> +	int nr, working, insync, failed, spare, journal;
>   	struct md_rdev *rdev;
>   
> -	nr = working = insync = failed = spare = 0;
> +	nr = working = insync = failed = spare = journal = 0;
>   	rcu_read_lock();
>   	rdev_for_each_rcu(rdev, mddev) {
>   		nr++;
> @@ -6749,8 +6749,7 @@ static int get_array_info(struct mddev *mddev, void __user *arg)
>   			if (test_bit(In_sync, &rdev->flags))
>   				insync++;
>   			else if (test_bit(Journal, &rdev->flags))
> -				/* TODO: add journal count to md_u.h */
> -				;
> +				journal++;
>   			else
>   				spare++;
>   		}
> @@ -6769,6 +6768,7 @@ static int get_array_info(struct mddev *mddev, void __user *arg)
>   	info.raid_disks    = mddev->raid_disks;
>   	info.md_minor      = mddev->md_minor;
>   	info.not_persistent= !mddev->persistent;
> +	info.journal       = journal;
>   
>   	info.utime         = clamp_t(time64_t, mddev->utime, 0, U32_MAX);
>   	info.state         = 0;
> diff --git a/include/uapi/linux/raid/md_u.h b/include/uapi/linux/raid/md_u.h
> index 7be89a4906e7..485befa2205d 100644
> --- a/include/uapi/linux/raid/md_u.h
> +++ b/include/uapi/linux/raid/md_u.h
> @@ -84,6 +84,7 @@ typedef struct mdu_array_info_s {
>   	int raid_disks;
>   	int md_minor;
>   	int not_persistent;
> +	int journal;
>   
>   	/*
>   	 * Generic state information

