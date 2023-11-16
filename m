Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA857EDFDB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345045AbjKPLaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjKPLaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:30:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B271FC2;
        Thu, 16 Nov 2023 03:30:08 -0800 (PST)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 18C916607341;
        Thu, 16 Nov 2023 11:30:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700134207;
        bh=ty13vCPH27VR0qcUKKKM2Jry6HZQD6mg6dHimPMzTEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJrFPOdpS1kkhBmp10jHXmq9Tiwj5qgRzpdNKjtfPGHUDuh4QDxsxj6ii96WSyPaj
         KpCe8apA6fcxPKX9VPUsPGIjILr+rm19Yg9MEwbO8/11In2s2PVcd71Hv7GoywHoQr
         WtU6W2zk2KC80AL3gFOgIFQp7l89hpJVw2df/Bq+UJsvznpvbXHBQnDXp3rfw4wpgF
         L/UiREDS5zU1BfkOI2qNfa1/sFQUGkiO95U+slrF3czh3TsKy3pJ51JjW7qx/Y93IY
         viTHpBGn6fh0ZDmH6zZyAK80CMwcOOt6xKNJb+UcJANqN4pETvo5eOhnEsUjPMDggH
         BInRD08XBbcTw==
Received: by mercury (Postfix, from userid 1000)
        id DFBD11062B52; Thu, 16 Nov 2023 12:30:04 +0100 (CET)
Date:   Thu, 16 Nov 2023 12:30:04 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Diederik de Haas <didi.debian@cknow.org>,
        Vincent Legoll <vincent.legoll@gmail.com>
Subject: Re: [PATCH v8 08/14] mfd: rk8xx: add rk806 support
Message-ID: <20231116113004.o77ayzlzchwdygro@mercury.elektranox.org>
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
 <20230504173618.142075-9-sebastian.reichel@collabora.com>
 <e612cef3-3bb6-46b7-a2c9-53fffc20c819@linaro.org>
 <20231115180050.5r5xukttz27vviyi@mercury.elektranox.org>
 <0ba99820-ada8-4a42-af99-3b57f585bec8@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oilhz3ei6idmqh75"
Content-Disposition: inline
In-Reply-To: <0ba99820-ada8-4a42-af99-3b57f585bec8@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oilhz3ei6idmqh75
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 16, 2023 at 09:41:03AM +0100, Neil Armstrong wrote:
> On 15/11/2023 19:00, Sebastian Reichel wrote:
> > On Wed, Nov 15, 2023 at 06:17:50PM +0100, Neil Armstrong wrote:
> > > On 04/05/2023 19:36, Sebastian Reichel wrote:
> > > > Add support for SPI connected rk806, which is used by the RK3588
> > > > evaluation boards. The PMIC is advertised to support I2C and SPI,
> > > > but the evaluation boards all use SPI. Thus only SPI support is
> > > > added here.
> > > >=20
> > > > Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> > > > Tested-by: Diederik de Haas <didi.debian@cknow.org> # Rock64, Quart=
z64 Model A + B
> > > > Tested-by: Vincent Legoll <vincent.legoll@gmail.com> # Pine64 Quart=
zPro64
> > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > > ---
> > > >    drivers/mfd/Kconfig       |  14 ++
> > > >    drivers/mfd/Makefile      |   1 +
> > > >    drivers/mfd/rk8xx-core.c  |  69 ++++++-
> > > >    drivers/mfd/rk8xx-spi.c   | 124 ++++++++++++
> > > >    include/linux/mfd/rk808.h | 409 ++++++++++++++++++++++++++++++++=
++++++
> > > >    5 files changed, 614 insertions(+), 3 deletions(-)
> > > >    create mode 100644 drivers/mfd/rk8xx-spi.c
> > > >=20
> > >=20
> > > <snip>
> > >=20
> > > > -	ret =3D devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> > > > -			      cells, nr_cells, NULL, 0,
> > > > +	ret =3D devm_mfd_add_devices(dev, 0, cells, nr_cells, NULL, 0,
> > > >    			      regmap_irq_get_domain(rk808->irq_data));
> > >=20
> > > It seems you replaced PLATFORM_DEVID_NONE by 0, triggering again the =
bug preventing
> > > having multiples RK pmics on the same system I fixed earlier at [1].
> >=20
> > All cells have PLATFORM_DEVID_NONE specified and thus are registered
> > without an ID. I changed this bit to avoid overriding the
> > information, since I did not want to have PLATFORM_DEVID_NONE for
> > rk806.
> >=20
> > > This gives (again):
> > > <4>[ 0.664107] sysfs: cannot create duplicate filename '/bus/platform=
/devices/rk808-clkout'
> >=20
> > Which means, you do not want PLATFORM_DEVID_NONE (-1), but
> > PLATFORM_DEVID_AUTO (-2). The above path is the expected path
> > for PLATFORM_DEVID_NONE.
> >=20
> > > <4>[ 0.664120] CPU: 3 PID: 97 Comm: kworker/u12:2 Not tainted 6.6.1 #1
> > > <4>[ 0.664131] Hardware name: Hardkernel ODROID-GO-Ultra (DT)
> > > <4>[ 0.664139] Workqueue: events_unbound deferred_probe_work_func
> > > <4>[ 0.664160] Call trace:
> > > <4>[ 0.664165] dump_backtrace+0x9c/0x11c
> > > <4>[ 0.664181] show_stack+0x18/0x24
> > > <4>[ 0.664193] dump_stack_lvl+0x78/0xc4
> > > <4>[ 0.664205] dump_stack+0x18/0x24
> > > <4>[ 0.664215] sysfs_warn_dup+0x64/0x80
> > > <4>[ 0.664227] sysfs_do_create_link_sd+0xf0/0xf8
> > > <4>[ 0.664239] sysfs_create_link+0x20/0x40
> > > <4>[ 0.664250] bus_add_device+0x114/0x160
> > > <4>[ 0.664259] device_add+0x3f0/0x7cc
> > > <4>[ 0.664267] platform_device_add+0x180/0x270
> > > <4>[ 0.664278] mfd_add_device+0x390/0x4a8
> > > <4>[ 0.664290] devm_mfd_add_devices+0xb0/0x150
> > > <4>[ 0.664301] rk8xx_probe+0x26c/0x410
> > > <4>[ 0.664312] rk8xx_i2c_probe+0x64/0x98
> > > <4>[ 0.664323] i2c_device_probe+0x104/0x2e8
> > > <4>[ 0.664333] really_probe+0x184/0x3c8
> > > <4>[ 0.664342] __driver_probe_device+0x7c/0x16c
> > > <4>[ 0.664351] driver_probe_device+0x3c/0x10c
> > > <4>[ 0.664360] __device_attach_driver+0xbc/0x158
> > > <4>[ 0.664369] bus_for_each_drv+0x80/0xdc
> > > <4>[ 0.664377] __device_attach+0x9c/0x1ac
> > > <4>[ 0.664386] device_initial_probe+0x14/0x20
> > > <4>[ 0.664395] bus_probe_device+0xac/0xb0
> > > <4>[ 0.664403] deferred_probe_work_func+0xa0/0xf4
> > > <4>[ 0.664412] process_one_work+0x1bc/0x378
> > > <4>[ 0.664421] worker_thread+0x1dc/0x3d4
> > > <4>[ 0.664429] kthread+0x104/0x118
> > > <4>[ 0.664440] ret_from_fork+0x10/0x20
> > > <3>[ 0.664494] rk8xx-i2c 0-001c: error -EEXIST: failed to add MFD dev=
ices
> > > <4>[ 0.666769] rk8xx-i2c: probe of 0-001c failed with error -17
> >=20
> > I didn't notice when working on rk806, but after analyzing it now:
> >=20
> > Your patch effectively set the cells to PLATFORM_DEVID_AUTO, because
> > you set all cells to PLATFORM_DEVID_NONE (-1) and additionally used
> > PLATFORM_DEVID_NONE (-1) for the devm_mfd_add_devices() call. But
> > that uses the sum of both IDs. Adding -1 to -1 is -2 and thus
> > PLATFORM_DEVID_AUTO. This is of course very confusing and just
> > worked by chance. There are two options:
> >=20
> > 1. Modify all cells to use PLATFORM_DEVID_AUTO instead of
> > PLATFORM_DEVID_NONE
> > 2. Drop the .id from all cells and use PLATFORM_DEVID_AUTO in the
> > call to devm_mfd_add_devices()
> >=20
> > Note, that switching from PLATFORM_DEVID_NONE to PLATFORM_DEVID_AUTO
> > modifies sysfs paths and thus might break people's scripts; that's why
> > I tried not to modify any existing platform. I will let you deal
> > with that, since I cannot even test any !rk806 platform supported by
> > this driver :)
>=20
> Yes it will modify sysfs path, but it's a regression since this before th=
is patch
> everything was registered with PLATFORM_DEVID_AUTO anyway,
> so I'll provide a fix adding back PLATFORM_DEVID_NONE to devm_mfd_add_dev=
ices
> in a first time...

If you just add back PLATFORM_DEVID_NONE to devm_mfd_add_devices(),
it will break rk806, since that correctly states PLATFORM_DEVID_AUTO
in its .id and that would become -3.

> > Also mfd_add_device should probably get special handling for
> > PLATFORM_DEVID_NONE, just like it already has special handling
> > for PLATFORM_DEVID_AUTO.
>=20
> ... and yes thanks for the great analysis I'll provide a change
> cleaning the mess.

Thanks,

-- Sebastian

--oilhz3ei6idmqh75
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmVV/TQACgkQ2O7X88g7
+ppMYBAApkTb+By74eCpGlr5FzKds21909i97OvIpuAzjyTiDAE+Q1Anv0xB8eAr
htCgueEeehsRnEXAnj8wmD1E2JgIAYcJ8yAPlK917bVE0zp9BlgTJcvC3lvEvKns
KTenrOGtbM97kCt4Uluesho5dJMTTRjzubHXyhcsndpBfaWTsnIRFsJ2VH2ZXMxu
gZqSanh1+KABV/5ESvmjmpD6dF0t1lCCH5eEPdUOJUDmcJbudTmpef4YEum1d4Xl
Q2NZVOOtWT5TjqKpz9dNAdATNDIzpy9pdPeCi4HX0jZIJQUlf+aG5UeKCFYS5dgD
+6yEOrx+F5nEKc/vWl4UXZrpV4ITcm6qJGx8P27ohsOXZbCI8NZ0hofTBwMn/PEw
dRG/QL644bi8Vx4ap9NJf1yC0Hx91ycvWzuCS6hGRiFEWZzt9awp1xgjfzPXSvLd
AOJP4vXhi+AbatFoi7hJf/PFQcIRWnxw6JfmBh+bg+PFrSiLFeYy1wYHd7o79cgm
xKjxFoz2Yspt8j506W9SIs609+sYBixrrbje3MoAAin0yQOKuI97eC3arYKt9L36
zRLWTl9FFWnCVbNd0Ew/T5QYeu2Veu66p7tvMTyszNLm542QxF4alVgfr71FUKsd
YWDpmvs5gbxFB/Av40BAQ1/4CPeiWDs0Jpp90zBj1iJsgcXYU0g=
=hZXx
-----END PGP SIGNATURE-----

--oilhz3ei6idmqh75--
