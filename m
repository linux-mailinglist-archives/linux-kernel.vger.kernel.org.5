Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794BD7CFBF9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345958AbjJSOEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345955AbjJSOEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:04:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722BD130
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:04:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D3CC433C7;
        Thu, 19 Oct 2023 14:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697724288;
        bh=xtme3jJusxVUa9FbYH1+EvMXHDNXjJxBF7Z86EuaCY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggAbf4wp3vSh5284kcig1pPPsSidHG15qglwc71EcbD47XdClE1fuh5T6bGJWQym0
         nV78AjAWd5j3cKm3rSV6aIE2+p/6c3n2QvwqCK/dFGWBjle+tmv4nZOS78m1cY04NC
         RsTNfYd7mU3vr32pqTAW5cgsVLc9lG0vxi/6stMX0+cZtd5TYVQSew8LZACHTK4C5d
         vWqkW899KSwASIC66uivQTu8GDuICN627eekP4A3A0gIXmtK48SFfCJFKSYiJ663ar
         O0tHBqkCwZ6xD8zHT1f9m3VGmjoIUzFxS+4kr8d1QPdJ65GxurgBx1Q6pX4XSP5HU2
         DZM+fsLGTyclg==
Date:   Thu, 19 Oct 2023 15:04:42 +0100
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
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/7] Add Huashan Pi board support
Message-ID: <20231019-amused-agonize-bcb8787c6f6f@spud>
References: <IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tVeLnAzB+nEjs8bs"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tVeLnAzB+nEjs8bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Oct 19, 2023 at 07:18:00AM +0800, Inochi Amaoto wrote:
> Huashan Pi board is an embedded development platform based on the
> CV1812H chip. Add minimal device tree files for this board.
> Currently, it can boot to a basic shell.

Just pointing out that this series is too late for v6.7, so you probably
won't hear anything from me until v6.7-rc1 has been tagged.

Cheers,
Conor.

>=20
> NOTE: this series is based on the Jisheng's Milk-V Duo patch.
>=20
> Link: https://en.sophgo.com/product/introduce/huashan.html
> Link: https://en.sophgo.com/product/introduce/cv181xH.html
> Link: https://lore.kernel.org/linux-riscv/20231006121449.721-1-jszhang@ke=
rnel.org/
>=20
> Changed from v3:
> 1. merge the patch 4 and 5 of v2 to preserve bisectability.
>=20
> Changed from v2:
> 1. use dt override to save code.
> 2. code cleanup.
>=20
> Changed from v1:
> 1. split the patch into several patch and refactor them.
>=20
> Inochi Amaoto (7):
>   dt-bindings: interrupt-controller: Add SOPHGO CV1812H plic
>   dt-bindings: timer: Add SOPHGO CV1812H clint
>   dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
>   riscv: dts: sophgo: Separate compatible specific for CV1800B soc
>   riscv: dts: sophgo: cv18xx: Add gpio devices
>   riscv: dts: sophgo: add initial CV1812H SoC device tree
>   riscv: dts: sophgo: add Huashan Pi board device tree
>=20
>  .../sifive,plic-1.0.0.yaml                    |   1 +
>  .../devicetree/bindings/riscv/sophgo.yaml     |   4 +
>  .../bindings/timer/sifive,clint.yaml          |   1 +
>  arch/riscv/boot/dts/sophgo/Makefile           |   1 +
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 119 +----------
>  .../boot/dts/sophgo/cv1812h-huashan-pi.dts    |  48 +++++
>  arch/riscv/boot/dts/sophgo/cv1812h.dtsi       |  24 +++
>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi        | 193 ++++++++++++++++++
>  8 files changed, 279 insertions(+), 112 deletions(-)
>  create mode 100644 arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
>  create mode 100644 arch/riscv/boot/dts/sophgo/cv1812h.dtsi
>  create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>=20
> --
> 2.42.0
>=20

--tVeLnAzB+nEjs8bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTE3egAKCRB4tDGHoIJi
0n41APwMeOxLjPmDl9G45xdD40nzpk/P7fEfNvMDqL6OV9fjfwD9H+4j5zSNJa5V
vAl9NCqwS1HSCxO8bydUCObAQsUjZww=
=+zw9
-----END PGP SIGNATURE-----

--tVeLnAzB+nEjs8bs--
