Return-Path: <linux-kernel+bounces-8338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B5381B5E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7721C2851B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870CD745DA;
	Thu, 21 Dec 2023 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoBDDMEa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78306E5AA;
	Thu, 21 Dec 2023 12:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32218C433C8;
	Thu, 21 Dec 2023 12:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703161777;
	bh=PoxtAVe0j4/90nOVvQGxKKA/OruAhyMaLvS2TdzLSMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SoBDDMEaJ4bux3ThhKN3Z2K52Pwnq/Q3z90b621BFqbvSkNeojFC1l5cO2G0KAAqe
	 7OoPn8BPGaav2dVvaj+4VIOc6TENMuZ5QICLgWQh11TVQbjjxZABqXUP0cxSiQmsm9
	 s4NR/qqT0Wp4GciuGm3UGijcNKc4nzdi2GSTA5E3yYtpaF4PJ6uSi0kyZ1wi6vruWC
	 fHLU26uJdLX50a/ZV0HFo0FPhhE1ttpWmWg/joMdP59NBp2e2u4Lga5bF46n+nnRIz
	 oi03J4ySXOLXH+2tgNafO7wHUiSB5noagu8+CVHRximDMg5+W97kxNTPJSnS5llCDv
	 RTuOFPWT/feUQ==
Date: Thu, 21 Dec 2023 13:29:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the block tree
Message-ID: <20231221-notieren-abbaggern-98327276ee4c@brauner>
References: <20231221135602.12bf82f5@canb.auug.org.au>
 <f31dae39-7c62-453a-8ca5-bd0b0e58769f@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f31dae39-7c62-453a-8ca5-bd0b0e58769f@kernel.dk>

On Wed, Dec 20, 2023 at 08:11:34PM -0700, Jens Axboe wrote:
> On 12/20/23 7:56 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > The following commits are also in the vfs-brauner tree as different
> > commits (but the same patches):
> > 
> >   24fa3ae9467f ("file: remove pointless wrapper")
> >   253ca8678d30 ("Improve __fget_files_rcu() code generation (and thus __fget_light())")
> >   372a34e66fb7 ("fs: replace f_rcuhead with f_task_work")
> >   4e94ddfe2aab ("file: remove __receive_fd()")
> >   7cb537b6f6d7 ("file: massage cleanup of files that failed to open")
> >   a88c955fcfb4 ("file: s/close_fd_get_file()/file_close_fd()/g")
> >   eac9189c9619 ("file: stop exposing receive_fd_user()")
> 
> Hmm confused, assumed vfs.file got rebased again, but doesn't look to be
> the case. Christian?

Nope, vfs.file definitely didn't get rebased. That was just me being
stupid and not merging vfs.file cleanly into vfs.all. Sorry about this.
Fixed now.

