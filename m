Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF4676DA0A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjHBV57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjHBV5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:57:51 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A832E173A;
        Wed,  2 Aug 2023 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691013470; x=1722549470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qXkV3RSJ67wGN/RTTtLjS+7GJSXx5qeFXBCzPChuO04=;
  b=OcsPkVyRGYaIB8Z+YKr4M0zLwcdfPlDlKyQ1hg9gLRSglCvGBR+V719j
   SV8+yuirBCzHOYGTsnRIfOzkwcE2ylEbpW5F6rxE8K1iFFjUO9oPO+rr+
   CXz2e+a7b9z1YT/y1d8OpdFhvgFjtGQUvk8b2Yjl+9flWtb0yomAFwdo5
   harcdTy5CbM7zfv8zKm0xy4aHr1fByXYrYn/IDcy0uJ+EBwSY4RzMvQeD
   IK6aRV+tORRWhQ5BLvcxzfMuOgLgtRR0DsNQVAUAfkexF3Vz41lM20E8D
   dSjRFa3/ZSm8rvoDgV+gTSnWS4ZRh27kncRGnZjbDqUBgzUNqXM/8cI6T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="400647660"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="400647660"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 14:57:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="706320847"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="706320847"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2023 14:57:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRJqj-000CNh-08;
        Thu, 03 Aug 2023 00:57:45 +0300
Date:   Thu, 3 Aug 2023 00:57:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: snps-dw-apb-uart: make
 interrupt optional
Message-ID: <ZMrRWP5mK+nksn4M@smile.fi.intel.com>
References: <20230802150545.3742-1-jszhang@kernel.org>
 <20230802150545.3742-2-jszhang@kernel.org>
 <20230802-halogen-bungee-63273b2c456c@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802-halogen-bungee-63273b2c456c@spud>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 04:43:48PM +0100, Conor Dooley wrote:
> On Wed, Aug 02, 2023 at 11:05:44PM +0800, Jisheng Zhang wrote:
> > The driver fall back to poll style when there's no irq. "poll" still
> > looks better than no support.
> 
> What is the user for this where the interrupt is not actually wired up
> in the hardware?

FYI: kernel console doesn't use interrupts, so for example it might be
the debug port. Note, I have no idea of the Zhang's case, just my assumption.

-- 
With Best Regards,
Andy Shevchenko


