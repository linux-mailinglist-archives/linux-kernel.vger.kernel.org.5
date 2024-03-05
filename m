Return-Path: <linux-kernel+bounces-91461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC58711D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EA128399F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF69524C;
	Tue,  5 Mar 2024 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZgy2KTf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE617F;
	Tue,  5 Mar 2024 00:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599254; cv=none; b=UEqGYF49RRM49Hpbv0n5DbPmEQWHC5rwoT5FarH1V26WBJXoZt9KOb7CsJwzZwKh9RrhO4I6NMKqCJzF0Crt5+csc057Qr9EqWd7Qf6NMenB0yichbkm2r1m7x53QhX8YhZgAnLgDBsDo+XmdaODkTwILKz8qIug722W78eqHBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599254; c=relaxed/simple;
	bh=RWFul7LxA2blYJmLQ2GTwyx3Gt/tPN9drFppTbMgZvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpZ9Y8CGwsQqyKXQDWsjhf7DnivyIV+Dg6k4/HK170nQWs/fyz2wJBpd4oEQyJPXiFHmd6+7+nieA/tNBrkFB+HvqT59Eodu5cXcO2snPID9AtctYw8NjJYLn0TolCXwMlJ06Q2J/tnNYADtRcLQibU3jrjp8fARFRHPeLuw5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZgy2KTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEFEC433F1;
	Tue,  5 Mar 2024 00:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709599253;
	bh=RWFul7LxA2blYJmLQ2GTwyx3Gt/tPN9drFppTbMgZvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZgy2KTfBnb6Mf1vjDcjcuM4615cZ9X6EiRLV8TmypgNg41SJ3jqmqH3TJpsJcI+u
	 0LYl/LIHjFAtFL2T4QXPi4gr6qoIVssy1lABdREtGAplz8z0CvcCqSrEbfEpfCGk6X
	 fv83YQXbmebIgI50pXPEgAKUk5GmkBKHraLnx+7YUy8pscbcpGdIwi/liSl6bR9a2J
	 TokyZjWTR9GJaAJR1br9JtJ3AzM5nFWt5aNHHgwN8ywSdAipzzpFBc+CTz8y59WL2k
	 I5zc1KnwnvHDKFITBs3DDelUWqL7CDlGarTqHp6puOBGeZSgTrDsOXGLhWniE8Vu3I
	 plGq3yyWvfGrQ==
Date: Mon, 4 Mar 2024 16:40:51 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christian Brauner <brauner@kernel.org>, Chao Yu <chao@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the f2fs
 tree
Message-ID: <ZeZqE0FHKwhANEQs@google.com>
References: <20240229104140.2927da29@canb.auug.org.au>
 <ZeC7OEA4Onoi-mED@google.com>
 <20240305113502.50980f88@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305113502.50980f88@canb.auug.org.au>

On 03/05, Stephen Rothwell wrote:
> Hi Jaegeuk,
> 
> On Thu, 29 Feb 2024 09:13:28 -0800 Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > On 02/29, Stephen Rothwell wrote:
> > > 
> > > Today's linux-next merge of the vfs-brauner tree got a conflict in:
> > > 
> > >   fs/f2fs/super.c
> > > 
> > > between commit:
> > > 
> > >   5fa6a97d2784 ("f2fs: introduce SEGS_TO_BLKS/BLKS_TO_SEGS for cleanup")  
> > 
> > fyi; I dropped the above commit in -dev.
> 
> And it seems to have come back as commit
> 
>   45809cd3bdac ("f2fs: introduce SEGS_TO_BLKS/BLKS_TO_SEGS for cleanup")
> 
> (which is fine, but the conflict has returned).

Yeah.. :P

> 
> > > from the f2fs tree and commit:
> > > 
> > >   512383ae4910 ("f2fs: port block device access to files")
> > > 
> > > from the vfs-brauner tree.
> > > 
> > > I fixed it up (see below) and can carry the fix as necessary. This
> > > is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your tree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particularly
> > > complex conflicts.
> > > 
> > > -- 
> > > Cheers,
> > > Stephen Rothwell
> > > 
> > > diff --cc fs/f2fs/super.c
> > > index 09ffdd554f9c,09e82624eff5..000000000000
> > > --- a/fs/f2fs/super.c
> > > +++ b/fs/f2fs/super.c
> > > @@@ -4206,9 -4265,9 +4206,9 @@@ static int f2fs_scan_devices(struct f2f
> > >   			} else {
> > >   				FDEV(i).start_blk = FDEV(i - 1).end_blk + 1;
> > >   				FDEV(i).end_blk = FDEV(i).start_blk +
> > >  -					(FDEV(i).total_segments <<
> > >  -					sbi->log_blocks_per_seg) - 1;
> > >  +						SEGS_TO_BLKS(sbi,
> > >  +						FDEV(i).total_segments) - 1;
> > > - 				FDEV(i).bdev_handle = bdev_open_by_path(
> > > + 				FDEV(i).bdev_file = bdev_file_open_by_path(
> > >   					FDEV(i).path, mode, sbi->sb, NULL);
> > >   			}
> > >   		}  
> 
> -- 
> Cheers,
> Stephen Rothwell



