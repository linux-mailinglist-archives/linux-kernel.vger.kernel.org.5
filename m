Return-Path: <linux-kernel+bounces-6286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E97E8196C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15A01C24B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A3414A8E;
	Wed, 20 Dec 2023 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="aFvbgqoI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3A214013
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703038874;
	bh=RjY9GuN03dUIP6ENwDTCxvhLazzEyteTs+UPhd1ubCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aFvbgqoIylW/UPj6md639iuRVrnTa33oCK08ZSON6380vrZMZY1cfwrOKMw/Uab4I
	 5BCKMv1+OLZE3k5oaIUKwNRE/hbNOU4vrFP6oWh/59poldc3enb074o5zB8AOvZASL
	 Kg1tmZmvrVUSa5Cg4kaTbQxVt/+/6JzDg80ENwZGVoUK9Dfl9Jw7TaKgxDRYv0U18Y
	 j/kebH19UCFpxhwOUB4j3RvKF86qQmCBIvzT5K/Nxb5mV2xFOr3WmhKK+43usnd388
	 XwggZZjHYqcru6RTQO0iKNZ3jK+imJ/H6rcOsMlmv36ymfrNSdg+ogUj3+UZl9QaaA
	 WZBs26MkHBqrw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 7795D13F06;
	Wed, 20 Dec 2023 03:21:14 +0100 (CET)
Date: Wed, 20 Dec 2023 03:21:14 +0100
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Li kunyu <kunyu@nfschina.com>, Zhao Lei <zhao_lei1@hoperun.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Zhang Zhengming <zhang.zhengming@h3c.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: relay: remove =?utf-8?Q?relay=5Ffile=5Fsplice?=
 =?utf-8?B?X3JlYWQg4oCS?= dead code, doesn't work
Message-ID: <3jyl25fuzazy24hccrnceu5h7phx2f4qjdpbrfaiuu7hgryzm5@tarta.nabijaczleweli.xyz>
References: <dtexwpw6zcdx7dkx3xj5gyjp5syxmyretdcbcdtvrnukd4vvuh@tarta.nabijaczleweli.xyz>
 <20231219163554.a65b8d9e918aeb28e21b5c21@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dvfnugagm2yhe5xj"
Content-Disposition: inline
In-Reply-To: <20231219163554.a65b8d9e918aeb28e21b5c21@linux-foundation.org>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--dvfnugagm2yhe5xj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 04:35:54PM -0800, Andrew Morton wrote:
> On Tue, 19 Dec 2023 23:24:14 +0100 Ahelenia Ziemia=C5=84ska <nabijaczlewe=
li@nabijaczleweli.xyz> wrote:
> > shows it just doesn't work, and splicing always instantly returns empty
> > (subsequent reads actually return the contents).
> >=20
> > No-one noticed it became dead code in 2016, who knows if it worked back
> > then. Clearly no-one cares; just delete it.
> All checks out for me.  How on earth did you notice this?
Trying to explicitly trigger every .splice_read callback to test patches for
  https://nabijaczleweli.xyz/content/blogn_t/011-linux-splice-exclusion.html

--dvfnugagm2yhe5xj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWCT5cACgkQvP0LAY0m
WPGVCw/9GsktG9TEWvvD/ThULmxl85Wgyxrzr4R0S2Uyy/UFMIPbLHj6HU2ULFZH
XxEWgDooJpgVMzkRfP9T/oNk1oCCN2h/KjtWa7gCogkbOytkYU+ut7cagJlHRGbB
5VG2Il3m4l0vnd2yuHeCDhVyLt59WkWY0plcL2FL6T/flW/WMYm1QZPjvCkGRTW0
vwYyMTYrvgZ9GjhpLBepkH2g98NDtsX323bH5H37Cxyx/L5WkvjUHuEV/DfFaZ6v
SqOAcmTZiBh7+M7pbvcsSmy4qn9ENTHtc/Q7luY2ThQwOa55sICnVdd579NMVnFN
2bu+LNVhPtU8y1dTq/+eEBKP4wsdOvWJysjSSMJsN6rZcCEOCp5fuiyg8LgsFUzH
SvXUB7SSHwCIQK0xCgMU0Gg/ZCZg7/E1SDcIMu6YxNSMQg1csepqXr6bS4PdGsIM
HIihAt1UjVwYB6+PwuDbFnvo6UwgxXDXXgq/J/uxBJiSOEYwTcTzHjRtUZvq/G8l
mRlczcp7epsgLOVF4zbvaufBpr8I6rTvtIEntt7O/1eEZSBTNs2niufnmBlJLziE
hB6jVh6xMjzJCe/6cvpeEsjUTs45HP3QFp5/pd66VxUiDHYTMxiWaVamr65zZXPa
c7RC6kegbY85hPwIlqrLmBbv21pkb49BenfQDFL636//ecLVIpM=
=nceo
-----END PGP SIGNATURE-----

--dvfnugagm2yhe5xj--

