Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8B4759E17
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGSTB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGSTB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:01:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C615B199A;
        Wed, 19 Jul 2023 12:01:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 646EB617BE;
        Wed, 19 Jul 2023 19:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC097C433C8;
        Wed, 19 Jul 2023 19:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689793315;
        bh=QCYE/Wf313d9BJewOaUale9wKUCaSWfR+2ebvrk+Vqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/6P30FVxHhcPraeIAO/Lc14DZpZiIFRHLyFmnuXTfj3lmyI/Ac60DY1kL0X+qiPO
         F0Bs5fFDUrRl4LAXBsaiCdyvGAfiHweDfQsaV5c+BIOkEC4EiSptOCIpiiH6ypdmT/
         e49NQKZTGOLoUEBB70cLzR+6hEvdBd/CLUZ12emKtprwvkyJ9Rzw6hwJcPL0Lt7ox2
         Y/NR0O1ziMcek/dJu8Fi+YTMH59dhYs9vSPtC0ov4AuS0pi+4wim4gLO1oth82c8Dd
         oxiWAH0cdedVdSgQ1k47/TZSuR+RmiBLNIl89q/l7eUoagJpvzdzTffPxrUCGzIVZg
         RS9msUN9+MDfQ==
Date:   Wed, 19 Jul 2023 20:01:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Foley <pefoley2@pefoley.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: avoid holes in struct spi_mem_op
Message-ID: <4b43fc7b-f76e-4155-ba8d-f95656b19563@sirena.org.uk>
References: <20230719190045.4007391-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GRW3G7GoVTbacsvG"
Content-Disposition: inline
In-Reply-To: <20230719190045.4007391-1-arnd@kernel.org>
X-Cookie: They just buzzed and buzzed...buzzed.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GRW3G7GoVTbacsvG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 09:00:25PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> gcc gets confused when -ftrivial-auto-var-init=3Dpattern is used on sparse
> bit fields such as 'struct spi_mem_op', which caused the previous false
> positive warning about an uninitialized variable:

Acked-by: Mark Brown <broonie@kernel.org>

--GRW3G7GoVTbacsvG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS4MxwACgkQJNaLcl1U
h9BnBQf+OfiP9IntksoAyNnBV4tHqOWod5rm1KLN0Mh6WbbbJ0fl84t+Dh2EKKXR
LH5yFWEkuTlBiWWbCMdishynP3zoKIMXO5ax26ipa4v+BWxmLJAK03u642w2BBDM
gcSmcFlbV44joYETgNQTkbsTM+3nC+/8IR5xnSmetyfwZb/4Rkg8hd2GjKn+ZNn9
1mcif0/95BqLGtt77M1V5Kaa3/n5BDTFZpo1vzNjO5UQlWf6JngzKUL/Z0cYqkfx
FwdqYrc7xnyKRO1II76XJ5RnkL+HsVKNizhhdOYvYDYp7ofccXP3G+GcwXWO89HA
fcVitg7824QSVEmWpZGe7hbWYmrj6g==
=XS2m
-----END PGP SIGNATURE-----

--GRW3G7GoVTbacsvG--
