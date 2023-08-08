Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECD37741CB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjHHR2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjHHR1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:27:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F3720D0D;
        Tue,  8 Aug 2023 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691511121; x=1723047121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TmMkE7Bdm1p7y8PQ8vVWi+yJ7XU2Aeo3z96hw1Uc64E=;
  b=VYrbRoa+pynZy+ELmtqTmhHbuUXtm0jbNMhK940ZLsjVZ5mFAW7oMNk9
   bAb6AZpmbEdJPC9b6TDibHJLiMCtWIgP2JFl9WhShv6ryk/ZAnt5oJ+dA
   5silk5P+uI2BmAzqpq1ylQ4Kb+S3UbY4Qa+GLHBTp+pz2RKt13Ctlmeao
   ypc4JvRPJqt7JDtkVRgX61Vu3AZlr6B1p4ghgYe0MbSn0BZSfmtk11VYq
   JUXoTdS7ffUw2e22SkPAOe5LGt1GOfnp3ubbJf6ZhheDBT3KUoy7iShc/
   l3WSpevmIU2cM/rqCJHq+rT2vSuUnpgLYsT2aVWuNnWAqwznU/9GZ/rD7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="355756657"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="355756657"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="760884448"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="760884448"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2023 06:26:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTMja-009iE8-1g;
        Tue, 08 Aug 2023 16:26:50 +0300
Date:   Tue, 8 Aug 2023 16:26:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
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
Subject: Re: [PATCH v3 2/2] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Message-ID: <ZNJCms2os3mKV7Uh@smile.fi.intel.com>
References: <20230807071831.4152183-1-marcus.folkesson@gmail.com>
 <20230807071831.4152183-2-marcus.folkesson@gmail.com>
 <ZNETcVNsEmvK0KKH@smile.fi.intel.com>
 <ZNHtMBG4yHpgL1kj@gmail.com>
 <74abc9e0-ba9a-d7ec-4f1c-815f8e351701@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74abc9e0-ba9a-d7ec-4f1c-815f8e351701@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:49:43AM +0200, Krzysztof Kozlowski wrote:
> On 08/08/2023 09:22, Marcus Folkesson wrote:

...

> >>> +	ret = device_property_read_u32(&adc->spi->dev, "microchip,device-addr", &adc->dev_addr);
> >>
> >> Why not spi->dev? Ditto for other uses like this.
> > 
> > After all, I think it is better to stick sith adc->spi-dev to be
> > consistent with the rest of the probe function. Change to spi->dev
> > should probably be a seperate patch.
> > Do you agree?
> > 
> 
> You can first simplify the usages and then add new family support
> already using spi->dev.

He-he, answered the same :-)

-- 
With Best Regards,
Andy Shevchenko


