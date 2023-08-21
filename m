Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F93782E58
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjHUQYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbjHUQYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:24:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C026DE8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DA3B63E19
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91FDC433C7;
        Mon, 21 Aug 2023 16:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692635076;
        bh=rh+mxk2XiwA0hIRSU2uiSF0lwTaOpoX7hUeSI+GftIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DkQ/4HMvIHtmoa+Iyx2BUPnPvRz3pEt3XII2fhysU7IJ6JauOHFXqCxYk2yApb4n3
         JTztA3RnFEMQUBj1yH/ami1p5V2/gHXDI7JYRk0wrUm+asGgVs6sLA0/aDTtY8dHWw
         Any0hpk+zQCCkht2yqeqQ681dT2DimDJPH7fXbqfmJ3PeIO2lV8bnNrpIQ/xFiDHpY
         Y6d7Mj74rM8c+2Sl04xn9rzQyrxnkJKKoY3gde3HKm0tBL5WCr+JBBZa3XncnW2eVM
         5qa3l/mxradlqHMTqMz4Nt+08rWjZcMPl0ak3ZcgntmYf+TV7rN+NMz2gWTGVXqOwJ
         WCZYWT70FEg2g==
Date:   Mon, 21 Aug 2023 17:24:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: Delete UDA134x/L3 audio codec
Message-ID: <01f4cbd3-b98a-4c8c-a19e-3e3eb2d45104@sirena.org.uk>
References: <20230821-delete-l3-v1-1-26d9cd32e7a2@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bhuvj7fzxmUqme8u"
Content-Disposition: inline
In-Reply-To: <20230821-delete-l3-v1-1-26d9cd32e7a2@linaro.org>
X-Cookie: No campfires allowed.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bhuvj7fzxmUqme8u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 04:17:57PM +0200, Linus Walleij wrote:
> This codec was used by the deleted S3C board
> sound/soc/samsung/s3c24xx_uda134x.c.

This breaks an x86 allmodconfig build:

make --silent --keep-going --jobs=15 O=/build/stage/build-work ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu-
/build/stage/linux/sound/soc/codecs/l3.c: No such file or directory
make[3]: *** [/build/stage/linux/scripts/Makefile.modpost:144: Module.symvers] Error 1
make[3]: Target '__modpost' not remade because of errors.

The Makefile removal is partial.


--Bhuvj7fzxmUqme8u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTjj78ACgkQJNaLcl1U
h9BBUAf7B1ABhYC/tCVDTcRPuPXweTcD7N4mzXgonKq4panMmO/+6yrEOvP84bke
hV1k61bEYTUDu9J43e9TWSbPIuBiGCIKG4o3ueuJ2f4lSf8Jg+U/n4w8+NuqYqGK
AVWqLe5eVuGYUXpGZDjO5HNLlGlWHLOBqRw8SkNC5vogHIJtuxiDVzAileYbaBqC
4lrOKpr8x+bp0mRYsMbdQfNr+lJrum373JN3F/rk9tBH2SHra5zROt9eUpTu7eZq
g16hRPxfiJwX+kSrEDMdk5nkhsRYtmqkS4/tIQgh07CJ6ZiGlpSAdz+++NjkoTzo
Wihi9k/dgmoBwfFnOMCXOatQadVbQA==
=Rq4B
-----END PGP SIGNATURE-----

--Bhuvj7fzxmUqme8u--
