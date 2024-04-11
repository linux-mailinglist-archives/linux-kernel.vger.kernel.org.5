Return-Path: <linux-kernel+bounces-140160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D178A0C33
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF7E1F21AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A3D14431D;
	Thu, 11 Apr 2024 09:21:10 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D228913CF91;
	Thu, 11 Apr 2024 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827269; cv=none; b=ESmaZFOEtddNHc5Ir1j+xTABqpG9V2xfrP/O+3u0Sq3oy1bEuoEcxRTl5R2wm+ZK2m/zOmiFmUrUeQd9cactEFm+/4Pp6VJIf7DiZEjmuaC+s6aJbvbEqcN0DrZHj5FGcle91ejtjH9lytUXwvP83K8Ete/q5e2UIlRbD7CIvX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827269; c=relaxed/simple;
	bh=vMip6sgICuC04GvZbjwcdVeG7Rk0YTkyr5l+fJFWK7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ifDd2iN/NpKW4DtGUeecz6+So1+KyeGXB911bg1+jII4U2PMmkp4mbmRfGxb/3RxS5Q+Okq4KHBS6d6KJ0F7jyIz9EU2yt7KhMByKvqi4P0m3AIHg5tpZGukXxCxXtY8+a88Uk1W1+AxNBG/PLih2BjnhwQ7VfRx8J/2ZNDWBnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VFYyh755wztSJc;
	Thu, 11 Apr 2024 17:18:20 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id A58E2140156;
	Thu, 11 Apr 2024 17:21:05 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 17:21:05 +0800
Message-ID: <a2683fad-07db-4857-9ebf-7adf31a09e50@huawei.com>
Date: Thu, 11 Apr 2024 17:21:05 +0800
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

Also, I am curious why such spelling errors cannot be detected at the 
compilation stage.

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

