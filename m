Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462CE7F5B97
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjKWJqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjKWJp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:45:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEE62125;
        Thu, 23 Nov 2023 01:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700732693; x=1732268693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LPFNYR6tLm2ibdzV9smgUSVHDB6vTwM5UIqyj9DLBUM=;
  b=lHCC4eyA7SVnjfchVb2SV45/X11QvuL0sjhBG7s7z8wkvsljSqN/FOJo
   RRv/Xiejy9kckQWu7zXwhB0gZ9XfWZhl22SaIkWRbu1GZxgaizXjT98/H
   NtrNvdiim8yjO6b4P3KelmePLeLckTqO5F0Kb/MgthH9qegLNEFqcnpB3
   i4+26rE77jxD1XoGmPldvMNYLjHpE3wI38MYWrf9aGAAgLBJOejEknxMM
   EHcNtk75ecpn0jfnRdGi5FXIJaIRyhXCIvnYe928Cr/V1HDZAObOQq81V
   VGBBC/Ah55PlYy87Yj4I86/tAo5RFMbn+HXmEM+tHZCMzERvF8RyCJvlL
   A==;
X-CSE-ConnectionGUID: Zrbw1xdKSOmkRdUe4iw5XQ==
X-CSE-MsgGUID: e8PbdSIKRoap7LBep/y66g==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="asc'?scan'208";a="12925617"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 02:44:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Nov 2023 02:44:25 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 23 Nov 2023 02:44:21 -0700
Date:   Thu, 23 Nov 2023 09:43:53 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     Rob Herring <robh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Conor Dooley <conor@kernel.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] kbuild: Per arch/platform dtc warning levels
Message-ID: <20231123-deviator-camisole-645715ad02e9@wendy>
References: <20231122-dtc-warnings-v2-0-bd4087325392@kernel.org>
 <CAK7LNASVMjVg4dr=KdSDHwGww_47H78H7rMXA=wf+ncugesDSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2G62sYkADi9C8Ekb"
Content-Disposition: inline
In-Reply-To: <CAK7LNASVMjVg4dr=KdSDHwGww_47H78H7rMXA=wf+ncugesDSA@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--2G62sYkADi9C8Ekb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Thu, Nov 23, 2023 at 04:38:37PM +0900, Masahiro Yamada wrote:
> On Thu, Nov 23, 2023 at 7:12=E2=80=AFAM Rob Herring <robh@kernel.org> wro=
te:
> >
> > This series adds support to set the dtc extra warning level on a per
> > arch or per platform (directory really) basis.
> >
> > The first version of this was just a simple per directory override for
> > Samsung platforms, but Conor asked to be able to do this for all of
> > riscv.
> >
> > For merging, either I can take the whole thing or the riscv and samsung
> > patches can go via their normal trees. The added variable will have no
> > effect until merged with patch 2.
> >
> > v1:
> >  - https://lore.kernel.org/all/20231116211739.3228239-1-robh@kernel.org/
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
>=20
>=20
> There were some attempts in the past to enable W=3D1 in particular subsys=
tems,
> so here is a similar comment.
>=20
> Adding a new warning flag to W=3D1 is always safe without doing any compi=
le test.
>=20
> With this series, it would not be true any more because a new warning in =
W=3D1
> would potentially break riscv/samsung platforms.

We carry a copy of the dtc in scripts/dtc, so I would expect that before
an upgrade is done that would introduce new warnings we can fix them in
the relevant platforms. Perhaps I am misunderstanding something there,
but I'm sure Rob can clear it up if I made a mistake.

> Linus requires a clean build (i.e. zero warning) when W=3D option is not =
given.

For RISC-V at least, there are currently no W=3D1 warnings while building
the dtbs (because I put effort into fixing them all) and I would like to
keep it that way, so that requirement is not a concern.

Cheers,
Conor.


--2G62sYkADi9C8Ekb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV8e1AAKCRB4tDGHoIJi
0sxaAQC2J2yJot6Q+z5RKQ6rY/Oa21cLwAgbgnGOkI0wsdpSGgD/X8W0HHWXxPfn
qGSKWwZvElDt0/4G68GZFIxJXRd/Kwk=
=Wtop
-----END PGP SIGNATURE-----

--2G62sYkADi9C8Ekb--
