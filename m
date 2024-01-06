Return-Path: <linux-kernel+bounces-18453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BD9825DC5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 02:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63BF6B21718
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 01:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D671815C3;
	Sat,  6 Jan 2024 01:56:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB615A0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 01:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-0KTY0_1704506152;
Received: from 30.222.32.126(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0W-0KTY0_1704506152)
          by smtp.aliyun-inc.com;
          Sat, 06 Jan 2024 09:55:52 +0800
Message-ID: <64d54843-4e25-4777-b324-dff105da705b@linux.alibaba.com>
Date: Sat, 6 Jan 2024 09:55:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: Spelling fix
To: Yongzhen Zhang <zhangyongzhen@kylinos.cn>, ocfs2-devel@lists.linux.dev
Cc: mark@fasheh.com, jlbec@evilplan.org, linux-kernel@vger.kernel.org
References: <20240104092427.18119-1-zhangyongzhen@kylinos.cn>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240104092427.18119-1-zhangyongzhen@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/4/24 5:24 PM, Yongzhen Zhang wrote:
> Modify reques to request in the comment
> 
> Fixes: b1b1e15ef6b8 ("ocfs2: NFS hangs in __ocfs2_cluster_lock due to race with ocfs2_unblock_lock")

Since it's just a typo, I don't think it deserves a 'Fixes' tag.

> Signed-off-by: Yongzhen Zhang <zhangyongzhen@kylinos.cn>
> ---
>  fs/ocfs2/dlmglue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index 64a6ef638495..cb40cafbc062 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -1615,7 +1615,7 @@ static int __ocfs2_cluster_lock(struct ocfs2_super *osb,
>  unlock:
>  	lockres_clear_flags(lockres, OCFS2_LOCK_UPCONVERT_FINISHING);
>  
> -	/* ocfs2_unblock_lock reques on seeing OCFS2_LOCK_UPCONVERT_FINISHING */
> +	/* ocfs2_unblock_lock request on seeing OCFS2_LOCK_UPCONVERT_FINISHING */
>  	kick_dc = (lockres->l_flags & OCFS2_LOCK_BLOCKED);
>  
>  	spin_unlock_irqrestore(&lockres->l_lock, flags);

