Return-Path: <linux-kernel+bounces-120646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF55D88DAEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DAB1F29805
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD372481AE;
	Wed, 27 Mar 2024 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VH/1QPRr"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF5B28DC8;
	Wed, 27 Mar 2024 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533866; cv=none; b=f2ZopOKyb/aRd3ig1aOFwOcEnb4pnezqFdTglWxdPTKmzTCGooO22jdu+wvcxUnAD8vNDSzndoNWkcXnJ7IsZ/M2wvMjnv523e98tsr/Ja2+rMQB7cdyfDs0cdkw3GF7OCTnqN4fx1s9kNX55DQNeRNP1/uxa6zW1QIgDS4INe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533866; c=relaxed/simple;
	bh=zHOu1BT4fq1H4eWqrAQyEF+PfNhdL/j7V9bzrUJW7HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWJgAFYfsHLE9llL8d/hkXhTiycqdR8qDO45UiN7/hOioLY3qe1uBAQeStosvNu9LS3vWuUIwBaLUR15OPk9DZrMtGjPrnoFI9GG+cb6x6edoDQx5HkxwCEVN03P+B0ZMyTCJh6VVatxzWFnyhnru/y0Gst9VeU570UpKinNyUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VH/1QPRr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E04B11BF20B;
	Wed, 27 Mar 2024 10:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711533862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgNmLJ4l/KBe87QFrkbOM5L8fAhZx6xWjXCh9e2pDEc=;
	b=VH/1QPRr4jfGXlSjHqumCG6tjGGLz7K4UUoU6z4cK1Pdou/0BYzCPbyj8gNbCYrgnh5y0w
	+xGd+767Gqpwwuz3RmTIaeY0MwzebMUO5W6DRjXxE+tY5G+wGbJJcfrISUjCBTiyTCXLQ9
	Urlqke1yVz5RV9TklMFATxHEN+JD+HsXv42Cn0aIfZMuMQFwerk8P5ewdSy2WjLAW+RFmn
	nfMoGpqQFbKShC0X7x1qtRKsKiHhbkER+yxbpn2qtnFN8flnuJ6PAcsLxKLzcZhPbrPRP7
	o/DPJxZ7nfyctaUh27f2ZCrEvjIwy7t228Z3FaNJkfdiPSOgEeqvEH3577R+fA==
Date: Wed, 27 Mar 2024 11:04:21 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Richard Weinberger <richard@nod.at>, Theodore Ts'o <tytso@mit.edu>,
	Tyler Hicks <code@tyhicks.com>
Subject: Re: linux-next: trees being removed
Message-ID: <20240327100421604167cd@mail.local>
References: <20240327101309.4e7d04f3@canb.auug.org.au>
 <20240327041653.GA35281@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327041653.GA35281@sol.localdomain>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 26/03/2024 21:16:53-0700, Eric Biggers wrote:
> On Wed, Mar 27, 2024 at 10:13:09AM +1100, Stephen Rothwell wrote:
> > The following trees are going to be removed from linux-next because they
> > have not been updated in more than a year.  If you want a tree restored,
> > just let me know (and update its branch).
> > 
> > Tree			Last commit date
> >   URL
> >   comits (if any)
> > ----			----------------
> > ecryptfs		2023-03-24 17:26:44 -0500
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git#next
> >   c1cc2db21607 ("ecryptfs: keystore: Fix typo 'the the' in comment")
> >   a3d78fe3e1ae ("fs: ecryptfs: comment typo fix")
> > fscrypt-current		2023-03-18 21:08:03 -0700
> >   git://git.kernel.org/pub/scm/fs/fscrypt/linux.git#for-current
> > fsverity-current	2023-03-15 22:50:41 -0700
> >   git://git.kernel.org/pub/scm/fs/fsverity/linux.git#for-current
> > modules-fixes		2023-02-06 08:45:55 -0800
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git#modules-linus
> > rtc-fixes		2023-01-23 23:33:47 +0100
> >   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git#rtc-fixes
> > tee-fixes		2023-02-12 14:10:17 -0800
> >   https://git.linaro.org/people/jens.wiklander/linux-tee.git#fixes
> > ubifs-fixes		2023-01-21 16:27:01 -0800
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git#fixes
> 
> fscrypt-current and fsverity-current are technically still in use.  I just
> haven't used them recently because there haven't been any bug fixes that needed
> to go in while other commits were already applied for the next merge window.
> 
> I've updated them to v6.9-rc1.
> 
> I'd guess that some of those *-fixes branches have something similar going on,
> where they may be rarely used fixes branches as opposed to the main development
> branch.
> 

This is exactly my case. I don't mind my branch being dropped and I can
ask to add it back once I have urgent fixes.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

