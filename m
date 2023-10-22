Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8F57D2516
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjJVSAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVSAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:00:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AA5E8;
        Sun, 22 Oct 2023 11:00:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EED4C433C8;
        Sun, 22 Oct 2023 18:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697997639;
        bh=9wO5luQQA8YamZzHgZ2c+8fPusMyrapaaEYIJ6WW7d4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCvWET6DpMgtWpc4RTvFqtnFe/lRb3pvOTc1BbmpzD7II1ggf9IjdzX1rT13qkC/W
         CceP0hWDUW4bxZqJJCAh2iXQcjGJ4IY9xombM9nW4mmBLJ30cEEfy4iGkkWw27YAhP
         9nkhlXCuiwMRr9FMucNlHHRApkm/bV71zVP042GkU4jCckh7fTETl4l2VDGocODOtD
         iVm0eOPrPBAkYRCFBcQv52qjHDEKwKfpOsGo73uG+ZI2FRJ4cs4yyzHVT0xb2zoCN4
         cTBMUO5QxyRTGCh4NlNoSsFmyF94GjaZ8+XRzAAgsll0kYuiTTmX700T/uYhBOkJy2
         vdOJEVOK7HDjg==
Date:   Sun, 22 Oct 2023 19:00:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com,
        devicetree@vger.kernel.org, dminus@andestech.com,
        evan@rivosinc.com, geert+renesas@glider.be, guoren@kernel.org,
        heiko@sntech.de, irogers@google.com, jernej.skrabec@gmail.com,
        jolsa@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, locus84@andestech.com,
        magnus.damm@gmail.com, mark.rutland@arm.com, mingo@redhat.com,
        n.shubin@yadro.com, namhyung@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
        tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me,
        wens@csie.org, will@kernel.org, ycliang@andestech.com
Subject: Re: [PATCH v3 00/13] Support Andes PMU extension
Message-ID: <20231022-cabana-crate-503b6e8d0481@spud>
References: <20231022151858.2479969-1-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kQihSqwF+AlYNzqS"
Content-Disposition: inline
In-Reply-To: <20231022151858.2479969-1-peterlin@andestech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kQihSqwF+AlYNzqS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Sun, Oct 22, 2023 at 11:18:45PM +0800, Yu Chien Peter Lin wrote:
> Hi All,
>=20
> This patch series introduces the Andes PMU extension, which serves
> the same purpose as Sscofpmf. In this version we use FDT-based
> probing and the CONFIG_ANDES_CUSTOM_PMU to enable perf sampling
> and filtering support.
>=20
> Its non-standard local interrupt is assigned to bit 18 in the
> custom S-mode local interrupt enable/pending registers (slie/slip),
> while the interrupt cause is (256 + 18).
>=20
> The feature needs the PMU device registered in OpenSBI.
> The OpenSBI and Linux patches can be found on Andes Technology GitHub
> - https://github.com/andestech/opensbi/commits/andes-pmu-support-v2
> - https://github.com/andestech/linux/commits/andes-pmu-support-v3
>=20
> The PMU device tree node used on AX45MP:
> - https://github.com/andestech/opensbi/blob/andes-pmu-support-v2/docs/pmu=
_support.md#example-3
>=20
> Tested hardware:
> - ASUS  Tinker-V (RZ/Five, AX45MP single core)
> - Andes AE350    (AX45MP quad core)
>=20
> Locus Wei-Han Chen (1):
>   riscv: andes: Support symbolic FW and HW raw events
>=20
> Yu Chien Peter Lin (12):
>   riscv: errata: Rename defines for Andes
>   irqchip/riscv-intc: Allow large non-standard hwirq number
>   irqchip/riscv-intc: Introduce Andes IRQ chip
>   dt-bindings: riscv: Add Andes interrupt controller compatible string
>   riscv: dts: renesas: r9a07g043f: Update compatible string to use Andes
>     INTC
>   perf: RISC-V: Eliminate redundant IRQ enable/disable operations
>   RISC-V: Move T-Head PMU to CPU feature alternative framework
>   perf: RISC-V: Introduce Andes PMU for perf event sampling
>   dt-bindings: riscv: Add T-Head PMU extension description
>   dt-bindings: riscv: Add Andes PMU extension description
>   riscv: dts: allwinner: Add T-Head PMU extension
>   riscv: dts: renesas: Add Andes PMU extension

You only sent 5 of these patches FYI.

--kQihSqwF+AlYNzqS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTVjPAAKCRB4tDGHoIJi
0o+CAQCs8vdPe2eoLkFKb2hs5d1cvV8J9PlrQHw0kqccpMHL3AD8CQBoM5Sk3hvM
Gz9PBQeo9LO29BJjkL9Q/nthrSlgIw0=
=9vNu
-----END PGP SIGNATURE-----

--kQihSqwF+AlYNzqS--
