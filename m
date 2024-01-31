Return-Path: <linux-kernel+bounces-46971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA59E84472E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778AD1F269EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598B0210FD;
	Wed, 31 Jan 2024 18:31:59 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B4BDF66;
	Wed, 31 Jan 2024 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725918; cv=none; b=Zman26N/yx/5ABfVMG01TC9JxIMSM+qXFBrDy1stPTt2G6GyVm4UdWYTRA2HbVrdq/uNUzAYuWK2Vv9rcQ5o1/FnTMTDUbJSiLcBsdxNZ+7u1xyEvrmmOjyeYnDOX4hCvzYD8TjW0fIKpfKo31fSo3gl+wKixqQaE+h+ZZO1nfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725918; c=relaxed/simple;
	bh=ZesQiPldqmTFy2+Rn2/fNwCEfJQ4Hd+LHzOFKswTR8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igCc+0aUfXBdKnxu/9Kjx+L4DSd7URUMgM0wQB0NpoirGrGBfLGtl+L6q8njGSbGWBhrLi1FDvBKP11ialkpRaPX6bAHt/LSnMw5ytpdU3dAyw+dbb1E6qBAxIAjaJop+dLHp4R6y3kDHimYm/4XBvfEsHci934CBca9FWKN/dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3158B1C007F; Wed, 31 Jan 2024 19:31:49 +0100 (CET)
Date: Wed, 31 Jan 2024 19:31:48 +0100
From: Pavel Machek <pavel@denx.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Pavel Machek <pavel@denx.de>, LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.204-rt100
Message-ID: <ZbqSFNtYwX6tLS8z@duo.ucw.cz>
References: <ZYX0Y_lbe8hNUNnj@uudg.org>
 <ZblPl7XCGo648oeU@duo.ucw.cz>
 <ZbqG45ZeWgd01CGb@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0z02tRrIz48k5Uc6"
Content-Disposition: inline
In-Reply-To: <ZbqG45ZeWgd01CGb@uudg.org>


--0z02tRrIz48k5Uc6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > We (as in cip project), are trying to do -cip-rt releases
> > once a month. Are there any plans for 5.10-rt release any time soon?
> > That would help us ;-).
>=20
> I already pushed v5.10-rt-next (containing v5.10.209-rt101-rc1) to
> kernel.org and kernelci should pick that up for comprehensive testing
> within the next hour. As soon as the testing is done I will perform the
> release dance.
>=20
> My vacations started (abruptly) a few days before I planned and that lead
> to some delays. People volunteered to run the builds if anything critical
> popped up, but that was not the case.
>=20
> Sorry for the inconvenience, I do hope a release tomorrow or Friday does
> not disrupt your workflow too much.

No problem, thanks for the information, and looking forward to the
release.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0z02tRrIz48k5Uc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZbqSFAAKCRAw5/Bqldv6
8gBrAJ0Sls4mHTinUHvL4m3S3PbvApoUowCbB7GUN6Ms6IxtmkHZDoQmIjGXa3c=
=v+X1
-----END PGP SIGNATURE-----

--0z02tRrIz48k5Uc6--

