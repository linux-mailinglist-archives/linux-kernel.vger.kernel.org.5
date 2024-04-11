Return-Path: <linux-kernel+bounces-140152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 167BA8A0C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4AD1F22868
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD51B14430C;
	Thu, 11 Apr 2024 09:17:05 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1436143C51;
	Thu, 11 Apr 2024 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827025; cv=none; b=PzS36SrMjDSiquqxBwRbpIXthvo7uuKQSIZOw2rMeg8Nsn4aZzp7dkbb0TE0nlTUC1f4CCFWjqXy6oicxxPZK5v0fVVH0AuhxmArJwORqKTdPafKLJeDE0DhqOmMTmB9lAPDMnOYAJC5knzYmyyV6rAd+NcRZEvW7Ly79R+k1oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827025; c=relaxed/simple;
	bh=l0t4D9s2/1QlWcjfS0uDVRP8x3YMT80ZWdmTgsPw7g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sUmBoTs2YiEMzPeuaKxKnrwZ7Y3MibGBJu1o/RxPEqlEp3xy7NUoT8bfDvdWUghScgRm+SnRN91jylkgfTkZuAjCymQoFhjTOxD67iaja/yPL7+JzbQx9Tq3moEHJK6WeWXjAv7H2eiSxJAYa9eFI2tNFLkoZmJZStRC7pI+VEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VFYsq0pNNz1RC7f;
	Thu, 11 Apr 2024 17:14:07 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F2AD1400C9;
	Thu, 11 Apr 2024 17:17:00 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 17:16:59 +0800
Message-ID: <11712bdc-9119-4ad2-b4ac-f6e2d0730134@huawei.com>
Date: Thu, 11 Apr 2024 17:16:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bcachefs: fix typo in reference to BCACHEFS_DEBUG
Content-Language: en-US
To: Lukas Bulwahn <lbulwahn@redhat.com>, Kent Overstreet
	<kent.overstreet@linux.dev>, Brian Foster <bfoster@redhat.com>,
	<linux-bcachefs@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lukas
 Bulwahn <lukas.bulwahn@redhat.com>
References: <20240411082931.56362-1-lukas.bulwahn@redhat.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240411082931.56362-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/4/11 16:29, Lukas Bulwahn wrote:
> Commit ec9cc18fc2e6 ("bcachefs: Add checks for invalid snapshot IDs")
> intends to check the sanity of a snapshot and panic when
> BCACHEFS_DEBUG is set, but that conditional has a typo.
> 
> Fix the typo to refer to the actual existing Kconfig symbol.
> 
> This was found with ./scripts/checkkconfigsymbols.py.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>   fs/bcachefs/snapshot.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/snapshot.h b/fs/bcachefs/snapshot.h
> index b7d2fed37c4f..3fdb41b33d2d 100644
> --- a/fs/bcachefs/snapshot.h
> +++ b/fs/bcachefs/snapshot.h
> @@ -77,7 +77,7 @@ static inline u32 __bch2_snapshot_parent(struct bch_fs *c, u32 id)
>   		return 0;
>   
>   	u32 parent = s->parent;
> -	if (IS_ENABLED(CONFIG_BCACHEFS_DEBU) &&
> +	if (IS_ENABLED(CONFIG_BCACHEFS_DEBUG) &&
>   	    parent &&
>   	    s->depth != snapshot_t(c, parent)->depth + 1)
>   		panic("id %u depth=%u parent %u depth=%u\n",

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

