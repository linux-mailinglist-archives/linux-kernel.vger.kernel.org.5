Return-Path: <linux-kernel+bounces-104104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA3B87C8FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E33C3B21BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A534014AA7;
	Fri, 15 Mar 2024 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="Yp2GKtFU"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E449113AE2;
	Fri, 15 Mar 2024 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487007; cv=none; b=mJoImswYviWdn5PDneQwJEQBp+z7FXMPbc8hkT8Xwua8vqSYZhWxkl4JOXoqzCx+LHvRYuufJiPhxkNFD1xLYb8LEv0Y0K0YYB/NXfK9Qcaccl5E3X7XvMbXx7Pml4MK4XA7xDlHD+y4RKalrnQbxBcICTcJR0gbX3edmwMaoUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487007; c=relaxed/simple;
	bh=7sWoJBmiM1RTh/+whohKr626E2AEwZKJYgfI3B+qws4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4GnlZ+akaC5wt53dp8HdB/Z71z6wF+cRNClf1HwrvbNvf7kjp5iQ85AxxHjo84t+OTHcA+gsQoWFpNDUxFa6RrztRGkzdc5ZyeC6f/U5zwh4UliYbtTi9lI6azG7qxkyKF88ZD+W8esqQOKyZjBgXRV1zOgjwwRPj2xcmAMfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=Yp2GKtFU; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/HshpHEiyxloK86klFo4GEh2BmozhDHk+34Y4SmA++0=; b=Yp2GKtFUaBTCTnmkkKwzoqgsQY
	AZf/lbIS+hcFqLaOuFdtohOEcP9Ox1E64e5GkXLyfXolLkSEFpWyHtOnOiPPCCYNulvg/4czaTiNB
	i9t7XcrTy1GWC/Yjz/ds8NJs/BF8Zbo2QBPB+sbaYcOZ7gONcQ4o0kDsLJC5KlNcpQkb/aDrVc3vD
	p08YyVsZLWu+PnEKHI1BlPXC70f6smzmmD8y+54JUwV1sQSdsEBSXBk0Gvu4pCtB6LG03veqvJzVH
	7efFBeF41A52a+F+1+bfSV1duTAcwccPlj1vhjosSy2baImNWwSujXBdNBUNWMQD1kXuGcQuLWqnZ
	/fU0NvEg==;
Received: from [2001:9e8:9d7:fc01:6f0:21ff:fe91:394] (port=46020 helo=bergen.fjasle.eu)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1rl1nn-004Lkq-Sv;
	Fri, 15 Mar 2024 08:16:27 +0100
Date: Fri, 15 Mar 2024 08:16:21 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>, kernel@pengutronix.de,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib/build_OID_registry: Don't mention the full path
 of the script in output
Message-ID: <ZfP1xdcYlUawm3uV@bergen.fjasle.eu>
References: <20240313211957.884561-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0mj95xAbx5R1PIon"
Content-Disposition: inline
In-Reply-To: <20240313211957.884561-2-u.kleine-koenig@pengutronix.de>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no


--0mj95xAbx5R1PIon
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 13 Mar 2024 22:19:56 GMT, Uwe Kleine-K=F6nig wrote:
> Date: Wed, 13 Mar 2024 22:19:56 +0100
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>, kernel@pengutronix.de,
>  linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
> Subject: [PATCH v2] lib/build_OID_registry: Don't mention the full path of
>  the script in output
> Message-ID: <20240313211957.884561-2-u.kleine-koenig@pengutronix.de>
> X-Mailer: git-send-email 2.43.0
> X-Mailing-List: linux-kbuild@vger.kernel.org
>=20
> This change strips the full path of the script generating
> lib/oid_registry_data.c to just lib/build_OID_registry. The motivation
> for this change is Yocto emitting a build warning
>=20
> 	File /usr/src/debug/linux-lxatac/6.7-r0/lib/oid_registry_data.c in packa=
ge linux-lxatac-src contains reference to TMPDIR [buildpaths]
>=20
> So this change brings us one step closer to make the build result
> reproducible independent of the build path.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> Changes since (implicit) v1, archived at
> https://lore.kernel.org/lkml/20240311110121.459581-2-u.kleine-koenig@peng=
utronix.de:
>=20
>  - Handle abs_srctree not being exported any more
>=20
> The v1 patch made it into next but im combination with commit e2bad142bb3d
> ("kbuild: unexport abs_srctree and abs_objtree") resulted in a build warn=
ing
> about $ENV{"abs_srctree"} being uninitialized which required this respin.
>=20
> Best regards
> Uwe
>=20
>  lib/build_OID_registry | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/build_OID_registry b/lib/build_OID_registry
> index d7fc32ea8ac2..56d8bafeb848 100755
> --- a/lib/build_OID_registry
> +++ b/lib/build_OID_registry
> @@ -8,6 +8,7 @@
>  #
> =20
>  use strict;
> +use Cwd qw(abs_path);
> =20
>  my @names =3D ();
>  my @oids =3D ();
> @@ -17,6 +18,8 @@ if ($#ARGV !=3D 1) {
>      exit(2);
>  }
> =20
> +my $abs_srctree =3D abs_path($ENV{'srctree'});
> +
>  #
>  # Open the file to read from
>  #
> @@ -35,7 +38,7 @@ close IN_FILE || die;
>  #
>  open C_FILE, ">$ARGV[1]" or die;
>  print C_FILE "/*\n";
> -print C_FILE " * Automatically generated by ", $0, ".  Do not edit\n";
> +print C_FILE " * Automatically generated by ", $0 =3D~ s#^\Q$abs_srctree=
/\E##r, ".  Do not edit\n";

I'd rather remove the script name from the comment or hard-code the=20
file name, but this is correct as it is.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--0mj95xAbx5R1PIon
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmXz9b8ACgkQB1IKcBYm
Emk/AxAA2HczsXAYEJ0izKaGPxnW0T2YOi1oC5XuGrjmnzeLZuu/JJIpmQdPyP2T
iJ2YpbcbZfAhBGteDjzDFjoDLnED5YjfTDWD+pQWYkrWXy27AzvfykdvMRwECFRD
FdSn2RoKrQChljtSz5OLoIcxSesGU+/iPhdDR98VimlNyaS8uPvjkXcj4r6me84a
qvrdC4CyhA2fCe3lk2d1nGc/ZJudqYJRAhNuIFo84WDUVPIA62lxNK/K5J69/mdI
foci2JMqouPdgqnTXBmlri4uwaUJDQgiGFCkPpTw6T8+jxRoSnFu1t41mkTBg9Yd
rLzOKVJooD6F2ihrkWyGUL5+d7xr6cDChyUnwYBpiPmGPamL/cRK/pJQFwq7Bzy4
CB1pMBqDvp1EwM9DSC4665SawZhzbBNfu01mwYmTjiIhFzN+Qq/qiA9DsKj5NzBu
lQfPoOcVEJ6RC3Y8QfsupmFlFBO1mYQOtoSlHGgh9kYnRq9bHKAWB0e8iZta2nOz
eGH3gE9MgvRiV8cHWyr87R3pMHnbW6N8x9CIghwF5Exp27MyQN8mgNUZfH5VqFXU
a374p1FjFC17FktlXuSgJtDwIoQHDpEc37Tvz49TWNXjGt8lmA/GIthGDZBaQDGN
yWt2OpQpL0K7WbVFbPJ0mLOI8rWwpEkHxiC68WTrKOYiR2IAYDU=
=VqKJ
-----END PGP SIGNATURE-----

--0mj95xAbx5R1PIon--

