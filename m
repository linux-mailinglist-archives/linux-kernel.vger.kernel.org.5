Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071377B328B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjI2Ma1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjI2MaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:30:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38BB1A4;
        Fri, 29 Sep 2023 05:30:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E140C433CA;
        Fri, 29 Sep 2023 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695990622;
        bh=k3xWL1SFzzzjKlskAbPdlYIiwuzG0dgQRnQciFliyZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UsFiaWZ01OsYHejI1JkrdrSdiXnrA34eD8/7ewtFU0nwJODMuynMHcdkOjJkzu/Kw
         wKxCnLIVDoF6BkygQ/KosW0oZck0r4ha6LJ9NGGctYSioHQs0yNvnC30yQq4OnqUqR
         YTJ3lffhnRDOHTzSBcVgQfD4ZxfLO2RJAdGxILqI0fKB0Kq0uMUbPDZq1GK/AHV07P
         drywp+ZyiiHKANwtlZgwsmCN9jOxi/NoeqfvNmqmhTsWiuYizPLVQOMpLEJrlq9s6F
         I5UEqFrfiBdW5zRe0c1NuvTyFxhvAQ+KXMpVIgfZirGoIdQKuOcC5+5tRjcgM10CWe
         67/0pMjYjH9qQ==
Date:   Fri, 29 Sep 2023 14:30:19 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Weidong Wang <wangweidong.a@awinic.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] ASoC: codecs: aw88261: Remove non-existing reset gpio
Message-ID: <ZRbDW3OiAYyAkWgN@finisterre.sirena.org.uk>
References: <20230929-aw88261-reset-v1-1-fcbce194a823@fairphone.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SD/a1hNMLsiCOH6n"
Content-Disposition: inline
In-Reply-To: <20230929-aw88261-reset-v1-1-fcbce194a823@fairphone.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SD/a1hNMLsiCOH6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 29, 2023 at 12:28:10PM +0200, Luca Weiss wrote:
> According to the AW88261 datasheet (V1.1) and device schematics I have
> access to, there is no reset gpio present on the AW88261. Remove it.

That looks to be the case according to

   https://doc.awinic.com/doc/20230609wm/c815e155-60b7-40fb-889b-676b02e67d0a.pdf

(which is v1.5 FWIW), Weidong?

> In case this looks okay, also to the driver author at Awinic, the
> binding doc also needs to be updated to include this change and not
> require (or even allow) the reset-gpios anymore.

It would be easier to just send the proper patch to start off with, no
need to resend if the change is confirmed...

--SD/a1hNMLsiCOH6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUWw1sACgkQJNaLcl1U
h9B3awf9Ecjx0vZgr/DmTAk/ErHXnQYhrO7285dekc9QFcjY+deZ/HNdhv98fNQF
POx/4M6ic1tLfZQQBH+DV+zxHESvr5whmSjSfBpFvMMmmjEIvJajDf0jo/Q6nCXq
esnxJDQo+qlpn0MZr4rxwcXiBd5FfJNRrzdCWHMzwLd2IVC7YIpPAw7nSZA3Anss
xUNnH8KLKLJPSTGuqLOZkAMTVo3hcdXKUsNTWxZTCAQ4Z3b/gFuT9vw86zwqScar
CnHuMsbt8UQqEkU3Vt+wREY1chTTtqb0xIYzaXCbQpA0XRDPhmRG1IbFTJxhaQMd
/7nwPkI012VOvqWlWJcuv2pKe7zFQg==
=R6nY
-----END PGP SIGNATURE-----

--SD/a1hNMLsiCOH6n--
