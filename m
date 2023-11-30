Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8947FF153
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345859AbjK3OJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345568AbjK3OJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:09:17 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF5AD5C;
        Thu, 30 Nov 2023 06:09:21 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c19a328797so775635a12.3;
        Thu, 30 Nov 2023 06:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701353361; x=1701958161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15OD46o/toT3zkM6qRemt6EuQTh1edNBEQbpx7wiFdE=;
        b=CQ3XwtGfOFWYV1boz8yUfellSZWLC/y8lTjPIqJWyNK2Fsk6TplEQk4a1dCglgiFqL
         Ey7waLuP43PgtIeasG3+15x44AkWFShtQFl61AUO5a0KD0MiDCUBWEt6+Albpucgj+P4
         yQ6IlCcyJvODF6dkNa6hVgawUwuJO/tvV8FWvt0gaecjprEXGN1txDnMpzUkrRqgxG5b
         iSnL3cEOvsTfbVhirH1hJPg/MTftKBHbDJFCjULOtaSZtEHg1biNG1GLLLgN8CM+eubf
         7S/rMehbM/RiMsIuFDINw5ptPTzv/UboY4+JOeAUJnoTrCFOkVm6bBz0ly93kIyxLDq6
         DBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353361; x=1701958161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15OD46o/toT3zkM6qRemt6EuQTh1edNBEQbpx7wiFdE=;
        b=wESCro4jizsQfY5I6y5557qd05gDLnQLfwYzwCrFpcEPFGFfuTooF8QLw0AEoW6U+y
         y0B5Yxu4Lt8Pl4LB7wTaNJAbmrUYPbYVuxsQtjm7lNRKWkSojYwLRXxMGosCPA8Os1L8
         9cgpGMHiJIMLAn4t+xVQHmNCkXDHblLmyUQ8yOhWgvUsF2vvAHXphcN9cpJCa+95UmX9
         Rrbnv1wbYeQAki80Nz1tGfi6Jex1rvVctddjk/4c1o6/eUbT4zIzJObSuVD4MW4jslkJ
         4N6VebqECPApyQaMB/OnKk/le5UwwIc+38pr4ja+BcFLkgtP4vaVxu0aF1rXu3sEelqv
         kBWA==
X-Gm-Message-State: AOJu0YzJBlmzK2SmzdJZCBFNvbmq32uQCZhcLX8e1zZbl6tCluhY4rx8
        ulfxVRKK0n3qtjQHPazV//VvkRBqep0RY4a94g0=
X-Google-Smtp-Source: AGHT+IF00H/DiK3TJhjdvbSR8KRFpkMNgH9iLU86PrDNyjwUDSRbOUDJaKPXeNmAeEJ34gwpTx/hW2Tc05RuHgkzquI=
X-Received: by 2002:a17:90b:314c:b0:285:a18a:4a27 with SMTP id
 ip12-20020a17090b314c00b00285a18a4a27mr16105052pjb.41.1701353360574; Thu, 30
 Nov 2023 06:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20231129093113.255161-1-paul.elder@ideasonboard.com>
 <7122934.GXAFRqVoOG@steina-w> <20231129151637.GG24293@pendragon.ideasonboard.com>
 <5734628.DvuYhMxLoT@steina-w> <CAHCN7x+hBGmnJ2z8B9awpS1KU7rgVjseMw-uTE2Sc7DZ5+oTKA@mail.gmail.com>
 <170135295658.1400840.15195708825865805741@ping.linuxembedded.co.uk>
In-Reply-To: <170135295658.1400840.15195708825865805741@ping.linuxembedded.co.uk>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 30 Nov 2023 08:09:09 -0600
Message-ID: <CAHCN7xL_DfQuvYfWCVrjLSqMcO2Uc2+Xu5iH9QVOW0oWmhJ+MQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp: Add overlays for ISP instances
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
        "ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 8:02=E2=80=AFAM Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> + Pantellis
>
> Quoting Adam Ford (2023-11-30 13:48:58)
> > On Thu, Nov 30, 2023 at 3:51=E2=80=AFAM Alexander Stein
> > <alexander.stein@ew.tq-group.com> wrote:
> > >
> > > Hi Laurent,
> > >
> > > Am Mittwoch, 29. November 2023, 16:16:37 CET schrieb Laurent Pinchart=
:
> > > > Hi Alexander,
> > > >
> > > > On Wed, Nov 29, 2023 at 11:20:07AM +0100, Alexander Stein wrote:
> > > > > Am Mittwoch, 29. November 2023, 10:31:13 CET schrieb Paul Elder:
> > > > > > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > > >
> > > > > > Add two overlay to enable each ISP instance. The ISP is wired d=
irectly
> > > > > > to the CSIS for now, bypassing the ISI completely.
> > > > >
> > > > > I'm not sure if this is worth adding in a separate overlay.
> > > >
> > > > The trouble is that, at this point, selection between the ISP and t=
he
> > > > ISI can only be performed through DT :-S That's why this is impleme=
nted
> > > > as an overlay.
> > >
> > > I feel a better place would be the overlay which actually adds the se=
nsor.
> > > This knows best whether ISI or ISP should be used.
> > >
> > > > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.=
com>
> > > > > > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > > > > > ---
> > > > > >
> > > > > >  arch/arm64/boot/dts/freescale/Makefile        |  2 ++
> > > > > >  .../arm64/boot/dts/freescale/imx8mp-isp1.dtso | 36 +++++++++++=
++++++++
> > > > > >  .../arm64/boot/dts/freescale/imx8mp-isp2.dtso | 36 +++++++++++=
++++++++
> > > > > >  3 files changed, 74 insertions(+)
> > > > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-isp1.d=
tso
> > > > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-isp2.d=
tso
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > > > > > b/arch/arm64/boot/dts/freescale/Makefile index
> > > > > > 300049037eb0..f97dfac11189
> > > > > > 100644
> > > > > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > > > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > > > > @@ -113,6 +113,8 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-dhcom-pd=
k2.dtb
> > > > > >
> > > > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-dhcom-pdk3.dtb
> > > > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-evk.dtb
> > > > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-icore-mx8mp-edimm2.2.dtb
> > > > > >
> > > > > > +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-isp1.dtbo
> > > > > > +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-isp2.dtbo
> > > > > >
> > > > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-msc-sm2s-ep1.dtb
> > > > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-phyboard-pollux-rdk.dtb
> > > > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-tqma8mpql-mba8mpxl.dtb
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso
> > > > > > b/arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso new file mode =
100644
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
> > > > >
> > > > > ISI is disabled by default. What is your intention here?
> > > >
> > > > It could be enabled by an overlay for a camera module. Ideally we w=
ant
> > > > to be able to enable both the ISI and ISP at runtime, but that's no=
t
> > > > possible yet and will require a very large amount of work.
> > >
> > > Again IMHO this is part of sensor setup, in a very specific overlay. =
To put it
> > > into different words: I barely see the gain of this small overlay.
> > >
> > > Runtime switching would require a combined media controller including=
 both ISI
> > > and ISP, no?
> > >
> > > Best regards,
> > > Alexander
> > >
> > > > > > +
> > > > > > + ports {
> > > > > > +         port@0 {
> > > > > > +                 /delete-node/ endpoint;
> > > > >
> > > > > This doesn't work in overlays. See [1]. Otherwise the OF graph co=
nnections
> > > > > look fine to me. I'm using the same in my local overlay.
> > > >
> > > > Interesting, I wasn't aware of that. Maybe we should fix it :-)
> >
> > When I did my camera implementation, I thought it was simpler to:
> >
> > /delete-node/ &isi_in_0;
> >
> > it's a one-line change.
> >
> > I would suggest we just drop the overlay and make users who have the
> > cameras integrate the cameras and the isp routing into their
> > respective overlays.
> >
>
> I use these to factor out common parts between multiple cameras that can
> be connected to multiple ports.
>
> I can connect any of (Physically available to me right now)
>  IMX219, IMX477, IMX708, GC2145, OV5640(7?) IMX335, IMX283, IMX519, Arduc=
am64MP
>
> to either of:
>
> Debix-SOM-A Port CSI-1
> Debix-SOM-A Port CSI-2
>
> And I can connect those same cameras to two ports of a Pi5. So now
> that's 27 overlays to manage the 9 cameras I have /on my desk/ to
> connect to this board.
>
> Uh Oh - sorry I can also connect them to a Debix Model A ... oh no ... I
> need to stop thinking about what I can connect them to. I have rockchip
> boards they'll work on too!
>
> This explosion of overlays could be ... hard to manage. With /a lot/ of
> repetition of the same data.
>

 That makes sense, I didn't think of it that way.

>
> I'm not opposed to dropping these intermediate helper overlays, but I'd
> be interested to know if anyone has ideas on how we could define
> 'connectors' and then abstract the cameras / overlays that can be moved
> between different compatible ports.
>
> The [RFC 0/3] Portable Device Tree Connector [0] might be interesting to
> resurrect. Did that go anywhere?
>
> [0] https://lore.kernel.org/all/1464986273-12039-1-git-send-email-panteli=
s.antoniou@konsulko.com/
>
> --
> Kieran
>
> > adam
> > > >
> > > > > [1]
> > > > > https://lore.kernel.org/all/CAMuHMdWu4KZbBkvEofUV2wuA1g2S=3DXHHM3=
RUN1cNrcZB
> > > > > khsPZA@mail.gmail.com/>
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
> > > > > > +                         remote-endpoint =3D <&mipi_csi_0_out>=
;
> > > > > > +                 };
> > > > > > +         };
> > > > > > + };
> > > > > > +};
> > > > > > +
> > > > > > +&mipi_csi_0_out {
> > > > > > + remote-endpoint =3D <&isp0_in>;
> > > > > > +};
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso
> > > > > > b/arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso new file mode =
100644
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
> > > > > > +                         remote-endpoint =3D <&mipi_csi_1_out>=
;
> > > > > > +                 };
> > > > > > +         };
> > > > > > + };
> > > > > > +};
> > > > > > +
> > > > > > +&mipi_csi_1_out {
> > > > > > + remote-endpoint =3D <&isp1_in>;
> > > > > > +};
> > >
> > >
> > > --
> > > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld=
, Germany
> > > Amtsgericht M=C3=BCnchen, HRB 105018
> > > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stef=
an Schneider
> > > http://www.tq-group.com/
> > >
> > >
> > >
