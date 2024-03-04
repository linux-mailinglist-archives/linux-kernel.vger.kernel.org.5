Return-Path: <linux-kernel+bounces-91245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58041870BAF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13424282316
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07AC947B;
	Mon,  4 Mar 2024 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrMQbhOg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F06FA9;
	Mon,  4 Mar 2024 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584590; cv=none; b=fo37tCuIx8kRSIJeBmHUVRBXblfbW7AEp2Rh/WOZSVIYFJOV+N0b1nPAUfH7LTfYlb3a8G/9xfWajGina0jewskpgBjaNfXdNcQs0ePsfkKKwqDPkek20O6+x9h47Ayc2XdkqNwedx3nFwoGSeXzYPvOwbyg1OPr1dr9+WFuR30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584590; c=relaxed/simple;
	bh=0MMHl+OHCBfHGKLKr5DEkaaBTXQ5Ns3AsiLeg4LasPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B57dxO9gVrgI2S5HSrcCEWu8RGcp8TsWrVrpNDSKn53kBJcb26vBt5qjUnfSzLtUqXxJZqFTffia+VasacnWsWGGDF13MaRoEf4NROm9m3yt6MFALIGMWPL8fQddITwLdiSuxogTUw4QxCa29gePUBt1tOEqS+zstFo2JxIMyTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrMQbhOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C80C433F1;
	Mon,  4 Mar 2024 20:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709584589;
	bh=0MMHl+OHCBfHGKLKr5DEkaaBTXQ5Ns3AsiLeg4LasPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RrMQbhOgk1XVUmA/6WJP4ULh44AdnpAOnO0Cv0x3bNyjccbZz417cadgkdWkTUPyR
	 GwR5rlFpeoIqJ6nNj1xCQzmRUixk0gMNLjtsA0vxf9FmccKTsPNKRoTInjJw9evC7M
	 duXjunpcgu9ZBTVdzhKEDJ/dugKjlNk378Cj/WvdlXsM2jv9s8kJxjkS0x1tj+hlTU
	 u7syGomBNyb53bhJDzK1Fj+rThut84LRMXbPyQjQ3+jqvJEaaYq3CpYQEZligti6O+
	 jYDPEwzS1UUemkWO1+h3jLEp5KLIxMxwVg8CGmbtoLX0UHXI4wBHRcVWF9X0fy0dk4
	 wJAJaleEuxJUA==
Date: Mon, 4 Mar 2024 20:36:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] riscv: config: enable SOC_CANAAN in defconfig
Message-ID: <20240304-collie-approach-80d0de4dc7da@spud>
References: <tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com>
 <tencent_FE1B7BF85E04C1B5C51D7F707D6204436809@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hLLOp79WaqibcIfJ"
Content-Disposition: inline
In-Reply-To: <tencent_FE1B7BF85E04C1B5C51D7F707D6204436809@qq.com>


--hLLOp79WaqibcIfJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 11:16:26PM +0800, Yangyu Chen wrote:
> Since K230 has been supported, allow SOC_CANAAN to be selected to build dt
> and drivers for it in defconfig.
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  arch/riscv/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 89a009a580fe..20b557ec28df 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -33,6 +33,7 @@ CONFIG_SOC_STARFIVE=3Dy
>  CONFIG_ARCH_SUNXI=3Dy
>  CONFIG_ARCH_THEAD=3Dy
>  CONFIG_SOC_VIRT=3Dy
> +CONFIG_SOC_CANAAN=3Dy
>  CONFIG_SMP=3Dy
>  CONFIG_HOTPLUG_CPU=3Dy
>  CONFIG_PM=3Dy
> --=20
> 2.43.0
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--hLLOp79WaqibcIfJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeYwyAAKCRB4tDGHoIJi
0v4LAP9ovsOm8/L+g9X/8QH+JrVVrJcdIk6eA4275kf9T/KF+gEA62x/SzJ0+UPT
mfI6sWHCa72hDfjRlU6Ji0X1CNqZiAE=
=2mwa
-----END PGP SIGNATURE-----

--hLLOp79WaqibcIfJ--

