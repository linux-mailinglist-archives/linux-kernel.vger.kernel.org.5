Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7364D77432B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjHHR6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHHR5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:57:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A3BC20AA;
        Tue,  8 Aug 2023 09:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 027D5623D2;
        Tue,  8 Aug 2023 12:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD27C433C8;
        Tue,  8 Aug 2023 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691498746;
        bh=57M2u8UPlvZ/iPMyVrQbhx5eMYWe8moJxNKmzCQ1eNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oa5tC5GT2rs94ZvbfUCcaMK/wP/SRTNslJRU+Q+jHjLEe0Uhcr9DpycEMvzrVcFgO
         X+ahxr4gZhgtz9vVLbsu9OC7p6cn08HejFPflzeEvE+j7w1mRi7uPP2glGAvnh1GsO
         vcylR3kURIs7kbPaNCAUPBTGBnu8TvbeEbB3YyKYUkRtfEOp9/PGnGfTst+9VvcOKW
         loHqQ3WTJ72C9m6SavLKblGX6DfaaVGirW+vwTQANrYk0L2epEXyPKZh5zflDICEM1
         wYtoAOHB530FnVkLQotoGJfq2SJ0uspevGZXs1emdJWEXEXMrAO9rfya9O7Is2SvDJ
         BylkEVtNnqEEw==
Date:   Tue, 8 Aug 2023 13:45:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Md Danish Anwar <a0501179@ti.com>
Cc:     Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/5] Introduce IEP driver and packet timestamping
 support
Message-ID: <20230808-nutmeg-mashing-543b41e56aa1@spud>
References: <20230807110048.2611456-1-danishanwar@ti.com>
 <20230808-unnerving-press-7b61f9c521dc@spud>
 <1c8e5369-648e-98cb-cb14-08d700a38283@ti.com>
 <529218f6-2871-79a2-42bb-8f7886ae12c3@kernel.org>
 <8bb5a1eb-3912-c418-88fe-b3d8870e7157@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qy+4LCvJDb1UKTzX"
Content-Disposition: inline
In-Reply-To: <8bb5a1eb-3912-c418-88fe-b3d8870e7157@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qy+4LCvJDb1UKTzX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 06:06:11PM +0530, Md Danish Anwar wrote:
> On 08/08/23 5:52 pm, Roger Quadros wrote:
> >=20
> >=20
> > On 08/08/2023 15:18, Md Danish Anwar wrote:
> >> On 08/08/23 5:38 pm, Conor Dooley wrote:
> >>> On Mon, Aug 07, 2023 at 04:30:43PM +0530, MD Danish Anwar wrote:
> >>>> This series introduces Industrial Ethernet Peripheral (IEP) driver to
> >>>> support timestamping of ethernet packets and thus support PTP and PPS
> >>>> for PRU ICSSG ethernet ports.
> >>>>
> >>>> This series also adds 10M full duplex support for ICSSG ethernet dri=
ver.
> >>>>
> >>>> There are two IEP instances. IEP0 is used for packet timestamping wh=
ile IEP1
> >>>> is used for 10M full duplex support.
> >>>>
> >>>> This is v2 of the series [v1]. It addresses comments made on [v1].
> >>>> This series is based on linux-next(#next-20230807).=20
> >>>>
> >>>> Changes from v1 to v2:
> >>>> *) Addressed Simon's comment to fix reverse xmas tree declaration. S=
ome APIs
> >>>>    in patch 3 and 4 were not following reverse xmas tree variable de=
claration.
> >>>>    Fixed it in this version.
> >>>> *) Addressed Conor's comments and removed unsupported SoCs from comp=
atible
> >>>>    comment in patch 1.=20
> >>>
> >>> I'm sorry I missed responding there before you sent v2, it was a bank
> >>> holiday yesterday. I'm curious why you removed them, rather than just
> >>> added them with a fallback to the ti,am654-icss-iep compatible, given
> >>> your comment that "the same compatible currently works for all these
> >>> 3 SoCs".
> >>
> >> I removed them as currently the driver is being upstreamed only for AM=
654x,
> >> once I start up-streaming the ICSSG driver for AM64 and any other SoC.=
 I will
> >> add them here. If at that time we are still using same compatible, the=
n I will
> >> modify the comment otherwise add new compatible.
> >>
> >> As of now, I don't see the need of adding other SoCs in iep binding as=
 IEP
> >> driver up-streaming is only planned for AM654x as of now.
> >=20
> > But, is there any difference in IEP hardware/driver for the other SoCs?
> > AFAIK the same IP is used on all SoCs.
> >=20
> > If there is no hardware/code change then we don't need to introduce a n=
ew compatible.
> > The comment for all SoCs can already be there right from the start.
> >=20
>=20
> There is no code change. The same compatible is used for other SoCs. Even=
 if
> the code is same I was thinking to keep the compatible as below now
>=20
> - ti,am654-icss-iep   # for K3 AM65x SoCs
>=20
> and once other SoCs are introduced, I will just modify the comment,
>=20
> - ti,am654-icss-iep   # for K3 AM65x, AM64x SoCs
>=20
> But we can also keep the all SoCs in comment right from start as well. I =
am
> fine with both.

> Conor / Roger, Please let me know which approach should I go with in next=
 revision?

IMO, "ti,am564-icss-iep" goes in the driver and the other SoCs get
specific compatibles in the binding with "ti,am564-icss-iep" as a
fallback.

--Qy+4LCvJDb1UKTzX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNI48wAKCRB4tDGHoIJi
0vd2AQCD1PBK5RG7PeNLxT8QjAC0nZ3ESYCKNWXzG8O/6AIM+QEA8NaT/8p8YQuh
H0bgixdfcJbyHFc0KwqR5+q6nbo3pw8=
=LIWP
-----END PGP SIGNATURE-----

--Qy+4LCvJDb1UKTzX--
