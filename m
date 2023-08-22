Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689DF784C02
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjHVV3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjHVV3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:29:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DF5CF3;
        Tue, 22 Aug 2023 14:29:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4205464375;
        Tue, 22 Aug 2023 21:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDC8C433C8;
        Tue, 22 Aug 2023 21:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692739752;
        bh=tntbjmmBDt88Ki9dV0KrgN4VlUqrLRu3FZus/NGOeis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uXDdUsgc1UkDTjIF9HGwWUS3dbXAxyRVQI/WyKzdTZNjcnGmESXJQ6SgRvJt0jyxP
         nQBV/vQD3NnAuw5S+Q2uM862Re9MG7pmY3m0TgXiO7dzmCUMU5FIBcMVeZTTsiaZVQ
         VOgR1MXlU496jbYFo0jgKqfLWLpS5CIz/CiF9doggeA3At3QaYlqCVDjGVRtT4lNW0
         5TkloUU0dB9EYwLdCWgvU/Aa+2TsJV6QCsg7ECaJSVuA4zSbMuezwREi2lPV5oIRde
         oDvJ50V7dVrseKH3/6fDHwfQACZc8fWD4pjYC7mBfSX4dAjq/vxw80ad/4gJ+DZiEo
         hXqO7bqm6EISg==
Received: by mercury (Postfix, from userid 1000)
        id 847E71062B36; Tue, 22 Aug 2023 23:29:09 +0200 (CEST)
Date:   Tue, 22 Aug 2023 23:29:09 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: (subset) [PATCH v6 06/10 RESEND] power: supply: rt5033_charger:
 Add cable detection and USB OTG supply
Message-ID: <20230822212909.mcnziqsuu523e4gk@mercury.elektranox.org>
References: <cover.1684182964.git.jahau@rocketmail.com>
 <223b440ab6831f2e7302d2c49b2cfd7779d5effd.1684182964.git.jahau@rocketmail.com>
 <169226510772.947223.494995318945916008.b4-ty@kernel.org>
 <20230822070737.GP1380343@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ktx2qheykwtretld"
Content-Disposition: inline
In-Reply-To: <20230822070737.GP1380343@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ktx2qheykwtretld
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 22, 2023 at 08:07:37AM +0100, Lee Jones wrote:
> On Thu, 17 Aug 2023, Lee Jones wrote:
>=20
> > On Mon, 15 May 2023 22:57:15 +0200, Jakob Hauser wrote:
> > > Implement cable detection by extcon and handle the driver according t=
o the
> > > connector type.
> > >=20
> > > There are basically three types of action: "set_charging", "set_otg" =
and
> > > "set_disconnect".
> > >=20
> > > A forth helper function to "unset_otg" was added because this is used=
 in both
> > > "set_charging" and "set_disconnect". In the first case it covers the =
rather
> > > rare event that someone changes from OTG to charging without disconne=
ct. In
> > > the second case, when disconnecting, the values are set back to the o=
nes from
> > > initialization to return into a defined state.
> > >=20
> > > [...]
> >=20
> > Applied, thanks!
> >=20
> > [06/10] power: supply: rt5033_charger: Add cable detection and USB OTG =
supply
> >         commit: c1af6bcc8583b0a1083338cd26c2090d0bcb0810
>=20
> Multiple fixes now follow this patch, so I am unapplying it.
>=20
> Sebastian, would you mind collecting it up please?

I'm leaving for a two week hiking trip (with basically no internet
access) in some hours. My planed return date is basically when Linus
is expected to tag 6.6-rc1, so I will not queue any more patches and
send my pull request early (within the next few hours).

I planned to catch up with the power-supply backlog last week during
Chaos Communication Camp, but it was too hot to do any sensible
review. Now I expect to process the power-supply backlog in the
week after the merge window.

Greetings and sorry for the inconvenience,

-- Sebastian

--ktx2qheykwtretld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmTlKKIACgkQ2O7X88g7
+pqjYQ//ROIQG4T2Lapk4Xk/B5nCt2gNSRs+4MOpOagMBah1hKrG7uVUIz2n3p3v
DLGombVmYmFyGhJiBN99NdzfbL95WbMGjftJ7Y+TCCdHFPXX7fYxmmaQed7AVq+H
HGQuIMDtFt+JYIPmbvbz+Adsl8+1QUIQp+QKX4DJkoYo1RWS7MujVojFsErAbxw4
KZnMsJuI426C4uFBp+W7PKSnEA0Z8+9L0O1ZDfJl1uW4/mtJTZJH1XEzB9XOpdgP
A5mx29rTvjii6g9h43aiRX6Msc5vbOVvDzI3DNPONyuo84GavL6JKu6WUrTdCB2T
VJowdPUybL7Ub8ZVb0/vzosU9qQzis1uQR1rFTtXAWyHxUf+k1nfA55p/OP4bQRf
GGzYkgkRK1n9U9b4ZLq4S2nASwim85MDvlTGpg/olzv+A3gZXsvGy3F4SCQek1Tj
d87rxX1Hv8Zk4+N/Rpt3QodyklaCZTkC7qJFSzHq/lxIb33/Q5EcKFfk4s8jULwY
r3UosP4gn7rsQUT8Ln/y6KkoPtwcts+Gv21ofiIQ21o5SsEj5CDuAvgDLCsdbgxP
pB4fZw2j41TjeRSLrx/s4OMa18lRpm4FW2i3Oxt14+/IO8ZHwLwZJpEf/gswVVpn
+nuatb3nTikeHaR1V2fqD4GJ1C7gCgT6XSCXfrH8VsgUcE8hy4Q=
=VkC1
-----END PGP SIGNATURE-----

--ktx2qheykwtretld--
