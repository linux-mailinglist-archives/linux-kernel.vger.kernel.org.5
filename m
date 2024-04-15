Return-Path: <linux-kernel+bounces-144497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4D68A4717
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5F628103E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83621182B5;
	Mon, 15 Apr 2024 02:48:44 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE117547;
	Mon, 15 Apr 2024 02:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713149324; cv=none; b=ny+e2hXzXaoPOpBmQUZ8nn5HYTkPC3AxVnQNV3+Yj7eTtJ9eXqQh1iJ3dYUIKu7dUibZYmdmwbVRhpi58mU41n6nZx27xUqYGoqjvIVD6fGJpKAEMcDj7hYSA5ztevg5s6+9ANRtrKI8oqXh7zUkI9X/5/EKY2+nLhIdEVihyXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713149324; c=relaxed/simple;
	bh=QXrkxhjzMpugnwMqbEqIWkZyuPPYtdOYLCS3hGr/o2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DI1iqzoVXCiViJPJTxDsn6wBCzc8bDQ2PgewiqWEC0cRbYRLHl6GwfG8lGYpH7IHzoQAC/60IPKCvnGLMkSP8PxZ/3RbVVkoYE9z1jLm7Z0BIQnmN8v6WL2KBoI+0B8JFPLx478q5l1zhC1KpqW9QY5ZqhF3pmmPDYc+m11A0ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VHs6C26BRz1GHYW;
	Mon, 15 Apr 2024 10:47:47 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 75D0018002D;
	Mon, 15 Apr 2024 10:48:38 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 10:48:38 +0800
Message-ID: <0ac17964-d5c3-47a6-b909-51d5fd60a355@huawei.com>
Date: Mon, 15 Apr 2024 10:48:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bcachefs: remove unneeded semicolon
Content-Language: en-US
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	<kent.overstreet@linux.dev>
CC: <bfoster@redhat.com>, <linux-bcachefs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abaci Robot <abaci@linux.alibaba.com>
References: <20240415023557.5851-1-jiapeng.chong@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240415023557.5851-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Maybe it is not enough, you can use "grep -rn ');;' fs/bcachefs/" to 
find out all the same format.

On 2024/4/15 10:35, Jiapeng Chong wrote:
> No functional modification involved.
> 
> ./fs/bcachefs/super.c:1128:59-60: Unneeded semicolon.
> ./fs/bcachefs/super.c:1133:59-60: Unneeded semicolon.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8755
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   fs/bcachefs/super.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
> index 8daf80a38d60..234f19ea8f30 100644
> --- a/fs/bcachefs/super.c
> +++ b/fs/bcachefs/super.c
> @@ -1125,12 +1125,12 @@ static int bch2_dev_in_fs(struct bch_sb_handle *fs,
>   
>   		prt_bdevname(&buf, fs->bdev);
>   		prt_char(&buf, ' ');
> -		bch2_prt_datetime(&buf, le64_to_cpu(fs->sb->write_time));;
> +		bch2_prt_datetime(&buf, le64_to_cpu(fs->sb->write_time));
>   		prt_newline(&buf);
>   
>   		prt_bdevname(&buf, sb->bdev);
>   		prt_char(&buf, ' ');
> -		bch2_prt_datetime(&buf, le64_to_cpu(sb->sb->write_time));;
> +		bch2_prt_datetime(&buf, le64_to_cpu(sb->sb->write_time));
>   		prt_newline(&buf);
>   
>   		if (!opts->no_splitbrain_check)

