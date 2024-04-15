Return-Path: <linux-kernel+bounces-145277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB478A51D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E23283A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B54C73501;
	Mon, 15 Apr 2024 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1Gx9/7H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EBA71759
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188295; cv=none; b=QDVNFob7jdExFC5f0EAO7qDtqMGRD0fG0/5kfeDt7iN+Ql8VIAxsgtvKGpzfDLAmB3GjFLntr6u3b+geCQd+i3yk8eZlIzY8JiD4hRc4p0lwK6TouIPCIjH3rMxT6/mwXz+Z9xoJusd0H8GNx9yZ8Dykzk2rJt5dYQ5MECFFig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188295; c=relaxed/simple;
	bh=D5lnOS4BaZn4Qhbk5HBYMUjuMcVsr7Tg9EDh+w5m3oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=th6y++VyeUqJLpfSi4UQ1yz25eJfV0T9Ka+T5Dyb0Ji122oOWsHLfjYfBrN5HnXhC5oYLkeEqaARof9DfaJxmh0iMfiORV9hkabRP0y11YkFqgEk6NeN98INMXtokFj3XLDrUwD2+4iiyMuQMD0cNiUcCF+NeNwUgWTSqNS42Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1Gx9/7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643B1C2BD10;
	Mon, 15 Apr 2024 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188295;
	bh=D5lnOS4BaZn4Qhbk5HBYMUjuMcVsr7Tg9EDh+w5m3oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1Gx9/7HrR7qcEPgR+1Gf7UVgaJwyZJ3Vt3Jt92x6Ap36pWHyJQPiko8+8rfYwOHB
	 6lf//ROsKkm+Vv2WeATEHf0gQyzXcpvNZ5NAM5UMBNA3QuQFbByK+hIdRuJJhTJE/t
	 QTur5cx7RJRyPOPcJEUNgKN+AMiG9x0kGkU9L8OkhAU4EdvrC+eqtCoRITVtbqYJW7
	 K7dwUoT3Pf5zwYxG71dJOS8ejhMMoSuYkh0obmKVGXta/80keaAWvRI5CbXLl6kIor
	 cA3ib1p9RDty4OhcjwV1yjVLmnh1ZMaipYA3PUCeLy7Xo6BNW0I0PNFsRngLao8MXH
	 cBkT9G504KWdw==
Date: Mon, 15 Apr 2024 15:38:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org, 
	huyue2@coolpad.com, jefflexu@linux.alibaba.com, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com
Subject: Re: [PATCH] erofs: set SB_NODEV sb_flags when mounting with fsid
Message-ID: <20240415-betagten-querlatte-feb727ed56c1@brauner>
References: <20240415121746.1207242-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240415121746.1207242-1-libaokun1@huawei.com>

On Mon, Apr 15, 2024 at 08:17:46PM +0800, Baokun Li wrote:
> When erofs_kill_sb() is called in block dev based mode, s_bdev may not have
> been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled, it will
> be mistaken for fscache mode, and then attempt to free an anon_dev that has
> never been allocated, triggering the following warning:
> 
> ============================================
> ida_free called for id=0 which is not allocated.
> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
> Modules linked in:
> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
> RIP: 0010:ida_free+0x134/0x140
> Call Trace:
>  <TASK>
>  erofs_kill_sb+0x81/0x90
>  deactivate_locked_super+0x35/0x80
>  get_tree_bdev+0x136/0x1e0
>  vfs_get_tree+0x2c/0xf0
>  do_new_mount+0x190/0x2f0
>  [...]
> ============================================
> 
> To avoid this problem, add SB_NODEV to fc->sb_flags after successfully
> parsing the fsid, and then the superblock inherits this flag when it is
> allocated, so that the sb_flags can be used to distinguish whether it is
> in block dev based mode when calling erofs_kill_sb().
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/erofs/super.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index b21bd8f78dc1..7539ce7d64bc 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -520,6 +520,7 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>  		ctx->fsid = kstrdup(param->string, GFP_KERNEL);
>  		if (!ctx->fsid)
>  			return -ENOMEM;
> +		fc->sb_flags |= SB_NODEV;

Hm, I wouldn't do it this way. That's an abuse of that flag imho.
Record the information in the erofs_fs_context if you need to.

