Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91F876E395
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjHCItL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbjHCItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:49:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FA6E42;
        Thu,  3 Aug 2023 01:49:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7985061CDE;
        Thu,  3 Aug 2023 08:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57432C433C8;
        Thu,  3 Aug 2023 08:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691052539;
        bh=Y0NT9+jhy+SVCkNdodtcTuuD4m428dSBnf4RYExMCVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hHSTdN7CY3d5RkxhKKUgxwBcIL10XDgXnREDhjjZryufbi7C0wF4l6SlExsQqxxQj
         xg+t2ORgMKOv0KYPjlEAQgKT5HK0o3evOXpdnBOcYQVtPCGXVXG7j5jRdCRDMZGqXG
         6HN5DnhVWpql+3EltG4mKh5iAhCM/V774rBWvN169MQmbQ4k2ejwbRxXZTRi4tTjEZ
         9hIxXmLiLi3P/f1nNSSKg3MgCtxL5g28aVxxBVNBEFuZJKFQiU4Tx7Na2UGaz0nVUB
         r5xWJyw2X9S0w+CRYDRXsyUK2SGiH1yB+U2lGHEkQPxOmx/heU9fP2RsVI4xSK9S+S
         uuszv6UIh1+xw==
Date:   Thu, 3 Aug 2023 10:48:57 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
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
Message-ID: <ekmwiy3iuvtqtb6hwjbba2ia3aemt3dxmx6dj3zh6ljfmuim4w@4jzhqdenxth4>
References: <20230718-feature-lcd-panel-v1-0-e9a85d5374fd@wolfvision.net>
 <292c3e7d-82ea-2631-bd4b-ef747f56287c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2sas7p43tngc2au2"
Content-Disposition: inline
In-Reply-To: <292c3e7d-82ea-2631-bd4b-ef747f56287c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2sas7p43tngc2au2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 10:11:22AM +0200, Neil Armstrong wrote:
> Hi,
>=20
> On 18/07/2023 17:31, Michael Riesch wrote:
> > Hi all,
> >=20
> > This series adds support for the partial display mode to the Sitronix
> > ST7789V panel driver. This is useful for panels that are partially
> > occluded by design, such as the Jasonic JT240MHQS-HWT-EK-E3. Support
> > for this particular panel is added as well.
> >=20
> > Note: This series is already based on
> > https://lore.kernel.org/lkml/20230714013756.1546769-1-sre@kernel.org/
>=20
> I understand Maxime's arguments, but by looking closely at the code,
> this doesn't look like an hack at all and uses capabilities of the
> panel controller to expose a smaller area without depending on any
> changes or hacks on the display controller side which is coherent.
>=20
> Following's Daniel's summary we cannot compare it to TV overscan
> because overscan is only on *some* displays, we can still get 100%
> of the picture from the signal.

Still disagree on the fact that it only affects some display. But it's
not really relevant for that series.

I think I'll still like to have something clarified before we merge it:
if userspace forces a mode, does it contain the margins or not? I don't
have an opinion there, I just think it should be documented.

Maxime

--2sas7p43tngc2au2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZMtp+AAKCRDj7w1vZxhR
xYu2AP9gN0xpGj30YXB2Oo/JNDobI7gGge8/IziOAnjHaTA73gEAnn8sMJU25ESF
ljJwLfmQB/zyjUPIdhEsxmn1uQD9sAg=
=IrPc
-----END PGP SIGNATURE-----

--2sas7p43tngc2au2--
