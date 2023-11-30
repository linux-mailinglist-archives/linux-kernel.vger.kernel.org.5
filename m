Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E267FF1AE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345999AbjK3OWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345990AbjK3OWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:22:35 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6939C103;
        Thu, 30 Nov 2023 06:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1701354159; x=1732890159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gk6Lr/mLkcAzYJKKXK3mEyznPnvsvpZlhZ7hJ9+Q1Vs=;
  b=APEFvsOrm9iDwwEoOA7IGlN7ZM5bp/i1KFOG04/Ooh/VlZIAI0N0F/ht
   KKRTAvViLN6Cn6yufngaCUifXIWyFfKOIC5WGxCaHRcCuQVr2g0jhhuta
   YRlbX3UwKKoynOD8YTHDQGcg1qO0F43YswBQTtMIVpYd20K7I2GgRgqbH
   ZRtESa9RZxWpN4QuaNN4ocbfcw8X9n6LLelYziacWaFoo5Bj/kEsFntiU
   X/2pTiBnaHDTOxT9VfMZUEybp/Yu2KF1VwtHKhqwfBf89QR9yjj3bjxgx
   qtEuOFvsDAL0IYFS+z7u15mXWcsRrhiTKejalSvsvgjVqN5cBoqJoZZRv
   Q==;
X-IronPort-AV: E=Sophos;i="6.04,239,1695679200"; 
   d="scan'208";a="34264102"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 30 Nov 2023 15:22:37 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 0B1FF280075;
        Thu, 30 Nov 2023 15:22:37 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Adam Ford <aford173@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Elder <paul.elder@ideasonboard.com>,
        tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        open list <linux-kernel@vger.kernel.org>,
        ARM/FREESCALE IMX / MXC ARM ARCHITECTURE 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp: Add overlays for ISP instances
Date:   Thu, 30 Nov 2023 15:22:36 +0100
Message-ID: <5997862.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <170135295658.1400840.15195708825865805741@ping.linuxembedded.co.uk>
References: <20231129093113.255161-1-paul.elder@ideasonboard.com> <CAHCN7x+hBGmnJ2z8B9awpS1KU7rgVjseMw-uTE2Sc7DZ5+oTKA@mail.gmail.com> <170135295658.1400840.15195708825865805741@ping.linuxembedded.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Am Donnerstag, 30. November 2023, 15:02:36 CET schrieb Kieran Bingham:
> + Pantellis
>=20
> Quoting Adam Ford (2023-11-30 13:48:58)
>=20
> > On Thu, Nov 30, 2023 at 3:51=E2=80=AFAM Alexander Stein
> >=20
> > <alexander.stein@ew.tq-group.com> wrote:
> > > Hi Laurent,
> > >=20
> > > Am Mittwoch, 29. November 2023, 16:16:37 CET schrieb Laurent Pinchart:
> > > > Hi Alexander,
> > > >=20
> > > > On Wed, Nov 29, 2023 at 11:20:07AM +0100, Alexander Stein wrote:
> > > > > Am Mittwoch, 29. November 2023, 10:31:13 CET schrieb Paul Elder:
> > > > > > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > > >=20
> > > > > > Add two overlay to enable each ISP instance. The ISP is wired
> > > > > > directly
> > > > > > to the CSIS for now, bypassing the ISI completely.
> > > > >=20
> > > > > I'm not sure if this is worth adding in a separate overlay.
> > > >=20
> > > > The trouble is that, at this point, selection between the ISP and t=
he
> > > > ISI can only be performed through DT :-S That's why this is
> > > > implemented
> > > > as an overlay.
> > >=20
> > > I feel a better place would be the overlay which actually adds the
> > > sensor.
> > > This knows best whether ISI or ISP should be used.
> > >=20
> > > > > > Signed-off-by: Laurent Pinchart
> > > > > > <laurent.pinchart@ideasonboard.com>
> > > > > > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > > > > > ---
> > > > > >=20
> > > > > >  arch/arm64/boot/dts/freescale/Makefile        |  2 ++
> > > > > >  .../arm64/boot/dts/freescale/imx8mp-isp1.dtso | 36
> > > > > >  +++++++++++++++++++
> > > > > >  .../arm64/boot/dts/freescale/imx8mp-isp2.dtso | 36
> > > > > >  +++++++++++++++++++
> > > > > >  3 files changed, 74 insertions(+)
> > > > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-isp1.d=
tso
> > > > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-isp2.d=
tso
> > > > > >=20
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > > > > > b/arch/arm64/boot/dts/freescale/Makefile index
> > > > > > 300049037eb0..f97dfac11189
> > > > > > 100644
> > > > > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > > > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > > > > @@ -113,6 +113,8 @@ dtb-$(CONFIG_ARCH_MXC) +=3D
> > > > > > imx8mp-dhcom-pdk2.dtb
> > > > > >=20
> > > > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-dhcom-pdk3.dtb
> > > > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-evk.dtb
> > > > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-icore-mx8mp-edimm2.2.dtb
> > > > > >=20
> > > > > > +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-isp1.dtbo
> > > > > > +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-isp2.dtbo
> > > > > >=20
> > > > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-msc-sm2s-ep1.dtb
> > > > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-phyboard-pollux-rdk.dtb
> > > > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-tqma8mpql-mba8mpxl.dtb
> > > > > >=20
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso
> > > > > > b/arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso new file mode
> > > > > > 100644
> > > > > > index 000000000000..cf394ed224ab
> > > > > > --- /dev/null
> > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso
> > > > > > @@ -0,0 +1,36 @@
> > > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > > > +/*
> > > > > > + * Copyright 2022 Ideas on Board Oy
> > > > > > + */
> > > > > > +
> > > > > > +/dts-v1/;
> > > > > > +/plugin/;
> > > > > > +
> > > > > > +#include <dt-bindings/media/video-interfaces.h>
> > > > > > +
> > > > > > +&isi_0 {
> > > > > > + status =3D "disabled";
> > > > >=20
> > > > > ISI is disabled by default. What is your intention here?
> > > >=20
> > > > It could be enabled by an overlay for a camera module. Ideally we w=
ant
> > > > to be able to enable both the ISI and ISP at runtime, but that's not
> > > > possible yet and will require a very large amount of work.
> > >=20
> > > Again IMHO this is part of sensor setup, in a very specific overlay. =
To
> > > put it into different words: I barely see the gain of this small
> > > overlay.
> > >=20
> > > Runtime switching would require a combined media controller including
> > > both ISI and ISP, no?
> > >=20
> > > Best regards,
> > > Alexander
> > >=20
> > > > > > +
> > > > > > + ports {
> > > > > > +         port@0 {
> > > > > > +                 /delete-node/ endpoint;
> > > > >=20
> > > > > This doesn't work in overlays. See [1]. Otherwise the OF graph
> > > > > connections
> > > > > look fine to me. I'm using the same in my local overlay.
> > > >=20
> > > > Interesting, I wasn't aware of that. Maybe we should fix it :-)
> >=20
> > When I did my camera implementation, I thought it was simpler to:
> >=20
> > /delete-node/ &isi_in_0;
> >=20
> > it's a one-line change.
> >=20
> > I would suggest we just drop the overlay and make users who have the
> > cameras integrate the cameras and the isp routing into their
> > respective overlays.
>=20
> I use these to factor out common parts between multiple cameras that can
> be connected to multiple ports.
>=20
> I can connect any of (Physically available to me right now)
>  IMX219, IMX477, IMX708, GC2145, OV5640(7?) IMX335, IMX283, IMX519,
> Arducam64MP
>=20
> to either of:
>=20
> Debix-SOM-A Port CSI-1
> Debix-SOM-A Port CSI-2
>=20
> And I can connect those same cameras to two ports of a Pi5. So now
> that's 27 overlays to manage the 9 cameras I have /on my desk/ to
> connect to this board.
>=20
> Uh Oh - sorry I can also connect them to a Debix Model A ... oh no ... I
> need to stop thinking about what I can connect them to. I have rockchip
> boards they'll work on too!
>=20
> This explosion of overlays could be ... hard to manage. With /a lot/ of
> repetition of the same data.

Maybe I am missing something, but how can the intermediate overlay reduce t=
his=20
amount of overlays? At least the remote-endpoint of the sensor needs the CS=
I=20
endpoint, which is different for CSI1/CSI2, and vice versa.
I do not have rockchip hardware, but I would not assume the CSI endpoint to=
=20
not have the same label, so the phandle reference is different there as wel=
l.

>=20
> I'm not opposed to dropping these intermediate helper overlays, but I'd
> be interested to know if anyone has ideas on how we could define
> 'connectors' and then abstract the cameras / overlays that can be moved
> between different compatible ports.

You still would have the naming problem. How do you identify a connector? I=
t's=20
similar to label naming on device tree nodes.

Best regards,
Alexander

> The [RFC 0/3] Portable Device Tree Connector [0] might be interesting to
> resurrect. Did that go anywhere?
>=20
> [0]
> https://lore.kernel.org/all/1464986273-12039-1-git-send-email-pantelis.an=
to
> niou@konsulko.com/
>=20
> --
> Kieran
>=20
> > adam
> >=20
> > > > > [1]
> > > > > https://lore.kernel.org/all/CAMuHMdWu4KZbBkvEofUV2wuA1g2S=3DXHHM3=
RUN1c
> > > > > NrcZB
> > > > > khsPZA@mail.gmail.com/>
> > > > >=20
> > > > > > +         };
> > > > > > + };
> > > > > > +};
> > > > > > +
> > > > > > +&isp_0 {
> > > > > > + status =3D "okay";
> > > > > > +
> > > > > > + ports {
> > > > > > +         port@1 {
> > > > > > +                 isp0_in: endpoint {
> > > > > > +                         bus-type =3D <MEDIA_BUS_TYPE_PARALLEL=
>;
> > > > > > +                         remote-endpoint =3D <&mipi_csi_0_out>;
> > > > > > +                 };
> > > > > > +         };
> > > > > > + };
> > > > > > +};
> > > > > > +
> > > > > > +&mipi_csi_0_out {
> > > > > > + remote-endpoint =3D <&isp0_in>;
> > > > > > +};
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso
> > > > > > b/arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso new file mode
> > > > > > 100644
> > > > > > index 000000000000..14e2e7b2617f
> > > > > > --- /dev/null
> > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso
> > > > > > @@ -0,0 +1,36 @@
> > > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > > > +/*
> > > > > > + * Copyright 2022 Ideas on Board Oy
> > > > > > + */
> > > > > > +
> > > > > > +/dts-v1/;
> > > > > > +/plugin/;
> > > > > > +
> > > > > > +#include <dt-bindings/media/video-interfaces.h>
> > > > > > +
> > > > > > +&isi_0 {
> > > > > > + status =3D "disabled";
> > > > > > +
> > > > > > + ports {
> > > > > > +         port@1 {
> > > > > > +                 /delete-node/ endpoint;
> > > > > > +         };
> > > > > > + };
> > > > > > +};
> > > > > > +
> > > > > > +&isp_1 {
> > > > > > + status =3D "okay";
> > > > > > +
> > > > > > + ports {
> > > > > > +         port@1 {
> > > > > > +                 isp1_in: endpoint {
> > > > > > +                         bus-type =3D <MEDIA_BUS_TYPE_PARALLEL=
>;
> > > > > > +                         remote-endpoint =3D <&mipi_csi_1_out>;
> > > > > > +                 };
> > > > > > +         };
> > > > > > + };
> > > > > > +};
> > > > > > +
> > > > > > +&mipi_csi_1_out {
> > > > > > + remote-endpoint =3D <&isp1_in>;
> > > > > > +};
> > >=20
> > > --
> > > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld=
, Germany
> > > Amtsgericht M=C3=BCnchen, HRB 105018
> > > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stef=
an Schneider
> > > http://www.tq-group.com/


=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/


