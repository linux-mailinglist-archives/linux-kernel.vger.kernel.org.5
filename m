Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BE281320C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573105AbjLNNrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjLNNrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:47:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001818E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:47:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03207C433C8;
        Thu, 14 Dec 2023 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702561641;
        bh=lWqoyY+Lp0x9QIy2h5s/P2Ib5HZKYH1QdBbOLtUFQsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p/Diy8RFki0Xj0UHq3i2rCZfhaqQg8EttcvF9psMEeM0+YTNy7zkRYMakriJZiqLK
         dBOBbHJ+2pqIQ0Qiwgg2Tr1V9wqcoRJR7PDuwBSk4mBYFvTth01psHiZwYVmPnOXFz
         5ZxP23bDpK1suw9uvM+qoQSUZ5tw10ARjNfqk6zQtsFdG1PWOwxgbD2ZmqHv2CYbpC
         9VPpcEJFmiFv05M30RH9pLf4nm5OPAT2tauPWu6Qol9Fq1zAhY/NLJC7PSJXfnbV27
         uuzPsug4M8oVleSFbo6yHZdfymHCVUNOMf/YNt6auGzR7/YglzJO7oLpFmFiQT9mXD
         5eH3JiIG3ZIhQ==
Date:   Thu, 14 Dec 2023 13:47:14 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Brandon Cheo Fusi <fusibrandon13@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/5] riscv: dts: allwinner: Update opp table to allow CPU
 frequency scaling
Message-ID: <20231214-junkyard-corset-d35b01bad69f@spud>
References: <20231214103342.30775-1-fusibrandon13@gmail.com>
 <20231214103342.30775-2-fusibrandon13@gmail.com>
 <20231214111446.camz2krqanaieybh@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Bt0sbK2SeaAxN2v"
Content-Disposition: inline
In-Reply-To: <20231214111446.camz2krqanaieybh@vireshk-i7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Bt0sbK2SeaAxN2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 04:44:46PM +0530, Viresh Kumar wrote:
> On 14-12-23, 11:33, Brandon Cheo Fusi wrote:
> > Two OPPs are currently defined for the D1/D1s; one at 408MHz and
> > another at 1.08GHz. Switching between these can be done with the
> > "sun50i-cpufreq-nvmem" driver. This patch populates the opp table
> > appropriately, with inspiration from
> > https://github.com/Tina-Linux/linux-5.4/blob/master/arch/riscv/boot/dts=
/sunxi/sun20iw1p1.dtsi
> >=20
> > The supply voltages are PWM-controlled, but support for that IP
> > is still in the works. So stick to a fixed 0.9V vdd-cpu supply,
> > which seems to be the default on most D1 boards.
> >=20
> > Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > ---
> >  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv=
/boot/dts/allwinner/sun20i-d1s.dtsi
> > index 64c3c2e6c..e211fe4c7 100644
> > --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > @@ -39,16 +39,22 @@ cpu0_intc: interrupt-controller {
> >  	};
> > =20
> >  	opp_table_cpu: opp-table-cpu {
> > -		compatible =3D "operating-points-v2";
> > +		compatible =3D "allwinner,sun20i-d1-operating-points",
>=20
> I don't think you should add a new compatible for every SoC that needs
> to be supported by a DT bindings and cpufreq driver. Maybe you should
> just reuse "allwinner,sun50i-h6-operating-points" and it will work
> fine for you ?
>=20
> Rob ?

The driver can definitely just reuse sun50i-h6, but the binding and
devicetree should have a soc-specific compatible for the sun20i-d1.

That said, the compatible does need to be documented, there's a
dt-bindings patch missing from this series.

Cheers,
Conor.

--4Bt0sbK2SeaAxN2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXsHYgAKCRB4tDGHoIJi
0llNAPwPlCtHYqdw3PHm/F9o63nh77wIsWE9SawYpIg6XvVYSQEA3ontbKuKxaUy
sMpsYI0c/7MsH2HbQPLjiFJVxobR5wo=
=L6Mk
-----END PGP SIGNATURE-----

--4Bt0sbK2SeaAxN2v--
