Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2184176E440
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjHCJWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjHCJWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:22:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A78F5;
        Thu,  3 Aug 2023 02:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C513961CE3;
        Thu,  3 Aug 2023 09:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3546C433C7;
        Thu,  3 Aug 2023 09:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691054563;
        bh=cDmDQ8IkJZfXXy9N2FqpfneiI87FSMvPq0LWI6XcjdY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=KxV+ZVVlSs9VQfoNtjLUjd+jQ4ttlo3PnspBD5VRFXFBd4r/ieW5v2lpzqGGecg3D
         1DLEoyK4bdkQXm/e77LYwxuDbSJVYMTToNhztNBbgJyts0HMu639ceNZW/LJNz1Mr/
         2lAbOjKYIvejy2jaNYMmS3K4TzskRdm8y7ce5tjOSufH3f8qUc+r7ex+wKHVJZQRTp
         5aA+0KKl9vmxEzp4OgWP9kuDuXM7PPq1TeAx5z6h2C7YmOw4IgoaImduwZLvPIHCKV
         ZliBT+k+c51SgZt7IJ121Hvumlzw9aooWtzyDGpN4CxlhvZ2OT5687/+KDPntDCA6E
         0tyo9Cm0HheOw==
Date:   Thu, 3 Aug 2023 11:22:40 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        David Airlie <airlied@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/4] drm/panel: sitronix-st7789v: add support for partial
 mode
Message-ID: <qmwtcungahbe2bhty7v2rso2kf3vai6k47muwipifbybmi7o6s@oj6lngnhyhtg>
References: <20230718-feature-lcd-panel-v1-0-e9a85d5374fd@wolfvision.net>
 <292c3e7d-82ea-2631-bd4b-ef747f56287c@linaro.org>
 <ekmwiy3iuvtqtb6hwjbba2ia3aemt3dxmx6dj3zh6ljfmuim4w@4jzhqdenxth4>
 <ZMtqraOyGN9JvVj9@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="747cy4c36hkubsom"
Content-Disposition: inline
In-Reply-To: <ZMtqraOyGN9JvVj9@phenom.ffwll.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--747cy4c36hkubsom
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 10:51:57AM +0200, Daniel Vetter wrote:
> On Thu, Aug 03, 2023 at 10:48:57AM +0200, Maxime Ripard wrote:
> > On Thu, Aug 03, 2023 at 10:11:22AM +0200, Neil Armstrong wrote:
> > > Hi,
> > >=20
> > > On 18/07/2023 17:31, Michael Riesch wrote:
> > > > Hi all,
> > > >=20
> > > > This series adds support for the partial display mode to the Sitron=
ix
> > > > ST7789V panel driver. This is useful for panels that are partially
> > > > occluded by design, such as the Jasonic JT240MHQS-HWT-EK-E3. Support
> > > > for this particular panel is added as well.
> > > >=20
> > > > Note: This series is already based on
> > > > https://lore.kernel.org/lkml/20230714013756.1546769-1-sre@kernel.or=
g/
> > >=20
> > > I understand Maxime's arguments, but by looking closely at the code,
> > > this doesn't look like an hack at all and uses capabilities of the
> > > panel controller to expose a smaller area without depending on any
> > > changes or hacks on the display controller side which is coherent.
> > >=20
> > > Following's Daniel's summary we cannot compare it to TV overscan
> > > because overscan is only on *some* displays, we can still get 100%
> > > of the picture from the signal.
> >=20
> > Still disagree on the fact that it only affects some display. But it's
> > not really relevant for that series.
>=20
> See my 2nd point, from a quick grep aside from i915 hdmi support, no one
> else sets all the required hdmi infoframes correctly. Which means on a
> compliant hdmi tv, you _should_ get overscan. That's how that stuff is
> speced.
>=20
> Iirc you need to at least set both the VIC and the content type, maybe
> even more stuff.
>=20
> Unless all that stuff is set I'd say it's a kms driver bug if you get
> overscan on a hdmi TV.

I have no doubt that i915 works there. The source of my disagreement is
that if all drivers but one don't do that, then userspace will have to
care. You kind of said it yourself, i915 is kind of the exception there.

The exception can be (and I'm sure it is) right, but still, it deviates
=66rom the norm.

> > I think I'll still like to have something clarified before we merge it:
> > if userspace forces a mode, does it contain the margins or not? I don't
> > have an opinion there, I just think it should be documented.
>=20
> The mode comes with the margins, so if userspace does something really
> funny then either it gets garbage (as in, part of it's crtc area isn't
> visible, or maybe black bars on the screen), or the driver rejects it
> (which I think is the case for panels, they only take their mode and
> nothing else).

Panels can usually be quite flexible when it comes to the timings they
accept, and we could actually use that to our advantage, but even if we
assume that they have a single mode, I don't think we have anything that
enforces that, either at the framework or documentation levels?

Maxime

--747cy4c36hkubsom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZMtx3wAKCRDj7w1vZxhR
xeToAQCUDopfDyd7vCfNpnPjT1j+PM0tpoS2T52jRiD9h1IgKAEAiAZxUoDl6bpB
bwelJPn2NL0fxTgPR8My3Na4LT8yCgE=
=1DIx
-----END PGP SIGNATURE-----

--747cy4c36hkubsom--
