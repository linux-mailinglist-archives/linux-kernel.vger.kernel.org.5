Return-Path: <linux-kernel+bounces-90290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E55686FCF7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FEC31C2216E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C03241E3;
	Mon,  4 Mar 2024 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tak5sBNU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A269B23747;
	Mon,  4 Mar 2024 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543816; cv=none; b=ZySTT6uOMkcF5GGJesZsvpTZljkA1u3zsr715wG6xlvXHiJ6E7VJO24mI99MjU/RtRXXRb05yw3LAsfX0XRTeSYrWh6G3+2bJPLHbzmwP/mpu4d6j7BONTjwNt6FGhEYYpTZlwxSjDRxwvnSqT+unXBupjiX4s68du1+zIZzGyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543816; c=relaxed/simple;
	bh=smtWowPoYhv7nEqimgeA8xDDf1PSEUGTNJKR2E0PKfE=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=Q3RmKN6OLUsz6yLmY8jLbdjzcHa7nZMce2nP2pPS6XbVjrdYqa/zhaE1jcLS2Tsnyxj0SBIh1d4PsbL61MZnoqpX/u9pS78RiGRoc8NNJQ0xnfUKc0nAdwe3lLx6ZfK+hRrtRXczihL+8VHIwKm4PZIUdr79QJTvVSnrPM8iJpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tak5sBNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFA8C433F1;
	Mon,  4 Mar 2024 09:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709543816;
	bh=smtWowPoYhv7nEqimgeA8xDDf1PSEUGTNJKR2E0PKfE=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=Tak5sBNUjnXkT+jt+oS3upMdOErw/XV1bnFuq3gV7KE6pHzfe53DwvyBxSTvqOmk5
	 gtJg0BnwMKflLZksQRhxucvAfFIb/ngzzsCFglrW0Q+6p1EeIhxFRw4Ny+moOxJ9ER
	 BzoxbjOE5qfdnmTNiLcXluFS6MPSkKUBZmhMVwQxgtV931ayWpAAycnqhggvNTDbiN
	 TUarNka6cEvsIydUSzFXP+EthiiuBTrPHyva8eeA3dOJTtY+vHnzpNQMmCncVaP4gw
	 pXY3aJEuuDAmwF0S3RkMKRMxJEtvLO0GMtM1KQGqwhvFHSi67MvIE1NqreluH6qjZV
	 pY9M5r4PlCaCg==
Content-Type: multipart/signed;
 boundary=56c5c757e8efd87fd596512d7c6b13800a50b7e712b376cf74eec9ce7510;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 04 Mar 2024 10:16:53 +0100
Message-Id: <CZKUPDY8GTHC.BQ9KN9FR2R0H@kernel.org>
Cc: <kernel@collabora.com>, <kernel-janitors@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Muhammad Usama Anjum" <usama.anjum@collabora.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Takahiro Kuwano"
 <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v2] mtd: spi-nor: core: correct type of i
X-Mailer: aerc 0.16.0
References: <20240304090103.818092-1-usama.anjum@collabora.com>
In-Reply-To: <20240304090103.818092-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--56c5c757e8efd87fd596512d7c6b13800a50b7e712b376cf74eec9ce7510
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Mar 4, 2024 at 10:01 AM CET, Muhammad Usama Anjum wrote:
> The i should be signed to find out the end of the loop. Otherwise,
> i >=3D 0 is always true and loop becomes infinite. Make its type to be
> int.
>
> Fixes: 6a9eda34418f ("mtd: spi-nor: core: set mtd->eraseregions for non-u=
niform erase map")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Michael Walle <mwalle@kernel.org>

--56c5c757e8efd87fd596512d7c6b13800a50b7e712b376cf74eec9ce7510
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZeWRhRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvvI9QD+NBOU1OgPhPQF+0Iw2vVU+MRbcTw0ux1D
p4zNxDJ+bogBAIO88z955ZP4Qg575PSYdMtAVZ7V6Xt8v3OTgB8inEwA
=0b60
-----END PGP SIGNATURE-----

--56c5c757e8efd87fd596512d7c6b13800a50b7e712b376cf74eec9ce7510--

