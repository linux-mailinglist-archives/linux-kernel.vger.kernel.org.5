Return-Path: <linux-kernel+bounces-74666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5C485D776
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D30282EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952A547F59;
	Wed, 21 Feb 2024 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JahR6DaO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129047A52;
	Wed, 21 Feb 2024 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516358; cv=none; b=hgrZBV9ppu4gFMChBuE+u0/8OVAR/VN8PxZ9AoAjm6U7u4u7TQ4jWVPVmo106XZu7EpirPEkoYKpxZeID/srSCv4+nWhhmDGfrAC4+0Hy/6zqTvcot77aUJcL7hlAhxG0x6vUpYlSXxSAqYd3gZf8AYdlzdnLPc9n6y4peADZks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516358; c=relaxed/simple;
	bh=lZLENxtHLbI6QbQIsmJDLuLCaCc5Gu/ruskB21Fbjd4=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To; b=Ly0WE4Y0wnFicifNRgdgU5bXE+fR6anO8uYrO143u+oBOkyYfy7bWHG+A0CxVxR79rbLjS4KsmUa3I4OyFav9AN/l3YfAZT8tY7S6O+mPQUa7fCaT6Mc6hCqhC9wokCGlYn+myRUdMQ48RJKgSocc4M9mcDAmxycr5LKZ38y+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JahR6DaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2660C433C7;
	Wed, 21 Feb 2024 11:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708516358;
	bh=lZLENxtHLbI6QbQIsmJDLuLCaCc5Gu/ruskB21Fbjd4=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
	b=JahR6DaOk3I/CcusIGmx+XzxI0zXtyxmcIprdjvc2Su2RQEF0iJ38GgOpZO+/fllm
	 ZlUuKfJYvaAWKqs6fuMTPGBm6V0CN3JYis4ZvmNj8+9j6nBxSak9RoIfM7oh1Dchn+
	 zzYjv8P82bkaHQPmRH9Oj1RgSKtZ8pj3jLGYhi/iosspHIczcmhcFk2+vvcoQd1kRm
	 lBuR3myQY5ir/Pj+5N89EIkh43E1kkaFR5ixa8aT5UyYiCLiz3MNfSzO4Wvp5sz0aR
	 Y2aBmqsHCU8U7zOoFLDTrlV5Qj1yysP6yMQYyjCLck2fjyUfWYn7EoMh5fiAAUFe4y
	 7rI7jd9Z+20tQ==
Content-Type: multipart/signed;
 boundary=c688cecef0f4ae5165c98d85f84090b76ef48c63c8e86034169e62c2a33d;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 21 Feb 2024 12:52:25 +0100
Message-Id: <CZAQHXT016DW.GDDY3ZAKS4CJ@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Pratyush Yadav" <pratyush@kernel.org>
Subject: Re: [PATCH v7] dt-bindings: mtd: spi-nor: add optional interrupts
 property
Cc: "Josua Mayer" <josua@solid-run.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, <linux-mtd@lists.infradead.org>, "Takahiro Kuwano"
 <tkuw584924@gmail.com>, "Takahiro Kuwano" <Takahiro.Kuwano@infineon.com>,
 "Yazan Shhady" <yazan.shhady@solid-run.com>, "Rob Herring"
 <robh@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.16.0
References: <20240219-mtd-flash-interrupt-binding-v7-1-206e30a656fa@solid-run.com> <CZAM553H2H56.2TDN36QEL90XX@kernel.org> <a0144c5b-4095-4a0c-84b6-93dfe9631a6b@solid-run.com> <CZANBUQ2RJ3N.DO07Z9VFJCBZ@kernel.org> <mafs0v86i6qk6.fsf@kernel.org>
In-Reply-To: <mafs0v86i6qk6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--c688cecef0f4ae5165c98d85f84090b76ef48c63c8e86034169e62c2a33d
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Feb 21, 2024 at 11:48 AM CET, Pratyush Yadav wrote:
> On Wed, Feb 21 2024, Michael Walle wrote:
>
> > [+ Takahiro]
> >
> > Hi,
> >
> > On Wed Feb 21, 2024 at 10:13 AM CET, Josua Mayer wrote:
> >> Hi,
> >>
> >> Am 21.02.24 um 09:27 schrieb Michael Walle:
> >> > Hi,
> >> >
> >> > On Mon Feb 19, 2024 at 3:41 PM CET, Josua Mayer wrote:
> >> >> Some spi flash memories have an interrupt signal which can be used =
for
> >> >> signalling on-chip events such as busy status or ecc errors to the =
host.
> >> > Do you have an example? Maybe one with a public datasheet?
> >>
> >> My example is Infineon S28HS512T, however datasheet download requires=
=20
> >> user account.
> >>
> >> S26HS512T has interrupt line, too, and datasheet is downloadable witho=
ut=20
> >> registration:
> >> https://www.infineon.com/cms/en/product/memories/nor-flash/semper-nor-=
flash-family/semper-nor-flash/#!documents
> >
> > Thanks, as far as I can see, both are hyperbus flashes. I'm asking
> > because I'm not aware of any SPI NOR flash with an interrupt line.=20
>
> I found this datasheet [0] for S28H flash family from Infineon on
> Google. These are SPI NOR flashes. In pinout you can see there is an
> INT# signal. The signal description says: "System Interrupt (INT#). When
> LOW, the device is indicating that an internal event has occurred."
> Further in section 4.1.1.5 "INT# Output" it says:
>
>     HL-T/HS-T supports INT# output pin to indicate to the host system
>     that an event has occurred within the flash device. The user can
>     configure the INT# output pin to transition to the active (LOW)
>     state when:
>
>     - 2-bit ECC error is detected
>     - 1-bit ECC error is detected
>     - Transitioning from the Busy to the Ready state
>
> [0] https://www.infineon.com/dgdl/Infineon-S28HS256T_S28HS512T_S28HS01GT_=
S28HL256T_S28HL512T_S28HL01GT_256-Mb_(32-MB)_512-Mb_(64-MB)_1-Gb_(128-MB)_H=
S-T_(1.8-V)_HL-T_(3.0-V)_Semper_Flash_with_Octal_Interface-DataSheet-v03_00=
-EN.pdf?fileId=3D8ac78c8c7d0d8da4017d0ee6bca96f97&da=3Dt


Okay then,
Acked-by: Michael Walle <mwalle@kernel.org>

-michael

--c688cecef0f4ae5165c98d85f84090b76ef48c63c8e86034169e62c2a33d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZdXj+RIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvvNcAEApra9rSm1MfAkhRbVfkHLU/6D/SWddatA
gXpTpAKirOoBALjzfbDua3ec+2dO1vFKuvOuC4AdReQxdnr3bRXO4SYB
=rxHh
-----END PGP SIGNATURE-----

--c688cecef0f4ae5165c98d85f84090b76ef48c63c8e86034169e62c2a33d--

