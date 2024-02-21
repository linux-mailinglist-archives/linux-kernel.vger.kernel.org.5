Return-Path: <linux-kernel+bounces-73895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F187E85CD3B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E9A1F229F6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA041FDD;
	Wed, 21 Feb 2024 01:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/tx5f9n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44D664B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708477676; cv=none; b=PEclVlpYzynfhhT7WUCaxUOUgQU5LsSVlHzGvDdrUXaMn7HM9Ed79XhE2XSLbv3zHYzcUafHdGgicPmZnqKhtd0RitxJlTHVSoKlUYs91bmRz2jqE2r7zOjyh9GT8iMzdwRhGquH87GWm1siNn55GA0sBjqEWa4mP73LDChm9RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708477676; c=relaxed/simple;
	bh=vmRQfPzqIuouzmoHrBq7ioBylNkbZIncObihjwwPxGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2ry1J2aA+DCxVV6OYF/VVB2eyZsenb7WXXpXfxrTe8JqLH5r1xNgKUfSBaU76ixngOFHEOZ7a1vh6ut6Qr3j3ndSTW3PsUGJSWX5T49wWbCd3/e3N0GDSjxxxHadFp4U+LmtYFX4aGOF/cTTxUHY8c2ZPRpLpXXUOElml2bOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/tx5f9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CB1C433C7;
	Wed, 21 Feb 2024 01:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708477676;
	bh=vmRQfPzqIuouzmoHrBq7ioBylNkbZIncObihjwwPxGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V/tx5f9njLOuMv7MjcdIwYchMrDjQO3WRV1A8QuAt9C6uWcjwkGWE/s5WDoDKDPET
	 8a2m+Z+oLlLqPdtvhn8E3lCAU3uMCKCjCm8iHWD8mriO+Zdmm1cHzDsMteYHMsV7WB
	 8wUIh3XnPjfjwijo2sS2KulJwzWTWPPhV4SInzIVMoe0E0odcBxPm07lJFH3ayuDHm
	 Gj64K0QGaibRx79TyzygA0s93avupO9YZTOj/MjlG6z2R54b63ACih4wggSzB3lcNr
	 ASuxDWuyom1cXsxDbjC2PO8z+Jxy5vh41VEhGVEdDCPNOsZS40Wx7TS2hRcqCoDPDw
	 a72y3FcJhCYgg==
Message-ID: <7e4d4e3f-4933-426c-9a8d-a96c8a052499@kernel.org>
Date: Wed, 21 Feb 2024 09:07:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: support compress extension update via sysfs
 interface
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Sheng Yong <shengyong@oppo.com>
References: <20240207062546.3083870-1-chao@kernel.org>
 <ZcQbRzyvb8MNeOMB@google.com>
 <74933d5b-449e-4061-9571-799acbc42b43@kernel.org>
 <ZdT9ZmbCqMNk2nU4@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZdT9ZmbCqMNk2nU4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/21 3:28, Jaegeuk Kim wrote:
> On 02/19, Chao Yu wrote:
>> On 2024/2/8 8:07, Jaegeuk Kim wrote:
>>> On 02/07, Chao Yu wrote:
>>>> Introduce /sys/fs/f2fs/<disk>/compress_extension to support
>>>> adding/deleting compress extension via sysfs interface, in
>>>> comparison to mount option, it's more easy to use and less
>>>> authority issue for applications.
>>>>
>>>> Usage:
>>>> - Query: cat /sys/fs/f2fs/<disk>/compress_extension
>>>> - Add: echo '[c|n]extension' > /sys/fs/f2fs/<disk>/compress_extension
>>>> - Del: echo '[c|n]!extension' > /sys/fs/f2fs/<disk>/compress_extension
>>>> - [c] means add/del compress extension
>>>> - [n] means add/del nocompress extension
>>>>
>>>> Signed-off-by: Sheng Yong <shengyong@oppo.com>
>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>> ---
>>>>    Documentation/ABI/testing/sysfs-fs-f2fs | 10 ++++
>>>>    Documentation/filesystems/f2fs.rst      |  6 ++-
>>>>    fs/f2fs/compress.c                      | 61 +++++++++++++++++++++++
>>>>    fs/f2fs/f2fs.h                          |  4 +-
>>>>    fs/f2fs/sysfs.c                         | 65 +++++++++++++++++++++++--
>>>>    5 files changed, 139 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>>>> index 48c135e24eb5..1f2cc0913e45 100644
>>>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>>>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>>>> @@ -762,3 +762,13 @@ Date:		November 2023
>>>>    Contact:	"Chao Yu" <chao@kernel.org>
>>>>    Description:	It controls to enable/disable IO aware feature for background discard.
>>>>    		By default, the value is 1 which indicates IO aware is on.
>>>> +
>>>> +What:		/sys/fs/f2fs/<disk>/compress_extension
>>>> +Date:		October 2023
>>>> +Contact:	"Chao Yu" <chao@kernel.org>
>>>> +Description:	Used to control configure [|no]compress_extension list:
>>>> +		- Query: cat /sys/fs/f2fs/<disk>/compress_extension
>>>> +		- Add: echo '[c|n]extension' > /sys/fs/f2fs/<disk>/compress_extension
>>>> +		- Del: echo '[c|n]!extension' > /sys/fs/f2fs/<disk>/compress_extension
>>>> +		- [c] means add/del compress extension
>>>> +		- [n] means add/del nocompress extension
>>>> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
>>>> index 32cbfa864f38..c82a8fd7316b 100644
>>>> --- a/Documentation/filesystems/f2fs.rst
>>>> +++ b/Documentation/filesystems/f2fs.rst
>>>> @@ -821,17 +821,19 @@ Compression implementation
>>>>      all logical blocks in cluster contain valid data and compress ratio of
>>>>      cluster data is lower than specified threshold.
>>>> -- To enable compression on regular inode, there are four ways:
>>>> +- To enable compression on regular inode, there are five ways:
>>>>      * chattr +c file
>>>>      * chattr +c dir; touch dir/file
>>>>      * mount w/ -o compress_extension=ext; touch file.ext
>>>>      * mount w/ -o compress_extension=*; touch any_file
>>>> +  * echo '[c]ext' > /sys/fs/f2fs/<disk>/compress_extension; touch file.ext
>>>> -- To disable compression on regular inode, there are two ways:
>>>> +- To disable compression on regular inode, there are three ways:
>>>>      * chattr -c file
>>>>      * mount w/ -o nocompress_extension=ext; touch file.ext
>>>> +  * echo '[n]ext' > /sys/fs/f2fs/<disk>/compress_extension; touch file.ext
>>>>    - Priority in between FS_COMPR_FL, FS_NOCOMP_FS, extensions:
>>>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>>>> index 3dc488ce882b..a5257882c772 100644
>>>> --- a/fs/f2fs/compress.c
>>>> +++ b/fs/f2fs/compress.c
>>>> @@ -20,6 +20,67 @@
>>>>    #include "segment.h"
>>>>    #include <trace/events/f2fs.h>
>>>> +static int is_compress_extension_exist(struct f2fs_sb_info *sbi,
>>>> +				unsigned char (*ext)[F2FS_EXTENSION_LEN],
>>>> +				int ext_cnt, unsigned char *new_ext)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < ext_cnt; i++) {
>>>> +		if (!strcasecmp(new_ext, ext[i]))
>>>> +			return i;
>>>> +	}
>>>> +	return -1;
>>>> +}
>>>> +
>>>> +int f2fs_update_compress_extension(struct f2fs_sb_info *sbi,
>>>> +				unsigned char *new_ext, bool is_ext, bool set)
>>>> +{
>>>> +	unsigned char (*ext)[F2FS_EXTENSION_LEN];
>>>> +	unsigned char *ext_cnt;
>>>> +
>>>> +	if (is_ext) {
>>>> +		ext = F2FS_OPTION(sbi).extensions;
>>>> +		ext_cnt = &F2FS_OPTION(sbi).compress_ext_cnt;
>>>> +	} else {
>>>> +		ext = F2FS_OPTION(sbi).noextensions;
>>>> +		ext_cnt = &F2FS_OPTION(sbi).nocompress_ext_cnt;
>>>> +	}
>>>> +
>>>> +	if (set) {
>>>> +		if (*ext_cnt >= COMPRESS_EXT_NUM)
>>>> +			return -EINVAL;
>>>> +
>>>> +		if (is_compress_extension_exist(sbi,
>>>> +					F2FS_OPTION(sbi).extensions,
>>>> +					F2FS_OPTION(sbi).compress_ext_cnt,
>>>> +					new_ext) >= 0)
>>>> +			return -EEXIST;
>>>> +
>>>> +		if (is_compress_extension_exist(sbi,
>>>> +					F2FS_OPTION(sbi).noextensions,
>>>> +					F2FS_OPTION(sbi).nocompress_ext_cnt,
>>>> +					new_ext) >= 0)
>>>> +			return -EEXIST;
>>>> +
>>>> +		strcpy(ext[*ext_cnt], new_ext);
>>>> +		(*ext_cnt)++;
>>>> +	} else {
>>>> +		int pos = is_compress_extension_exist(sbi, ext,
>>>> +						*ext_cnt, new_ext);
>>>> +		if (pos < 0)
>>>> +			return -ENOENT;
>>>> +
>>>> +		if (pos < *ext_cnt - 1)
>>>> +			memmove(ext + pos, ext + pos + 1,
>>>> +				F2FS_EXTENSION_LEN * (*ext_cnt - pos - 1));
>>>> +		memset(ext + *ext_cnt - 1, 0, F2FS_EXTENSION_LEN);
>>>> +		(*ext_cnt)--;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    static struct kmem_cache *cic_entry_slab;
>>>>    static struct kmem_cache *dic_entry_slab;
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index c5e7460d1a0a..d44e2c43d8ab 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -186,7 +186,7 @@ struct f2fs_mount_info {
>>>>    	unsigned char compress_level;		/* compress level */
>>>>    	bool compress_chksum;			/* compressed data chksum */
>>>>    	unsigned char compress_ext_cnt;		/* extension count */
>>>> -	unsigned char nocompress_ext_cnt;		/* nocompress extension count */
>>>> +	unsigned char nocompress_ext_cnt;	/* nocompress extension count */
>>>>    	int compress_mode;			/* compression mode */
>>>>    	unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN];	/* extensions */
>>>>    	unsigned char noextensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN]; /* extensions */
>>>> @@ -4273,6 +4273,8 @@ static inline bool f2fs_post_read_required(struct inode *inode)
>>>>     * compress.c
>>>>     */
>>>>    #ifdef CONFIG_F2FS_FS_COMPRESSION
>>>> +int f2fs_update_compress_extension(struct f2fs_sb_info *sbi,
>>>> +				unsigned char *new_ext, bool is_ext, bool set);
>>>>    bool f2fs_is_compressed_page(struct page *page);
>>>>    struct page *f2fs_compress_control_page(struct page *page);
>>>>    int f2fs_prepare_compress_overwrite(struct inode *inode,
>>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>>> index a7ec55c7bb20..a8f05a02e202 100644
>>>> --- a/fs/f2fs/sysfs.c
>>>> +++ b/fs/f2fs/sysfs.c
>>>> @@ -39,6 +39,7 @@ enum {
>>>>    	RESERVED_BLOCKS,	/* struct f2fs_sb_info */
>>>>    	CPRC_INFO,	/* struct ckpt_req_control */
>>>>    	ATGC_INFO,	/* struct atgc_management */
>>>> +	MOUNT_INFO,	/* struct f2fs_mount_info */
>>>>    };
>>>>    static const char *gc_mode_names[MAX_GC_MODE] = {
>>>> @@ -89,6 +90,8 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
>>>>    		return (unsigned char *)&sbi->cprc_info;
>>>>    	else if (struct_type == ATGC_INFO)
>>>>    		return (unsigned char *)&sbi->am;
>>>> +	else if (struct_type == MOUNT_INFO)
>>>> +		return (unsigned char *)&F2FS_OPTION(sbi);
>>>>    	return NULL;
>>>>    }
>>>> @@ -358,6 +361,25 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
>>>>    	if (!strcmp(a->attr.name, "compr_new_inode"))
>>>>    		return sysfs_emit(buf, "%u\n", sbi->compr_new_inode);
>>>> +
>>>> +	if (!strcmp(a->attr.name, "compress_extension")) {
>>>> +		int len = 0, i;
>>>> +
>>>> +		f2fs_down_read(&sbi->sb_lock);
>>>> +		len += scnprintf(buf + len, PAGE_SIZE - len,
>>>> +						"compress extension:\n");
>>>> +		for (i = 0; i < F2FS_OPTION(sbi).compress_ext_cnt; i++)
>>>> +			len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n",
>>>> +					F2FS_OPTION(sbi).extensions[i]);
>>>> +
>>>> +		len += scnprintf(buf + len, PAGE_SIZE - len,
>>>> +						"nocompress extension:\n");
>>>> +		for (i = 0; i < F2FS_OPTION(sbi).nocompress_ext_cnt; i++)
>>>> +			len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n",
>>>> +					F2FS_OPTION(sbi).noextensions[i]);
>>>
>>> I don't think this is acceptable in sysfs.
>>
>> It looks block layer output similar string:
>>
>> cat /sys/block/<dev>/queue/scheduler
>> mq-deadline kyber [bfq] none
>>
>> Or, can we add extension entries into /sys/fs/f2fs/<dev>/compress_extensions/
>> directory? like feature entries in /sys/fs/f2fs/<dev>/feature_list/.
>>
>> e.g.
>>
>> ls /sys/fs/f2fs/<dev>/compress_extensions/
>> so dex
>>
>> Show enable/disable to indicate current extension is in
>> compress_extension/nocompress_extension array.
>>
>> cat /sys/fs/f2fs/<dev>/compress_extensions/so
>> enable
>>
>> cat /sys/fs/f2fs/<dev>/compress_extensions/dex
>> disable
> 
> How about adding all the file extentions in a separate entries and eash showing
> the hot/cold/compression information together?

Ah, better,

If there is no objection, I'd like to add an extra 'extensions' directory
into /sys/fs/f2fs/<dev>/, and add all file extensions as separated entries
under 'extensions' directory.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>> +		f2fs_up_read(&sbi->sb_lock);
>>>> +		return len;
>>>> +	}
>>>>    #endif
>>>>    	if (!strcmp(a->attr.name, "gc_segment_mode"))
>>>> @@ -446,6 +468,35 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>>>>    		return ret ? ret : count;
>>>>    	}
>>>> +#ifdef CONFIG_F2FS_FS_COMPRESSION
>>>> +	if (!strcmp(a->attr.name, "compress_extension")) {
>>>> +		char *name = strim((char *)buf);
>>>> +		bool set = true, cmpr;
>>>> +
>>>> +		if (!strncmp(name, "[c]", 3))
>>>> +			cmpr = true;
>>>> +		else if (!strncmp(name, "[n]", 3))
>>>> +			cmpr = false;
>>>> +		else
>>>> +			return -EINVAL;
>>>> +
>>>> +		name += 3;
>>>> +
>>>> +		if (*name == '!') {
>>>> +			name++;
>>>> +			set = false;
>>>> +		}
>>>> +
>>>> +		if (!strlen(name) || strlen(name) >= F2FS_EXTENSION_LEN)
>>>> +			return -EINVAL;
>>>> +
>>>> +		f2fs_down_write(&sbi->sb_lock);
>>>> +		ret = f2fs_update_compress_extension(sbi, name, cmpr, set);
>>>> +		f2fs_up_write(&sbi->sb_lock);
>>>> +		return ret ? ret : count;
>>>> +	}
>>>> +#endif
>>>> +
>>>>    	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
>>>>    		const char *name = strim((char *)buf);
>>>>    		struct ckpt_req_control *cprc = &sbi->cprc_info;
>>>> @@ -785,15 +836,16 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>>>>    			const char *buf, size_t count)
>>>>    {
>>>>    	ssize_t ret;
>>>> -	bool gc_entry = (!strcmp(a->attr.name, "gc_urgent") ||
>>>> -					a->struct_type == GC_THREAD);
>>>> +	bool need_lock = (!strcmp(a->attr.name, "gc_urgent") ||
>>>> +					a->struct_type == GC_THREAD ||
>>>> +					a->struct_type == MOUNT_INFO);
>>>> -	if (gc_entry) {
>>>> +	if (need_lock) {
>>>>    		if (!down_read_trylock(&sbi->sb->s_umount))
>>>>    			return -EAGAIN;
>>>>    	}
>>>>    	ret = __sbi_store(a, sbi, buf, count);
>>>> -	if (gc_entry)
>>>> +	if (need_lock)
>>>>    		up_read(&sbi->sb->s_umount);
>>>>    	return ret;
>>>> @@ -942,6 +994,9 @@ static struct f2fs_attr f2fs_attr_##name = __ATTR(name, 0444, name##_show, NULL)
>>>>    #define ATGC_INFO_RW_ATTR(name, elname)				\
>>>>    	F2FS_RW_ATTR(ATGC_INFO, atgc_management, name, elname)
>>>> +#define MOUNT_INFO_RW_ATTR(name, elname)			\
>>>> +	F2FS_RW_ATTR(MOUNT_INFO, f2fs_mount_info, name, elname)
>>>> +
>>>>    /* GC_THREAD ATTR */
>>>>    GC_THREAD_RW_ATTR(gc_urgent_sleep_time, urgent_sleep_time);
>>>>    GC_THREAD_RW_ATTR(gc_min_sleep_time, min_sleep_time);
>>>> @@ -1008,6 +1063,7 @@ F2FS_SBI_GENERAL_RW_ATTR(compr_saved_block);
>>>>    F2FS_SBI_GENERAL_RW_ATTR(compr_new_inode);
>>>>    F2FS_SBI_GENERAL_RW_ATTR(compress_percent);
>>>>    F2FS_SBI_GENERAL_RW_ATTR(compress_watermark);
>>>> +MOUNT_INFO_RW_ATTR(compress_extension, extensions);
>>>>    #endif
>>>>    /* atomic write */
>>>>    F2FS_SBI_GENERAL_RO_ATTR(current_atomic_write);
>>>> @@ -1181,6 +1237,7 @@ static struct attribute *f2fs_attrs[] = {
>>>>    	ATTR_LIST(compr_new_inode),
>>>>    	ATTR_LIST(compress_percent),
>>>>    	ATTR_LIST(compress_watermark),
>>>> +	ATTR_LIST(compress_extension),
>>>>    #endif
>>>>    	/* For ATGC */
>>>>    	ATTR_LIST(atgc_candidate_ratio),
>>>> -- 
>>>> 2.40.1

