Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D94754FF5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 19:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjGPRDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 13:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGPRDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 13:03:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7159C1B1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 10:03:17 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qL58u-0006CV-5l; Sun, 16 Jul 2023 19:02:44 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1B66C1F1E34;
        Sun, 16 Jul 2023 17:02:35 +0000 (UTC)
Date:   Sun, 16 Jul 2023 19:02:33 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Cla udiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        George McCollister <george.mccollister@gmail.com>,
        Andreas Larsson <andreas@gaisler.com>,
        Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Chris Snook <chris.snook@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Douglas Miller <dougmill@linux.ibm.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Tara s Chornyi <taras.chornyi@plvision.eu>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Timur Tabi <timur@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Vinod Ko ul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Kevin Brace <kevinbrace@bracecomputerlab.com>,
        Francois Romieu <romieu@fr.zoreil.com>,
        Michal Simek <michal.simek@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alex Elder <elder@kernel.org>,
        =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Pouille r <jerome.pouiller@silabs.com>,
        Richard Cochran <richardcochran@gmail.com>,
        devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-amlogic@lists.infradead.org, linux-oxnas@groups.io,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-wpan@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        wcn36xx@lists.infradead.org
Subject: Re: [PATCH] net: Explicitly include correct DT includes
Message-ID: <20230716-stout-grudging-1f91d771de85-mkl@pengutronix.de>
References: <20230714174809.4060885-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g5fw27woy7qbit6d"
Content-Disposition: inline
In-Reply-To: <20230714174809.4060885-1-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g5fw27woy7qbit6d
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vxeub4efr4nku2wd"
Content-Disposition: inline


--vxeub4efr4nku2wd
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2mmyiduer253ii4f"
Content-Disposition: inline


--2mmyiduer253ii4f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.07.2023 11:48:00, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/net/can/bxcan.c                                 | 1 -
>  drivers/net/can/ifi_canfd/ifi_canfd.c                   | 1 -
>  drivers/net/can/m_can/m_can.c                           | 1 -
>  drivers/net/can/m_can/m_can.h                           | 1 -
>  drivers/net/can/rcar/rcar_canfd.c                       | 1 -
>  drivers/net/can/sja1000/sja1000_platform.c              | 1 -
>  drivers/net/can/sun4i_can.c                             | 1 -
>  drivers/net/can/ti_hecc.c                               | 1 -

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # for drivers/net/can

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2mmyiduer253ii4f--

--vxeub4efr4nku2wd--

--g5fw27woy7qbit6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS0IqYACgkQvlAcSiqK
BOhfLQgAnOPxJiYWHd0YYYBr6D5Xvaa7YD/llBx5YeP2Eol6zKlE5NW1xdwBoHP/
oxs3PENqI/mVuAtWhs6sNCSEtOEssWtUWrx23I9bxRa2AE/DUWfpg/NP/sy3ZVsV
sYgzGHOJqf+S+OMzalvZ9hIDu+a6xxhA9rUTaK2lNn0nBeWxEf92JhPV+nGREldR
CHY3WW/trL1qHxxtn7ZWhI2IVounTWpkXZnJz9DRocIQrm1mPmNz5lcwkr+ST1th
C92e2GJEahuxXdOMXfuuGMUSGzFqGZRtKT3WAx9/8l/lUsyKZ9Jhn1Rv7NE9zNPG
R640Tfvr5cFRQIVusYrKVMlQ8URlUg==
=ICgU
-----END PGP SIGNATURE-----

--g5fw27woy7qbit6d--
