Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F18F7AEBF9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjIZL6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjIZL6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:58:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE045E4;
        Tue, 26 Sep 2023 04:58:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47462C433C8;
        Tue, 26 Sep 2023 11:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695729495;
        bh=NjkF4xcPxF2ifhkiyBm2HlqjGTgAB/ghxfP+25hX3PY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ed9cYYefB3CS5SFt1rZBxk2MO0uarbkhj7UeX790LUORL/JXPwInFCke98DW71809
         eUv7fxMEtxv72ltRVZfEsKXIugzjjPDgvEcUBH2J7ICCgps79N9wm/do0J5ZDyhT40
         v1f7F8nEiKFoUhgLGmHKDXy9G2Hb/lFLeg0IC9Xsbp6Xhhg+ElKb2XvPRuDDABPBI3
         giS5KevoHICC0qnOmpLzbG9GfGhYwWifJaGvoBB4g1hyrfQjimDt1Zci7DNCv9F3BZ
         2I3MEksQEQS0Tv3IxtwJXthrdgv8gIu1Q+RXvMFpZWcjNtSNjolZrW3oVvAbVDvjJs
         qV345mNtV7xgQ==
Date:   Tue, 26 Sep 2023 13:58:13 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH V2] spi: spi-cadence-quadspi: Fix missing unwind goto
 warnings
Message-ID: <ZRLHVReL9Bq4PNvS@finisterre.sirena.org.uk>
References: <20230919074658.41666-1-d-gole@ti.com>
 <ZRK+oDrT4vaZ0R/G@finisterre.sirena.org.uk>
 <20230926114046.5ukretunoud3yv45@dhruva>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MvZ6bn6WKiXdv4+Y"
Content-Disposition: inline
In-Reply-To: <20230926114046.5ukretunoud3yv45@dhruva>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MvZ6bn6WKiXdv4+Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 26, 2023 at 05:10:46PM +0530, Dhruva Gole wrote:

> Pardon, which branch is this being applied on?

It'll have been applied as a fix so against 6.6.

--MvZ6bn6WKiXdv4+Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUSx1QACgkQJNaLcl1U
h9CjNgf+JfmiXzp4Gwjz8OpW8Hj4QMzOGAUEChahKv4IuZK5iNyiWkjJDxUuChCF
rUn1QY0gOsceXkzfDXEZHT4minRgAmCKTcmplOpZzxBdZVkrHvJvfZmiD/PoltVm
r3rqn4tJ6q39TQwFh8TaCdYuaTyYofRVejZLDwmgY8K2vCznvqK8W2uXsiFCZ6Z2
uhMTn0X2Z3lkcvg+wpXEM5FEG8Ah3UF/tmpelIhPv0JdTxighQkdkYw2DL5lwoeu
A+z3H1WxAzTvSpPGg+rU9Vgh2Bs2cPhBQ7QC344KLqYGuMEkPFN4JLAOgXLjVdwe
k7bNdtCTRH9aSgniuyLTy8/XXhABEg==
=04Mi
-----END PGP SIGNATURE-----

--MvZ6bn6WKiXdv4+Y--
