Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A96F76D6E3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbjHBScb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjHBSc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:32:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB80A1724;
        Wed,  2 Aug 2023 11:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A53761AA9;
        Wed,  2 Aug 2023 18:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE1BC433C7;
        Wed,  2 Aug 2023 18:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691001147;
        bh=835Hv4QBvbzeO4Zgwkya1w0YOfQH/0t6IhAjHwIhDMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVNjGtFaE0zjnFTk9s+HwpDFCo/tpQHAZJ84BNz6ff88tcX10hojL68VkjR+ohlry
         u96A0/ygy4xIFByKUAL91b2N4ShiMoKsScqhl+PxOUET/g/rbMcI8teRAadrGMCV4g
         rzmEJi5QW+tU9FtkrzqDcbomYmGrZoxQsfmi5AG5yPQo1o1Ph5XpoK2/tPz+/ap/CK
         PgAE5xCCXICBgDN2z7nupHjl1natQOsi2YTdCrfA+DN13WbuywRnoLlgXqA3hLN7dc
         LEGYIo4Z3dx819TRF0fpk3g02H6afmE65wgqYasJv2CPdqRbN30+kJdFB19QYigh0s
         kT2ajEkWg0Z3g==
Date:   Wed, 2 Aug 2023 19:32:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] serial: core: Fix serial_base_match() after fixing
 controller port name
Message-ID: <1aac1375-e9f8-4fda-9f07-a4cc7cf23142@sirena.org.uk>
References: <20230802114846.21899-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UO+8QaAxAAuPqQDH"
Content-Disposition: inline
In-Reply-To: <20230802114846.21899-1-tony@atomide.com>
X-Cookie: if it GLISTENS, gobble it!!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UO+8QaAxAAuPqQDH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 02:48:43PM +0300, Tony Lindgren wrote:
> While fixing DEVNAME to be more usable, I broke serial_base_match() as
> the ctrl and port prefix for device seemed unnecessary.
>=20
> Let's fix the issue by checking against dev->type and drv->name.

This fixes boot on at least i.MX8MP-EVK:

Tested-by: Mark Brown <broonie@kernel.org>

--UO+8QaAxAAuPqQDH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTKoTQACgkQJNaLcl1U
h9B7gwf/eHZzom2Lp5Q3hgclWUDcKlP8GAmA2ed+mD6j+1niucW8gGqaV3Op/7ck
KbAD34YqjIKLI8xsPYfJO9mKdtVGvks95BnA9EQwyrv12lgfaNI8r/5NZ/zfbAsl
fjSjQiiwQLOT/yZXgr74kOfN8lPNCR8fIsDcU7JjStqonh0lTRcMEBbf5C3c0rKg
P2il1HvODhxdayoBSCJ13W7ugEys4cVK7AGWeM3mjSmmujDsDLXj2otpDhn2bLkL
AOsWxANuSosxrYdcpI4KIZhokbE4xgOWorIS7q3leDvG/nJuM1iDWZnYMy+FApC1
UhIYerNTSoHW3DzEbvBS9jBRY3i+Rw==
=pAuJ
-----END PGP SIGNATURE-----

--UO+8QaAxAAuPqQDH--
