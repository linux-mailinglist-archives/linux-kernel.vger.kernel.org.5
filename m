Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E927678C89B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbjH2P3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237294AbjH2P3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:29:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19871BB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693322950; x=1724858950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vCm19zfFlQsRtOpVppq1qEr5BzGW4HddNBumYjzdWDM=;
  b=PzpR6YJrBu9zHD62oG5Cefy+mbo13F4qWWRe6y4ha/NfhOS9MAOcJSbX
   sGNxwPWx//V8MLV6eA12XbrqaY/D7oLAhSadiK47Y+n6kVVuPzyD8W4It
   WNA/yXNI7+sHb3yyK7533x/74Atqk0LoYKrwF0CvbRzGBYKzNcWvM2UAx
   s2Az2EppCCYC8Z3Y9Coym+70/TJiV+X8IxBU4yg2Ut2ielFDGteO1c5XI
   N1eYp3rNqFaf0dDBdTQqWDS5YdLHbABRiMdvYTLQW/4s4lrnWojSQMEvR
   T3HmX38w1LwaqBFbJ0ELvRvfRgjIp74KOJTc3N3NP9SWdPwpYyw1WCAwT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="355725589"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="355725589"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 08:29:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="738752199"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="738752199"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2023 08:29:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb0eR-004unT-2Z;
        Tue, 29 Aug 2023 18:29:07 +0300
Date:   Tue, 29 Aug 2023 18:29:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 2/8] bitmap: add test for bitmap_*_region() functions
Message-ID: <ZO4Ow2dPZrQRml9d@smile.fi.intel.com>
References: <20230829023911.64335-1-yury.norov@gmail.com>
 <20230829023911.64335-3-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829023911.64335-3-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 07:39:05PM -0700, Yury Norov wrote:
> Test basic functionality of bitmap_{allocate,release,find_free}_region()
> functions.

I'm always fan of new test cases,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


