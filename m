Return-Path: <linux-kernel+bounces-107477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F7687FD0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385F51C21D85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3BF7F467;
	Tue, 19 Mar 2024 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr0g4cOT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6961CD13;
	Tue, 19 Mar 2024 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848421; cv=none; b=VLOrs1xA8ddAa9GisPltFMUzQc4XtuDfursFLVW939m4cD/oxSkUJZso+QpCQG6DDRpUvUKupK4i1uQJj67T4q9GN3yeiqtLJAXbuf+9RwVh26HpxT+g5aqpx78VfDOAtP0vn9r8kw4Fgi5ENQLTZfUAhVKMjDihu7xq+k0PRXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848421; c=relaxed/simple;
	bh=8H1N8IVK0aMrxHwTIAJImeJ74R0FI5ahgx9a7aRkzlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ap8sRU5WhOGtsLBMYnlWBjEceirnxBzME7PvF2obaKETXSdfVzP2uNN0huRS9lMYBQWHDXzd8WIAAFh9hY0w9KF6nJLlyJrldkuXFwWFWkHvMfH2/yv/suDegClIcCVHGcWpZk2BSsN9b4SlCzlIM5WDcEkC1vWhMOQdTTbE/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr0g4cOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2CAC43390;
	Tue, 19 Mar 2024 11:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710848421;
	bh=8H1N8IVK0aMrxHwTIAJImeJ74R0FI5ahgx9a7aRkzlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rr0g4cOTM/CSNGme7kyGe9YRJCgDiU5moZndh7++L++nc2cojq3Ce2hRPMiA1iN/D
	 hEv/OD8FeLqvCY1YCJCNcmhSvje+Gyoi2993zSyR40lIj6LY4AZDD55M4w9VIs3p7l
	 ODgW5swUhQQoPf81DpKji4GDxGSvdnCkDxdfyjdjradptmAhw3EUhD1Nq9VVwaYYd8
	 m71+oBXPUO9QT5uSeqpCUJ76Z208X8JJy1g86iFBrEyvbtIWXOfEH7uSjRddyq6jpR
	 lS726NFVZn3RntMrxSz8EnN8K+3c4eLPELPWi25qWIo/xJ2o0PpTBDH5NFkCcJNNDD
	 YWbwuHRvGPGSQ==
Date: Tue, 19 Mar 2024 12:40:17 +0100
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
Message-ID: <Zfl5oT1amymvxjjL@debian>
References: <20240227110550.3702236-1-mic@digikod.net>
 <Zd4OlL1G3t1D3TgC@google.com>
 <20240307.oxQuab5tho0u@digikod.net>
 <ZfgOf2dHBVT4WUcp@debian>
 <20240319.eeb8tajeiPee@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lVXM4NhaC2HReP5T"
Content-Disposition: inline
In-Reply-To: <20240319.eeb8tajeiPee@digikod.net>


--lVXM4NhaC2HReP5T
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Mar 2024 12:40:17 +0100
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

Hi Micka=C3=ABl!

On Tue, Mar 19, 2024 at 11:46:34AM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Mon, Mar 18, 2024 at 10:50:42AM +0100, Alejandro Colomar wrote:
> > Hi Micka=C3=ABl, G=C3=BCnther,
> >=20
> > Sorry for the delay!
> >=20
> > On Thu, Mar 07, 2024 at 11:21:57AM +0100, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > CCing Alejandro
> > >=20
> > > On Tue, Feb 27, 2024 at 05:32:20PM +0100, G=C3=BCnther Noack wrote:
> > > > On Tue, Feb 27, 2024 at 12:05:49PM +0100, Micka=C3=ABl Sala=C3=BCn =
wrote:
> > > > > Extend the kernel support section with one subsection for build t=
ime
> > > > > configuration and another for boot time configuration.
> > > > >=20
> > > > > Extend the boot time subsection with a concrete example.
> > > > >=20
> > > > > Update the journalctl command to include the boot option.
> > > > >=20
> > > > > Cc: G=C3=BCnther Noack <gnoack@google.com>
> > > > > Cc: Kees Cook <keescook@chromium.org>
> > > > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > > > ---
> > > > >=20
> > > > > Changes since v1:
> > > > > * New patch, suggested by Kees Cook.
> > > > > ---
> > > > >  Documentation/userspace-api/landlock.rst | 57 ++++++++++++++++++=
+++---
> > > > >  1 file changed, 51 insertions(+), 6 deletions(-)
> >=20
> > [...]
> >=20
> > > > > +
> > > > > +  lsm=3Dlandlock,lockdown,yama,integrity,apparmor
> > > > > +
> > > > > +After a reboot, we can check that Landlock is up and running by =
looking at
> > > > > +kernel logs:
> > > > > +
> > > > > +.. code-block:: console
> > > > > +
> > > > > +    # dmesg | grep landlock || journalctl -kb -g landlock
> > > > > +    [    0.000000] Command line: [...] lsm=3Dlandlock,lockdown,y=
ama,integrity,apparmor
> > > > > +    [    0.000000] Kernel command line: [...] lsm=3Dlandlock,loc=
kdown,yama,integrity,apparmor
> > > > > +    [    0.000000] LSM: initializing lsm=3Dlockdown,capability,l=
andlock,yama,integrity,apparmor
> > > > > +    [    0.000000] landlock: Up and running.
> > > > > +
> > > > > +Note that according to the built time kernel configuration,
> > > >=20
> > > > s/built time/build time/
> > > >                  ^
> > >=20
> > > OK
> >=20
> > Here, this should actually be "build-time" since it works as an
> > adjective.
>=20
> Thanks Alex but this was already merged:
> https://git.kernel.org/torvalds/c/35e886e88c803920644c9d3abb45a9ecb7f1e761
>=20
> Because I picked G=C3=BCnther's below suggestion, it should be good right?

Yeah, it's a minor grammar mistake that is widespread elsewhere.  If you
want to patch it, go ahead, if you want to keep it until next time you
revise this text, it's not something that will significantly hurt the
understanding of the text.

See also: <https://www.grammar-monster.com/lessons/hyphens_in_compound_adje=
ctives.htm>

Have a lovely day!
Alex

>=20
> >=20
> > >=20
> > > >=20
> > > > It feels like the phrase "according to" could be slightly more spec=
ific here.
> > > >=20
> > > > To paraphrase Alejandro Colomar, "Note that" is usually redundant.
> > > > https://lore.kernel.org/all/0aafcdd6-4ac7-8501-c607-9a24a98597d7@gm=
ail.com/
> > > >=20
> > > > I'd suggest:
> > > >=20
> > > >   The kernel may be configured at build time to always load the ``l=
ockdown`` and
> > > >   ``capability`` LSMs.  In that case, these LSMs will appear at the=
 beginning of
> > > >   the ``LSM: initializing`` log line as well, even if they are not =
configured in
> > > >   the boot loader.
> >=20
> > LGTM
> >=20
> > >=20
> > > OK, I integrated your suggestion.  I guess `capability` is not really
> > > considered an LSM but it would be too confusing and out of scope for =
an
> > > user documentation to explain that.
> > >=20
> > > >=20
> > > > > +``lockdown,capability,`` may always stay at the beginning of the=
 ``LSM:
> > > > > +initializing lsm=3D`` list even if they are not configured with =
the bootloader,
> > > >=20
> > > > Nit: The man pages spell this in two words as "boot loader".
> > >=20
> > > OK, I'll use "boot loader" too.
> > >=20
> > > >=20
> > > >=20
> > > > > +which is OK.
> > > > > +
> > > > > +Network support
> > > > > +---------------
> > > > > +
> > > > >  To be able to explicitly allow TCP operations (e.g., adding a ne=
twork rule with
> > > > >  ``LANDLOCK_ACCESS_NET_BIND_TCP``), the kernel must support TCP
> > > > >  (``CONFIG_INET=3Dy``).  Otherwise, sys_landlock_add_rule() retur=
ns an
> > > > >=20
> > > > > base-commit: b4007fd27206c478a4b76e299bddf4a71787f520
> > > > > --=20
> > > > > 2.44.0
> > > > >=20
> > > >=20
> > > > Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
> > >=20
> > > Thanks!
> >=20
> > Reviewed-by: Alejandro Colomar <alx@kernel.org>
> >=20
> > Have a lovely day!
> > Alex
> >=20
> > --=20
> > <https://www.alejandro-colomar.es/>
> > Looking for a remote C programming job at the moment.
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--lVXM4NhaC2HReP5T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmX5eaEACgkQnowa+77/
2zLeYxAAnJTAbKLQYz/5DxQmedRvL+W3k/fnLGakyKe+gmMvXAFsrAPRdPJqx+B/
IrnjIXRGN9heqRpBuuq8BTxAFfnlapd5zatjGNMxD3f2VhlFjsH5WYj0fDj59+9d
w8unSYIMyd/pvhxiSl9NvIzu/O7zWPFmDJ+mY+tLVzHkaQmZ/SO2X6U2DRW2d6F2
25iJujYtmp6hQtANfVzJY7Qmufbp7GB4s83KuKd/IXqExlzLS7sG0H9mxHi0Ii3w
2OOGZ7lVTk8yCCqAxlr9gNwgbbeHZ55DKPwUobBllhQr4tvbrbE09QXm6WgLK+Hk
Tgsdw/MsviWRuWUztcSJjnqiEkAwSREB5EZXP/+QQqWCrbiTsdfJoVYvdz4uIUvg
78/eE6vIW/iSliJe9MnXv8nCH3vJ3QsENV6S3HgeXAx6dlvy2r3gMul5VklSfztR
4BWP3Usx42rOs33ielFDVPncJFYbFjIaNGvaraa6gWlott6YoYzaLetGK0pnUs78
gTD1ZECDe2UuQGcoiEEH47U7Hg9uLYnAEfahXpE60kf555p4exQWoXs1r2pMmEzm
ylWrd2TfmWV15CVCNpR1bK4AgAIiOel5FU+nYjAq9GoBeqThqjbwZlGhGWXY/Nlp
cnJAH59ziEI8YPqdKq3BRglpzWldmGwCLQXvR1hQuyc1Dq6I6Bc=
=5omu
-----END PGP SIGNATURE-----

--lVXM4NhaC2HReP5T--

