Return-Path: <linux-kernel+bounces-77244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B6386027F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816D11C24974
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CD6548E5;
	Thu, 22 Feb 2024 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="jWtKaN2e"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C902814B804;
	Thu, 22 Feb 2024 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629551; cv=none; b=HfJeR8+N7GRahZxOg7NlwLqD4yLaWd/baVzcGYJBjfu1nPIIAThQziFVyAxREWR0xLW0rDXPo0NlndFOTxdbw9Jap05ZutUkE+Fftpnnr0/Lr1DKGxEBSDuA6BeDm73gqAuI5W358p7Xm6Qnb+cQkytwqSZZY5W5jkF2jYHC7L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629551; c=relaxed/simple;
	bh=qhLehXJeOerzMpqJ0h4GqLLY/DHCVpEfMMpWFb2pWGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBZR+ZsXMvx2Wa2+PUqlCZDY4I/ikCPqMJJIderfBqH3ohDUYs3FZRuHg2JjVWaNdv7eofBX+pBrQ7lB4QiG24KN5lkOZtPcEpDdhuP7ypEvmMu2I21W5SqNDbX87M+LG/B/YIP2voKFCIlhQHntk2biLgtIsC2CennyO+5eZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=jWtKaN2e; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9E3FF1C0080; Thu, 22 Feb 2024 20:19:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708629546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1CReOHfu8cM+87GmnCZWyhephfKgSIBTovz2lAsV5Kc=;
	b=jWtKaN2e9fc60EjhziDDwBilk8Gj6DB8OqD4KR+qd5CNP8cczOyqkEbFnzGX8JiNZlBj4a
	Zs64RPijgEDBx5Mjm40pWTvxRhxAuejqcjNq3dDh47O/BBF/ayqzB7R0A7VoSdIpesRIJd
	jgr29KeXc2RcHrpc9kZDjgFzBR1gEeo=
Date: Thu, 22 Feb 2024 20:19:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Vlastimil Babka <vbabka@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jiri Benc <jbenc@redhat.com>, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: stable-kernel-rules was Re: fs/bcachefs/
Message-ID: <ZdeeKiTXc7WidRcs@duo.ucw.cz>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <uknxc26o6td7g6rawxffvsez46djmvcy2532kza2zyjuj33k7p@4jdywourgtqg>
 <2024022103-municipal-filter-fb3f@gregkh>
 <4900587.31r3eYUQgx@natalenko.name>
 <2024022155-reformat-scorer-98ae@gregkh>
 <aaf2f030-b6f4-437b-bb4e-79aa4891ae56@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s+LkKkXk95XsNqZb"
Content-Disposition: inline
In-Reply-To: <aaf2f030-b6f4-437b-bb4e-79aa4891ae56@suse.cz>


--s+LkKkXk95XsNqZb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Personally I think we are not taking enough, and are still missing real
> > fixes.  Overall, this is only a very small % of what goes into Linus's
> > tree every day, so by that measure alone, we know we are missing things.
>=20
> What % of what goes into Linus's tree do you think fits within the rules
> stated in Documentation/process/stable-kernel-rules.rst ? I don't know but
> "very small" would be my guess, so we should be fine as it is?
>=20
> Or are the rules actually still being observed? I doubt e.g. many of the
> AUTOSEL backports fit them? Should we rename the file to
> stable-rules-nonsense.rst?

There seems to be just one rule being observed: "It or an equivalent
fix must already exist in Linus' tree (upstream).". Every other rule is
broken pretty much all the time.

AUTOSEL is a problem.

Plus there's problem with dependencies -- if a patch A is need for fix
B, the rules pretty much go out of the window, huge patches are
applied, whitespace fixes are applied, etc.

There are even known-bad patches being applied, and then
reverted. Greg explained that it heps his process somehow.

For example in 6.1.53 review, my notes say 30% of the patches did not
match the documented rules. 42% for v6.1.76.

OTOH ammount of patches that cause "real" problems is not that great,
and we seem to have enough testing. Still, updating the documentation
to match the reality would be good (perhaps explaining that stable
does not have manpower to re-do the dependencies, and how "apply bad
and revert" works).

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--s+LkKkXk95XsNqZb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdeeKgAKCRAw5/Bqldv6
8vdCAJ0RFoBCe44jaM/9Yby4MDmhD7BKnwCgow91ieOFc1Kq+uvHpe2550KDnV0=
=f+89
-----END PGP SIGNATURE-----

--s+LkKkXk95XsNqZb--

