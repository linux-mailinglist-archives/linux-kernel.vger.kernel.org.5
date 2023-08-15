Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDE277D06E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbjHOQyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238627AbjHOQyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:54:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC031737;
        Tue, 15 Aug 2023 09:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692118470; x=1723654470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iwcQcD5rTJK8Op4W6tdanSOrb4DkU58vzN5cdx/6XHE=;
  b=SRezZ80F4BGhTNC9s80AnoboPdX4iutz6o42lRWIwX0Mq+Hd+2sPFwzg
   EJmjFzSReyzimFuwMwixIQlzyII3RAtR/yKa6acWh923Y9wLUxGgUnUuU
   NtWRxaSpsUZ3J8pumGrMLzCBlR3lfSwrHFlNtOYxy8xU1L5ZnLxLkszVQ
   0PZ1ZiClaWCiOIFbMWBRFP7YF0NK+XTgSVMOhUL3JPGAVl7PPs2tRWg14
   88PaM5bcgTzolxdRGjezKhU4SinWO9705qBQrlAEOCBcEkiFDrmxRybUb
   HcYj5g+Rv6ITOpRLUGuhDP+j5D86eWGmm/DT+DeORcBCNpH9WM4ElLOfQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="369805208"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="369805208"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 09:54:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848144826"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="848144826"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 15 Aug 2023 09:54:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVxJH-00AFxd-0S;
        Tue, 15 Aug 2023 19:54:23 +0300
Date:   Tue, 15 Aug 2023 19:54:22 +0300
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
Subject: Re: [PATCH v5 5/6] iio: adc: mcp3911: avoid ambiguity parameters in
 macros
Message-ID: <ZNutvoSfe/yNv7fi@smile.fi.intel.com>
References: <20230814121010.184842-1-marcus.folkesson@gmail.com>
 <20230814121010.184842-5-marcus.folkesson@gmail.com>
 <ZNuSJTjOL1sEnVUd@smile.fi.intel.com>
 <ZNush-mJqb8W6fjJ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNush-mJqb8W6fjJ@gmail.com>
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

On Tue, Aug 15, 2023 at 06:49:11PM +0200, Marcus Folkesson wrote:
> On Tue, Aug 15, 2023 at 05:56:37PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 14, 2023 at 02:10:09PM +0200, Marcus Folkesson wrote:
> > > Name macro parameters after what they represent instead of 'x'.
> > 
> > Yes, but it's not my suggestion, what I was talking about is how macro
> > parameters being treated.
> 
> Sorry, I clearly missunderstood what you was aiming for.
> I will change to (ch) in this patch and keep it consistent in the
> following.

Yep. and drop tag with my name in it.
Thank you!

-- 
With Best Regards,
Andy Shevchenko


