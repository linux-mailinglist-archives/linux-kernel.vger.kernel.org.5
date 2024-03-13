Return-Path: <linux-kernel+bounces-102279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6429E87B020
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5731C26029
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A412EBE2;
	Wed, 13 Mar 2024 17:38:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9B2634FB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351494; cv=none; b=OffmqXPu0lrdO3X4bRhcj7NoZyRy+geL0CaL5Z3LM+Dc1bb1KwHOrSefbv+kPuQZB9nHz9dCZUIQ1uWYiUxqn0tbCtcWFmHW6ev+bEpy6mF34A5ZbX2/vcFyqZXYyP5oGD9FCQKXlLb2XA6kLTEKBS4vezeUZGkcbtgA+Pybusg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351494; c=relaxed/simple;
	bh=Po+4lA1wENmeWL/NswnAViySKzXpp/YmiQdUG3AAD3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4RJKHxCnWljuJtdfkjl8P2R+Q8ffX71618yK96uovydaWuwbudu9HL8+qulwiovTBwkh0692HmB7LHRsHX7mrR2f4eEIyTmL1jFbknnscd/6XEvVLqhQaIMIIeueUFpBioOvos5qOwWuy20Jwbzv7m15zLbMXDj1MZ7BQUBPog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD6801007;
	Wed, 13 Mar 2024 10:38:48 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E8533F73F;
	Wed, 13 Mar 2024 10:38:11 -0700 (PDT)
Date: Wed, 13 Mar 2024 17:38:08 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: wens@csie.org, samuel@sholland.org, Kamil Kasperski
 <ressetkk@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dts: arm64: sunxi: add initial support for t95 tv
 box
Message-ID: <20240313173808.38d893b5@donnerap.manchester.arm.com>
In-Reply-To: <13468418.uLZWGnKmhe@jernej-laptop>
References: <20240311174750.6428-1-ressetkk@gmail.com>
	<13468418.uLZWGnKmhe@jernej-laptop>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Mar 2024 18:25:14 +0100
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

> Hi Kamil!
>=20
> Dne ponedeljek, 11. marec 2024 ob 18:47:47 CET je Kamil Kasperski napisal=
(a):
> > T95 is a most commonly known for being a box with a pre-installed malwa=
re.
> > It uses Allwinner H616 and comes with eMMC and DDR3 memory.
> > This device comes with two versions - one with AXP305 PMIC and another =
with AXP313 PMIC. =20
>=20
> I have this board and it always felt like a clone of X96 Mate, which is
> already supported in kernel, except for broken sd card detection. Would it
> make sense to unify those two boards and just overwrite or update parts h=
ere
> that are not the same?

I think the box you have is an older one, with the AXP305? IIUC, this is
about a newer revision with the AXP313. There are quite some differences
between the two PMICs, though it might still make sense to share the DTs,
see the OrangePi Zero[23].

Cheers,
Andre

> > Kamil Kasperski (3):
> >   dt-bindings: vendor-prefixes: sunxi: add T95 to vendor-prefixes
> >   dt-bindings: arm: sunxi: add t95 compatible string to list of known
> >     boards
> >   dts: arm64: sunxi: add initial support for T95 AXP313 tv box
> >=20
> >  .../devicetree/bindings/arm/sunxi.yaml        |   5 +
> >  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
> >  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
> >  .../dts/allwinner/sun50i-h616-t95-axp313.dts  | 138 ++++++++++++++++++
> >  4 files changed, 146 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-t95-axp31=
3.dts
> >=20
> >  =20
>=20
>=20
>=20
>=20
>=20


