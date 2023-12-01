Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2991800068
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377446AbjLAAlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjLAAlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:41:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA18410C2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:41:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0692BC433C8;
        Fri,  1 Dec 2023 00:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701391274;
        bh=xyNXG6SSw/FX+HmvZLvMHfne8MiBvBU5k2qUErywYyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=euVkBSUhyDkac4CuPscrYU3WCYyr12e7uI7wedIrK6RwcBi0Bjh0087oE++tAsadB
         RgWnbEBFV/sp93kZs5ULLGR7JCmaaZNSW6Ifl+nw1+VrCvC3Vl/rUiLyLOiUH+HIIi
         djXuO+F3Rofz+qqXJDAewx/xMuSfFEtnJjzZCkbIPQfaSs79VLSSberldUhILVQkW2
         HdzWBpkty2jZkFMb+1MiRwdz5O+LrrOEqanRQ3BYkWXa0Bw8dYb/fiI8Gn3ePkkMq+
         7NMcZWCyHzVCypYcAxpVCQqWZed41tMOFwj0F6pdm4VeZ9Vr3h89U/sdYYl+zIpZUz
         ZXw8HIgi+nMvA==
Date:   Fri, 1 Dec 2023 00:41:08 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/7] Add Huashan Pi board support
Message-ID: <20231201-nullify-overhand-9fb99d0752ad@spud>
References: <20231130-radiator-cut-167bcaaa2cd6@spud>
 <IA1PR20MB4953275B5B7BB241916A937BBB82A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Oa6rKUcHt4IMj/fE"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953275B5B7BB241916A937BBB82A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Oa6rKUcHt4IMj/fE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 07:21:29AM +0800, Inochi Amaoto wrote:
> >
> >On Thu, 19 Oct 2023 07:18:00 +0800, Inochi Amaoto wrote:
> >> Huashan Pi board is an embedded development platform based on the
> >> CV1812H chip. Add minimal device tree files for this board.
> >> Currently, it can boot to a basic shell.
> >>
> >> NOTE: this series is based on the Jisheng's Milk-V Duo patch.
> >>
> >> Link: https://en.sophgo.com/product/introduce/huashan.html
> >> Link: https://en.sophgo.com/product/introduce/cv181xH.html
> >> Link: https://lore.kernel.org/linux-riscv/20231006121449.721-1-jszhang=
@kernel.org/
> >>
> >> [...]
> >
> >Applied to riscv-dt-for-next, thanks! LMK if something looks not as
> >expected.
> >
> >[1/7] dt-bindings: interrupt-controller: Add SOPHGO CV1812H plic
> >      https://git.kernel.org/conor/c/21a34e63afcc
> >[2/7] dt-bindings: timer: Add SOPHGO CV1812H clint
> >      https://git.kernel.org/conor/c/06ea2a1968a9
> >[3/7] dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
> >      https://git.kernel.org/conor/c/d7b92027834e
> >[4/7] riscv: dts: sophgo: Separate compatible specific for CV1800B soc
> >      https://git.kernel.org/conor/c/5b5dce3951b2
> >[5/7] riscv: dts: sophgo: cv18xx: Add gpio devices
> >      https://git.kernel.org/conor/c/dd791b45c866
> >[6/7] riscv: dts: sophgo: add initial CV1812H SoC device tree
> >      https://git.kernel.org/conor/c/681ec684a741
> >[7/7] riscv: dts: sophgo: add Huashan Pi board device tree
> >      https://git.kernel.org/conor/c/2c36b0cfb408
> >
> >Thanks,
> >Conor.
> >
>=20
> Hi Conor,
>=20
> Thanks for the confirmation. But I suggest to revert these patches.
> Several days ago, Sophgo informed me that CV1810 series will be
> renamed. And the Huashan Pi will switch to the chip with new name.
> To avoid unnecessary conflict, please drop these patch and I will
> prepare a new patch once the renamed chip is launched.

This is a board that exists, that you (and possibly others) have, right?


--Oa6rKUcHt4IMj/fE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWkrpAAKCRB4tDGHoIJi
0hX6AP9OHp3TzIaapwlMHyhqln64NTsByJQi4Ni2lrdwgE9f1wEAk8lHeZH8ux+P
5BlutmsXivBzaXVvkood0Zk8vTY2OwY=
=lcfp
-----END PGP SIGNATURE-----

--Oa6rKUcHt4IMj/fE--
