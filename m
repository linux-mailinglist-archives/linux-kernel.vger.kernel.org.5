Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A5E79B01B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjIKUue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbjIKMbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:31:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C8D1B9;
        Mon, 11 Sep 2023 05:31:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B54C433C7;
        Mon, 11 Sep 2023 12:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694435506;
        bh=QRpBAeUI3hitgnSMQW2yEao4wcbtSpYQNtObb57edb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NDMtglzWsJ2DbsIiZrdGnYwd6+mP2wjZ02Dtk3Hglx+MAmOwc/gEQW3/UPuVhfi99
         bpg9lHNV+D2jbHm4URzIqXXvOxKTeswLHS2AftA+xA555vRElqfWQubv6JOfUVC7N5
         jnW2A9liKkfXz3c5IU2KtQtz4lceDvVosjoAxck/C9ruvwr/huyRC7oDHtB4t1YBOH
         BLVoBo/7HckY7lmbYhUDo3L+Ytp8suRxpJrWZzDL7HNsZ5R/bEPRNnMDiXIhsTpmgi
         r2rqwQvl4bcnkTDc+Wubloqer55o5Wxw0m28TDeg3QRnjkZe8Bc6h0TB0hsMpyRPXW
         AeZ8v+243VBzA==
Date:   Mon, 11 Sep 2023 13:31:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Myunguk Kim <mwkim@gaonchips.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Uw e =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jose Abreu <joabreu@synopsys.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH] ASoC: dwc: Add Single DMA mode support
Message-ID: <ZP8Irf6g+sG6Ax9j@finisterre.sirena.org.uk>
References: <20230911024023.43833-1-mwkim@gaonchips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DtMfBSD3gbWfkN9d"
Content-Disposition: inline
In-Reply-To: <20230911024023.43833-1-mwkim@gaonchips.com>
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


--DtMfBSD3gbWfkN9d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 11:40:23AM +0900, Myunguk Kim wrote:
> There is a SoC between dwc and DMA block (ie. PL330)
> that does not have a burst signal and supports only single.
>=20
> So write not-support-burst property on dts, it support single DMA mode.

This feels like something we ought to be discovering from the DMA API
somehow, while it's not quite a property of the DMA controller (but
rather of the SoC integration) in this case it could be a property of
some DMA controller elsewhere and the whole process of finding and
figuring out the properties of the DMA controler is handled by the DMA
API.

--DtMfBSD3gbWfkN9d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT/CKcACgkQJNaLcl1U
h9Dq6wf8D1e8icWFQphCSuOBQy9bjVPvV7mJb6wbO9yIefWMNrYj/sberQ5lGM5h
1/R+G76ou+eLpYY6O1qXHwb4LK6DO9Tp9MV7zxM+RJ3LhD2qzRyswhHFbAXlPXJb
KfJuHSq7npMz7EMEAi/Exoq0wJpMvsCeL8ekSWDBdOcoceB5FYAbeKtIRIrWvg0h
/rJlufpWyGYRrDY14C+bZSNivHhFaL3FfvKmBeRYw68kjZyjSH6cmo9dbWAzhVW4
yePTL5XZ7plwQMtpmwAg0GjF3HywcFSFXecr5AqbabTuQxL3hctZSquKn8h5XMrB
D8DoHnP6I+L0B1yA9XsEcRTXudElNA==
=dtYL
-----END PGP SIGNATURE-----

--DtMfBSD3gbWfkN9d--
