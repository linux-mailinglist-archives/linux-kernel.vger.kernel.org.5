Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A809D7D6C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjJYMlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjJYMlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:41:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BB98F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:41:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC46C433C8;
        Wed, 25 Oct 2023 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698237710;
        bh=5+h7ezmQDA0zbyiqtBxqtLVD/G6sYN3hQR1nL+mJvYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tw7jDvWzStRa9vIMes2r/55HPXDJXg/3P5xPf3CoTCO1SkbRZt7yp/XbIBacaacSp
         ZpGyfgR12LjeIXhsOC2SkhSrbXdDrRN8uP3CtFu/Mw57WXiqFdgrM37IY6m8aX1eSc
         ionkcn2TG758Fu2PP7sMY0wXM5odDKFOEwL09sSf7eAh5jqJinIGSR9geJerWYyCml
         0fTC7m+gSpvUReiLGGTVxDOsaswjuddzy1EEia4qeIsl5JJReEYf3mzBwW0QS7N3VS
         nIXz5HgR6+SgYZwPHeHOvjAswR24Wjku13u0dxu4J3c+eldLJyRrgK6nHnk/OvuSUj
         EtYcEpTfSyQ0A==
Date:   Wed, 25 Oct 2023 13:41:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/7] regulator: dt-bindings: whitelist
 system-critical-regulator property for fixed-regulator
Message-ID: <e2ae68a5-b6fc-4b0f-b198-e635435c33ce@sirena.org.uk>
References: <20231025084614.3092295-1-o.rempel@pengutronix.de>
 <20231025084614.3092295-5-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="snUpAOfYIdGu4zP7"
Content-Disposition: inline
In-Reply-To: <20231025084614.3092295-5-o.rempel@pengutronix.de>
X-Cookie: There's no time like the pleasant.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--snUpAOfYIdGu4zP7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 10:46:11AM +0200, Oleksij Rempel wrote:
> Allow fixed-regulator to be marked as system-critical by whitelisting
> the 'system-critical-regulator' property.
>=20
> This property indicating that the fixed-regulator is critical to system
> stability or functionality, aligning with the recent changes in the
> regulator core handling of under-voltage events for system-critical
> regulators.

Why would this need to be something we explicitly enable for a given
regulator?  Surely this is a property of the creativity of hardware
engineers rather than the regulator itself.

Also please avoid the use of the outdated terms whitelist and blacklist,
pass and block lists are often a good alternative.

--snUpAOfYIdGu4zP7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU5DQgACgkQJNaLcl1U
h9AdYggAhZQKEysbWfpHAlugx8AivAUbYgLyylR9UaQWeuqprdjhZheLHYMK8zsB
OY6KCpgqc4CETsiBQNtJxKDKrckLqPNJPtEbz12ntgjpTRZEMO92A31iYsfR2xAe
W7R0VmxFeUOJnzQ0fXMgnvSkS9aRF8HfuRIEH+hh8nYr5+Z9+LHPRNlm7qMk8KH0
GuW1jn3o9dQ1TgZy2RHDSSTrUZoGiDrmGyyqjWeburUFG63NHFAhm/p69WpNWf4N
VjbQilSJYiDeNq9k+7bBy+/Bk63oBZAowt7vAsJGoPxqw+G2vJhP1GneqAQD1zVh
34arlTX8Bt081igWxEk0mKg6b2bacw==
=zJKI
-----END PGP SIGNATURE-----

--snUpAOfYIdGu4zP7--
