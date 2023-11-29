Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6E37FE1AC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjK2VTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjK2VTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:19:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01034D7F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:19:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61002C433C9;
        Wed, 29 Nov 2023 21:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701292757;
        bh=/fnIy3jD+36xv/6RVbKvsPzVZU//UMZaIm+uyGyKuVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJGsY37qWAKZiaCPTj8usxvNJEo9ZjhCkmSFdb3EuOQP8O3tGp/pzkc8CgKfMQexL
         AzgxmckMb+VGbyGPYDZBGEKN0mGNEM3oRIM+Md8q4qyDVQ9Mp+E9THhxalSeJYPVA/
         nyMkErvsc5Q81ne41oYTE6NmOXl1MD5mM6aQr3uhd9CPha7TtcXcyys8c0UD0bYSgD
         MW/pdtMIwTbu3HdmHS7t7nOKdDu3orAeP/eEsZSD4uJ1hRuWUjBMtflrftYnD3PPmP
         MbnpP1ow5fPamK7cxRxJQX8fD1As2jOCKtYZCSq64maE9juW70AWhPoUFeDboMvp1G
         a72GRv2mLlyCw==
Date:   Wed, 29 Nov 2023 21:19:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Mario Kicherer <dev@kicherer.org>,
        Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] mtd: spi-nor: Stop reporting warning message when
 soft reset is not suported
Message-ID: <2e88fbd7-64ac-41a1-8368-edd430e86e6c@sirena.org.uk>
References: <20231129064311.272422-1-acelan.kao@canonical.com>
 <20231129064311.272422-2-acelan.kao@canonical.com>
 <9c97e28e-fbb8-4a7f-8205-821fcbd579f6@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7YWgVhkvHWbLOpD6"
Content-Disposition: inline
In-Reply-To: <9c97e28e-fbb8-4a7f-8205-821fcbd579f6@linaro.org>
X-Cookie: Are you a turtle?
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7YWgVhkvHWbLOpD6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2023 at 07:46:02AM +0000, Tudor Ambarus wrote:

> You haven't specified who shall take these patches. Is it fine for you
> if I take just the SPI NOR bits? If you want Mark to queue both:

I can certainly take both.  I guess there's no build time dependency so
we could each take the subsystem specific patch, though there'd be some
bisection drift if that happens?

--7YWgVhkvHWbLOpD6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVnqs4ACgkQJNaLcl1U
h9Bfywf+IhNs9FBX4arNA6V1SfNZlB4veB+gZpxcSWRk0wMv7//dofmoZXk9dEee
9dSuk4BjfDCsrfhbwbDY+3ieYDb2zZtxC3Zr3Rhfq8Y2e2amI5cRhc1x0XiQ60aZ
F9l4e2NteA9xPCZx2+IiE2tZg/guvNe0r1YgNM+iB4/yamLg/guVjCxpvvHPO1Wy
rpvn4WEUdrCEDAV7uk9dEtswP4ikWJAaWikmiZZUkto3f1pxhuU8g27GwJf5O7kI
a+wNykTKWEGa7Y7OS1wp+KhkrGlzz/L4e2oLyI9jT7QKw02+mR5PunZLOB6BcPv4
cljHGqo8YFG8eNl9P7dbAlsK0ZVpRQ==
=nOsL
-----END PGP SIGNATURE-----

--7YWgVhkvHWbLOpD6--
