Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A95B7A5080
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjIRRHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjIRRHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:07:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D4383
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:07:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCFFC433AD;
        Mon, 18 Sep 2023 13:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695043894;
        bh=K06M3VCr0WHKqkg1Cw3llw5aRxi2imdgpuq+0caHVrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIkb50CwTmrvliTx4dhLfE3sM2zHntXcc0rjgJrTIRi8nlkvU6XdOzQqvcqT+6Vkt
         OgR48Iq/Txyw1RuyjMqQVmzsd1Ie1EcSSdnp9cZBHzl0CM7Dlw5i9ULq9wPbkRCpxu
         /vt1twaho0ZShLhc8ohWqIPFncebh3mxB5aJW8cbAlDLnGMMxu7EIf6ZHNrxfZuxW2
         AKwrw2lynoZSQC68AqoU7ugpRuE6T20273oWoqJ9IgG3F4r6Anwl6mmEHxclDKBVPE
         DbhV572jaEE3ZxlhRXnKJMFVR74bB/bQ5FbZ8U4UkSbuDNgkgaBC5XVzytS8F6PRz2
         NXP+esALPesUQ==
Date:   Mon, 18 Sep 2023 14:31:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandra Diupina <adiupina@astralinux.ru>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eason Yen <eason.yen@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] asoc: mediatek: common: Remove check of return value of
 mtk_memif_set_addr() and mtk_memif_set_format()
Message-ID: <0b94717e-1198-4b6d-bd64-270dbeb92f79@sirena.org.uk>
References: <20230825153650.20923-1-adiupina@astralinux.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DRbDaKLEClkXmGi+"
Content-Disposition: inline
In-Reply-To: <20230825153650.20923-1-adiupina@astralinux.ru>
X-Cookie: Never kick a man, unless he's down.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DRbDaKLEClkXmGi+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 06:36:50PM +0300, Alexandra Diupina wrote:
> The mtk_memif_set_addr() and mtk_memif_set_format() functions always retu=
rns 0, so it is
> necessary to remove the check of its return value (which was
> probably specified by analogy with the check of return values
> for other functions) to make the code more readable

If the return values can be safely ignored the functions should be
updated to return void, if the functions are returning a value it is
sensible defensive programming to check it.

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: df799b9502ed ("ASoC: mediatek: common: refine hw_params and hw_pre=
pare")

This is in no way a bug fix, please don't include noise like this - it
causes people to waste time doing things like considering it for backport.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--DRbDaKLEClkXmGi+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUIUS8ACgkQJNaLcl1U
h9B5fAf/Wt1o8/BD/FOp0dhg9MPqSJ4CExDadYY8vIXEpw9Txy/tYSjqR1VbchGZ
OBfqVnvtKgqQy7XgNCLffYhzsq1dCkQO1TDWU38imdMCCYswL7+MfBdxA6ZqqQlK
GGChui6/43ql1XZ1rQ76ZQiuNo4SEKVf2DmcPNee1CiwIoTm7JPVQcWL7SDXAHnC
v+GQrwEVj4BHZzfWuIa8vuoHf/GdYpGWuUkVYPVxS4/Wsd3NoKMQ/4O3ajJOQD4g
F/2uzEi9/y6EX0/8n8xIJ0+vKtPtvuxR5Y7aKnTU509sCU2TQgOEGzAfqc13odCj
3xhnA7V0r+I66VKwPZXUCimV2+Jhyw==
=uuBR
-----END PGP SIGNATURE-----

--DRbDaKLEClkXmGi+--
