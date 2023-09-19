Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F5D7A5B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjISHkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjISHkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:40:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE9E10F;
        Tue, 19 Sep 2023 00:40:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84182C433C8;
        Tue, 19 Sep 2023 07:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695109201;
        bh=K/CCEQLfGgec2HfKP4kI3szqGJXJsj/NkOCSY7wCACM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIWCsBhc7S6fqc6ADy3uTx3eaAdpdcYTDmt4/1DV/E4ACTcJ7tj8JzAoAFE/wH4jw
         GKpjxyhTUeUHrKIxynBEbDemlIddXqOs1i+sR4BY0pNEYaqrx4TAdnElujazcOdXnk
         Ffd7zDNRf/M34tzX0ZXMYWhCExs4DqhV+b2nDYEjaA65wh377k07HVdJcAzuvyySnO
         VpFIWU0Q6ZSgJQrAzsFDql1FfQncAO5n4whiMcYOmfZf6dBcujtBXoDh7wAgllqasr
         MJqNYkAGrMRWPr3xTcCQTnrr2117okVg9aoUXPooayvkJXkbdMG2NjVSUtWadwfC5e
         TtKo0pMJ3Snyg==
Date:   Tue, 19 Sep 2023 09:39:58 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 00/13] imx8mp: first clock propagation attempt (for LVDS)
Message-ID: <z363tfhxt3h2rfe3vguwruelggoazdpdsojrjhebon6s6ejs2g@cxgxizho2jxp>
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
 <87fs3bbdjb.fsf@oltmanns.dev>
 <CAJpcXm7nrLzbDmNVCACy3ycBnhWY7HxWhCwroOCF-+GfMT_A9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="24bhmfbcnblmpqxn"
Content-Disposition: inline
In-Reply-To: <CAJpcXm7nrLzbDmNVCACy3ycBnhWY7HxWhCwroOCF-+GfMT_A9w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--24bhmfbcnblmpqxn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 08:05:48PM +0200, Benjamin Bara wrote:
> Hi Frank!
>=20
> On Mon, 18 Sept 2023 at 19:24, Frank Oltmanns <frank@oltmanns.dev> wrote:
> > On 2023-09-18 at 00:39:56 +0200, Benjamin Bara <bbara93@gmail.com> wrot=
e:
> > Thank you very much for including me in the discussion. If I understood
> > Maxime correctly, your proposal is close to what he was suggesting in
> > the discussion you referenced. Unfortunately, it doesn't cover the
> > rounding aspect (which you also mentioned in your cover letter and the
> > description for clk_detect_unintended_rate_changes in patch 7. I've been
> > pondering the last three weeks how to find a good solution to this
> > problem, but so far haven't found any.
>=20
> I think if we stick to the idea of always enforcing the exact "typical
> rate", we cannot avoid physically impossible cases. IMHO, it might make
> sense to add a set_rate() function with a "timing_entry" (e.g. used by
> display_timing.h[1]) to the clock API, which gives a suggestion but also
> defines the "real" boundaries. This would provide a shared parent PLL
> more freedom to provide a satisfying rate for all its children.

It's definitely something we should do, and I've wanted to do that for a
while.

The clock rate is not the only thing we can change though. The usual
trick is to modify the blanking areas to come up with a rate that
matches what the hardware can provide without modifying the framerate.

It belongs more in a KMS helper

Maxime

--24bhmfbcnblmpqxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZQlQTgAKCRDj7w1vZxhR
xSZrAQCXDBYBR1qegeYM/FX3JRolA9OAusZu69+JCObLx9va1wEAvh7wvzcpJ5z7
D8FLajZsctnmmyoJ2o/3IGxHtUP/ows=
=D/La
-----END PGP SIGNATURE-----

--24bhmfbcnblmpqxn--
