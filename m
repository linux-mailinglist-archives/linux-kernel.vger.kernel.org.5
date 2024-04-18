Return-Path: <linux-kernel+bounces-149382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF1E8A905F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D43B1F21C53
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C80C8F59;
	Thu, 18 Apr 2024 01:09:53 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0664411;
	Thu, 18 Apr 2024 01:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402592; cv=none; b=kk4c7Zk/FG7fIMITSesDJrIRYNCCn4tChmSRK1opd/nlFF8fRIQ940FEotVXyyQJ1kY1ubiJ8T5vWpXx8z9f1jaLx318zUIc0zRxn4N2s4lxSkvlK025ornCeMRUmpQsR8BMFKNHP2/T1PkhC88DUuQK3JzBP4diHQ2lSRQEZaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402592; c=relaxed/simple;
	bh=lvGFpFWG/c5SJn5k6EpKDjuGe+uh1Zqt7Kd70bAY8Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GIy2MUIsHcaTt2pOjOlcaBhz4NgVO9a685i4QWUDVYLyz4ER6t3o9v058B3efMte5vkW4xbJNRWnTGpO82qjO8ZHjrusXlbpGBGl1Z38G7gzCSIBYY00BCk1Ux2sAfLfBgEz6xwR5CCv33QCtaTOf75/Tt92aTb0qbW5ADXVUhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VKfkB3yl6zwSkL;
	Thu, 18 Apr 2024 09:06:42 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 557C3140120;
	Thu, 18 Apr 2024 09:09:46 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 09:09:46 +0800
Message-ID: <bd0b9517-63d1-4a49-90fd-c68e66dd464a@huawei.com>
Date: Thu, 18 Apr 2024 09:09:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bcachefs: Align the display format of
 `btrees/inodes/keys`
To: Youling Tang <youling.tang@linux.dev>, Kent Overstreet
	<kent.overstreet@linux.dev>
CC: <linux-bcachefs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Youling
 Tang <tangyouling@kylinos.cn>
References: <20240418005055.45482-1-youling.tang@linux.dev>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240418005055.45482-1-youling.tang@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/4/18 8:50, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> Before patch:
> ```
>   #cat btrees/inodes/keys
>   u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0:   mode=40755
>     flags= (16300000)
>     bi_size=0
> ```
> 
> After patch:
> ```
>   #cat btrees/inodes/keys
>   u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0:
>     mode=40755
>     flags=(16300000)
>     bi_size=0
> ```
> 
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
> v2:
> - Adjust where to add new lines of code.
> - Remove flags ` ` by Hongbo suggestion.
> 
>   fs/bcachefs/inode.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/inode.c b/fs/bcachefs/inode.c
> index f0da2b0048cc..5c9ee41baa72 100644
> --- a/fs/bcachefs/inode.c
> +++ b/fs/bcachefs/inode.c
> @@ -534,12 +534,13 @@ int bch2_inode_v3_invalid(struct bch_fs *c, struct bkey_s_c k,
>   static void __bch2_inode_unpacked_to_text(struct printbuf *out,
>   					  struct bch_inode_unpacked *inode)
>   {
> +	prt_printf(out, "\n");
>   	printbuf_indent_add(out, 2);
>   	prt_printf(out, "mode=%o\n", inode->bi_mode);
>   
>   	prt_str(out, "flags=");
>   	prt_bitflags(out, bch2_inode_flag_strs, inode->bi_flags & ((1U << 20) - 1));
> -	prt_printf(out, " (%x)\n", inode->bi_flags);
> +	prt_printf(out, "(%x)\n", inode->bi_flags);
>   
>   	prt_printf(out, "journal_seq=%llu\n",	inode->bi_journal_seq);
>   	prt_printf(out, "bi_size=%llu\n",	inode->bi_size);

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks.
Hongbo Li


