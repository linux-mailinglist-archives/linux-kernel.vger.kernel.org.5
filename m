Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A013875A779
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjGTHNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjGTHNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:13:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF681719;
        Thu, 20 Jul 2023 00:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689837210; x=1721373210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JqmIbHV6INwiceEQ+zwOlcaktt1kdVZIs4BjTMq3ya8=;
  b=A+IrXBVYVpxpEcYqeJVfNvsWAd+1yAdc4kz5Do42+fVsATYNpxcRBZGi
   6q+nYzlwv8dpTw3SWZlEWMtsW5ASrG/8xtGYy29Jxl8ibULRKj5rr+HUc
   UytqL1JjKUSIL97cNFX/oJaZmbtnkvg3PJORRCojlhyJQrUnfTxZgm0wJ
   zhhPYRmII3Snh3efi8OlZpjTwhK4bFNKg3K++8l3F9793jpsCu4spZB49
   vaSlnX8r2az3Jesg2/jPNuS5fkRCMFJBkK9GsiG4mQ3Fg/P6Gea+Bi63M
   eZFzbREQaIrOu+gzbSzFayI0JAXDhGdtTq0X1G6TUKDi8CCQDbqEuUukL
   w==;
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="asc'?scan'208";a="236654397"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2023 00:13:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Jul 2023 00:13:28 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 20 Jul 2023 00:13:27 -0700
Date:   Thu, 20 Jul 2023 08:12:54 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Walker Chen <walker.chen@starfivetech.com>
CC:     Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: starfive: Explicitly include correct DT includes
Message-ID: <20230720-captive-wife-8bdd341fa8f5@wendy>
References: <20230714175149.4068174-1-robh@kernel.org>
 <6d503477-82eb-c201-129a-009bcde485d0@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q61HPjpCze90uyKW"
Content-Disposition: inline
In-Reply-To: <6d503477-82eb-c201-129a-009bcde485d0@starfivetech.com>
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

--Q61HPjpCze90uyKW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 02:12:51PM +0800, Walker Chen wrote:
> On 2023/7/15 1:51, Rob Herring wrote:
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it as merged into the regular platform bus.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those include
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
> >=20
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/soc/starfive/jh71xx_pmu.c | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/j=
h71xx_pmu.c
> > index 7d5f50d71c0d..d3b78a619d40 100644
> > --- a/drivers/soc/starfive/jh71xx_pmu.c
> > +++ b/drivers/soc/starfive/jh71xx_pmu.c
> > @@ -10,7 +10,6 @@
> >  #include <linux/iopoll.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > -#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_domain.h>
> >  #include <dt-bindings/power/starfive,jh7110-pmu.h>
>=20
> Nice! Thank you for your careful discovery, this helps simplify the code.

Huh, seems I missed this patch. Now applied, thanks!

--Q61HPjpCze90uyKW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLjedgAKCRB4tDGHoIJi
0vsDAQCuzaEOC//rMky0CIQbHRukRzUFHVoUi5eh/3WIk3BZPwD/f6kXwQ4NNyIS
ZLj28G8IuwKFCpSF6f4Ac2+nAj8e4Qk=
=LdIm
-----END PGP SIGNATURE-----

--Q61HPjpCze90uyKW--
