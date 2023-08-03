Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3443576EF1E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjHCQJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjHCQJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:09:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF6A2D54;
        Thu,  3 Aug 2023 09:09:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B26461E2E;
        Thu,  3 Aug 2023 16:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17B0C433C7;
        Thu,  3 Aug 2023 16:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691078975;
        bh=lSJVkTfbON95P1BPKWV/UPmDZSbg52JekuS2qndfKnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UKF3hoIoWjZ2JnCikrqcXLLo5RVbxGvOkmOZiyE+fYebuExZS2x+fEW+UVWC+KBEk
         9EqW09Euzl2BPfh7Aa47ZL15Cp96uPlY2mZBH2lsTlctHFK7KOLUIXx9uFiqqGpsf0
         rI0IdLVzNixXCxKizBkgy57JAqaqkyCmO7/KoWo4FXstzMte/uvDRw/BSaPN2W4PWc
         3BolBh8JnfNu8H5wSixzphLhTjwwVh0pNghI1u8837gbIxZED7d4vs48Zw8j5VQbkP
         EkJ9TG6DAcSp5Cd5ZN1zyvbnmYvBWbpMlymw/hQBakyphwHx3xlOiCKDEydJAY5ckd
         iLB3SSnL0elOg==
Date:   Thu, 3 Aug 2023 17:09:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <rgallaispou@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: st: convert sti-pwm to DT schema
Message-ID: <20230803-sandbox-prideful-4f23b78ddc67@spud>
References: <20230801220559.32530-1-rgallaispou@gmail.com>
 <20230802080238.d3nam6elnern65rb@pengutronix.de>
 <8e74af01-36c6-3a41-6d31-91b09ea62026@gmail.com>
 <20230803085645.svrrcritdifbjwdz@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YM8QKZEAAE3zp/In"
Content-Disposition: inline
In-Reply-To: <20230803085645.svrrcritdifbjwdz@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YM8QKZEAAE3zp/In
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 10:56:45AM +0200, Uwe Kleine-K=F6nig wrote:
> On Thu, Aug 03, 2023 at 09:18:14AM +0200, Rapha=EBl Gallais-Pou wrote:
> > Hi
> >=20
> > Le 02/08/2023 =E0 10:02, Uwe Kleine-K=F6nig a =E9crit=A0:
> > > Hello,
> > >=20
> > > On Wed, Aug 02, 2023 at 12:05:59AM +0200, Raphael Gallais-Pou wrote:
> > > > +  st,capture-num-chan:
> > > > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > > > +    description: Number of available Capture channels.
> > >=20
> > > I have the theory that nobody actually uses the capture feature and I=
'd
> > > like to get rid of it. People who do use it, should better switch to =
the
> > > counter driver.
> >=20
> > TBH I only found two drivers using it, including this one.
> >=20
> > $ grep -rinI "\.capture" drivers/pwm/ | wc -l
> > 2
>=20
> Right, there is pwm-stm32 and pwm-sti that support capture.
>=20
> There are a few machines that have a st,sti-pwm device:
>=20
> 	$ grep -rl st,sti-pwm arch/arm/boot/dts/*.dtb
> 	arch/arm/boot/dts/stih407-b2120.dtb
> 	arch/arm/boot/dts/stih410-b2120.dtb
> 	arch/arm/boot/dts/stih410-b2260.dtb
> 	arch/arm/boot/dts/stih418-b2199.dtb
> 	arch/arm/boot/dts/stih418-b2264.dtb
>=20
> but to actually use capture the device tree must have a property
> st,capture-num-chan. "st,capture-num-chan" isn't set by any of the
> devices.
>=20
> I think for stm32 it's not that trivial to show that it's unused.
> While the capture code isn't a big maintenance burden, I still would
> prefer to get rid of it if nobody uses it. Still more given that there
> are better alternatives available.
>=20
> > If there is no opposition about removing this feature I suggest to do i=
t in
> > a second time, in a serie.
>=20
> Does that mean you will do that? I guess not, but at least this means
> you're not using capture support.

It seems like it should either be done as part of the conversion or as a
second patch in the series doing the conversion /shrug

--YM8QKZEAAE3zp/In
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMvROwAKCRB4tDGHoIJi
0rsBAP9W4ZcZaDLpQ4p91p3GDR6kxwf0M0FjUwJOV5k+MHVzLQEA/huIQjfEVEs4
X5xwyVnO3I0+FfyVNMPK6uDXwyjZgws=
=yoUc
-----END PGP SIGNATURE-----

--YM8QKZEAAE3zp/In--
