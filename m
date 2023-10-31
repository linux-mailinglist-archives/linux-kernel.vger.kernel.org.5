Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619F27DCE8E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344726AbjJaN7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344693AbjJaN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:59:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8591E6;
        Tue, 31 Oct 2023 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698760770; x=1730296770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GHC9JJLjxYAwUCBjiPkG7gQfKyEtrkzL46wpQ3Px//4=;
  b=m8g7Hb7moAa0j2nmVVbfTAk+TCE1g8lmaJInSUC+7iQLijnF1uyds+wE
   46i+QyxQBHa65GLbJsW66PeuI70S+QKs1kQdsf/YDsYerIQ8BF6r4GBPv
   SQYjrc3EYYsQZZJ7AmOZMKO3shWp87iXBjQaJTiMNQnIPRCMbqvw/NRsv
   SUgpOU2pxq34uJeKIUQWF7mJGuk+08NJd4Fmkr5G2T5w6YaklRuvQFSZ1
   X3J1KRI2KsxoHhzOBZ59ljLdIE7EAyXI0YVxF+/I/md1dZJnzSQjYh+eo
   buSg3kysdaiDZ1WY0B+QROIsTINK3EkL/RiF+xr1tVE6Y8rNpb1pD6Nq/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="378680000"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="378680000"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 06:59:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="795586029"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="795586029"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 06:59:28 -0700
Date:   Tue, 31 Oct 2023 15:59:25 +0200
From:   Raag Jadav <raag.jadav@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: tangier: Enable 910 Ohm bias
Message-ID: <ZUEIGOTWADFdebM7@black.fi.intel.com>
References: <20231030141404.3242102-1-andriy.shevchenko@linux.intel.com>
 <ZUAhqX-3O6QcoWMZ@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUAhqX-3O6QcoWMZ@black.fi.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 11:35:42PM +0200, Raag Jadav wrote:
> On Mon, Oct 30, 2023 at 04:14:04PM +0200, Andy Shevchenko wrote:
> > Family 7 (I2C) supports special bias value, i.e. 910 Ohm.
> > 
> > Enable it for configuring pin.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/pinctrl/intel/pinctrl-tangier.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/pinctrl/intel/pinctrl-tangier.c b/drivers/pinctrl/intel/pinctrl-tangier.c
> > index 40dd60c9e526..007bca1cf224 100644
> > --- a/drivers/pinctrl/intel/pinctrl-tangier.c
> > +++ b/drivers/pinctrl/intel/pinctrl-tangier.c
> > @@ -382,6 +382,9 @@ static int tng_config_set_pin(struct tng_pinctrl *tp, unsigned int pin,
> >  		case 2000:
> >  			term = BUFCFG_PUPD_VAL_2K;
> >  			break;
> > +		case 910:
> > +			term = BUFCFG_PUPD_VAL_910;
> > +			break;
> >  		default:
> >  			return -EINVAL;
> >  		}
> > @@ -405,6 +408,9 @@ static int tng_config_set_pin(struct tng_pinctrl *tp, unsigned int pin,
> >  		case 2000:
> >  			term = BUFCFG_PUPD_VAL_2K;
> >  			break;
> > +		case 910:
> > +			term = BUFCFG_PUPD_VAL_910;
> > +			break;
> >  		default:
> >  			return -EINVAL;
> >  		}
> 
> Ah, I failed to notice this was already present in the getter.
> 
> Looks good,

Reviewed-by: Raag Jadav <raag.jadav@intel.com>

