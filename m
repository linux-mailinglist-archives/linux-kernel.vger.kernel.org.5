Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3275477913D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjHKOBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbjHKOBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:01:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9583430CA;
        Fri, 11 Aug 2023 07:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AB6D61159;
        Fri, 11 Aug 2023 14:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C4DC433C8;
        Fri, 11 Aug 2023 14:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762500;
        bh=r1OL1xOaDTJW8Cq/tuXNgO+CZev883XVsFSAo/bOUn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vnouo9gAj/nxKh8FeFcS7z4/iDN+1qVgA6Grl1jjvYa0XzmFqs+nDOwqkDGDXVBYY
         D5gz9md9NUswiXc9+xv2L4mTI77X6O3qirUxKoJ4rT8ikiP2Ef7mKZs+m133dr9giU
         LeoOc63h+g20VZoSdmL3CXkDqoqh5XAuXbEpNpLb78/pkk9nXMrIb0A96R6EcwYLU9
         r7y27QxXzE4hdM3NuKvU2PpYAkLqIULbAXel/Kz9qb6Mnffudd9VtT9IxkT9lc4lQO
         8AqZw5OTyQS/ZloHjnXXWmwQM6mGC8EzifsETwniz/VtA6YwkAjYTB+RZX4m3lpl0W
         X0l/WUvUytQqw==
Date:   Fri, 11 Aug 2023 14:59:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Watts <contact@jookia.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ASoC: dt-bindings: wlf,wm8782: Add max-rate property
Message-ID: <ZNY+x/R8/T5ysPhy@finisterre.sirena.org.uk>
References: <20230810224930.3216717-1-contact@jookia.org>
 <20230810224930.3216717-4-contact@jookia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1ci7ZGSM7XW5/wTO"
Content-Disposition: inline
In-Reply-To: <20230810224930.3216717-4-contact@jookia.org>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1ci7ZGSM7XW5/wTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 11, 2023 at 08:49:30AM +1000, John Watts wrote:

> + - max-rate    : max supported audio rate configured by FSAMPEN pin, defaults to 48000

This seems like a cumbersome and error prone way to configure this - why
not just have the binding specify the state of the pin?  That's just a
boolean high/low whereas this requires getting the rate right and then
having the driver validate it.

--1ci7ZGSM7XW5/wTO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTWPsYACgkQJNaLcl1U
h9C6BAf+JXfLV2AFtuDMuVZ4qlpwsOcaBZOaV8+3FqM7MeR3V0Em8PVKmAfSX95w
7SrCD5KYBxKmVf3EJMVAoslW0AnBytEF3xwzRQAFG73fCCMFbfpyC4FeSpV54yNH
F3Xw6cK75zsHdklYTVmYgrzLEEHUImr9gh5LLeOwJpK12oqi9MzpyrDSC29873df
eL3FmrHdBCHvMyVcn3b9iC5OHrltt3EYiUPP/7IXoFL96K9+y/bD9D20WefdUZYA
psf5N2WvyK7BGDi35w9Rk4dnI4WhXIRAwrGGMpPAz/1T+qr84PQ5HkTAWqN/5Plm
Up3LlXn3AZj3WOh3xdfhk0XOXVvZQQ==
=cmnz
-----END PGP SIGNATURE-----

--1ci7ZGSM7XW5/wTO--
