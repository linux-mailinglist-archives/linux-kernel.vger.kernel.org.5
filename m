Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6017377F6BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350970AbjHQMtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350965AbjHQMsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:48:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7002D7B;
        Thu, 17 Aug 2023 05:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692276533; x=1723812533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G8cMKxXUowjsJCMHQzyH3gavNrmvY+GR+fdexo0zSBo=;
  b=Iv4Byxod2ceLPxvDTIc5zSmEuIErHthcmbtq/hNp5I9klAOqJp9akAGA
   PVjEN7aiiSQKo0nAZ7OQ2lUmDKt/DkriWn1uU7ny/fCbfWGfwpi69ln9m
   YHVh5Hjn28haxGyGH1ypUnYI/YSvW8mWqButi984D30wgJMDy5qjMMxaj
   QzOn7eEJeHzSxtLmkDJiDrcHW5anrw2eJRSFBXAKHZmURuQgtDiVR7n4H
   X2qWUM8slQzzk0zZSM22Vxi9kBc+AcmWr96yW/C7/eypgBHXnyjvO5qpW
   26Bz+pnVKxlqqCjtA19ZmzlC3VuY9CcXu5WLbOcHiiXZD6arm0MC07g+4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357761175"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="357761175"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:48:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769631160"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="769631160"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 17 Aug 2023 05:48:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWcQf-00C3fJ-1s;
        Thu, 17 Aug 2023 15:48:45 +0300
Date:   Thu, 17 Aug 2023 15:48:45 +0300
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/6] iio: adc: mcp3911: fix indentation
Message-ID: <ZN4XLcwvhyjxS7p8@smile.fi.intel.com>
References: <20230817120518.153728-1-marcus.folkesson@gmail.com>
 <20230817120518.153728-4-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817120518.153728-4-marcus.folkesson@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 02:05:16PM +0200, Marcus Folkesson wrote:
> The whole file does not make use of indentation properly.
> Do something about it.

Okay,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


