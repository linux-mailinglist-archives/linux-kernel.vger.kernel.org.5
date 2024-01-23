Return-Path: <linux-kernel+bounces-35684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2064839519
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5354B1F2DFB8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF5681218;
	Tue, 23 Jan 2024 16:39:48 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD94811E2;
	Tue, 23 Jan 2024 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027988; cv=none; b=PVhgVlVg1fePLiJNowEkoODvVQASAQZ/WgHv1mkMoUPPMmUYIKWeCu5jSyZVOKL7AJBolP7/6aYQQENzvdgsjF/VgXxXKxnoxK6+wYweAp3p//gGtJvTrSTG/FuB25L55QXcUvsIqer3Q2eXHFIFzbEAI82XmgCntAalVlY89MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027988; c=relaxed/simple;
	bh=dMMaPYa1wAbibTnMNj895HLSrAnGL9Jfiu4kbBdK5Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwhzDIxlt6wVQNpWa/oJKtNsScfywYhVJVuLU/hCB1alDt11zYE4Gve+AHWL1U/lq3vMrTCLdOUrbpz/Da1dVdwn2eGS+3aor0hGzXevrhDDCLe+DDXHDjuzbHQDHoXvVpiu5R9JZuHwYFKEMuOWpoNLXktX9S9GB95T68+jPoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Received: from localhost ([147.142.156.120]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MhDAi-1qwqbP43yU-00eOnC; Tue, 23 Jan 2024 17:39:26 +0100
Date: Tue, 23 Jan 2024 17:39:24 +0100
From: Christian Heusel <christian@heusel.eu>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Michal Wilczynski <michal.wilczynski@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	christian@heusel.eu
Subject: Re: Re: [RFT][PATCH v1] ACPI: OSL: Use a threaded interrupt handler
 for SCI
Message-ID: <kvoclxvyhmdmrfpfgwfjr33bdltej3upw5qcnazc4xakwdgg2b@krewjw2uk42k>
References: <5745568.DvuYhMxLoT@kreacher>
 <20231129085600.GQ1074920@black.fi.intel.com>
 <CAJZ5v0iRqUXeuKmC_+dAJtDBLWQ3x15n4gRH48y7MEaLoXF+UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5lwyhnohrcrn6rfz"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iRqUXeuKmC_+dAJtDBLWQ3x15n4gRH48y7MEaLoXF+UA@mail.gmail.com>
X-Provags-ID: V03:K1:y0uqNSq2EKI+HrwCFqUbaCCD6hKsC61KTwWnqjVmx9yzRwAHEmf
 UpTS7H2C3pPVBpexWC9VdgXUp8CCspde07aXQH9LaDK6RKFbJmWYkMusQem4+vGoNEFJq00
 gUXZB0CVzbpOoVJIGOALufWKw4iKMYCPULCscWuXp2/H6a6Xm0IPBJAIfV4YdRcqnJVe3vU
 4//z2/vWzaUYeFnqgZUVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pRyLIeEbGCQ=;lwmtfEfXeHaoZNmmuE6qHlYQ3VV
 K17uQhc8jzGwbx5x/rUIKy4lkopvqKoqVMtYF8Ozz3JqiCf0l7avt+g6BoKjq0k5SxSScS0qu
 xU9uB8gDlVW39BLGMsiqiJZblbRh6bRdAx5xKEqzXmAVO0sIbGAD0qgLX/8pSh6gku4ErtdCO
 nn8T4Gu3LaSUNELgOfzhmmA9pY+f8BMPw5IkWqtyeyG6Mx88p+/PP7jbss6n1Mee3geATdWnP
 15auRSs4nqptnMYJY7XqbyKdNxcN/C+/WMMEqsKNRlLxEzC8+9VkfPXkYUbDOQDhRbqKeDjgr
 spdnHyCarMtcYeFwRzLMNMv9M9iFf6v8+Uxv1V47CKtd1ZlY8SlRXbSSstUIA4DVYJNVmuyNU
 CfkGvIV+FB/bp9A9Fb8hPXKrDhies3HJ8eVMkJBRVgpQxH6muUXItawLPtAuXPpMchl1v1ocA
 PGGhsMSvzfDHh/V7mrBDSjdQMTgWAj13dgsCTKcLEffiO5HayBvUPrzA4SPzA+wdUAkP9adWF
 7x02y8XOQMQESCSevx6il5y+Fq5rLAsGohq5Hov10uBrCcUuZP6SNy39bSkpRCY6ix4YxeCkY
 JUs0zEZAMyFt430fc7pCSpOhVPM4Ti8gn6Vn3IM+6RV4tfTBE7kDnCeRLXKpIU02hg2lFAT3D
 8Joe9TSpYn7PiUeQWKckudd+iqIbCHvM4GsqYR8Y4QtvX5XKYft4ChzhxJI2JQ/k6EBPTTtzv
 pqlf7YdBkyUZ1NZq2LKTNcuft1lAIkzZsa8rx7ktFMCklDVtX+nBxv+sQ1eEl4MRGCWCfXr9b
 FbNVIEtDIeY7Rp/MKrawnGm8dQDzUBGJZbcy0QpaC/4PS0kSig7/5q5Ikw0iPXviOfQLEtE6R
 7wmxYYPNRC3Ce3A==


--5lwyhnohrcrn6rfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23/11/30 02:28PM, Rafael J. Wysocki wrote:
> Hi Mika, Hi Mario,
> Thanks for your replies and tags!
>=20
> Given the lack of response from anyone else I'm going to move this
> towards linux-next with 6.8 as the target.
>=20
> Thank you!

I got a stack trace in dmesg with linux6.8-rc1 that seems to be caused
by this commit according to my bisection, see the bugzilla report for
details / further discussion:

https://bugzilla.kernel.org/show_bug.cgi?id=3D218407

Cheers,
Christian

--5lwyhnohrcrn6rfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmWv67sACgkQwEfU8yi1
JYVFng/+PPIkhzl/+23A5fiBJAcuyo90aLSackIrL7BEVrrpBSiz3My95FlnNn3x
1avaI09apGVvPRoS9FSTpeXj6IfBE55W7t190nUcZNpA9lCwKjBr9tKIYYeJjSuy
n1LFJWPqEfGmuvdrFJMs2Vq27Oclomo68JXA2UIubidNNXWWtbfM0r8bRNRUsIjM
BFAznleLBX2tkVQVikDISnX+MP29hTzYIZTpj6+PkpVaI0DB+NlGIfp6xIADDzfs
zEgsA0acJQAed0CluMJjKiCvn5hHPITTWb/YbPexwtPp3dl32P5tQJspK9UhjHHL
qorodrQV24RbCwYtTi/jnM7cWnPzwVBsJt+gFf7Uqwc2RNhL4okWOZq8jN8NDI6p
L7ST0BJIGu8ZxlvZIwHjteDO+395eWB3Nrk73febOS1E+1gLJwaSameucwLPPodn
QKuCZnSJFKOe2cOlVr4zkMvo6FwhXJoQQT9P9KTAYTGUJpLzldaXPPlIefRDJVwv
aYwuSBRl9HY6SbTRBDGcv8KUkfDvnNN1zqIkujZjY/JJZHon+3xU+FWQcA1vdOZ1
bLiLhDO0Lpk5fADb3mMazILulCWvOD3P1Q/hCOPwo6ZTND3nr6znIMOo1kdf4nad
MNYST2i2HSKF7WKjVSxYuL0MMfAPKXIMNM5cSuKKQLByZtI6XRQ=
=K2Kf
-----END PGP SIGNATURE-----

--5lwyhnohrcrn6rfz--

