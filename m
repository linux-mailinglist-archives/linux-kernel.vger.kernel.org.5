Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F4778C56E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbjH2NcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbjH2Nbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:31:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF40F7;
        Tue, 29 Aug 2023 06:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693315894; x=1724851894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j8TotLg+WCeiZgYEEdgpTqcpkTRhh9Ch/8LAKiO0za0=;
  b=Etwj2K2w0Zs7G4GNMpKCbahxyF16SIF64DmFpeZjkahRt31WS/jRGZxs
   m9XISwAP/IARCnUUWGNnw0y5oK8sg5ZZ0jh5dkmjQA7geSVD1Ye77HAAX
   3mk5Vq66ou3oDWd0Ziy5DlVKjruvFg3HDQNBEFuWEtBZw6ZoiBHIsZWP5
   WZVXLq4BB5t92n3mlRYp1JRVsVtLvgFGm/JhR3o7DXu1zmJZz7dQRN1jq
   +fP3E0ftQ/wsw2vjVYcEo4c9/f2ncjoLRmOw7Sqnx+TdxaLtygWk6EQuE
   9yymNI0K6JBy3QafZMqfS35HBbSMN6fxoWmghYRX9uZEeXxY943skyyqm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="354880211"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="354880211"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 06:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="985354090"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="985354090"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 29 Aug 2023 06:31:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qayoW-004tGp-29;
        Tue, 29 Aug 2023 16:31:24 +0300
Date:   Tue, 29 Aug 2023 16:31:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Dumitru Ceclan <mitrutzceclan@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Okan Sahin <okan.sahin@analog.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Lee Jones <lee@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad717x: add AD717X driver
Message-ID: <ZO3zLKrZNGekV7Co@smile.fi.intel.com>
References: <20230810093322.593259-1-mitrutzceclan@gmail.com>
 <20230810093322.593259-2-mitrutzceclan@gmail.com>
 <34f5e2118a4714048231e6ee9a8f244248616bd0.camel@gmail.com>
 <ZNUEBDsMg6UfeOtl@smile.fi.intel.com>
 <5a31871d0e0322b9704633bd2dca2503c554c358.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a31871d0e0322b9704633bd2dca2503c554c358.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 11:14:31AM +0200, Nuno Sá wrote:
> On Thu, 2023-08-10 at 18:36 +0300, Andy Shevchenko wrote:
> > On Thu, Aug 10, 2023 at 01:57:02PM +0200, Nuno Sá wrote:
> > > On Thu, 2023-08-10 at 12:33 +0300, Dumitru Ceclan wrote:

...

> > > Is ad717x_gpio_cleanup() being used anywhere? Moreover I would maybe just
> > > get rid of
> > > the #ifdef wrapper and just select GPIOLIB. How often will it be disabled
> > > anyways?
> > 
> > The agreement is that users are depend on and not selecting GPIOLIB.
> > Any news in these agreement terms?
> 
> Hmm no idea about that. If you say so, it's just one new thing I'm learning :)

That's the last I know.
Cc'ing to GPIOLIB maintainers...

-- 
With Best Regards,
Andy Shevchenko


