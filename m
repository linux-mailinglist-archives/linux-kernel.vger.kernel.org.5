Return-Path: <linux-kernel+bounces-112276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F88877C7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FCB1C20E3E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3757FBE9;
	Sat, 23 Mar 2024 09:21:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2464DF46
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711185685; cv=none; b=C5JtITLp4I1B/Il5rzS8I8viZFglBYsDbfC74cVcT9NAmr/Pu1KXzlAN3ungj2gmW3FiY6pAFnZYONFWgTu56olqAjGGmwb8o+/Ycoq3zWHltq1w0CQqIbYESkTD17SAmySGjRqMSupxcMTkGlgkvGwP44fnRhV5GtvSHJxa0jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711185685; c=relaxed/simple;
	bh=jT4GE+fmqg6kJtgR/0UAglNxb0nMzTEJ1TDJkNQ9ZgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uioCfjjHBGFaUTlVSySG1L5eiH0AYJiFvl10j8a+6Y6Ic9JoPBpxPr37QkDJ1fExcc/zpIzEKJKJrlZ7qOCResR2g8908sY7usBZK7ZhzPKZucR/+6Erx/imN/YfzkMOS4vszxfBJwrWp7cgerrvDsvms7+kAmH50hbqBLprsX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rnxZ0-0008Fh-8C; Sat, 23 Mar 2024 10:21:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rnxYz-0080hA-Fa; Sat, 23 Mar 2024 10:21:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rnxYz-009qi8-1G;
	Sat, 23 Mar 2024 10:21:17 +0100
Date: Sat, 23 Mar 2024 10:21:17 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Scherer <t.scherer@eckelmann.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PULL] siox changes for 6.9
Message-ID: <4kjqykrcyebkqdxu3d5twv6ydcadkdib367xsz72f7zafowos6@ucskw5xl4sws>
References: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
 <ad141dd22c7d95ad0bd347f257ce586e1afb22a4.1708328466.git.u.kleine-koenig@pengutronix.de>
 <ftvih5huvc72a76s7fe4zisrqtaax5tcgoukqoi2bkz47zcrq2@4fixszonixgl>
 <2024030732-ocean-handbook-161f@gregkh>
 <nuchb5aaywc5vr6cof4gqbavq4rkte3hvzgs6au3lbg6s6wlq4@bvbjevbum7kc>
 <o52ptgjxknpxhtyemb5xdjyobidejvzluicsoc5ceajy4pz4xy@6e3aecoiz7eh>
 <k7pd3oar3e3mogaokjl7mykqy3w3cifl4dgbukmnsynyqgk5ze@ch5mn5xln2j7>
 <mryuydqd7pqxwkvylp24fped57tsys4me4pazdg4ujwkwtthhp@26rnjgzjesrx>
 <2024032240-yield-tycoon-f5a4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ueo73qd6numsxhzp"
Content-Disposition: inline
In-Reply-To: <2024032240-yield-tycoon-f5a4@gregkh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ueo73qd6numsxhzp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Greg,

On Fri, Mar 22, 2024 at 08:31:15AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 22, 2024 at 08:22:16AM +0100, Uwe Kleine-K=F6nig wrote:
> > You probably saw me being impatient and sending the PR to Linus
> > directly. If not: These changes are already in the mainline now
> > (00453419575d6b4f5ce0f370da9421cf5253f103) and this is the thread you
> > can drop from your todo list. I removed the above tag from my repository
> > to (hopefully) prevent future confusion.
>=20
> No worries, I see this is all in Linus's tree.  Sorry for the delay, I
> was actually on vacation for once and didn't have the chance to do all
> of this

No need to be sorry. There are no hard feelings on my side. It's
important for indiviuals and also for the project that key persons are
not available at times.

> (and to be fair, you asked for the pull request way too late...)

I sent the pull request the day following you requesting it. If the
timing is so tight, a note about that would be helpful. (No offence
intended!)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ueo73qd6numsxhzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmX+nwwACgkQj4D7WH0S
/k46dggAi9ZA5OKfQ0/ia5qc9D7rTXdXZBcis3pQAK1pC4b5FHcEIiSGcdKZjLal
Siupuh2aW9KtAJFe572M22wFkCZBQilQ4eqsj8iNlVD3HbXMvdKvwokzZW+i3LME
NfAd4YOD5q1GTaZ2CkE5KRnjjQESSHhINpAuflQG3vC+B9TgOsdpIhd0oVZR0BW1
O7pIN4CdcuxlJQehWx6Zb7ofI9DfHA65m3RBW55ghO08nHapV/T2BC+JgN4Yh/zx
bkdvpo0t2kj1xTHnEt0uqLyJW2L3gIRtBzvSLJk2COQYPMGufFfjj0LT58poLZz4
rQgIe0bY3utTDYFz1DheR5gd8/L4EQ==
=nJn3
-----END PGP SIGNATURE-----

--ueo73qd6numsxhzp--

