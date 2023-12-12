Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F297880E67A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjLLIno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjLLInj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:43:39 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4E6CF;
        Tue, 12 Dec 2023 00:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702370625; x=1733906625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wgVHBzqoKPPGjfmpxOQWTXb8ZDh9UV5MdaG4pwJ/vWI=;
  b=YeZFOe5+gHlb8iFFB/pn7raHKb2flh/Jngf/A6tw2hzcTz/BZjhgAvaR
   mmTmZjGbwrTsOg4cYv94DoxZyiUub8zU36iLPd3EgP2dp6qWPub1nwq+Q
   t6ZEI1kEFRPzqyMxzgX04Bgmgjbwc2sZ9tEaZ4iOGFaHTaHZK8gEe3b7I
   fdFkkFadZM+9QYsAuRi7nfXGyUYih2FJf8oUbOt3ddwWt0NHwP0qlDWRx
   dRlRSrez4h8i4gH5uIHMDooD2+NuGkMZi5Hsb22kBHGitz/nq7bDyIJT9
   v9fgnl2jgibwr5jvcH2vYYCQSXWi1xidU6lvUhgmHOMmVfHbfOuKEzBRh
   A==;
X-CSE-ConnectionGUID: WiO6fCDNTCCj2lq+o3a3hw==
X-CSE-MsgGUID: am4cvTE2TnicaDYOgADGLw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="asc'?scan'208";a="180345961"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 01:43:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 01:43:38 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Dec 2023 01:43:36 -0700
Date:   Tue, 12 Dec 2023 08:43:06 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [PATCH v1] soc: renesas: make ARCH_R9A07G043 depend on
 !DMA_DIRECT_REMAP
Message-ID: <20231212-ambition-karma-4834afd4eb16@wendy>
References: <20231211-primate-arbitrate-fbcd307a0b00@spud>
 <CAMuHMdX0bETuMoZCZM7pAodbwyf0ttZMpKuq0ibBZX7S-YV8xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e2oQTY8OE7jKY5sj"
Content-Disposition: inline
In-Reply-To: <CAMuHMdX0bETuMoZCZM7pAodbwyf0ttZMpKuq0ibBZX7S-YV8xw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--e2oQTY8OE7jKY5sj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 09:19:32AM +0100, Geert Uytterhoeven wrote:
> Hi Conor,
>=20
> On Mon, Dec 11, 2023 at 11:06=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > Randy reported yet another build issue with randconfigs on rv32:
> > WARNING: unmet direct dependencies detected for DMA_GLOBAL_POOL
> >   Depends on [n]: !ARCH_HAS_DMA_SET_UNCACHED [=3Dn] && !DMA_DIRECT_REMA=
P [=3Dy]
> >   Selected by [y]:
> >   - ARCH_R9A07G043 [=3Dy] && SOC_RENESAS [=3Dy] && RISCV [=3Dy] && NONP=
ORTABLE [=3Dy] && RISCV_ALTERNATIVE [=3Dy] && !RISCV_ISA_ZICBOM [=3Dn] && R=
ISCV_SBI [=3Dy]
> >
> > This happens when DMA_DIRECT_REMAP is selected by the T-Head CMO erratum
>=20
> or by the Zicbom extension support?

Probably, yeah. That was just the conditions for this particular
randconfig IIRC.

> > option and DMA_GLOBAL_POOL is selected by the Andes CMO erratum. Block
> > selecting the RZ/Five config option, and by extension DMA_GLOBAL_POOL,
> > if DMA_DIRECT_REMAP has already been enabled.
> >
> > Fixes: 484861e09f3e ("soc: renesas: Kconfig: Select the required config=
s for RZ/Five SoC")
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> > Closes: https://lore.kernel.org/all/24942b4d-d16a-463f-b39a-f9dfcb89d74=
2@infradead.org/
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.8.
>=20
> Or should this be queued as a fix for v6.7 instead?

Depends on your opinion on how critical such a fix is I suppose.

> > ---
> > I don't know what the exact fixes tag here is as I did not bisect with
> > the randconfig, so I blamed the one that added DMA_GLOBAL_POOL.
>=20
> Bisection leads to commit da323d4640704001 ("dma-direct: add
> dependencies to CONFIG_DMA_GLOBAL_POOL") in v6.7-rc1, but that is
> merely making visible the symptoms, so I think your Fixes tag is fine.
>=20
> Esmil: I think you need a similar fix for ERRATA_STARFIVE_JH7100 in
> your tree.

I probably need a similar fix in my tree for that, since I applied
Emil's patches...

--e2oQTY8OE7jKY5sj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXgdGQAKCRB4tDGHoIJi
0jbuAP91y7WApBZFEeiqbfME/Mo6p2pI+fFTDQeQretgcPSVNQEA0ZQFUcwsk10K
K1XlumMMEm3Lyb4/BNoAfFhLqNBlIA8=
=AJxt
-----END PGP SIGNATURE-----

--e2oQTY8OE7jKY5sj--
