Return-Path: <linux-kernel+bounces-67301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A18485696E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9AC1F2A4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BD313473C;
	Thu, 15 Feb 2024 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="xIlQf3jZ"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA36341F;
	Thu, 15 Feb 2024 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013945; cv=none; b=o7KvjvpRV5IOH2OIepxw6rmmtjH4qYkxhlCwtjRsHbY+lt09Xv145pZtA8KqXf46s07QO8iQLdPAS/PnUddfRedySqJs33lq9jTLhJVOElWWeirByu6dh+C1MFJ7BN6K//s/GyF9jg7Jj+UiW3/dngofQYhyReYL+Ht0CBcia+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013945; c=relaxed/simple;
	bh=PcFBMZiQYBH71c2rrxzUDi5y1utt8Rnyzi5Fbt9/RhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSbySyQp6SA7yEBupTeLKlCME06lwEY/efAAjcdueUohxfia5MPIzHDtFTOqk1TOfCN3JcBN1+koQ37TGOjoOzhuJHL/RvPaluwvu8EeP6dJ1lvGPe1Gspn9crgkDNxWtWpfzkigEFKKMEw1NDsL+k8AXEg53vjKobTQIKd7FDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=xIlQf3jZ; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 5110D635B048;
	Thu, 15 Feb 2024 17:11:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1708013475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1ABQsGHQyPkw9knwFU9RouseYJ0+l0nXTl+Vp1/CvI=;
	b=xIlQf3jZ4K+o3e8nJHsFZ1h3td7iAWthvJP0ViG8OZSIkLYsYEjz35hB3n/G1Hj/ip9Xte
	UlblptM6c54iKKhteIanSBAf0qBPJTiyqsJkVA741P2oJ/ftG/7r39lDGHBRkctPGY8aOD
	VvXI7xnwHgeEPJmBZ3skWKtOcq5C9aI=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, security@kernel.org,
 Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
 Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Date: Thu, 15 Feb 2024 17:10:50 +0100
Message-ID: <12454500.O9o76ZdvQC@natalenko.name>
In-Reply-To: <2024021532-commode-knickers-3895@gregkh>
References:
 <2024021430-blanching-spotter-c7c8@gregkh>
 <CAKXUXMw-xZ_w6prrdTG5Vs=QL1EDvwGv1M9r2PT14LE+HxWUHQ@mail.gmail.com>
 <2024021532-commode-knickers-3895@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5828478.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5828478.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Thu, 15 Feb 2024 17:10:50 +0100
Message-ID: <12454500.O9o76ZdvQC@natalenko.name>
In-Reply-To: <2024021532-commode-knickers-3895@gregkh>
MIME-Version: 1.0

Hello.

On =C4=8Dtvrtek 15. =C3=BAnora 2024 13:04:56 CET Greg Kroah-Hartman wrote:
> On Wed, Feb 14, 2024 at 09:34:38AM +0100, Lukas Bulwahn wrote:
> > On Wed, Feb 14, 2024 at 9:01=E2=80=AFAM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > The Linux kernel project now has the ability to assign CVEs to fixed
> > > issues, so document the process and how individual developers can get=
 a
> > > CVE if one is not automatically assigned for their fixes.
> > >
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > ---
> > > v3: fix up wording in security-bugs.rst based on the changes to the c=
ve
> > >     assignment process from v1, thanks to a private reviewer for
> > >     pointing that out.
> > > v2: Grammer fixes based on review from Randy
> > >     Updated paragraph about how CVE identifiers will be assigned
> > >     (automatically when added to stable trees, or ask us for one
> > >     directly before that happens if so desired)
> > >
> >=20
> > Hi Greg, Sasha, Lee,
> >=20
> > Generally, I think this is a great step forward on the whole "security
> > vulnerability mess" and this will certainly help me and others in the
> > embedded space to argue to update to recent stable kernel versions.
> > This can then finally put the practice of shipping multiple-year-old
> > kernel versions to an end. Often this was just done with the argument
> > that there is not a recent CVE and fix assigned to some recent stable
> > kernel version---and integrators think updates to recent kernel stable
> > versions are not needed and not recommended.
> >=20
> > I am looking forward to seeing what and how many stable commits are
> > going to get CVEs assigned. If Greg's policy from the Kernel Recipes
> > 2019 presentation comes into play, every git kernel hash (GKH)---at
> > least in the stable tree---could get a CVE identifier (just to be on
> > the safe side). But I assume you are going to use some expert
> > knowledge, heuristics or some machine-learning AI to make some commits
> > in the stable tree carrying a CVE identifier and some others not.
>=20
> Yes, that "expert knowledge" will be "review all patches by hand" just
> like we do today for all that are included in the stable trees.

Not undermining your efforts in any way, but I'd like to get an honest answ=
er: is this really true? For instance,

$ git log --oneline v6.7.1..v6.7.2 | wc -l
641

Is it physically possible to actually review all these backports in just fi=
ve days?

Thank you.

>=20
> > Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>=20
> Thanks for the review.
>=20
> > > +Common Vulnerabilities and Exposure (CVE=C2=AE) numbers were develop=
ed as an
> > > +unambiguous way to identify, define, and catalog publicly disclosed
> > > +security vulnerabilities.  Over time, their usefulness has declined =
with
> > > +regards to the kernel project, and CVE numbers were very often assig=
ned
> > > +in inappropriate ways and for inappropriate reasons.  Because of thi=
s,
> > > +the kernel development community has tended to avoid them.  However,=
 the
> > > +combination of continuing pressure to assign CVEs and other forms of
> > > +security identifiers, and ongoing abuses by community members outsid=
e of
> > > +the kernel community has made it clear that the kernel community sho=
uld
> > > +have control over those assignments.
> > > +
> >=20
> > Though, I get what is meant with "the community members outside of the
> > kernel community", it still feels strange when reading.
> >=20
> > Here are some alternatives I could come up with:
> >=20
> > "reporters outside the kernel community"
> > "reporters beyond the actively contributing/engaged kernel community me=
mbers"
> > "individuals not engaged with the kernel community"
>=20
> "community members" is a strange wording, you are right, I've replaced
> it with "individuals and companies" as it has been both abusing the
> system (and "individuals at companies", but that's just nit-picking...)
>=20
> > > +The Linux kernel developer team does have the ability to assign CVEs=
 for
> > > +potential Linux kernel security issues.  This assignment is independ=
ent
> > > +of the :doc:`normal Linux kernel security bug reporting
> > > +process<../process/security_bugs>`.
> > > +
> > > +A list of all assigned CVEs for the Linux kernel can be found in the
> > > +archives of the linux-cve mailing list, as seen on
> > > +https://lore.kernel.org/linux-cve-announce/.  To get notice of the
> > > +assigned CVEs, please subscribe to that mailing list.
> > > +
> > > +Process
> > > +-------
> > > +
> > > +As part of the normal stable release process, kernel changes that are
> > > +potentially security issues are identified by the developers respons=
ible
> > > +for CVE number assignments and have CVE numbers automatically assign=
ed
> > > +to them.  These assignments are published on the linux-cve-announce
> > > +mailing list as announcements on a frequent basis.
> > > +
> > > +Note, due to the layer at which the Linux kernel is in a system, alm=
ost
> > > +any bug might be exploitable to compromise the security of the kerne=
l,
> >=20
> > Just a nit: but I would say: a kernel bug is compromising the
> > "security of the system"; the kernel bug just happens to allow anyone
> > to run any code on their hardware... in some systems that is a
> > security issue, but in my previous MSDOS system that was the default
> > behaviour ;)
>=20
> Good change, made, thanks!
>=20
> greg k-h
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart5828478.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmXON4oACgkQil/iNcg8
M0uqTxAAmk6x+IahqEYoc7nYIsHWT6pgEnm6Tx7R4fELlQQ1Z3JqVzXRytUoaZty
nTdzVYq4uPjyg6wzh9/QiMR4bRcoKw75cRIU1R5EH4PNpoU/I1XAiACP+C/viOT4
Lv2kJ6SY6niyYDhAeg5Yk8ycWN52Y6Fno6HphzvYg9fYboKaGDfyNCFiWq76ludb
ocRTVyPoUcvTW4fe4Yjap1uGG4hw1RRDY919z78UzZ64NgiSBNp8MeK2lGOFcL9E
KgwEVOqH/iIBrCgfIiDZxp1pip/nHBLH61GwLPLXxmLwPYXVFHD7P+r466luBLF4
+rs/0XMBWbGzrgZMX6fTIYObsuaM4J0m0IhHdnRD7DKZRS3qr0vl/2EnRg+BqeKZ
md6xu3L3Xwem000EdrSpmMzGQ+dVDsU0Z/N912vB1zJdyt9gWARwpf7EDNliZP55
UqEzzgPXarU29fkv+6rPEWXHGKz42gGmIjW2gL2iP6eojfPkeszD1pZGdDqKS1zs
7I0XmXAKTdXMqrL4GR1Q6gCLYByESB8Xs5PGi9PQnKjT6MpXY7FO5+CXoWC/9B7S
ZDZClffguL+AZwbCUraL+bDNRzf8czndOA4De6tMVa4ffeIUUE9XFDHrbbwRQwRH
kHCeHL5jDMljAqOb20NVfTi/s2GOk7iAKhEZw5i/fCzFFfuOYdQ=
=ChnR
-----END PGP SIGNATURE-----

--nextPart5828478.DvuYhMxLoT--




