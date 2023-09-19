Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB9C7A6CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 23:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjISVDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 17:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjISVDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:03:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CDDBF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 14:03:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC9EC433C8;
        Tue, 19 Sep 2023 21:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695157429;
        bh=jQELY3ed0aSaCGrtR4O8uZ4VBZ0t0mnB+LYkLbV4ppc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOCZUvwjqCVGTEeJxFMGoi3GdFpVUr1ctfO8v8hiexPz7Rpzjri86AhYDbTtCXhdF
         ZRFwIRQXm8NPTeTJ+daRlMezaJ/FBkG4LxJ5nZT3oKjrphthzUy4OMyGVVOypZ6o7c
         BIa56mraLBLegxo2FYqMeaqWT7TTKzmuhwDJnlpqxmLQxHeWOY8pVIWFo2u3EiEroF
         CtzOiddTk9Iu3NUG0pn7D2rhDbMJaKhPf5zD9UYLcJcHW+V76w0rZokqdXXatQQ5kO
         sF9c8a6wiIfKEUGzn7bi+LFlGchnl2IFeJGvoasDpijUyYzd96h0TvHP/AjglthFWk
         3UHwZYcl0gZiA==
Date:   Tue, 19 Sep 2023 22:03:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gokhan Celik <gokhan.celik@analog.com>
Cc:     outreachy@lists.linux.dev, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] regulator: dt-bindings: Add ADI MAX77503 support
Message-ID: <612491b7-f303-4ce7-ba41-26a622209f65@sirena.org.uk>
References: <cover.1695155379.git.gokhan.celik@analog.com>
 <5ce9482e53587d9250ecaa07d0908b987081b4e9.1695155379.git.gokhan.celik@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U7bugydQvn0mFnR9"
Content-Disposition: inline
In-Reply-To: <5ce9482e53587d9250ecaa07d0908b987081b4e9.1695155379.git.gokhan.celik@analog.com>
X-Cookie: You buttered your bread, now lie in it.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U7bugydQvn0mFnR9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 19, 2023 at 11:45:22PM +0300, Gokhan Celik wrote:

> +required:
> +  - compatible
> +  - reg
> +  - regulator-min-microvolt
> +  - regulator-max-microvolt

There should not normally be a requirement to specify voltage
constraints, it should be valid for the system to not permit any
configuration of the voltage at runtime and just use whatever state it
was left with when the kernel was started (eg, hardware or bootloader
default).

--U7bugydQvn0mFnR9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUKDK8ACgkQJNaLcl1U
h9AlTwf/VzAnN77CfZ0uBHjrlcyNqnuHpdCoS7AZT9VOMeDyUWNkM+jBz5/Dty5L
P4amLUiuB4FNCw05Bb6A+InKAJsVAJblH69cBNHkw9TPjb57fPjoZNUGMisCOiOJ
3O0aXatbaYLlwNEz7564lyTk+t5PTcQvA0YOCzfwOyEuwTCYm6Pw1sU7y1oMwduQ
8BaWwxRxDocuq7o5PWeatSK+HiAOe3WmVQykD0g+OocpNRJMb4EBhJWIbNG4zAdB
fo8cKL+eQ21oHT+ATOOdjQD1ZwWCy9QsddHwXUU4/Bd4bLlIipHTxp320nZqJuuQ
U7J6RuKB5SMNPE0sRIBrVvRqWK/Wig==
=YCg7
-----END PGP SIGNATURE-----

--U7bugydQvn0mFnR9--
