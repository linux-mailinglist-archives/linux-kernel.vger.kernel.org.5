Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2957FF3C6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjK3Pms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjK3Pmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:42:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709F783
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:42:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521EFC433C7;
        Thu, 30 Nov 2023 15:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701358973;
        bh=WlLJfUiHU4McYxn94NiMcp46fAMc3TUOTPbaqBQLG/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=teECoiBPqM0U8Ehit9ioXGecjoILrpbNTcS1O2v2z0ZmW1ykgsH7a4/6pqOApmFM0
         iXoroSoJBwStm48mdd1gqCoLdp7Nk6hOIek2RQgE8wHHgST2c3TGg/smVi6rudWJQs
         HPnhortTfNkXdF6MXLsRFfj8q3q3tHh4x8lYuZ9h5PScStSDii4kaTjdv3yGvUV1DT
         E5vlrni/BHqpfhlweGh5vsL1ewX6wVf9S2P84sMFIcXrut/zAznT9cm/87IHbF956N
         xz+JcqjR/7nqj2w2aUkMzRNz+RkcsojXMc3clL9jGOsWNLZN/hXk3M8HZJ299zaqP5
         2k+p13+Ph0Klw==
Date:   Thu, 30 Nov 2023 15:42:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Thomas Richard <thomas.richard@bootlin.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, u-kumar1@ti.com
Subject: Re: [PATCH 1/5] dt-bindings: arm: keystone: add ti,j7200-sci
 compatible
Message-ID: <20231130-repugnant-aghast-0bc35af8de3c@spud>
References: <20231129-j7200-tisci-s2r-v1-0-c1d5964ed574@bootlin.com>
 <20231129-j7200-tisci-s2r-v1-1-c1d5964ed574@bootlin.com>
 <20231129-caress-banister-5b5ccbf183e6@spud>
 <20231129-crawling-gaming-76077ed03c57@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zEaYWprFLeGvpHlX"
Content-Disposition: inline
In-Reply-To: <20231129-crawling-gaming-76077ed03c57@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zEaYWprFLeGvpHlX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 03:38:04PM +0000, Conor Dooley wrote:
> On Wed, Nov 29, 2023 at 03:34:20PM +0000, Conor Dooley wrote:
> > On Wed, Nov 29, 2023 at 04:31:17PM +0100, Thomas Richard wrote:
> > > On j7200, during suspend to ram the soc is powered-off.
> > > At resume requested irqs shall be restored which is a different behav=
ior
> > > from other platforms.
> > >=20
> > > Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> >=20
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Un-Acked. Your dts patch contradicts this one.
>=20
> Is the programming model compatible with the existing devices? To be
> compatible, the existing device only need to support a compatible subset
> of behaviours.
> If so, this patch is wrong. If not, then the dts one is.

Given Andrew's response, it looks like the dts patch is the correct one
of the two, and this patch should document the k2g as a fallback for the
jh7200.

Cheers,
Conor.

--zEaYWprFLeGvpHlX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWitdwAKCRB4tDGHoIJi
0mkhAP98vayPMHoouzmPwyTjP5SrWcx1W4mXtH9nl8OtgqZpbQEAzHUQkAjTUikM
Ync+Qp1rElNGrwDq0R1MRMGtTgimSwc=
=2kcW
-----END PGP SIGNATURE-----

--zEaYWprFLeGvpHlX--
