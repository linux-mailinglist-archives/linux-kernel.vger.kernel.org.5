Return-Path: <linux-kernel+bounces-120557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FAA88D94F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF751F2CA76
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5F936139;
	Wed, 27 Mar 2024 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="q0N+qofl"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AC33993;
	Wed, 27 Mar 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528868; cv=none; b=uqbjNOznxN4EXogJoehae3HufXIDO2XxsC0XxeEz4/kgHoIeQQgBxafeVpkLneItMhK3i0hm/SU6btZ6loO75pj4n1RerRjzo59MPxkSj6Hshfgd/G+0XCSmmvqwRqWidQjJwGLOs++IeCvXtSWajfY0Z9nwAzClv/fwRX9/ZJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528868; c=relaxed/simple;
	bh=xRB92wiK/60Dd4ywTzCohV4wgX5MoXZ7PetfJo/uNGs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N17vz9qD+Kc5NIyKpF94ktoYcFMSkfNOr49GkhkO0eC9SQpBHkFcymzu7oHP6ej+HWwcKi+jf0XI0pn5w8P2ghi5oAvmo15RToJvyHi/s9Y+EarT9UtnSyBPkvQ03JgdfCHS6lQc51L8XBDbNxYkukjR06XJoS1TykfQ4lx0c6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=q0N+qofl; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 8548F8803A;
	Wed, 27 Mar 2024 09:41:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711528863;
	bh=0aClRNtVlcXSh2p2olWCG/oCLHKpi0YBik2OFWy6TPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q0N+qoflRag9vW7VrC5CfShn5I3BQ6CVsSqV9yoOp+eXprYdlQ8MO/uMxZOr4qQEZ
	 bM798ijThTFq+AnORt2Wd1pJZAMOMximkegQO0L5EWhAMAHjNiG8a+b/u+YK2NoF7a
	 AUW4i+Uv6IF0P0+vBuo8DuJSQahlGHrJRsDmggRIqzn2QGr/MnR/9fba4jJqewckcX
	 WuWusHB94XHdmaqhoKuOreGIMv8YoYj3m5wzjMM6w4bdsJT5amWGis+05mJKWCqvio
	 VDrKbOo3i7Tsdlqf1eRPf1FuiZDDuDnv2IrEeoo8ecTyr+zB5ZorLWKyZYfW2tUNOc
	 s8Z+C2ClBCM4g==
Date: Wed, 27 Mar 2024 09:41:01 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Oleksij
 Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>,
 Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Murali Karicheri
 <m-karicheri2@ti.com>, Jiri Pirko <jiri@resnulli.us>, Dan Carpenter
 <dan.carpenter@linaro.org>, Ziyang Xuan <william.xuanziyang@huawei.com>,
 Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] net: hsr: Provide RedBox support
Message-ID: <20240327094101.4712d8ec@wsk>
In-Reply-To: <20240326101240.65c28519@hermes.local>
References: <20240326090220.3259927-1-lukma@denx.de>
	<20240326101240.65c28519@hermes.local>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B8iOh7uBlCiQ9Te8tY3Oba5";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/B8iOh7uBlCiQ9Te8tY3Oba5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

> On Tue, 26 Mar 2024 10:02:20 +0100
> Lukasz Majewski <lukma@denx.de> wrote:
>=20
> > Configuration - RedBox (EVB-KSZ9477):
> > ifconfig lan1 down;ifconfig lan2 down
> > ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision
> > 45 version 1 ip link add name hsr1 type hsr slave1 lan4 slave2 lan5
> > interlink lan3 supervision 45 version 1 ifconfig lan4 up;ifconfig
> > lan5 up ifconfig lan3 up
> > ifconfig hsr1 192.168.0.11 up =20
>=20
> Learn to use ip instead of ifconfig...
>=20
> ip link set lan4 up

Ok. Thanks for info.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/B8iOh7uBlCiQ9Te8tY3Oba5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYD250ACgkQAR8vZIA0
zr2xVwgAl3fFlMnCYArx7X4rafNLdbHv3H3iBt9QIthMIhAVVZk3c/gi2SLW7WqD
+s9um3AsLUkdqAYcsQFEGB7iF98t3p42HnypUibo+jTR0Oyp/1tF/B3NtgTGx3bi
D2BcIL9bV++SVnLC8OLAFNKcaXAMYd25RnhMQLZJbIGIRbSurikoPx5QZonJxKaM
EaF1gM5/a9FK7+X4korSjxSrWKWqOPr/Jh/5xSPCWgCvgUbHLohSP1/VIFwVRLgd
mJCt4YHntg9ivke8sjPREprJXCDQbE5lRm0vj/t6ydCXnnoFhv0JtSGpeVx/qWsn
posHiiNm7D5wqiw5SmsYoREP1ODA9w==
=AxW0
-----END PGP SIGNATURE-----

--Sig_/B8iOh7uBlCiQ9Te8tY3Oba5--

