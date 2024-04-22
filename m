Return-Path: <linux-kernel+bounces-154076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FBE8AD724
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7631C21993
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E961F932;
	Mon, 22 Apr 2024 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlnz8/AV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E201D54F;
	Mon, 22 Apr 2024 22:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713824156; cv=none; b=PBlogTGceFgjXSsoNf09W4D2QfneJMGyAMamKDHDjwG0enkLtP4UL9B58zS2uaYXAAS4ROJ+SOHBSzCmMG+U1mXcY/U+0F0g6jaMLDmufVleaHbi74I0+115t6Vy8DSmq1pbyL6f2HLmEpYUUovOjWKiEfQnig571V46yBEyBa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713824156; c=relaxed/simple;
	bh=YLj1Y4Zq6gvQIdES41SRPwMqvfsPBwNoD4Vei+Csd6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTGNxo38OXvY2diMjifrWe3GLcePKrw6WL0b3Kh8dAAG6nllZLCcZF5SOqrZUF3zbSUNcsfZQ5CQVXyFYTOjPRtIICBplWuiUr8DGSiKiW1Q0l/hH31CPcagQd2UOdAZiBTd2mGihHkq3cgtcoXFKO3eGVmS63RGUNadTWotgF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlnz8/AV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7FBC113CC;
	Mon, 22 Apr 2024 22:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713824155;
	bh=YLj1Y4Zq6gvQIdES41SRPwMqvfsPBwNoD4Vei+Csd6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jlnz8/AVBBUSN2shBrWF8FFrD85UTYA1ypKhTU9vjmW4NGV3f1kI1JUAb0HZ/5TDF
	 NWMB8iGfyjcAO5ukXretxuUvIlDXzA0Cmhy0cVywBGkc0p/JDvHFT9s9Cs/j5vTGJg
	 /1O+5EOhJ7TiYukxqWD8x8zqLF5MJA2WY0GipXN7bypsJ+ONPYBrEqsIBaQCZ41XJX
	 sYqI+4TaqnRAT2+V1Ktfe7yGf6amk1xXZTehr3zJKtga8Fn6LBaW4wZ3CXxtjhkcfA
	 kC3kHzo6B460UlXHB7RG9buB1KMgqs5Y8zQi08l57SjVGmFEN7wa2xcorvL1p6jejt
	 V7Mr/8JlvRfzw==
Date: Mon, 22 Apr 2024 23:15:50 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Thorsten Leemhuis
 <linux@leemhuis.info>, Sasha Levin <sashal@kernel.org>,
 helpdesk@kernel.org, "workflows@vger.kernel.org"
 <workflows@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
Message-ID: <20240422231550.3cf5f723@sal.lan>
In-Reply-To: <2024042311-slinky-musket-fc75@gregkh>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
	<20240417-lively-zebu-of-tact-efc8f3@lemur>
	<e7318984-7ef4-48cd-aae4-1deda3d711a5@leemhuis.info>
	<2024041734-gleeful-freewill-b24b@gregkh>
	<d4853f43-2538-4a92-9ac4-aff5c7b0893e@leemhuis.info>
	<2024041830-karaoke-aspirate-df00@gregkh>
	<655ce2a3-eb04-4ade-999e-23fc5dc5fb3a@leemhuis.info>
	<20240422-stoic-sawfly-of-protection-db8bfe@lemur>
	<20240422224637.01bb3058@sal.lan>
	<2024042311-slinky-musket-fc75@gregkh>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 23 Apr 2024 00:04:01 +0200
Greg KH <gregkh@linuxfoundation.org> escreveu:

> On Mon, Apr 22, 2024 at 10:46:37PM +0100, Mauro Carvalho Chehab wrote:
> > Em Mon, 22 Apr 2024 15:25:18 -0400
> > Konstantin Ryabitsev <konstantin@linuxfoundation.org> escreveu:
> >   
> > > On Mon, Apr 22, 2024 at 05:49:29PM +0200, Thorsten Leemhuis wrote:  
> > > > @Greg, BTW: should this be stable+noautosel@kernel.org or have a 
> > > > 'vger.'    
> > > 
> > > No vger, just stable+whatever@kernel.org.
> > >   
> > > > in it, e.g. stable+noautosel@vger.kernel.org? I assume without 'vger.'
> > > > is fine, just wanted to be sure, as
> > > > Documentation/process/stable-kernel-rules.rst in all other cases
> > > > specifies stable@vger.kernel.org, so people are likely to get confused.
> > > > :-/ #sigh    
> > > 
> > > These serve two different purposes:
> > > 
> > > stable@kernel.org (goes into devnull)
> > > stable@vger.kernel.org (actual mailing list)
> > > 
> > > Confusion happens all the time, unfortunately.  
> > 
> > Yeah, I did already used stable@kernel.org a few times in the
> > past. 
> > 
> > IMO, the best would be either for stable to also accept it or for
> > kernel.org mail server to return an error message (only to the
> > submitter) warning about the invalid address, eventually with a
> > hint message pointing to the correct value.  
> 
> stable@kernel.org is there to route to /dev/null on purpose so that
> developers/maintainers who only want their patches to get picked up when
> they hit Linus's tree, will have happen and not notify anyone else.
> This is especially good when dealing with security-related things as we
> have had MANY people accidentally leak patches way too early by having
>  cc: stable@vger.kernel.org in their signed-off-by areas, and forgetting
> to tell git send-email to suppress cc: when sending them out for
> internal review.

Nice! didn't know about that. On a quick check, the only place at
documentation mentioning it without vger is at checkpatch.rst.

Perhaps it would make sense to document that as well.

> Having that bounce would just be noisy for the developers involved.
> 
> thanks,
> 
> greg k-h

