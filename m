Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD617B4F24
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbjJBJid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjJBJi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:38:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45B591;
        Mon,  2 Oct 2023 02:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696239505; x=1727775505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EKeqTQ7lBi8p0ds3MCDEOA0gTab2eJ95FzFsr/E1n6o=;
  b=X34ptVaB7wNYWA2sNbvdGAtGQNYh2ZEsdtYD5iHE0/COoszRyiwVDjQe
   Jm4CFUWv8IZUqdppAajngRRsUdGh9AnaLmL6pre2gDfJ2JOJ+2MvMj1dZ
   nqokmDZZQDuX+Ya4roNjnRg4jH3j0eq7SdOn7x+p1Xa0mO07MdDbXLMl4
   CYyQ8NM9Uw5KL5irCLaA0BDktRYvL8pG+MHCGOcuTxIIM4lVdiqZLXuIQ
   3q/LDb43YaWesQOEDZ7EFWHQtSj39Bx0RMVq79DpFfteC7taN717Lzn0T
   6QptztR6cirdpv6Jb0kmG5kkTXlR+9aaxt7NT0Zjmd7ezZ2TLD8FNPLaP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="382516181"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382516181"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:38:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="1081591596"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1081591596"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:38:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnFNc-000000027aE-1EzC;
        Mon, 02 Oct 2023 12:38:20 +0300
Date:   Mon, 2 Oct 2023 12:38:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rafael.j.wysocki@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v1 2/2] ACPI: NFIT: Use modern scope based rollback
Message-ID: <ZRqPjLfITntN3cKr@smile.fi.intel.com>
References: <20230926184520.2239723-1-michal.wilczynski@intel.com>
 <20230926184520.2239723-3-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926184520.2239723-3-michal.wilczynski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 09:45:20PM +0300, Michal Wilczynski wrote:
> Change rollback in acpi_nfit_init_interleave_set() to use modern scope
> based attribute __free(). This is similar to C++ RAII and is a preferred
> way for handling local memory allocations.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


