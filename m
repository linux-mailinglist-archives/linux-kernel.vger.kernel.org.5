Return-Path: <linux-kernel+bounces-147882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BA68A7AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22711F22B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF44C79FE;
	Wed, 17 Apr 2024 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/lrgA20"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3844579C0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323508; cv=none; b=mbXQBd3+SyQapwiBdkY/aJZeynkV9UOBPiLe9r8dPiu9JGyCZcoWP7gS/q+mOLSPXnR5KJZkzhO5ilOpuvX2tXhActOkQoPqs4O8igV1JRkd0/HB1Qd6j375nWcE5LcQHFy3bM5+gmfWNjju/IHr8ylH63BSjFzn+RRNhnuMlV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323508; c=relaxed/simple;
	bh=UONd/W0nJEXdL+M6NCBHpupjmfaKOELcAVnYMGiHm5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZftM0mmSG2cHiMlbDvWN16M2cjwGOnATRr42w0WlYGkG+PptcrZa4meAj/AzgjHT+lNNMSUXSTbd5zMVQDzyr9hpkpEfAZAgBw+DzsP5+KNyfoZG8Svebl3qaDzYTzRLsfdrDA5+aqlEkYKd6ufWPoBWXawDr3eRwbp9mR1tUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/lrgA20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77300C113CE;
	Wed, 17 Apr 2024 03:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713323507;
	bh=UONd/W0nJEXdL+M6NCBHpupjmfaKOELcAVnYMGiHm5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/lrgA202YESfUXdVr9ed/qonB7AzNsjISkdJ0ajEy3mR/ES4gQwQJsEQpalSTL7+
	 ZrP2jTYMff0sS4vPwoaxO7LJar5po5NUaS3p0p+MjBwLCfzFbiPgUMok69EwXqsMuU
	 XCZw34FvVoC7qCTNZFphpfnF58G6fr9sYBDpx/0d83Ucjm3maKFpiuzETFy3r1wpu9
	 +F6EDr1c4dyHnZp68OPod5mf3E8uheYZ+3mNbWlkR7UU/zRPaVWIaYzQMf1URHyA24
	 awzNGEVv4McX4Zqk5RHH/1TJ45/KKU9+m0S6nbkeX1ma440YqtXjqB8AV6KsvZtFDQ
	 OLTaOXv3osaEw==
Date: Wed, 17 Apr 2024 11:11:46 +0800
From: Gao Xiang <xiang@kernel.org>
To: Baokun Li <libaokun1@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>, xiang@kernel.org,
	linux-erofs@lists.ozlabs.org, chao@kernel.org, huyue2@coolpad.com,
	jefflexu@linux.alibaba.com, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, yangerkun@huawei.com,
	houtao1@huawei.com
Subject: Re: [PATCH] erofs: set SB_NODEV sb_flags when mounting with fsid
Message-ID: <Zh898uJW0AFtE0Rk@debian>
Mail-Followup-To: Baokun Li <libaokun1@huawei.com>,
	Christian Brauner <brauner@kernel.org>, xiang@kernel.org,
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
 <Zh6QC0++kpUUL5nf@debian>
 <779ff32f-3f3b-c602-5da8-c88b361716ac@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <779ff32f-3f3b-c602-5da8-c88b361716ac@huawei.com>

On Wed, Apr 17, 2024 at 10:59:53AM +0800, Baokun Li wrote:
> On 2024/4/16 22:49, Gao Xiang wrote:
> > On Tue, Apr 16, 2024 at 02:35:08PM +0200, Christian Brauner wrote:
> > > > > I'm not sure how to resolve it in EROFS itself, anyway...
> > > Instead of allocating the erofs_sb_info in fill_super() allocate it
> > > during erofs_get_tree() and then you can ensure that you always have the
> > > info you need available during erofs_kill_sb(). See the appended
> > > (untested) patch.
> > Hi Christian,
> > 
> > Yeah, that is a good way I think.  Although sbi will be allocated
> > unconditionally instead but that is minor.
> > 
> > I'm on OSSNA this week, will test this patch more when returning.
> > 
> > Hi Baokun,
> > 
> > Could you also check this on your side?
> > 
> > Thanks,
> > Gao Xiang
> Hi Xiang,
> 
> This patch does fix the initial problem.
> 
> 
> Hi Christian,
> 
> Thanks for the patch, this is a good idea. Just with nits below.
> Otherwise feel free to add.
> 
> Reviewed-and-tested-by: Baokun Li <libaokun1@huawei.com>
> > 
> > >  From e4f586a41748b6edc05aca36d49b7b39e55def81 Mon Sep 17 00:00:00 2001
> > > From: Christian Brauner <brauner@kernel.org>
> > > Date: Mon, 15 Apr 2024 20:17:46 +0800
> > > Subject: [PATCH] erofs: reliably distinguish block based and fscache mode
> > > 
> SNIP
> 
> > > 
> > > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > > index c0eb139adb07..4ed80154edf8 100644
> > > --- a/fs/erofs/super.c
> > > +++ b/fs/erofs/super.c
> > > @@ -581,7 +581,7 @@ static const struct export_operations erofs_export_ops = {
> > >   static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
> > >   {
> > >   	struct inode *inode;
> > > -	struct erofs_sb_info *sbi;
> > > +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> > >   	struct erofs_fs_context *ctx = fc->fs_private;
> > >   	int err;
> > > @@ -590,15 +590,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
> > >   	sb->s_maxbytes = MAX_LFS_FILESIZE;
> > >   	sb->s_op = &erofs_sops;
> > > -	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> > > -	if (!sbi)
> > > -		return -ENOMEM;
> > > -
> > >   	sb->s_fs_info = sbi;
> This line is no longer needed.
> > >   	sbi->opt = ctx->opt;
> > >   	sbi->devs = ctx->devs;
> > >   	ctx->devs = NULL;
> > > -	sbi->fsid = ctx->fsid;
> > >   	ctx->fsid = NULL;
> > >   	sbi->domain_id = ctx->domain_id;
> > >   	ctx->domain_id = NULL;
> Since erofs_sb_info is now allocated in erofs_fc_get_tree(), why not
> encapsulate the above lines as erofs_ctx_to_info() helper function
> to be called in erofs_fc_get_tree()？Then erofs_fc_fill_super() wouldn't
> have to use erofs_fs_context and would prevent the fsid from being
> freed twice.

Hi Baokun,

I'm not sure if Christian has enough time to polish the whole
codebase (I'm happy if do so).  Basically, that is just a hint
to the issue, if you have more time, I guess you could also help
revive this patch together (also because you also have a real
EROFS test environment).

Let me also check this next week after OSSNA travelling.

Thanks,
Gao Xiang

