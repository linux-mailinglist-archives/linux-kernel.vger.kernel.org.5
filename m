Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B177C6AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343691AbjJLKNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjJLKNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:13:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808CCB8;
        Thu, 12 Oct 2023 03:13:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40602C433C8;
        Thu, 12 Oct 2023 10:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697105583;
        bh=S8PCgcA5OHp9XJ/wJB/pwGNXJXWuDW53tUyjXmrQDCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eh/BWXv8u4wGqu27YUYgTLMdX6XiiLAmXAowqH9fbIEmksAjC4u/p6NIlGoAOWGVU
         I/mF8wqwAZXBFCsJR7Ngx3RIIXbLJkzHIY7aM1PR71iIjbuH2ujApGqn84hN7Uv1x7
         Y8tH/wz8K0fcwUlAlWr8xyDPOhxiXiGtvkuPkXv0r43hsaij49l2KR/Pfn2+/lIpuJ
         47nuUk9CWECvQqMUyg/gEqZ/T0YR3m8pkqpc7MRvUAyOwyE7NxZNW9SCY3fjVOCmf3
         CoGusX/vMsD0htVcFl+HavbW8ABebvrTlG3yygXdQj6hDKh3E3edFItM9AIOkXVlIr
         u3r4apeiSLlag==
Date:   Thu, 12 Oct 2023 11:12:57 +0100
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
Message-ID: <87361226-14c6-46c0-a0a1-cc95b53287ab@sirena.org.uk>
References: <20231004183906.97845-1-brgl@bgdev.pl>
 <169696282723.222014.3485016870976123694.b4-ty@kernel.org>
 <CAMRc=MenBeJV+p6LirsCfyaPRWfAvSrVQayqUc77KOyvRGMqvQ@mail.gmail.com>
 <f1b8555b-5acb-43cd-b48b-1dfafdb8d27c@sirena.org.uk>
 <CAMRc=MdLXjnYiTjfoKjqAVcLvG5r3p5mWYbSupDM3Di-BAe5eQ@mail.gmail.com>
 <CAMRc=McY2d0tHE18qn5WAPYwTwFn+TVZt48WA-t5tMwzkPsjvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W9qulpyDLTFpPkLj"
Content-Disposition: inline
In-Reply-To: <CAMRc=McY2d0tHE18qn5WAPYwTwFn+TVZt48WA-t5tMwzkPsjvg@mail.gmail.com>
X-Cookie: I've Been Moved!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W9qulpyDLTFpPkLj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 10:40:53AM +0200, Bartosz Golaszewski wrote:
> On Wed, Oct 11, 2023 at 1:52=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:

> > I'm sorry. I didn't expect the removal process to go as fast as there
> > were quite a few users but it turned out to be almost ready now.

> > We can wait until rc7 when your for-next branch will be more or less
> > immutable and then you can tag
> > 21f252cd29f08892d48739fd7513ad79c1cff96a alone (it only has a few
> > commits between it and v6.6-rc1) if that works for you?

I spent some time yesterday looking at pulling out a branch but there's
other dependencies way back in the history so that's probably not going
to work well.

> Alternatively - if you send your SPI PR to Linus early in the merge
> window, I will send the patch removing gpiochip_find() later on top of
> it?

I tend to send all my PRs the morning the merge window opens so that'd
not be a problem.  If I send you a PR at -rc7 you'd realistically want
to wait until that was merged before sending yours anyway.

--W9qulpyDLTFpPkLj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUnxqgACgkQJNaLcl1U
h9BATQf8DDXvRpXocXw+zGCf7h+baCvPQZ/zwu1TwtP82vZGgVAL2uu8sCTUQ+V9
gxMTIrb6d6SlQ1Ue0LcMTUIUxLSt7OsEVSNO0tFXxH3990z8MGYzx+yDt4ZvLJb7
dgocDuOpe3bOhTf0d3fvZHFqdGQORgv538qDHlvnGIXzHgCbwuXd8LWKUiNKDnhQ
6eALnJ9qTUQIPFQSkbCZdsPdZCCFEh9tDyQJWfV/WpWxUOkwT0dsbLffGI8KtGT5
PxYIcDB+Okd/gosbLVvORfKvd+FFtj8MzkxSO6t3LiMmmUQRQDvZJP+/Q4VXHLwz
0cUykHWxe+ic1DcIHfoNIAZrH1csxA==
=H/NQ
-----END PGP SIGNATURE-----

--W9qulpyDLTFpPkLj--
