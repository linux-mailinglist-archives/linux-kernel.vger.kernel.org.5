Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C29808EC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443321AbjLGRbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjLGRbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:31:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7F910CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:31:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA79C433C8;
        Thu,  7 Dec 2023 17:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701970299;
        bh=y5KQaG6xsO92nyU8jMBjwng72ljhMerO17hvLBT/01s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7ia9+f7X6k9/jV0mXmpBMYhlZE37AFCCRWGXDRntRLrVF+xVRoIuRw7reZjML+2w
         twc0HzmZg+PNMQTU8QG893Z0VAq/ltDXDMYDwkRcqBvSZhuS5g7ePrOMuijKvrBkIJ
         drbrnpbsWsIBYrt2VhHIo/Wpp3b/U4gprRE4EL0jzyW662+Rb4k+Gxdw26IogPqhSB
         OkJN0K4b1FQjFITQCU+5CsxCWT00mHkDGPgC+LWYJ16k2H0ZFHDmT6B6vwdhMDKHC2
         0E5E4wQxu3LzxP2MVLB4uWuUyGfmPRArMIB5TYoQFkujhqEO9Y4uC55W4A/xVpBRsy
         VprPzntPwnHMw==
Date:   Thu, 7 Dec 2023 17:31:33 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Liu Gui <kenneth.liu@sophgo.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        qiujingbao.dlmu@gmail.com, dlan@gentoo.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/4] riscv: dts: sophgo: add clock generator for
 Sophgo CV1800 series SoC
Message-ID: <20231207-doze-spinster-0bfad3b1441a@spud>
References: <f9db367c-a96b-4789-9884-f2062499765a@linaro.org>
 <IA1PR20MB49531D4EFD4626834B5C604ABB8BA@IA1PR20MB4953.namprd20.prod.outlook.com>
 <375bb6e4-18dc-4f54-9a06-6f9f2ba0a0ec@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lhuauHl59hGZdGju"
Content-Disposition: inline
In-Reply-To: <375bb6e4-18dc-4f54-9a06-6f9f2ba0a0ec@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lhuauHl59hGZdGju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 01:52:16PM +0100, Krzysztof Kozlowski wrote:
> On 07/12/2023 10:42, Inochi Amaoto wrote:
> >>> +&clk {
> >>> +	compatible =3D "sophgo,cv1810-clk";
> >>> +};
> >>> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot=
/dts/sophgo/cv18xx.dtsi
> >>> index 2d6f4a4b1e58..6ea1b2784db9 100644
> >>> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> >>> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> >>> @@ -53,6 +53,12 @@ soc {
> >>>  		dma-noncoherent;
> >>>  		ranges;
> >>>
> >>> +		clk: clock-controller@3002000 {
> >>> +			reg =3D <0x03002000 0x1000>;
> >>> +			clocks =3D <&osc>;
> >>> +			#clock-cells =3D <1>;
> >>
> >> I don't find such layout readable and maintainable. I did some parts
> >> like this long, long time ago for one of my SoCs (Exynos54xx), but I
> >> find it over time unmaintainable approach. I strongly suggest to have
> >> compatible and other properties in one place, so cv1800 and cv1812, ev=
en
> >> if it duplicates the code.
> >>
> >=20
> > Hi Krzysztof:
> >=20
> > Thanks for your advice, but I have a question about this: when I should
> > use the DT override? The memory mapping of the CV1800 and CV1810 are
> > almost the same (the CV1810 have more peripheral and the future SG200X
> > have the same layout). IIRC, this is why conor suggested using DT overr=
ide
> > to make modification easier. But duplicating node seems to break thiS, =
so
> > I's pretty confused.
>=20
> Go with whatever your subarchitecture and architecture maintainers
> prefer, I just shared my opinion that I find such code difficult to read
> and maintain.
>=20
> Extending node with supplies, pinctrl or even clocks would be readable.
> But the compatible: no. The same applies when you need to delete
> property or subnode: not readable/maintainable IMHO.

There are apparently 3 or 4 of these SoCs that are basically identical,
which is why the approach was taken. I do agree that it looks somewhat
messy because I was looking for device-specific compatibles for these
SoCs.

--lhuauHl59hGZdGju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXIBdQAKCRB4tDGHoIJi
0gvbAP0aZRnwZeW/uj2D5AKml7K6VntejuP/ZKF3cb023p/PeQD+K7QPGKIR7elG
P9fe8O+9MjABjpbXTovEnCRCL6XdLwM=
=5VP/
-----END PGP SIGNATURE-----

--lhuauHl59hGZdGju--
