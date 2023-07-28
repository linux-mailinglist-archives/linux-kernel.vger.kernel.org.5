Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845D2767601
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjG1TGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjG1TGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:06:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF663C05
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A5CF621DC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 19:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B4BC433C7;
        Fri, 28 Jul 2023 19:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690571162;
        bh=uvi0bATcHujY6DvXBu4/fcOB4Yc3DjUaV91qV1I79VQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UeR8dNB6wZh7BOsUGBe8c9Teqh+jZNiF+aAwm8T3PEIoNwCY+5+FPEXZn8DFuW6V9
         XegaV2kHvQS4hJvnln69dp3tyS8MWcFea0zb89vLdZnnYf02d2mMGtkuoTjHsyswT6
         MMPOaTrtiWB/jUkcKkVnqhPAWC0Lt20mRAYg+eOMa/gflFYkX9fb90IcXjD7eUHsoJ
         S0pU7+h6Pnqw1qLydXkdWhiX1vQxL2A+au/0O1V+bRe2LL6SyF/iFLXLj1suQXJ+ak
         II4N5R48GC87Uda/sc8HWXvbO3tazp7aaAT+fao06wCZJcBWu0qdvIJDZeHShLODGb
         4+tS3F96U0GNw==
Date:   Fri, 28 Jul 2023 20:05:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: Intel: Skylake: replace deprecated strncpy with
 strscpy
Message-ID: <e60cc955-87ed-45e3-aec5-8ba6705dee1a@sirena.org.uk>
References: <20230726-asoc-intel-skylake-remove-deprecated-strncpy-v1-1-020e04184c7d@google.com>
 <20230727-asoc-intel-skylake-remove-deprecated-strncpy-v2-1-152830093921@google.com>
 <f0f0ebe4-55fb-4861-a94c-77c82ec600c5@sirena.org.uk>
 <202307281153.B9D0831710@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0CLOAGmPChQYeQM2"
Content-Disposition: inline
In-Reply-To: <202307281153.B9D0831710@keescook>
X-Cookie: Ontogeny recapitulates phylogeny.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0CLOAGmPChQYeQM2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 28, 2023 at 11:56:08AM -0700, Kees Cook wrote:
> On Fri, Jul 28, 2023 at 12:27:24AM +0100, Mark Brown wrote:

> > Please don't send new patches in reply to old patches or serieses, this
> > makes it harder for both people and tools to understand what is going
> > on - it can bury things in mailboxes and make it difficult to keep track
> > of what current patches are, both for the new patches and the old ones.

> Hm, I see "X-Mailer: b4 0.12.3". Is this a default behavior of b4? (If
> so, that needs fixing.)

I've not noticed it doing that for my outbound patches and can't find
any option I tweaked to make it send as new threads, nor can I remember
configuring anything.  There is a b4.send-same-thread option since v0.13
but it's default no according to the documentation:

   https://b4.docs.kernel.org/en/latest/config.html#contributor-oriented-settings

--0CLOAGmPChQYeQM2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTEEZMACgkQJNaLcl1U
h9Ct+Af/T7a2K03kKbmE3CZlrTeEc/9UoIzWu826PaLwb+bN2MkLIcLQgYsNhPMZ
mZevyeMs2vdVYdereur4vUo4/7proNHZLpIZkvRZqg2gCEJeaJeKbvgmTp0V+1Nw
TWSFyzDzLY1fPuqNL0BzHaJtxKioS2AtUWJo+kXgBK1USKMk0ufVEKv5kf7zVHHP
B6sa7nppmwWvP1mGwTxO2QOYHax8dNSh1F3z5EUH+5eKy50dZRwgCD75dSTu5ktp
PQkXFLUWuxaF1zHUqoi96HaAshfz7vq09wqGNppTycfiphmjjIen5xyfoYrTKJCF
srtzRDZE6v0YThqGgMykopRlEu6PLw==
=Zsm0
-----END PGP SIGNATURE-----

--0CLOAGmPChQYeQM2--
