Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78AC7528F9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbjGMQpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbjGMQpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:45:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05048211F;
        Thu, 13 Jul 2023 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689266702; x=1720802702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=snXTa2azq0xnvrMVVYEmz2Vp8CufjzE+QoK451TgVig=;
  b=bcotvVHAw4LSxtrKGgbin0SUiFMdlKnROqaNJTlrcXj71zp2wD5PFdHU
   2QteACk3OuDcJQZ148fT3qtMnG14aoYB8ROweyEVngid1BkFcrNYHY5XC
   45/zGM3HUYsBcL+sZo0b+O/oHtn5WYTFkMz/oUp8wyB1EFGIu2TvF6M3X
   q7AyACzTacDAjHDup+Q2JAEwaiDMpu7ekEBa70A/oSUZ10Sf+fv2D8A0W
   4P3MOeOiSXRyAfUkkj+I0tLCtg4PuUAaitD59iBRJ49v6bx0dEMqwHEk2
   /bwaRg0WZ8kEVsGRK1urDb3Tx/n4mDczTvI4RaC2KamNeGmh6fc7zfu1O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345566222"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="345566222"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 09:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="716024032"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="716024032"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 13 Jul 2023 09:44:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJzR1-002RMV-1y;
        Thu, 13 Jul 2023 19:44:55 +0300
Date:   Thu, 13 Jul 2023 19:44:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] platform/x86/intel/tpmi: Read feature control
 status
Message-ID: <ZLAqBzZTvylHn2Yp@smile.fi.intel.com>
References: <20230712225950.171326-1-srinivas.pandruvada@linux.intel.com>
 <20230712225950.171326-2-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712225950.171326-2-srinivas.pandruvada@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 03:59:48PM -0700, Srinivas Pandruvada wrote:
> Some of the PM features can be locked or disabled. In that case, write
> interface can be locked.
> 
> This status is read via a mailbox. There is one TPMI ID which provides
> base address for interface and data register for mail box operation.
> The mailbox operations is defined in the TPMI specification. Refer to
> https://github.com/intel/tpmi_power_management/ for TPMI specifications.
> 
> An API is exposed to feature drivers to read feature control status.

...


> +#define TPMI_CONTROL_TIMEOUT_MAX_US	(1 * USEC_PER_SEC)


> +#define TPMI_RB_TIMEOUT_MAX_US		USEC_PER_SEC

In the similar way?

-- 
With Best Regards,
Andy Shevchenko


