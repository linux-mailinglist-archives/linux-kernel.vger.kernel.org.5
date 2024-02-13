Return-Path: <linux-kernel+bounces-63703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9763853375
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C031F26905
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A98E58126;
	Tue, 13 Feb 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lCaNGj6W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D657897;
	Tue, 13 Feb 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835476; cv=none; b=dNM9sRxSBsPu/CmHugf5pp625lRh8T2bo8WoOiUVBd6hLk4YVJQTudNXpYGbyBR5wslhD6EfAAt7xxqeH9OuQKIM2vV6exQmsirP0H0TVbGKvcCKi/WvS4PSgUuUiJCXVOiXjTin4v5mbeYoLjg4WoAhRoBNOLVtGdb5sjErmyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835476; c=relaxed/simple;
	bh=40HhOZ7I6r9KO7Crjk6jgqhf9PkR8540d0W63DCKBWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBe9/mCYvF1E4E/lVnTDthmdHwT1Mgxi77IrjgJNiyIMFxgePMF4K7i2SdqrPyTFpzT45EIsHaDElReWyweFwB4zTBtrsTVQ0GXkAutobuu5Raek57E4J//2D/gru6WHZtytMvmbaiwQXIYI2AxDa11iY4m/vN1ErLj1L02lIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lCaNGj6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3897C433C7;
	Tue, 13 Feb 2024 14:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707835476;
	bh=40HhOZ7I6r9KO7Crjk6jgqhf9PkR8540d0W63DCKBWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCaNGj6W+NZJLl77lQz9uAZi7DL6neH8aFZyohY/c5lEJxDFlpr4MPYIqehPKw2nn
	 yumTn4TUCr1DgM/J7pQ7ttJo81BFItvc5pKsiIW7i9v0PvoXErWgVsZLl/Bul97nSK
	 bWqYnRGjIeC7JrYxJdicf8NyscGPzE3mTj5TQ7d8=
Date: Tue, 13 Feb 2024 15:44:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs stable updates for v6.7
Message-ID: <2024021300-deck-duffel-5d2b@gregkh>
References: <6yl6zvu2pa3mz7irsaax5ivp6kh3dae5kaslvst7yafmg6672g@mskleu2vjfp2>
 <2024021307-reactive-woven-8543@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021307-reactive-woven-8543@gregkh>

On Tue, Feb 13, 2024 at 03:38:10PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 08, 2024 at 08:14:39PM -0500, Kent Overstreet wrote:
> > Hi Greg, few stable updates for you -
> > 
> > Cheers,
> > Kent
> > 
> > The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:
> > 
> >   Linux 6.7 (2024-01-07 12:18:38 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-for-v6.7-stable-20240208
> > 
> > for you to fetch changes up to f1582f4774ac7c30c5460a8c7a6e5a82b9ce5a6a:
> > 
> >   bcachefs: time_stats: Check for last_event == 0 when updating freq stats (2024-02-08 15:33:11 -0500)
> 
> This didn't work well :(
> 
> All of the original git commit ids are gone, and for me to look them up
> and add them back by hand is a pain.  I'll do it this time, but next
> time can you please include them in the commit somewhere (cherry-pick -x
> will do it automatically for you)
> 
> Let's see if I can figure it out...

I got all but 3 applied, can you please send an updated set of 3 patches
for the ones I couldn't just cherry-pick from Linus's tree?

thanks,

greg k-h

