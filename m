Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179BA78FDE5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347334AbjIAM6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbjIAM6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:58:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F955E0;
        Fri,  1 Sep 2023 05:58:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E62DD61DA1;
        Fri,  1 Sep 2023 12:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6023EC433C8;
        Fri,  1 Sep 2023 12:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693573081;
        bh=RdPb4XfmBoPdgLciBy81PFwX6kWRVtgJtGzMBl1kvPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DsrpSTGw4elR2u8YKWrlE/1TN210UbEbk7Yaqz+qdUQpC7Q2T0RmJ94Y5tGZ/3r8Y
         SribhQxamfqHE3sFtF/I0L7py5PjW0A55RQweqqWLNALnxQwDnVmm2YHQdleMRTTYX
         cD3vyUJ777brbPwiB7hMvc+wNoLC/xexnQENCOxmqC0pXFxCRAedeLPGkmhIN+W4fQ
         p7112RZRiUGd3VFe8wX3oSdNTnR3EQxq75XTEjy0dJYcSWJvVx7iOusVFOdN3mFVlB
         VzkrO9y6LOBL2ZX+BZpmLgM2scISWTanBY0gd4M3ifvZxIODftSyOW21iwfuUbRwbO
         8VJ3mzn/PExQg==
Date:   Fri, 1 Sep 2023 13:57:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [RFT PATCH v2] spi: bcm2835: reduce the abuse of the GPIO API
Message-ID: <d57a99ce-77eb-409f-8371-95f2658fa0c0@sirena.org.uk>
References: <20230901111548.12733-1-brgl@bgdev.pl>
 <CACRpkdYLcOZQ9r46aBwesh-H392C_0AWC8n2ikuwUknfEhoNNA@mail.gmail.com>
 <ba9803e9-3aff-42b9-87ad-4e6d75d36d87@sirena.org.uk>
 <CAMRc=MdX3jtssO_zWCp9g5r00esGgASNeN437aJheRobVyqZcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UbHgzI4xkkVxHjkA"
Content-Disposition: inline
In-Reply-To: <CAMRc=MdX3jtssO_zWCp9g5r00esGgASNeN437aJheRobVyqZcQ@mail.gmail.com>
X-Cookie: Dealer prices may vary.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UbHgzI4xkkVxHjkA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 02:33:03PM +0200, Bartosz Golaszewski wrote:
> On Fri, Sep 1, 2023 at 2:31=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
> > On Fri, Sep 01, 2023 at 02:15:39PM +0200, Linus Walleij wrote:
> > > On Fri, Sep 1, 2023 at 1:15=E2=80=AFPM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote:

> > > > +       struct gpiod_lookup_table *lookup __free(kfree) =3D NULL;

> > > This is really neat.
> > > As noted, it will confuse static checkers at no end, but they just ha=
ve
> > > to adopt. (CC to Dan C if he now runs into this.)

> > It also doesn't look amazing for humans, it's very not C like...

> Once it's widely adopted, you'll see how much clearer and less prone
> to bugs in error paths the code becomes with autopointers. It's 2023
> dammit, if we can't have flying cars, let's at least get some RAII
> into the kernel. :)

I use RAII extensively with other languages, I also know that with C you
have to be careful and look to make sure everything is freed.

--UbHgzI4xkkVxHjkA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTx39EACgkQJNaLcl1U
h9DYSQf+Kt45phKyr2Mv/QTqMQDMfwNWLfKEDRASvlVuSaRZziL93qD2Z2RRYIuy
fGq3od30msoIcAwrDwsjl6wRY2CaX+xHihrFwbcTVIDBbeTsAszXAfrTiC+WjGmg
HvsgQ78GM1Q7My6TBtCKuQDu4BytC9TYSuqwFgPOfuVK/i56dbW4xcrfhU1Oj0QE
/HmcWN+5AlCObF5jv/r0Oi2roWA6BReoFX8dodtiFTJGKFyS0sLsWeFQnHQst3oF
Q4HnSdgGNzO04Nmqx/OCotlsP+bGo6uoM7gKAFBnZ9dJ9MGnFD0SrhDAiVSP6qn6
4JKfMLyMbc5wQNYJdnaLG5CtAiqpBw==
=Y5Dz
-----END PGP SIGNATURE-----

--UbHgzI4xkkVxHjkA--
