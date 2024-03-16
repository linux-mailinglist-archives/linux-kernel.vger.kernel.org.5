Return-Path: <linux-kernel+bounces-105279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7F087DB50
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 20:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071C828176F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 19:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED811BDD0;
	Sat, 16 Mar 2024 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXy1ljqs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49F91843;
	Sat, 16 Mar 2024 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710617619; cv=none; b=gi1Hu8uWx/aaTbKPxH9cTA8A8kPxAzdAklzo+LnMaAZuTW9e3mwetbs5a2rotHxo/JHZfz7m+6TWwP9SMVOJXzQ7QwwW+ouhpebRaJtTG/8veEb+bCo9zOOHuTHWgmj8HpB5h/J0+hs2YcG8T2tAracSf9VNhKLiwGWSCV0Qz0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710617619; c=relaxed/simple;
	bh=+a6ZtiXkLjE2iSQzJIUrXlMm0H0+j0NMZDv9NxvUOIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrYrIuZfBh3Iz00QIQZl+QC1V7Pl5xN1OReaFGXAx8/oMk23kbdqHuT6RlPFDGdIGhL2owtZsSKe35hCc2secfaR+KsRSXT54oQfs+b4Q5vHj6dnoB2UT2ZXuW4rj6Ug7t/pFDpQ9Ii21XY2fpzeDuVcXPzTvF1V1v+7IKEs0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXy1ljqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E47DC433C7;
	Sat, 16 Mar 2024 19:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710617619;
	bh=+a6ZtiXkLjE2iSQzJIUrXlMm0H0+j0NMZDv9NxvUOIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXy1ljqs56Ki+WHS2FrQdgSbVY/uvOlP0g88yFlYx4vW/iB/U2vf6ravxAvhTrsum
	 j1r9nEEL6Ku9hYcPJ+9lau7jo7o9tUBlsYF+fto37itA59+PZQ7gic4Mmg3OVg1pKo
	 /mQvqHZ4PNz+D0M/LirRdcM1a5QusmBUv2epOXi5NG1jPSxpC77KX2BtCXYz1VMn/o
	 CDWKehnjNUvPReTtWCl8yHpjYsRxVZl15QAfqug7JagdFwJ6bB7Lu4BFpqJaCwq7RP
	 x5zx7U5+WAFF1i7050grIl155fTo7BJXc//rsz7dyqgtg4D1g/n6FkA8BCoXtZuwB2
	 xugDvt+0xaApA==
Date: Sat, 16 Mar 2024 20:33:36 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
Message-ID: <ZfX0EBsVl4a5FQ_L@debian>
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
	protocol="application/pgp-signature"; boundary="Z0iRHz2zH4EOqck3"
Content-Disposition: inline
In-Reply-To: <CAK1VsR2zaCT3Bs1cwCEfLhAPXjwNk1byzNq5y32C736=hxqjoA@mail.gmail.com>


--Z0iRHz2zH4EOqck3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 Mar 2024 20:33:36 +0100
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

I'm sorry, but I haven't been able to reproduce the behavior.  The test
programs have several problems which I reported in previous mails.
Maybe there's something that makes it unstable and in your system
behaves differently?  Please clean up those examples, and try to run
them in a different system, and maybe then I can reproduce it.

Have a lovely day!
Alex


$ uname -a
Linux debian 6.8.0-rc7-alx-dirty #3 SMP PREEMPT_DYNAMIC Mon Mar  4 15:24:33=
 CET 2024 x86_64 GNU/Linux

--=20
<https://www.alejandro-colomar.es/>

--Z0iRHz2zH4EOqck3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmX19BAACgkQnowa+77/
2zJsYxAAirFbK0lul+k7Z17yej4u7Wuwk9hdugxBaxS9iesoRQndvaFZxo+HIBZZ
Ix1hX3zG74ugffHQoQJLCq8kNaiMD8BtWIjmDFDyOT2vZWb/odUzkK6QnYeKZPUq
JvGrvJQ6D6hVwFAWbHjwXY5FYYRpk2p8yOoguyHm/0RWAP3Gb6Qru9bM5xFvwtX7
F9joYKptFR1/lIlLqTMo53GjQpvmsbLHZIV6nzyHGjfUTdggzrhvYeA4xAGtz0/q
1gmklRadCPUQSspPIw+o/1z34GjDRyDZ8veidtEMdN3GSKYe0zx8i6VVP2HTaHjC
y3VMbWKxY2fN6T59X51uQG4rupLRrD2HKgyrxgOY9aV0mZwJGj2nEkWyCbZLNIz2
J7KToiutW/rfa8qY7k+0j/wOlKzHTnbAwowJbR5LPeKSpfcqXbwbNNkgRllV7rCe
LWuNS1aWbJe9b5hXGGV4F0as4agDdVkLntTMomHiUCPbgntgOhbsCmaJhkXeM4UY
f7TQLQTuqmbeaDMdNkbDzQEVcBl/1VG6qNBIRkQ9sC8C6YjkwkMNQhvgCss+IM4+
k1BCGNrtnwumNPS/zewo5n13XrwE2ODG+jQ1+aw4njO+6S8mb6vUUtQEmf50+p1W
kPZFxTRf73MDQc3ZGmrFtSN0U6rKSwBIu9JpCtO9F0Trbmcsong=
=U/eC
-----END PGP SIGNATURE-----

--Z0iRHz2zH4EOqck3--

