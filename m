Return-Path: <linux-kernel+bounces-38884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E4E83C7C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837E11F276FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874B2129A6C;
	Thu, 25 Jan 2024 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B62H1JSb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7BF745FC;
	Thu, 25 Jan 2024 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199688; cv=none; b=HOtSieyrlNtzXbcE+ecPiGphONEOU7hry1Q/6PzUyYkXEryecRmWxjYatcU0qPuy2Vx911R0mGNtDSID+twtSko7nDcjVM8yQ7BsC5MyF1/z8WOImiFM6k66MM/aMUOMc+CqemJI+yOfrEXiHmrwhAx3rFQA6NTeQLftpTJSsCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199688; c=relaxed/simple;
	bh=e2wzMafEiJ87zPqKUzajnoGGsBbwxCdh9NkGtzE9mUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAsDNuCJLZk1eJdkwt6Y5E+q2nRyB6jn5S/TbD4jmyt8xBFvxnkmv6HmTQYJfVs9dA2Zt9gpi+5cksSBA52z6ngjH0AibyEmxT0DFALkQxWv+HoYIJ9TcJ4FbKm9dnJqEJFhkmK5liMuZhwyjwZ8Q6N5XJSXo91l92cqqgtdzOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B62H1JSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AAEC433F1;
	Thu, 25 Jan 2024 16:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706199688;
	bh=e2wzMafEiJ87zPqKUzajnoGGsBbwxCdh9NkGtzE9mUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B62H1JSblc++Zb4nnT22+0Ff4+RAP2mrxZICom1zGqCkWkBaA4Jur9TCQQ1U9FwdN
	 gzZxUdpPx3aKgpXN5ACS/NN/NOYJJJQhxF544797+i8XzmIA31NIjjBRn7yBcNTXj9
	 x+DRf4WzDPldpojnqacGAyoJwNAVowGZAXmBZCq0jOZQX1Orl7TAI20OXEgxlWedlp
	 DCPsWaKPBgt/Y0JXGuhwB9JwKc/jdBioTC4wgMqiG3CDoMUjaUnsr3MMi4PC+jOjo2
	 6d1WC+/w2263d/dyDLuvFD8pGkRWMBvDETnotSPck2hmxayrgwACdt1YnBmzdWiCZE
	 AHzxeRYNx1wiQ==
Date: Thu, 25 Jan 2024 17:21:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Baokun Li <libaokun1@huawei.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20240125-mochten-lauftraining-9fa7ac4a3461@brauner>
References: <20240123125227.0521c8d9@canb.auug.org.au>
 <20240124122040.04cd2c8a@canb.auug.org.au>
 <20240124-liquidieren-retten-8b3c65074c33@brauner>
 <20240124223537.35433349@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240124223537.35433349@canb.auug.org.au>

On Wed, Jan 24, 2024 at 10:35:37PM +1100, Stephen Rothwell wrote:
> Hi Christian,
> 
> On Wed, 24 Jan 2024 12:13:02 +0100 Christian Brauner <brauner@kernel.org> wrote:
> >
> > I had dropped both from vfs.misc yesterday night. Maybe it didn't make
> > it in time.
> 
> It still has not ... I only fetch your vfs.all branch.  Did you remerge
> and push it out?

So vfs.all should be at:

commit 8577a331532bb1d75f3536461739a0a8e15b219c
Merge: 0c5c260545bd 06b8db3a7dde
Author:     Christian Brauner <brauner@kernel.org>
AuthorDate: Wed Jan 24 18:33:30 2024 +0100
Commit:     Christian Brauner <brauner@kernel.org>
CommitDate: Wed Jan 24 18:33:30 2024 +0100

    Merge branch 'vfs.fs' into vfs.all

    Signed-off-by: Christian Brauner <brauner@kernel.org>

And that should've contain a merge of vfs.misc with all problematic
patches dropped. Please yell if you still see an issue tomorrow!

