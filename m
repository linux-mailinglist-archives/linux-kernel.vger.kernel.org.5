Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27D87A3511
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 12:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbjIQKDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 06:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbjIQKCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 06:02:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FAB18E;
        Sun, 17 Sep 2023 03:02:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC82C433C8;
        Sun, 17 Sep 2023 10:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694944965;
        bh=Yx0C/LPc7fwyXJG8rpC6fgaxCVhPZjt7jlvRHPWAjVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KI9WEKSTxtksk44Tf+UGk2y57gn79PHe+IDxI1Bm9ScQD6I3h+pZVkRLd3VsMJoMa
         G2P4KfJVo0e0DBByZ3Bhb99HOnBezAQFlHG1GRiBpm8r2UpYCkVlc2g4EmKDMLteXV
         B0Vs0iBiM8HvTbsUHBFEWSDoC/+PE6YEYOgwMIk9Jo/xo/9y7P94iXlpOnX4kR9I4t
         m3eUNXY49i4JufDPHQDaiUPXUn+uiStgpHNjZfvK68beOTW95ErgRJmikVqommS/xD
         J0vwdG1s2T4hbfFysWOQ1zZ/GRM7bci9S0YM0TQUlpeKyRhHf5m+22BNuqaHIitYOY
         lNkq1ripirkug==
Date:   Sun, 17 Sep 2023 11:02:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Nik Bune <n3q5u8@yahoo.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: atmel,at91rm9200-wdt: convert txt
 to yaml
Message-ID: <20230917-shampoo-prance-972b224e2c92@spud>
References: <20230916154826.84925-1-n3q5u8.ref@yahoo.com>
 <20230916154826.84925-1-n3q5u8@yahoo.com>
 <c42f1653-caa8-731c-e4ef-2d5fe47adc8c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB05wVaZPoWhCPv0"
Content-Disposition: inline
In-Reply-To: <c42f1653-caa8-731c-e4ef-2d5fe47adc8c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB05wVaZPoWhCPv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 16, 2023 at 10:37:23PM +0200, Krzysztof Kozlowski wrote:
> On 16/09/2023 17:48, Nik Bune wrote:
> > Convert txt file to yaml.=20
> > Add reg to the list of required properties.
> > Add mainteiners from ./scripts/get_maintainer.pl output.
> >=20
> > Signed-off-by: Nik Bune <n3q5u8@yahoo.com>
> > ---
> >  .../watchdog/atmel,at91rm9200-wdt.yaml        | 31 +++++++++++++++++++
> >  .../watchdog/atmel-at91rm9200-wdt.txt         |  9 ------
> >  2 files changed, 31 insertions(+), 9 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at=
91rm9200-wdt.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at=
91rm9200-wdt.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/watchdog/atmel,at91rm920=
0-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wd=
t.yaml
> > new file mode 100644
> > index 000000000000..e9706b9c1e6b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.y=
aml
> > @@ -0,0 +1,31 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
>=20
> How this copyright appeared here? Why are you adding some 2022
> copyrights of someone else?

It's worth noting that that patch also re-licences the original binding,
and was not written by anyone from microchip in the first place.

--TB05wVaZPoWhCPv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQbOwAAKCRB4tDGHoIJi
0ptWAQDcGuIl+LD+PGu+xPcAWqHEhX/rrdCXmItgDD7kVJ06OAD9EzYnuv+tL5th
Af1Scq9wQ8HqcYJdhIHvZEqguaW+5A4=
=wDPU
-----END PGP SIGNATURE-----

--TB05wVaZPoWhCPv0--
