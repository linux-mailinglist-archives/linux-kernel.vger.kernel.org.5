Return-Path: <linux-kernel+bounces-22917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18FD82A56F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE3AB26AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632321383;
	Thu, 11 Jan 2024 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q4LWI3iG"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2091117;
	Thu, 11 Jan 2024 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704934423;
	bh=nzGmFc9AclGr4W295d/Kez2p8+ogh3ed9c1WG2+i9tM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q4LWI3iGRMWDXMIQMeLLXgP9M+SBaH15KD1uWjYOvvT2cva4rIl5H59fyLkYheF+3
	 B+zCg0hE0xaK6kzh2zEnrZUCVoGlhqpValcFLd8iiuJJEwgwhfgO9pblcdJwVGEY5t
	 BrtQNbDL8Sie3aVKG4U5bUEaTAD+R2YwLJBYM7pfswsGe/ZO42wmOwsoSORTg9zvA/
	 dISbDvouM7ADFSI/q999R45aXhsIEDOyHJ1FMnn4hvpaSw1rgggg2hrEfiNbER1sDC
	 UnwwVOWrAihJl5vDBOEwbBTIzfpBAHJ1f1H5pQrHbw/rswRqYBrQJu04LLC3euoa2f
	 aaQwNfs2vfTmw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T9R4Q63W3z4wd0;
	Thu, 11 Jan 2024 11:53:42 +1100 (AEDT)
Date: Thu, 11 Jan 2024 11:53:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: Armin Wolf <W_Armin@gmx.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drivers-x86 tree with the
 hwmon-staging tree
Message-ID: <20240111115341.662478d0@canb.auug.org.au>
In-Reply-To: <20231204132252.065ad867@canb.auug.org.au>
References: <20231204132252.065ad867@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/o1TMqZk4pVTC85Dio.ZGgcS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/o1TMqZk4pVTC85Dio.ZGgcS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 4 Dec 2023 13:22:52 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the drivers-x86 tree got a conflict in:
>=20
>   drivers/platform/x86/wmi.c
>=20
> between commit:
>=20
>   9ad55f14cc30 ("hwmon: (dell-smm) Add support for WMI SMM interface")
>=20
> from the hwmon-staging tree and commits:
>=20
>   75c487fcb69c ("platform/x86: intel-wmi-sbl-fw-update: Use bus-based WMI=
 interface")
>   2340f12023ef ("platform/x86/intel/wmi: thunderbolt: Use bus-based WMI i=
nterface")
>=20
> from the drivers-x86 tree.
>=20
> diff --cc drivers/platform/x86/wmi.c
> index d68a96a2c570,cb7e74f2b009..000000000000
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@@ -106,7 -106,8 +106,9 @@@ MODULE_DEVICE_TABLE(acpi, wmi_device_id
>   static const char * const allow_duplicates[] =3D {
>   	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
>   	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
>  +	"F1DDEE52-063C-4784-A11E-8A06684B9B01",	/* dell-smm-hwmon */
> + 	"44FADEB1-B204-40F2-8581-394BBDC1B651",	/* intel-wmi-sbl-fw-update */
> + 	"86CCFD48-205E-4A77-9C48-2021CBEDE341",	/* intel-wmi-thunderbolt */
>   	NULL
>   };
>  =20

This is now a conflict between the hwmon-staging tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/o1TMqZk4pVTC85Dio.ZGgcS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWfPBUACgkQAVBC80lX
0Gy+PAf/epW+McZt3o87dcjtY5M00tJFUTrumEQ4hto3s095ZQ9R+vJSk6tbh5+S
xaiQ4hiuBAqNQplyjj7cum8I17KY5lBbQQkEWx1rTcm80JCllzx3rTffcGm0MmFs
XaPDUqN1wlczgA0h3OunSQ4zYAawDh48450yBNcs8caU4jVP0kvZDz8gOmQd+1NS
Q23jKQlfaWbgsujI5Eeu1kvlA6K6pUSl8dbG0BroHIm4Wn5vSwFqV37L+EiPJojA
yKyzysCDxlh+I2/kJOCUpkys3xO5W3OBlnqTDBxV3rs7hUeZHaCwtTkdqbimfxNP
xX3BdNs5gREFjSI7SWgDS9Jy1eqKPA==
=LYde
-----END PGP SIGNATURE-----

--Sig_/o1TMqZk4pVTC85Dio.ZGgcS--

