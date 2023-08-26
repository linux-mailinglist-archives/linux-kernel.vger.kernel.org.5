Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9097578951A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 11:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjHZJ2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 05:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjHZJ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 05:28:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45D01BCC;
        Sat, 26 Aug 2023 02:28:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 384EF60C3F;
        Sat, 26 Aug 2023 09:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE7CC433C8;
        Sat, 26 Aug 2023 09:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693042126;
        bh=YxxISRt1nikCjFmpxDviziNud+rrOQ+XHWWA42FDTrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mKJTrskegf5j6cRlOf+FyVjKHzoB2Hi9ULPscnuoPdq70iwfinPGT+8ipA3Qykxbc
         dNu7EeqPpn6Sy0FL0htDoE6HSBssx1I2zGZ7ScZwfxXIh7257Rwicpgp7oZx9PTXKY
         m11cOxvmI4BETAdWvpvWmwfL4EIgYjy9iy7MXbZ3P5WFYn2D+aZDjhC0ggElVGz5oE
         xvzUW7BJwrQ2AxzRz1lhUey5nbFlOCEh9gjSDexy7osYDSP81Gq4uykvtuQpDC2c/g
         nJf2F9nUwr07lwGWgCBzEvApkgDjcArUeVOCBsP9SBYgBKc8LAkxmtOcwnNtpLLUz3
         8zy5fRGy46jTg==
Date:   Sat, 26 Aug 2023 10:28:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>, Wei Fu <wefu@redhat.com>,
        Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: allwinner: d1: Add PMU event node
Message-ID: <20230826-reverse-unroll-a2e0b2365dc1@spud>
References: <IA1PR20MB495310F06009AA884D0612A1BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0pBAAiuXuzC5EtR1"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB495310F06009AA884D0612A1BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0pBAAiuXuzC5EtR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 26, 2023 at 04:38:53PM +0800, Inochi Amaoto wrote:
> D1 has several pmu events supported by opensbi.
> These events can be used by perf for profiling.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>

Could you please include a link to some documentation as to where these
values came from? I know several people have had some trouble with
understanding the pmu DT stuff & having some documentation would make
this an in-tree end-to-end example.

Thanks,
Conor.

> ---
>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/b=
oot/dts/allwinner/sun20i-d1s.dtsi
> index 8275630af977..d9031ccdec89 100644
> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> @@ -72,5 +72,45 @@ plic: interrupt-controller@10000000 {
>  			#address-cells =3D <0>;
>  			#interrupt-cells =3D <2>;
>  		};
> +
> +		pmu {
> +			compatible =3D "riscv,pmu";
> +			riscv,event-to-mhpmcounters =3D
> +				<0x00003 0x00003 0x00000008>,
> +				<0x00004 0x00004 0x00000010>,
> +				<0x00005 0x00005 0x00000200>,
> +				<0x00006 0x00006 0x00000100>,
> +				<0x10000 0x10000 0x00004000>,
> +				<0x10001 0x10001 0x00008000>,
> +				<0x10002 0x10002 0x00010000>,
> +				<0x10003 0x10003 0x00020000>,
> +				<0x10019 0x10019 0x00000040>,
> +				<0x10021 0x10021 0x00000020>;
> +			riscv,event-to-mhpmevent =3D
> +				<0x00003 0x00000000 0x00000001>,
> +				<0x00004 0x00000000 0x00000002>,
> +				<0x00005 0x00000000 0x00000007>,
> +				<0x00006 0x00000000 0x00000006>,
> +				<0x0000a 0x00000000 0x0000000b>,
> +				<0x10000 0x00000000 0x0000000c>,
> +				<0x10001 0x00000000 0x0000000d>,
> +				<0x10002 0x00000000 0x0000000e>,
> +				<0x10003 0x00000000 0x0000000f>,
> +				<0x10019 0x00000000 0x00000004>,
> +				<0x10021 0x00000000 0x00000003>;
> +			riscv,raw-event-to-mhpmcounters =3D
> +				<0x00000000 0x00000001 0xffffffff 0xffffffff 0x00000008>,
> +				<0x00000000 0x00000002 0xffffffff 0xffffffff 0x00000010>,
> +				<0x00000000 0x00000003 0xffffffff 0xffffffff 0x00000020>,
> +				<0x00000000 0x00000004 0xffffffff 0xffffffff 0x00000040>,
> +				<0x00000000 0x00000005 0xffffffff 0xffffffff 0x00000080>,
> +				<0x00000000 0x00000006 0xffffffff 0xffffffff 0x00000100>,
> +				<0x00000000 0x00000007 0xffffffff 0xffffffff 0x00000200>,
> +				<0x00000000 0x0000000b 0xffffffff 0xffffffff 0x00002000>,
> +				<0x00000000 0x0000000c 0xffffffff 0xffffffff 0x00004000>,
> +				<0x00000000 0x0000000d 0xffffffff 0xffffffff 0x00008000>,
> +				<0x00000000 0x0000000e 0xffffffff 0xffffffff 0x00010000>,
> +				<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>;
> +		};
>  	};
>  };
> --=20
> 2.41.0
>=20

--0pBAAiuXuzC5EtR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOnFyAAKCRB4tDGHoIJi
0vUQAP4rn0a1GtuTy9uRAuCAabcGhEsSKGdJ5Mgd3WVmE+3/pAD/a612kqTRPb+p
IAQcu3jlvuZgUpxpEMUUMdDE5DZzzgY=
=3dSo
-----END PGP SIGNATURE-----

--0pBAAiuXuzC5EtR1--
