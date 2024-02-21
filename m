Return-Path: <linux-kernel+bounces-74396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FDC85D369
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A631C2245E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4EC3D0DD;
	Wed, 21 Feb 2024 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrmSA7G2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2583D0B9;
	Wed, 21 Feb 2024 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507415; cv=none; b=qYOeVMdii+7zm/0XmQ5ugD5RZOJCwklIa7K04b0rh2CLeq9oNCJJy1/vSz8BpV9mUeNzO7TK0roY1NaoPM6n9vQ7n1eE82MoJydVU5eTrtRHXkIKHX4JXAp66tjKOF7m7LeibTbFO48cPzHXQ1k3N4ccXWvzI4ie5D+X2eBxOTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507415; c=relaxed/simple;
	bh=jE1ncH7sLUYatuNt7cLbmypurrJj6Bf/Ccrj6W1lvQc=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=FelfAn0uA42CcxK62mam3079GYUbTsfS4+kwcu7/qSIOy8DIM+vygBZYvDy7hl2nm1sFglOiRbz6VC+jHx9WM+E4IYTeeFz3QVCzfnxhxw/QRtcBMhhH4k2E6nGtz/eCT43UGFvUtAjwueUIfM9I6OQELNMxxh/P8zT+xAtaG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrmSA7G2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C35C433C7;
	Wed, 21 Feb 2024 09:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708507415;
	bh=jE1ncH7sLUYatuNt7cLbmypurrJj6Bf/Ccrj6W1lvQc=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=LrmSA7G2qnXbBZhzlDs81CW9rI3+FG6uXE41/r/OntunNmQAaXDrUdQ8ItFLdHyn+
	 bNAfSgOe2g83K0QYoUPAzIXpjzHL7G4l3xvd8XB/qJcF947Mt65f9sgd99elh1g01v
	 /9tAmqpvAK1edAwv7CN7XVVNFYT9gOY5u5xdfzMxSD6pJRfCvbn4uF9h6O2yVw5fIw
	 a4rDLwUB3BShO/RVIULt8/jeq6Te5kQkxR+tRjhbSPAPByOprD+IDlTGO/be3/SsIW
	 oSd+YaFoVy8b+45thdfESHxajkjPW6jTgRNnbfcW+SgrbNClj9xvf8E4CKYySc//gg
	 0kgN66e1XzQJQ==
Content-Type: multipart/signed;
 boundary=e9f867f281deaf04305f7f7b113436157ecc73b10b85215ac510f5eb30ca;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 21 Feb 2024 10:23:25 +0100
Message-Id: <CZANBUQ2RJ3N.DO07Z9VFJCBZ@kernel.org>
Cc: "Yazan Shhady" <yazan.shhady@solid-run.com>, "Rob Herring"
 <robh@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Josua Mayer" <josua@solid-run.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-mtd@lists.infradead.org>, "Takahiro Kuwano" <tkuw584924@gmail.com>,
 "Takahiro Kuwano" <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v7] dt-bindings: mtd: spi-nor: add optional interrupts
 property
X-Mailer: aerc 0.16.0
References: <20240219-mtd-flash-interrupt-binding-v7-1-206e30a656fa@solid-run.com> <CZAM553H2H56.2TDN36QEL90XX@kernel.org> <a0144c5b-4095-4a0c-84b6-93dfe9631a6b@solid-run.com>
In-Reply-To: <a0144c5b-4095-4a0c-84b6-93dfe9631a6b@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--e9f867f281deaf04305f7f7b113436157ecc73b10b85215ac510f5eb30ca
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

[+ Takahiro]

Hi,

On Wed Feb 21, 2024 at 10:13 AM CET, Josua Mayer wrote:
> Hi,
>
> Am 21.02.24 um 09:27 schrieb Michael Walle:
> > Hi,
> >
> > On Mon Feb 19, 2024 at 3:41 PM CET, Josua Mayer wrote:
> >> Some spi flash memories have an interrupt signal which can be used for
> >> signalling on-chip events such as busy status or ecc errors to the hos=
t.
> > Do you have an example? Maybe one with a public datasheet?
>
> My example is Infineon S28HS512T, however datasheet download requires=20
> user account.
>
> S26HS512T has interrupt line, too, and datasheet is downloadable without=
=20
> registration:
> https://www.infineon.com/cms/en/product/memories/nor-flash/semper-nor-fla=
sh-family/semper-nor-flash/#!documents

Thanks, as far as I can see, both are hyperbus flashes. I'm asking
because I'm not aware of any SPI NOR flash with an interrupt line.=20

-michael

--e9f867f281deaf04305f7f7b113436157ecc73b10b85215ac510f5eb30ca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZdXBDRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvsMiwEAjOqBidGogjxPHhp8y+blJyfOYdrapFQv
ZY95qF3u2uIBAP+EXR9ovlBJIAjMCkirhifr2qt6x005yRPmB2mlhi8N
=iSVx
-----END PGP SIGNATURE-----

--e9f867f281deaf04305f7f7b113436157ecc73b10b85215ac510f5eb30ca--

