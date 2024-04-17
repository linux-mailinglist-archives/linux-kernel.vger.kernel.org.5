Return-Path: <linux-kernel+bounces-148941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C08A896C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C14284B93
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258BA17164C;
	Wed, 17 Apr 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgUmr/cJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6701517106F;
	Wed, 17 Apr 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372970; cv=none; b=hPY/iLG5odmSKYUJcBjecV9K7h2NhCoBFTXRbJucSX5Ca0gBtk6wQcvLNfozAPzG5EWXpjZkoOlfBikW5udkHMkI4wX8jfb0gOEeNP0b/hhvfsTheJB3Ro0nD3k/D1cS4asYfH17lTIwX1CmXRmZ5//SfJbyhMOMCqZBoofES4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372970; c=relaxed/simple;
	bh=naHEJLhXEjzMrrKnJsTa18gff65eKpGUlxZm08ziO5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKoT1uxA83P2+/ARymOw3Cc/8AST2E8JWGDNpCN9XUS0iksQ86KObA3u+NjHccgHSiSdzJUI718spzf18M/fIIGfh94dYcCGsMctncpzkQVgOA2A4Ae1XC1SnVUcn9cz2yaNphZAshPMSKnKxD61szRIzoZ+/a0do9NydzcKZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgUmr/cJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA2FC32782;
	Wed, 17 Apr 2024 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713372970;
	bh=naHEJLhXEjzMrrKnJsTa18gff65eKpGUlxZm08ziO5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HgUmr/cJT4LAPRutbmXu5zt/nTjS6Rsv+RuAbNP4blqJmOkWtKOT658WG09KvxBIt
	 +yfm10LCDEWLryXBGIoGV8rP+cd12qIQoe370dxZIjMoCgCTW6TmyFtHJJNTRdzFpX
	 LHFdmK9HzbsnsWRML6NiBoPPiZ5m0rT4RaDGdGHg5iLhroPkhERQHK++Enn7hyByGi
	 /6OUJhcuL4Uo/jHiqM/dIF/AS06yj+xLgt3KKK0GSsaq5x9hO+vJ1HOi+PXPUouF9/
	 P++b0tSuCRGXxNSqT8O2X6NYczRyjQ/I9mBnWFRPgy7NTigUCzl+9cfzK5RA12P400
	 d3DCYDt/tFNCQ==
Date: Wed, 17 Apr 2024 17:56:05 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, helpdesk@kernel.org,
 "workflows@vger.kernel.org" <workflows@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
Message-ID: <20240417175605.3639157a@sal.lan>
In-Reply-To: <2024041715-calorie-late-c4de@gregkh>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
	<20240417090918.77360289@sal.lan>
	<2024041715-calorie-late-c4de@gregkh>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Wed, 17 Apr 2024 10:16:26 +0200
Greg KH <gregkh@linuxfoundation.org> escreveu:

> On Wed, Apr 17, 2024 at 09:09:26AM +0100, Mauro Carvalho Chehab wrote:
> > Em Wed, 17 Apr 2024 09:48:18 +0200
> > Thorsten Leemhuis <linux@leemhuis.info> escreveu:
> >  =20
> > > Hi kernel.org helpdesk!
> > >=20
> > > Could you please create the email alias
> > > do-not-apply-to-stable@kernel.org which redirects all mail to /dev/nu=
ll,
> > > just like stable@kernel.org does?
> > >=20
> > > That's an idea GregKH brought up a few days ago here:
> > > https://lore.kernel.org/all/2024041123-earthling-primarily-4656@gregk=
h/
> > >=20
> > > To quote:
> > >  =20
> > > > How about:
> > > > 	cc: <do-not-apply-to-stable@kernel.org> # Reason goes here, and mu=
st be present
> > > >=20
> > > > and we can make that address be routed to /dev/null just like
> > > > <stable@kernel.org> is?   =20
> > >=20
> > > There was some discussion about using something shorter, but in the e=
nd
> > > there was no strong opposition and the thread ended a a few days ago.=
 =20
> >=20
> > Heh, a shorter name would make it a lot easier to remember, specially
> > since not wanting a patch to go to stable is an exception... I bet
> > I'll never remember the right syntax, needing to look at the docs
> > every time it would be used.
> >=20
> > IMO, something like:
> > 	no-stable
> > or
> > 	nostable
> >=20
> > would do the trick and would be a lot easier to remember.
> >=20
> > Btw, IMO, it won't hurt accepting more than one variant that
> > could be allowed, e. g. using a regular expression like:
> >=20
> > 	(do)?[-_]?(nt|not?).*stable =20
>=20
> That's not going to work at the mailing list server, or with my scripts,
> sorry.

A setting like that would likely be at exim (or similar). Most smtp servers
allow some sort of wildcards, as those are used to pass or not e-mails to
list servers and/or handle custom mail forward rules.

At client level, one could use dovecot with pigeonhole to have sieve
rules to filter e-mails. That's what I do here.
=20
> > at the scripts used by stable developers - and maybe at the ML server -=
 to
> > catch different variations won't hurt, as it sounds likely that people =
will
> > end messing up with a big name like "do-not-apply-to-stable", typing
> > instead things like:
> >=20
> > 	do_not_apply_to_stable
> > 	dont-apply-to-stable
> >=20
> > and other variants. =20
>=20
> I want this very explicit that someone does not want this applied, and
> that it has a reason to do so.  And if getting the email right to do so
> is the issue with that, that's fine.  This is a very rare case that
> almost no one should normally hit.

Yeah, agreed: those are very rare exceptions. I remember just one or=20
two cases where a media fix patch couldn't be queued to stable.=20
The already-existing workflow worked for those.

> And again, if maintainers don't want their tree to have Fixes: and
> AUTOBOT run on them, we can easily add that to our lists.  That's the
> simpler and more explicit thing to do for those that do not want to have
> anything backported they do not explicitly mark as such (some subsystems
> do this already, like kvm and -mm and xfs, it's fine!).  This all is
> here because of maintainers who do NOT want to do that.

=46rom my side, I'm fine with whatever-explicit-long-filter-email.

Regards,
Mauro


