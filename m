Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EC47EAFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjKNMLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjKNMLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:11:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9208D133;
        Tue, 14 Nov 2023 04:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699963885; x=1731499885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S7XiKn8qHd30a1CCbLm7pq6hZ0fzTbDe51PrhInjjjo=;
  b=T4n3N0OawmRXwhvIRrsq0pi4+cy2tF+feKL41d5VsmbVu9jE1yFCZyuG
   W8V68zBEJdgfg8cXimzgZHxa3j+3BZU77AeAxXqh+RAO6b/B+93SEt0fZ
   oPmTcpLCmOgzACVN1dCKnoAnXaEpxKxhTOgJ2dorgWgo5WW4EbFeJufNq
   +JTrZb8N7/7BJ9UKh2QkpKIXQC0QasPcBLdGhzcDNo2k+EnpbNCdMCPF8
   /R1niaOMT/M7IHQQ1601Z57yFH7SNJ1uVSb8BypRE2ulV1ClMzT/ggygF
   hAgQicGhIvoUib6tIyCKOfV+yea8dDnBERnOJxUTkCvxSfSO2Ope8vncJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="3702370"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="3702370"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 04:11:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1011894067"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="1011894067"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 04:11:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2sGG-0000000Dnra-2lnA;
        Tue, 14 Nov 2023 14:11:20 +0200
Date:   Tue, 14 Nov 2023 14:11:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     kernel test robot <yujie.liu@intel.com>,
        Raag Jadav <raag.jadav@intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/2] pinctrl: intel: Add a generic Intel pin control
 platform driver
Message-ID: <ZVNj6GY3Rb6Y-bqR@smile.fi.intel.com>
References: <20231113123147.4075203-3-andriy.shevchenko@linux.intel.com>
 <202311140345.etMnKZeR-lkp@intel.com>
 <ZVNczZMruhh59Vfc@smile.fi.intel.com>
 <20231114115024.GV17433@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114115024.GV17433@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 01:50:24PM +0200, Mika Westerberg wrote:
> On Tue, Nov 14, 2023 at 01:41:01PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 14, 2023 at 09:46:07AM +0800, kernel test robot wrote:
> > > Hi Andy,
> > > 
> > > kernel test robot noticed the following build errors:
> > > 
> > > [auto build test ERROR on linusw-pinctrl/devel]
> > > [also build test ERROR on linusw-pinctrl/for-next linus/master v6.7-rc1 next-20231113]
> > 
> > False positive as the dependencies appeared in today's Linux Next.
> > 
> > $ git tag --contains 22f57707fa0c
> > next-20231114
> 
> Okay thanks for checking!
> 
> The series looks good to me so feel free to add,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


