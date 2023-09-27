Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BC47B0023
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjI0Jbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjI0Jb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:31:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FBAE6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:31:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A4EC433C8;
        Wed, 27 Sep 2023 09:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695807085;
        bh=cZsA2Bwd5dQg9fYOxwh55qsutXEo02ZTNVCxfZZnx0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y8P+kEwL06U8frDbg5i9jjN17qhUSZOwPiDgpdAZnQx4QfYGB4Tq9t0bTW8k7ilfg
         B4atijvydEMAXhYsJ9jRBWZmoMC1KQZhZEA+Mo2mg/gWhXxZbFr8chYsw/wpJFwVU8
         pJdy1RIOxSvpdQ3zIYR3SwqBEy2ScBMVyzaQ7hXvh4JnWbGjuM+VfROVbMJ9QGNMmw
         fNLlASOB0x/r+vSOMA6pL4tRQyNaSzGnHRKChxpe4T07nUqBshzpkq0mEyVz3gH14B
         vHTBYztxuERLxslIQmqkBrn6yBsCHVnyY27UVJQnG9oqXbaaJ+OV/k+conhKfeD8yn
         rCKTp92Pcyytg==
Date:   Wed, 27 Sep 2023 11:31:22 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] ASoC: soc-pcm.c: Make sure DAI parameters cleared
 if the DAI becomes inactive
Message-ID: <ZRP2aghTvU4x3FUR@finisterre.sirena.org.uk>
References: <20230920153621.711373-1-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CnAeQwTRQV9vuxnA"
Content-Disposition: inline
In-Reply-To: <20230920153621.711373-1-chancel.liu@nxp.com>
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


--CnAeQwTRQV9vuxnA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 11:36:20PM +0800, Chancel Liu wrote:
> It's reasonable that DAI parameters should be cleared if current DAI beco=
mes
> inactive.
>=20
> Only check DAI active status in soc_pcm_hw_free() is not enough since the=
re's
> the risk that DAI parameters never be cleared if there're more than one s=
tream
> [see A]. Only check DAI active status in soc_pcm_close() is also not enou=
gh
> since it will cause the cleanup just happening in soc_pcm_close() [see B].

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--CnAeQwTRQV9vuxnA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUT9mkACgkQJNaLcl1U
h9CZ7gf/TT2l6M7xebGR8UgDez3KbRn8MJrAq4wQDPw4rST8oHs5jSgX59/Neefh
fvfZ1NIAmstyP9g1O8lHM7H4ROVZ8vBgXNbqNgRdXWTssOHpadjJqWXkSOE3UYv6
ZDfdPcZuapuT8p65DUv7lsnZaKogJ/WuW8uR5+9cmVFP6CZ/A4r6kzMoqi2W6B6h
UeTKydJrVgo+X0pfO8OJdbjU+3np4ozx7rc19yU2m3l1pM4ZJrDL6A2/3929MZkn
83aOAoiyNXUZb2JXXdoxeFj9UtR11Aq/32oKdHt0VXLyNgpo9Ak2q//08KGTStaL
3eFeQDEsvL/YLfyGPR3xwiKxFNk7fw==
=IksO
-----END PGP SIGNATURE-----

--CnAeQwTRQV9vuxnA--
