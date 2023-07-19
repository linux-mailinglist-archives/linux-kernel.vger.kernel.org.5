Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B41758DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjGSGjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjGSGjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:39:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602621FDD;
        Tue, 18 Jul 2023 23:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD9E5611FC;
        Wed, 19 Jul 2023 06:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B336C433C8;
        Wed, 19 Jul 2023 06:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689748770;
        bh=tS2USjBiTii2vuCPFys8pH4L2wdw03uCCar6swSVKH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZpPZzjMjbULCWVQOQFPRhZl4bi55zKdgr/SX5rXzypGRyeX1wnKtnnhBy+SEP6Vzk
         sSJwZ2yT+enuxn51dwMmaYm+RpnpQZnYUoqOg5mchSp/06PkIJPgVgmAxsDi5Ws3f7
         8P5iBe6JYHpwfMsa/WTRmt0DPRNYsnwAH99aTEDp2VgXh7Ew0ueyDywYHdz/CMRDHI
         vPbxejeV0majDR3tAchIF0xBzHERMbimdlMf46QcGuQwPiCUXaKVWHnfXsuPZVMkMp
         pAn1H4VGqZqLM6/Tk7KhP0tf24vil+fvzXK/MKRzXUDKhx/Xor+wCOPRy+oxwv+Skv
         bw8mk/c/TWGDA==
Date:   Wed, 19 Jul 2023 08:39:21 +0200
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
Message-ID: <tbdwgfr4rqgytttoxhidsil42mda77qj3qmhw2do3k5rmwsaeh@qronuzdubv6q>
References: <20230718-feature-lcd-panel-v1-0-e9a85d5374fd@wolfvision.net>
 <20230718-feature-lcd-panel-v1-3-e9a85d5374fd@wolfvision.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gchzkzww7o425bgv"
Content-Disposition: inline
In-Reply-To: <20230718-feature-lcd-panel-v1-3-e9a85d5374fd@wolfvision.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gchzkzww7o425bgv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 18, 2023 at 05:31:52PM +0200, Michael Riesch wrote:
> The ST7789V controller features support for the partial mode. Here,
> the area to be displayed can be restricted in one direction (by default,
> in vertical direction). This is useful for panels that are partially
> occluded by design. Add support for the partial mode.
>=20
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>

We already had that discussion, but I think we shouldn't treat this any
differently than overscan for other output.

Maxime

--gchzkzww7o425bgv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZLeFGQAKCRDj7w1vZxhR
xQEHAP9l+6fq2pGx7Jm6gVs/CtjU/7bDk+zaO0WdI84BaqQvbAEAriaZs0acLkRy
cLAuw4lVbWWc+TWWoE24cPhBJrI1DA0=
=64QN
-----END PGP SIGNATURE-----

--gchzkzww7o425bgv--
