Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C7D808FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjLGS0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjLGQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:20:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC03611B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:20:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE46FC433B9;
        Thu,  7 Dec 2023 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701966052;
        bh=MBl8jX+CYsWd6FZCSkh8ink0zxCjpM93rbZyvHRV2R8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OaX+Amr4+2De3B69b6K4i/wdD/KlCz19NtGb/HlW2OyVVH6jkUYW99P33NutAtN4J
         A0nJKfpdTQgOybcd97ybL7zLpQcpAoIfs08y/yLVszKPYo/p+7aHgn5ouMxal5zYoQ
         neQnIF9I8uOtFo2BAuAC+cNRUgo3VlEwViQgAwkE3Y6L8ngIELWn0jYiUvgC0Tfw/T
         15nM8TDyTLAx6xgL9Dl9eBYcgSLXtLh34DH8JSLBQEIAB6zRSvv4ifzuKJxcwR84Qo
         O6eqsr+covJ2qISwOFeGcu9CXz+wIGANUWkPYIT3T2/5srMqIVYD9zUL5gKYmw2wNS
         ougPA1Q+aQ0Jw==
Date:   Thu, 7 Dec 2023 16:20:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sbinding@opensource.cirrus.com, james.schulman@cirrus.com,
        david.rhodes@cirrus.com, rf@opensource.cirrus.com, perex@perex.cz,
        tiwai@suse.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, linux-mtd@lists.infradead.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, michal.simek@amd.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [GIT PULL] Immutable branch between MFD and SPI due for the v6.8
 merge window
Message-ID: <d12da7b2-f18c-4b56-85be-6d98b62d6ddd@sirena.org.uk>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-2-amit.kumar-mahapatra@amd.com>
 <170142465659.3329910.8527538140063947758.b4-ty@kernel.org>
 <395caa58-a8a0-4c75-85d3-4fa0f6f4a9ba@sirena.org.uk>
 <20231207133849.GB8867@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H1tMbLV73SdOkctb"
Content-Disposition: inline
In-Reply-To: <20231207133849.GB8867@google.com>
X-Cookie: Two is company, three is an orgy.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H1tMbLV73SdOkctb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 01:38:49PM +0000, Lee Jones wrote:
> Good afternoon Mark,
>=20
> > Is there a signed tag available for this - without this change the
> > subsequent SPI changes introduce a build breakage.
>=20
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa=
86:
>=20
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-spi-v6=
=2E8
>=20
> for you to fetch changes up to 4ae08845db4c1f759b8382bc7527ab8249230e7f:
>=20
>   mfd: tps6594: Use spi_get_chipselect() API to access spi->chip_select (=
2023-12-07 13:36:29 +0000)

Thanks!

--H1tMbLV73SdOkctb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVx8NoACgkQJNaLcl1U
h9BXiwf+NG+nYvE91fSSJn6y9dB1oLiMaR2BUDYVTOuWkwmRWLtbTbJgJwxJfBqH
itW5Xs7GuEJ8Rq82sl4K6ITes+jLCB1ljYdbbH4QTqo7Sm5MjdRwGQczHbe8FONG
FTu5Oa7WGJfTQa7tTu7TOJU16Dd1YPVT4QO8Zg2D6Fvltfdh5y0vTJO9LxdA99cE
11d/pzJGFKEojADXl3V7RFLAiJJAFpri7C730ZOZ30WRt42f18MTl7omglIGAQOE
6YvN9sSZ57FEQuWaoIKp8IGnOukM4eqEwuwx8CqUNGfD7ag9ffo17PpytPgQosoX
6xPrq5I2cgrNMJzC71jsMobrBpQF1w==
=4OmM
-----END PGP SIGNATURE-----

--H1tMbLV73SdOkctb--
