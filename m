Return-Path: <linux-kernel+bounces-101583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B7A87A8FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED0B287BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387594596F;
	Wed, 13 Mar 2024 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWJQupRI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E58641C7F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338645; cv=none; b=RkBucvSs2E5RaC0XyyXnG1VdRZnCJ99h1FQKBY18GyPE13loLRbhtGCixds6/3Te63IJaey+67gx1GxTH3yK1ZDylFS5/hCAifEQOzoVXYJMk6rs1m4+8Khd2QSb6igSUAJZXGdQ3+gjDjMbG1yKOUvuuRy46XUxLSmzjK3w8JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338645; c=relaxed/simple;
	bh=c6F26WYWOWPHGngG2bLzrx8m4VbcPQ7QBfWC8CH32Uc=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=Y3jHho7JPCrVY4fepS0bqA1+xb2d4i3kAhqIrJkxI/cPYk3+Zya/FWWyV14K/ANiVFvIsrlt2GZ1sVBY5cd4PsKIxVWO2rAuNjrB594IPEYKAFifrm0IlOI/zKWah4orYyWOHJaiPBmUN3DEvmFp+Xh6WTOFtJ+U6Po6kN2leug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWJQupRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FD8C433C7;
	Wed, 13 Mar 2024 14:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710338645;
	bh=c6F26WYWOWPHGngG2bLzrx8m4VbcPQ7QBfWC8CH32Uc=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=TWJQupRIoMDLYy8Z56ID/kiUfI6+tt/S/oJpr7erwMaWPJ+GlbRvRDuV7jZ+vNmW8
	 L84D1juJ/mh9/OBoyiDYlxWn9t7oAQdGo/jRyJ/oRm1l1zEXBxecSCpPYkg9MAJ+pU
	 64NHCHsaoggzD/OW+aAClUurZ7GUlNxJVHQ1pn3aSbQVAz3YYVf38VFf6tYwMpBubo
	 NNGz+uzf7S+1MnHqZ0RVmVducRmBkaHBxNG6P3kZ1Pbq6MMEsoqieSyPGFkvX9lAHl
	 /5Hli3BRxYj1+dtAo2U5BZ9jTfqNZQ7IV+ojXqvGlwvkJG3fsChRR95RPReU9TN6kb
	 p8/TfJKxXmutQ==
Content-Type: multipart/signed;
 boundary=fd774a84601503390b4d60fed6349c6cc9ccc01530323bbd271b951b5256;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 13 Mar 2024 15:03:52 +0100
Message-Id: <CZSOG0WG0FAJ.23WQ5CB6Q8RIZ@kernel.org>
Subject: Re: [PATCH 2/2] mtd: core: Don't fail mtd_device_parse_register()
 if OTP is unsupported
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger"
 <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Mika
 Westerberg" <mika.westerberg@linux.intel.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Aapo Vienamo" <aapo.vienamo@linux.intel.com>
X-Mailer: aerc 0.16.0
References: <20240307130418.3131898-1-aapo.vienamo@linux.intel.com>
 <20240307130418.3131898-3-aapo.vienamo@linux.intel.com>
 <CZQZXAB2GOCY.12YVJ6CRGG26B@kernel.org>
 <xeqscncwirfaz77mtpcvkueo5xto7vis5khr3uwclcx4sfx6eb@35j3grcqrzo2>
 <CZSIHWU6IYXB.2DUCUUYFTAB2X@kernel.org>
 <lxl3zzgq4kgbgxkya2c6zyagcnrcyp2lzewu553mkmgdlooeca@m2wyltn7qpog>
In-Reply-To: <lxl3zzgq4kgbgxkya2c6zyagcnrcyp2lzewu553mkmgdlooeca@m2wyltn7qpog>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--fd774a84601503390b4d60fed6349c6cc9ccc01530323bbd271b951b5256
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Mar 13, 2024 at 2:59 PM CET, Aapo Vienamo wrote:
> On Wed, Mar 13, 2024 at 10:24:13AM +0100, Michael Walle wrote:
> > On Mon Mar 11, 2024 at 5:20 PM CET, Aapo Vienamo wrote:
> > > On Mon, Mar 11, 2024 at 03:38:17PM +0100, Michael Walle wrote:
> > > > Also, you'll print an error message for EOPNOTSUPP, although that i=
s
> > > > not really an error. Is that intended?=20
> > >
> > > Well, when we hit this, the functionality of the SPI memory itself is
> > > degraded in the sense that the OTP functionality is not available. Wh=
at
> > > would you suggest?
> >=20
> > But it's not really an error, I mean, we are ignoring that one on
> > purpose now :) I'd just guard it with "if (ret !=3D -EOPNOTSUPP)".
>
> To clarify, are you suggesting a modification like this to the code at
> the end of mtd_otp_nvmem_add()?
>
> err:
> 	nvmem_unregister(...);
> 	if (ret !=3D EOPNOTSUPP)
> 		return dev_err_probe(...);
> 	return 0;

Yes, either this variant, then you don't need to fix the caller or
return EOPNOTSUPP but just don't print the message.

-michael

--fd774a84601503390b4d60fed6349c6cc9ccc01530323bbd271b951b5256
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZfGySBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvuZrgEArJM6xLpOYhTGbcQdQa1SJArVlp1t5IKr
KPBIGGXA9cUA/iy1eF1dAKCAhY7cOF1DcpEEl6KNC17kS+2BT82oVJ4E
=KvfU
-----END PGP SIGNATURE-----

--fd774a84601503390b4d60fed6349c6cc9ccc01530323bbd271b951b5256--

