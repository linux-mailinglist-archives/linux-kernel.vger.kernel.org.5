Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B06F7CA6C9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjJPLfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjJPLfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:35:01 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FE5D9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:34:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qsLrv-0006gp-Oq; Mon, 16 Oct 2023 13:34:43 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qsLru-0024VF-Ap; Mon, 16 Oct 2023 13:34:42 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qsLru-00EjWY-7l; Mon, 16 Oct 2023 13:34:42 +0200
Date:   Mon, 16 Oct 2023 13:34:42 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v7 10/26] PM / devfreq: rockchip-dfi: Add RK3568 support
Message-ID: <20231016113442.GZ3359458@pengutronix.de>
References: <20230704093242.583575-1-s.hauer@pengutronix.de>
 <20230704093242.583575-11-s.hauer@pengutronix.de>
 <ac224dfe-ff7d-57c7-89ad-f10939975b4d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac224dfe-ff7d-57c7-89ad-f10939975b4d@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 03:17:14AM +0900, Chanwoo Choi wrote:
> On 23. 7. 4. 18:32, Sascha Hauer wrote:
> > This adds RK3568 support to the DFI driver.  Only iniitialization
> > differs from the currently supported RK3399.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/devfreq/event/rockchip-dfi.c | 21 +++++++++++++++++++++
> >  include/soc/rockchip/rk3568_grf.h    | 12 ++++++++++++
> >  2 files changed, 33 insertions(+)
> >  create mode 100644 include/soc/rockchip/rk3568_grf.h
> > 
> > diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> > index 6b3ef97b3be09..261d112580c9e 100644
> > --- a/drivers/devfreq/event/rockchip-dfi.c
> > +++ b/drivers/devfreq/event/rockchip-dfi.c
> > @@ -23,6 +23,7 @@
> >  
> >  #include <soc/rockchip/rockchip_grf.h>
> >  #include <soc/rockchip/rk3399_grf.h>
> > +#include <soc/rockchip/rk3568_grf.h>
> >  
> >  #define DMC_MAX_CHANNELS	2
> >  
> > @@ -209,10 +210,30 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
> >  	return 0;
> >  };
> >  
> > +static int rk3568_dfi_init(struct rockchip_dfi *dfi)
> > +{
> > +	struct regmap *regmap_pmu = dfi->regmap_pmu;
> > +	u32 reg2, reg3;
> > +
> > +	regmap_read(regmap_pmu, RK3568_PMUGRF_OS_REG2, &reg2);
> > +	regmap_read(regmap_pmu, RK3568_PMUGRF_OS_REG3, &reg3);
> > +
> > +	dfi->ddr_type = FIELD_GET(RK3568_PMUGRF_OS_REG2_DRAMTYPE_INFO, reg2);

The ddr_type is 5 bits wide. The lower three bits are here.

> > +
> > +	if (FIELD_GET(RK3568_PMUGRF_OS_REG3_SYSREG_VERSION, reg3) >= 0x3)
> > +		dfi->ddr_type |= FIELD_GET(RK3568_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3, reg3) << 3;

The upper two bits are here, hence we need to shift the value above the
lower three bits.

> 
> There are no reason of why shifting the '3'.
> Could you add the comment about '3' or add the constant definition '3'?

I don't think adding a constant makes sense. I'll add a comment making
it more clear what happens.

> 
> > +
> > +	dfi->channel_mask = 1;
> 
> nitpick.
> On other rkXXXX_dfi_init, use GENMASK() to initialize 'dfi->channel_mask'.
> In order to keep the consistency, it is better to use BIT() macro as following:
> 	dfi->channel_mask = BIT(0);

Ok, will do.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
