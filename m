Return-Path: <linux-kernel+bounces-159800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DFA8B3441
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BDD1C2100D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2D713F450;
	Fri, 26 Apr 2024 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jr9lNuEO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD913C9A0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124232; cv=none; b=mPGqQHnkpskVYlZPGWUm7Ev/ABvncmi+p9Rf3Prmk/KeAfyYUI+BcAjsM78U0LON7U6Q6k2hhlY3OaHIW2iBk4SDl6ofK0S53G7cGXn6FZDAamb/XSnorwi8T7oF2aQw0LsieXYRzOOEDNjOAdk6e8d9eyQcoe4iRfUYEN0JdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124232; c=relaxed/simple;
	bh=P/GTw1XxjReEuD9Ww1RsUUzrNV6/qF1pdeMu8tj7+48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LcQB4lcrifv6XQ+RxCjSJ5URGGSACJjqRK+sSvtUPTNXyurDGicHnpvrRJCjGKpX19uV8H/IOs8t/sCMtkL8X0hM0guTaKV+kk6OzQ2rgy0fVdxoOXOog4N1nH/nJk8OFT4DFfwe1RurnoLnwnFJFZNBhu/6K9X0LMmvdjdKcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jr9lNuEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0886AC2BD10;
	Fri, 26 Apr 2024 09:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714124231;
	bh=P/GTw1XxjReEuD9Ww1RsUUzrNV6/qF1pdeMu8tj7+48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jr9lNuEOMS2DqrFPyu5S68MJZ5GqIrU58Lm1iTr7ajshWHlSGu4NSC7S+Wh7qgoLf
	 nBiDDBAGM7uD1/N1uurBI18fqYwsCxShr/DPNAw27+eZfaWge+whlBUZKmQvoUMUuF
	 z+/q4AwN0R1eUknJ2+T3+4oEcsQt+Nj5xHII/oA2K9O7fgo069jlMhfgvD2kPfFVDl
	 sFFOnwBuBm+CsBXL+cQkrIpEA57IadsDMXRoBF3JKF/VggDDu64O02HdINKOrYt8GY
	 +/q7rvkRZAp/WVrYm/BEAPP+1Z8Spv5lStRB+89Vl8ADJQieJ9Z6RCW1umZXCPlZn2
	 mphuzlHKnrw5Q==
Message-ID: <235d9db4-2ca5-4d7a-bd2a-36f98d1880a9@kernel.org>
Date: Fri, 26 Apr 2024 17:37:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: remove unnecessary block size check
 in init_f2fs_fs()
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240416072108.5819-1-chao@kernel.org>
 <20240416072108.5819-2-chao@kernel.org>
 <CAHJ8P3J4Z7QJ=kpd_Nt+TGX2ZD8HH5YQWmbPsbS7+DeN2NrxyA@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3J4Z7QJ=kpd_Nt+TGX2ZD8HH5YQWmbPsbS7+DeN2NrxyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/16 19:12, Zhiguo Niu wrote:
> On Tue, Apr 16, 2024 at 3:22 PM Chao Yu <chao@kernel.org> wrote:
>>
>> After commit d7e9a9037de2 ("f2fs: Support Block Size == Page Size"),
>> F2FS_BLKSIZE equals to PAGE_SIZE, remove unnecessary check condition.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/super.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 6d1e4fc629e2..32aa6d6fa871 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -4933,12 +4933,6 @@ static int __init init_f2fs_fs(void)
>>   {
>>          int err;
>>
>> -       if (PAGE_SIZE != F2FS_BLKSIZE) {
>> -               printk("F2FS not supported on PAGE_SIZE(%lu) != BLOCK_SIZE(%lu)\n",
>> -                               PAGE_SIZE, F2FS_BLKSIZE);
>> -               return -EINVAL;
>> -       }
>> -
>>          err = init_inodecache();
>>          if (err)
>>                  goto fail;
> Dear Chao,
> 
> Can you help modify the following  comment msg together with this patch?
> They are also related to commit d7e9a9037de2 ("f2fs: Support Block
> Size == Page Size").
> If you think there is a more suitable description, please help modify
> it directly.

Zhiguo,

I missed to reply this, I guess you can update
"f2fs: fix some ambiguous comments".

> thanks！
> 
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index a357287..241e7b18 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -394,7 +394,8 @@ struct f2fs_nat_block {
> 
>   /*
>    * F2FS uses 4 bytes to represent block address. As a result, supported size of
> - * disk is 16 TB and it equals to 16 * 1024 * 1024 / 2 segments.
> + * disk is 16 TB for a 4K page size and 64 TB for a 16K page size and it equals

disk is 16 TB for 4K size block and 64 TB for 16K size block and it equals
to (1 << 32) / 512 segments.

#define F2FS_MAX_SEGMENT       		((1 << 32) / 512)

Thanks,

> + * to 16 * 1024 * 1024 / 2 segments.
>    */
>   #define F2FS_MAX_SEGMENT       ((16 * 1024 * 1024) / 2)
> 
> @@ -424,8 +425,10 @@ struct f2fs_sit_block {
>   /*
>    * For segment summary
>    *
> - * One summary block contains exactly 512 summary entries, which represents
> - * exactly one segment by default. Not allow to change the basic units.
> + * One summary block with 4KB size contains exactly 512 summary entries, which
> + * represents exactly one segment with 2MB size.
> + * Similarly, in the case of 16k block size, it represents one
> segment with 8MB size.
> + * Not allow to change the basic units.
>    *
>    * NOTE: For initializing fields, you must use set_summary
>    *
> @@ -556,6 +559,7 @@ struct f2fs_summary_block {
> 
>   /*
>    * space utilization of regular dentry and inline dentry (w/o extra
> reservation)
> + * when block size is 4KB.
> 
> 
> 
>> --
>> 2.40.1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

