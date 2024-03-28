Return-Path: <linux-kernel+bounces-123366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAA4890731
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0F029ADA2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183F412DDAF;
	Thu, 28 Mar 2024 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P23qjp0j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4A7F46F;
	Thu, 28 Mar 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646993; cv=none; b=rtsjIZhpWc7BbjYOaKkDkWDw3M+mGgwHZ5FmBWKUh4MtEq+6IYROuX7BoS8/6ubgEGdnjQmsTy6HCT8UFjZ6a0fK9AEn5iWFmzqQd9/N/woRMOLxQkrgEsacWDZja6k05p0mpJSbABkM/0HEtHxs0nIOUV19z7HxbQem8sRK4EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646993; c=relaxed/simple;
	bh=2yjXG1cxcOLRAQQFD2MmlXzfBTpxi8yuDIP1YvTVo1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5ZllLRWOSkwEbj0o6hQT4Fh5/FBas2Tm6K85BnrFqXs4bt56Lt/Ylj5LtiN0E5hMqA3kZBHmI8rguLA+eVs0kWCtqELICk1X99Y8YPBa8zJ8YzLsKO9Lt4WyWtqDuFhsN2+R/skL/HOCPglgARSfCH562/7LXDRiSZZsZRoY38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P23qjp0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD47CC433C7;
	Thu, 28 Mar 2024 17:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711646992;
	bh=2yjXG1cxcOLRAQQFD2MmlXzfBTpxi8yuDIP1YvTVo1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P23qjp0jZGrt5nB7AvifCFT26FEKuPDGE1gQPhQ9VG7LDmaJZZubXdTjGL3d8g+0z
	 1/W5PgJOr5RtSDp9S0Pu+iADL8NZ7oMTIcXQ3W3Qh1AgvSYUQ70+EY6mkS8x3SvhjG
	 oVWyZOzRj5V4S4vWvNWu44YjcJYHsnyhoTiNNCLO4CbfBVBuZSm3qX89V48RF8tlwh
	 aOVWX1QukpiYy3BfhRkyfdwg5PSTwCuDO7E7JXsSs81XUWzTMSsoQTyqhywubf1IFc
	 C55lYbOzdO/GjNDAwX8FqZXrtTa0rOwIKDv0LNPTOjEoLW/1CBN3rP494bU1R5RsqM
	 OO7eUgnD4v3gQ==
Date: Thu, 28 Mar 2024 17:29:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] riscv: Kconfig.socs: Deprecate SOC_CANAAN and use
 SOC_CANAAN_K210 for K210
Message-ID: <20240328-daytime-hankie-41a57ad9fbce@spud>
References: <tencent_2E60E33C1F88A090B6B3A332AE528C6B8806@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rTpquQ6Zk9VYNr0B"
Content-Disposition: inline
In-Reply-To: <tencent_2E60E33C1F88A090B6B3A332AE528C6B8806@qq.com>


--rTpquQ6Zk9VYNr0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yangyu,

And Linus/Stephen/Philipp I guess!

On Fri, Mar 29, 2024 at 01:03:22AM +0800, Yangyu Chen wrote:
> Since SOC_FOO should be deprecated from patch [1], and cleanup for other
> SoCs is already in the mailing list [2,3,4], so we deprecate the use of
> SOC_CANAAN and use ARCH_CANAAN for SoCs vendored by Canaan instead from n=
ow
> on.
>=20
> However, the K210 SoC is so special for NoMMU and built for loader.bin, if
> we share the ARCH_CANAAN symbol directly for K210 and other new SoCs which
> has MMU and no need for loader, it will confuse some users who may try to
> boot MMU Kernel on K210, but it will fail. Thus, this patch set renamed t=
he
> original use of SOC_CANAAN to SOC_CANAAN_K210 for K210 SoC, as Damien
> suggested from the list [5]. Then, it made some adaptations for soc, clk,
> pinctrl, and reset drivers.
>=20
> Note: This patch set is used to prepare for Canaan K230 Support, which is
> on the mailing list [6]. The next revision for the K230 support patch will
> be based on this patch set.

Please, if you don't completely understand what I tell you to do, ask me
to clarify. Asking for more information on what to do is not a problem,
it saves effort for everyone if you ask rather than submit another
version. This patchset has the same sort of problem as was pointed
out on the v5 and v6 of the k230 support.
All patches in this series must go through the same tree, if they don't
then the relevant drivers will not compile in the subsystem trees. As
the new symbol will not be defined there. This is why I said that you
should solicit acks from the subsystem maintainers to take this all via
the soc tree - but you do have to explicitly ask for them! I suggested
doing it under the --- line in each patch, as often maintainers ignore
the parts of a series that do not involve them (I know I do this with
dt-bindings *all* the time).

The only way this works without taking everything via one tree is if we
introduce ARCH_CANAAN for 6.10-rc1, switch every driver subsystem over in
6.11-rc1 and then delete the Kconfig symbol after 6.11-rc1. Although I
also waited with my SOC_FOO symbol removals because I wanted the
ARCH_FOO symbols to propagate into .configs, I followed the process
above so that things could be taken into subsystem trees without
preventing building the drivers.

I'm perfectly happy to take the whole series via the soc tree, but I need
acks on the clk, pinctrl and reset patches before I can do that.

Thanks,
Conor.

> [1] https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@ker=
nel.org/
> [2] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7ed0=
a@spud/
> [3] https://lore.kernel.org/linux-riscv/20240305-fled-undrilled-41dc0c46b=
b29@spud/
> [4] https://lore.kernel.org/linux-riscv/20240305-stress-earflap-d7ddb8655=
a4d@spud/
> [5] https://lore.kernel.org/linux-riscv/2b0511af-1b5b-4c90-a673-c9113bb58=
142@kernel.org/
> [6] https://lore.kernel.org/linux-riscv/tencent_F76EB8D731C521C18D5D7C4F8=
229DAA58E08@qq.com/
>=20
> Yangyu Chen (5):
>   riscv: Kconfig.socs: Split ARCH_CANAAN and SOC_CANAAN_K210
>   soc: canaan: Deprecate SOC_CANAAN and use SOC_CANAAN_K210 for K210
>   clk: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
>   pinctrl: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
>   reset: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
>=20
>  arch/riscv/Kconfig.socs                        | 10 ++++++++--
>  arch/riscv/Makefile                            |  2 +-
>  arch/riscv/configs/nommu_k210_defconfig        |  3 ++-
>  arch/riscv/configs/nommu_k210_sdcard_defconfig |  3 ++-
>  drivers/clk/Kconfig                            |  4 ++--
>  drivers/pinctrl/Kconfig                        |  4 ++--
>  drivers/reset/Kconfig                          |  4 ++--
>  drivers/soc/Makefile                           |  2 +-
>  drivers/soc/canaan/Kconfig                     |  4 ++--
>  9 files changed, 22 insertions(+), 14 deletions(-)
>=20
> --=20
> 2.43.0
>=20

--rTpquQ6Zk9VYNr0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgWpCwAKCRB4tDGHoIJi
0vSiAP46u8BBoQ4Q2gEfklZZQYfm0Iqp6XLECwPL/erieG3qeAD/Z/ajVOOOn2gC
HdoMbj86rCTOUylDh4k+rOt91693IAM=
=b+GD
-----END PGP SIGNATURE-----

--rTpquQ6Zk9VYNr0B--

