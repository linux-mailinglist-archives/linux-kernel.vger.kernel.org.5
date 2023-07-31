Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BDD769511
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjGaLjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGaLj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:39:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103E8E4A;
        Mon, 31 Jul 2023 04:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690803568; x=1722339568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bk5DMwF7rZz6n/fcjLNabhMTSOkn7DumjJhcd9DMlSE=;
  b=XlLteRVRzV+S+YpCo5BxMGl9BsndM1yF5onIh/u8+C+62EssvRVqrqeD
   orc/gt6Xx/FuCdkFawqu79GD8riGZeP8okFTFCHqtvhIExy6jmxW3wth2
   djWwj6mffbCgeAvGixxf0GwmUs9dVg7RyJBy12LbAIOqjgHOm/PJRH44+
   3/1PWoYdST29VYetZ5KhfO8tQtgTi+mM8xIWEgAQoUGB8Zq3l/NAzrPll
   FOqeHItdiRKKb8HPUAURC3eIna92SnOn4y2UTkgB6KGJ3nb+KV3D6cAE5
   5msS/P+h+ISU1nu1lHQR15KylqKevXwYchNZouYb2dLGm45glv/jh2K2V
   A==;
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="asc'?scan'208";a="223112760"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2023 04:39:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 31 Jul 2023 04:39:15 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 31 Jul 2023 04:39:12 -0700
Date:   Mon, 31 Jul 2023 12:38:37 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Jisheng Zhang <jszhang@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        <linux-riscv@lists.infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v10 3/6] riscv: mm: dma-noncoherent: nonstandard cache
 operations support
Message-ID: <20230731-tribute-splashing-6a90f443cefe@wendy>
References: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230702203429.237615-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZMZ6XB6gX2kFd/Nt@xhacker>
 <CA+V-a8u3F_XDjBfVVVvNMfjrni8pgpcRgbVt6_Ax1TmG2fJdEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d/DKBGEaeBZfjJb+"
Content-Disposition: inline
In-Reply-To: <CA+V-a8u3F_XDjBfVVVvNMfjrni8pgpcRgbVt6_Ax1TmG2fJdEg@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--d/DKBGEaeBZfjJb+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 12:30:43PM +0100, Lad, Prabhakar wrote:
> On Sun, Jul 30, 2023 at 4:09=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org=
> wrote:
> > On Sun, Jul 02, 2023 at 09:34:26PM +0100, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> > > +config RISCV_NONSTANDARD_CACHE_OPS
> > > +     bool
> > > +     depends on RISCV_DMA_NONCOHERENT
> > > +     help
> > > +       This enables function pointer support for non-standard noncoh=
erent
> > > +       systems to handle cache management.
> >
> > Per Documentation/riscv/patch-acceptance.rst:
> >
> > "we'll only consider patches for extensions that either:
> >
> > - Have been officially frozen or ratified by the RISC-V Foundation, or
> > - Have been implemented in hardware that is widely available, per stand=
ard
> >   Linux practice."
> >
> > I'm not sure which item this patch series belongs to.
> >
> Maybe Conor can help me here ;)

I'm not entirely sure why you need my help, it's your company that
manufactures the SoC that needs this after all.. I think Emil already
pointed out that it was the latter of the two. I guess it is not an
"extension" in the strictest sense of the word, but it fills the same
gap as one, so /shrug.

--d/DKBGEaeBZfjJb+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMedMAAKCRB4tDGHoIJi
0otyAQCTdXhKY3ZMzXlhBusieryR8/T0KUnMSoyc/nJ6g+0HrQD/ama4ssLUZSV1
/pCK2RUuXSCTW8uPY8nM87ygzQ/AbQ8=
=NAG3
-----END PGP SIGNATURE-----

--d/DKBGEaeBZfjJb+--
