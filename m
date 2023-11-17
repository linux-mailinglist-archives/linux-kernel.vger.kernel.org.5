Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFE77EF647
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjKQQgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjKQQgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:36:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB19194;
        Fri, 17 Nov 2023 08:36:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D0DC433C9;
        Fri, 17 Nov 2023 16:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700238976;
        bh=y6Shd7bmKCsekpBRoYhpQ2ZpMh78XJxTVe4sGB2BHac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WG0Grb750dwkd6qBwm5RB8YkQ4mrl5JAMjtpfNcuKssNdb9OFAXz5WSD1cW2RBtc8
         ClVZ3YDwldl+qYkE1FOjKn/WsD+PpkuS3Yl7yGRorawaOkEt8KIDS96SkhL+IQCDkp
         uXNgQgoQWmAVXE6fdypg0aPN0VzVlCrIz9Sa1KlV+bnaAiqtNa8ka1FPlp24rezmVN
         BF9cUwKKWGxy+RpUfjQw9WGTXZzQzBAWFm7DziGEA9fMuutr3/WDyQTiT16XTMDnjd
         9MCPWsP+YbQuMjWKYRcTEasvcdYbJdvbxYRxBVPMS7EodVsrZqNgB5MUEW3zPjsAlC
         koOKG9Jof7kBg==
Date:   Fri, 17 Nov 2023 16:36:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] ASoC: cs43130: Allow driver to work without IRQ
 thread
Message-ID: <ZVeWfefrEQJIx0YL@finisterre.sirena.org.uk>
References: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
 <20231117141344.64320-7-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jNsZootFS+OqjmoX"
Content-Disposition: inline
In-Reply-To: <20231117141344.64320-7-mstrozek@opensource.cirrus.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jNsZootFS+OqjmoX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 17, 2023 at 02:13:43PM +0000, Maciej Strozek wrote:
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---
>  sound/soc/codecs/cs43130.c | 56 +++++++++++++++++++++++++++++++-------
>  sound/soc/codecs/cs43130.h |  1 +
>  2 files changed, 47 insertions(+), 10 deletions(-)

Why?  This isn't some obvious fix, you need to write a changelog
motivating open coding interrupt handling if there's some reason for
doing that.

--jNsZootFS+OqjmoX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVXlngACgkQJNaLcl1U
h9AIgAf/YwFU+24iTCyBD2p7T4hTxXe88GHpeNfoDy4xmZqQ93P5hdHXUVgC/dPC
YyQ10xS2vXHlTdHUF61h7mI8sK7SQ19P+1bdNGEKc5JDok4qKxG8k9PxWlbS09n+
uOGhfpKyH326+gLfbNn5PyDg8O5JG8w0rCDSq4xEaeR0Vw1eMmNB8Ub1TCUlNvtB
sI6xGKkyi7gw8kqk8tQza69iPYJNXsIW4ar/oM6FjH3ZjzPhDS8ZKMEbJWGhtUda
YsYIk47TfXUs0f+bZNRcmhYUnTJfdy8VgHQSrSKp9Lmb51q6q2sqhS+Ah3icNlJU
uwTHiuhzkeufob+mFz0/IyIqoKcA+g==
=qhs0
-----END PGP SIGNATURE-----

--jNsZootFS+OqjmoX--
