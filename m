Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1B57F7675
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjKXOiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXOio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:38:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875DE19A3;
        Fri, 24 Nov 2023 06:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700836731; x=1732372731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QKgJEGRCbdv2EWGbewfRTODn2GZOxw9ytLOYIn7uuOQ=;
  b=L1/kyVmIVn1Dddb4n3hQEVXNkMjvRp0P2uctbs5mnDfvYCF85KU+wWWH
   X9T+2UrK5KleGAtP+JeWAASN7z4AvjkyXun7uX6Ry12ktp2WFjU1JN3wO
   SPP8LKF340YlD74jZv6un3ZcdaevZBVgkFlaI37+TiASAHyegMwQ3gpVT
   wvZ4XXGBZrblSZymOccm7KETGJV0p58RpqcmS7a4Lb8SkG3sSJMh07ZF4
   di0kBDViFNRNdhDKU4J5A69UltanAMcxXnRkb11d3byVhN329eOsP0lfI
   QdpVpyeZtzQMsSnFa8OptGY58PPIu/V/SJScVdPNMvC2ecToQqdfIRPx8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="392198719"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="392198719"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 06:38:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="743906526"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="743906526"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 06:38:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r6XCh-0000000GjtS-2kli;
        Fri, 24 Nov 2023 16:30:47 +0200
Date:   Fri, 24 Nov 2023 16:30:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>
Subject: Re: [PATCH v2 06/21] pinctrl: equilibrium: Convert to use struct
 pingroup
Message-ID: <ZWCzl-EYXdymay4p@smile.fi.intel.com>
References: <20231123193355.3400852-7-andriy.shevchenko@linux.intel.com>
 <202311241401.ZPILPdov-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311241401.ZPILPdov-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 09:19:45PM +0800, kernel test robot wrote:

...

> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311241401.ZPILPdov-lkp@intel.com/
> 
> smatch warnings:
> drivers/pinctrl/pinctrl-equilibrium.c:719 eqbr_build_groups() warn: unsigned 'grp->npins' is never less than zero.

Thank you for the report!

...

>    718			grp->npins = of_property_count_u32_elems(np, "pins");
>  > 719			if (grp->npins < 0) {
>    720				dev_err(dev, "No pins in the group: %s\n", prop->name);
>    721				of_node_put(np);
>    722				return -EINVAL;
>    723			}

Surprisingly (to me) the _count_u32_elems() can return a negative error code...
Fine, I redo a bit the code by introducing a new patch that will use err instead
of ->npins (which sounds better approach anyway).

-- 
With Best Regards,
Andy Shevchenko


