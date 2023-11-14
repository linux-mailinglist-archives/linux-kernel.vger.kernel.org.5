Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0B37EB376
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjKNPZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjKNPZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:25:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D597B93
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:25:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147BDC433CA;
        Tue, 14 Nov 2023 15:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699975500;
        bh=sKD7iy2x5fxE5EB6+uDvGE1JpLP9GBw3UM1c1ZpmCNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wlbc/7VuXxX/EU9n5788dxNTIRfUrjA+UhwKUDvGpqMC4TwXYQdhqIFszxCNYQqMo
         vZRZ7J9tRw+WUFRwDMfJx92KLlFeyXfWXIaXWgZaMbjaHuziYldPTL8LqkI7cnbPdY
         NeLoI0S/xaXw+vI0S0GwNM7y3ucrwYkrhEFaSg+ixGQMNu9/OZXFFh7vlvFewUFEqy
         4VC/MJOZdNh5wkBeCKnTXcyO2JT9P719X22JnT28/Lq2ehJVYigS/qJsCtP4hFrups
         OdQrzeM+t0gBMCLu9WTssmG+ZecB2j+OySm45GQgKsT+3VAd5L6YgXNkh9BF9UzKqG
         xLiraGDUS667Q==
Date:   Tue, 14 Nov 2023 15:24:56 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Xiaoguang Xing <xiaoguang.xing@sophgo.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: dts: sophgo: separate sg2042 mtime and
 mtimecmp to fit aclint format
Message-ID: <20231114-skedaddle-precinct-66c8897227bb@squawk>
References: <MA0P287MB03326E8AF2EA63CE8CF108CBFEB2A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <IA1PR20MB49531C1FCBAB0E19CAFE19DFBBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TRf8O7Nes3xxvHJQ"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49531C1FCBAB0E19CAFE19DFBBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TRf8O7Nes3xxvHJQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 09:47:19AM +0800, Inochi Amaoto wrote:
> >On 2023/11/14 8:45, Inochi Amaoto wrote:
> >> Change the timer layout in the dtb to fit the format that needed by
> >> the SBI.
> >>
> >> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> >> Fixes: 967a94a92aaa ("riscv: dts: add initial Sophgo SG2042 SoC device=
 tree")
> >> ---
> >>   arch/riscv/boot/dts/sophgo/sg2042.dtsi | 80 +++++++++++++++---------=
--
> >>   1 file changed, 48 insertions(+), 32 deletions(-)
> >>
> >> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/=
dts/sophgo/sg2042.dtsi
> >> index 93256540d078..0b5d93b5c783 100644
> >> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> >> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> >> @@ -93,144 +93,160 @@ clint_mswi: interrupt-controller@7094000000 {
> >>                             <&cpu63_intc 3>;
> >>           };
> >>
> >> -        clint_mtimer0: timer@70ac000000 {
> >> +        clint_mtimer0: timer@70ac004000 {
> >
> >The address of timer register is changed,  and I guess it is another cha=
nge not directly related to the topic of this patch.
> >
> >Can you please add some comments in the commit message?
> >
>=20
> As it needs to follow aclint format, the timer offset is applied to
> identify the actual timer. So there is a change.
>=20
> >>               compatible =3D "sophgo,sg2042-aclint-mtimer", "thead,c90=
0-aclint-mtimer";
> >> -            reg =3D <0x00000070 0xac000000 0x00000000 0x00007ff8>;
> >> +            reg =3D <0x00000070 0xac004000 0x00000000 0x00000000>,
> >Why the length of first item is zero? Can you please add some clarificat=
ion in commit message?
>=20
> I uses length zero to address that the mtimer is not supported, so the
> SBI can know there is no mtimer in the timer.

No, that's unacceptably hacky. If there is only one of the two registers
present, then you need to provide only one of them, not spoof the
presence of two. I suppose that means you need to add reg-names to the
binding & get your registers by name in the SBI implementation, not by
index.

--TRf8O7Nes3xxvHJQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVORRQAKCRB4tDGHoIJi
0hpKAPdj8VR56fGGhyJiFMfWFoZW5wbBqRoZOyFXCdk9rySaAP9bMYcOCBEXXicO
UjA0qR0K/9zqgTJOjAG4LxdbNASkBg==
=ToAp
-----END PGP SIGNATURE-----

--TRf8O7Nes3xxvHJQ--
