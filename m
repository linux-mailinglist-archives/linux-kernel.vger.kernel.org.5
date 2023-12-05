Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A6B805562
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345356AbjLENDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345321AbjLENDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:03:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B129D120
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:03:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FD0C433C7;
        Tue,  5 Dec 2023 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701781393;
        bh=lF8CK0pjxX1D/FyHV6Cs2V2LUREtHoin87SU5A8Sn8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCO+MuX9IqRUeFUsTVhQJejeyXrzVCd+kEm4LgiPHU8s69Nw+YR618LGg9+qlNS7c
         sLVK55XJwmhb5po6/dgV0Z1cbYd4P+83djx/DTAqVlKiMXUjnplB+rGo1n9kFrWEPS
         Z+Hbb5KJEEEYsLhjRGdwky+wMVNlmn7gpsJmJz5Xz5iXlqLGNagLQt/g/U3t+SXdOH
         KVYX1hJ+58f0kXmjHX6YX64DlniWZ0L1IgeQoGBcp0Y7SbAnSes2EGSmcOhSHq6xz4
         tVAGey996XRnYj5VwKpWWBvObuK6BuQlDq4EbUwQsBoG2bf/P28z7Fbw8hAqhWpxGS
         wxGAaA74Q1BHQ==
Date:   Tue, 5 Dec 2023 13:03:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     davidgow@google.com
Cc:     Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 4/4] ASoC: topology: Replace fake root_device with
 kunit_device in tests
Message-ID: <feb6b3d9-8a56-4193-a45b-30e2ab0e3b53@sirena.org.uk>
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
 <20231205-kunit_bus-v1-4-635036d3bc13@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KyBf/qGc1XRWqySF"
Content-Disposition: inline
In-Reply-To: <20231205-kunit_bus-v1-4-635036d3bc13@google.com>
X-Cookie: I've Been Moved!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KyBf/qGc1XRWqySF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2023 at 03:31:36PM +0800, davidgow@google.com wrote:
> Using struct root_device to create fake devices for tests is something
> of a hack. The new struct kunit_device is meant for this purpose, so use
> it instead.

Acked-by: Mark Brown <broonie@kernel.org>

--KyBf/qGc1XRWqySF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVvH4kACgkQJNaLcl1U
h9AFbgf/bgK9XVnQoAUMv87Z1CQnQuPpp0QhnCmWZFdGZ4GjvHke057jzsTnJ8h6
3ScpMXqmMUVbccALtmJOUePEtoRQo5JQkv8TZG/vSoNorkXCGlhZAW8yFrPwo5n7
2h0Cxx9voKORC48sOz+N6e9EkaDTGlULV+jZf5OdI6lY3GQeSjLQ1UxL8+1IINyX
UghWoJI8ieTf/IVd4r6jRQ6yEoJxyKyZhQyB/tuHyKbS6vwhR2qpctRfM7Ojaxsb
UyQXCP2eusxkBn5HWe20YI94dce0y4PJyi7zSXi+X09X41I8HHKQFUhYD+3V2aYF
zaD+g7IpnmuPIVm1ktzDR/o1blYjOg==
=Vsiy
-----END PGP SIGNATURE-----

--KyBf/qGc1XRWqySF--
