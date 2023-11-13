Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AED67EA4A9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjKMURm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMURl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:17:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CEFD72;
        Mon, 13 Nov 2023 12:17:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32326C433C8;
        Mon, 13 Nov 2023 20:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699906657;
        bh=SwYHSTS3rTDa7Clubx8Dvf8G10g50QTr2Ibg/KW4oWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEVjZcuRKwNGSQo9Z6hggcHjls2BO5bwob2sN4A61qPt1Uh6cI04CVwi9R2lNafsk
         xPKVEfsNctoAo553B7Xq6hoXvJFPysMDNE78i1wBmptzl6gqTGF5BgB0N28fEzY1aK
         st537PkxXo0+tfaXS9L3+rfGrv5TIvO1ysTsQjMGfxC+Zt/mxpI/56hN+xtKlrezi8
         e4PO3k//uYLFRfXmK8+nPg2pCeTZeLHCYVSS/oA04kREcTwxfn/FHl1IxxIEQh3ZXk
         x74FxaEUvqhxZAVD1rKJkcBXFuibj9IRyz3Tf9ouXuS/KIM2exjrISpl9x0hTn9VlI
         E8nyjOsK4wQDg==
Date:   Mon, 13 Nov 2023 20:17:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v7 1/4] dt-bindings: pwm: Add OpenCores PWM module
Message-ID: <20231113-sprung-tantrum-94659009b9d4@squawk>
References: <20231110062039.103339-1-william.qiu@starfivetech.com>
 <20231110062039.103339-2-william.qiu@starfivetech.com>
 <afce202d-6234-4c5f-9018-facd9a56b5eb@linaro.org>
 <f4551a7a-61e6-4d97-94c2-da2e4e9e8cb3@starfivetech.com>
 <824cee7b-e4d3-461a-8bfb-4ad095c240fd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+lpp7srQCeLErYm2"
Content-Disposition: inline
In-Reply-To: <824cee7b-e4d3-461a-8bfb-4ad095c240fd@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+lpp7srQCeLErYm2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 09:07:15PM +0100, Krzysztof Kozlowski wrote:
> On 13/11/2023 10:42, William Qiu wrote:
> > Will update.
> >>> +
> >>> +allOf:
> >>> +  - $ref: pwm.yaml#
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    oneOf:
> >>> +      - items:
> >>> +          - enum:
> >>> +              - starfive,jh7100-pwm
> >>> +              - starfive,jh7110-pwm
> >>> +          - const: opencores,pwm
> >>
> >> That's a very, very generic compatible. Are you sure, 100% sure, that
> >> all designs from OpenCores from now till next 100 years will be 100%
> >> compatible?
> >>
> > My description is not accurate enough, this is OpenCores PTC IP, and PWM
> > is one of those modes, so it might be better to replace compatible with
> > "opencores, ptc-pwm"
> >=20
> > What do you think?
>=20
> Sorry, maybe this answers maybe doesn't. What is "PTC"?

"pwm timer counter". AFAIU, the IP can be configured to provide all 3.
I think that William pointed out on an earlier revision that they have
only implemented the pwm on their hardware.
I don't think putting in "ptc" is a sufficient differentiator though, as
clearly there could be several different versions of "ptc-pwm" that have
the same concern about "all designs from OpenCores for now till the next
100 years" being compatible.

Cheers.
Conor.

--+lpp7srQCeLErYm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVKEWgAKCRB4tDGHoIJi
0lg6AQDoetFH+2Q0R2VopRs52W7OWITEOpAFd04nMYVyHdsONgD+LawAuiiSLaEB
0ECkKGOudEZJ6nR1cZ/Vt+FGfB1MyAs=
=sVnT
-----END PGP SIGNATURE-----

--+lpp7srQCeLErYm2--
