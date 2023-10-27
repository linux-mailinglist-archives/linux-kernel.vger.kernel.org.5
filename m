Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC377D9D40
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346195AbjJ0Ppd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345780AbjJ0Ppb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:45:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60072B8;
        Fri, 27 Oct 2023 08:45:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E8BC433CA;
        Fri, 27 Oct 2023 15:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698421529;
        bh=Baa+A2T9pHR5w9mQAEwQT8AFlDHNCPYd0F88xPPlOYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqbfePkCiqTz1f9wsXZyWvhrGUUm/uK6IPStBxduVBkMvO4wqIB1eCbcCzl+XRWtE
         Eyh5JmRTcCmuq2eQdsleFkkFd3u5n2VKkboI1hwL4Yn9T+TYGekG41brcbROjMAq6K
         nVkKT4Nigxf5FF8vAaZCFhzaL80aCTqiB85SmDTIbj2LNnkdXWB/DhmMaifVqF8S1j
         fuVS5XjofWd4zMvNgu4ZNJP8qRm8VGO0SNFARgCF/a51ENc4SoHGna+gJSyv1TZvKL
         C7X/BWnVRP5/GPhKINtt3etTqw/1hV3cFU2CyKL1Pvhkt0rEmErz8DnIxO7dWBIDci
         /Hx6ffRr2M0cQ==
Date:   Fri, 27 Oct 2023 16:45:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Stoll, Eberhard" <eberhard.stoll@kontron.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Eberhard Stoll <estl@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "Schrempf, Frieder" <frieder.schrempf@kontron.de>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: AW: [PATCH 1/4] spi: Add parameter for clock to rx delay
Message-ID: <ZTvbFc+kFMotVUkh@finisterre.sirena.org.uk>
References: <20231026152316.2729575-1-estl@gmx.net>
 <20231026152316.2729575-2-estl@gmx.net>
 <20231027005643.4b95f17e@xps-13>
 <DB9PR10MB82468A8BD333B12D3FCB3C43F1DCA@DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM>
 <ZTujIs2O+GYKIPlU@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t+iyWvYvU8cBITVd"
Content-Disposition: inline
In-Reply-To: <ZTujIs2O+GYKIPlU@smile.fi.intel.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t+iyWvYvU8cBITVd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 27, 2023 at 02:46:42PM +0300, Andy Shevchenko wrote:

> So, to me sounds like device tree source issue. I.e. you need to provide
> different DT(b)s depending on the platform (and how it should be).
> The cleanest solution (as I see not the first time people I trying quirks like
> this to be part of the subsystems / drivers) is to make DT core (OF) to have
> conditionals or boot-time modifications allowed.

> This, what you are doing, does not scale and smells like an ugly hack.

No, this seems like an entirely reasonable thing to have - it's just a
property of the device, we don't need to add a DT property for it, and
the maximum speed that the device can run at is going to vary depending
on the ability of the controller to control the sampling point.

As people have been saying there's a particularly clear case for this
with SPI flash which is probed at runtime and is readily substituted at
the hardware level.

--t+iyWvYvU8cBITVd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU72w4ACgkQJNaLcl1U
h9AzXAf/U69EcDG6BKh7GvxVDQ45r9zmTFIm3xM7WXD0qH+qxx0fMewR3y/JF0LA
qMH/a2wPo8djtZBJOz5RM80PaIf4/2K9uj3D1m5iuWKuHIicML+KE6FCMmeSvXBo
TFd2RgKSOFkLoZXmcfJbTMN1oMw0DL/j8ZENCnexMxSF7hrCBFxlpRj3bcKyBp9n
wUhXhfew3/aZNffqWAj2e9HaixbJEqyTV/YYAldTFblGgLYZOdpHsV6br86mXdRv
H83PyiLZzWj/w/1If3GLEROsnzISxyoSuf+U28gGNEJlHrY4bANXEcFJUpnlDj8y
Y6ZrCknBoHrHpxc8xsL7ABl8Vk45Mw==
=atJr
-----END PGP SIGNATURE-----

--t+iyWvYvU8cBITVd--
