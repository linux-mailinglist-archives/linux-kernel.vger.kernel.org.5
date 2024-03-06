Return-Path: <linux-kernel+bounces-93205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E2E872C53
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC40B1F21BED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B1F7499;
	Wed,  6 Mar 2024 01:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIXCiskZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF516FBD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 01:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689725; cv=none; b=QA/PQwn5YXBvZ7Hcumokmg8Nz5DSLli/d4QtlmR5M0ofcPACMAqIwjBocDh/tKsxtRreyIh/8R6FI4r6OfnTabKxxioTmXHAyuF52M2dz0aAahKksnb4sabqzGuVadd16YpiAeI3aFtQB6+KScvx4rzPdMIfeccLh6Wgw8buRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689725; c=relaxed/simple;
	bh=rgKLOGz+NBarhLpk4OYzhz7bVkPRRMgs5+kz/74cL04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=joJQV3RHqxRxSjB1eAji7mNgXXRcfWggoVF1enJt4MVPRTILn69XRz10mLDzUphr0CDSwlKQ+i5xH0RnrBQ/7N9g+eBV44Jb/7fDck6hbiDoU0umxfNlIhrEImt+iEuSB2LO+cPR+0W7gZtPamonGWvDFjWrAAj6ky8Lfo4f8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIXCiskZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF2EC433F1;
	Wed,  6 Mar 2024 01:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709689725;
	bh=rgKLOGz+NBarhLpk4OYzhz7bVkPRRMgs5+kz/74cL04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UIXCiskZ/y54tEmBjW0vVX4foThN0YH730WROKu2nTnEiJvPtflWx/QkFwLiQ4ZhK
	 dDVGP9Oq9qsNWAVA3vwTqH8WLQTmPyZVY6fs0X12+zYD0VQQQCkAF7r80qGVofz7rh
	 OAS0WQNQDZ/YUsjgtBlwKEuodBjvFzNJNN1fKWuMyTu5UuP5/b0BELVF/+0bpt3DVQ
	 XZfpV7TS4h7vLfgZZbyUWNOt3t/ji5Fy/JBdQVciAPMs0QFviJiuoLCE9HoUfwUNw/
	 VXxjUd/xecb0RRQk0KpjPUuDX5ckvPRYUAyGpyobLAfNEwGqkJciU0GBpLfoZuAMXN
	 YqbTG2sGxzBVA==
Message-ID: <3017291c-f600-4810-8d6e-8d9ef7a8d43f@kernel.org>
Date: Wed, 6 Mar 2024 09:48:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: Cast expression type to unsigned long in
 __count_extent_cache()
Content-Language: en-US
To: Roman Smirnov <r.smirnov@omp.ru>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, Karina Yankevich
 <k.yankevich@omp.ru>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240305080943.6922-1-r.smirnov@omp.ru>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240305080943.6922-1-r.smirnov@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/5 16:09, Roman Smirnov wrote:
> Cast expression type to unsigned long in __count_extent_cache()
> to prevent integer overflow.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
>   fs/f2fs/shrinker.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
> index 83d6fb97dcae..bb86a06c5d5e 100644
> --- a/fs/f2fs/shrinker.c
> +++ b/fs/f2fs/shrinker.c
> @@ -33,7 +33,7 @@ static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi,
>   {
>   	struct extent_tree_info *eti = &sbi->extent_tree[type];
>   
> -	return atomic_read(&eti->total_zombie_tree) +
> +	return (unsigned long)atomic_read(&eti->total_zombie_tree) +
>   				atomic_read(&eti->total_ext_node);
>   }
>   

