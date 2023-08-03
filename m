Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA3976E3B7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbjHCI5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjHCI5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:57:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4640DE46
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:57:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRU8W-0000PT-EI; Thu, 03 Aug 2023 10:56:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRU8U-000nhX-7v; Thu, 03 Aug 2023 10:56:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRU8T-00A6Il-JQ; Thu, 03 Aug 2023 10:56:45 +0200
Date:   Thu, 3 Aug 2023 10:56:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?Q?Rapha=C3=ABl?= Gallais-Pou <rgallaispou@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: st: convert sti-pwm to DT schema
Message-ID: <20230803085645.svrrcritdifbjwdz@pengutronix.de>
References: <20230801220559.32530-1-rgallaispou@gmail.com>
 <20230802080238.d3nam6elnern65rb@pengutronix.de>
 <8e74af01-36c6-3a41-6d31-91b09ea62026@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qtjumvqtwxq43ajp"
Content-Disposition: inline
In-Reply-To: <8e74af01-36c6-3a41-6d31-91b09ea62026@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qtjumvqtwxq43ajp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 09:18:14AM +0200, Rapha=EBl Gallais-Pou wrote:
> Hi
>=20
> Le 02/08/2023 =E0 10:02, Uwe Kleine-K=F6nig a =E9crit=A0:
> > Hello,
> >=20
> > On Wed, Aug 02, 2023 at 12:05:59AM +0200, Raphael Gallais-Pou wrote:
> > > +  st,capture-num-chan:
> > > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > > +    description: Number of available Capture channels.
> >=20
> > I have the theory that nobody actually uses the capture feature and I'd
> > like to get rid of it. People who do use it, should better switch to the
> > counter driver.
>=20
> TBH I only found two drivers using it, including this one.
>=20
> $ grep -rinI "\.capture" drivers/pwm/ | wc -l
> 2

Right, there is pwm-stm32 and pwm-sti that support capture.

There are a few machines that have a st,sti-pwm device:

	$ grep -rl st,sti-pwm arch/arm/boot/dts/*.dtb
	arch/arm/boot/dts/stih407-b2120.dtb
	arch/arm/boot/dts/stih410-b2120.dtb
	arch/arm/boot/dts/stih410-b2260.dtb
	arch/arm/boot/dts/stih418-b2199.dtb
	arch/arm/boot/dts/stih418-b2264.dtb

but to actually use capture the device tree must have a property
st,capture-num-chan. "st,capture-num-chan" isn't set by any of the
devices.

I think for stm32 it's not that trivial to show that it's unused.
While the capture code isn't a big maintenance burden, I still would
prefer to get rid of it if nobody uses it. Still more given that there
are better alternatives available.

> If there is no opposition about removing this feature I suggest to do it =
in
> a second time, in a serie.

Does that mean you will do that? I guess not, but at least this means
you're not using capture support.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qtjumvqtwxq43ajp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTLa8wACgkQj4D7WH0S
/k5kqAf5AUlS1PFYKiPBmxelcFtkKh5q7ONNjSqWzlujDKL9ZKQemH6LC5WnHobm
I97fyE6PD/asmAvBJ41YzCGUIxQyqK7JnLKrKYwQuVOPojcx/Dbvh599hFwxq3Vf
ySU3AUjuH0Ynilp2NDui50nPMSHt/Y0OFNuyBsDz5fvxvmf/nJ9pKN7+QRHEWkxv
+yGub7i28h5kXue2v8OUPz5fO3BV6K4HkYeZwhh4hJNSEdx9uuJMbgwW/PktREWU
uAY6VQyHi+jOf5kDaWA9fpKBDKyNIYmNg2dU20lzB91M2RRlpfHr7R6PLhzjQJbv
CjOIRmhHKn+VbdvMg1FQw1E5HM45og==
=71Vl
-----END PGP SIGNATURE-----

--qtjumvqtwxq43ajp--
