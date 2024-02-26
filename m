Return-Path: <linux-kernel+bounces-80402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE7A866812
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E611F218F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ABBDF44;
	Mon, 26 Feb 2024 02:12:52 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE5B33EC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708913572; cv=none; b=p/sKzs8xtGT47RPLIbJKZmjUCHRSp6Ma3GU41WH1r6W2fOAJ7de84bidcOgqEac5yK6E0BtCrcHGAgqOhhweL1/JDXinr7hUEdr300tvXU+HRUHDF5dquBesbjzo+UdjQIaYGr82PhqF9hxyPLsxqv9ypXjpMLwf7jBg/Pd7tdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708913572; c=relaxed/simple;
	bh=LNUSX5FlxjU+3VyGstxX//Kkk9TFDlSniR7R7kgkApY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OQbPK7VK9v6QtZ4MT5GX8+CO9Ur+iEWiJU+QkIm/zCWLBKNECzxRHgTXe3zUVKOu4HH/HiKmfgaM+xe2aYxRnCuB85gJnEUzwBDNTmqnWUOZAweNaE6cmMzOpFEkFdfBAo/zUXW/5ttVvo6CsLkRh+5wkgWZH8zBLbX2T3Y7ouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Tjkbt4VsQz1X3QJ;
	Mon, 26 Feb 2024 10:10:34 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id DE5981400D3;
	Mon, 26 Feb 2024 10:12:47 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 10:12:46 +0800
Subject: Re: [PATCH] ubifs: remove SLAB_MEM_SPREAD flag usage
To: <chengming.zhou@linux.dev>, <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <vbabka@suse.cz>, <roman.gushchin@linux.dev>,
	<Xiongwei.Song@windriver.com>, Chengming Zhou <zhouchengming@bytedance.com>
References: <20240224135217.830331-1-chengming.zhou@linux.dev>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <3384a81a-e6c9-6f2e-e66e-c9b9a9433c0f@huawei.com>
Date: Mon, 26 Feb 2024 10:12:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240224135217.830331-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/2/24 21:52, chengming.zhou@linux.dev Ð´µÀ:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>   fs/ubifs/super.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index f780729eec06..8ae7648021a8 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -2433,8 +2433,8 @@ static int __init ubifs_init(void)
>   
>   	ubifs_inode_slab = kmem_cache_create("ubifs_inode_slab",
>   				sizeof(struct ubifs_inode), 0,
> -				SLAB_MEM_SPREAD | SLAB_RECLAIM_ACCOUNT |
> -				SLAB_ACCOUNT, &inode_slab_ctor);
> +				SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
> +				&inode_slab_ctor);
>   	if (!ubifs_inode_slab)
>   		return -ENOMEM;
>   
> 


