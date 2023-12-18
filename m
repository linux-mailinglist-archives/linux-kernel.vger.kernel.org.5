Return-Path: <linux-kernel+bounces-4080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70868177B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B200C28684F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39752498BD;
	Mon, 18 Dec 2023 16:40:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756731E4AF;
	Mon, 18 Dec 2023 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1rFGIr-000A6d-38;
	Mon, 18 Dec 2023 17:17:13 +0100
Date: Mon, 18 Dec 2023 17:16:29 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <zajec5@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Larry Finger <Larry.Finger@lwfinger.net>, Arend van
 Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>, Hante
 Meuleman <hante.meuleman@broadcom.com>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, b43-dev@lists.infradead.org,
 brcm80211-dev-list.pdl@broadcom.com, SHA-cyfmac-dev-list@infineon.com,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcma,ssb: simplify dependency handling for bcma and ssb
 drivers
Message-ID: <20231218171629.5cf95fd3@barney>
In-Reply-To: <CAKXUXMxh3rM8da9kJG_=Sy8fQqqf7f8xXaHDHPLvpvRiYg1e5w@mail.gmail.com>
References: <20231218115802.15859-1-lukas.bulwahn@gmail.com>
 <26207725d5025318b831dd5a5feca67248aaa221.camel@sipsolutions.net>
 <87o7ensgjv.fsf@kernel.org>
 <CAKXUXMxh3rM8da9kJG_=Sy8fQqqf7f8xXaHDHPLvpvRiYg1e5w@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Q7GEDofx/o0YmJSgzfmcjUH";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/Q7GEDofx/o0YmJSgzfmcjUH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Lukas,

thanks for your patch.

On Mon, 18 Dec 2023 16:03:54 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> While reading through the code, I was
> confused on what the dependencies were trying to tell me, as the
> config symbols and conditions seemed to repeat over and over in
> different places.

The {SSB,BCMA}_POSSIBLE constants are defining the conditions under
which it is possible to 'select' SSB/BCMA.
SSB and BCMA are usually 'select'ed rather than depended on, for better
user experience while configuring.

> I thought it was worth a clean up and this was the patch I came up
> with in the end.

IMO this does not clean up or simplify the code.
It rather makes it more complicated to maintain.

The idea behind the POSSIBLE constants it to _not_ spread the
conditions all across the drivers. That has significant advantages, if
the condition changes.

I also don't see the redundancy in the resulting dependency conditions
as a bad thing. It's better if every option explicitly defines its
dependencies rather than expecting something else to depend on it.
That's fragile.

NAK from me.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/Q7GEDofx/o0YmJSgzfmcjUH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmWAcF0ACgkQ9TK+HZCN
iw5l7BAAgpdZdzT7v2hPcLw7K9DpHS31i4y/GGlvC4rtJuMzznJNJQGs1MQDH5qM
xo1mioY+gzeH17iRop1VCJynuzBTwOkJNz0cKPq6Iia2dS1z+YNZWwaJp0jvF0aQ
0OQO+rzX+z2ydUmiE9jSbeS1CO9l1Pk9pvKBQhp/Axg/fq1Om+MOQSdngezPdH/7
pgJnhM7XYnEy5xyKEjB5yPzcR3LuCC5NPnq964J7/+Y4A5HfWGtQBKLO6F0+XWBF
xeUlNl7uvmXilz6MwSsQkiIoSmkQBJKQwpYXV1uXi4VXiz7man3cY+ZuayqlyuVL
JfgM0pbmldVPiiXTeL0ds+LuZm+1/xiXQtmoWNp4O1VxBR+XdPKoDxL2nkC4GB4W
Okq2+TA6n1WKPIrI4WAdhASvw+skaIx8HawIoM4jhGrc4tFaX93DA80gNOQuJ1Yt
PH752DI0wcM03qnYoPIrkcfYxrdX/h7sYEY8BCYJfetRjWwSsZT8y7CtVz47qszE
WhwU2E1sMSLM5rHV+W8t8RXmvzZEo2AUMNDQ2V1PFtn/FALO52cQ3HvwbOee1OjE
HZeMAJE3m2g5xxm2O/omOXSPwm8H7QE6DhPhA3JmrSSqjFv1vSVEx/3n/DuX8DmG
JkmrPATbaZbRYQFthprmECBBXcOgnAhCa4ZDDja1+/lL3q0ArCY=
=fqXM
-----END PGP SIGNATURE-----

--Sig_/Q7GEDofx/o0YmJSgzfmcjUH--

