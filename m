Return-Path: <linux-kernel+bounces-117170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8DF88A82B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803981F66D66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F19B7172D;
	Mon, 25 Mar 2024 13:46:45 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A363DAC01
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374405; cv=none; b=h5ypvpXkn5gdvKn0QPOaI0VAnygxKc256josYKt6esNw4Jjfo1rDx7bR74MXdsfClB7rDFbXw5uOvBIxj3US6O91i36r7f7RSA4xABi9TuhOT4XOWQgxpUwmATUcNeTqvfj0xuHB8frYWde4Po9i5r38aDoRN6YGsjVccuTX8ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374405; c=relaxed/simple;
	bh=CH/dCXWNi2/KMcpRzScslB9UiE4F2GrOGvUbtKluF50=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZkiL+OZtXGF6WV6/LK0rwGw7sF1NLoS9J6rztAy7JXttHLOZ3+s3r8byGj57CeKlLPIiXbpW1h0AUPCt5pRYbFOHeHZwJTG+79npd6hhifZGAfiI/wj/F1632ybN/ASHAHG0JaoWujEdeOg+yHsEdNVBxPFW/1EXOyr0YKUDzGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V3Dfx0HVszXjks;
	Mon, 25 Mar 2024 21:43:53 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 4ED3B140258;
	Mon, 25 Mar 2024 21:46:37 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 21:46:36 +0800
Subject: Re: [PATCH V2] ubifs: correct UBIFS_DFS_DIR_LEN macro definition and
 improve code clarity
To: ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20240325125713.95035-1-wangzhaolong1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <3fce4fde-0163-4fd4-feb0-2a68aa785e2f@huawei.com>
Date: Mon, 25 Mar 2024 21:46:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240325125713.95035-1-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/3/25 20:57, ZhaoLong Wang Ð´µÀ:
> The UBIFS_DFS_DIR_LEN macro, which defines the maximum length of the UBIFS
> debugfs directory name, has an incorrect formula and misleading comments.
> The current formula is (3 + 1 + 2*2 + 1), which assumes that both UBI device
> number and volume ID are limited to 2 characters. However, UBI device number
> ranges from 0 to 37 (2 characters), and volume ID ranges from 0 to 127 (up
> to 3 characters).
> 
> Although the current code works due to the cancellation of mathematical
> errors (9 + 1 = 10, which matches the correct UBIFS_DFS_DIR_LEN value), it
> can lead to confusion and potential issues in the future.
> 
> This patch aims to improve the code clarity and maintainability by making
> the following changes:
> 
> 1. Corrects the UBIFS_DFS_DIR_LEN macro definition to (3 + 1 + 2 + 3 + 1),
>     accommodating the maximum lengths of both UBI device number and volume ID,
>     plus the separators and null terminator.
> 2. Updates the snprintf calls to use UBIFS_DFS_DIR_LEN instead of
>     UBIFS_DFS_DIR_LEN + 1, removing the unnecessary +1.
> 3. Modifies the error checks to compare against UBIFS_DFS_DIR_LEN using >=
>     instead of >, aligning with the corrected macro definition.
> 4. Removes the redundant +1 in the dfs_dir_name array definitions in ubi.h
>     and debug.h.
> 5. Renames the duplicated UBIFS_DFS_DIR_LEN and UBIFS_DFS_DIR_NAME macros in
>     the sysfs-related code (sysfs.c and ubifs.h) to UBIFS_SYSFS_DIR_LEN and
>     UBIFS_SYSFS_DIR_NAME, respectively, to differentiate their usage from the
>     debugfs constants.
> 
[...]
> diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
> index 1f3ea879d93a..549e147c5ce5 100644
> --- a/fs/ubifs/ubifs.h
> +++ b/fs/ubifs/ubifs.h
> @@ -159,10 +159,11 @@
>   
>   /*
>    * The UBIFS sysfs directory name pattern and maximum name length (3 for "ubi"
> - * + 1 for "_" and plus 2x2 for 2 UBI numbers and 1 for the trailing zero byte.
> + * + 1 for "_" and 2 for UBI device numbers and 3 for volume number and 1 for
> + * the trailing zero byte.
>    */
> -#define UBIFS_DFS_DIR_NAME "ubi%d_%d"
> -#define UBIFS_DFS_DIR_LEN  (3 + 1 + 2*2 + 1)
> +#define UBIFS_SYSFS_DIR_NAME "ubi%d_%d"
> +#define UBIFS_SYSFS_DIR_LEN  (3 + 1 + 2 + 3 + 1)

I don't thinks this renaming is necessary, just remove it from "ubifs.h" 
like v1 does.
>   
>   /*
>    * Lockdep classes for UBIFS inode @ui_mutex.
> 


