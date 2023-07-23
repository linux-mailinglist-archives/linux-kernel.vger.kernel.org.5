Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD54E75E2A8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjGWOcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWOcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:32:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C6EE71;
        Sun, 23 Jul 2023 07:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5B7060DCF;
        Sun, 23 Jul 2023 14:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBB7C433CA;
        Sun, 23 Jul 2023 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690122724;
        bh=ABCsOm9JvWZ+f5nM61rJ7xZNzE0gx8IHdAjQzRG359c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bXr/2FXi7zvvZxq8YappjJNcYGpYEdL+LSGDcNEg2Xu6OKq1mz+qrmtaXlwb/xIet
         WwQqHTqliVs9MEuQCzDTyhJWf8dZGzTdWx9z2uhQIpb4hoLiqnu8pkQlDoTKErNtm+
         P0Onv9DjGXNIKCrAhv173l5BMqpuMKfiqgRbj4cuafYxqAmTqxZYI2LOibS9Ru+jCg
         l+t45Ul4EBQMLA7MrGlc1n+SC10mKbqBNS4KaooOr4yalsCxX/BCHj5dy4yXMT8AvK
         ivDdZKn3EBZcqw8mw6G1Y5+QGabUUDPLMePohq/D/Nx5dWjE5V++lCsCnd4mudQVJJ
         n780NLykLrEqw==
Date:   Sun, 23 Jul 2023 15:32:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] thermal/of: Fix double free of params during
 unregistration
Message-ID: <ZL054LHAZv8VmIk3@finisterre.sirena.org.uk>
References: <20230723-thermal-fix-of-memory-corruption-v1-1-ed4fa16d199d@kernel.org>
 <f559a614-93d5-121a-8ff3-0da77bc85f44@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VCVa1Mdcy0K7qUUI"
Content-Disposition: inline
In-Reply-To: <f559a614-93d5-121a-8ff3-0da77bc85f44@linaro.org>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VCVa1Mdcy0K7qUUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 23, 2023 at 11:57:52AM +0200, Daniel Lezcano wrote:
> On 23/07/2023 01:26, Mark Brown wrote:

> I think this issue has been fixed by:

> https://lore.kernel.org/all/20230708112720.2897484-2-a.fatoum@pengutronix.de/

Yes, that should fix the same issue.

> Rafael ? Did you pick it up ?

There was a message on the thread saying the patches have been applied
for v6.5 but I can't see them in either mainline or -next.

--VCVa1Mdcy0K7qUUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS9Od8ACgkQJNaLcl1U
h9C4+ggAgyC6LyMmC5zuLuGmpsEUMdCUr58Pk1Fkdi9gM5H24Q82x2RSh9U91FY3
zAm7b4GvLAjY7a+VQ0kFpLvfO5/eZaxvEKt0obAJQOFbPa/w6g4JpF3CkN8yX/ad
GYPMBi6Aeo5RzL1VcFRkzcJajKq1EBGXra8YaKWcRsEiEc5OYfXHI+jdk864ZWMe
FdhA0ciburHOzbrkT4KulZV6Onm+5m3KoQQmMzePJnQgCzYAXZdX7SO5Ftnpb8T5
DyTXYivBI57Y9tPEgUwftPHtZEG0XOw2MBeIp8zAGJCTykJ9MI8OW2D0zCeOYWaL
W7Yy19cTg4LDmXRhJfm42x3Ew6bf5g==
=iPai
-----END PGP SIGNATURE-----

--VCVa1Mdcy0K7qUUI--
