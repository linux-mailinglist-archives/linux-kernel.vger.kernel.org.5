Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83802777A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjHJOLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjHJOLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:11:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C991B4;
        Thu, 10 Aug 2023 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691676676; x=1723212676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3GgyKrWKjhnKbshDx9sC3BsFjjr/Saitu+okW3mdClQ=;
  b=mexpO0E3rOlgUsMbVT9pi22SdcEOKZVEbJTx2shANTJhsLUWnVUdZLRS
   PCLnoNEvwYIDsQn/vmBNjpXSapozFTLPP9SrXNEosTWUYJxVGbli47FCK
   VDiVBNZdnQ8sjBE8wj95OziHMpjudSx70YeQs6MjloLWtfhew1UzzzOYz
   +FcumtcVil3rYj6nY2KtE/bqSFziRepWJJnIQICURBXWeBPaqc6J5AJWX
   oMq56d2UnCAiAaRc0y+qODWX+1Bd0G6/xMxANu5ZX7Ia6To/7JC4oB++q
   jE0yRmKZFHvi23Y20GoFeZ75QIJsfPAnwFZZrhm4gjcINhwGIdnp175b7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="368880741"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="368880741"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 06:44:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="802214505"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="802214505"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 10 Aug 2023 06:44:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU5xd-003Juj-11;
        Thu, 10 Aug 2023 16:44:21 +0300
Date:   Thu, 10 Aug 2023 16:44:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Message-ID: <ZNTptMeRFAga34wd@smile.fi.intel.com>
References: <20230808110432.240773-1-marcus.folkesson@gmail.com>
 <20230808110432.240773-4-marcus.folkesson@gmail.com>
 <ZNJP6xpOvRJigtMx@smile.fi.intel.com>
 <ZNM1AYMB3RGRWp7C@gmail.com>
 <20230809190257.67602e55@jic23-huawei>
 <3939bd56-d57d-173e-da78-297ce607f9bc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3939bd56-d57d-173e-da78-297ce607f9bc@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 08:14:54PM +0200, Krzysztof Kozlowski wrote:
> On 09/08/2023 20:02, Jonathan Cameron wrote:
> > On Wed, 9 Aug 2023 08:41:05 +0200
> > Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

...

> >>> Inconsistent macro implementation, i.e. you need to use (x).
> >>
> >> Sorry, I do not get you

In other macros you avoid ambiguity of the parameter, so they can be evaluated
properly, and not here.


...

> >>>> +	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))

(1)

> >>> This also becomes shorter.
> >>>
> >>> One trick to make it even shorter:
> >>>
> >>> 	if (device_property_present(dev, "microchip,data-ready-hiz"))
> >>
> >> Thank you, I wasn't aware of device_property_present().
> > 
> > I know the read_bool function is direct equivalent of this but where a property
> > is a flag, it feels more natural to me to check it with that one.
> > read_present() feels more appropriate for where you want to know a more
> > complex property is present.
> > 
> > Doesn't matter that much either way however so up to you.
> 
> For the OF, of_property_read_bool() is indeed preferred. Is there
> device-xxx() equivalent?

See (1) above ?

-- 
With Best Regards,
Andy Shevchenko


