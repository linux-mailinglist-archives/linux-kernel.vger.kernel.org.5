Return-Path: <linux-kernel+bounces-147067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844D98A6EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F7F1C22751
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B2F1311A7;
	Tue, 16 Apr 2024 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwJ6tVrV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412C713048E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278989; cv=none; b=cQ48UOKO0n9d3lNKlLZSjyKjmHMNXW0YIZLIvwFrOHRpOQb1HlyE/2LtggrZdpTzUGx5rSm5og58cu/QL9YjezMZgp+owsokOnpZAXNFW59OpdGcStQup0f2XC9g6rZS6lKYZzzUmZsGzcEtkt06mUnadVvpuQg2pO0y4QCqFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278989; c=relaxed/simple;
	bh=slUT4zBHYjU9qi8tHgbYouEcTeqwtszCaEUoidxe348=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMVyURkceeZedYzGrkZW9kgG0M88LIo2mSL4j4oODtrO7hYrrfDhlo57H27k7zLYok1OGW4oDbzEsY/Kv15zxkyUU5uTSmm4HcCn1lDhB07CHZ3imxnErkLTagu81KhLbPCprdvg6uSxtb8BcTRsbydcXVKSiocBBH5Hxy2RDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwJ6tVrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D70C113CE;
	Tue, 16 Apr 2024 14:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713278988;
	bh=slUT4zBHYjU9qi8tHgbYouEcTeqwtszCaEUoidxe348=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BwJ6tVrV6sLRveHEptvfeuji50XNganjw9kogO6idtAG3H8A9mSvncwvjCcmVfbFv
	 zTorwrpg9izqbjDm7SieTN/cb04YaKvWKn1by/rFzilt25q8cpJ1wZF+tIMBeA/U/B
	 UDXo9tIxYZb14rYbyO7KNFwbsyEgFfxBA5MDYw6O0a60pZHbNwdSMBS6oXVFydoPTi
	 9yIO+eUUOnaIHyhyIGxWx8vwo3kfJMFqVfbgANJ2M/va34gBiSExNvUTPHtdlRXmkn
	 wxi/FQwGYetQWXOU1gAsMir3XyQVjtFJUCjqdWqtwpbs2oFMLongmOukuOkXzABxkV
	 MxXrw2JZHDrSw==
Date: Tue, 16 Apr 2024 22:49:47 +0800
From: Gao Xiang <xiang@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Baokun Li <libaokun1@huawei.com>, xiang@kernel.org,
	linux-erofs@lists.ozlabs.org, chao@kernel.org, huyue2@coolpad.com,
	jefflexu@linux.alibaba.com, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, yangerkun@huawei.com,
	houtao1@huawei.com
Subject: Re: [PATCH] erofs: set SB_NODEV sb_flags when mounting with fsid
Message-ID: <Zh6QC0++kpUUL5nf@debian>
Mail-Followup-To: Christian Brauner <brauner@kernel.org>,
	Baokun Li <libaokun1@huawei.com>, xiang@kernel.org,
	linux-erofs@lists.ozlabs.org, chao@kernel.org, huyue2@coolpad.com,
	jefflexu@linux.alibaba.com, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, yangerkun@huawei.com,
	houtao1@huawei.com
References: <20240415121746.1207242-1-libaokun1@huawei.com>
 <20240415-betagten-querlatte-feb727ed56c1@brauner>
 <15ab9875-5123-7bc2-bb25-fc683129ad9e@huawei.com>
 <Zh3NAgWvNASTZSea@debian>
 <e70a28b4-074e-c48a-b717-3e17f1aae61d@huawei.com>
 <20240416-blumig-dachgeschoss-bc683f4ef1bf@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240416-blumig-dachgeschoss-bc683f4ef1bf@brauner>

On Tue, Apr 16, 2024 at 02:35:08PM +0200, Christian Brauner wrote:
> > > I'm not sure how to resolve it in EROFS itself, anyway...
> 
> Instead of allocating the erofs_sb_info in fill_super() allocate it
> during erofs_get_tree() and then you can ensure that you always have the
> info you need available during erofs_kill_sb(). See the appended
> (untested) patch.

Hi Christian,

Yeah, that is a good way I think.  Although sbi will be allocated
unconditionally instead but that is minor.

I'm on OSSNA this week, will test this patch more when returning.

Hi Baokun,

Could you also check this on your side?

Thanks,
Gao Xiang


> From e4f586a41748b6edc05aca36d49b7b39e55def81 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Mon, 15 Apr 2024 20:17:46 +0800
> Subject: [PATCH] erofs: reliably distinguish block based and fscache mode
> 
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
> Instead of allocating the erofs_sb_info in fill_super() allocate it
> during erofs_get_tree() and ensure that erofs can always have the info
> available during erofs_kill_sb().
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/erofs/super.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index c0eb139adb07..4ed80154edf8 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -581,7 +581,7 @@ static const struct export_operations erofs_export_ops = {
>  static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct inode *inode;
> -	struct erofs_sb_info *sbi;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  	struct erofs_fs_context *ctx = fc->fs_private;
>  	int err;
>  
> @@ -590,15 +590,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_maxbytes = MAX_LFS_FILESIZE;
>  	sb->s_op = &erofs_sops;
>  
> -	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> -	if (!sbi)
> -		return -ENOMEM;
> -
>  	sb->s_fs_info = sbi;
>  	sbi->opt = ctx->opt;
>  	sbi->devs = ctx->devs;
>  	ctx->devs = NULL;
> -	sbi->fsid = ctx->fsid;
>  	ctx->fsid = NULL;
>  	sbi->domain_id = ctx->domain_id;
>  	ctx->domain_id = NULL;
> @@ -707,8 +702,15 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  static int erofs_fc_get_tree(struct fs_context *fc)
>  {
>  	struct erofs_fs_context *ctx = fc->fs_private;
> +	struct erofs_sb_info *sbi;
> +
> +	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> +	if (!sbi)
> +		return -ENOMEM;
>  
> -	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->fsid)
> +	fc->s_fs_info = sbi;
> +	sbi->fsid = ctx->fsid;
> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>  		return get_tree_nodev(fc, erofs_fc_fill_super);
>  
>  	return get_tree_bdev(fc, erofs_fc_fill_super);
> @@ -762,11 +764,15 @@ static void erofs_free_dev_context(struct erofs_dev_context *devs)
>  static void erofs_fc_free(struct fs_context *fc)
>  {
>  	struct erofs_fs_context *ctx = fc->fs_private;
> +	struct erofs_sb_info *sbi = fc->s_fs_info;
>  
>  	erofs_free_dev_context(ctx->devs);
>  	kfree(ctx->fsid);
>  	kfree(ctx->domain_id);
>  	kfree(ctx);
> +
> +	if (sbi)
> +		kfree(sbi);
>  }
>  
>  static const struct fs_context_operations erofs_context_ops = {
> @@ -783,6 +789,7 @@ static int erofs_init_fs_context(struct fs_context *fc)
>  	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
>  		return -ENOMEM;
> +
>  	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
>  	if (!ctx->devs) {
>  		kfree(ctx);
> @@ -799,17 +806,13 @@ static int erofs_init_fs_context(struct fs_context *fc)
>  
>  static void erofs_kill_sb(struct super_block *sb)
>  {
> -	struct erofs_sb_info *sbi;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  
> -	if (erofs_is_fscache_mode(sb))
> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>  		kill_anon_super(sb);
>  	else
>  		kill_block_super(sb);
>  
> -	sbi = EROFS_SB(sb);
> -	if (!sbi)
> -		return;
> -
>  	erofs_free_dev_context(sbi->devs);
>  	fs_put_dax(sbi->dax_dev, NULL);
>  	erofs_fscache_unregister_fs(sb);
> -- 
> 2.43.0
> 


