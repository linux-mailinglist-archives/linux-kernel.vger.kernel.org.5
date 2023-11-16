Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA947EE02B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345154AbjKPLx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345132AbjKPLxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:53:55 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BA0187
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:53:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3avq-0003lL-PZ; Thu, 16 Nov 2023 12:53:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3avk-009RKv-1F; Thu, 16 Nov 2023 12:53:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3avj-002aey-NF; Thu, 16 Nov 2023 12:53:07 +0100
Date:   Thu, 16 Nov 2023 12:53:07 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org
Cc:     Jay Fang <f.fangjian@huawei.com>, Rob Herring <robh@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Tony Lindgren <tony@atomide.com>,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liu Ying <victor.liu@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Yangtao Li <frank.li@vivo.com>, Yuan Can <yuancan@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-tegra@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: [PULL] bus: Convert to platform remove callback returning void
Message-ID: <20231116115307.32rovgcej2s5pe4r@pengutronix.de>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
 <1e5e1008-707b-449a-9dbf-48324eb2b248@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uz4ywpyf2v5xtmw3"
Content-Disposition: inline
In-Reply-To: <1e5e1008-707b-449a-9dbf-48324eb2b248@app.fastmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uz4ywpyf2v5xtmw3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Arnd,

On Fri, Nov 10, 2023 at 07:32:01AM +0100, Arnd Bergmann wrote:
> On Thu, Nov 9, 2023, at 21:28, Uwe Kleine-K=F6nig wrote:
> > this series converts all drivers below drivers/bus to struct
> > platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
> > Provide a remove callback that returns no value") for an extended
> > explanation and the eventual goal.
> >
> > drivers/bus/fsl-mc was already addressed earlier with a separate
> > series[1].
> >
> > All conversations are trivial, because all .remove() callbacks returned
> > zero unconditionally.
> >
> > Some of the drivers touched here don't have a maintainer and there is no
> > maintainer for all of drivers/bus. It would be great if someone could p=
ick up
> > the whole series, maybe Arnd might do that?
>=20
> Sure, please send a pull request to soc@kernel.org if there
> are no further comments.

here it comes:

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.pengutronix.de/git/ukl/linux tags/bus-platform-remove-void

for you to fetch changes up to 7d6da8800a35d2257ff8b4b7d7c4551978f0a71a:

  bus: ts-nbus: Convert to platform remove callback returning void (2023-11=
-16 12:43:57 +0100)

----------------------------------------------------------------
This series converts all drivers below drivers/bus to struct
platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
Provide a remove callback that returns no value") for an extended
explanation and the eventual goal.

After the initial simplification in commit 864acca58000 ("bus: fsl-mc:
Drop if block with always false condition") all conversations are
trivial because the remove callbacks all return zero unconditionally.

----------------------------------------------------------------
Uwe Kleine-K=F6nig (14):
      bus: fsl-mc: Drop if block with always false condition
      bus: fsl-mc: Convert to platform remove callback returning void
      bus: hisi_lpc: Convert to platform remove callback returning void
      bus: omap-ocp2scp: Convert to platform remove callback returning void
      bus: omap_l3_smx: Convert to platform remove callback returning void
      bus: qcom-ssc-block-bus: Convert to platform remove callback returnin=
g void
      bus: simple-pm-bus: Convert to platform remove callback returning void
      bus: sun50i-de2: Convert to platform remove callback returning void
      bus: sunxi-rsb: Convert to platform remove callback returning void
      bus: tegra-aconnect: Convert to platform remove callback returning vo=
id
      bus: tegra-gmi: Convert to platform remove callback returning void
      bus: ti-pwmss: Convert to platform remove callback returning void
      bus: ti-sysc: Convert to platform remove callback returning void
      bus: ts-nbus: Convert to platform remove callback returning void

 drivers/bus/fsl-mc/fsl-mc-bus.c  | 16 +++-------------
 drivers/bus/hisi_lpc.c           |  6 ++----
 drivers/bus/omap-ocp2scp.c       |  6 ++----
 drivers/bus/omap_l3_smx.c        |  6 ++----
 drivers/bus/qcom-ssc-block-bus.c |  6 ++----
 drivers/bus/simple-pm-bus.c      |  7 +++----
 drivers/bus/sun50i-de2.c         |  5 ++---
 drivers/bus/sunxi-rsb.c          |  6 ++----
 drivers/bus/tegra-aconnect.c     |  6 ++----
 drivers/bus/tegra-gmi.c          |  6 ++----
 drivers/bus/ti-pwmss.c           |  5 ++---
 drivers/bus/ti-sysc.c            |  6 ++----
 drivers/bus/ts-nbus.c            |  6 ++----
 13 files changed, 28 insertions(+), 59 deletions(-)

Thanks for considering these changes,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uz4ywpyf2v5xtmw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVWAqIACgkQj4D7WH0S
/k4d1gf/TpLJMgm0K7phGR6IWiPk7QZqX2jnAbl6qyTi+9xjRHbuz/D4C7zAO46l
ZHY9vIM/qpv5F+ym/qOFKjh1byHDqtIdhJiICka50uHZfsH7LhgPtrf6O3sUWzeu
iA2Rv+ntUK7EabnEka/zzepJYvXPUiulla0N7to+syQffGo24ialHAubU9e2BztQ
q78IWAu/LKAgcMT6uxHCELNmTMuORFiN+DI2T4wVwbzLGh8IinScezVi1pmRREDI
gZTzC0dqmgDbLT57PFwpRRDWUrzj+B2HIzBd6BcZiG3eR6JQID4Z2ahfCDQTMM0o
9HDdblXjmhubXbN71G1MA0Mi7knPWQ==
=u4Db
-----END PGP SIGNATURE-----

--uz4ywpyf2v5xtmw3--
