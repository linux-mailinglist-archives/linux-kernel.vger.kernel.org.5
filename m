Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF2E7BD69E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345700AbjJIJWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345671AbjJIJWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:22:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47CC97;
        Mon,  9 Oct 2023 02:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696843320; x=1728379320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nl/Pb7yNcrRSIji9Rq2BWcaYNm9rNVSMwfevq+ZJbXU=;
  b=xUIKuTlT4Hl4zOaiT5pfr5MaQgXYhlSCLkdhy7sIMF/4FCdJnoS82G+h
   xU6MRhuLH44z+pVuXJT+BKAhJx7ihfHlKQT+TkRfT9dnCI8bCrEhiNL1r
   Y0fivAgu/GkL2K+wJn8LSWcJu201i1CFlDCeeaGnu8Prgkkfy1iVTYKWi
   lNgBnWY1Il/198TbfmLlQrJ0yTqr6sE5VAj2JaG5ZszlxWi1H3WjSZ6v2
   qAWINHtMYq2rMzcAi75kvlf/JyRIYG/YqasGO8z93P/jy2a1/gfP5Kh6n
   3iJ9NCPTcsoY0Y+b09xYsxBk7zSzfL/NXf2wFV264DxmB+b2ANpjcHvgN
   A==;
X-CSE-ConnectionGUID: crs7sF3tRlKn6sEwzlDrPg==
X-CSE-MsgGUID: 9cWccrISQheTSGzag4PSBQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="asc'?scan'208";a="176377026"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2023 02:21:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 9 Oct 2023 02:21:59 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 9 Oct 2023 02:21:56 -0700
Date:   Mon, 9 Oct 2023 10:21:36 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <linux-renesas-soc@vger.kernel.org>, <conor@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] soc: renesas: select ERRATA_ANDES for R9A07G043 only
 when alternatives are present
Message-ID: <20231009-acuteness-nutlike-1f28a2335384@wendy>
References: <20231009-sandbar-botch-0f398fd2e289@wendy>
 <CAMuHMdVojwgOP8bqHobgbsgUA+7yxUA7v5M6Z800zxrCeuxZjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H8JAiz5CASvgRsHi"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVojwgOP8bqHobgbsgUA+7yxUA7v5M6Z800zxrCeuxZjg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--H8JAiz5CASvgRsHi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 10:34:34AM +0200, Geert Uytterhoeven wrote:
> Hi Conor,
>=20
> On Mon, Oct 9, 2023 at 10:12=E2=80=AFAM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> > Randy reported a randconfig build issue against linux-next:
> > WARNING: unmet direct dependencies detected for ERRATA_ANDES
> >   Depends on [n]: RISCV_ALTERNATIVE [=3Dn] && RISCV_SBI [=3Dy]
> >   Selected by [y]:
> >   - ARCH_R9A07G043 [=3Dy] && SOC_RENESAS [=3Dy] && RISCV [=3Dy] && NONP=
ORTABLE [=3Dy] && RISCV_SBI [=3Dy]
> >
> > ../arch/riscv/errata/andes/errata.c:59:54: warning: 'struct alt_entry' =
declared inside parameter list will not be visible outside of this definiti=
on or declaration
> >    59 | void __init_or_module andes_errata_patch_func(struct alt_entry =
*begin, struct alt_entry *end,
> >
> > On RISC-V, alternatives are not usable in XIP kernels, which this
> > randconfig happened to select. Add a check for whether alternatives are
> > available before selecting the ERRATA_ANDES config option.
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org>
> > Closes: https://lore.kernel.org/all/09a6b0f0-76a1-45e3-ab52-329c47393d1=
d@infradead.org/
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Thanks for your patch!
>=20
> > --- a/drivers/soc/renesas/Kconfig
> > +++ b/drivers/soc/renesas/Kconfig
> > @@ -343,7 +343,7 @@ config ARCH_R9A07G043
> >         select ARCH_RZG2L
> >         select AX45MP_L2_CACHE if RISCV_DMA_NONCOHERENT
> >         select DMA_GLOBAL_POOL
> > -       select ERRATA_ANDES if RISCV_SBI
> > +       select ERRATA_ANDES if (RISCV_SBI && RISCV_ALTERNATIVE)
>=20
> Perhaps ARCH_R9A07G043 should depend on RISCV_ALTERNATIVE (and
> RISCV_SBI) instead?  It's not like RZ/Five is gonna work without the
> Andes errata handling present (unless all of them are related to cache
> handling, and we can run uncached; also see below)).
>=20
> >         select ERRATA_ANDES_CMO if ERRATA_ANDES
>=20
> And then this "if" can go as well.
>=20
> Any other hard dependencies?
> E.g. can RZ/Five work without RISCV_DMA_NONCOHERENT?

That seems fair to me, it won't work without any of the above, so it's
probably fair game to make them actual dependencies & likely more user
friendly since it'll prevent people creating a kernel that cannot
function.

Cheers,
Conor.

>=20
> >         help
> >           This enables support for the Renesas RZ/Five SoC.
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --=20
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

--H8JAiz5CASvgRsHi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSPGIAAKCRB4tDGHoIJi
0pQdAQDP0EDastcRyfubosMkIjTRJbu3yHBbxDcEIeHUXE1/2QEAgoXMXZl4RxM7
cxShvCs8UHEpmf2WuY+pPyQiXnxHvQ4=
=VHI5
-----END PGP SIGNATURE-----

--H8JAiz5CASvgRsHi--
