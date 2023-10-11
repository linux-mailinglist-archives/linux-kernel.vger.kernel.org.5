Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9B87C525F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbjJKLpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbjJKLpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:45:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F1098;
        Wed, 11 Oct 2023 04:45:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D906C433C8;
        Wed, 11 Oct 2023 11:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697024738;
        bh=2rNnRPbutD2jUkamVsQTXHOGYyI/vgTPHfVJILJMjwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CuxlfmYBe3Ygxsc2dKYGwo2ts/CUK4/jGB0tD3A8UgZi/YudGX8rhZ4Elsjg7+rQG
         ZvEfvBvgc5kpQQBnuYJjDXqNpNLNPW4DS9qMfHpTcPcxcPwMODhKSA2XIIv2IqCd/V
         HvGrQ1KdMsArRi6vBkiyWMyo8QJVepL7NHCB45djElooihPFX769nQ8nCL3O8F65P7
         0dvuGg7v8S/h/o6Yg/NScOvQ8opAVhh7eI+JslIOOdxAmjtPnHzrYWRyGroeQX/d4c
         6ww6ujsAxdHD+CaKzDkRpJDQQQGfpg5ljSRJl25z8PX/QkMBSXKbz4QIj79B0X1NM/
         xcROJvZ3ZxzWQ==
Date:   Wed, 11 Oct 2023 12:45:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] spi: bcm2835: add a sentinel at the end of the lookup
 array
Message-ID: <f1b8555b-5acb-43cd-b48b-1dfafdb8d27c@sirena.org.uk>
References: <20231004183906.97845-1-brgl@bgdev.pl>
 <169696282723.222014.3485016870976123694.b4-ty@kernel.org>
 <CAMRc=MenBeJV+p6LirsCfyaPRWfAvSrVQayqUc77KOyvRGMqvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="afp+guHfXX9/pd8X"
Content-Disposition: inline
In-Reply-To: <CAMRc=MenBeJV+p6LirsCfyaPRWfAvSrVQayqUc77KOyvRGMqvQ@mail.gmail.com>
X-Cookie: What an artist dies with me!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--afp+guHfXX9/pd8X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 09:36:19AM +0200, Bartosz Golaszewski wrote:
> On Tue, Oct 10, 2023 at 8:33=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> > On Wed, 04 Oct 2023 20:39:06 +0200, Bartosz Golaszewski wrote:

> > [1/1] spi: bcm2835: add a sentinel at the end of the lookup array
> >       commit: 9aaa25df9b02bfe5579cbc9b4cc1177c662ec33f

> Can you provide me with an immutable branch containing commit
> 21f252cd29f08892d48739fd7513ad79c1cff96a (the one this one fixes)?

> We are very close to removing gpiochip_find() from the GPIOLIB and
> with this pulled we could remove it for v6.7.

Ugh, *please* say this sort of thing when sending patches rather than
waiting until after they've been applied.  The default is just to add
patches to the normal development branches which means they have the
whole history for the release cycle after them and may well have other
things applied on top of them before you get round to asking for them to
be applied on a different branch as is the case here.

--afp+guHfXX9/pd8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUmitoACgkQJNaLcl1U
h9D+4Af8CJ5+ct01+tn2WsdFFMcvKELu0E7FSpEIegfW7OyA0n4hHQFdJIUS83hH
VBwCQ//WgRkIgr616SqVaxKy3XYgi34kMOCUWUUGFuPTUnSfuSZ8HkXBmY+e/eHf
5oepsYewqtgd4QqsQuTD+jVFM4K+/X5EtT4wl4gGXDLXaCjYZZpF37N3BwdaUOFL
EuZ0OyiUWhcY7BUv2a0jZJklE7J4fuTAT2DhE2xLd9WNrIM1P9JWzBNvy1JeoprG
v1fGaLY/pUNxJTh0o2i9qpo+IRuyAcrP69q4n6lnrGce7kdXC9PakeEIoUK81fAw
4v45+QwKR2do3HAR24Uy0g+zssca8g==
=/G22
-----END PGP SIGNATURE-----

--afp+guHfXX9/pd8X--
