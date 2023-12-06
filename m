Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2B7807271
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378842AbjLFObi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378823AbjLFObg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:31:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2681D40
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:31:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9BCC433C7;
        Wed,  6 Dec 2023 14:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701873102;
        bh=jxQtCX9Tnj5Rn5bgII5oPUR6Vl+e2nBLKxf7aaoQeMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KzMUmksiJQNyvHH9O1O5A2uWk+4owp54WXqV28gCUOj5HpzeCiAd56Bi+vY14f1EM
         eUhWfanjkDqFYfr9AtbhtYkVN1lLeiUJMT0nUErzs0Wn5xl6OXxh/R1YFjeoJGi1k3
         Z/11WR2zHc6B9HRuYpMJ/7eH9c5ac9pSmXpI1NJ0l3Z8TDUsD75f+NXh2Kzg0kiN8V
         Z2d55NLUJvmDjhNuOU244HEqu4TPdrxDcQUlVXGkXzT0W6/iGWI5qTQQcwvQtrvby7
         2uPwlDrElvAc1CfgBiXMUxr4yM+HdejfAsHKcv6XH2fKUqbDvl53akwJh0Jyx6YxA+
         pgxf/NKhirbUg==
Date:   Wed, 6 Dec 2023 15:31:39 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Parshuram Thombare <pthombar@cadence.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 0/4] drm: Fix errors about uninitialized/wrong
 variables
Message-ID: <be65q5mrkoq55lnusz6xm2s6vl5h7gt3333j7lrazutrngbyom@m3atoa24sxzg>
References: <20231103-uninit-fixes-v2-0-c22b2444f5f5@ideasonboard.com>
 <0d458603-fc4a-44cc-bf90-eccee875d014@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t2peozghuvu7sqte"
Content-Disposition: inline
In-Reply-To: <0d458603-fc4a-44cc-bf90-eccee875d014@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t2peozghuvu7sqte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 02:50:57PM +0200, Tomi Valkeinen wrote:
> Hi all,
>=20
> On 03/11/2023 15:14, Tomi Valkeinen wrote:
> > Fix cases where smatch reports a use of an uninitialized variable, and
> > one where the variable is initialized but contains wrong value.
> >=20
> >   Tomi
> >=20
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > ---
> > Changes in v2:
> > - Added two more fixes
> > - Link to v1: https://lore.kernel.org/r/20230804-uninit-fixes-v1-0-a607=
72c04db5@ideasonboard.com
> >=20
> > ---
> > Tomi Valkeinen (4):
> >        drm/drm_file: fix use of uninitialized variable
> >        drm/framebuffer: Fix use of uninitialized variable
> >        drm/bridge: cdns-mhdp8546: Fix use of uninitialized variable
> >        drm/bridge: tc358767: Fix return value on error case
> >=20
> >   drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c | 3 ++-
> >   drivers/gpu/drm/bridge/tc358767.c                   | 2 +-
> >   drivers/gpu/drm/drm_file.c                          | 2 +-
> >   drivers/gpu/drm/drm_framebuffer.c                   | 2 +-
> >   4 files changed, 5 insertions(+), 4 deletions(-)
> > ---
> > base-commit: 9d7c8c066916f231ca0ed4e4fce6c4b58ca3e451
> > change-id: 20230804-uninit-fixes-188f92d60ac3
> >=20
> > Best regards,
>=20
> Ping on this (or I'll forget the series...).

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--t2peozghuvu7sqte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXCFywAKCRDj7w1vZxhR
xWkGAP9+CxSw6oCLELzhvUt4toOjxTWe1Z4y84jRB9x56ljN4gD/X8l9hCmN36Yb
nqU83CX7rysJsuBCQHLyz/n0gh1zEAI=
=C+yp
-----END PGP SIGNATURE-----

--t2peozghuvu7sqte--
