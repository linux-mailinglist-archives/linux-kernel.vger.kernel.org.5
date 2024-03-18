Return-Path: <linux-kernel+bounces-105916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04D787E659
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E3BB2211C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49A92D602;
	Mon, 18 Mar 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA9dHlB5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05342D029;
	Mon, 18 Mar 2024 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755459; cv=none; b=NnUS4vbaou9b4HLYbDpG2DgYhsXnzyn0uydd3XoSdj2nVFPmL+UbEhnzmMkiEsdxaq6VCzmLC58xjIwuFIw6rBz2VAZ5Kf97bk63P+aVWG4bE4nYx0J+QZNjvZRDmwueb8myirxfNm1u4Awq0T/QWJ27GFj140+gDWegTUNmalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755459; c=relaxed/simple;
	bh=GtiAsryJiIMLKj1emvBm1jrA0Ny409Z6CRr5ZugckOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKqGibSF0WuV4iAjZBe/IOw0OifWRVrtzeQMWM8xcSB0W0tucolz8Dj/gQRE9fz1Heb2BIrl8eDaaRGVwQ3gV4hBoLHmRP8YBCaSyJ0bVOZSpd1WseeoIGmbBV4tisbspdczUAtu0sGAXchali89Vg4M68H/YrJM0y1dpPg7XF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA9dHlB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A03DC433F1;
	Mon, 18 Mar 2024 09:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710755459;
	bh=GtiAsryJiIMLKj1emvBm1jrA0Ny409Z6CRr5ZugckOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DA9dHlB5p7ohUneVhqHFIENoif6fuYu7DFC1HDuAjN7aPmSlAd0eV0a28SDFA4NAt
	 HqR+UiYy3HGL5LJXGIn4oOVNxrDq/DHQUKoLn2k61aJ0fkoUzKNcXcMHpu+9WKxKjp
	 y+c15lq/8gxstTVx9ckmPTDI/znWLJfB1/r1gL2M1qrwY5nI0bLoiy4+AybuQCCnNI
	 muLqkWk5MsiyysDSYsfolRQ+aaFHUyoLc+QlvxlTUTANxwYFbXr1/ZyX+1Qd1Rf2m4
	 AHryrQU71AL+B+h6XK1If5k8odLHWDMtnFJJjQcc7usTvqAuzXFxXY8O2oLa0xXUpH
	 DkEfIZn5h+OIg==
Date: Mon, 18 Mar 2024 10:50:42 +0100
From: Alejandro Colomar <alx@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Shervin Oloumi <enlightened@chromium.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 1/2] landlock: Extend documentation for kernel support
Message-ID: <ZfgOf2dHBVT4WUcp@debian>
References: <20240227110550.3702236-1-mic@digikod.net>
 <Zd4OlL1G3t1D3TgC@google.com>
 <20240307.oxQuab5tho0u@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t2wrf6PLaMqwtsDi"
Content-Disposition: inline
In-Reply-To: <20240307.oxQuab5tho0u@digikod.net>


--t2wrf6PLaMqwtsDi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Mar 2024 10:50:42 +0100
From: Alejandro Colomar <alx@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Shervin Oloumi <enlightened@chromium.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 1/2] landlock: Extend documentation for kernel support

Hi Micka=C3=ABl, G=C3=BCnther,

Sorry for the delay!

On Thu, Mar 07, 2024 at 11:21:57AM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> CCing Alejandro
>=20
> On Tue, Feb 27, 2024 at 05:32:20PM +0100, G=C3=BCnther Noack wrote:
> > On Tue, Feb 27, 2024 at 12:05:49PM +0100, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > Extend the kernel support section with one subsection for build time
> > > configuration and another for boot time configuration.
> > >=20
> > > Extend the boot time subsection with a concrete example.
> > >=20
> > > Update the journalctl command to include the boot option.
> > >=20
> > > Cc: G=C3=BCnther Noack <gnoack@google.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > ---
> > >=20
> > > Changes since v1:
> > > * New patch, suggested by Kees Cook.
> > > ---
> > >  Documentation/userspace-api/landlock.rst | 57 +++++++++++++++++++++-=
--
> > >  1 file changed, 51 insertions(+), 6 deletions(-)

[...]

> > > +
> > > +  lsm=3Dlandlock,lockdown,yama,integrity,apparmor
> > > +
> > > +After a reboot, we can check that Landlock is up and running by look=
ing at
> > > +kernel logs:
> > > +
> > > +.. code-block:: console
> > > +
> > > +    # dmesg | grep landlock || journalctl -kb -g landlock
> > > +    [    0.000000] Command line: [...] lsm=3Dlandlock,lockdown,yama,=
integrity,apparmor
> > > +    [    0.000000] Kernel command line: [...] lsm=3Dlandlock,lockdow=
n,yama,integrity,apparmor
> > > +    [    0.000000] LSM: initializing lsm=3Dlockdown,capability,landl=
ock,yama,integrity,apparmor
> > > +    [    0.000000] landlock: Up and running.
> > > +
> > > +Note that according to the built time kernel configuration,
> >=20
> > s/built time/build time/
> >                  ^
>=20
> OK

Here, this should actually be "build-time" since it works as an
adjective.

>=20
> >=20
> > It feels like the phrase "according to" could be slightly more specific=
 here.
> >=20
> > To paraphrase Alejandro Colomar, "Note that" is usually redundant.
> > https://lore.kernel.org/all/0aafcdd6-4ac7-8501-c607-9a24a98597d7@gmail.=
com/
> >=20
> > I'd suggest:
> >=20
> >   The kernel may be configured at build time to always load the ``lockd=
own`` and
> >   ``capability`` LSMs.  In that case, these LSMs will appear at the beg=
inning of
> >   the ``LSM: initializing`` log line as well, even if they are not conf=
igured in
> >   the boot loader.

LGTM

>=20
> OK, I integrated your suggestion.  I guess `capability` is not really
> considered an LSM but it would be too confusing and out of scope for an
> user documentation to explain that.
>=20
> >=20
> > > +``lockdown,capability,`` may always stay at the beginning of the ``L=
SM:
> > > +initializing lsm=3D`` list even if they are not configured with the =
bootloader,
> >=20
> > Nit: The man pages spell this in two words as "boot loader".
>=20
> OK, I'll use "boot loader" too.
>=20
> >=20
> >=20
> > > +which is OK.
> > > +
> > > +Network support
> > > +---------------
> > > +
> > >  To be able to explicitly allow TCP operations (e.g., adding a networ=
k rule with
> > >  ``LANDLOCK_ACCESS_NET_BIND_TCP``), the kernel must support TCP
> > >  (``CONFIG_INET=3Dy``).  Otherwise, sys_landlock_add_rule() returns an
> > >=20
> > > base-commit: b4007fd27206c478a4b76e299bddf4a71787f520
> > > --=20
> > > 2.44.0
> > >=20
> >=20
> > Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
>=20
> Thanks!

Reviewed-by: Alejandro Colomar <alx@kernel.org>

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--t2wrf6PLaMqwtsDi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmX4DnIACgkQnowa+77/
2zJdTA//d7J8aVihMiGfZiCLI9GhosQmnzKqxH6nxyShkAcHLDoJYZfAPDpXfqwM
DlQAXbMmO+WWQrBXMQ97vYvNE4g6ldl53CAb5X2R96KBhR8vXToXkm/DfvxIeeEF
Gc+B20PgyRtWqs1fWwZ6kBpIOEv4vhi2+KSky1FQUmTp7tUQXUNd8IaB8/8pXxzY
YP04T18MMZ8qOMVnC4PnfJm2gij39i45YG7m3OT6hiFwh+AztlK3fFAZdIBM1X1O
HTq36UG3E2Zog6kE7SjIUeRXcN+GG/9XraeQkyjBuiAR+4EmA9Z6fOcz41j9pu7w
1fGpZ2i/19wTRkyAvzMZGjVUrCcItur/dkGuXAfzEvuuqsgLuLcabKqvz3EbLTme
+DBSaB+Q9FIx3ema9i/X1k098GLgDrlwS755Q2whV2LnUXfhor2r+OT22kDVedby
xpxdkOWTTkBjwsnApw0QVw75xEh+ozGmVhfqi8sSwwZ5NS3I3EzAEVNjMOJJvVZS
UUbooDUYC1YUuBDlhZfWl3HcSPFseBx/BT9YBGs9qq30dGC2Rv8LGmxSXRRo4zYJ
+cw9OJ9iCyogF9M4wcRK8WgzCVQ3Al6LlyAS42D+WiBJcmKXS+pFRzodb+HwtxBG
X3G5U8RdRDbVhz/YaNx1Q9IZ0A4CW6WcYi5/G45RvN8LPH4M42o=
=XEON
-----END PGP SIGNATURE-----

--t2wrf6PLaMqwtsDi--

