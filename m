Return-Path: <linux-kernel+bounces-151626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCEF8AB14C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CD32820B7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D08012F584;
	Fri, 19 Apr 2024 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="ZI8Yy/4I"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0627E11E;
	Fri, 19 Apr 2024 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539249; cv=none; b=AAAcK1fwb1RjGXUZ/1th2zhMrw+m5fG3R4P6d9MGXApjO0gFi0HGgY39aR+mbLl0EvS6yTPSYns0ewuY4sf75wXGxQTdH3JysdJOuQaunkB132pBr9BVLvPh14OO5B64NzMZf4DAA990VDZtM1dpbLmSsD+dJi9+AcxGv8mt5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539249; c=relaxed/simple;
	bh=Aeux13K27xxEOJgQucGQNnXKrqTxFRbQpmqHcMsSW/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2REPy8wqsUf3dKTDH3NNbB8l3Ibfw1Hd7HzIqZ6HKNEGo9YKovSz8IGx2fpTqBtjMUpo5LdzacJA6C2Ai3pn1srVyGK4dFRfPzMKJjZNbQPZxa0AKYuwSLH/ovWBBSqAX8gX9nQM+zPLGsomE+BSJ9QrKsPJuhwWhxQu97Bzxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=ZI8Yy/4I; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DOzN/8e8CTCRv8H3ZSByCxFzdeJC78AmKTVTZIe4QMo=; b=ZI8Yy/4ITJSE4+NRK16R6JIBeM
	VEbIGV2qv8ZXDoj2z63BwsZgNtml4Zfm1+JyNW4CBeiLY588RMVao3hEACRxbZ02FGwgIsn/v14x0
	cgfxMfa0Pk+91KsxtZzaIRmv+rLsmX7YX/ywNhXZwXa/R+eBQUHmOJii5SYbbreEXRSSr52rjqGDt
	LCJDlL+egfocQK9ExxkCAKh4vCEwrpHNgqiHKhBjheiYcTeh4Dglyaqhl2WOIl8DIk6dtfuWKo99c
	7EJDu33pgnI1EULZ1X7yA2ThT8AfPcqNv/T3dNUJXpP6cauEP/VSrRJ4Pv5OT6PMN3ZlWWoozg3C4
	gT13SUSg==;
Received: from [2001:9e8:9f5:cc01:6f0:21ff:fe91:394] (port=47534 helo=bergen.fjasle.eu)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1rxppa-0049vQ-Uh;
	Fri, 19 Apr 2024 17:07:15 +0200
Date: Fri, 19 Apr 2024 17:07:12 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Makefile: remove some unnecessary header include
 paths
Message-ID: <ZiKIoLKtG0suO-8i@bergen.fjasle.eu>
References: <20240416121838.95427-1-masahiroy@kernel.org>
 <20240416121838.95427-3-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fwy6oIwWUjQAVF0b"
Content-Disposition: inline
In-Reply-To: <20240416121838.95427-3-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no


--fwy6oIwWUjQAVF0b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 16 Apr 2024 21:18:36 GMT, Masahiro Yamada wrote:
> The include directive with the double-quote form, #include "...",
> first searches for the specified header in the directory containing
> the source file.
>=20
> If all local headers are included using the double-quote form instead
> of the angle bracket form, there is no need to add the local directory
> to the header search path.
>=20
> drivers/gpu/drm/imagination and drivers/net/ethernet/aquantia/atlantic
> use only the double-quote form for including the local headers, and
> there are no generated sources or headers in their directories. Hence,
> the local header search path is unneeded.
>=20
> The same applies to arch/loongarch/kvm/ because TRACE_INCLUDE_PATH is
> relative to include/trace/.
>=20
> I guess there exist more Makefiles with unnecessary header inclusion
> paths (and more cases where it is possible to delete the header search
> path by replacing #include <...> with #include "..."), but I do not have
> an easy way to detect it.
>=20
> These are unneeded inclusion paths that I happened to find.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  arch/loongarch/kvm/Makefile                     | 2 --
>  drivers/gpu/drm/imagination/Makefile            | 2 --
>  drivers/net/ethernet/aquantia/atlantic/Makefile | 2 --
>  3 files changed, 6 deletions(-)
>=20
> diff --git a/arch/loongarch/kvm/Makefile b/arch/loongarch/kvm/Makefile
> index 244467d7792a..7a0108a721c1 100644
> --- a/arch/loongarch/kvm/Makefile
> +++ b/arch/loongarch/kvm/Makefile
> @@ -3,8 +3,6 @@
>  # Makefile for LoongArch KVM support
>  #
> =20
> -ccflags-y +=3D -I $(srctree)/$(src)
> -
>  include $(srctree)/virt/kvm/Makefile.kvm
> =20
>  obj-$(CONFIG_KVM) +=3D kvm.o
> diff --git a/drivers/gpu/drm/imagination/Makefile b/drivers/gpu/drm/imagi=
nation/Makefile
> index ec6db8e9b403..3d9d4d40fb80 100644
> --- a/drivers/gpu/drm/imagination/Makefile
> +++ b/drivers/gpu/drm/imagination/Makefile
> @@ -1,8 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only OR MIT
>  # Copyright (c) 2023 Imagination Technologies Ltd.
> =20
> -subdir-ccflags-y :=3D -I$(srctree)/$(src)
> -
>  powervr-y :=3D \
>  	pvr_ccb.o \
>  	pvr_cccb.o \
> diff --git a/drivers/net/ethernet/aquantia/atlantic/Makefile b/drivers/ne=
t/ethernet/aquantia/atlantic/Makefile
> index 8ebcc68e807f..268a055086c4 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/Makefile
> +++ b/drivers/net/ethernet/aquantia/atlantic/Makefile
> @@ -8,8 +8,6 @@
> =20
>  obj-$(CONFIG_AQTION) +=3D atlantic.o
> =20
> -ccflags-y +=3D -I$(srctree)/$(src)
> -
>  atlantic-objs :=3D aq_main.o \
>  	aq_nic.o \
>  	aq_pci_func.o \

I'm afraid drivers/net/ethernet/aquantia/atlantic/macsec/macsec_api.c,=20
=2E../hw_atl2/hw_atl2.c and .../hw_atl2/hw_atl2_utills{,_fw}.[ch] need to=
=20
be adjusted first.

Except for the atlantic related patch diff:
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--fwy6oIwWUjQAVF0b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmYiiKAACgkQB1IKcBYm
EmnrQxAAunFD7ET2ixOJ1mZIQH/XqFzErlSihK9sOkn8LU1PLS4NPTNQbyytman0
I1pomoValbUTr01blxH4l6HH6sg61xj2vVnRCJxU44LU88tr4z5d0O37LO0oQpen
MM1HUyUxNz7UyrRa+9YMl4lp7YvbSVbAVVIpli48vlfkQ3Zjhrt0mlgv5JxwIhim
UyoaOIS7iLswsjNhqMicDr5NWg8k7WvRPsHHEaOXfu4rXLc1mNDNxorrK80mDMeb
YtrJ+a9B9cY5Gr48NCvjfcRh/w0DqBBi2WiRe97pcD5VY7qIAWhMQlRktFaf6pHC
4Gz9Q8pwVUsCk1dnGfqqBnei+8MZzrCmJ3bJSgcADPVUJ6HCNPfFK28swdy3idfP
yBd2y7BO32DrGQ9RJJ1A59LlyejjYSOONWLEDKdsnHQJYSpzK9czQ5Bxqb839fMI
YCAdZRcbyWt0OEHvcv5R4CeopdZdQ4uCRO8SsA/RiqAlCUkInxF3tRV6spPDbheF
7cO8Ubh7yc3fxLL+3tuVqDr9/rQeJuwUc4816riiWKqVivseJTXtpcDw+eatM+Pb
L5yZtxYyjHWtpaYI5dXTjiPu20pLZxxIbiox+0SvXYz2ctMr85/VqBGLzFsKHC36
bgUeI5o7nYCkU5fvKueBnrcK4pJ5lwcAdl8MOmImszrDkWOnbq0=
=Ct27
-----END PGP SIGNATURE-----

--fwy6oIwWUjQAVF0b--

