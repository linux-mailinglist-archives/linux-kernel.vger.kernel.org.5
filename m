Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E5676F1C6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjHCSX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjHCSX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:23:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A2D2D70
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DCB761D95
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 18:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94685C433C7;
        Thu,  3 Aug 2023 18:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691086943;
        bh=rYzPPj1pajmgQ2TmW2GpIgJRYwl2kR2mxM9iWu7OYjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6aJL/mRpVeQmNONdk7XxK2AOhD3aqkWHWLT9qV9Ktw2/Dt/gpNObxCUZ9JYjZYpw
         gP9Kt3vD0bkHcpyKO+CEM1X83XC5marYngM7sWTtf23hVjmsKZQIQ3tHvXv00g7f0Y
         RQqt5TvhRGAyGY51SzwYWWEKUYWpnAEyZ/96SIb1BYipcXpWbV86/dQJw4+hQnTDsP
         NMGDEZwSdI12lx6uDzVl8h5Ai4O3iqdN3NqTIgp8RAS+LyTggF9ihk/SBBgTNOePls
         Bd+/EEbK2FMcxSMzxYPL3TNaIxVyLhvq2G96s0w6ZF+or2qQRIn+FjJXyVz83Je+VX
         OdxN8LqfnCGAw==
Date:   Thu, 3 Aug 2023 19:22:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 RESEND*3] ASoC: fsl MPC52xx drivers require
 PPC_BESTCOMM
Message-ID: <4be1bfef-9f66-4fa8-bb8b-57e25fbba729@sirena.org.uk>
References: <20230803025941.24157-1-rdunlap@infradead.org>
 <9581313f-5340-455d-a75d-dc27d2eb3ec0@sirena.org.uk>
 <63bc327d-999a-1654-e7b5-6bcfd7477a32@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g3EJGwd85dmsC6Ch"
Content-Disposition: inline
In-Reply-To: <63bc327d-999a-1654-e7b5-6bcfd7477a32@infradead.org>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g3EJGwd85dmsC6Ch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 11:09:43AM -0700, Randy Dunlap wrote:
> On 8/3/23 04:27, Mark Brown wrote:
> > On Wed, Aug 02, 2023 at 07:59:41PM -0700, Randy Dunlap wrote:

> >> Both SND_MPC52xx_SOC_PCM030 and SND_MPC52xx_SOC_EFIKA select
> >> SND_SOC_MPC5200_AC97. The latter symbol depends on PPC_BESTCOMM,
> >> so the 2 former symbols should also depend on PPC_BESTCOMM since
> >> "select" does not follow any dependency chains.

> > Take a hint, it's not clear that the patch is tasteful.

> Thank you for replying.  I'll drop it and just report the build errors.

To be clear I generally don't give you review comments because in the
past I grew so frustrated with having them and their escalations
ignored that it seemed better to just not start.  If the patch seems
fine I generally apply it, usually you just don't resend patches so that
works.=20

--g3EJGwd85dmsC6Ch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTL8FkACgkQJNaLcl1U
h9A2ZAf/cC6V/6CosGIVhHjsgdpesC1xuhx10tq2L5C4HOOufOJXJ7KEEw9YRJl7
NbAWAp2aavscsub/zcP3OzBDFZ9vDRcYDniGIOdt9rv+JGtURTv8aFrbQdBFAAWR
KXfprV0EWwi45+heZNxo6a53tlFYu7Q0h5mVaI7O0R6wbMRr3z92A3BaCH1Eq3/8
6QZkJal7oeNWoHVHwUGSMb3PoqbRVadxYEWudjYGsAVhJ0IdHWyh1G6cx69iIOMz
DCVffJQOXcvvtkmc+oYvd2zfYT2sDSMcpRVBptb/2Dsy9gaaN3CwG9E/Agu4Li5L
WgG5XZBI+Jy/KxTlgICIsEVFG2bjvA==
=Nre9
-----END PGP SIGNATURE-----

--g3EJGwd85dmsC6Ch--
