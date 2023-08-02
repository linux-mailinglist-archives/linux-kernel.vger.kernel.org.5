Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A783976CD71
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjHBMri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjHBMrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:47:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5FD2721;
        Wed,  2 Aug 2023 05:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E60E61967;
        Wed,  2 Aug 2023 12:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FEDC433C8;
        Wed,  2 Aug 2023 12:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690980428;
        bh=LhXZRg0afv0qB+yKsYUZTxyHFk+cS+imz+tvV17ALoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTQYiQ7fa5yF+bGKtFjjkeZsRgj023SmHrPh1SfQtR/gdZqn9Y09deOoViq4CLyn+
         8QdV6tFx9vOqD93irNUGKGv8Kszx+AnQ/fRUA3OQkdXc0qUIo/OyjBT/9Vq5PkL0sn
         H+jloeUziBgeM78fA/VQ63/U3eAdQhLyzTY9FMJtJjzPsa2Ghxzwf0xGPIAKb3zzNp
         du0rTUejIYu/l80vQt+NFzq1BC4NzsYj9bNuLV45aQeO42ggXdeh5YaRdU1MwTFKEw
         yIixZpaUDMVVK086i8LZUvCBeVetB9+nyaMYMX5Sd0cErg2tx6GdFlBzxclByIWOpB
         wzAZ3nnKY8rMg==
Date:   Wed, 2 Aug 2023 14:47:04 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/4] drm/panel: sitronix-st7789v: add support for partial
 mode
Message-ID: <jfmsb4tmgx5rej4ae4npzq4zjh2dnydukxuk34oejbqdpe4a42@a2bbo3bwa3yq>
References: <20230718-feature-lcd-panel-v1-0-e9a85d5374fd@wolfvision.net>
 <20230718-feature-lcd-panel-v1-3-e9a85d5374fd@wolfvision.net>
 <tbdwgfr4rqgytttoxhidsil42mda77qj3qmhw2do3k5rmwsaeh@qronuzdubv6q>
 <097de164-6d62-6a1d-f7b5-cbd7d4408ab7@wolfvision.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7wiv5tnbzr6rtjkg"
Content-Disposition: inline
In-Reply-To: <097de164-6d62-6a1d-f7b5-cbd7d4408ab7@wolfvision.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7wiv5tnbzr6rtjkg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 02, 2023 at 02:34:28PM +0200, Michael Riesch wrote:
> On 7/19/23 08:39, Maxime Ripard wrote:
> > On Tue, Jul 18, 2023 at 05:31:52PM +0200, Michael Riesch wrote:
> >> The ST7789V controller features support for the partial mode. Here,
> >> the area to be displayed can be restricted in one direction (by defaul=
t,
> >> in vertical direction). This is useful for panels that are partially
> >> occluded by design. Add support for the partial mode.
> >>
> >> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> >=20
> > We already had that discussion, but I think we shouldn't treat this any
> > differently than overscan for other output.
>=20
> Indeed we had that discussion. For reference, it can be found here:
> https://lore.kernel.org/dri-devel/20230329091636.mu6ml3gvw5mvkhm4@penduic=
k/#t
> The thing is that I am still clueless how the overscan approach could wor=
k.
>=20
> I found some DRM properties related to overscan/margins and I guess
> userspace needs to set those. On my system weston is running. Is weston
> in charge of configuring the corresponding output so that the correct
> margins are applied? If so, how can this be achieved?

I don't really know Weston, but my guess would be based on some
configuration or user feedback, depending on which case we're in.

We also set the default using some kernel command-line options.

> Will DRM handle the properties generically or does the driver need to do
> some work as well?

What do you mean by generically?

> In any case it could make sense to write the partial mode registers and
> enter the effective dimensions. At least I have seen this in other panel
> drivers.

Sure, it makes sense. It shouldn't come from the DT and be fixed though.

Maxime

--7wiv5tnbzr6rtjkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZMpQSAAKCRDj7w1vZxhR
xVzFAP9kilsZBbm6W92vMaew8O9CoKFITr2sHAY3YtrjXN+BMwD8CFk1GalP9DqQ
xK2JsT/QInfbGyojc95pU1mtGD0S+Q8=
=2hFM
-----END PGP SIGNATURE-----

--7wiv5tnbzr6rtjkg--
