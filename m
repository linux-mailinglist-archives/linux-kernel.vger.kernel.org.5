Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA4F7AD39A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjIYImB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjIYIl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:41:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F83EBC;
        Mon, 25 Sep 2023 01:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695631312; x=1727167312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ik/VX0jzwD0mpvhQYFDRhT2i5D3eVP3vzyDvpQ2/UoM=;
  b=mcf2al/GdRMVA524h7PChzU9J6AJIVcz77B3nvQ3cIoBOvG2MynQlcIa
   MW4Mpeaok8PI8GPVQpZ/p5WWl+WM4GqshdtqnCrdtibykf2cuBN0fhi9t
   f/anj+/00/clhTjFWggmkrUMGsUsIuTrQIxslnlDfEBC2OOWAEZWHdkEv
   wwLW7JhPjsd+xseln5FeIeifhBfisM4wyex3RFcilnx12FoN633bzggzS
   EQ5j5k1pmc2aJzC7CxsNCtiuTHM6a6qZ61tWVJx7b35osNwtV3XwpjIE8
   gUdrQEPU3w4Eu8pkxqG5AZpNUfs5BkKHmEuhI+MLsgCfBCR/AeV2+ZNYl
   w==;
X-CSE-ConnectionGUID: 1TnWewJoSl6L34RRtFQyew==
X-CSE-MsgGUID: a2jL1wM1TCiKyhjY2IueuA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="asc'?scan'208";a="173396645"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2023 01:41:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 25 Sep 2023 01:41:35 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 25 Sep 2023 01:41:32 -0700
Date:   Mon, 25 Sep 2023 09:41:14 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     yang tylor <tylor_yang@himax.corp-partner.google.com>
CC:     Conor Dooley <conor@kernel.org>, <dmitry.torokhov@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <jikos@kernel.org>,
        <benjamin.tissoires@redhat.com>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <poyuan_chang@himax.corp-partner.google.com>,
        <hbarnor@chromium.org>,
        "jingyliang@chromium.org" <jingyliang@chromium.org>
Subject: Re: [PATCH V2 1/2] dt-bindings: input: Introduce Himax HID-over-SPI
 device
Message-ID: <20230925-cod-vacancy-08dc8d88f90e@wendy>
References: <20230919024943.3088916-1-tylor_yang@himax.corp-partner.google.com>
 <20230919024943.3088916-2-tylor_yang@himax.corp-partner.google.com>
 <20230919-70b2f1e368a8face73468dfa@fedora>
 <CAGD2q_anfBP78jck6AbMNtgAggjOgaB3P6dkmq9tONHP45adFA@mail.gmail.com>
 <20230919-cc4646dbfb953bd34e05658c@fedora>
 <CAGD2q_bkTpvXiomWb_yerNjQfMVKOctYgBqF_RBSo_jYqyyyxw@mail.gmail.com>
 <20230922-unclothed-bottom-5531329f9724@spud>
 <CAGD2q_YsFdDVhE4JCmQSGMWOdpe_yzG8-CdWYPXtjeZsManvgQ@mail.gmail.com>
 <20230922-removable-footwork-f1d4d96d38dd@spud>
 <CAGD2q_Y467jJJnwCVH+3F-hh6a-1-OYRugcy0DdjPnTCC77Z8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6yswMwPAh/4Cve9z"
Content-Disposition: inline
In-Reply-To: <CAGD2q_Y467jJJnwCVH+3F-hh6a-1-OYRugcy0DdjPnTCC77Z8A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--6yswMwPAh/4Cve9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 09:44:21AM +0800, yang tylor wrote:
> On Fri, Sep 22, 2023 at 11:31=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Fri, Sep 22, 2023 at 05:43:54PM +0800, yang tylor wrote:
> > > On Fri, Sep 22, 2023 at 5:22=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
> > > >
> > > > On Fri, Sep 22, 2023 at 03:56:25PM +0800, yang tylor wrote:
> > > > > On Tue, Sep 19, 2023 at 7:09=E2=80=AFPM Conor Dooley <conor@kerne=
l.org> wrote:
> > > > > > On Tue, Sep 19, 2023 at 05:31:29PM +0800, yang tylor wrote:
> > > >
> > > > > > > The behavior of "himax,boot_time_fw_upgrade" seems not stable=
 and
> > > > > > > should be removed. "himax,fw_in_flash", I use the kernel conf=
ig for
> > > > > > > user to select.
> > > > > >
> > > > > > That seems like a bad idea, we want to be able to build one ker=
nel that
> > > > > > works for all hardware at the same time.
> > > > > >
> > > > > I see, so I should take that back?
> > > > > I'll explain more about it.
> > > >
> > > > Are there particular ICs where the firmware would always be in flas=
h and
> > > > others where it would never be? Or is this a choice made by the boa=
rd or
> > > > system designer?
> > > >
> > > Most cases it's about the system designer's decision. But some ICs ma=
y be forced
> > > to use flash because of its architecture(multiple IC inside, need to
> > > load firmware to
> > > multiple IC's sram by master IC). But if there is no limitation on
> > > this part, most system
> > > designers will prefer flashless.
> >
> > Forgive me if I am not understanding correctly, there are some ICs that
> > will need to load the firmware from flash and there are some where it
> > will be a decision made by the designer of the board. Is the flash part
> > of the IC or is it an external flash chip?
> >
>=20
> Both are possible, it depends on the IC type. For TDDI, the IC is long
> and thin, placed on panel PCB, flash will be located at the external
> flash chip. For the OLED TP, IC is usually placed at FPC and its flash
> is embedded, thus the IC size is large compared to TDDI. But from the
> driver's perspective either external flash or embedded flash, the IC
> itself will load firmware from flash automatically when reset pin is
> released. Only if firmware is loading from the host storage system,
> the driver needs to operate the IC in detail.


Since there are ICs that can use the external flash or have it loaded
=66rom the host, it sounds like you do need a property to differentiate
between those cases.
Is it sufficient to just set the firmware-name property for these cases?
If the property exists, then you know you need to load firmware & what
its name is. If it doesn't, then the firmware either isn't needed or
will be automatically loaded from the external flash.

--6yswMwPAh/4Cve9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRFHmgAKCRB4tDGHoIJi
0nMVAQD0/+RvD0e0+hNILOkQtK4zp8D2AVRzfWJAv2WJqNTsjAD/byS1txiZNPpM
fKg2haa7MvIoQWxWAckF+Bk6qkgBkgY=
=B6aB
-----END PGP SIGNATURE-----

--6yswMwPAh/4Cve9z--
