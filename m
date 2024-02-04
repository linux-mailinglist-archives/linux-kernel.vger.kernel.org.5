Return-Path: <linux-kernel+bounces-51905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DEE849096
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F0B1C20F1E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5366F28E3E;
	Sun,  4 Feb 2024 21:10:35 +0000 (UTC)
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A32562C;
	Sun,  4 Feb 2024 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.190.117.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707081034; cv=none; b=ObGouLrrYweYBv27Q/8zpaWjPyiMhyzfVRMuGhxfM5wTjnw7sWT9U9HJ9sXXE9VFHaZs4rugo4kRw2mQzX2WKgon235auMIBsJAS/BIgDuOAINH3uCe3IEIulXlgGltblSre4JYUQbQzSe/clh/06Fvmz8gO/eOEmyW/+G2aOyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707081034; c=relaxed/simple;
	bh=R359VuPtGYDwzodKzxeFeYgxtjqZxMYRp0uTv5n+eV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pA2NOXLGKbosY77u79NTjJKkSf8g9Aobyz1MsyUK3MmtMe3ngC5AZ/7KwzsaCxaJ+ePwT83RjaD8SeuATwnrIYWG0ggNcNPXaPD0Lr/seQyuUjEHxPYJKJi+QU5kZ7jlqg2rOGYk9Ri5Py+KNsR7ZVGbdZA8ns9xnFBBRpUH0t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; arc=none smtp.client-ip=80.190.117.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1rWjQ1-000LOK-22;
	Sun, 04 Feb 2024 21:48:48 +0100
Date: Sun, 4 Feb 2024 21:48:15 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ssb: make ssb_bustype const
Message-ID: <20240204214815.7f5db722@barney>
In-Reply-To: <20240204-bus_cleanup-ssb-v1-1-511026cd5f3c@marliere.net>
References: <20240204-bus_cleanup-ssb-v1-1-511026cd5f3c@marliere.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PyNQNBTJ/s=KDhaIex8KrE9";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/PyNQNBTJ/s=KDhaIex8KrE9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 04 Feb 2024 17:44:21 -0300
"Ricardo B. Marliere" <ricardo@marliere.net> wrote:

> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -384,7 +384,7 @@ static struct attribute *ssb_device_attrs[] =3D {
>  };
>  ATTRIBUTE_GROUPS(ssb_device);
> =20
> -static struct bus_type ssb_bustype =3D {
> +static const struct bus_type ssb_bustype =3D {
>  	.name		=3D "ssb",
>  	.match		=3D ssb_bus_match,
>  	.probe		=3D ssb_device_probe,

Acked-by: Michael B=C3=BCsch <m@bues.ch>


--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/PyNQNBTJ/s=KDhaIex8KrE9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmW/+A8ACgkQ9TK+HZCN
iw7Ntg//aq3vS8BvSlIJjEbcPp7yFiBegZ+/XRFP+IelKMFMoNOzMZPhkuylZUBo
0/kXQDIZOx5OmRGSOkMbGW5xfANRFWKoD7qmwDSv6nC/9psp7vhesaYqM2G3eDmL
P1g6fjnmRWRsnCxxAY7Ic+hU55K5qN84CLUTbD+P9/rFvzd6XUBTQRlmIuzMFSq+
wQfGPTdBjQfcCn45Ddwulfr0Tpn/CgHfAe9lg7KBVf+G7BzzcJ1KjqGg6eXLy/XJ
nNa5y8MpiGAKhSMNoMUICVsBR6pbzI3C+W14zPEHI+ESr0e1pO/ThGPcVIKrWG/t
MyofauMi0mnQUtKVVtC+1T6i0eAtN8dQFCfaosjlFLE0Zxz8JIptvwpE8Fv61RJp
FJ1khoJjf8wOx3geSrv6tHSMXlaZ+pWWKwAirKPe1nVh6CCC5Epc//yOa4j+Ktvg
m7tob+1/RB8bjLZ6xEVIItmcZk6zycqykfcSbTtI9pV2xq4xT2qpg5vVla8jaUx4
Wqu/sP7Iss9zr/X55+Z97RMsQdUXx+Tw7ffbCJQglt8Yu2qtJGa+Ar4pgrU0GiOL
hxo3J4BcX4EN4soL05FXVKXsFtPa7MtytTd4f2g7liLy3JyoQrpd38TzD6KYXy+c
WUIacZJJ9dM8cnGTmhRCZNf72YUznwPNdue+1MD2aHWs8Natvys=
=0btd
-----END PGP SIGNATURE-----

--Sig_/PyNQNBTJ/s=KDhaIex8KrE9--

