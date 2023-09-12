Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8F579D640
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbjILQ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjILQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:27:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EAF115;
        Tue, 12 Sep 2023 09:27:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92E2C433C7;
        Tue, 12 Sep 2023 16:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694536056;
        bh=bv7Iv5VgHVPJ6lM+M2Zxb2Yans87pWgfeZ8AlEiNrz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lILXc5E4FhEYv8fuvDsGkuvHJ2DnFl+NMUfeMJafGAz3mfJzrp4uvSRpEoiO63GdW
         2uKvPxhP3JKXVy9o54F/+cL0MDEFZYXlzA0HnIFPdG1VhnfuJSCN0OyLFxM63p7ZvG
         F/OrOHGc+pLF9KC8CdALvdswKGB+GR1EAZjiLxkn7+kuV815G0Vf8vS55ryVWws5CI
         YmSLe2gG+kzn8lrfigUTdPFXa8mwDw5JT/c1RuWftTfsYSj0ssHcK+z0zUeyaVSE3Z
         biGdhtjaNY/miUV+o5UNPLiRwO5O+NSn3xP3EFR2VUiko3t3UuJyqJzOMZauTSKem4
         FEsuuB/lEq5Iw==
Date:   Tue, 12 Sep 2023 17:27:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
Subject: Re: [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus
Message-ID: <20230912-trailing-pampered-52738ec6f009@spud>
References: <20230912072232.2455-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DcZx3Ial+vgjWY0d"
Content-Disposition: inline
In-Reply-To: <20230912072232.2455-1-jszhang@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DcZx3Ial+vgjWY0d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 03:22:32PM +0800, Jisheng Zhang wrote:
> riscv select ARCH_DMA_DEFAULT_COHERENT by default, and th1520 isn't
> dma coherent, so set dma-noncoherent to reflect this fact.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Tested-by: Drew Fustini <dfustini@baylibre.com>
> ---
>=20
> Since v1:
>  - rebase on v6.6-rc1
>  - collect Tested-by tag

Does this mean you're expecting me to take this?

>=20
>  arch/riscv/boot/dts/thead/th1520.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/=
thead/th1520.dtsi
> index ce708183b6f6..ff364709a6df 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -139,6 +139,7 @@ soc {
>  		interrupt-parent =3D <&plic>;
>  		#address-cells =3D <2>;
>  		#size-cells =3D <2>;
> +		dma-noncoherent;
>  		ranges;
> =20
>  		plic: interrupt-controller@ffd8000000 {
> --=20
> 2.40.1
>=20

--DcZx3Ial+vgjWY0d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQCRcwAKCRB4tDGHoIJi
0uF4AQCC0yGFWykN5lVA7ttKf7xI/KAt2zqKey5loUVcTCKeewEA/Qu3oqmy+WyO
C5iFFtyyupU0IxGU5PkxjcPqACgjOAI=
=jBrY
-----END PGP SIGNATURE-----

--DcZx3Ial+vgjWY0d--
