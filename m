Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82E1755D56
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGQHrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGQHrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:47:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753F6173E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:46:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLIvw-0006Ew-M1; Mon, 17 Jul 2023 09:46:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLIvu-0004V7-Rb; Mon, 17 Jul 2023 09:46:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLIvu-005Wy1-6x; Mon, 17 Jul 2023 09:46:14 +0200
Date:   Mon, 17 Jul 2023 09:46:14 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH v8 1/5] pwm: dwc: split pci out of core driver
Message-ID: <20230717074614.zv2c26vh2j6cm3pz@pengutronix.de>
References: <20230614171457.69191-1-ben.dooks@sifive.com>
 <20230614171457.69191-2-ben.dooks@sifive.com>
 <20230715192832.hczmcchn4svzilnd@pengutronix.de>
 <faa870b6-112e-46fa-2b98-f5700dd76263@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rn6fijr2nsjoxci2"
Content-Disposition: inline
In-Reply-To: <faa870b6-112e-46fa-2b98-f5700dd76263@codethink.co.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rn6fijr2nsjoxci2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 08:07:10AM +0100, Ben Dooks wrote:
> On 15/07/2023 20:28, Uwe Kleine-K=F6nig wrote:
> > On Wed, Jun 14, 2023 at 06:14:53PM +0100, Ben Dooks wrote:
> > > Moving towards adding non-pci support for the driver, move the pci
> > > parts out of the core into their own module. This is partly due to
> > > the module_driver() code only being allowed once in a module and also
> > > to avoid a number of #ifdef if we build a single file in a system
> > > without pci support.
> > >=20
> > > Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> > > ---
> > > v8:
> > >   - add module namespace
> > >   - remove compile-test for pci case, doesn't make sense
> > >   - fix makefile, missed config symbol changes
> > > v7:
> > >   - re-order kconfig to make dwc core be selected by PCI driver
> > > v6:
> > >   - put DWC_PERIOD_NS back to avoid bisect issues
> > > v4:
> > >   - removed DWC_PERIOD_NS as not needed
> > > ---
> > >   drivers/pwm/Kconfig        |  14 ++-
> > >   drivers/pwm/Makefile       |   1 +
> > >   drivers/pwm/pwm-dwc-core.c | 176 +++++++++++++++++++++++++++++++++
> > >   drivers/pwm/pwm-dwc.c      | 197 +---------------------------------=
---
> > >   drivers/pwm/pwm-dwc.h      |  60 +++++++++++
> > >   5 files changed, 253 insertions(+), 195 deletions(-)
> > >   create mode 100644 drivers/pwm/pwm-dwc-core.c
> > >   create mode 100644 drivers/pwm/pwm-dwc.h
> > >=20
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index 8df861b1f4a3..7c54cdcb97a0 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -186,9 +186,19 @@ config PWM_CROS_EC
> > >   	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
> > >   	  Controller.
> > > +config PWM_DWC_CORE
> > > +	tristate
> > > +	depends on HAS_IOMEM
> > > +	help
> > > +	  PWM driver for Synopsys DWC PWM Controller.
> > > +
> > > +	  To compile this driver as a module, build the dependecies as
> > > +	  modules, this will be called pwm-dwc-core.
> > > +
> > >   config PWM_DWC
> > > -	tristate "DesignWare PWM Controller"
> > > -	depends on PCI
> > > +	tristate "DesignWare PWM Controller (PCI bus)"
> > > +	depends on HAS_IOMEM && PCI
> > > +	select PWM_DWC_CORE
> > >   	help
> > >   	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > index 19899b912e00..de3ed77e8d7c 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLK)		+=3D pwm-clk.o
> > >   obj-$(CONFIG_PWM_CLPS711X)	+=3D pwm-clps711x.o
> > >   obj-$(CONFIG_PWM_CRC)		+=3D pwm-crc.o
> > >   obj-$(CONFIG_PWM_CROS_EC)	+=3D pwm-cros-ec.o
> > > +obj-$(CONFIG_PWM_DWC_CORE)	+=3D pwm-dwc-core.o
> > >   obj-$(CONFIG_PWM_DWC)		+=3D pwm-dwc.o
> >=20
> > Would it make sense to call this pwm-dwc-pci.o? And the symbol
> > CONFIG_PWM_DWC_PCI? (The latter would break make oldconfig. Hmm, I'm
> > unsure myself.)
>=20
> i left the pci as the pwm-dwc so that anyone moving up and using
> this as a module won't have to change config or their module loading
> if they're not autoloading modules.

Yeah, I thought so. I don't care much either way, but maybe that's worth
mentioning in the commit log or even a comment in drivers/pwm/Makefile.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rn6fijr2nsjoxci2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS08cUACgkQj4D7WH0S
/k6UlQf+K5YF0HgTVhK6JnRE/jEYcmCeKznSCR1NLXV0Bc0fzqFvxHPoRL7t6wxy
khjN7dunvOiWsY1cjWjzXN1zl63TJzhgC/gENKiPSYux5S9mEhPKq8SLyDVfOflw
q0dzlx+XreE1Cxdjc3uIOCwz9mI6azvWN9l19SjqNc7M44H2tLjnJSB83TEC59BM
6WXYIFkZ/QZVJY31FZj7t6T571XKYmDnCJopq50om4kud689Hb1xrIy6xnFT24Kq
iq+yeW3ctSAOscOdZWsxBOrIonJlHuAJuftW7TEYWHywaOZZ0oPtRBuQox1SinMN
bHDKOxDUq0zDSgrfFyy554+Iet2s0A==
=1vuS
-----END PGP SIGNATURE-----

--rn6fijr2nsjoxci2--
