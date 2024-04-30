Return-Path: <linux-kernel+bounces-163726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0DA8B6ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E60D28453E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6BD128833;
	Tue, 30 Apr 2024 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="P4oUqNvM"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BE128389
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714470817; cv=none; b=CTYxM0d3HYDofxYaR8BNV7p7B3q/F1t5bjJzcYkwx8q24j7yeVD14Jy/lFFXGlbvpwrzaK3jzaaleaFAalYwrSCmevKv5H+sk5hEU1rn1KpiBiHsweBQvScXAvwrOOtKwIrISvcsarlEX9obX3btyU6iK8Gbn/b1//c3hzT/xQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714470817; c=relaxed/simple;
	bh=GXKfWFFF7RQoHWKkPZ06vCZuiUcnMAH+8TtHuYpvnOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQrjwH67uMmAZeHjm7Fa4ejMoZXxEydPcxZMy51Ss9g/oMwT6h/0vePag4c66xNv57jEoxit9G9CJo+TXyO0mzrmC+Gl8NrXwl98aVkfbCDl4zucY71crc6qpUud153Xgm3OghAkbYPiBpIOhF67zAzPOjwGUd/lZxR3WCDOLrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=P4oUqNvM; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=GXKf
	WFFF7RQoHWKkPZ06vCZuiUcnMAH+8TtHuYpvnOI=; b=P4oUqNvMQ/CpzA4VWElE
	p/bnhQaBQfV6FxSDtv/BAYmCbH2U8sz8HnECLyqs/K247dOIZYf8dsDCFRMPbExD
	soztpszv25qeW0y3j5dIQSp8wpn9erRu6Ci8i0jioYOZ88LwJE4jjho82JEZm/31
	MWo1dwrCzDVL7fYgzQ+m5ffh6ATDaKvAaFznGzSDnZtmG3MJSVnDBRRzMy9C0p0b
	Gu8Hyck/1gRvuPsRgrXcfduOo6vCcfKBCxwzT0ELRQt2vA3aL89Vz6G86FS84VlB
	pKpEFxg3pCPmOSvUQ6semuGGiPcOfzDK1KOypQqcg30ga9TfizNwGGnARG1TO1jg
	zw==
Received: (qmail 2585368 invoked from network); 30 Apr 2024 11:53:32 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Apr 2024 11:53:32 +0200
X-UD-Smtp-Session: l3s3148p1@9gK/V00XzJBehhrb
Date: Tue, 30 Apr 2024 11:53:32 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Hien Huynh <hien.huynh.px@renesas.com>
Subject: Re: [PATCH v3] mmc: renesas_sdhi: Set the SDBUF after reset
Message-ID: <rekyp45sxw7xtwj7jz3kgnfskroc7z5txbmvmyk4tbw3djqhcn@qyulszizfvc3>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Claudiu <claudiu.beznea@tuxon.dev>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Hien Huynh <hien.huynh.px@renesas.com>
References: <20240430093724.2692232-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jparjn2ysbxorccu"
Content-Disposition: inline
In-Reply-To: <20240430093724.2692232-1-claudiu.beznea.uj@bp.renesas.com>


--jparjn2ysbxorccu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:37:24PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> For development purpose, renesas_sdhi_probe() could be called w/
> dma_ops =3D NULL to force the usage of PIO mode. In this case the
> renesas_sdhi_enable_dma() will not be called before transferring data.
>=20
> If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable()
> call from renesas_sdhi_probe() will configure SDBUF by calling the
> renesas_sdhi_sdbuf_width() function, but then SDBUF will be reset in
> tmio_mmc_host_probe() when calling tmio_mmc_reset() though host->reset().
> If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.
>=20
> To fix this call again the renesas_sdhi_sdbuf_width(host, 16) in
> renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
> removed from renesas_sdhi_clk_enable() as the host->reset() is optional.
>=20
> Co-developed-by: Hien Huynh <hien.huynh.px@renesas.com>
> Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--jparjn2ysbxorccu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYwv5cACgkQFA3kzBSg
KbafUxAAsJ3wQuqSl+GQrbsQ7yA7ZNfWhXATEOMhQ0RtTH8zsooQ9MsSs1tsqqwp
Ygi38r8GGo28LkvKV+YjxwA/jBnW02S5hbGajwYsiWuAOVbXtsneFJZ4ea79sQYP
qazKz1Te386vHpPhfKs1d0qTBaaZp1XsD+1P4xd6Y1jak5o7iDca08LlpR0xt3+s
b/F5Gy6GVoM69GWRrertb7evWyiiKc0G+QW+8/eXjixe3DUvu81M1f1vxvF7NKR0
GjMYi/VUQJ5ypYBdyUPd94af3+3Z/URbM6886ugSpHOvj7PTs59zG36ddQ5yLJN0
EZlUoofQZ8b0vYpVEm/JcXXG1BH8EOkaffdj5y67HtrQzj7/Jm68waMaTlQKQ+xO
hMOdhX7lwYlWGVBFrpYX8UzUofwKnqJlk3w4XG37qTy1ZwH/AfdHHHWm5rdtGPFP
IuEFZC0XUGX2aW4XgcKe5UcEGz2bCuqSvmOfUUg1oN553BasKfGIqRnR9innNb76
uxEtrhmjFcQz9ZrBJACgHL0vo5/6NXNZyxx+mwjXWftXLpmmgAr5e6r2x+wGU0o3
4Fi9DlvpJC0N5yjyN3uvI1OhqjD8zh+QyOzHuhWP372es13IpGqYfohxyYrm69Qf
alt+AeYq15lanBxcPbhXGY/CgkqHQjQVGF4M75Dmn+tepwkcpIc=
=vsZz
-----END PGP SIGNATURE-----

--jparjn2ysbxorccu--

