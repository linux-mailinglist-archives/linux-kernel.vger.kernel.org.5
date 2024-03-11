Return-Path: <linux-kernel+bounces-98440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24A1877A33
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D161F21E35
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F119187F;
	Mon, 11 Mar 2024 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZvzXiNj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662FA16FF4F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710129246; cv=none; b=HdkDIhanb5mK8meep+QNUxmVJuVEEOcsg7FeRnKSNAk6XhaFxmaX9p+HigbkzWX4UgUVY8vkV8AmTbsTLdZz+T5ZAA9Pg6B5br2ByTVFjDomvAsm2gb3ifUlclnZVmDhxPQOOdsOCmp13OtUuNqOF+uaj9l2Q+2l35uFgXSEwhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710129246; c=relaxed/simple;
	bh=1j9WPfieMKDOLQaDOS5Cyf1ofMxyJtJqnuJPUaavX2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFd5ln5aFU2N5YDf1C1/+c2hfqRC0WTmt2W0oHhEE79Gt/X5IkSjVevAu87kUvmsbWWewunzPkbWQoSJow/gGgl4S8rsHl2ZFZdezBHt1HuRHiLqg6NN542dF71qHss1JLvh8gwz5W1PaWrAnNkLHPdPJ/xp3laXAkGfGiDeXxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZvzXiNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBC6C433C7;
	Mon, 11 Mar 2024 03:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710129245;
	bh=1j9WPfieMKDOLQaDOS5Cyf1ofMxyJtJqnuJPUaavX2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hZvzXiNjsjR/mLRkE/q4I81NWyTDrFo0xIdWF/5dizanAOB9U7zt0jTzGX1PypYTx
	 R4EbNm3v2V6btBh4kiGSGeVqC4gO9kzuzOojCxCrsGCrUlmzSZnPoLAn/008qySkIR
	 QfUjIgcqsR8G0NcF8B/b76dLWwHIXNb2+mGmEHVJdnwNzD3E0ARmDxHv23Sa1o95Bi
	 9V/dCZ7w5Al9K/kpJP70kp7FvHOn3IvZq/Osv1uXq0BE+tvzEPX8ibzxZZZEYqyF7P
	 vmzkiY7J3nU7fTBviIZpFFMgcNyCuXMzVAaC+2VFjgxUiQ5h7Lpgy/B38iD3dNsoId
	 wWIhLVBq5OZiA==
Message-ID: <67a7f35d-5cc3-4b5f-968a-e4151c63eb74@kernel.org>
Date: Mon, 11 Mar 2024 11:54:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] f2fs: fix to remove f2fs_bug_on in add_bio_entry
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1709892753-27461-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1709892753-27461-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/8 18:12, Zhiguo Niu wrote:
> add_bio_entry should not trigger system panic when bio_add_page fail,
> fix to remove it.
> 
> Fixes: 0b20fcec8651 ("f2fs: cache global IPU bio")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/data.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d9494b5..f8ae684 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -759,8 +759,10 @@ static void add_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio,
>   	be->bio = bio;
>   	bio_get(bio);
>   
> -	if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE)
> -		f2fs_bug_on(sbi, 1);
> +	if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
> +		bio_put(bio);

I didn't get it, why new created bio has no space to store one page?

Thanks,

> +		return;
> +	}
>   
>   	f2fs_down_write(&io->bio_list_lock);
>   	list_add_tail(&be->list, &io->bio_list);

