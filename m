Return-Path: <linux-kernel+bounces-67310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C0C856995
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7F74B21FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC673134CC4;
	Thu, 15 Feb 2024 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1nLqiiP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A738134739;
	Thu, 15 Feb 2024 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708014586; cv=none; b=OlnIfmsBvlwfw7jypr3N7ekLu8NLNIdMgvF1iQtmnXJnH3HnxQzof1MiDi72IUNJS0PVzGeziFGF5Ot62fvP49s1ORxSAXy+OGVVwlA/927H595tY+haW1ZH2X0QAE3RJN0WRuXRg4mAcRYmtT7skVwWGhiy8VLw3oytvfLAKjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708014586; c=relaxed/simple;
	bh=xpMCGqwTxgUJyuySQdpmgx/+9jeLznpOpOU3fi5NUlw=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=I9hbivp3L8Uy7L7ZSJszxn/YoHV+WzYtYkfExvk6npCKHwbazFTvBWJdzqsVvc7cAvqhhHzWvn59+xa5CR+UhhtorcTv44YXhozAIn/1Up3b8xB/wuoPaHXo+VG7N/Qsc0UvQXSJEPySVbH0snqEJUqiqFQqikdpF9mPq4EJOmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1nLqiiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3ECC433F1;
	Thu, 15 Feb 2024 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708014585;
	bh=xpMCGqwTxgUJyuySQdpmgx/+9jeLznpOpOU3fi5NUlw=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=s1nLqiiPVk4EeZbWMEb93s1oFad4QsucBcR5DtkpsSl2RCAwsjmYK662tUsXHN3kj
	 aBVTiNgVslX8e75hX4vznqC1kL+2z126Gczfvu6oHByBV1XA68r/h90+Tf2AUSOWgt
	 exQblEzu2gpC9V7wT71ewdnaNu9MzdmsDh8wY9WBy4iS5baUFrM6libK3aif+p5EKr
	 5D6KTuXxvk53i9Wruq2TVqq9UtRcGiB3PB8s2LpnnLRDJ5TUL/4hbzJgdnB7PfYX7v
	 RZueBdOKMBr/REVPprmArSHuRnZoyDZKjNtWi70cyqmyi1Wzia9pG8zZ3FLGKB2Vip
	 PBca0AuNItqsg==
Content-Type: multipart/signed;
 boundary=d8fe15f87fbebbfb1a05ad0234592c7c1f29a5ff64a6a3d68c8a574e83bd;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Thu, 15 Feb 2024 17:29:42 +0100
Message-Id: <CZ5SMYXNTTOP.3MZ8P9N5BY4SH@kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: Add support for TI J722S
 Evaluation Module
Cc: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <j-choudhary@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Vignesh Raghavendra" <vigneshr@ti.com>, "Vaishnav Achath"
 <vaishnav.a@ti.com>, "Andrew Davis" <afd@ti.com>, <nm@ti.com>,
 <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <kristo@kernel.org>, <robh+dt@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240206100608.127702-1-vaishnav.a@ti.com>
 <20240206100608.127702-4-vaishnav.a@ti.com>
 <CZ386ITQ83KH.1KNOV5MXLXPBF@kernel.org>
 <45bd5618-2e22-4715-9724-92f1d4b84608@ti.com>
 <40e15761-70b3-4343-a4b3-653bc4e6637e@ti.com>
In-Reply-To: <40e15761-70b3-4343-a4b3-653bc4e6637e@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--d8fe15f87fbebbfb1a05ad0234592c7c1f29a5ff64a6a3d68c8a574e83bd
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Feb 14, 2024 at 10:42 AM CET, Vignesh Raghavendra wrote:
> On 14/02/24 13:13, Vaishnav Achath wrote:
> > On 12/02/24 21:32, Michael Walle wrote:
> >> On Tue Feb 6, 2024 at 11:06 AM CET, Vaishnav Achath wrote:
> >>> +# Boards with J722s SoC
> >>> +dtb-$(CONFIG_ARCH_K3) +=3D k3-j722s-evm.dtb
> >>
> >> I'm a bit confused by your names. What are the new/correct ones now?
> >> Some seem to use the amXX names and some the jXX ones. I've read [1]
> >> and it appears it was suggested to use the am67 names for the device
> >> trees. Esp. because there is already, am62, am64, am65, am68 and
> >> am69 in as names for the device trees.
> >>
> >> The TRM you've linked in the cover letter doesn't shed much light
> >> either. It just lists both.
> >>
> >=20
> > Both names are correct, for other Jacinto devices J721S2 and J784S4, th=
e
> > industrial variants (AM68, AM69 respectively) and those boards were
> > announced at a later point of time and since the automotive/J7 variants
> > were introduced first, the SoC dtsi and files have the J7XX names, for
> > AM62/AM64 there is no confusion in naming, in this case the initial TRM
> > itself mentions J722S and AM67 variants with similar capabilities, the
> > reasoning behind continuing with the J722S name is because the initial
> > support is being added for J722S EVM (the top marking on the SoC packag=
e
> > populated on the EVM say XJ722SAMW, this can be seen in the schematics
> > also), please let know if this clarifies the confusion.
> >=20
>
> AM64,AM62x/A/P are from different product line (Sitara) and don't have
> any other aliases.
>
> On the other hand, Jacinto SoCs have both J7xx variant and AM6xx part
> numbers. Its being really unpredictable wrt when AM6xx variants of
> Jacinto devices come out. So as a general rule, we name the DTS files
> based on the name of the first device that comes out in the market which
> has consistently been J7xx.

Thanks for the explanation. I just noticed that any k3-am6[89]*
device trees will include the j7xx SoC dtsi. That would have been my
next question: Boards with the AMxx will have the "correct" name
k3-amNN-*.

-michael

--d8fe15f87fbebbfb1a05ad0234592c7c1f29a5ff64a6a3d68c8a574e83bd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZc479hIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvtvBAD/Q6zUsGrsdv2dI2Lie45k5Qcf7kNAr1qK
LgqLuy/NP4ABAM+pdNE3IZ1Y5tNuoJ7txSvxjr4/Ns+fFKB88i39r+UL
=LpmB
-----END PGP SIGNATURE-----

--d8fe15f87fbebbfb1a05ad0234592c7c1f29a5ff64a6a3d68c8a574e83bd--

