Return-Path: <linux-kernel+bounces-98031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54078773D9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5B81F216D2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811A14E1DD;
	Sat,  9 Mar 2024 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="QNi7XpRJ";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="i9lO1fTL";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="gFOY0eJg"
Received: from e2i652.smtp2go.com (e2i652.smtp2go.com [103.2.142.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1340C4AEE8
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710015920; cv=none; b=Sk18vufIDpdk2RMRPF8W63Y54HlgyVs4TuHQOTG8MIWwmGSoM8FV2LjoB/miMevh2Z4fc4l5CTxvbLFNODQBcbkSDlsR0n51uOZZ6plG91rQMxmBsM6RjL/bBaMB0lSJB873hEdSZM8WLZD9BpjrPxkYwzc3Fl+M4KDY/x7XD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710015920; c=relaxed/simple;
	bh=dl2VisRpJYnYlk9wJru0VHfQwZoHEewY2ivg3LESeOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ecvf9mqxb5hvBSALziOxvXDmndR4kCjPu5gMs2p1CwxhpGHwSFTOXWzm2qbud++4r5GUU7oIclI+hVYrWrXggxvO34oRQQoMzOIPhnBKcotbOJ5c+XjGysnXp4mytPZlEkJ178R8Q6K5FWEAkWv4QSfG0Om2pw3PaUpOpde4DL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=QNi7XpRJ reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=i9lO1fTL; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=gFOY0eJg; arc=none smtp.client-ip=103.2.142.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1710016812; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe; bh=mtqDjolUsWaeGKZ24iwFO2dVVvu6hdYgTIfsUsr0MCs=; b=QNi7XpRJ
	grkOXGJ0k0rQNxSYGTIbf6aqTJXGXN7vGWQocST9OGtOVAGCoaz4AhN6N9mmZ6qojF7PuwIGbvO2Z
	Y7MA7Z5YwqIrtM3EYlc4OijlTOo2mrxMwOKVJlMvSPt+K1+3kWMp6prbMfJJzbYaNKC6+Dpn4g7Fy
	kHpWSVAXBNBpeXqzuO0vE1r0WLi3EZCWsXBhhXUFGQ9LM/liuyHELAnKsGLpykwoyRVnogZKbXzxW
	RyEQaVea4G55LD3T/hpVbEY/IZ1otXJrIkeCFSevzqdZdAYsrsDG4wWiDReLTou1iJn0zLTUqNtQt
	OOgXRwEEjoo5dax+3VqPRDay3w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1710015912; h=from : subject :
 to : message-id : date;
 bh=mtqDjolUsWaeGKZ24iwFO2dVVvu6hdYgTIfsUsr0MCs=;
 b=i9lO1fTLyllrQftjMkhIE9IZHPRMwXEIsbEhiluyJyEpxNHfseOWJumv7/kQtrAXXk2jC
 8keOf8I2WTeUo6UmOGaaxpyuXjPSqDJqQf1q5G8qN1246cyMmbbUAipa/E52HkE/r/TUIih
 ot+RZkCUaSnAOlBp0PJ4Yc5wJr0oFi9w3kPEs7ICDn6/uGjoopyfKUr7dNOl+lQSOzaYVMA
 4OK1EL+T9rEWMEAG+vVuMCGLbkp2+0Ba8M25fzfbWafd3EZcc/n2VKLfCpj6vt+LBZ6p3kM
 ALSABqKczVtfX+Dmaa7B74uNUjygHTq4eAu4fHAsCkbiKQa5kduRYOAKIp8w==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1rj3FO-qt4IRI-BW; Sat, 09 Mar 2024 20:24:47 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1rj3FN-4Xd4Kv-2H; Sat, 09 Mar 2024 20:24:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1710015883; bh=dl2VisRpJYnYlk9wJru0VHfQwZoHEewY2ivg3LESeOI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gFOY0eJg5FUIQdh/aBrJrJCwJcsMD8QIkwANt46Po5BLaEUPsEusNWxcO/dCUbNT8
 u/8egPqkCYkuowOi9F+POkzHtXO5y1D0OwUOIbAnEq6iuQOih2CKB4PfOQdNT2SjJ+
 CbGghSUYssfAjqYG90k159U++gBZHN3pvY7PXwis=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id A42F93CF3F; Sat,  9 Mar 2024 21:24:42 +0100 (CET)
Date: Sat, 9 Mar 2024 21:24:42 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] kconfig: add some Kconfig env variables to make help
Message-ID: <ZezFirN5okYdhL1U@fjasle.eu>
References: <CAK7LNAQ8OyNMeGzVoTRg-sHDZ4YK0EKY_eEWNepekaibO_ZKwg@mail.gmail.com>
 <20240229021010.GM11972@google.com>
 <CAK7LNASujf8m4PpMyoCC1cTN_YGeG1HVaOR+3pZx5=3OJp=85A@mail.gmail.com>
 <20240229034739.GN11972@google.com>
 <CAK7LNAS-mOxY884pLEMwWaX+wgzXdc6+=vqN=wfHBekuKL5ryA@mail.gmail.com>
 <20240301043316.GO11972@google.com>
 <ZeG2PRYmdO0r44kS@buildd.core.avm.de>
 <20240301142844.GP11972@google.com>
 <ZeVtIwua9T5prwUl@buildd.core.avm.de>
 <CAK7LNAT7+GbXaF6MW18YvEeF4ZZLrn6sOutHPNxcoL_RD1Utyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nQS4gEj3tiVtUJKn"
Content-Disposition: inline
In-Reply-To: <CAK7LNAT7+GbXaF6MW18YvEeF4ZZLrn6sOutHPNxcoL_RD1Utyw@mail.gmail.com>
X-Smtpcorp-Track: 1rM3FN4bd4Kv2H.7UWJBS6DdGaZ8
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286sP8TmRGQtl
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>


--nQS4gEj3tiVtUJKn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 01:46:35AM +0900 Masahiro Yamada wrote:
> On Mon, Mar 4, 2024 at 3:41=E2=80=AFPM Nicolas Schier <n.schier@avm.de> w=
rote:
> >
> > On Fri, Mar 01, 2024 at 11:28:44PM +0900, Sergey Senozhatsky wrote:
> > > On (24/03/01 12:04), Nicolas Schier wrote:
> > > > Perhaps it might be a compromise to let 'make help' point to the
> > > > kbuild/kconfig documentation?
> > >
> > > Yes, I was thinking the same. A one-liner description per-env var
> > > and point to documentation if one-liner is not enough
> > >
> > >       KCONFIG_BARREL_ROLL     - kconfig does a barrel roll
> > >       KCONFIG_FOO_BAR         - kconfig does foo and then bar (see
> > >       documentation for details)
> >
> > No, I thought about leaving out any concrete examples but just adding a
> > sentence like:
> >
> >   kconfig and kbuild allow tuning and checks by settings various
> >   environment variables, cp. Documentation/kbuild/ for details.
> >
> > Then there is no need to re-document each variable in 'make help' but
> > those who are new are explicitly pointed to the maintained
> > documentation.
>=20
>=20
> That can be a compromised way, but it sounds silly...
>=20
> Is it helpful at least for people who know 'make help'
> but do not know Documentation/kbuild/?

Touch=C3=A9, that's probably right.

Kind regards,
Nicolas

--nQS4gEj3tiVtUJKn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmXsxX4ACgkQB1IKcBYm
EmnwBhAAht/u1aC8A5IC+/JVNytMj45JZ2OmKLjf1CWbxsZAx4eF0oFpxul4vOyJ
gqu5nPoC5A/oUSi/l6HQtwctj57NV1i+VNkQk+r7rEdBvb6hmo5pAfgpJNPmIVIx
gv/lL8XB0tJ26NcGv83kMIfH/3XOcedNrMO1969SQ4yz53Kdb4JwSURZfAQtVWIi
PT5ktVrpC48f+5WEfY4lAxELgkO57QoYTUNs1xeQhsecTpHkb4t6kRUNoKYIRR5I
zvMoV5rHk1gtiUmaZg0+0XS+K040VUdluQnXtDx1E1e1O5cXac27dpkLeUzElSXU
rJw7FL83bafFwWlXDGM47jmM6sL2F3ugE0vtRqKeMkxXFFOjF/lGhaIKKgD73QtM
AOxMyRLt+B48myvkYaToisDieXDw5EQCCmqcrgrEtRAJlcCJBW2S+GNbNMKc9R23
uTJP+iag6p1zubKjUldFyeXl1vtCpqia5Y9FrPatX+FzF/5x8Oo/GjkvYqhjxTYh
mu1W+Qx6y7A2xcbiiG+RiQN3nHC9pOD4kl+JzIUu3oIl8tmgpfyuNPvvk6Zp1uic
owlJammmvdFjd02be5dF04tOOT+LLoihGy52kedAsN1TRdkrIiTqBDWccTzLabeq
sJF3wdVozxezi2dcvQhyWNxVVuN5MM9SSSPZGF9rRFFx3GW4hGE=
=ELdL
-----END PGP SIGNATURE-----

--nQS4gEj3tiVtUJKn--

