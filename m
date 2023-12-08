Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67E9809EB6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573420AbjLHJCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbjLHJCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:02:20 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5851703
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:02:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBWkJ-0003GX-Cl; Fri, 08 Dec 2023 10:02:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBWkH-00ENT4-HR; Fri, 08 Dec 2023 10:02:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBWkH-00GLAI-7q; Fri, 08 Dec 2023 10:02:05 +0100
Date:   Fri, 8 Dec 2023 10:02:05 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Ian Ray <ian.ray@ge.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        kernel@collabora.com, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCHv4] serial: imx: Add DMA buffer configuration via sysfs
Message-ID: <20231208090205.ioc76sych3snjiwb@pengutronix.de>
References: <20210305115058.92284-1-sebastian.reichel@collabora.com>
 <YEIetFdcuYZU98s/@kroah.com>
 <20210305124252.c3ffgca6wjqpkn45@earth.universe>
 <20210405214446.zhidvtvahcfp4wxa@earth.universe>
 <YGwKAOmlHRgEVh20@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ff53tonb2aszag6u"
Content-Disposition: inline
In-Reply-To: <YGwKAOmlHRgEVh20@kroah.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ff53tonb2aszag6u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

[Cc +=3D dt maintainers]

On Tue, Apr 06, 2021 at 09:13:04AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 05, 2021 at 11:44:46PM +0200, Sebastian Reichel wrote:
> > On Fri, Mar 05, 2021 at 01:42:52PM +0100, Sebastian Reichel wrote:
> > > On Fri, Mar 05, 2021 at 01:06:12PM +0100, Greg Kroah-Hartman wrote:
> > > > On Fri, Mar 05, 2021 at 12:50:58PM +0100, Sebastian Reichel wrote:
> > > > > From: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> > > > >=20
> > > > > In order to optimize serial communication (performance/throughput=
 VS
> > > > > latency), we may need to tweak DMA period number and size. This a=
dds
> > > > > sysfs attributes to configure those values before initialising DM=
A.
> > > > > The defaults will stay the same as before (16 buffers with a size=
 of
> > > > > 1024 bytes). Afterwards the values can be read/write with the
> > > > > following sysfs files:
> > > > >=20
> > > > > /sys/class/tty/ttymxc*/dma_buffer_size
> > > > > /sys/class/tty/ttymxc*/dma_buffer_count
> > > >=20
> > > > Ick no.  Custom sysfs attributes for things like serial ports are c=
razy.
> > > >=20
> > > > > This is mainly needed for GEHC CS ONE (arch/arm/boot/dts/imx53-pp=
d.dts),
> > > > > which has multiple microcontrollers connected via UART controllin=
g. One
> > > > > of the UARTs is connected to an on-board microcontroller at 19200=
 baud,
> > > > > which constantly pushes critical data (so aging character detect
> > > > > interrupt will never trigger). This data must be processed at 50-=
200 Hz,
> > > > > so UART should return data in less than 5-20ms. With 1024 byte DMA
> > > > > buffer (and a constant data stream) the read operation instead ne=
eds
> > > > > 1024 byte / 19200 baud =3D 53.333ms, which is way too long (note:=
 Worst
> > > > > Case would be remote processor sending data with short pauses <=
=3D 7
> > > > > characters, which would further increase this number). The current
> > > > > downstream kernel instead configures 24 bytes resulting in 1.25ms,
> > > > > but that is obviously not sensible for normal UART use cases and =
cannot
> > > > > be used as new default.
> > > >=20
> > > > Why can't this be a device tree attribute? Why does this have to be=
 a
> > > > sysfs thing that no one will know how to tune and set over time.  T=
his
> > > > hardware should not force a user to manually tune it to get it to w=
ork
> > > > properly, this isn't the 1990's anymore :(
> > > >=20
> > > > Please never force a user to choose stuff like this, they never will
> > > > know what to do.
> > >=20
> > > This used to be a DT attribute in PATCHv1. It has been moved over to
> > > sysfs since PATCHv2, since it does not describe the hardware, but
> > > configuration. Unfortunately lore.kernel.org does not have the full
> > > thread, but this is the discussion:
> > >=20
> > > https://lore.kernel.org/linux-serial/20170629182618.jpahpmuq364ldcv2@=
pengutronix.de/
> > >=20
> > > From downstream POV this can be done either by adding a DT property
> > > to the UART node, or by adding a udev rule.
> > >=20
> > > From my POV there is not a huge difference. In both cases we will
> > > be bound by an ABI afterwards, in both cases people will usually
> > > stick to the default value and in both cases people that do deviate
> > > from the default probably ran into problems and started to look
> > > for a solution.
> >=20
> > ping? It's not very nice to get a rejected in cycles :(
>=20
> I recommend working with the DT people here, as custom sysfs attributes
> for things like this that are really just describing the hardware is
> crazy.

I was one who expressed concerns in the earlier rounds that dt isn't the
right place for this. dt is about hardware description, but choosing
a good value for the dma buffer size is driver tuning and depends on the
individual requirements. (latency, throughput, memory consumption,
robustness under system load). I can even imagine use cases where the
settings should be changed dynamically, which cannot (easily) be done
using dt.

While I see your point that a driver specific sysfs property is
unusual/strange/whatever every downside you mentioned also applies to a
dt property (or a custom ioctl).

Among the solutions I can imagine, my preference order is:

 - automatic tuning
 - sysfs property
 - further discussion
 - dt property
 - custom ioctl

I wonder if there is a sensible way to implement a automatic tuning. In
the use case mentioned in the commit log, Sebastian's need is low
latency for a constantly sending microcontroller on the other side. Is
it sensible to make the used dma buffers smaller if we have a certain
throughput? Or is that too magic and doomed to fail covering most use
cases? If that doesn't work, I support Sebastian's approach to do that
in a sysfs property.

Sebastian, have you evaluated just not using dma for these UARTs?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ff53tonb2aszag6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVy24wACgkQj4D7WH0S
/k7+ggf+Mcv56tDH2NcnNQ7qncn8ZtwodtWIarYf4MDerc7cZntyFdkGOLbJ8CdE
cCulj6BnK1Yjl9nCz4tYqd6XY0SoDIR5mFdudhQU5ViQTTt9ohYT6pjqeL1F2dVc
ozhSFoFasBucM1QVIoZR5sgXWQR0mUoPWpY11YFYbjNzC4ZGA4R9Ill3P8iFLMQR
d7e/M2jBKIR+0XlHO+m4s3zy/oTxh7ZXj4IcBQqhlnfaz+A8vUJutMZ/kDCcVAvH
k4AhpafOEU3IeH3OJEXPs9Q9MfUzCBGfgCNCI7YX5qrzx3tmGNQg/EWw2V7P2npz
9nWpionkSNv4oKH2RT7cjG2Ad+JljA==
=iVEI
-----END PGP SIGNATURE-----

--ff53tonb2aszag6u--
