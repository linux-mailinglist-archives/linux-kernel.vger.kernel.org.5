Return-Path: <linux-kernel+bounces-96522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6963F875D77
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C742832D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6019032C89;
	Fri,  8 Mar 2024 05:11:03 +0000 (UTC)
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF32B2E84F;
	Fri,  8 Mar 2024 05:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.190.117.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874663; cv=none; b=U0C8g9gPimkQzDXnfEtHUf0LBLUxYlqRYba3Xqtns3oUYcP3ZIyi97j4Oroor8bXcmCMqJwCvXUmRfr5QETMjqsCz7nSU9dSFLefkTzrdJJuotpqFPqXWRYtAdX2mN3A0O8egoEbXaFl50+j9G0W38cRfKfOEB/4Bggw4ilLu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874663; c=relaxed/simple;
	bh=ZO7s82fTv+KQLU799znIeMMbxQbbZDdJMV0RZdahXos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXD8LBgcKDo6vU8j2aHzgmrc+fSY14WhRexaYFUZsudGsSgZDJMOvw9jiGK5r3GSWElIanebbf+mwQQz1AN8XzJRqkbGF395/4oJ9gSg2xX89oQJ1iczPsQR+nG59mBj3DYZjkzzTgVKr6qamHOR0lMYVR1PMCct82Vp9pCndWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; arc=none smtp.client-ip=80.190.117.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1riSVS-0006Q4-3B;
	Fri, 08 Mar 2024 06:10:54 +0100
Date: Fri, 8 Mar 2024 06:09:43 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: deeb.rand@confident.ru, jonas.gorski@gmail.com, khoroshilov@ispras.ru,
 kvalo@kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
 voskresenski.stanislav@confident.ru, james.dutton@gmail.com
Subject: Re: [PATCH v3] ssb: Fix potential NULL pointer dereference in
 ssb_device_uevent
Message-ID: <20240308060943.2410ef2e@barney>
In-Reply-To: <20240307232927.171197-1-rand.sec96@gmail.com>
References: <20240307223849.13d5b58b@barney>
 <20240307232927.171197-1-rand.sec96@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2sTVD8EKNY9IX0ipm+1Z=px";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/2sTVD8EKNY9IX0ipm+1Z=px
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  8 Mar 2024 02:29:27 +0300
Rand Deeb <rand.sec96@gmail.com> wrote:

> On Fri, Mar 8, 2024 at 12:39=E2=80=AFAM Michael B=C3=BCsch <m@bues.ch> wr=
ote:
>=20
> > The point is that leaving them in is defensive programming against futu=
re changes
> > or against possible misunderstandings of the situation. =20
>=20
> Dear Michael, I understand your point. It's essential to consider defensi=
ve
> programming principles to anticipate and mitigate potential issues in the=
=20
> future. However, it's also crucial to strike a balance and not overburden=
=20
> every function with excessive checks. It's about adopting a mindset of=20
> anticipating potential problems while also maintaining code clarity and=20
> efficiency.

Removing NULL checks is the opposite of maintainability and code clarity.
Efficiency doesn't matter here. (And besides that, NULL checks do not alway=
s mean less efficiency.)

> > A NULL pointer dereference is Undefined Behavior.
> > It can't get much worse in C. =20
>=20
> Again, If we adopt this approach, we'll find ourselves adding a null chec=
k=20
> to every function we write, assuming that such changes may occur in the=20
> future.

This would be a good thing.
Let the compiler remove redundant checks or let them stay there in the resu=
lting
program, if the compiler can't fiure it out.
Checks are a good thing.

> > Your suggestion was about REMOVING a null pointer check.
> > Not about adding one.
> > I NAK-ed the REMOVAL of a null pointer check. Not the addition. =20
>=20
> My suggestion was to remove a (REDUNDANT) null pointer check, and not a=20
> null pointer check, there is a big difference.

No. There is no difference.

> However, if the reviewer encounters this check, they=20
> might mistakenly assume that 'dev' could indeed be NULL before the functi=
on
> call.

So? Nothing would happen.

> Conversely, if they read that 'dev' cannot be NULL, it could lead to=20
> confusion, and perhaps they want the actual null check. Removing redundan=
t=20
> checks could mitigate confusion and minimize the risk of overlooking the=
=20
> actual null check for example.

I fundamentally disagree.
Removing a NULL check _adds_ confusion.
NULL is "the billion mistake" of computing.
Please don't ever make it worse.
Thanks.

I will not ack a patch that reduces code quality.
Removing NULL checks almost always reduces the quality of the code.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/2sTVD8EKNY9IX0ipm+1Z=px
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmXqnZcACgkQ9TK+HZCN
iw7QAhAAmJOlE885xiLSF3ro18tJnRGsEQ+UxjAH+j1uTQUCQ7sCxQBoZVGVZtmI
ctWTJZsS0ctkU36z7W/xtkACYHcnUHJcO0utSyOMYgJ/Ux+MLOsJaglKnwMN+XC9
uSzs0QcTkA1PV1wgjt9CgNo7+7e5Z1Z58qgo9GowrGOo5c8Np+o5b8USQMAWy13Y
/sqyNOeIXdq08hHaY6MvRLHZhx7s2glih5vFBHaTDACD1asvV+V/BWyPHvqLm/W/
A7o98mN9NKTFJ9slTDleN3ZzRoXZ2XC7WtO3okH8eUpq2AlDxKIaeYe8s3gnOmIO
GVpb5Y//GXVl8iL0JzXvMaBIoviTrasCvqdDs709b8o9hWCksahzTL/PWbJ1IaMZ
IQBedsjowOGIhdCzuHfkQTfDZCX+LKMZZrKpojDKcHZSUZDTV2JVOC16iDZDvWNx
Aq40b7rd7QyKBn6p5xi5FUsbzcMmnMmSpN4NY35mL16lCdfh7HKp1I40KDWtdfrm
GtBFs7jRVIVwyHgbN+GzVtnA94DN9kN/mlJdkKCGWv47l7VxCWbv+7TGgCMyTp3P
WblIgur43DDUTlFpz4jRJV9U1qK25NNs2qlhYN8B+zXJuZHtXZ6ItgOjXaqjlnJG
vH34j8RjS37LPegZiKYdMHdCxg98Bk0R8ZL61l0shOwrEh385R0=
=yujV
-----END PGP SIGNATURE-----

--Sig_/2sTVD8EKNY9IX0ipm+1Z=px--

