Return-Path: <linux-kernel+bounces-111433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1878886C50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7AC288225
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F2D3FB85;
	Fri, 22 Mar 2024 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hMA50/00"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADFE446A0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111291; cv=none; b=TaGkgm2o96CG98E/dNY49K1J6kUNEEl9N+1fN4ojgSo5V+l/C5RU1Hv0JQ8xYjTp/mo0LZEE8JBfubk06oVp3LWkIe4B5SbZHihyHgApKqgucYVoMkoByjxSOfWjTaJtdODpV/Nxx3u+xDvKQ9CgN+X9Ego2gdiIDgk+L6t09KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111291; c=relaxed/simple;
	bh=3Je8w2bAEmEHX1T7e/jY+IL0n4dVZyCdK5mweC9BXJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6Ik67isztT7wBTzSpXD1+5IyGVzEBJZnilM51tE9ykzbVufL3MYjrA12ELBtMa7y3SC5g7CxQPqJlIecm5040Wt+jowLwxbAUlVu6wSAzxfIagWFs7ldawIp5Gb7lZwL9ICD+dUFwUUUfTnqKQNbYC8Am1KmS7LF6IQklvSemo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hMA50/00; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711111285; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xAE0vYbfun0EnTckxuzzM5D85GyEmtWY8TOlqPzbd/Y=;
	b=hMA50/00zeA21SJQUWwZxZTPiC/PUTtGo7apBlhDHTNBGhbI34Ih1WLuWS6rpoICll+Ft257bZ79l+VMvHNoIRvogm/uhqzR/Hvtsd4kQruyq0Yu7zNX33Xlvzch68401Q+QAaDjSLXObbvbROe4X8mdGscYxJxtHwJfa2dM25I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W327Cer_1711111284;
Received: from 30.221.128.129(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0W327Cer_1711111284)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 20:41:25 +0800
Message-ID: <23f6cc23-9f9b-405b-8c8e-5cda14e79587@linux.alibaba.com>
Date: Fri, 22 Mar 2024 20:41:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] fs: Add kernel-doc comments to
 ocfs2_prepare_orphan_dir()
Content-Language: en-US
To: Yang Li <yang.lee@linux.alibaba.com>, akpm <akpm@linux-foundation.org>
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240322063718.88183-1-yang.lee@linux.alibaba.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240322063718.88183-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/22/24 2:37 PM, Yang Li wrote:
> This commit adds kernel-doc style comments with complete parameter
> descriptions for the function ocfs2_prepare_orphan_dir.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/namei.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index 9221a33f917b..8a61c5f94533 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -2187,8 +2187,10 @@ static int __ocfs2_prepare_orphan_dir(struct inode *orphan_dir_inode,
>   * @osb: ocfs2 file system
>   * @ret_orphan_dir: Orphan dir inode - returned locked!
>   * @blkno: Actual block number of the inode to be inserted into orphan dir.
> + * @name: Buffer to store the name of the orphan.
>   * @lookup: dir lookup result, to be passed back into functions like
>   *          ocfs2_orphan_add
> + * @dio: Flag indicating if direct IO is being used or not.
>   *
>   * Returns zero on success and the ret_orphan_dir, name and lookup
>   * fields will be populated.

