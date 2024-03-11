Return-Path: <linux-kernel+bounces-99513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51183878976
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EBE51C2095C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9C75731B;
	Mon, 11 Mar 2024 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="SlvZYcvC"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42F56765;
	Mon, 11 Mar 2024 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710188772; cv=none; b=LXllkeWrt9JISvsvUzLMVRC2IJO0wD4G11aw+m2JWhDQUGy4n10I5OcAYbtMMGR+n6KKopyRGcvbZqF4Sa0O6V75oXQEVj8PlPlDhtnxppUkUS1Mx35Dr8AB1lqMAFf5MjjHZQnn8h6D+BlVZo/Ox46BvR3RmBP+EH/cbuTZcVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710188772; c=relaxed/simple;
	bh=QPiPfOFecIX8WW823ElbpwpIzdwIS3P4yFEaWv7mkWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuTMB1lfjzboZq39UCW/VNAjt9xAeipxTu5E26OoO3e36GLwFqnKYfGNElfW4TfccsdWUKdVqSLR8HJs/FC/Wa6dbc+CmKvFFCZqnUfV3U66baf5J3x1nhsO6C6vwdYiZa1fx5MyrOTkySYpu5YRR4Mw+ikIXTe8mDr/wu52U5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=SlvZYcvC; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1710188732; x=1710793532; i=j.neuschaefer@gmx.net;
	bh=QPiPfOFecIX8WW823ElbpwpIzdwIS3P4yFEaWv7mkWQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=SlvZYcvCkWrZ+mCkQDpi2VBxJ/6L1ZAGXws1NOatgnsxdgSresSqQDnRea1mpSfH
	 /B3VMAFjBIDD/dxDBRRA7fuOSaMBhgehXQlv87TSVOuhSpmqjahRWi74YKEfk/To6
	 8Jc84Rygo3PdNz46PHxTeEW5XQf9m6tW0ZjCaKCI47yAZ/i4h2OnTsdnthrH89ZMU
	 /MMqYRJEMsivVUFea0jt7x94CWGNwI7G3/hbO4kqw/rwtbgkeUe80dp0z2WeSXkwI
	 N2BkrCfw77XHpHW1jtnITJ14M//ohYQ6cVympecDUxaM6pVefGABkdSNgujkaeLoJ
	 3zSFQwNF1kyRVcrqLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.35.216.168]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiTt-1rFhIH1KH7-00U0Ec; Mon, 11
 Mar 2024 21:25:32 +0100
Date: Mon, 11 Mar 2024 21:25:30 +0100
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v10 2/4] ARM: dts: wpcm450: Remove clock-output-names
 from reference clock node
Message-ID: <Ze9ouqs8iS-zAuhs@probook>
References: <20240310192108.2747084-1-j.neuschaefer@gmx.net>
 <20240310192108.2747084-3-j.neuschaefer@gmx.net>
 <c7693ae1-b7e4-4960-b447-8373855d86b5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VmXkit7k7mmW0jx/"
Content-Disposition: inline
In-Reply-To: <c7693ae1-b7e4-4960-b447-8373855d86b5@linaro.org>
X-Provags-ID: V03:K1:DSV6Jxp9uHCDsY5cseqTnBTBiB0eztWVfRktYcb2oYcokvKRra4
 36xFfyFtmLnvtHLi/sbqt6v+EL0+kGVcr8gIMT4LDzL1YzQmcwibae2KSp14mMDRXhBPNRi
 KR2OmTO5waIBc8yh627MVue5HiV2SBfwq7lspqqfqiw60IhHHYlp/b+V5CTf6X9dVxvPd5R
 geY1m9M0ezesO6j/VJbeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oHssPTIrJ5Y=;KMxezZM62M1iUl8WK1u15cMTYGh
 rLJyAi6oqjFl38zgWdeud0amqwS4UmrjUiUj+xW+L2aiszNson6b516TzVrE7ky4IZIy0+91E
 Hbt7EjpGZpwVFR3G0AL7xh2imxXYRXcf52eVVK1WkXdBkRwRJralUustf6To2+vNmWxuSjIkA
 A4D/JuY5Ddg+NUmNvRYMQFvguVSSGshydMtrEYmohIZIaXacuzEGNlb1d0AxVypavtVNtJwKb
 V+xdwNEbo1KennbrXLmNBUhKwM845kEIZK73viAEdSDjtu0FGNHwO9khFKrJakUi/3OWltiCS
 5/J6s91Ycl6/0Wp6aWp+IJ5xeMybwAhYGI8LEqskFnGObFzqhKzpJE0hhlkNHNkufpCgtognP
 ziQR/Nd949Vnb5gzwnHN6BxUnHFJSIlX1dZS613dgsECEiNJF+n2UactGeF6LCOYW/mHpazEl
 CUbOwJ1d0ydDIkN9hXIjMKEmXHhEAvuYlOz3voUOV1MQQ6dBvKf3GiBDtVu3N52hlH4pVXUKd
 hvCEA23pD/ax/xV8vkiYsmR4TCkxkGPpQKZGcTU2SK9+13dbm9sqnK6TeQBjQU+PeItq7LSsE
 BNzpBdsXu4DuRppS/q5DBv+pDi220T40B06QuDmLQTLkwQ4ONTPeNwOwZL999ShsV/IHyPBti
 +NVLu74DBgoXuWGIciAse2Kn/qQOcncRwSGIhHRhRSN2t1wuXSHHzF7QEyesqL+XqnAdWxfV9
 +QbEFep3Tf8IX91ZEUWK15dOOyNdEG8rBjPsXdWm4NrMk4d7y20oVCQFSqRKxMcG1S/8ywXyg
 X2h3pyvwEN6BhXfESFUll55803BOKZT4LlmmCJGDKioG0=


--VmXkit7k7mmW0jx/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 07:50:22AM +0100, Krzysztof Kozlowski wrote:
> On 10/03/2024 20:21, Jonathan Neusch=C3=A4fer wrote:
> > This is not necessary anymore, because the clk-wpcm450 driver doesn't
> > rely on global clock names anymore.
> >=20
>=20
> Your commit msg should say: since which commit.

Good point, I'll do that in the next iteration

--VmXkit7k7mmW0jx/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmXvaE0ACgkQCDBEmo7z
X9uzbg/9E4zYqzQDzzKwxco6TXOke7njucuOXl8f2KDunoXsBn/3CLtkyc4/JhtR
RMwRHsCkAHMm9VSLdVtVR+ZDXZZ/y3dbKpGIauB7bIii0rHY3iv3Ut1DNKQtd71q
ZpwTki+a+gJavU+eQiAzspIgtv2IHfsdZa/6jy3t4IqryAlbFK7J9rfC+iyxD7HV
MVCyKQqGD5qDJQ4UWJOzcX4/72zqjDTRXw65xTf94mr12+Htx55hV/1SVnSgEELj
++zkxvMQAbbrO3QTm0gk0WUJfUL4tD72jfTeLxFuzsqDYklRcrOOHaM+KjJnU1E0
4xWNj44KaIUNM6olaYwdSdAk/byR7FByBV8ShE7bWAJHLBCO++L1UiyBqzm8UPNB
ZVbP+RNdYBdm1Dd6qPZ2uAMV3Qc1RjGBXeDQ+Ecqx/zn1FFrDe9JnCcxnTfM3P9w
EzclIhK0NtORnqY7B+SxW4SREOXt0tiGPNBZWQSVH5w6b9jlsXakRRdbRSs1d2ij
bjhkX0sexsT1VxSJI/uAj2nZ4jMkn4OpRMkz50AxV1fYNJcTkjbIwcIrF5uzK69O
IxsiMzl6YIXaVEVz0dY82ZycKOqtVHkiX7uVfk/HbfKlR0svz6sxHIfGRQkW4Kna
Go5/WdMeKJwngPm0en45IFyQTVV7OjnsYJkycNqucp0Qoo4hReM=
=Fu2N
-----END PGP SIGNATURE-----

--VmXkit7k7mmW0jx/--

