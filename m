Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59627B01D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjI0K2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjI0K2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:28:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D2CEB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 03:28:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B1DC433C7;
        Wed, 27 Sep 2023 10:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695810511;
        bh=cvS5PqEhY5R7uI/RDPX5ydbaAUx6zExD2wS5YF2OBVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DIOerlI2Ki0TXaQaY40WQF54NjPAildbPQqWliLxv3AbvAKIfh3Jv8i8piCifxJSj
         LZC30VS8b8gXhnlQ9AT47xas28d1TgOefmkBQ1L2xqCCqT9mPxaFOkXOcmux0w4hsY
         mCMV2/RkYVvBsoue8dtnD4kz6C3J2OUq8brTMzuVPalQ+MtNhZUzy4ZFHxECWadf8M
         iHL0OSJEUtfXbbjtcAartn+coxjR1NSi5YlBmUh7/unC0Q9bbcCi5bki7wQaumb1kC
         H8qxLQX2+zemAQNTgKfSUA5/dA+D3m0fJO6yT+FI4788owsqTDLbRaSrkHDf00KUXd
         PPFAP+18o+yXg==
Date:   Wed, 27 Sep 2023 12:28:29 +0200
From:   Mark Brown <broonie@kernel.org>
To:     ChiYuan Huang <cy_huang@richtek.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Allen Lin <allen_lin@richtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: rtq9128: Add TDM data source selection
Message-ID: <ZRQDzZG7PPovUIsf@finisterre.sirena.org.uk>
References: <1695780376-32301-1-git-send-email-cy_huang@richtek.com>
 <ZRPyMolOIjLBWXPC@finisterre.sirena.org.uk>
 <20230927094637.GA25905@linuxcarl2.richtek.com>
 <ZRP9Aw904ynL5Se/@finisterre.sirena.org.uk>
 <20230927101948.GA27975@linuxcarl2.richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D0qJCejxf+Euu+mv"
Content-Disposition: inline
In-Reply-To: <20230927101948.GA27975@linuxcarl2.richtek.com>
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


--D0qJCejxf+Euu+mv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 27, 2023 at 06:19:48PM +0800, ChiYuan Huang wrote:
> On Wed, Sep 27, 2023 at 11:59:31AM +0200, Mark Brown wrote:

> > Sure, but is that actually a practical design - or if someone is doing
> > this shouldn't it be joined up with the TDM configuration since with
> > just the control it'd only be possible to switch the pins but not change
> > the TDM layout?  I'm not sure that this control works as a standalone
> > thing.

> I think if two data source input for different scenarios, then the data source
> switch will become practical. For the standalone usage, keep a device property
> to decide this may be enough. But consider the future application, to keep this
> in general mixer control is still usable to meet the complex design.

My concern is that the control might not actually be usable without also
changing the TDM mode so we might need the machine driver to add a
control which flips the input and also changes the TDM mode - it feels
likley that if there are two inputs they won't have identical formats.

--D0qJCejxf+Euu+mv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUUA8wACgkQJNaLcl1U
h9AkUQf/bHqfsJCtxIZwe9pBVupRqgu3iwyqLmWXWCS8b3tyO4RvM/XBxkSH8NDY
6Plwt9R4CuvRGgVUyMLyuCNnZWj8925kgcmhPtXA2l3wdGq4pyvvxR3k4/tNJtpS
W5d1csRIOqWJQSpR/L/THHCj1JcTqDnGLdU724MHA5QvVFjBgOLGFAnRgUmiZr5z
ftO8+UoQsMrjzG7pAlMo7ACQ5EP7GLk865NzBloiiVOizs6tWBZHnIDup8vJJA2I
n8i8bnblQBghWL4SZ6oBlr2AeRNTVDbKQXQnvSi8eLhU2qDwwAH61906roRs4ZQH
N5khCHwX0zTrKaDUmzlPpAb7Gr8srw==
=Fp4G
-----END PGP SIGNATURE-----

--D0qJCejxf+Euu+mv--
