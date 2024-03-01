Return-Path: <linux-kernel+bounces-88599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA80F86E3F9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE9A2880F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC346EB4C;
	Fri,  1 Mar 2024 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAsmulBD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE315CC;
	Fri,  1 Mar 2024 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305450; cv=none; b=kEutlPYTNl09pzdjPNIFOQ56tog5wb2Hi9l1aFFX1yes1pmW+zF8pmCh27HR0zfNAcb3pondT2XOHL8cAsJrjRinmfl0bSHDMmkmx068Z4P7jX1BykKy78yqfDdinT67Ye/CiF/SD1zjj41cqkOHcHgJTysAPf1REnakQwIyEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305450; c=relaxed/simple;
	bh=8b4klxTgnQVm/tbELPg2yxa2m+O4M5Ntj7KUNSDPzxg=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=sU6Qz5M6ZIhLaza6+KJ18akjX/fRfxfRQw8qIEVN7Xk/9+Yo13rlw3xvTdmGiRnJe7Xdi0/BOakOPdEoDjpfblO7zygaziEK6AkFgdZUd/DdGeMRBtczo/KXMR3AKygM0ItbkE5IDBfRBCYTx7mZBKagAhFSHrnD4YBlcvCFYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAsmulBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600BDC433C7;
	Fri,  1 Mar 2024 15:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709305449;
	bh=8b4klxTgnQVm/tbELPg2yxa2m+O4M5Ntj7KUNSDPzxg=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=RAsmulBD3Akg3zzYlXjxlRTxDWhi/Fo0WxID12TKQmSSDDZOusA3Z4zsU9uKPqCA2
	 v/wdNRKOuev6YAhsF4mePiXcMqyCmuoDuV+vPQtwPBtFeAQH3Rxc0Ae2GQY3MnJzrZ
	 jtTlBhXMNkBfUXs/acOJcd9RNZAPDBAU+VaUgZPf0BX+7LCfmmOMSh55tBg1C/wiFb
	 UreKVTdQBQ41iVSPGbGw6Smae41j5NtyqA66Wv/Eug5cAysB/hQlp5KCqiRZbJ/KQZ
	 pF0kdv2SItktqY+T5RBCWsCrykY4XWp7B/s6SFMRJeRYIePc3YkwGQC27iCa357ra8
	 E1qXS+7qwHSUw==
Content-Type: multipart/signed;
 boundary=dcbc775c0ca5af93bb9f19526977feebad1ad56af9d8f64d40c34533ac2c;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 01 Mar 2024 16:04:01 +0100
Message-Id: <CZII7JH72OWF.1IAQO5VJCBZX3@kernel.org>
Cc: <kernel@collabora.com>, <kernel-janitors@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Muhammad Usama Anjum" <usama.anjum@collabora.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Takahiro Kuwano"
 <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH] mtd: spi-nor: core: correct type of i to be signed
X-Mailer: aerc 0.16.0
References: <20240301144517.2811370-1-usama.anjum@collabora.com>
In-Reply-To: <20240301144517.2811370-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--dcbc775c0ca5af93bb9f19526977feebad1ad56af9d8f64d40c34533ac2c
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri Mar 1, 2024 at 3:45 PM CET, Muhammad Usama Anjum wrote:
> The i should be signed to find out the end of the loop. Otherwise,
> i >=3D 0 is always true and loop becomes infinite.
>
> Fixes: 6a9eda34418f ("mtd: spi-nor: core: set mtd->eraseregions for non-u=
niform erase map")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  drivers/mtd/spi-nor/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 65b32ea59afc6..46bc45b80883f 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3373,7 +3373,7 @@ static u32
>  spi_nor_get_region_erasesize(const struct spi_nor_erase_region *region,
>  			     const struct spi_nor_erase_type *erase_type)
>  {
> -	u8 i;
> +	s8 i;

Can we just have an "int" here. So we don't shoot ourselves in the
foot again. I'm really no friend of these kind of micro
optimizations, it should have been int in the first place IMHO.

-michael

> =20
>  	if (region->overlaid)
>  		return region->size;


--dcbc775c0ca5af93bb9f19526977feebad1ad56af9d8f64d40c34533ac2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZeHuYRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvtp+wD+KQl+p3C2+4qOt0VnkpYbjzqiMJxIj7gj
O7VZPJX0mA0BAJvAJ948Oer0qeYQC9QCjaW69eLEjcNaL1fCCTXoBPQH
=vz1B
-----END PGP SIGNATURE-----

--dcbc775c0ca5af93bb9f19526977feebad1ad56af9d8f64d40c34533ac2c--

