Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2E478BFB2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjH2HwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbjH2Hvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:51:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AD119F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:51:40 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1qatVf-0000oC-HJ; Tue, 29 Aug 2023 09:51:35 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1qatVe-0003qb-Ea; Tue, 29 Aug 2023 09:51:34 +0200
Date:   Tue, 29 Aug 2023 09:51:34 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>, kernel@pengutronix.de,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 4/5] drm/bridge: samsung-dsim: adjust porches by rounding
 up
Message-ID: <20230829075134.GG17387@pengutronix.de>
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de>
 <20230818-samsung-dsim-v1-4-b39716db6b7a@pengutronix.de>
 <CAOMZO5AFEDMT1de2O2sUUuw8E0ZRCyD4QVVCKxAtfRaisU5gVw@mail.gmail.com>
 <CAHCN7xLuzWk53dTOM_ySVTGuqNZwCXDiZ236CXavyjSKZp-sRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xLuzWk53dTOM_ySVTGuqNZwCXDiZ236CXavyjSKZp-sRA@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 17:39:03 -0500, Adam Ford wrote:
> On Mon, Aug 28, 2023 at 1:26 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Michael,
> >
> > On Mon, Aug 28, 2023 at 12:59 PM Michael Tretter
> > <m.tretter@pengutronix.de> wrote:
> > >
> > > The porches must be rounded up to make the samsung-dsim work.
> 
> ...at some resolutions and refresh rates.

I will rephrase the commit message in a v2 and list the resolutions and
refresh rates that were fixed in my test.

Michael

> 
> >
> > The commit log could be improved here.
> >
> > The way it is written gives the impression that samsung-dsim does not
> > work currently.
> 
> This is a big improvement in the number of resolutions and refresh rates.
> 
> Reviewed-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon
> Tested-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon
> 
