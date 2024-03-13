Return-Path: <linux-kernel+bounces-101713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5C687AAE1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626C01F2325C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171F9481BA;
	Wed, 13 Mar 2024 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="eLwSR1m0"
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E04AEC6;
	Wed, 13 Mar 2024 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345872; cv=none; b=I40S6mIvK8RtRFyGMCfU7E0LE40e2IT66tXcbDTBtIj4n4keD+pt/OfpOXTj/kTo32jvfHnm7fOm7xFf237m8cdPGawoj55bJzLF9xrC2GNUpXD1uaIvry8wD5E91yFOwVLdeLDMo6f+hZ2thk0NbqZmi5M1Fsys38vnT4m9AR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345872; c=relaxed/simple;
	bh=/21vYs7JnLGOZDeq4wGJbJe7ymO25lDPTNiTyZzXeAQ=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=Ht/V+UTCZRUZCX2zPcBpKL+KOJfcSJ3hMtnZHzhRPAu0g8JazJCtPLQ67ka4OdlnCwf/Zl9vGWkZ1ps6VYhc0G5HKfZ5SdmJlKvOMxPa8QusWg/RIj6f7oVO6ST6xZL04Z3vkXrp3+xno8e+nxVMj4KCzEOs2XmaaS4WtkoznEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=eLwSR1m0; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id B6F8FA57;
	Wed, 13 Mar 2024 16:56:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1710345365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=0kMx2fnLG9S7QuFGxkEk0mKxM9IIq52H3BHVY49JHOo=;
	b=eLwSR1m0Ax3+MWq7PQkwieRJ5WLjMrpCkYqvqfVpaL65dyCaT1FAZqBmqPx/u8RjISDBxU
	5ObwEhczI6lUbB+8Py0TwalyHjbKMcgGp6l9KlMpD/I4fD0yxhnE7zezlL0iYZQb3KVdF7
	FMh4QrJyBORVs6BFuFjNaWFlcPElHujzL6aszvgArnTOxTm3h5Ln1IynijWqTzB7Em5qGv
	9PEWqvYiPKZ9NZ530BysQ+PVnwyM/uJPROHe2Og3mWS2t5cbxuV+F2E94kobaIPKLvnVKS
	qDarovdw8J6tGH77V2A7a5zd0UGRHhEeq74xiFW/z6iiOEtqcyxukTczpGSTCg==
Content-Type: multipart/signed;
 boundary=ec260765e73bac126ee51ca62d74f74f4bbd22afdb55110dde7cef8988ef;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 13 Mar 2024 16:56:00 +0100
Message-Id: <CZSQTVDX6QR1.1K5UGJUNPLM0S@walle.cc>
To: "AceLan Kao" <acelan.kao@canonical.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Mika Westerberg"
 <mika.westerberg@linux.intel.com>, "Dhruva Gole" <d-gole@ti.com>,
 <linux-mtd@lists.infradead.org>, "Mark Brown" <broonie@kernel.org>, "Kamal
 Dasu" <kamal.dasu@broadcom.com>, =?utf-8?q?Jonathan_Neusch=C3=A4fer?=
 <j.neuschaefer@gmx.net>, "Mario Kicherer" <dev@kicherer.org>, "Chuanhong
 Guo" <gch981213@gmail.com>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/2] spi: Unify error codes by replacing -ENOTSUPP
 with -EOPNOTSUPP
Cc: "Florian Fainelli" <florian.fainelli@broadcom.com>
From: "Michael Walle" <michael@walle.cc>
X-Mailer: aerc 0.16.0
References: <20231129064311.272422-1-acelan.kao@canonical.com>
In-Reply-To: <20231129064311.272422-1-acelan.kao@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--ec260765e73bac126ee51ca62d74f74f4bbd22afdb55110dde7cef8988ef
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

I just had a quick look to see where Florians breakage could come
from and just noticed this:

> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 849ccfedbc72..e0b6715e5dfe 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -974,7 +974,7 @@ static int spinand_manufacturer_match(struct spinand_=
device *spinand,
>  		spinand->manufacturer =3D manufacturer;
>  		return 0;
>  	}
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
> =20
>  static int spinand_id_detect(struct spinand_device *spinand)

This seems to be random as no other spi-nand ENOTSUPP was converted
but just this. Is there a reason for this, AceLan?

-michael

--ec260765e73bac126ee51ca62d74f74f4bbd22afdb55110dde7cef8988ef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIcEABYIAC8WIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZfHMkBEcbWljaGFlbEB3
YWxsZS5jYwAKCRDNyh2jtWxG++m7APsGW7Jo4lpVFMx2pZX2ivdcG1PCQ8xeW1SQ
QsPWXO6HlgEA6GXGBiyJkT1rh+sJTBKn5D6J/jDGAcdt6SCLWtzR/wk=
=TR1q
-----END PGP SIGNATURE-----

--ec260765e73bac126ee51ca62d74f74f4bbd22afdb55110dde7cef8988ef--

