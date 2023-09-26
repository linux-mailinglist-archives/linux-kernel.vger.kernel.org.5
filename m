Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A3B7AF410
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbjIZTXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjIZTW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:22:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7483E192;
        Tue, 26 Sep 2023 12:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695756173; x=1727292173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tlhQ45iZYHZ8Hm8Kzdj8LITXLLm2eTGdDO0Sb7N4hUw=;
  b=BlXn+iAqYYWDsZtPkMP5MMw5UfGxKmdpxcW+rubqPlRGI1X0xC7zQY+k
   5waZygRa75KHxjK1jN92Ik+Y3qEvs//kbeeP1iVvrxscjv0RcNyN8GTBR
   2PFhiF4MV4esnWs8DZ2YKh5GY2rM0G9GvGThXfeY53b7+k367OX9eenuO
   jReluQBwGC8Akdmy7I9R00+dSL9MT5XvFUZpt0GeANT9nXGeOamB8MN/N
   Xt42JiRVJ5Sp6vWKXntASpHBlGjxbEMguvfyT3jCDdute4hM/ZsuKLaqe
   lTqBOZZfhf54fRLryeLAFfyljsXvMWwj9kzRN5O9YgpJn6IV5Yz2ISpaU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="378930648"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="378930648"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 12:22:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="864509026"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="864509026"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 12:22:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qlDdl-00000000hR1-01Jq;
        Tue, 26 Sep 2023 22:22:37 +0300
Date:   Tue, 26 Sep 2023 22:22:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: intel_speed_select_if: Use
 devm_ioremap_resource
Message-ID: <ZRMvfL+BqacV/Y+D@smile.fi.intel.com>
References: <20230926175840.989732-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926175840.989732-1-srinivas.pandruvada@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 10:58:40AM -0700, Srinivas Pandruvada wrote:
> Replace devm_ioremap() with devm_ioremap_resource() by defining a
> resource.
> 
> No functional impact is expected.

Resource(s) will be monitored via resource management framework.
Dunno if this will affect functionality of a code.

> Suggested-by: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>

Andy

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Reviewed-by: From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


