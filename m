Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FF7801322
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379380AbjLASuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjLASuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:50:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96346B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:50:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A377C433C7;
        Fri,  1 Dec 2023 18:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701456626;
        bh=nlNo7xM9XoRlNYHh2JQaIekxrQZHPuEHEh20xUWik9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eix0RHOryZ9fBUgKkiP3QDCZYWkQfGj0qw7PH2nt9Ij/gX120ikLc9r3jpDtMy6sf
         rgmZGHvqQNVhKOxcLmZ161yUAiZn4s78Y23brUdPGdPhTAhFC+i6FJz3XugCzxHlRp
         Ig+ududz0DuZtxihAgmEp4sXjkOSrBRJ2O122FhozAoQ+kb7GVueZW2LgPNs0rW5Bf
         YXy8lQVXxIuYYtN19fcnKuN4Ec5bSzGzd23rAds2gzKmFGQo1LsE0NIgp0s2eRVuGk
         VkpLlgLZlFsGR+b2Yk+9FKc8ZtqR2/HbOqP+o8Mbd+pizyhKM6IIQ+t/Dcj9TftAw6
         NXhpQFInUQ95w==
Date:   Fri, 1 Dec 2023 18:50:15 +0000
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
Subject: Re: (subset) [PATCH v11 01/10] mfd: tps6594: Use set/get APIs to
 access spi->chip_select
Message-ID: <395caa58-a8a0-4c75-85d3-4fa0f6f4a9ba@sirena.org.uk>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-2-amit.kumar-mahapatra@amd.com>
 <170142465659.3329910.8527538140063947758.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uaQ9X2fe+EqjZHC4"
Content-Disposition: inline
In-Reply-To: <170142465659.3329910.8527538140063947758.b4-ty@kernel.org>
X-Cookie: The early worm gets the late bird.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uaQ9X2fe+EqjZHC4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2023 at 09:57:36AM +0000, Lee Jones wrote:
> On Sat, 25 Nov 2023 14:51:28 +0530, Amit Kumar Mahapatra wrote:
> > In preparation for adding multiple CS support for a device, set/get
> > functions were introduces accessing spi->chip_select in
> > 'commit 303feb3cc06a ("spi: Add APIs in spi core to set/get
> > spi->chip_select and spi->cs_gpiod")'.
> > Replace spi->chip_select with spi_get_chipselect() API.

> Applied, thanks!

> [01/10] mfd: tps6594: Use set/get APIs to access spi->chip_select
>         commit: dd636638446c87c95c5beddcd367d95ac6764c6c

Is there a signed tag available for this - without this change the
subsequent SPI changes introduce a build breakage.

--uaQ9X2fe+EqjZHC4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVqKuYACgkQJNaLcl1U
h9APAwf+KLPqe9oVMKPnVoC0/RKtAWqn22qR/OisWnbE+SjMxYnOliwWr1Uy1gfO
VQpQx3O/7kKmZ5aYGt82J0rykYY+6IFwHvgwUu67iYpCzQgmhVbnbh1B94YeZIkV
SUkOiN7HUoTbbExTLVa5Jn+5+LKRmMkbjYXVdpb41Jz/fyGNAidXizOnpqct/Qp1
dMNggC1eWI/kqsOjSr9obsJHhIcyM7u1pwaicJzWGG7SwNM0PSramv3lCHpaKH5W
UbyLbyZ+G0Z2JIwwnq1hFEyklQ1RVInt+3p4rfYhIInMDF+5cQPUjBTcS4k8ho1J
FDPG03/Neeonh9yIf8+TSmQ4tVxszQ==
=/wO/
-----END PGP SIGNATURE-----

--uaQ9X2fe+EqjZHC4--
