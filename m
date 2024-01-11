Return-Path: <linux-kernel+bounces-23803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D47C82B1EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF7D284B26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435DD4CB5E;
	Thu, 11 Jan 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="fllCzGWU"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F194EB21;
	Thu, 11 Jan 2024 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NSBJqfADEShofd+/J8eRt+E/Mq28kUfGRhWex30pOlc=; b=fllCzGWUgkndS2CZQcQZ9/raE7
	81lwWToaH+XB+KrZOaGhOF8vckPqJNVwUg5G8ScfSM6XcT+TwvpO0i+wU5PQS7kYYMQsSTVRbiXSL
	/ueYqgsCzhoRr20eMxsYBq5IVUOHFzOZQm0gAaiXOxKCRxFObotabZoCQnVVTM06lBZ/s2k7h4oVf
	DDYAdBp0azR7G3711XvFz7JFtakhHdPQagLJ1/mLRXB/Mj/shv7n1td8y39SfVcX53+fucA+xA5Gb
	pgVyKD7mtP/vzeM1OoLXc2yKk7lsmsL+c0oSMog+2ea+aPxhtDqp0DfazHO5XRbmJKT5u71sDvCzM
	CUIqSx4w==;
Received: from [2001:9e8:9f5:a201:eadf:70ff:fe12:9041] (port=45062 helo=bergen.fjasle.eu)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1rNx7b-007oYX-3M;
	Thu, 11 Jan 2024 16:37:31 +0100
Date: Thu, 11 Jan 2024 16:37:28 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Mirsad Todorovac <mirsad.todorovac@alu.hr>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] Very long .deb package build times for bindeb-pkg
 build target
Message-ID: <ZaALOOhEdBP70lDH@bergen.fjasle.eu>
References: <c2adb439-0dea-4de1-996e-5a0caa5c729d@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RWLzT3EZlFqQQ5iv"
Content-Disposition: inline
In-Reply-To: <c2adb439-0dea-4de1-996e-5a0caa5c729d@alu.unizg.hr>
X-Operating-System: Debian GNU/Linux trixie/sid


--RWLzT3EZlFqQQ5iv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mirsad,

On Thu 11 Jan 2024 13:22:39 GMT, Mirsad Todorovac wrote:
> Hi,
>=20
> With this new release, it seems that Debian kernel build uses "xz" in sin=
gle-
> threaded mode:
>=20
> Tasks: 484 total,   2 running, 481 sleeping,   0 stopped,   1 zombie
> %Cpu(s):  2.5 us,  2.2 sy,  6.3 ni, 85.1 id,  2.3 wa,  0.0 hi,  1.7 si,  =
0.0 st
> MiB Mem :  64128.3 total,    524.3 free,   5832.0 used,  58540.9 buff/cac=
he
> MiB Swap:  32760.0 total,  32758.7 free,      1.2 used.  58296.3 avail Mem
>=20
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
> COMMAND
>=20
>  978084 marvin    30  10  112440  97792   2432 R 100.0   0.1  29:30.23 xz
>=20
>=20
> Before dpkg-deb was using up to 3200% of CPU time on a 16 core SMT CPU.
>=20
> Can it be something with dpkg-deb --thread-max=3D%n option?

I cannot find any --thread-max option in Linux tree.  Do you call=20
dpkg-deb manually or somehow induce a thread maximum?

> Waiting for half an hour just for the build of linux-image-...-dbg package
> seems like an overkill ...

With current v6.7 release tree I do not see the reported slow-downs=20
when building bindeb-pkg; I tested by cross-compiling for arm64 on=20
amd64 with CONFIG_MODULE_COMPRESS_XZ=3Dy and =3Dn).

Both take roughly 5mins on my 24-core i9 system.

Kind regards,
Nicolas

--RWLzT3EZlFqQQ5iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmWgCzgACgkQB1IKcBYm
EmnonRAArlsVyoSVQP/FrJUOR+piJFy8ktUoOUaP0yNJdTqFccHwBIqCHFn5YZki
EOGVpSfCVGR+9yzOyczCas7UPfODC0FTNOCphSNNQPFM/Jta9ixuTf3LSNpeoU+m
U8imxUfsFAd+8tPsGN2vnhu7zeO/HVNoUJlLDFyq8IN4xD3vk9SW56C6YGApINhf
8zokl6ThkiwAY7SkwXtGx9saZKj3mqL1yhEOqRAxhLJSnBExxTnrrkRyz13LTEDZ
8qj9a1PaNmzMZf3FLPrq+VCpgLLiuIaSyYXjHlYP8FhXn6B7WtEFZwVHlWXXtXup
PUrZ+Pin4Cl88qOkSawLa7fqkb5UWagut5d3ev8EJn20D3LXbND3wtCTMqjQSMdl
yFOgQVtr6Erg1QGM15vZJ/RXhlItJJDTy6rAaIm1ukOOp5G4BbPbW6GAuxirN0xP
PVs+BZ/rpLXA/jYBKD56SUpxMmrtPdFb7hSrb4fWMG9XlIhCiUZH1NBNnTT+KCSU
F29ed3zQaCN1d6h2a1csH60gx3CcWnnu94YQSZKOz03HEXLITnHZMOSYa6sLP6Sf
1D7tr3ylrZiWcKG/oEXpDYqF9/z1tz+AIC1F2LumEhL6anAdL3NLgQBMRNM+v56D
TcB5N1DrQFqlRSuiqOvVPzlVosVFFsHMbQKHp0j5oR0AyAKG7Bs=
=xQuv
-----END PGP SIGNATURE-----

--RWLzT3EZlFqQQ5iv--

