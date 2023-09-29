Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88447B32E2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjI2Myn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjI2Myc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:54:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB35B7;
        Fri, 29 Sep 2023 05:54:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A1BC433C8;
        Fri, 29 Sep 2023 12:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695992069;
        bh=EoBxvrxDfGkVdyIyzpMbPaY4B2XdkS2E9Vlf3uqDKBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQL3CFIlVUWSxJbvvFJ5D6ryVfPSd4t2vrMpnI3g/vlQJNjKl9PzT2h0PH9DDi4H4
         6VWWjQqELAI+VoZ0pMXf8PLIkszYnqqicz53+I8xYrT1Tw5DdJphpJaycyG8mQJOGo
         VOIDTPE2EvHzUIkmzXXzPVNea1bMGWL+t0v7bFjQGxJdUQyCOXjgbLUhYegkO3ejW6
         kpx7h4abs5V/ZIuse+/5Z6lAPvLGYNogP/2LRS4Q/YX4Hq4a8gew5stD7z7bF+M+SL
         V8RXDlREFHZtvQJqkS2OrlKPcaBTYryhp5IdilsbRozpcBm3IoYFA0gA8fExZRWVUJ
         D7sxFQiTk9Xkw==
Date:   Fri, 29 Sep 2023 14:54:27 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Weidong Wang <wangweidong.a@awinic.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] ASoC: codecs: aw88261: Remove non-existing reset gpio
Message-ID: <ZRbJAwoanwLnnaJ1@finisterre.sirena.org.uk>
References: <20230929-aw88261-reset-v1-1-fcbce194a823@fairphone.com>
 <ZRbDW3OiAYyAkWgN@finisterre.sirena.org.uk>
 <CVVET1A2CO26.3O47662JKAL6@otso>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qONoz+opKwc0uBGE"
Content-Disposition: inline
In-Reply-To: <CVVET1A2CO26.3O47662JKAL6@otso>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qONoz+opKwc0uBGE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 29, 2023 at 02:44:47PM +0200, Luca Weiss wrote:

> Unfortunately the dt binding is a bit trickier to update since it's made
> for both AW88261 and AW88395.

> After spending a bit of time using non-Google search machines (Google
> seems incapable of finding anything there) I found a datasheet for
> AW88395 and that does appear to have a RSTN "Active low hardware reset"
> pin so we should not remove that one.

> Probably it's easier to separate the two dt bindings then, instead of
> trying to keep them together?

You can do conditionals based on compatibles so it might not be
required.

--qONoz+opKwc0uBGE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUWyQIACgkQJNaLcl1U
h9A/xAf/XN4jfnsD6rctf5QA0do+w2dON4lVcBHZWLQoVexuH4atppdPKFOGfwfW
ycEeWWnTssfIhxGIiQ97rN8onZpMEWh4TI1cfBbUDKnpP1E5tRlLrhBEFH6q6bYe
rK5H9ScASfpxab9MrL5YczeE5aX2LwGNvlfYbPqMP2uOYxuVBZYX7saf7nE8uY9j
k+1wj+aMhW0MUcOJaIiSpyINPL2i/C7Tr0eV5Zfdly0f7iPCV9QiJjbhXzXyr+2q
FbZIqxtzRLJcy2lG2Yw24pc3/AgJdm1RD3b0a0CEayYcRMe1VOlxMMDrDoB2D6XH
w8Y0zxbwNy/sTRiXIBUJZnf3Yc+xcg==
=55Gl
-----END PGP SIGNATURE-----

--qONoz+opKwc0uBGE--
