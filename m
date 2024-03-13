Return-Path: <linux-kernel+bounces-102598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F5B87B466
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C541C21336
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545F75A0EB;
	Wed, 13 Mar 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+wL/h4W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CE84C602;
	Wed, 13 Mar 2024 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369307; cv=none; b=AM/g0natBh64sQexUlPCEJx7EhT1pQTzO+JFM1SMBhLhQ09Vm32mF9gXIcUb5/LpnNPpW2intf8k586hBGO+CZ+rDJY/xAKOoTTeMvn8q5f2jylcXs1a2KeW9R1HjdK7E60xTez06Xtf+iOxSM/uMB/ooeKAXmT206hBB60jtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369307; c=relaxed/simple;
	bh=zwcUoM/bxmu5V6pA+K99Z11qzxW5g/6XHdhxZM99p6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVzOzGipKa7hfx7QZOgJ2kK7qHl2mgUsbbO7e6Le6RikUsEbRaqAZfS838Bp492wm8gjELjOtpnvCjyhqMFISavI+LrGpU4+6ns8VVEadG6KF6/6JmMhU004QgqrD1eONALs5GBfn2xr/7tK2oTWv96ivdLDh2Lp24tppQnTz00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+wL/h4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5591EC433C7;
	Wed, 13 Mar 2024 22:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710369307;
	bh=zwcUoM/bxmu5V6pA+K99Z11qzxW5g/6XHdhxZM99p6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+wL/h4WGL5z8rc8BbZuwBG8fovddfSSTLwN5qQarza0kyDWfQg/eK2t9CtgWVmY0
	 qmJZtVsJhx/+EKWgRwgvSGhXOd7VfkIiYW2gohWPAFTUVCcdyVKp5AdLhG4k85pXDR
	 rxvbMwTAa66skpbgF4+K2pDN1h6mdFgJgw0rOWRStKeGNb7KKDmqG8c5cJX9rwi0O3
	 houy1R5BzpsZWVHnoWYE1cKT2h3NZVC8bv0/g8he1NAy4ZIWSzv6EEIXtlDTkQB8t+
	 DDN3XC/FIV3l14j90FIaYi/DmOw1cuhU0wNj/WnEYEMP1r9d0hMWqj+Uvlq3bAffSt
	 FvnKHjXjBZ6EA==
Date: Wed, 13 Mar 2024 23:35:03 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
Message-ID: <ZfIqGP1V69LfYpgV@debian>
References: <hxiq3upwxs3j5mc5arwlx4jriqm7fq5z54wroc4h4kqcq4gq7m@uwnoq2vnkhup>
 <ZeXzuWVmC9AnsECt@debian>
 <7ubz52rfdl2i76sotvd3s4thv6jvbfao6zct3sywqus2owlvkx@wpbeqqdvipo4>
 <ZehMWQ0LkemsTHAC@debian>
 <CAK1VsR0XZMgUW8qMQMcDPohD8-+OZsgW68sZegLbVy6cdoWucQ@mail.gmail.com>
 <ZehrtwSDQV-X7BXV@debian>
 <CAK1VsR3MsyphK+=rA7XcEigiSd6J_-QsVW+8hH1fU9xmRY3nGQ@mail.gmail.com>
 <CAK1VsR2zaCT3Bs1cwCEfLhAPXjwNk1byzNq5y32C736=hxqjoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lnpdUluPzO2RGSIw"
Content-Disposition: inline
In-Reply-To: <CAK1VsR2zaCT3Bs1cwCEfLhAPXjwNk1byzNq5y32C736=hxqjoA@mail.gmail.com>


--lnpdUluPzO2RGSIw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Mar 2024 23:35:03 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options

Hi Oliver,

On Wed, Mar 13, 2024 at 02:27:17PM -0400, Oliver Crumrine wrote:
> > Hi Alex,
> > I apologize for your repeated troubles with my test program.
> > I have attached a video of myself using it in the method that I
> > described to you. (I emailed you off-list as to avoid sending a 12
> > MB video to the whole list)
> >
> > If you are using it in the same way that works for me, I don't know
> > what the problem is. If I could've been clearer in my instructions, let
> > me know for the future.
> >
> > Thanks,
> > Oliver
>=20
> Hi Alex,
> Were you able to make any progress whatsoever with this test program?

Sorry, I needed some rest this week.  I've been only attending easy
threads.  I hope I can come back to it very soon.  :-)

Have a lovely night!
Alex

> Thanks,
> Oliver
>=20

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--lnpdUluPzO2RGSIw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXyKhcACgkQnowa+77/
2zLBBxAAnyugJdYJoniJjRZBKNzH44ibuFpiMBxecOHrYTqiYERS1Ljq5A80f6/R
snkjZkoy1cH8xNzhCB397qErSZg4ibwPBBr2XHUQFR1oMxeAqHAyabF3LsK3agfF
RyqGU7lHdh+WBSCGM6vfjd8lRtAlzE3fn1Zh4tdzORMcGVRZeWA1OGRBXt3Af5CQ
VXzWWO784Xfoxv/OjgMYfCaILP7bsxfL7u3Bjfoeswv+ujKYtQ4lpz0wP8pUlWIL
epT4bIAATo573BO8GJVFzFqEpwc1MjQ86Ju0XqJOrOjbtLh5sOxpMOguhkCOAaCU
S2i3920l02Tc2JF9uZk9BvPOI058FMYNjaqV1qZ4KZ4WjyfQLXvHxkHHIaA9cdse
7eOg7kbwxTHoy8wSMW2zNgh7asfmEGG//UScv/tW1l7EnvSG+HitFwYUVfnRx34e
194l15YnC47LmeG41gooif2vdRVbt23zhb0cBRrTKe1ry1sgPKkc6b6pXpziwlfs
DpwOMPxfEJpZ+0YRRfrB/QJmGgH0+gIeciEkFUuE3i2TSFRgBE4fKMsZlN56+9ib
/8St+3tBR9FXWcMutjeWhiU+bXef7f1NBT0m1DEOlDRMzyL9HyHJklyrTAW/up60
jiI8vDe5Pd6hUQ7HkEpocIFk/9hGf2TbxHNi7jT+5KeqMX0KRo8=
=WFux
-----END PGP SIGNATURE-----

--lnpdUluPzO2RGSIw--

