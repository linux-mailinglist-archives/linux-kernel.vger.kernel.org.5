Return-Path: <linux-kernel+bounces-70136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1B08593D8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B141F21E28
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9B64C7C;
	Sun, 18 Feb 2024 01:26:02 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01574A24
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 01:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708219561; cv=none; b=TavD1s2vuR10laBmDjdTGtP6cVjBu03UA4M0PthMXJn9PsDqhDBrnOEGxs6EKorjiQsAZTWwQUNNxmk5tHkLBFKfpYbrWy+3zT0X4z1jUF2f6ufcFATzsBUZufH63xdvtzqSMHXbU4yh5XqhCxKmaTM5s2KXo89fnrJwIbAIaQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708219561; c=relaxed/simple;
	bh=TZjic76A8kuTdFOi//kqSuC2cW56oelgKFo7TvSy1y4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MN1DuuTLAvizQZ/cG37cp6TyzxmFGCfdYnFefKvCyhMWu9c9rnSh+yoHkrEmK8slW/0xRPbW3oqyQjs2NHtFb6awvjO3XHdQmMnAy293BEARoDqaM/XEmp+3bkJfl+MzN6d19kv0/547HDoTC8e+i+xSA7dWCKXh04Va2qGaxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TcnyY2Fwxz1xnZm;
	Sun, 18 Feb 2024 09:24:37 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 4193D140157;
	Sun, 18 Feb 2024 09:25:56 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 09:25:55 +0800
Subject: Re: [PATCH 1/2] ubifs: fix sort function prototype
To: Arnd Bergmann <arnd@kernel.org>, Richard Weinberger <richard@nod.at>,
	Nathan Chancellor <nathan@kernel.org>, Adrian Hunter
	<ext-adrian.hunter@nokia.com>, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
CC: Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20240213095412.453787-1-arnd@kernel.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e9687d56-1ee4-37ee-4a0e-d0b7933f3353@huawei.com>
Date: Sun, 18 Feb 2024 09:25:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240213095412.453787-1-arnd@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/2/13 17:54, Arnd Bergmann Ð´µÀ:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The global sort() function expects a callback pointer to a function with two
> void* arguments, but ubifs has a function with specific object types, which
> causes a warning in clang-16 and higher:
> 
> fs/ubifs/lprops.c:1272:9: error: cast from 'int (*)(struct ubifs_info *, const struct ubifs_lprops *, int, struct ubifs_lp_stats *)' to 'ubifs_lpt_scan_callback' (aka 'int (*)(struct ubifs_info *, const struct ubifs_lprops *, int, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>   1272 |                                     (ubifs_lpt_scan_callback)scan_check_cb,
>        |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Change the prototype to the regular one and cast the object pointers
> locally instead.
> 
> Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   fs/ubifs/find.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/ubifs/find.c b/fs/ubifs/find.c
> index 873e6e1c92b5..1cb79b167a4f 100644
> --- a/fs/ubifs/find.c
> +++ b/fs/ubifs/find.c
> @@ -726,11 +726,10 @@ int ubifs_find_free_leb_for_idx(struct ubifs_info *c)
>   	return err;
>   }
>   
> -static int cmp_dirty_idx(const struct ubifs_lprops **a,
> -			 const struct ubifs_lprops **b)
> +static int cmp_dirty_idx(const void *a, const void *b)
>   {
> -	const struct ubifs_lprops *lpa = *a;
> -	const struct ubifs_lprops *lpb = *b;
> +	const struct ubifs_lprops *lpa = *(const struct ubifs_lprops **)a;
> +	const struct ubifs_lprops *lpb = *(const struct ubifs_lprops **)b;
>   
>   	return lpa->dirty + lpa->free - lpb->dirty - lpb->free;
>   }
> @@ -754,7 +753,7 @@ int ubifs_save_dirty_idx_lnums(struct ubifs_info *c)
>   	       sizeof(void *) * c->dirty_idx.cnt);
>   	/* Sort it so that the dirtiest is now at the end */
>   	sort(c->dirty_idx.arr, c->dirty_idx.cnt, sizeof(void *),
> -	     (int (*)(const void *, const void *))cmp_dirty_idx, NULL);
> +	     cmp_dirty_idx, NULL);
>   	dbg_find("found %d dirty index LEBs", c->dirty_idx.cnt);
>   	if (c->dirty_idx.cnt)
>   		dbg_find("dirtiest index LEB is %d with dirty %d and free %d",
> 


