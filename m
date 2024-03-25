Return-Path: <linux-kernel+bounces-116375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B088388995D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663581F31D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DA11292EE;
	Mon, 25 Mar 2024 05:25:54 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B582B4D599
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711331092; cv=none; b=D8q5ijVZ/mmi/lyG+nnR7WyCu3Sefejh547nQpMLCf3zjYxP9+QW9/XUIZt11d8OWnd5mXhuyClX5N9VNCHrWd0GBfecFctYUhpKChlNQLF5lu+xrt1TZqJtEKOJlLDbaXR+nJotXDi+OZo7g/WVihqprUwwt9+n58ZAMzUJYvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711331092; c=relaxed/simple;
	bh=g+N2IFwrHJmYX6hG4nCxHxw2BF0Zo9VeacaZLso3seQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=C2tL/XIfGflq2tHoEC+l623JLADs4rTHog4Xf0TkVEe8Dz/0YpTWlNd5EFI+Yj0fCR+j6HxjWUahL2wgwjhM5/SIIIo05Ua8ee+IJSk8ChK3ZG6AKTsjdu6HwqYCD3nrqvfpPAX7bxYMl46e8uY0LthRz5Tc3aBcOTkAJGu7CoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V2wdx6NR2zXjH8;
	Mon, 25 Mar 2024 09:41:57 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 66058140258;
	Mon, 25 Mar 2024 09:44:41 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 09:44:40 +0800
Subject: Re: [PATCH] ubifs: xattr: remove unused anonymous enum
To: <pascal.eberhard@se.com>, Richard Weinberger <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240324004134.161755-1-pascal.eberhard@verified.se.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <7030eaa5-73b5-7aa3-3b7d-56a3519878b3@huawei.com>
Date: Mon, 25 Mar 2024 09:44:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240324004134.161755-1-pascal.eberhard@verified.se.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/3/24 8:41, pascal.eberhard@verified.se.com Ð´µÀ:
> From: Pascal Eberhard <pascal.eberhard@se.com>
> 
> commit 2b88fc21cae9 ("ubifs: Switch to generic xattr handlers") removes
> usage of this anonymous enum. Delete the enum as well.
> 
> Signed-off-by: Pascal Eberhard <pascal.eberhard@se.com>
> ---
>   fs/ubifs/xattr.c | 13 -------------
>   1 file changed, 13 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
> index 0847db521984..f0969519ad05 100644
> --- a/fs/ubifs/xattr.c
> +++ b/fs/ubifs/xattr.c
> @@ -48,19 +48,6 @@
>   #include <linux/slab.h>
>   #include <linux/xattr.h>
>   
> -/*
> - * Extended attribute type constants.
> - *
> - * USER_XATTR: user extended attribute ("user.*")
> - * TRUSTED_XATTR: trusted extended attribute ("trusted.*)
> - * SECURITY_XATTR: security extended attribute ("security.*")
> - */
> -enum {
> -	USER_XATTR,
> -	TRUSTED_XATTR,
> -	SECURITY_XATTR,
> -};
> -
>   static const struct inode_operations empty_iops;
>   static const struct file_operations empty_fops;
>   
> 


