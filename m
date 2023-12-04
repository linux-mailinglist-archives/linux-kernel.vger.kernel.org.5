Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1528033AE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344161AbjLDM76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjLDM75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:59:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61E4AC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701694804; x=1733230804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y2GfyXQZuFvt44HpNbFO8Dio1945GQvhrWWBFMeblpg=;
  b=NK2Xa/LBs5fi966YKG1RFAhJRJYqd/xBIW4FWspJMByWqgCBRyAAbuCw
   aqtXtAE1AjcXny6Es+Xn3gH8fWqIR3kNDcIV4d6w/T7SdXgs8c7fZ8IeA
   +luYl6risJ2UkB6GtKSIvisNnc1Y24a8NYqIs+pFdBVAoAM2EZXIhEhir
   BsSYy8Dt94DZqNfYOST67DU1skgiZpC/szNx/Znj1X7YvXeXe3SbGpe3p
   qxW8MBEnh6k/B8B6sdeF3XwPMyUUN2CIDeqDnHgRhp1K6kFsEdPUxQCPh
   Yus4d2mDUi9eJNSi6Az/ucfvKj/CsOy8PylmaPVf3jpCnP8hG/JsxG/Pv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="780594"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="780594"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:00:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="836576672"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="836576672"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:00:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rA8YI-00000001kmJ-1XMq;
        Mon, 04 Dec 2023 14:59:58 +0200
Date:   Mon, 4 Dec 2023 14:59:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v1 1/1] checkpatch: Add dev_err_probe() to the list of
 Log Functions
Message-ID: <ZW3NTnB5Vdf890zP@smile.fi.intel.com>
References: <20231201151446.1593472-1-andriy.shevchenko@linux.intel.com>
 <3c709cc1-0da8-4d23-9f75-8c18d4d18779@roeck-us.net>
 <ZWoHLkcPk2084gQH@smile.fi.intel.com>
 <8fff7625-69b7-4c32-a3bb-d3ca24f149bf@roeck-us.net>
 <ZWoS3gyJukQkndqY@smile.fi.intel.com>
 <8d846c564461af99c27d81a69888d73f3622de8b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d846c564461af99c27d81a69888d73f3622de8b.camel@perches.com>
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

On Fri, Dec 01, 2023 at 02:29:57PM -0800, Joe Perches wrote:
> On Fri, 2023-12-01 at 19:07 +0200, Andy Shevchenko wrote:
> > Currently the [style] behaviour is
> > inconsistent independently on somebody's preferences...
> 
> <shrug>  Which is IMO perfectly fine.
> 
> The ratio of multiple line and single line uses
> of dev_err_probe is ~50:50
> 
> $ git grep -w dev_err_probe | grep -P ';\s*$' | wc -l
> 1532
> $ git grep -w dev_err_probe | grep -P ',\s*$' | wc -l
> 1871

My point is that checkpatch won't warn on dev_err(..., "very long line\n");
while doing the same on dev_err_probe() even if the line is shorter than in
dev_err() case. This inconsistency I am talking about.

-- 
With Best Regards,
Andy Shevchenko


