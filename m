Return-Path: <linux-kernel+bounces-134149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC82589AE41
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7898282726
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407ED748F;
	Sun,  7 Apr 2024 03:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huvBeV5Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6627460
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 03:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712460034; cv=none; b=eTjy/UhzDKvlr26nxAhuqBzS5zdM5h6KVsZY75qUukjXaDXvDZlsJXl14paphdG7W4jsPk6HqKQ1pTOYOh0lAVr5xXTfM/BP9LNyOQ+CgYi+TQwKsXCZZn1N4M4+cWBLpPWLksMbcAMdRXGov2i3l9ESoG8YKCH1PNo0DsrpNjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712460034; c=relaxed/simple;
	bh=b9Tc4eovGDofZDA3f8IXjRzPGaiAXdbUqV5UzjNB+5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkXfEV5KJ82oRQZiqQab2tW2xWNkPveLrjceujqcsk5dfH8QrjNxUVBYzG3XwlfmEQ1PP7Hzc8YgYzG+4nZeSqtdfDMRPmhfY7h/nxfH32LKXyZbez4//kkN8/YL9ojvwXO9AGPY51jk9Z2ei8ZJKA2GjaibU6y7uehmmCOStMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huvBeV5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE33C433C7;
	Sun,  7 Apr 2024 03:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712460034;
	bh=b9Tc4eovGDofZDA3f8IXjRzPGaiAXdbUqV5UzjNB+5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=huvBeV5QNo4hti68EKlCE7KbV8DE7YP93IjNmjsGEfLXk3KWeJg2OkAZG7MenXrSE
	 BSwuUOvNwWZ0AlmYFkzA2iYDdyL37mARklEzx9jDlqgqaqA1Rq3GsDwjMy1rnrMOTv
	 fD4L9MslPHsq+QnHRPlEuu3qTT4ulFsjU+dQCEf29k0lLkOFOQj4egIk5UtQ0JKfX1
	 qgkwMYN4C7RtZ53YwBer52WU6b2Da0rxOn2odLic3VYwbMq25GwKrdbW1OxJqs/+wS
	 ZpOnO1th1nTuh0ktGHMyrtFw7N9JIkDpz6FEFfqgxyGLH9u/1nbpKM/9FSd+09ihWS
	 hZl1reuBKxucA==
Message-ID: <302e8f2c-74a2-4476-b71a-87f818fea919@kernel.org>
Date: Sun, 7 Apr 2024 11:20:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: fix zoned block device information
 initialization
To: Daeho Jeong <daeho43@gmail.com>
Cc: jaegeuk@kernel.org, Wenjie Qi <qwjhust@gmail.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20240328072136.3023135-1-chao@kernel.org>
 <CACOAw_w0YgVtGGdb-2DQ6ROCc7YyXETWxWPiAB+D0qHt369fQQ@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_w0YgVtGGdb-2DQ6ROCc7YyXETWxWPiAB+D0qHt369fQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/5 2:20, Daeho Jeong wrote:
> On Thu, Mar 28, 2024 at 12:23 AM Chao Yu <chao@kernel.org> wrote:
>>
>> From: Wenjie Qi <qwjhust@gmail.com>
>>
>> If the max open zones of zoned devices are less than
>> the active logs of F2FS, the device may error due to
>> insufficient zone resources when multiple active logs
>> are being written at the same time.
>>
>> Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v6:
>> - add check condition to avoid remount failure.
>>   fs/f2fs/f2fs.h  |  1 +
>>   fs/f2fs/super.c | 27 +++++++++++++++++++++++++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 0550929dc6e5..694f8a52cb84 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1559,6 +1559,7 @@ struct f2fs_sb_info {
>>
>>   #ifdef CONFIG_BLK_DEV_ZONED
>>          unsigned int blocks_per_blkz;           /* F2FS blocks per zone */
>> +       unsigned int max_open_zones;            /* max open zone resources of the zoned device */
>>   #endif
>>
>>          /* for node-related operations */
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 7c45929671ad..642540782471 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -2326,6 +2326,17 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>          if (err)
>>                  goto restore_opts;
>>
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +       if (f2fs_is_multi_device(sbi) &&
> 
> Why do we check multiple devices' condition here?

Oh, it needs to check f2fs_sb_has_blkzoned(), right?

Thanks,

> 
> Thanks,
> 
>> +               sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
>> +               f2fs_err(sbi,
>> +                       "zoned: max open zones %u is too small, need at least %u open zones",
>> +                                sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
>> +               err = -EINVAL;
>> +               goto restore_opts;
>> +       }
>> +#endif
>> +
>>          /* flush outstanding errors before changing fs state */
>>          flush_work(&sbi->s_error_work);
>>
>> @@ -3868,11 +3879,24 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>>          sector_t nr_sectors = bdev_nr_sectors(bdev);
>>          struct f2fs_report_zones_args rep_zone_arg;
>>          u64 zone_sectors;
>> +       unsigned int max_open_zones;
>>          int ret;
>>
>>          if (!f2fs_sb_has_blkzoned(sbi))
>>                  return 0;
>>
>> +       if (bdev_is_zoned(FDEV(devi).bdev)) {
>> +               max_open_zones = bdev_max_open_zones(bdev);
>> +               if (max_open_zones && (max_open_zones < sbi->max_open_zones))
>> +                       sbi->max_open_zones = max_open_zones;
>> +               if (sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
>> +                       f2fs_err(sbi,
>> +                               "zoned: max open zones %u is too small, need at least %u open zones",
>> +                               sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>>          zone_sectors = bdev_zone_sectors(bdev);
>>          if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=
>>                                  SECTOR_TO_BLOCK(zone_sectors))
>> @@ -4186,6 +4210,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>>
>>          logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
>>          sbi->aligned_blksize = true;
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +       sbi->max_open_zones = UINT_MAX;
>> +#endif
>>
>>          for (i = 0; i < max_devices; i++) {
>>                  if (i == 0)
>> --
>> 2.40.1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

