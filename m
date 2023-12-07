Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB20D8088EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjLGNMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjLGNMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:12:02 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E404910E9;
        Thu,  7 Dec 2023 05:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701954728; x=1733490728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4hPha8F9u1bHaqRGRfkg8SwanFYTgp+4Z7tK+Ubzcjs=;
  b=EoAUjU1OqOJHpCkpqwFv39VX/gT55zavlED0+Zi14t+KhRpDWDZw6XTj
   tCexsmJ2QjuJwZ++nNL9TRybezLIN7bTLzLSxAvUK6vOinQ5efJHsKm+i
   1nl8MvhAfTCyawpYOEjiPZdzGimFzAHxJtPL27dvOUi4iTug/SgMohWzw
   64goeFEfPSZ3E7QWSVFAOd6ndUcPrbSs8pQXrKM8JeoaR27i80T7F+Kji
   uLaC3kFquGE38P+WdXpXRrvlQ+na/Ey9pPJXGhyOHmsaMlR/FUeWxnXb/
   MSGWgUuMEMQMs9jhWLCOU6No5Kzoih+Rgei4NrRfdBAr82bSL3ntUtleI
   w==;
X-CSE-ConnectionGUID: JQolBRUHQTen03AsQHVsCg==
X-CSE-MsgGUID: phlp69xtRlu1zFivcfKhmw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="asc'?scan'208";a="13247861"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2023 06:12:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 06:11:56 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 7 Dec 2023 06:11:53 -0700
Date:   Thu, 7 Dec 2023 13:11:23 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, <geert+renesas@glider.be>,
        Atish Patra <atishp@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <apatel@ventanamicro.com>, <alexghiti@rivosinc.com>,
        Bjorn Topel <bjorn@rivosinc.com>, <suagrfillet@gmail.com>,
        <jeeheng.sia@starfivetech.com>, <petrtesarik@huaweicloud.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [RFT 1/2] RISC-V: handle missing "no-map" properties for
 OpenSBI's PMP protected regions
Message-ID: <20231207-buffalo-varmint-de843c8a12bb@wendy>
References: <20230810-crewless-pampers-6f51aafb8cff@wendy>
 <mhng-550dee8b-a2fb-485b-ad4d-2763e94191b4@palmer-ri-x1c9>
 <20231206-precut-serotonin-2eecee4ab6af@spud>
 <CA+V-a8s3MjvpD8gAE7-mOUc6PEytbPOR6x_PHuw0J0hOLkaz-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f9Fz83/CoTY3gAXZ"
Content-Disposition: inline
In-Reply-To: <CA+V-a8s3MjvpD8gAE7-mOUc6PEytbPOR6x_PHuw0J0hOLkaz-w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--f9Fz83/CoTY3gAXZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 01:02:00PM +0000, Lad, Prabhakar wrote:
> On Wed, Dec 6, 2023 at 2:26=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
> > On Wed, Dec 06, 2023 at 04:52:11AM -0800, Palmer Dabbelt wrote:
> > > On Thu, 10 Aug 2023 02:07:10 PDT (-0700), Conor Dooley wrote:

> > > > I'm perfectly happy to drop this series though, if people generally=
 are
> > > > of the opinion that this sort of firmware workaround is ill-advised.
> > > > We are unaffected by it, so I certainly have no pressure to have
> > > > something working here. It's my desire not to be user-hostile that
> > > > motivated this patch.
> > >
> > > IIUC you guys and Reneas are the only ones who have hardware that mig=
ht be
> > > in a spot where users aren't able to update the firmware (ie, it's ou=
t in
> > > production somewhere).
> >
> > I dunno if we can really keep thinking like that though. In terms of
> > people who have devicetrees in the kernel and stuff available in western
> > catalog distribution, sure.
> > I don't think we can assume that that covers all users though, certainly
> > the syntacore folks pop up every now and then, and I sure hope that
> > Andes etc have larger customer bases than the in-kernel users would
> > suggest.
> >
> > > So I'm adding Geert, though he probably saw this
> > > months ago...
> >
> > Prabhakar might be a good call on that front. I'm not sure if the
> > Renesas stuff works on affected versions of OpenSBI though, guess it
> > depends on the sequencing of the support for the non-coherent stuff and
> > when this bug was fixed.
> >
> ATM, I dont think there are any users who are using the upstream
> kernel + OpenSBI (apart from me and Geert!). Currently the customers
> are using the BSP releases.

That doesn't really answer whether or not you (and your customers) are
using an affected version of the vendor OpenSBI?
The affected range for OpenSBI itself is [v0.8 to v1.3).

--f9Fz83/CoTY3gAXZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXHEewAKCRB4tDGHoIJi
0qAVAQDuyK5FCD922oVznNjcMLfpdk3VinS8Td2EgK/P06qa2wD+NHaA5dhQABPZ
AL8kEYvuUajwlHISzPfMrsohnzvnlQE=
=LBlc
-----END PGP SIGNATURE-----

--f9Fz83/CoTY3gAXZ--
