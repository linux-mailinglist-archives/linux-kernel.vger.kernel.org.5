Return-Path: <linux-kernel+bounces-82624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2368868762
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317FC29084D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A7D1DA21;
	Tue, 27 Feb 2024 02:47:24 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9602B1D524
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709002044; cv=none; b=FOwdW4IClLRh3Dig6zU/keLkz0Ylx11/8vAnALVEizFtvTCK9SuL18cUaeTbH5zBXCMNxUOkM/Y7jV/lSI0WwHFxZ19hbfvDNBqaAsIApS+N2o3tR80NRt6MHg+iF5tV1cUGyysC+4ePmsw/p4cJEOs4ATy8LDGEzJ+ylqZBCdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709002044; c=relaxed/simple;
	bh=ECWsLE7UkIKsB3497BLRqkYuoniZAUJzn+zpZ2dTrYQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BPov1IUWBz58X8t0exrknlYVqIAl5p/F/P3sAIv3TKdZIq4umTkkHoOqX1ciQdC1qzNRb9gOtLNEn365a2v/EVyEIZpuIZcxGsWtEvk8qH5dnIFfbLO6JM1yc+gmWuZE3EIvYi1ktmoJky2z7t27yXst79I9rQcvgieEgi32//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TkMM40qXfzqjhM;
	Tue, 27 Feb 2024 10:46:40 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id B3D291400D3;
	Tue, 27 Feb 2024 10:47:16 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 10:47:15 +0800
Subject: Re: [PATCH] ubifs: fix function comment warning
To: Arnd Bergmann <arnd@kernel.org>, Richard Weinberger <richard@nod.at>, Arnd
 Bergmann <arnd@arndb.de>
CC: kernel test robot <lkp@intel.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240226121600.1267204-1-arnd@kernel.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e10d1819-bd02-ad1a-444d-bf77b3a9a369@huawei.com>
Date: Tue, 27 Feb 2024 10:47:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240226121600.1267204-1-arnd@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/2/26 20:15, Arnd Bergmann Ð´µÀ:
> From: Arnd Bergmann <arnd@arndb.de>
>
> My previous fix introduced a new W=1 warning for the kerneldoc style
> comments:
>
> fs/ubifs/find.c:86: warning: Function parameter or struct member 'arg' not described in 'scan_for_dirty_cb'
>
> Adjust the comments to the argument names.
>
> Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402261559.cYtMOkIn-lkp@intel.com/
> Fixes: ec724e534dfd ("ubifs: fix function pointer cast warnings")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   fs/ubifs/find.c   | 8 ++++----
>   fs/ubifs/lprops.c | 2 +-
>   2 files changed, 5 insertions(+), 5 deletions(-)

The commit title could be more detailed(eg. add function name) in next time.

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> diff --git a/fs/ubifs/find.c b/fs/ubifs/find.c
> index 6ebf3c04ac5f..643718906b9f 100644
> --- a/fs/ubifs/find.c
> +++ b/fs/ubifs/find.c
> @@ -73,7 +73,7 @@ static int valuable(struct ubifs_info *c, const struct ubifs_lprops *lprops)
>    * @c: the UBIFS file-system description object
>    * @lprops: LEB properties to scan
>    * @in_tree: whether the LEB properties are in main memory
> - * @data: information passed to and from the caller of the scan
> + * @arg: information passed to and from the caller of the scan
>    *
>    * This function returns a code that indicates whether the scan should continue
>    * (%LPT_SCAN_CONTINUE), whether the LEB properties should be added to the tree
> @@ -340,7 +340,7 @@ int ubifs_find_dirty_leb(struct ubifs_info *c, struct ubifs_lprops *ret_lp,
>    * @c: the UBIFS file-system description object
>    * @lprops: LEB properties to scan
>    * @in_tree: whether the LEB properties are in main memory
> - * @data: information passed to and from the caller of the scan
> + * @arg: information passed to and from the caller of the scan
>    *
>    * This function returns a code that indicates whether the scan should continue
>    * (%LPT_SCAN_CONTINUE), whether the LEB properties should be added to the tree
> @@ -581,7 +581,7 @@ int ubifs_find_free_space(struct ubifs_info *c, int min_space, int *offs,
>    * @c: the UBIFS file-system description object
>    * @lprops: LEB properties to scan
>    * @in_tree: whether the LEB properties are in main memory
> - * @data: information passed to and from the caller of the scan
> + * @arg: information passed to and from the caller of the scan
>    *
>    * This function returns a code that indicates whether the scan should continue
>    * (%LPT_SCAN_CONTINUE), whether the LEB properties should be added to the tree
> @@ -773,7 +773,7 @@ int ubifs_save_dirty_idx_lnums(struct ubifs_info *c)
>    * @c: the UBIFS file-system description object
>    * @lprops: LEB properties to scan
>    * @in_tree: whether the LEB properties are in main memory
> - * @data: information passed to and from the caller of the scan
> + * @arg: information passed to and from the caller of the scan
>    *
>    * This function returns a code that indicates whether the scan should continue
>    * (%LPT_SCAN_CONTINUE), whether the LEB properties should be added to the tree
> diff --git a/fs/ubifs/lprops.c b/fs/ubifs/lprops.c
> index a11c3dab7e16..8788740ec57f 100644
> --- a/fs/ubifs/lprops.c
> +++ b/fs/ubifs/lprops.c
> @@ -1005,7 +1005,7 @@ void dbg_check_heap(struct ubifs_info *c, struct ubifs_lpt_heap *heap, int cat,
>    * @c: the UBIFS file-system description object
>    * @lp: LEB properties to scan
>    * @in_tree: whether the LEB properties are in main memory
> - * @lst: lprops statistics to update
> + * @arg: lprops statistics to update
>    *
>    * This function returns a code that indicates whether the scan should continue
>    * (%LPT_SCAN_CONTINUE), whether the LEB properties should be added to the tree



