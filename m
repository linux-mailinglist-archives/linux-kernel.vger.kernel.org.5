Return-Path: <linux-kernel+bounces-74302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C974E85D28A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A30CB23CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D843BB55;
	Wed, 21 Feb 2024 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ic0r5xFI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96F623C9;
	Wed, 21 Feb 2024 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504068; cv=none; b=aiH3Aly03foP3gvnIW6u47llQOISCM+lFEkaThC+OU+qXUBgwfokSlqNk7YIl4bT+IaRK+0MUnbwQChI5ILegVvHTaSvA+ugZwcFlJmTXNrie70W/RPH2hQuDseSLxRu1+Ci9NcEK2upSdf4OcTct7XwpHbYNtORzlysDiAGm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504068; c=relaxed/simple;
	bh=qRF4WCJKc+7S2gxfQOFzn1ROveekqZHEyCJTKXwAiaY=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=sSNp2osf9Hct0gE7/8bPoIk6lAb1eUz2016QQQATD+gaTxKGTkwlxhJDIypbmt62ePZMSgp7Pa3Um1ENHdQobXLoSnEMC/jhQFZkx6TCohIZe2GZ8kOHwtNQtankCvZ8/CrM1bKLfY43BtymoU9WC61CEeC+9cxmJk5ffl9MB3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ic0r5xFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB85C433F1;
	Wed, 21 Feb 2024 08:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708504068;
	bh=qRF4WCJKc+7S2gxfQOFzn1ROveekqZHEyCJTKXwAiaY=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=ic0r5xFINXXfSYwtRByHBDYCIIEXVlDmlX9u6RJOne05/VJXk1+j1q4mdnEyZbF1a
	 iZiYbRsL9AhR1xtRq6ANz1L0DT5qwP6O5G+W/u2xnOPBhTlQfVrixsef+SCg0d3N0N
	 H+RjDX4noEDX4FRHv4ABXGiM3p+Fuxzb7Or8ks41/f/Vd1CUZ2kSlBXDtM10Da2gMR
	 JeyZ6UJpoWxoLudFXiX4MhLn0kl9TYprLFkdJRmlZ9G5iGiz+BanzJemu7i1F36Dcz
	 UngXbqZljgCe/pFnRIeTeUYGtcW0ZERtpHbHRPyQwrg15OlK9/O4LmOisfIh855emV
	 JaVcjoQEc27zw==
Content-Type: multipart/signed;
 boundary=42ada7a77eafabbea00286cefa9886bdf49729263a69fbabf35bf5d7c998;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 21 Feb 2024 09:27:38 +0100
Message-Id: <CZAM553H2H56.2TDN36QEL90XX@kernel.org>
To: "Josua Mayer" <josua@solid-run.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v7] dt-bindings: mtd: spi-nor: add optional interrupts
 property
Cc: "Yazan Shhady" <yazan.shhady@solid-run.com>, "Rob Herring"
 <robh@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240219-mtd-flash-interrupt-binding-v7-1-206e30a656fa@solid-run.com>
In-Reply-To: <20240219-mtd-flash-interrupt-binding-v7-1-206e30a656fa@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--42ada7a77eafabbea00286cefa9886bdf49729263a69fbabf35bf5d7c998
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon Feb 19, 2024 at 3:41 PM CET, Josua Mayer wrote:
> Some spi flash memories have an interrupt signal which can be used for
> signalling on-chip events such as busy status or ecc errors to the host.

Do you have an example? Maybe one with a public datasheet?

-michael

--42ada7a77eafabbea00286cefa9886bdf49729263a69fbabf35bf5d7c998
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZdWz+hIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvt0fgD/RoTM/WunYCUK3dUGUG8NLVQCFB4h26Bo
4czKnwqDcDwBALS7CgrZHUZ7QKgh1ApV8U0F99kDhl/Li96dj981Ta4J
=+hWC
-----END PGP SIGNATURE-----

--42ada7a77eafabbea00286cefa9886bdf49729263a69fbabf35bf5d7c998--

