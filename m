Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298DF7A5B37
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjISHiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjISHhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:37:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4100C116;
        Tue, 19 Sep 2023 00:37:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4926FC433CA;
        Tue, 19 Sep 2023 07:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695109061;
        bh=NJEdOhSplERf4qx+MZnaddtdGxjwkTj9FA70yGwEl/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=toJGkyN//X1dq/GlVmSCP5BAImC4qNkx0+qvdGNKwgIg4nWdrMsNY3PSR0LhC8ey6
         C6+w/YZpgqJtNnUImwuowlzhbwSJg/GDc2ONrxID0oKvtqayMHYIXYRPPiyamykENZ
         e+TARbge08QSDBvNJQDO9cN672fNX0dzU/CHe43RvDVGoeQZ4OXCCDjW+SJ0byGQil
         9fh2QIkA9HgWdNZTNqZEZ3VwNWKobCNo9MBFNopyWfkRdPQMtRpCRKq+aDqYbywaeD
         Ps9K6b7AMDHjKLH1jXSd3fAGprFS2WLFcz+O4Ec//le6qhvGvAvknDoCYivh3lVr2x
         otIj5mwBAL7eQ==
Date:   Tue, 19 Sep 2023 09:37:38 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
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
        Frank Oltmanns <frank@oltmanns.dev>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 00/13] imx8mp: first clock propagation attempt (for LVDS)
Message-ID: <fzu4iwxh7tak65twym35p7oik2nt4ke6khmmamzz7q2uopu736@cimranz73wvt>
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
 <CAHCN7xJ8KrBd-532=gDE+82xo1ZNtoDT7pZsYwy9-9WiJvmkvw@mail.gmail.com>
 <CAJpcXm6OWNODOz5gEWVhOJjKTazwzE7XV6ZR1H06zpECrivZig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zkw33pnzrz7sbey3"
Content-Disposition: inline
In-Reply-To: <CAJpcXm6OWNODOz5gEWVhOJjKTazwzE7XV6ZR1H06zpECrivZig@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zkw33pnzrz7sbey3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 07:59:16PM +0200, Benjamin Bara wrote:
> Hi Adam!
>=20
> On Mon, 18 Sept 2023 at 07:00, Adam Ford <aford173@gmail.com> wrote:
> > On Sun, Sep 17, 2023 at 3:40=E2=80=AFPM Benjamin Bara <bbara93@gmail.co=
m> wrote:
> > > The idea:
> > > Enable CLK_SET_RATE_PARENT, at least for media_disp2_pix and media_ld=
b.
> > > When this is done, ensure that the pll1443x can be re-configured,
> > > meaning it ensures that an already configured rate (crtc rate) is sti=
ll
> > > supported when a second child requires a different rate (lvds rate). =
As
> >
> > Have you tested with the DSI as well?  If memory servers, the DSI
> > clock and the LVDS clock are both clocked from the same video_pll.  At
> > one time, I had done some experimentation with trying the DSI
> > connected to an HDMI bridge chip connected to a monitor and the LVDS
> > was connected to a display panel with a static resolution and refresh
> > rate.  For my LVDS display, it needs 30MHz to display properly, but
> > various HDMI resolutions needed values that were not evenly divisible
> > by 30MHz which appeared to cause display sync issues when trying to
> > share a clock that was trying to dynamically adjust for two different
> > displays especially when trying to change the resoltuion of the HDMI
> > display to various values for different resolutions.
>=20
> Unfortunately I haven't. I think if you have the use case to support
> different "run-time-dynamic" (HDMI) rates in parallel with a static
> (LVDS) rate

If anything, LVDS is harder to deal with than HDMI. HDMI only has a
handful of clock rates (74.250, 148.5, 297 and 594MHz mostly) while LVDS
is more freeform.

We are more likely to change the rate on an HDMI device though, but a
rate change from 1080p to 720p would only require a divide by two (from
148.5 to 74.250) so fairly easy to do.

Maxime

--zkw33pnzrz7sbey3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZQlPwgAKCRDj7w1vZxhR
xQXZAP0X9+g7TAJgG9bUbGB3HDyh4TifaZt/f4MAA2x26s9IQQD/YvP1E9Pg3wEZ
aHBt6URFPtaaQv1p3sB+/iouDuI0mgU=
=L9fk
-----END PGP SIGNATURE-----

--zkw33pnzrz7sbey3--
