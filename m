Return-Path: <linux-kernel+bounces-45206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0436C842CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A7C2871BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E528B7B3FE;
	Tue, 30 Jan 2024 19:35:56 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B0383BA;
	Tue, 30 Jan 2024 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643356; cv=none; b=SqYkZkCx2g5LwoXzaa9iMBRo6EoW8cOI9WtIDxT09vuqKAtbGqNAS7gT1pxatnTU7T7+emq8mp6ttJ1cOIsFl4H4Co8YTPE5KQtrGijMAe87rElzDEskR8RJdkTszFFQL6Qe7H8kes3H6lwMBs98IJWCFKFNqeC3xFxYZDrGTAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643356; c=relaxed/simple;
	bh=AqtvsA+TojyvEdhqjAUAJv/36H4xYBLJGbhhgrw1/Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdavwlTFxEQOjkim9ncqjDMg5rHWsGhPjZcHpvRw5aZXwg4AQZOQ+aM8RSCegBgZYx1E6yAN+f8Fzj61AamZOwHUxF+5QPEPJMTY2n/z+hyrnbFKLFOTfKPO8jo5PmFQF0yDXKrIJxsGM7qcxT9IRz4KatKG4eMb77Fbay8wuq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4EF821C006B; Tue, 30 Jan 2024 20:35:52 +0100 (CET)
Date: Tue, 30 Jan 2024 20:35:51 +0100
From: Pavel Machek <pavel@denx.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.204-rt100
Message-ID: <ZblPl7XCGo648oeU@duo.ucw.cz>
References: <ZYX0Y_lbe8hNUNnj@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dQZEVK1Sbqb2AdcB"
Content-Disposition: inline
In-Reply-To: <ZYX0Y_lbe8hNUNnj@uudg.org>


--dQZEVK1Sbqb2AdcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

We (as in cip project), are trying to do -cip-rt releases
once a month. Are there any plans for 5.10-rt release any time soon?
That would help us ;-).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--dQZEVK1Sbqb2AdcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZblPlwAKCRAw5/Bqldv6
8vNUAKCiLApgpsqWVf3R1ShJfn+RutJ4iQCfTL76BjjVp/5InUQFgR01/clhxRM=
=0Mw+
-----END PGP SIGNATURE-----

--dQZEVK1Sbqb2AdcB--

