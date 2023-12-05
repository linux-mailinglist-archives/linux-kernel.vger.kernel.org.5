Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA73805BE7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbjLEQNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjLEQNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:13:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC4B9E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:14:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAF4C433C9;
        Tue,  5 Dec 2023 16:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701792840;
        bh=ru2Yf4e2J+5cS2zc1QOY6JOr4Q5ZMrCeka8oIoe8iAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CkA/wmYSZZ4ekKAvd12zaT1b3VgxWrPSB/VMN5QvQQzuZh5GoehADzQVGrABSmUSk
         sqC5OV922UTccz+YnMFpwCqWyosrrjhxs/x1f9D8H1rC+l//ey1XblksBplk4noFlW
         L4bEs0arekh5l8tGAYd4ntf5ToSKcq+roU6Qio2IOWLj7CT0AN7QYsQbOmTvmmdGC4
         BtjnuhDMjHv2B9o/L68tLpHFRhJkeo8sss+Bdw3zg1G1VYErimy8vCMU3U2xuZvy4a
         2a6qKqavUaKIc+43DCIN3mWIl1Jup8yT6SBNig59OTvIV1H20NHiLDhxyiLaVSmjeb
         Brc52So+XpBiA==
Date:   Tue, 5 Dec 2023 16:13:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Gergo Koteles <soyer@irl.hu>, Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/2] ALSA: hda/tas2563: Add tas2563 HDA driver
Message-ID: <aecaaaff-9a4c-4d1f-8457-5afdb7803d94@sirena.org.uk>
References: <cover.1701733441.git.soyer@irl.hu>
 <4a2f31d4eb8479789ceb1daf2e93ec0e25c23171.1701733441.git.soyer@irl.hu>
 <90765ee0-a814-4852-9b2a-020cda98d930@linux.intel.com>
 <974d41f6c703d9b65ebcd75a2c659cecf13bd877.camel@irl.hu>
 <a530e70a-2491-4270-b582-cd493d1512b1@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GodoWbeZVkkSioJV"
Content-Disposition: inline
In-Reply-To: <a530e70a-2491-4270-b582-cd493d1512b1@linux.intel.com>
X-Cookie: I've Been Moved!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GodoWbeZVkkSioJV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2023 at 10:01:08AM -0600, Pierre-Louis Bossart wrote:

> >>> +static const struct dev_pm_ops tas2563_hda_pm_ops = {
> >>> +	SYSTEM_SLEEP_PM_OPS(tas2563_system_suspend, tas2563_system_resume)

> >> where's the pm_runtime stuff?

> > The amp stores its state in software shutdown mode.
> > The tas2563_hda_playback_hook wakes/shutdowns the amp, not the
> > pm_runtime.

> My point was that you have all these pm_runtime_ calls in the code, but
> nothing that provides pm_runtime suspend-resume functions so not sure
> what exactly the result is?

It *could* be ACPI doing something I guess...

--GodoWbeZVkkSioJV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVvTEIACgkQJNaLcl1U
h9By3Af/UZHQo24BocMAB4/saETBOo5GGwsh7kVw55UIvFTRy65mXMVBsOnLmP3J
x6TBjezeo/Zi6COh1+dtdzCfO2wEA5j6sW95WMvsIlj6Z1rpwKIfPTk4kXI7GxIz
a3I/9acM3/W6UZizagHBWXK0QgQuCi/fL/1aVh8VYwCGKi+5MOQxNftGfiYrXpJh
X4V8p+vTxR+ex/CRNi6lgrM2vEnk9fFfhAesugBjCN+J1KJ2gPO1oL+5SiHf/sJ/
rjOebOBFlzOru4UhBUjaTSXCOoVFpgJ2eoimKQzmtgo4pHq1TmTKWlSYEo45wk4p
QKIq5JCEqxA4Vl2tZ/3/KNmkckGbAw==
=x4+9
-----END PGP SIGNATURE-----

--GodoWbeZVkkSioJV--
