Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA0803295
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjLDM1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjLDM1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:27:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA84C0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:27:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B56EC433C8;
        Mon,  4 Dec 2023 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701692873;
        bh=W7f0pOjg304HyKPpQW7nP4LI4oM3YnuorMhU4Q0ZrLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEiDVoTK2D3qff6nHAmnZtWpkkVNTUSyGrqjuyC/u/Q8CHrOEMmrUYWZD8oSMh6Et
         l8iSYt3cvd2nczJWYc+wV3VP1XW+fh28UByZKsxZXhGBECdTsICPmkVWH1jRT1MfS0
         /590eRRWIM82tMFK+qd7H9524x4c+T/UPIzT2fvouOgh7KAaiQ7Kyj9M44Ur6gg0g0
         oL+belo7cKfxKocpm5E2wY0FTWX1umZiYntOgDXIsaN4jJaB5Nr2voskSAo1Pfb/bB
         szKZqxUls0w/qqCduZuiHes4P3PTZT13cGluVIbVRQoTjP9KTVcoOKQxNXaW/JTMUW
         G/BA+vlE8me7Q==
Date:   Mon, 4 Dec 2023 12:27:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: SOF: Move sof_of_machine_select() to core.c from
 sof-of-dev.c
Message-ID: <76ca7ffb-3881-468f-aef8-47ec6723e4bd@sirena.org.uk>
References: <20231204033549.2020289-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UcsYHd9sLq57ihM2"
Content-Disposition: inline
In-Reply-To: <20231204033549.2020289-1-wenst@chromium.org>
X-Cookie: For office use only.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UcsYHd9sLq57ihM2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 04, 2023 at 11:35:47AM +0800, Chen-Yu Tsai wrote:

> This reverts commit 014fdeb0d747304111cfecf93df4407c1a0c80db.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--UcsYHd9sLq57ihM2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVtxcIACgkQJNaLcl1U
h9AynAf8CEBCwsobXc9txfMwNf9AcFUdJlsRlH78OTUCy5HjmnqVhEvigo19ZCzl
MRalW+nYuo1UneAK1iENEHzBrl0wJEJzgeiVWoCLINrrpOVfHno6j+8XGFt8+/ef
WI0hbYqByLuZLxo0ImrJc86HUE5RL95khKkaJjk7cMVKlY6l4jqusubnmrbM/fEt
mq8rZLnNGLTf0XR/K3YkI2s/wvbsxdVVEQ/TSqoHgQzQcsUVGK1M+uKL8vNKSuI4
SQiZRuh3y6xgIgrNEff+TdVo4itr39uHj1IOjxNdNsBLx0xQITBWN2TaMMrMb1FD
UeeTbYxEM3MbmTwtgwaoDrplP4dcAQ==
=VXtL
-----END PGP SIGNATURE-----

--UcsYHd9sLq57ihM2--
