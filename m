Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBE378ECFD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbjHaMY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjHaMY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:24:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEEA1A4;
        Thu, 31 Aug 2023 05:24:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A1C2ACE20DB;
        Thu, 31 Aug 2023 12:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF801C433C9;
        Thu, 31 Aug 2023 12:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693484689;
        bh=nXWcobST5xvZcG1UeeKu5sV7yE2+CygPSMmrLOFEf0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fs4kR/bSqpjFjNJTJAWL64045RYFRG42iIS580k8R3taCUkllCPBectpxgvkgmDrq
         q+kNnLogNk65FY+JkDL79buGJga9h42YQdq8IVF/43x2EWQvKsz31BzE++C2+/xZAP
         zHkASNL3KxS7VJR7XIkcBalnDuCnq8A+qKLP1hh67KTc0B6iImTFPz8dBReoseG2Eg
         h6v2M96nxJiAuxEpWn3KC5k1cDU26W+ncF+3VI+DN6VlCjMfokCXRkcEDjTCuBe8aS
         SdATOOW67qPqB25TY8LlKww7ld60C+dOXtW+oBW3opY9/NA2gF5CxVhWkIsn/HqFfz
         4MJAM/teGorxg==
Date:   Thu, 31 Aug 2023 13:24:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Watts <contact@jookia.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] sun4i-i2s: Support channel remapping
Message-ID: <ZPCGjA9g8hVdr2Pm@finisterre.sirena.org.uk>
References: <20230811201406.4096210-1-contact@jookia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DeugAER/HXv/4y4M"
Content-Disposition: inline
In-Reply-To: <20230811201406.4096210-1-contact@jookia.org>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DeugAER/HXv/4y4M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 12, 2023 at 06:13:59AM +1000, John Watts wrote:

> First, I split up channel-dins and channel-slots. This is mainly
> because I implemented one first but both of them only make sense
> together. The registers themselves use a format of a byte per
> channel with the upper nibble being the din and the lower being
> the slot. Perhaps this is a better format to copy?

I think this is fine.

> Third, channel-slots is available on all sun4i-i2s controllers,
> but I only have it implemented on the R329 variant for now when
> there are multiple din pins.
> I could add support for this on older controllers but there's not
> really a use case for manual configuration as there's no DIN
> and I don't have hardware to test it on.

It's fine to leave this for someone who cares about that hardware to
implement, might be nice to add a warning if the properties are set but
not supported but it's not essential.

> Fourth, I don't limit the readable channels to the channels
> listed. Reading more channels than you have currently results in
> the controller assuming you want to use TDM, but that's not the
> case here and you can have strange duplicate channels show up.

It would be better to have constraints which prevent userspace doing the
wrong thing here.

> Fifth, it might be a good idea to increase the maximum channels
> from 8 to 16, especially if people are going to be running
> multiple TDM streams on one controller.

If there's no reason not to...

--DeugAER/HXv/4y4M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTwhowACgkQJNaLcl1U
h9CjTAf9Eb9zBoEzAuUZtcuChIs4gYOvUP+KJHWZQvgZ7KMKd9UsThI0n7CTASTY
yvJjmMWvrFRTRoW1aGyk4Vc+bBYNX+fVBlmwxcqrQtNda7MSGKlIpf/FNpGOOZEz
h5OjmgfIsLqH0KWJKkWrdQK581QDxGXtVGaJ/gzKtKmhsKyVyGsVHYRe4mc1kn47
dabSfrqQV1S1B3U6HhtVsZ4eF3kvxfiGkaGgyjr1Kwij5xkoAYW+HrYJf3N/lO5P
kCl1OMYD/9HGpIZneXwp+765K5ja28fM/nXtlbwrBIyN7BlNuFXoKo1rVqWXmpQc
9x/1s+zCXiDfKj9iX3gpEt4IrHmg1Q==
=CYGX
-----END PGP SIGNATURE-----

--DeugAER/HXv/4y4M--
