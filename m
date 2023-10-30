Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19AA7DB56A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjJ3IsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3IsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:48:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC6D94;
        Mon, 30 Oct 2023 01:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698655696; x=1730191696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LS2pJUDiSTV423qSWLXmXIRDuZGAYUxp6qKMrJfujok=;
  b=TIgKY1buvMEgrpzxDzhdtGcbh5vQLpNEIPwcMUYWDghKiPJ5/on4tepb
   G/lv30pUdYEGSTsCs1hYYSSzbAt8oI4Lsca3WcRIIUCaJMrwY6wSKT+CE
   avGl7BKQNbkavuWtLRmcUxJ6JZe/io2eXsPMQxWtluxhHr/4cx8i+nAa+
   5O0XgePoRoHVcOq6kfoGvjzQwdY806/DulpO+QLGL6l8Z0jQyJI4tVOgF
   LXbDQzak+Hx4rZKxiGPijJKmb5y5uZPqDnhVNy2yG01uqP3OdT92j2e/D
   ZR5qaFFg5MftJ/aqb9x4s2wsk4qsj+1HJYMxQa+C2Qwe/AqkDepZs+ElS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="368251134"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="368251134"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 01:48:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="933719934"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="933719934"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 01:48:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qxNwO-00000009mXD-2f7u;
        Mon, 30 Oct 2023 10:48:08 +0200
Date:   Mon, 30 Oct 2023 10:48:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     "Stoll, Eberhard" <eberhard.stoll@kontron.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Eberhard Stoll <estl@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "Schrempf, Frieder" <frieder.schrempf@kontron.de>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: AW: [PATCH 1/4] spi: Add parameter for clock to rx delay
Message-ID: <ZT9tyDEBqwqv26O8@smile.fi.intel.com>
References: <20231026152316.2729575-1-estl@gmx.net>
 <20231026152316.2729575-2-estl@gmx.net>
 <20231027005643.4b95f17e@xps-13>
 <DB9PR10MB82468A8BD333B12D3FCB3C43F1DCA@DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM>
 <ZTujIs2O+GYKIPlU@smile.fi.intel.com>
 <ZTvbFc+kFMotVUkh@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTvbFc+kFMotVUkh@finisterre.sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 04:45:25PM +0100, Mark Brown wrote:
> On Fri, Oct 27, 2023 at 02:46:42PM +0300, Andy Shevchenko wrote:
> 
> > So, to me sounds like device tree source issue. I.e. you need to provide
> > different DT(b)s depending on the platform (and how it should be).
> > The cleanest solution (as I see not the first time people I trying quirks like
> > this to be part of the subsystems / drivers) is to make DT core (OF) to have
> > conditionals or boot-time modifications allowed.
> 
> > This, what you are doing, does not scale and smells like an ugly hack.
> 
> No, this seems like an entirely reasonable thing to have - it's just a
> property of the device, we don't need to add a DT property for it, and
> the maximum speed that the device can run at is going to vary depending
> on the ability of the controller to control the sampling point.
> 
> As people have been saying there's a particularly clear case for this
> with SPI flash which is probed at runtime and is readily substituted at
> the hardware level.

So, then the question is what does DT _actually_ describes?
If we have an autoprobe of something that doesn't work on platform A and works
on platform B, shouldn't these platforms have to have distinguishable DTs?

-- 
With Best Regards,
Andy Shevchenko


