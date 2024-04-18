Return-Path: <linux-kernel+bounces-149472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A4A8A9190
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75CFD1C2124E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520D652F6E;
	Thu, 18 Apr 2024 03:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRgqNGUR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D379D0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411195; cv=none; b=gNuTH5PGu0Nnkp/jR7HTMLiVghI+5ZrwF8G4pwpCFXWaMod5RZUnktNca4sgNs+iBbUlSuedAzUp3/NP38QYD0xe7h+zvspek2dZrzKmk6VGvHNmhxa6tQwI9p14yIxTIu+K4PKrTo+25KgUDqgm26YG37thiTRRJjmTcT/Jk6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411195; c=relaxed/simple;
	bh=uqbQDcCb4KtLmSPyByi5T+QvrKt80hHMqNZ40UdU0vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VC2CExeWciyKDGlVk9IMVJwDrbb/rtSXkcT+Vp2O0oO2uef+FoRuE3lzlhYrRM16RfHd+SxeDvMfKVpld+2j1/KOvfvSVC9ICXveppqLpUSm5DmDSs+a7kv4gNUIJ4tA+SHk37hfJRhMV0dR1dO9taPRQtjRljtJPiyR/atuJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRgqNGUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2669BC113CC;
	Thu, 18 Apr 2024 03:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713411194;
	bh=uqbQDcCb4KtLmSPyByi5T+QvrKt80hHMqNZ40UdU0vc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=dRgqNGURsqtAA0Mdlc6wSAa//R5K24gE0urmQwsqC6laE1V9BwIpcYiW9SK3l/HeO
	 13SQUSvG9PIme4jJ02Xjo3no3/WiBdk12vJHNXdRvc0+IUs0H4q1/WXzusJERVDWvL
	 b1eb13R4qGIc1rkLglnOWmnWo/Hxff/5Wi1WFbsB/dHeEizNWpwqTj6Y1Z6LUnmoYb
	 L9GDcC/Nh0wGKGDTsStSwgNM0PUoVQFsvTderYxv58j6Ivx/h5N9N5h22wm8z2dIjs
	 S97SR1WEUnoK3GvXRozrJqlQzUuUk9tDO6Jg8W5OxQaKuSChKbmQNs/iaoQTLFkoaw
	 FvII62FVILczw==
Message-ID: <afe91331-92a5-4ccf-b5b3-095a2d65f0d0@kernel.org>
Date: Thu, 18 Apr 2024 11:33:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: assign the write hint per stream by
 default
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240417211201.3919770-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240417211201.3919770-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/18 5:12, Jaegeuk Kim wrote:
> This reverts commit 930e2607638d ("f2fs: remove obsolete whint_mode"), as we
> decide to pass write hints to the disk.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   Documentation/filesystems/f2fs.rst | 29 +++++++++++++++
>   fs/f2fs/data.c                     |  2 +
>   fs/f2fs/f2fs.h                     |  2 +
>   fs/f2fs/segment.c                  | 59 ++++++++++++++++++++++++++++++
>   4 files changed, 92 insertions(+)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index efc3493fd6f8..68a0885fb5e6 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -774,6 +774,35 @@ In order to identify whether the data in the victim segment are valid or not,
>   F2FS manages a bitmap. Each bit represents the validity of a block, and the
>   bitmap is composed of a bit stream covering whole blocks in main area.
>   
> +Write-hint Policy
> +-----------------
> +
> +F2FS sets the whint all the time with the below policy.

No user-based mode?

Thanks,

> +
> +===================== ======================== ===================
> +User                  F2FS                     Block
> +===================== ======================== ===================
> +N/A                   META                     WRITE_LIFE_NONE|REQ_META
> +N/A                   HOT_NODE                 WRITE_LIFE_NONE
> +N/A                   WARM_NODE                WRITE_LIFE_MEDIUM
> +N/A                   COLD_NODE                WRITE_LIFE_LONG
> +ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
> +extension list        "                        "
> +
> +-- buffered io
> +N/A                   COLD_DATA                WRITE_LIFE_EXTREME
> +N/A                   HOT_DATA                 WRITE_LIFE_SHORT
> +N/A                   WARM_DATA                WRITE_LIFE_NOT_SET
> +
> +-- direct io
> +WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
> +WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
> +WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
> +WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
> +WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
> +WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
> +===================== ======================== ===================
> +
>   Fallocate(2) Policy
>   -------------------
>   
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 5d641fac02ba..ed7d08785fcf 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -465,6 +465,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
>   	} else {
>   		bio->bi_end_io = f2fs_write_end_io;
>   		bio->bi_private = sbi;
> +		bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi,
> +						fio->type, fio->temp);
>   	}
>   	iostat_alloc_and_bind_ctx(sbi, bio, NULL);
>   
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index dd530dc70005..b3b878acc86b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3745,6 +3745,8 @@ void f2fs_destroy_segment_manager(struct f2fs_sb_info *sbi);
>   int __init f2fs_create_segment_manager_caches(void);
>   void f2fs_destroy_segment_manager_caches(void);
>   int f2fs_rw_hint_to_seg_type(enum rw_hint hint);
> +enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
> +			enum page_type type, enum temp_type temp);
>   unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
>   			unsigned int segno);
>   unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index f0da516ba8dc..daa94669f7ee 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3364,6 +3364,65 @@ int f2fs_rw_hint_to_seg_type(enum rw_hint hint)
>   	}
>   }
>   
> +/*
> + * This returns write hints for each segment type. This hints will be
> + * passed down to block layer as below by default.
> + *
> + * User                  F2FS                     Block
> + * ----                  ----                     -----
> + *                       META                     WRITE_LIFE_NONE|REQ_META
> + *                       HOT_NODE                 WRITE_LIFE_NONE
> + *                       WARM_NODE                WRITE_LIFE_MEDIUM
> + *                       COLD_NODE                WRITE_LIFE_LONG
> + * ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
> + * extension list        "                        "
> + *
> + * -- buffered io
> + *                       COLD_DATA                WRITE_LIFE_EXTREME
> + *                       HOT_DATA                 WRITE_LIFE_SHORT
> + *                       WARM_DATA                WRITE_LIFE_NOT_SET
> + *
> + * -- direct io
> + * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
> + * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
> + * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
> + * WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
> + * WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
> + * WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
> + */
> +enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
> +				enum page_type type, enum temp_type temp)
> +{
> +	switch (type) {
> +	case DATA:
> +		switch (temp) {
> +		case WARM:
> +			return WRITE_LIFE_NOT_SET;
> +		case HOT:
> +			return WRITE_LIFE_SHORT;
> +		case COLD:
> +			return WRITE_LIFE_EXTREME;
> +		default:
> +			return WRITE_LIFE_NONE;
> +		}
> +	case NODE:
> +		switch (temp) {
> +		case WARM:
> +			return WRITE_LIFE_MEDIUM;
> +		case HOT:
> +			return WRITE_LIFE_NONE;
> +		case COLD:
> +			return WRITE_LIFE_LONG;
> +		default:
> +			return WRITE_LIFE_NONE;
> +		}
> +	case META:
> +		return WRITE_LIFE_NONE;
> +	default:
> +		return WRITE_LIFE_NONE;
> +	}
> +}
> +
>   static int __get_segment_type_2(struct f2fs_io_info *fio)
>   {
>   	if (fio->type == DATA)

