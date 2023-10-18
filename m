Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794C97CDBC6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344600AbjJRMfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjJRMfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:35:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FDC10F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:35:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C09C433C8;
        Wed, 18 Oct 2023 12:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697632548;
        bh=IzeKyhweq1AWLlQfKTFic0Ns1rUrAh3cIE6nERCkITs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YcSC7Jo657eM8tIi2pAedw6dTC23LfnzfpUvTnfeYeQryq56M5FX0LWqykW3Zde5z
         kPhKUcFnZFggluYnd5Tf7P2YG8mQQ/Ite0cCrmrMoVBexhmbne4X77jfbLSXIeXOEd
         1pXGEFi6RIx665WWvDBavqie2GpwxSnYLet1H/dgt+VzIn4cvfzggZJzx0QmQi8f5P
         oTLz6+l6fT9mpgEH0b8ubg0NM7CO2+QIN7qVAEhw3xgEZN/Wt8dfXo46KDSmoNL25N
         WesDoXZstkDvoTc1jWXMCwS9NRKwFJAlLC0OFNnsu7yFE+gv2CB7/Vgexi5Xpqckm0
         yZRIlD62AsWNw==
Date:   Wed, 18 Oct 2023 13:35:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: wsa884x: allow sharing reset GPIO
Message-ID: <3aa9e3a7-9417-44b4-87d8-fcf1a8b46daf@sirena.org.uk>
References: <20231018100055.140847-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p00VV8kk1vH04gU8"
Content-Disposition: inline
In-Reply-To: <20231018100055.140847-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Santa Claus is watching!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p00VV8kk1vH04gU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 18, 2023 at 12:00:55PM +0200, Krzysztof Kozlowski wrote:
> On some boards with multiple WSA8840/WSA8845 speakers, the reset
> (shutdown) GPIO is shared between two speakers.  Request it as
> GPIOD_FLAGS_BIT_NONEXCLUSIVE to allow such configurations.

>  	wsa884x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
> -						GPIOD_OUT_HIGH);
> +						GPIOD_FLAGS_BIT_NONEXCLUSIVE | GPIOD_OUT_HIGH);

How do the speakers coordinate?

--p00VV8kk1vH04gU8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUv0R4ACgkQJNaLcl1U
h9DM3wf+Ox6S1h4qHtk5rsc4MfEIG9YfVXZ2Dbwm1s+8OKlAzkmarLvnx7aIoe6A
K7KDIqZa56KFb5V98aCgLdOrKReHACqAd3aQxqyP3I+lNkaKS+hSywdGJfCS/+ze
IUGmrH7xrcdfLpNb1K5vbq1Y4xsvoczcLcd76kV2FO/vx6NYlivAmMA6+m7LXdoo
XXNG4DCilqMpUtNPjNaw3CFI7/X2O7s5Mb/blmWAB6neNbAJEc+vefr3gnmR7JQU
j/TjQY/kXSUJHeRt3l6Kdrkot+xgKL6XsgUKFzhyv1FsJcIEOJ47nZcjyHlkFMK+
padfziLK0UyF/yTXkDl8uHDep4q/aw==
=nLXY
-----END PGP SIGNATURE-----

--p00VV8kk1vH04gU8--
