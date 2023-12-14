Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A240813588
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573947AbjLNQA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573919AbjLNQAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:00:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450E5E8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702569662; x=1734105662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MO0cb4xBumQBl6fOdYgeZbqe/Me8HN7NNVsrBWcpE/4=;
  b=Toby5VHFSwIH8fOHaUSKgdi3JbXtkhpV4SR7daH/rEbbkAau9X4jvTJK
   eWi3AX3+Okf+vot6fEffrKUtN2qWiYhT6XmPvNy4i625RUJQVXZrrii+U
   ba+9e8opPRp+rfmaelfjn+8AXPuFsStb26l6IXWtoGnNpulPeBQzj4eEH
   64zBSJ9zLQYowN51a7mo+vRbapGZXAx525QarEGSs10Mvuz3S3e1kP29K
   cQZX2y7zSimUtKlQcfsk4cbAVWM9RWFHa9lkVyjVs1XqNdMCx1CjIoVvB
   q/a1L9Mm5rINW5KFFxy2xh9YUJ3vBBbavRLkqdfDSEUgFjXHJAan+tkAu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1990478"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1990478"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 08:01:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="897787243"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="897787243"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 08:00:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rDo8t-00000005t4Y-0fF7;
        Thu, 14 Dec 2023 18:00:55 +0200
Date:   Thu, 14 Dec 2023 18:00:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        alexander.usyskin@intel.com, tomas.winkler@intel.com,
        Arnd Bergmann <arnd@arndb.de>, wentong.wu@intel.com
Subject: Re: [PATCH 1/1] mei: vsc: Rework firmware image names
Message-ID: <ZXsmtrGerSc7MS8h@smile.fi.intel.com>
References: <20231213094055.446611-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213094055.446611-1-sakari.ailus@linux.intel.com>
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

On Wed, Dec 13, 2023 at 11:40:55AM +0200, Sakari Ailus wrote:
> Rework firmware image names with the users in mind---there's no need for
> variation between firmware names, apart from connected sensors. All
> supported SoCs use the same firmware, too.
> 
> Use a single set of firmware binaries and assume they'll be found under
> intel/vsc directory.

I like it, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


