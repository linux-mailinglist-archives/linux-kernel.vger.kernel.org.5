Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976D9756369
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGQMzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGQMz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:55:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E235E49
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:55:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F08BA61038
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DB5C433C8;
        Mon, 17 Jul 2023 12:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689598526;
        bh=Iqh7TfjijModD1NwjJzA82R/SnUFVzZQQvN3iUdM0Dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cqxtSMHeVaOO2y+5T7XvfymkK6ZiMuedPIKRkPc7kZ9pVnWDBY2HBK+wDsN53yylv
         s5GLwxI0ftOyPwsJcIqnGzeGNPUuQ+jlhngpUgzqdlA4rGdKxeTjsP5V1RCLp4LfJY
         ICOTTmXoJYPGBTJiXJ73iT/WbmIkOia21Eybua6b79PomacrGD6uPmyeE5gOy2znNQ
         L3mgvj27TR3Qx+jTbphosG7wrF6TRG0HTAM+IjG5/Z75NRGyC7vZNHdewK/rT863FD
         C8D8jblHKb4vGXwarkv/u5Wk4wSfeviBjcOW6yuC6+49sbSPihS2kIKmSbdXyzlXdt
         XM0QSQqyU1rTQ==
Date:   Mon, 17 Jul 2023 13:55:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Matus Gajdos <matuszpd@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_sai: Disable bit clock with transmitter
Message-ID: <d2cbf249-32e1-4e19-8362-7087d6b7d3d8@sirena.org.uk>
References: <20230712124934.32232-1-matuszpd@gmail.com>
 <CAOMZO5ATTK7UsTRPTF_7r86WbNmAhtpEphO2u896QqARTk2kpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PksENF3NvhBOBXfu"
Content-Disposition: inline
In-Reply-To: <CAOMZO5ATTK7UsTRPTF_7r86WbNmAhtpEphO2u896QqARTk2kpA@mail.gmail.com>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PksENF3NvhBOBXfu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 09:31:38AM -0300, Fabio Estevam wrote:
> On Wed, Jul 12, 2023 at 9:53=E2=80=AFAM Matus Gajdos <matuszpd@gmail.com>=
 wrote:
> >
> > Otherwise bit clock remains running writing invalid data to the DAC.
> >
> > Signed-off-by: Matus Gajdos <matuszpd@gmail.com>
>=20
> Should this contain a Fixes tag so that it could be backported to
> stable kernels?

I'll just put a non-specific Cc stable tag on it, that should be enough
to get it backported.

--PksENF3NvhBOBXfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS1OjcACgkQJNaLcl1U
h9DS1wf/c16EisoD6DHiFlMXL2USTW4POzR71yM0WbVK9sShUOKNMw++l2llTr8F
+2lfuS0cGsgEJxtBPRJnWJlUleMwVRHpZJ9Vhl7TdwFQF7X2G6jXGFO6EFg7aBqz
knhGCxOTfYZO3MqD3ppBKGhcaNJdoWOWi8Dre2NNh6StSURThYv+hSIwp92OQP3W
09ssoeCBkrVkOmvWoxIJ8fgkr0b2ySIXi0dDLeeTAhZ73xydCGq9GehXiJphnshX
iSAYkBqrD6ioCD+8n1kO4a4Jp18sTF1IVvGEonzv9sVpSavKrqWIohI5Kiu318TP
lVKVvYs/7EH4FswQ2FztkW7ksidFZQ==
=3WHI
-----END PGP SIGNATURE-----

--PksENF3NvhBOBXfu--
