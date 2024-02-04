Return-Path: <linux-kernel+bounces-51371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B45EE848A4A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7282B1F2344F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA208C0A;
	Sun,  4 Feb 2024 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzsBCThk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEEB8BEB
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707011274; cv=none; b=gGzLJmnz5DKD/YgxNQ0xBt390WCOjA2VKIOhUk1dXVru3IC1UGchvP2KaqNHgnDMG9ELfslvkx/lnOerk20bqiWVJYqtxPdTp7Avru0PrC8ccARq0vc4TwmCk9saBCySSM+uQ5UyMVGxYMPOpvvR9sPF27MDun/ytjdXXqFVO2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707011274; c=relaxed/simple;
	bh=2AQnPmoKsbbhPHWUPAdwATTf/lebIxhhjhdFZEHTX+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFAVLhqJr+EZTDBEaP1146ouw/e4OjxGdNBKFs4sm1i0mV6aLtBw4f9MByVPyii2k0C8d1/ZD7wrsYrPmyQ3HPubpNeGutlu/Edr1nXyy3DHonVXjPDwnJGJpgQqGP7BJJJ5EJgXBYvJH1eODlnG6lDKi9ER+Uzn9me8vew6q20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzsBCThk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50390C433C7;
	Sun,  4 Feb 2024 01:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707011273;
	bh=2AQnPmoKsbbhPHWUPAdwATTf/lebIxhhjhdFZEHTX+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gzsBCThkcBb2Mjc90NH8US4+wnXWJVvpFsmZG0tEJ2ytPqPw8/RqZ+dDR502goRB+
	 xucxJS/a7ZEeh8J1fFXtjOqeFBOByBGifO2JXxcbivmKU0P0yeaOjfarL/BoLidJKD
	 mJy3DIfkssHOrrAg8eK8j/JRr7fTxWN+kkVsYf4DoIy1o8xZezHRgNOpDOqA3iva45
	 ajrC1OuY8v6JQZ5bgBiTYCo6JWI7Q6V6u3unvoNmiGPv34a+rogpZkAai1FOf34ker
	 jZy8wIWeYv85fZjIzYSz/+bFrFBrbu58LmKIFrL+hRrgXProgXdoGj0oZfj/IsUKhE
	 0W5LRIC1X0fFg==
Message-ID: <8eaf59a4-1aaa-460e-a3cc-b798ed5e0f63@kernel.org>
Date: Sun, 4 Feb 2024 09:47:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] f2fs: fix zoned block device information
 initialization
Content-Language: en-US
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org,
 yangyongpeng1@oppo.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Cc: hustqwj@hust.edu.cn
References: <20240203152436.1352-1-qwjhust@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240203152436.1352-1-qwjhust@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/3 23:24, Wenjie Qi wrote:
> If the max open zones of zoned devices are less than
> the active logs of F2FS, the device may error due to
> insufficient zone resources when multiple active logs are
> being written at the same time. If this value is 0,
> there is no limit.
> 
> Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> ---
>   fs/f2fs/f2fs.h  |  1 +
>   fs/f2fs/super.c | 21 +++++++++++++++++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 543898482f8b..161107f2d3bd 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1558,6 +1558,7 @@ struct f2fs_sb_info {
>   
>   #ifdef CONFIG_BLK_DEV_ZONED
>   	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
> +	unsigned int max_open_zones;		/* max open zone resources of the zoned device */
>   #endif
>   
>   	/* for node-related operations */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 1b718bebfaa1..45e82d6016fc 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2388,6 +2388,16 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	if (err)
>   		goto restore_opts;
>   
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	if (sbi->max_open_zones && sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
> +		f2fs_err(sbi,
> +			"zoned: max open zones %u is too small, need at least %u open zones",
> +				 sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
> +		err = -EINVAL;
> +		goto restore_opts;
> +	}
> +#endif
> +
>   	/* flush outstanding errors before changing fs state */
>   	flush_work(&sbi->s_error_work);
>   
> @@ -3930,11 +3940,22 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>   	sector_t nr_sectors = bdev_nr_sectors(bdev);
>   	struct f2fs_report_zones_args rep_zone_arg;
>   	u64 zone_sectors;
> +	unsigned int max_open_zones;
>   	int ret;
>   
>   	if (!f2fs_sb_has_blkzoned(sbi))
>   		return 0;
>   
> +	max_open_zones = bdev_max_open_zones(bdev);

Wenjie,

max_open_zones can always be zero? then sbi->max_open_zones will be zero,
is this a valid case?

Thanks,

> +	if (max_open_zones && (max_open_zones < sbi->max_open_zones || !sbi->max_open_zones))
> +		sbi->max_open_zones = max_open_zones;
> +	if (sbi->max_open_zones && sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
> +		f2fs_err(sbi,
> +			"zoned: max open zones %u is too small, need at least %u open zones",
> +				 sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
> +		return -EINVAL;
> +	}
> +
>   	zone_sectors = bdev_zone_sectors(bdev);
>   	if (!is_power_of_2(zone_sectors)) {
>   		f2fs_err(sbi, "F2FS does not support non power of 2 zone sizes\n");

