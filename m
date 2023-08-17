Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCF977F69A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350918AbjHQMn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350900AbjHQMnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:43:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6A72D61;
        Thu, 17 Aug 2023 05:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692276178; x=1723812178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qt428taott+JShp1rj09H5WbPuI4VdtsGaMucNnQ05Q=;
  b=oDpu11h4L6XhCztYdPrU7CLibTPcIbgF5qmwrt20fppgWdkuO3tCx7fE
   u4H1a6CBNGaFfe+iWzTmkjTHoLOxbt7oJkYyU8ScB30xhIwjw72FSf9mn
   LNw+fnW7JYgvXONRdPYli01mQLuud2piojsA6TbNm7mvv3nYDP1HRXqh6
   v7PyOd2VHg8UXvmEAkn6jyRRefAi8XVXTf6dzgiXxsstcmZvP2pLXdNbk
   CdaZb/3QlCYqZ73eeXIKF6LPG3uWKTcD1DT3pd4mCJsEhWHGuwemk/U0K
   7FOWXsxgDoNV94dEVA67c4cVBpSjNR8l6wVU+/Ab6StH3GO+YJqBOb4me
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403780049"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="403780049"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:42:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="981143566"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="981143566"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2023 05:42:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWcKx-00Bqlq-0I;
        Thu, 17 Aug 2023 15:42:51 +0300
Date:   Thu, 17 Aug 2023 15:42:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: iio: adc: mcp3911: add support for
 the whole MCP39xx family
Message-ID: <ZN4Vynahb4rYE9nU@smile.fi.intel.com>
References: <20230817120518.153728-1-marcus.folkesson@gmail.com>
 <ZN4VrLPKhQIVLxfP@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN4VrLPKhQIVLxfP@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 03:42:21PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 17, 2023 at 02:05:13PM +0200, Marcus Folkesson wrote:
> > Microchip does have many similar chips, add those to the compatible
> > string as the driver support is extended.
> 
> With properly formed cover letter (and using --base) a maintainer may safe
> their time by utilizing some features of `b4`. I.e. the
> 
> 	b4 -slt -M ...

	b4 shazam -slt -M ...

> will treat the series as a PR with summary in cover letter taking into merge
> commit. This is really cool feature and from now on I will require people to
> submit the series with mandatory cover-letter and --base in use.
> 
> BUT. I'm not the maintainer here, so up to Jonathan to decide.

-- 
With Best Regards,
Andy Shevchenko


