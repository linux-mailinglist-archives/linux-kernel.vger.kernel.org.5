Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8464178C8DA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbjH2Pob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237356AbjH2PoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:44:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843AACDF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693323813; x=1724859813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f0lFfiPYifIoQWNfekzN1kl/h/edoaFDWxHeEcLxfTQ=;
  b=EUUONzjfUY8SEKMZZ8ilfNaZiEw0RyMYUlvnYMDZs0514PmxfEX5j/jK
   mUxWQcBkPiDQd3DyJ12dfzsQqU8/w5N1c7EJBKFRvibDSQk34KKLTq9fo
   vAsdD/2Z0za25wxsLXvXRx9AOHQMNi4fW/MAvaQGHhGecEzrN3p5si7ae
   Vt+3igkZbOBHfjKmnaotKU7GMQBM00HXl0TAvL7AMOZtpRPuFvKHNgVBn
   meCHJF7JETLqiZdC3czh+1vYBjeOZikpGF8/UZOE9iOz8rRe1GxV9dukP
   hVh/vOEuOWbJ82TwV06TSWokoIdAM+fo/c1a1sdX0ekWdO15JuzMzXDOA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461771506"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="461771506"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 08:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="862287548"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="862287548"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 29 Aug 2023 08:26:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb0cK-004ult-0Z;
        Tue, 29 Aug 2023 18:26:56 +0300
Date:   Tue, 29 Aug 2023 18:26:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 1/8] bitmap: align __reg_op() wrappers with modern
 coding style
Message-ID: <ZO4OP3tuQHa4adct@smile.fi.intel.com>
References: <20230829023911.64335-1-yury.norov@gmail.com>
 <20230829023911.64335-2-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829023911.64335-2-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 07:39:04PM -0700, Yury Norov wrote:
> Fix comments so that scripts/kernel-doc doesn't warn, and fix for-loop
> stype in bitmap_find_free_region().

...

> CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

When you have a tag, no need to have a separate Cc.
An in general, explicit Cc in the commit message make a lot of noise
and makes git index of the project fatter, you can use --cc parameter
when preparing / sending patches.

Other than that
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


