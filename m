Return-Path: <linux-kernel+bounces-148746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E3C8A86E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677CF1F22521
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C2A1465AF;
	Wed, 17 Apr 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+5/cF3y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E515137C33
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366181; cv=none; b=phIgLfDnnNFZssNxqAdlx6EguUTv9u3y0Xo1CxvRXOx9ft31i0l3ItVHQ3Gd1MpIg6V5gq3UtZiU9bzUJ+sb3IMTxJDeKxec+4dMubb9DlWE9hpkOidu8aqgiKrrGIGYs8LYrIp0h1Y6uUX8d2n1DqW24aEFW0MYDD0kdw728Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366181; c=relaxed/simple;
	bh=/Bqkb7GldAoAOYMnYPa55hOe2NOFX26LJMHeeNgsJmE=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=b27MQpI0cWfGF1YZLzH4CU11Uusv59nxXyc5EU1DX+jNwbPfoJe1Y8PnGHSS7Sw4TTw054X0G7X78u9PgXnkrBIA+dHRryJIqYCTPms7sLfN+XIkMsIfEFGMQzff3Hk/I05avQnJfiXIeSqaVyQPYCy2xerCIAtMnAngHeAjn9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+5/cF3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80107C3277B;
	Wed, 17 Apr 2024 15:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713366180;
	bh=/Bqkb7GldAoAOYMnYPa55hOe2NOFX26LJMHeeNgsJmE=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=d+5/cF3yTQM4BYfA1SZFN7z0BhLJy35wEBz6cksna76/+Tpu+erwS4gPs5AVAzEzl
	 d2aAS+rpfMDyQZJFltNtyE6TxxWrWdGiWM+OdAyxsSyvTdq3Cniz0dIUP5Iet+3YYC
	 b+o/T0llDh3XLt6JdKtEks1iV9pAHzI3y3x3O9c8xVi0VedrDF0vblw97S4NUxgUgR
	 u6hhvpUBakvI5tFZLcb8SB+h74KLC3PkPYayuymtFMNoTJ41uD2R15Ss6RXK3DYgyK
	 4YrcWEOTdRu7J/DdUIo6yxJglZ7yj2tne99ZREI2nj+Vn+575fkMjhBobKXFoaGWij
	 wTd3C2LLfWgmA==
Content-Type: multipart/signed;
 boundary=c423f377f76eebb1c0e9a87ea3b3550e31e5e58260f6d25ee91339b00ae2;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 17 Apr 2024 17:02:57 +0200
Message-Id: <D0MHMBLVCCZ2.23XGMIORQYGDR@kernel.org>
Subject: Re: [PATCH v1 0/6] mtd: spi-nor: spring cleaning
Cc: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>
X-Mailer: aerc 0.16.0
References: <20240412134405.381832-1-mwalle@kernel.org>
 <f07afa83-1c37-49da-923f-2ea9550e7163@linaro.org>
In-Reply-To: <f07afa83-1c37-49da-923f-2ea9550e7163@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--c423f377f76eebb1c0e9a87ea3b3550e31e5e58260f6d25ee91339b00ae2
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue Apr 16, 2024 at 6:57 AM CEST, Tudor Ambarus wrote:
> On 4/12/24 14:43, Michael Walle wrote:
> > It's time for some spring cleaning. Remove the oddball xilinx
> > flashes with non-power-of-2 page sizes.
> > Remove the .setup() callback, only the default callback is ever
> > used and it is unlikely there is need for a custom setup.
> >=20
> > Finally, the last patch is a proposal how to deprecate flashes,
> > which are just detected by their id. We cannot really find out if
> > there are boards out there which are using a particular flash. Thus,
> > as a first step, we can print a warning during kernel startup. As a
> > second step we might introduce a kernel config option to actually
> > disable the flashes which has the deprecated flag.
>
>
> How many FRAMs/MRAMs are in SPI NOR? Can you list them please? I don't
> remember anyone bringing topics about everspin and the cypress thingy
> was a mistake. I'd like to get an idea whether it's fine to remove the
> FRAM/MRAM from SPI NOR without doing these preparation steps and waiting
> for another year.

As far as I can tell it is just
  drivers/mtd/spi-nor/evervision.c:
   - mr25h128
   - mr25h256
   - mr25h10
   - mr25h40
and
  drivers/mtd/spi-nor/spansion.c
   - cy15x104q

Please keep in mind that the evervision also have dt bindings and
spi aliases. So we'd also have to deprecate these ones. Not sure
they can easily be moved over to another driver, esp. because the
kernel interface is different (mtd partitions vs nvmem/eeprom sysfs
file).

There are three in-tree kernel boards using the mr25h frams:
arch/arm/boot/dts/nxp/imx/imx6dl-eckelmann-ci4x10.dts
No clue about that one.

arch/arm/boot/dts/nxp/mxs/imx28-sps1.dts
I've contacted Marek who introduced support for this board and he
said it can likely be removed altogether.

arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
This seem to be openwrt driven (?)

I was thinking about sending patches to migrate them over to the
at25 driver. But again, that also means they'll loose mtd
partitions. Not sure, that fram is used on these boards anyway.

In any case I'd like to start with deprecating the FRAMs in
spi-nor and the DT bindings.

Also, the cy15x104g is rather new...

-michael

--c423f377f76eebb1c0e9a87ea3b3550e31e5e58260f6d25ee91339b00ae2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZh/koRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hppgF/eysfe0XwOiW1dI8MpG8NU6Y7AGPTH1od
7JCUF8xW6WoUkGyZNfy9WwDoa1PhjO5rAYDyPS9TGbQ2HIvGO8GclixI+fqq9b04
UT2uLi0rfeoBXHUDGibDVLs5k7qonhxjeIc=
=3qxk
-----END PGP SIGNATURE-----

--c423f377f76eebb1c0e9a87ea3b3550e31e5e58260f6d25ee91339b00ae2--

