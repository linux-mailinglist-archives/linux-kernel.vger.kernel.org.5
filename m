Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CA677F695
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350904AbjHQMm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350841AbjHQMm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:42:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3562D57;
        Thu, 17 Aug 2023 05:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692276149; x=1723812149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rnvQB8vVYEWmrqyik5H2iI+pxyd4YqSM4HtPDho3t3M=;
  b=HBBJSyVZ2C8OmKI16GxEoneJRJiLVxLDrBe7cBPIIkd4DZlRSA16a3By
   3C3TqabwtZOgBNBWhR5wjZB2CWHZnDDvrIBLEUiP+FbT/fHYwbCIaW8mm
   GTXCMxWF5rknIZ3zKndI8Qrzok9540eGvws6V541ogLGUfZC77fPXDlOH
   XCI+3y+7ohqZR6f/WJCrYzqqQp2kyNuq9JZ7MLP3dwJJbShxcubrdthZh
   ZlmdXIc9fNADwcHw/ADXorKf7GEjwNWAAgwaDp8IoluZTsOfto3pf1Vmz
   CTqnhbGXIZFESktPVQpf0dMYqGgB7/aFeYtwmFiJOFxQr73M5FdoeOVU2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436702380"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="436702380"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:42:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="764063865"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="764063865"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2023 05:42:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWcKS-00Bpg4-3D;
        Thu, 17 Aug 2023 15:42:21 +0300
Date:   Thu, 17 Aug 2023 15:42:20 +0300
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
Message-ID: <ZN4VrLPKhQIVLxfP@smile.fi.intel.com>
References: <20230817120518.153728-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817120518.153728-1-marcus.folkesson@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 02:05:13PM +0200, Marcus Folkesson wrote:
> Microchip does have many similar chips, add those to the compatible
> string as the driver support is extended.

With properly formed cover letter (and using --base) a maintainer may safe
their time by utilizing some features of `b4`. I.e. the

	b4 -slt -M ...

will treat the series as a PR with summary in cover letter taking into merge
commit. This is really cool feature and from now on I will require people to
submit the series with mandatory cover-letter and --base in use.

BUT. I'm not the maintainer here, so up to Jonathan to decide.

-- 
With Best Regards,
Andy Shevchenko


