Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2207DB92F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjJ3Ll5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjJ3Llz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:41:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD60D6;
        Mon, 30 Oct 2023 04:41:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65602C433C7;
        Mon, 30 Oct 2023 11:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698666113;
        bh=bz6igKuHupvtiNkw5ZoF2Pc2VCrbtGARD3I17VSwiOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eGe08F3jZZRbIVv+zeX+3ej6MJOvO8BbTuxF4TM8a4QQEctmK5gGGcGSSrzPNndtC
         ++VoH2AX4C14RrLR/AZaPILnRnqbco6FVT/+kFNOPVVS4NE5dsascnNysqFp4ref2/
         +FhTtbmC5KSDCu0/tN8hKJsUP/uouNiN74inofe4YyiFOWmX19x6lgeqQgqZ15HHBo
         e9SCP0HtWw8R25pl1Ah0ULmwyJhAn/zzalSfkR5zM3k5cVeF+YyUyFXn2gcwh7xeBi
         HQvC/sgdxancozu84+rwT7jgtaLXhNgGdNFHS/HDr0+t5M+G3J9yvvo0cMS5Wvs38g
         xx5X8cpT2eRLg==
Date:   Mon, 30 Oct 2023 11:41:47 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: clock: brcm,kona-ccu: convert to YAML
Message-ID: <20231030-afternoon-traps-f7b20de220e2@spud>
References: <ZTf0oWfOqnyMEKbF@standask-GA-A55M-S2HP>
 <20231027-bulldog-component-5b84e4660465@spud>
 <ZTzw5c5/MwU3VOBo@standask-GA-A55M-S2HP>
 <5bd796c5-3e9a-4aa5-b284-27fb4fc8ea48@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3lNzro6sSew2kpsK"
Content-Disposition: inline
In-Reply-To: <5bd796c5-3e9a-4aa5-b284-27fb4fc8ea48@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3lNzro6sSew2kpsK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 10:16:14PM +0100, Artur Weber wrote:
>=20
> On 28/10/2023 13:30, Stanislav Jakubek wrote:
> > On Fri, Oct 27, 2023 at 03:47:48PM +0100, Conor Dooley wrote:
> > > On Tue, Oct 24, 2023 at 06:45:21PM +0200, Stanislav Jakubek wrote:
> > > > Convert Broadcom Kona family clock controller unit (CCU) bindings
> > > > to DT schema.
> > >=20
> > > I didn't cross-check the clock-output-names, but this conversion most=
ly
> > > looks good to me.
> > >=20
> > > > Changes during conversion:
> > > >    - remove "dmac" from clock-output-names for brcm,bcm11351-master=
-ccu,
> > > >      it is not used in DT nor the dt-bindings
> > > >    - remove "uartb4" from clock-output-names for brcm,bcm21664-slav=
e-ccu,
> > > >      it is not used in DT nor the dt-bindings
> > >=20
> > > This I'm not sure about - they _were_ documented in the text-form
> > > dt-binding, even if they weren't used in the dts. If the clock
> > > controller does actually produce these clocks, removing them doesn't
> > > make sense to me.
> >=20
> > Hi Conor. Looking at downstream, I was not able to find these clocks, t=
hough
> > I admit that I'm not familiar enough with the downstream mess to be 100%
> > confident.
> >=20
> >  From what I can tell, the BCM21664 arch/arm/mach-hawaii/clock.c (e.g. =
[1])
> > doesn't contain any mention of uartb4, only uartb, uartb2 and uartb3.
> > And similarly, for the BCM281XX arch/arm/mach-capri/clock_capri.c (e.g.=
 [2])
> > I wasn't able to find any mention of dmac, only dmac_mux_apb and dma_axi
> > (though these two don't seem to be supported on mainline yet).
>=20
> I've done some digging in the downstream kernel; for the BCM21664, I'm
> almost certain that the uartb4 clock doesn't exist. Broadcom helpfully
> left in "RDB" files containing the entire register layout of all of the
> components; and even in the RDB for the slave clock manager[1] (used by
> the other uart clocks), there is no uartb4, nor is it mentioned
> anywhere else in the kernel (judging by a quick grep in the kernel
> sources).
>=20
> As for the BCM281XX clocks, there indeed doesn't seem to be an exact
> "dmac" clock but there is a "dmac" clock gate register[2], which is
> used for the dma_axi clock, so perhaps that's what this is referring
> to? Also not 100% certain.

I'm 99% sure I was happy with this otherwise, so thanks for doing the
investigation guys :)

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--3lNzro6sSew2kpsK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZT+WegAKCRB4tDGHoIJi
0sxPAPwLvrTjRs6fj26uMHvW8nOf+sn8iPT13yt8UCj0kyWmIgD8CiKefsXxXRls
oDopVlrjt1bwZ+qq7+OGZg3ey9hxQwI=
=emOG
-----END PGP SIGNATURE-----

--3lNzro6sSew2kpsK--
