Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A73B7B8376
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243231AbjJDPXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243221AbjJDPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:23:02 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB302D7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:22:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1qo3i3-0002p0-Lg; Wed, 04 Oct 2023 17:22:47 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mtr@pengutronix.de>)
        id 1qo3i1-00B3vw-5O; Wed, 04 Oct 2023 17:22:45 +0200
Received: from mtr by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1qo3i1-00Cmdh-0E; Wed, 04 Oct 2023 17:22:45 +0200
Date:   Wed, 4 Oct 2023 17:22:44 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     Inki Dae <daeinki@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>, kernel@pengutronix.de,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/5] drm/bridge: samsung-dsim: add more mipi-dsi device
 debug information
Message-ID: <20231004152244.GD3042281@pengutronix.de>
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de>
 <20230818-samsung-dsim-v1-1-b39716db6b7a@pengutronix.de>
 <CAHCN7x+J_umWCBvivuZsrHTvjw=4CvBqOSeO-j_+fTMm=DdAOg@mail.gmail.com>
 <CAAQKjZM9UGgzAgfg-Rt92BNdvLuUJ90=QRUrd=FnDFwGvoC-zA@mail.gmail.com>
 <CAHCN7xJLH2oBzvn6V0VRpisr1Pmh3knx0t0Vesck5q_-RGnN6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xJLH2oBzvn6V0VRpisr1Pmh3knx0t0Vesck5q_-RGnN6A@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023 07:47:53 -0500, Adam Ford wrote:
> On Sun, Sep 3, 2023 at 8:05 PM Inki Dae <daeinki@gmail.com> wrote:
> >
> > 2023년 8월 29일 (화) 오전 7:38, Adam Ford <aford173@gmail.com>님이 작성:
> > >
> > > On Mon, Aug 28, 2023 at 10:59 AM Michael Tretter
> > > <m.tretter@pengutronix.de> wrote:
> > > >
> > > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > >
> > > > Since the MIPI configuration can be changed on demand it is very useful
> > > > to print more MIPI settings during the MIPI device attach step.
> > > >
> > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> > >
> > > Reviewed-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon
> > > Tested-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon
> >
> > Reviewed-by: Inki Dae <inki.dae@samsung.com>
> > Acked-by: Inki Dae <inki.dae@samsung.com>
> 
> What needs to be done in order to get this accepted?  This series is a
> very nice improvement in i.MX8M Mini / Nano.

I think it is my turn to send a v2 that addresses the review comments. I'll
try to find time this week.

Michael

> 
> adam
> >
> > >
> > > > ---
> > > >  drivers/gpu/drm/bridge/samsung-dsim.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > index 73ec60757dbc..6778f1751faa 100644
> > > > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > @@ -1711,7 +1711,10 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
> > > >                 return ret;
> > > >         }
> > > >
> > > > -       DRM_DEV_INFO(dev, "Attached %s device\n", device->name);
> > > > +       DRM_DEV_INFO(dev, "Attached %s device (lanes:%d bpp:%d mode-flags:0x%lx)\n",
> > > > +                    device->name, device->lanes,
> > > > +                    mipi_dsi_pixel_format_to_bpp(device->format),
> > > > +                    device->mode_flags);
> > > >
> > > >         drm_bridge_add(&dsi->bridge);
> > > >
> > > >
> > > > --
> > > > 2.39.2
> > > >
> 
