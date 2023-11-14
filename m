Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD47EAF58
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjKNLlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNLlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:41:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCD4D9;
        Tue, 14 Nov 2023 03:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699962072; x=1731498072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qd0JXalpGcwrYa5tsYwaquRc1lmCzBIUp6iekemYFyE=;
  b=CAQaDdBf3d1g622tAJGdJHJxbVXHeHEPuY/hut0aFM/uNGWKM6IH5u2q
   PmkyC+q1vEnQcU7BIGz5FDIW6NLe7HDQ2lH+V6K3MUq4fV+BXeBcf6Ytz
   TdJYDTafooshQ+5Fy2XCEJang17eSdtnemfpv8+T/qmPjLLz47l/GwTCF
   psJsuQUH/QVFzWUeGxB0N2TUVa9VuZrK50ahRwKTFS5W0rgT6OwINREq7
   MjK5BNWyv/gi23DHjLeaW2/Sr33VA+tuWxnDrGgvzbbOz8XBtvmvSxC4o
   hA4Q2N5AI0NyCsZBEAqx9tfH1aGqP7lW+/mqzGnLqHjOw0VDyK6SD88HI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="3742844"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="3742844"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 03:41:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="938053799"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="938053799"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 03:41:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2rmv-0000000DnLW-4BEl;
        Tue, 14 Nov 2023 13:41:01 +0200
Date:   Tue, 14 Nov 2023 13:41:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/2] pinctrl: intel: Add a generic Intel pin control
 platform driver
Message-ID: <ZVNczZMruhh59Vfc@smile.fi.intel.com>
References: <20231113123147.4075203-3-andriy.shevchenko@linux.intel.com>
 <202311140345.etMnKZeR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311140345.etMnKZeR-lkp@intel.com>
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

On Tue, Nov 14, 2023 at 09:46:07AM +0800, kernel test robot wrote:
> Hi Andy,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linusw-pinctrl/devel]
> [also build test ERROR on linusw-pinctrl/for-next linus/master v6.7-rc1 next-20231113]

False positive as the dependencies appeared in today's Linux Next.

$ git tag --contains 22f57707fa0c
next-20231114

-- 
With Best Regards,
Andy Shevchenko


