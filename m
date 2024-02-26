Return-Path: <linux-kernel+bounces-82161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F272C86800C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 299B0B254F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD1A12EBE8;
	Mon, 26 Feb 2024 18:50:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A921DFF4;
	Mon, 26 Feb 2024 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973409; cv=none; b=BN9/t1aD500XaF15UZT8BwILFcQoaD7PRuLq2gZ3mYjufS/gygbG5p2daonmerBiStFzrCVyjYVYE0T5xrsQ6M2QSYj0RY0vz+Q2TN5A4kAcbD5VVqs1rNKTo9vYtAkJ3luj+VWrJJGiwkUzKHFsbrocFhPMpAGXLpPUfUPG7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973409; c=relaxed/simple;
	bh=BDC8F9Mgjm+6KsQL/o0loxTaN3Zn4xNIrAfIu9/shdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJ09WHWWK/zdrbB3bV1HdAVNP7xXuuIeoQDzCNY42BC9nE/S/Vl5OX30LyeVf9yMpmnWhGBwHyd4vGLudHl6A/tj2+CKC3MnKheCTt5jI4vJNm5dhozbHRzuTQQoKKS4l+690BwU1aJelDGiwomvonwzpgPyFo0nMCDqUfDqoK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161E7C433F1;
	Mon, 26 Feb 2024 18:50:07 +0000 (UTC)
Date: Mon, 26 Feb 2024 13:52:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: chengming.zhou@linux.dev
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, vbabka@suse.cz, roman.gushchin@linux.dev,
 Xiongwei.Song@windriver.com, Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] tracefs: remove SLAB_MEM_SPREAD flag usage
Message-ID: <20240226135207.70a27f30@gandalf.local.home>
In-Reply-To: <20240224135206.830300-1-chengming.zhou@linux.dev>
References: <20240224135206.830300-1-chengming.zhou@linux.dev>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Feb 2024 13:52:06 +0000
chengming.zhou@linux.dev wrote:

> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Queued.

Thanks!

-- Steve

> ---
>  fs/tracefs/inode.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index d65ffad4c327..5545e6bf7d26 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -731,7 +731,6 @@ static int __init tracefs_init(void)
>  	tracefs_inode_cachep = kmem_cache_create("tracefs_inode_cache",
>  						 sizeof(struct tracefs_inode),
>  						 0, (SLAB_RECLAIM_ACCOUNT|
> -						     SLAB_MEM_SPREAD|
>  						     SLAB_ACCOUNT),
>  						 init_once);
>  	if (!tracefs_inode_cachep)


