Return-Path: <linux-kernel+bounces-95128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB31874987
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C424B1C21402
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6088563408;
	Thu,  7 Mar 2024 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj6R8WLM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD76306D;
	Thu,  7 Mar 2024 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799890; cv=none; b=SgGr4aVaheXNFFgvj6JsPWeErgIRBFkCAfza/16uBgSd62dzeEqmnkEh3BehkmSdCX6zZov1EQddSJOECFZtnj1osLsCEZAzs9kJ0JVOHi81/m23TKQ6s41zKjiSCaB7LFhr9Fnrrcip5QdlAoeC/bNO8BLPZxk8QNkMDDwooKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799890; c=relaxed/simple;
	bh=JRjeMOhVcUoYGH5wfYDmdc5dmJuRXe0e+FF4nl515X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZ9Ggl+XHPhIkELcBRz7z/aqya34Og27Ak/t5coDkmR3k9XVcdqrvOLxr/MbG5AUfXVzLZ2BFNfaSJGNYWjQXG27ensZBj4aIGF1kiy033URRAHnaxsgs+OzHAdxSnuWPqP0WFuB30LGUzN5nztUWcYMgTJwFPdbv+nG8Y/XeBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj6R8WLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22855C433C7;
	Thu,  7 Mar 2024 08:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709799890;
	bh=JRjeMOhVcUoYGH5wfYDmdc5dmJuRXe0e+FF4nl515X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fj6R8WLMvU4vNlTsx9EwZdiYvlgld0IKGoYwsXRN7lt26LFlNozeCNsZCMu6q6snW
	 dkRzRdJ7qC3lbWwlw+f/k2Ja47hvf1S5Y0Qbcuoz7NXShSt02131HvjQhoOS595ym+
	 OIQm8c9WjBXYB41k18jIYfXqfCbZrY/dA/Vyyk5G9om8CWk89cyKsKUWoMUK6PoEwr
	 ZK2AVPRPUCKFJfSY4wthKxbziOMLIyV7HnuXa7w8S4F24O6qwJvGIruCuv6xvW7KCO
	 DXkz9CEWTZDjt6Oid68kZylr0kXblDnTn7tbYjA9IzX0+BUN2P4GWF2Mtu5eWjYnx+
	 vfDIhVCi4/w2Q==
Date: Thu, 7 Mar 2024 08:24:45 +0000
From: Lee Jones <lee@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the backlight tree
Message-ID: <20240307082445.GK86322@google.com>
References: <20240226132828.7524baec@canb.auug.org.au>
 <20240305111634.57e84398@canb.auug.org.au>
 <20240305091737.GB5206@google.com>
 <20240306095539.0da4e342@canb.auug.org.au>
 <20240306140427.4cb24a5e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306140427.4cb24a5e@canb.auug.org.au>

On Wed, 06 Mar 2024, Stephen Rothwell wrote:

> Hi Lee,
> 
> On Wed, 6 Mar 2024 09:55:39 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Tue, 5 Mar 2024 09:17:37 +0000 Lee Jones <lee@kernel.org> wrote:
> > > On Tue, 05 Mar 2024, Stephen Rothwell wrote:  
> > > > On Mon, 26 Feb 2024 13:28:28 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:    
> > > > >
> > > > > After merging the backlight tree, today's linux-next build (x86_64
> > > > > allmodconfig) failed like this:
> > > > > 
> > > > > drivers/video/backlight/ktd2801-backlight.c:8:10: fatal error: linux/leds-expresswire.h: No such file or directory
> > > > >     8 | #include <linux/leds-expresswire.h>
> > > > >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > 
> > > > > Caused by commit
> > > > > 
> > > > >   48749e2f14e3 ("backlight: Add Kinetic KTD2801 backlight support")
> > > > > 
> > > > > I have used the backlight tree from next-20240223 for today.    
> > > > 
> > > > I am still getting this failure.    
> > > 
> > > I just pushed a bunch of patches.  
> > 
> > I saw only 3 new ones (forgot to push?) none of which addressed this
> > problem.
> > 
> > > Please let me know if this is still an issue tomorrow.  
> > 
> > The problem is that after Feb 23, you rebased your tree and dropped commit
> > 
> >   25ae5f5f4168 ("leds: Introduce ExpressWire library")
> > 
> > which (added the leds-expresswire.h header), but kept commit
> > 
> >   48749e2f14e3 ("backlight: Add Kinetic KTD2801 backlight support")
> > 
> > which uses it.
> 
> Now I see what happened.  I have 2 trees from you, the backlight tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git#for-backlight-next)
> and the leds-lj tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git#for-leds-next)
> and the former implicitly depends on the latter (and I merge the
> backlight tree first).  You should make that dependency explicit by
> merging (part of) the latter into the former (or something).

Right.  So you build each tree as its merged?

My assumption was that all things come together in -next?

-- 
Lee Jones [李琼斯]

