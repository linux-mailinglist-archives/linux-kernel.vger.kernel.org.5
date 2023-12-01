Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48E7801126
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378777AbjLAQS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378342AbjLAQR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:17:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC201FDA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701447476; x=1732983476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c2E7CG6uyepV9nDHpR+5LjE4/DSDebBB9Tnx7sJ/DOE=;
  b=JBbLZU8zL4ApBhzxDjxtoPcdIeSl5yzqVk09mLivuTqTVM070uEb7sZh
   jXRkJyZ2NU8h3w/2ENijgnw2RMgcdqZhRhNJryFhCwK7B4aPQpibMesx1
   2sNTt8mMUEmAWXF5cXPVn1R3I0N72TGTrQH1HQvLw2VeGypn6F0XtqtIG
   jGI2+5Q+Mp/LMJdUQDM650EEn9URDvRYbGVeT0XbP84UXwVBnYa5D80/t
   kVgr0sA5+98cH5meuoigLUrpYHG13MHNCPWO65mSVgZEgpm9VpTTKVVCq
   T1Dyi4zY3yEf1gWGYz8vEjSjhVHhM0UtTZFRdOHO0RzG3cAAzvqYW7AWu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="460013094"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="460013094"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 08:17:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="763190783"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="763190783"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 08:17:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r96D9-000000012Fn-0ei5;
        Fri, 01 Dec 2023 18:17:51 +0200
Date:   Fri, 1 Dec 2023 18:17:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v1 1/1] checkpatch: Add dev_err_probe() to the list of
 Log Functions
Message-ID: <ZWoHLkcPk2084gQH@smile.fi.intel.com>
References: <20231201151446.1593472-1-andriy.shevchenko@linux.intel.com>
 <3c709cc1-0da8-4d23-9f75-8c18d4d18779@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c709cc1-0da8-4d23-9f75-8c18d4d18779@roeck-us.net>
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

On Fri, Dec 01, 2023 at 08:01:28AM -0800, Guenter Roeck wrote:
> On 12/1/23 07:14, Andy Shevchenko wrote:
> > dev_err_probe() is missing in the list of Log Functions and hence
> > checkpatch issues a warning in the cases when any other function
> > in use won't trigger it. Add dev_err_probe() to the list to behave
> > consistently.

...

> Not sure if I agree. The difference here is that dev_err_probe()
> has two additional parameters ahead of the string. I would very much prefer
> to have those two additional parameters on a separate line if the string is
> too long to fit in 100 columns with those two parameters on the same line.
> In other words, I very much prefer
> 
> 	dev_err_probe(dev, -ESOMETHING,
> 		      "very long string");
> over
> 	dev_err_probe(dev, -ESOMETHING, "very long string");
> 
> and I don't really think that the latter has any benefits.
> 
> Also note that other dev_xxx() log functions are not included in the above test
> and would still generate warnings. Accepting
> 
> 	dev_err_probe(dev, -ESOMETHING, "very long string");
> but not
> 	dev_err(dev, "very long string");

They are included, see the line previous to the added one.
(Regexp covers something like x_y_()* and x_*() families with the explicitly
 listed * suffixes.)

That's why _this_ change makes it consistent.

> doesn't really make sense to me.

-- 
With Best Regards,
Andy Shevchenko


