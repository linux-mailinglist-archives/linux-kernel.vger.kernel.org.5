Return-Path: <linux-kernel+bounces-109244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D4F8816AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283111F2453E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EBE6A34D;
	Wed, 20 Mar 2024 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GC+QjOLg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CBD1DFC6;
	Wed, 20 Mar 2024 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956359; cv=none; b=KDuJjOXuy7SVeNiGssaB/ni8Go/AJeQNR/YYVkN4byLZwQ/OVQkkHnf9xF1aHiKUhhctk25TtfGdHVYF4Eeq22/4aJbGDgR/jwgxuDhn8qJDHvoxrQkU/hNtR/Icly0HPwbjBiQJiBvtFYil8nsg2JiVIcE9zJRgDf76B7DNN1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956359; c=relaxed/simple;
	bh=+I4HwwOXGb4OTVbce2LLwgvNTP55VKW3XPSef7uX2qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLwBvoavBLUkH22j+ASMWlatlw8683ysi9w8Crzj8A2OOIRaIXJ8fkhnQ76dWKzLnMCkWSutzO1eS0aDECuJsebNHbhhdE5mMg3l1duiC3qmQkGS7iORhUA9G6h1sWTKWbUsWIaeSCrZPaNctAx5PHHaLBbuPcu6Rnsmkzs1H0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GC+QjOLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0D2C43390;
	Wed, 20 Mar 2024 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710956359;
	bh=+I4HwwOXGb4OTVbce2LLwgvNTP55VKW3XPSef7uX2qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GC+QjOLgCWd2xCHOfgGMVLPcEchWO055AePCNCuub4yNELWCDEJ2LXQ3wPuRdpWbW
	 6zS68GkufurAmzHXJlPukCgGffKZAKhn+BvCVZPh1uGOc1x/3fGAaUBVf43pX1j12a
	 6PPBA0loQz+7M3ep5XFYftdWyRq5doQVVKGb7R71FC339a0qTOT9MOPScoxWDvAfk2
	 mILf4BeGvDnmqNZXxVxGIiGFRJgVPwP6t2c+jtrls1bi9cFsjEw4+GmojQkAcACnx9
	 fBXDs4BFv+7RtocNzFtYxn/akzVicQYhk6V0cEuODsLqzVhR+WkurDG9G1dCMjxzED
	 FOi9lFYlChCtA==
Date: Wed, 20 Mar 2024 17:39:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: Conor Dooley <conor.dooley@microchip.com>, Guo Ren <guoren@kernel.org>,
	linux-riscv@lists.infradead.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/7] riscv: Kconfig.socs: Split ARCH_CANAAN and
 SOC_CANAAN_K210
Message-ID: <20240320-ideology-pasty-d3aea07cc519@spud>
References: <tencent_FC10B3C630BE27412FED2547245CBE18D807@qq.com>
 <tencent_6F35FEF31908DE6AEB385AE30AC658863C0A@qq.com>
 <CAJF2gTS1-VQP=gQBx=SoUWsdap153EGOObKVn+2L7=kbP2CqFg@mail.gmail.com>
 <20240306-scowling-mortify-9b427c80e8ab@wendy>
 <tencent_91E604E3B4D51DA37045625242A81B07F909@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7hxDktwiGEbdrYmU"
Content-Disposition: inline
In-Reply-To: <tencent_91E604E3B4D51DA37045625242A81B07F909@qq.com>


--7hxDktwiGEbdrYmU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 04:14:33PM +0800, Yangyu Chen wrote:
>=20
>=20
> > On Mar 6, 2024, at 16:01, Conor Dooley <conor.dooley@microchip.com> wro=
te:
> >=20
> > On Wed, Mar 06, 2024 at 07:38:52AM +0800, Guo Ren wrote:
> >=20
> >> On Wed, Mar 6, 2024 at 7:04=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> =
wrote:
> >>>=20
> >>> Since we have Canaan Kendryte K230 with MMU now. The use of SOC_CANAAN
> >>> is no longer only referred to K210. Split them and add _K210 suffix
> >>> to the name for old SOC_CANAAN. And allows ARCH_CANAAN to be selected
> >>> for other Canaan SoCs.
> >>>=20
> >>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> >>> ---
> >>> arch/riscv/Kconfig.socs                        | 8 +++++---
> >>> arch/riscv/Makefile                            | 2 +-
> >>> arch/riscv/configs/nommu_k210_defconfig        | 3 ++-
> >>> arch/riscv/configs/nommu_k210_sdcard_defconfig | 3 ++-
> >>> drivers/clk/Kconfig                            | 4 ++--
> >>> drivers/pinctrl/Kconfig                        | 4 ++--
> >>> drivers/reset/Kconfig                          | 4 ++--
> >>> drivers/soc/Makefile                           | 2 +-
> >>> drivers/soc/canaan/Kconfig                     | 4 ++--
> >>> 9 files changed, 19 insertions(+), 15 deletions(-)
> >=20
> >> This patch cross so many subsystems, I am not sure about it. If I were
> >> you, I would keep SOC_CANAAN and just add SOC_CANAAN_K230.
> >=20
> > Right. That is why I didn't try to rename the symbol, and just left it
> > as SOC_CANAAN, but if the relevant people ack it, the chances of a
> > significant conflict are low.
> >=20
>=20
> Maybe I should split this patch into different subsystems for better
> review. I think at least drivers/soc/Makefile should changed to use
> ARCH_CANAAN. Because we need some SoC drivers for K230 in the future.
> And arch/riscv/Makefile should use SOC_CANAAN_K210 instead of
> ARCH_CANAAN.  Because we should avoid the M-Mode loader build for
> other Canaan SoCs except for K210.

It seems like what Damien requested is pretty much what's done here.
Can you resend this CCing the maintainers for clk pinctrl and reset?
If you leave a note under the --- line in this patch about wanting acks
to take this via riscv, I don't mind picking up this treewide patch if
the individual maintainers ack it. I don't think there's likely to be a
significant conflict caused by it going through one tree.

I got a k230 board (the canmv one) so I should be able to test this
myself before picking stuff up.

Cheers,
Conor.

--7hxDktwiGEbdrYmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfsfQgAKCRB4tDGHoIJi
0qhpAP0bH5dwSrdhtgZy8odymGeXP5Eu/mXODpURg5Zun0lG/AD9Fuz5Yc320STN
idBImdOU5uB7YmUXP6mjgPn82j0uvwY=
=j7D0
-----END PGP SIGNATURE-----

--7hxDktwiGEbdrYmU--

