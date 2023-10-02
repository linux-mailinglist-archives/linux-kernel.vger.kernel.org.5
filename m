Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072927B52C1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbjJBMMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbjJBMMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:12:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C320835AE
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:11:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C4CC433C8;
        Mon,  2 Oct 2023 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696248633;
        bh=/LiX+txB3BRVZ32LePlO17W8hckAYNHaz2iEFDZjuJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WAweR1RS3PeKDXyktGjd2NkmON/1Kn3Nrb5nYRpUPGrQSb9IwMWKAqQmwzzpAJB/U
         hD8OOJ2YodtGDarNe5b3Qld83DSkJExcN95cczDJYwKXoo09zJ6lUyCVUfptsd3wOe
         4eYVtPEHcTOvjMzzKoSWb1f5/+ERRpbMl+7atb3+qQZNsjGtKGV0AVtkIuXJkFHkKx
         in5wo28KrQq5ERGacqK+eTnX8cDiqv2bqi7aPrROE725I5uQPVaH9ZFbS+LC1XZMgB
         G3v2Rf2RycbO0Fjg1XtI1/+ZWk3z8b/C2imDTmHXb71kep0PI/yHM+SmnENUlkEagK
         rDNZal4d4rnyg==
Date:   Mon, 2 Oct 2023 13:10:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicorn_wang@outlook.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
Subject: Re: [PATCH 0/5] Add Milk-V Duo board support
Message-ID: <20231002-traps-prize-d5b5c0f2152d@spud>
References: <20230930123937.1551-1-jszhang@kernel.org>
 <MA0P287MB0332292A882CC400750788A8FEC7A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KFvRWj/kJia4o6i6"
Content-Disposition: inline
In-Reply-To: <MA0P287MB0332292A882CC400750788A8FEC7A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KFvRWj/kJia4o6i6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2023 at 10:18:23PM +0800, Chen Wang wrote:
>=20
> =E5=9C=A8 2023/9/30 20:39, Jisheng Zhang =E5=86=99=E9=81=93:
> > Milk-V Duo[1] board is an embedded development platform based on the
> > CV1800B[2] chip. Add minimal device tree files for the development boar=
d.
> > Currently, now it's supported to boot to a basic shell.
> >=20
> > NOTE: this series is based on the SG2042 upstream series for the vendor
> > prefix and ARCH_SOPHGO option.
> Missing reference to [3].

Should be fine without it :)

> >=20
> > Link: https://milkv.io/duo [1]
> > Link: https://en.sophgo.com/product/introduce/cv180xB.html [2]
> > Link: https://lore.kernel.org/linux-riscv/cover.1695804418.git.unicornx=
w@gmail.com/ [3]
> >=20
> > Jisheng Zhang (5):
> >    dt-bindings: interrupt-controller: Add SOPHGO CV1800B plic
> >    dt-bindings: timer: Add SOPHGO CV1800B clint
> >    dt-bindings: riscv: Add Milk-V Duo board compatibles
> >    riscv: dts: sophgo: add initial CV1800B SoC device tree
> >    riscv: dts: sophgo: add Milk-V Duo board device tree
> >=20
> >   .../sifive,plic-1.0.0.yaml                    |   1 +
> >   .../devicetree/bindings/riscv/sophgo.yaml     |   4 +
> >   .../bindings/timer/sifive,clint.yaml          |   1 +
> >   arch/riscv/boot/dts/sophgo/Makefile           |   2 +-
> >   .../boot/dts/sophgo/cv1800b-milkv-duo.dts     |  38 ++++++
> >   arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 117 ++++++++++++++++++
> >   6 files changed, 162 insertions(+), 1 deletion(-)
> >   create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> >   create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> >=20

--KFvRWj/kJia4o6i6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRqzMwAKCRB4tDGHoIJi
0hc/AQCrKLVIiXVABYoKX34nKht5Ha7F+ubUYXyuiEDISviTYAEAlU1seAj6AN3c
L36nj/svH9vlWR5tzkoocIkUeQ3BgAo=
=7CjF
-----END PGP SIGNATURE-----

--KFvRWj/kJia4o6i6--
