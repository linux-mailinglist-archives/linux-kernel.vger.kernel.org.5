Return-Path: <linux-kernel+bounces-152661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757A68AC233
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 01:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9341F2164E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 23:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF30046441;
	Sun, 21 Apr 2024 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pPiS7Oed"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9371D2942D;
	Sun, 21 Apr 2024 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713743807; cv=none; b=j8iGcPKKp5JvM02j1MJ9HpN4o3NV/DrZWGDHcv30toE7WW5NovdsxfAahhQ3HcnytKMmNXAY2/ZGUJRDxdyuJKwPHWK752UOVsFpT2aPlYLnN3iUv9X5sx4Tt0DzSsTLJU2SImijptRLcm22i4PMzYCOWM5To25jM3IQI2qRZys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713743807; c=relaxed/simple;
	bh=aictF39DBxTvOODbrLHCTzbnenCLcl824B3rt1qxaVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alEQ16QTE/ysFSxa5iZgfhmFZrnohYncEhWEujvtFvWGe/16eUYJsL5mzewN043EctqoqZ7upromLFIGsVg8K7UAbIilzqoCxi19nwhRchjNwuHBdmSKPRq2II7Fs0x3QRg6saqXs/+s/5dNgHdjVUA6zmbNJzksK7Gswoxdr0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=pPiS7Oed; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713743804;
	bh=SLIE0ixNJA92WnFsxrYMQLdV5RXpE1MlC7mhjXAwMnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pPiS7OedvYIrsD9U8GIHLXZiqUqIbiy4RaR9i6FOznrR4RMrPVG/6VFCHTNaG9Kj9
	 XbdFyXZwJsYVrze830s8Bp6xM0LiqWv5lrlRwut04BnAW2hz9/CBojZvvEELEuQVYP
	 lwm1zjM/OWdpgN2WfHcW8uv7lhDHcHcohMxm0fHqNRFmV0TvoyDFH7WQZ4/D/xILlS
	 FYsXIbd2gn91vbZR82EScrxjzhTMQOSuSMsfbBuK4CIll9oX8qsbw8nYAnwH7uFIF1
	 mZxW8Y6qx6E3dKV5IyT/AjSpliHrBFTK50pW9de/9mMeuTsHmLBYlPZSsWRrG0LzBD
	 GSgOhqHOvFVaA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VN4zc02dcz4wck;
	Mon, 22 Apr 2024 09:56:43 +1000 (AEST)
Date: Mon, 22 Apr 2024 09:56:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Dave Airlie <airlied@redhat.com>, DRI
 <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20240422095642.41892152@canb.auug.org.au>
In-Reply-To: <20240130135626.312c7ebd@canb.auug.org.au>
References: <20240130135626.312c7ebd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ckVYBvYa+bJim8U_ITjmvx9";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ckVYBvYa+bJim8U_ITjmvx9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 30 Jan 2024 13:56:26 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the amdgpu tree, today's linux-next build (htmldocs)
> produced this warning:
>=20
> drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h:1: warning: no s=
tructured comments found
> drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h:1: warning: no s=
tructured comments found
>=20
> Introduced by commit
>=20
>   d79833f34bdc ("Documentation/gpu: Add entry for the DIO component")

I am still seeing these warnings (as of last Friday) but the above
commit is now in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ckVYBvYa+bJim8U_ITjmvx9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYlp7sACgkQAVBC80lX
0GyeMwf/c6mJqYJWVfTdR2FODcWDg3b9586D4We8UklpbyQBQgEdDMf0zYAAoQBg
0JA+h+MTbOlSgnoQ5s3DQ5m3/arBPR3cFv62qVqKliLoshWJgfJSjAnabbZOH3gM
lc9k6E4XAS/MppzHoDoWnkm0KKhpBjYjgmiOgIXU+KZI/QGzEZyR9lfMMLVODoDL
ER7qLfbKcQ4O2C7utcaeO09Z16CInRXc/qeZIunL+T3KBtOYyV/CEPBqMN9oMstu
w/w83oXSx6aueZBIGplo8yUwMlUMSjVbkUmJHTAkFmWVgu+u37Q+Ad6McvVaNdib
spEAQOPqSLbI2ayTZ0snFOPiArZYeg==
=bwSC
-----END PGP SIGNATURE-----

--Sig_/ckVYBvYa+bJim8U_ITjmvx9--

