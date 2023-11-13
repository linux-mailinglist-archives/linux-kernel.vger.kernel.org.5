Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0607E9CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjKMNOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjKMNOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:14:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C3FD7E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:14:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2109CC433C8;
        Mon, 13 Nov 2023 13:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699881278;
        bh=EtMfTCKsUg7ufBalhxFNF8jrs+peRdy0cY2hZzRhWmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nS7ZNMw0hmdXGtW9w0SMYVBq4p59yvF5bYxvk/T84uxjzZf4zpFYR2Ozd7OH2gTCz
         u2AqN6RpKU4MZp/AkMYYpbeRp3zMOpry8A4u+d/t4zz47VuOUn+TtpUhPVsdG81X0E
         L0m7EAeVjdkCdzGXaXqPsWSNOGYOb51/E8G/YyTHFtEz7ujWpSSqWXjL0ZUqyq+ecN
         a9H9EGuWSJw+5DItCmAI5N7bJP5e9hRB0euEJfdiw6PM7LPeGUrL/FVrJc0Ls1U8m9
         CaqJQhoCyQIo5oI++GMPhggi9LWuB0tP0YzouBFu1To6wLb+VtEj89fAX48qkQdQAT
         uCMFAS8aTnMyw==
Date:   Mon, 13 Nov 2023 13:14:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: remove address-cells from CV1800B
 intc node
Message-ID: <20231113-portable-garnet-8a04dbb71b51@squawk>
References: <IA1PR20MB49532613F5B4BD9753A1BB4DBBB3A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HnJ3G1ILUKIB0LMn"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49532613F5B4BD9753A1BB4DBBB3A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HnJ3G1ILUKIB0LMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 05:26:15PM +0800, Inochi Amaoto wrote:
> A recent submission from Rob has added additionalProperties: false
> to the interrupt-controller child node of RISC-V cpus. But CV1800B does
> not follow this change and still uses #address-cells in its interrupt
> controller. As it has no child nodes, #address-cells is not needed and
> can be removed.
>=20
> Fixes: c3dffa879cca ("riscv: dts: sophgo: add initial CV1800B SoC device =
tree")
> Link: https://patchwork.kernel.org/project/linux-riscv/patch/202309152019=
46.4184468-1-robh@kernel.org/

This is a dupe of a patch I already applied, but have not yet sent a PR
for:
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?h=
=3Driscv-dt-for-next&id=3Db99df62818919b84e970eea5aec60b0dbc57da18

Cheers,
Conor.

>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dt=
s/sophgo/cv1800b.dtsi
> index df40e87ee063..aec6401a467b 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -34,7 +34,6 @@ cpu0: cpu@0 {
>  			cpu0_intc: interrupt-controller {
>  				compatible =3D "riscv,cpu-intc";
>  				interrupt-controller;
> -				#address-cells =3D <0>;
>  				#interrupt-cells =3D <1>;
>  			};
>  		};
> --
> 2.42.1
>=20

--HnJ3G1ILUKIB0LMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVIhNwAKCRB4tDGHoIJi
0rkAAQCDRGINzffMT6MvCnhOlveVMvDNHnDgSN+m8Wjdp5iJ6gD/Zh+u83XnVzPH
evBzqZTo5OoPvBJr4cZdAXjyS7KMPgY=
=Kphh
-----END PGP SIGNATURE-----

--HnJ3G1ILUKIB0LMn--
