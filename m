Return-Path: <linux-kernel+bounces-103672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E6187C2D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5FE282971
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DBE74E0C;
	Thu, 14 Mar 2024 18:33:19 +0000 (UTC)
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410CD1A38FB;
	Thu, 14 Mar 2024 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.190.117.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441198; cv=none; b=JyfT5PDHtvrz209RLutCJLXpWevGuWj20by3RGhCKINIQbj+iHhKMNZTs/6K4pkZA9PHCC3ZR/rYlKpLIxjtl8aTYw0Og+BmBOzyUp9+Zu5VrSve9dQ1XoskHjCSTiS+w1x3XvVrtD5UThPvt5HEC33+0npaMd5F+bGV7N1+8eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441198; c=relaxed/simple;
	bh=G2QSNSLgALZNvK4haNKtoQw708Y7zVKOLHgKk+Y1/f0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcOVgvAxgq3ii3dsGr0ba027HgdTP+7syzFXCgY9AAARYU8yzsD3ndynwlknPvZSFDoa9xsiLcsCx3DTcK2ieA3Q/KWd38TT2kbxuvztHg9FGLj05zuRYFTtEklcBMZsPDVRYMphtyMe5wEXUWSFiMFZBTME+vo0B1e/AZgi2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; arc=none smtp.client-ip=80.190.117.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1rkpt2-0012GJ-0E;
	Thu, 14 Mar 2024 19:33:03 +0100
Date: Thu, 14 Mar 2024 19:32:15 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 b43-dev@lists.infradead.org
Subject: Re: [PATCH 2/3] net: b43: Convert sprintf/snprintf to sysfs_emit
Message-ID: <20240314193215.74aac927@barney>
In-Reply-To: <20240314094823.1324898-2-lizhijian@fujitsu.com>
References: <20240314094823.1324898-1-lizhijian@fujitsu.com>
	<20240314094823.1324898-2-lizhijian@fujitsu.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lQpcmYwR9PeRUh3dx42=9yH";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/lQpcmYwR9PeRUh3dx42=9yH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Mar 2024 17:48:22 +0800
Li Zhijian <lizhijian@fujitsu.com> wrote:

>  	case B43legacy_INTERFMODE_NONE:
> -		count =3D snprintf(buf, PAGE_SIZE, "0 (No Interference"
> -				 " Mitigation)\n");
> +		count =3D sysfs_emit(buf, "0 (No Interference" " Mitigation)\n");
>  		break;

>  	if (wldev->short_preamble)
> -		count =3D snprintf(buf, PAGE_SIZE, "1 (Short Preamble"
> -				 " enabled)\n");
> +		count =3D sysfs_emit(buf, "1 (Short Preamble" " enabled)\n");
>  	else
> -		count =3D snprintf(buf, PAGE_SIZE, "0 (Short Preamble"
> -				 " disabled)\n");
> +		count =3D sysfs_emit(buf, "0 (Short Preamble" " disabled)\n");
> =20

Please either leave the line break in place, or remove the string continuat=
ion.



--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/lQpcmYwR9PeRUh3dx42=9yH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmXzQq8ACgkQ9TK+HZCN
iw4/lg/+JasVyWxAy739KHA2FtfgNev/rh0gwiIISYBJd72k164TItI6CoOK/vFE
RaufsC77oYVzcIpuGitLAgyGnl0voXywJPnMSsce57eqqXnjeblJpXP2IWmpykGv
2VBmXKY8SwwtOwjvYfRxCCT48n0uRNCtflLrbIlD5nVYVLDGwcDpFAz1Eas27vfy
xHCf3FtCL5Hu0kC3y0Y0GZHTNRH/fOd8dVJ/6QBjRyB8i7f7FpTdRW8t9M8TJbW4
FcfiVnisM8WgC5T4dTzsZ776EaUHsxHM2XV78oywcfEr/Shj8OOQGoIqbAj7oyRI
4QgdMmQjJnTJkJVUpIxYxm+nUmGK8zz3HhNyX3dBTUi2wfidOSs2H2b8NI7VZLeB
1FD3sc7CR7OQFhfsoDr6oDHNDug1ryun67hXK1AY+Qtr35Mz+C7l1YfiyzSKc8og
bTJAyFsBttDjbMYsHqxY9PEKrmRC9ubZWAcfz6/6Ir9RC7SHh8WNrX8F7v3BIWxy
N5BUVjjppQw5SiFgYUny1fNM1gHvzy9IScUIiv21zMb1ei02GmU4qw/pAe0oIKCP
pQFV4BJhHtBgI7aL3vIXe2yYRO9fNdxt5h4TJ6ZWVD1QCFzKbC7MihxHCtLZakma
nzc+UwY/uniy5LtQmwQirsrBr+5Zc2WSrVvziK2sD0tzYFRp9w0=
=1+TG
-----END PGP SIGNATURE-----

--Sig_/lQpcmYwR9PeRUh3dx42=9yH--

