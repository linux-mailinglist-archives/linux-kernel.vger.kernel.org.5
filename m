Return-Path: <linux-kernel+bounces-70130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E67C38593C9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF091F21D9D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E98D184D;
	Sun, 18 Feb 2024 01:13:57 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA8149DED;
	Sun, 18 Feb 2024 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708218836; cv=none; b=kChUMHFAgZuxD39+2QisSxJBqIOi48wHdWiPDH0IOJDTTkhLdUWztYvnfaMxC0CKM0fUvAUuLDpL1QXtOrkZiyi2m/UhcaCDoHrQy0rA6IqnPoG5G3xXTKcQs3vt4Tb7FjTYqQanyumaQN8ajyIyXLqun161gVcBkYDVEasNNLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708218836; c=relaxed/simple;
	bh=BM5fWLHxt+nbnIcaH9/6rApX+O/g3UTPsFa3hJbgNYQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MjRzLnzvXJzzs9scfp+J4YYdIQl0YLkje2zoa6l8/woLf9J7EdzTWeJzxbklvcDjnYqnQufyOaZrbqI6zCdB2TjJeR6t7fotcE636P0NSaJj1AbosZA7WIWtM30skVdOhIr2ovIelsm9BdNYFNlK9pf+uJIjFITQYLuPwbuMDo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TcncM4vSQz1FKTg;
	Sun, 18 Feb 2024 09:08:51 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id B5AB314040D;
	Sun, 18 Feb 2024 09:13:39 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 09:13:38 +0800
Subject: Re: [PATCH] jffs2: print symbolic error name instead of error code
To: Christian Heusel <christian@heusel.eu>, David Woodhouse
	<dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>
References: <20240211003907.167891-1-christian@heusel.eu>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e4d00360-bb36-cfe1-5c0c-8e5b1c7bebc0@huawei.com>
Date: Sun, 18 Feb 2024 09:13:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240211003907.167891-1-christian@heusel.eu>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/2/11 8:39, Christian Heusel Ð´µÀ:
> Utilize the %pe print specifier to get the symbolic error name as a
> string (i.e "-ENOMEM") in the log message instead of the error code to
> increase its readablility.
> 
> This change was suggested in
> https://lore.kernel.org/all/92972476-0b1f-4d0a-9951-af3fc8bc6e65@suswa.mountain/
> 
> Signed-off-by: Christian Heusel <christian@heusel.eu>
> ---
>   fs/jffs2/background.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/jffs2/background.c b/fs/jffs2/background.c
> index 6da92ecaf66d..bb0ee1a59e71 100644
> --- a/fs/jffs2/background.c
> +++ b/fs/jffs2/background.c
> @@ -44,8 +44,8 @@ int jffs2_start_garbage_collect_thread(struct jffs2_sb_info *c)
> 
>   	tsk = kthread_run(jffs2_garbage_collect_thread, c, "jffs2_gcd_mtd%d", c->mtd->index);
>   	if (IS_ERR(tsk)) {
> -		pr_warn("fork failed for JFFS2 garbage collect thread: %ld\n",
> -			-PTR_ERR(tsk));
> +		pr_warn("fork failed for JFFS2 garbage collect thread: %pe\n",
> +			tsk);
>   		complete(&c->gc_thread_exit);
>   		ret = PTR_ERR(tsk);
>   	} else {
> --
> 2.43.1
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> .
> 


