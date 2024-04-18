Return-Path: <linux-kernel+bounces-149635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39278A93C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E9E1C21765
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631EE3B785;
	Thu, 18 Apr 2024 07:11:45 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457EF25777
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424305; cv=none; b=ddDV1xtx2SQSvV9wLWDI1Y4LL6/J/jWsjOhEOb9PUPUZVCtfTrEH30K4wxm6nzo6Bs/OXJaPLG1rNrKWZ/dZMdli/sayBReWUvVa8keIYRup5PKsatRY53OxzorIxN4W/nPXAk5C8iQ5l1TWTQV+ScowSnoM8YhCzzEpTDhfqUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424305; c=relaxed/simple;
	bh=Ap9iYqzhgv9llNxrD1QByufe1cUyyBleHHekxCCfc2k=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Uj81Z/Qa/Wpiw4Re8ETmz10dXyLn24YQApPaU9PcdjhfCwYGPhn3uLM9aa1PNlIUhwgA8eD1OJZ1UC9mqEse69UZ95M5M2lnjLlPoRF3kO0q+VUeIhtKNEzcbtOK5l24VG3sgEuHzp1uG211PGdzXUHzcMiNxvk681TR8S/E4No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VKpmP04R9zNnhS;
	Thu, 18 Apr 2024 15:09:09 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id A37C31800C4;
	Thu, 18 Apr 2024 15:11:33 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 15:11:32 +0800
Subject: Re: [PATCH V3] ubifs: correct UBIFS_DFS_DIR_LEN macro definition and
 improve code clarity
To: ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20240418070704.3080590-1-wangzhaolong1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <fde03388-9673-af46-ffef-9d387605d015@huawei.com>
Date: Thu, 18 Apr 2024 15:11:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240418070704.3080590-1-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/4/18 15:07, ZhaoLong Wang Ð´µÀ:
> The UBIFS_DFS_DIR_LEN macro, which defines the maximum length of the UBIFS
> debugfs directory name, has an incorrect formula and misleading comments.
> The current formula is (3 + 1 + 2*2 + 1), which assumes that both UBI device
> number and volume ID are limited to 2 characters. However, UBI device number
> ranges from 0 to 31 (2 characters), and volume ID ranges from 0 to 127 (up
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
> 
> While these changes do not affect the runtime behavior, they make the code
> more readable, maintainable, and less prone to future errors.
> 
> v2->v3:
> 
>   - Removes the duplicated UBIFS_DFS_DIR_LEN and UBIFS_DFS_DIR_NAME macro
>     definitions in ubifs.h, as they are already defined in debug.h.
> 
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>

You lost my 'review-by' in last v3.

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>



