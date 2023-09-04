Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55947915A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349302AbjIDKTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIDKTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:19:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0731B5;
        Mon,  4 Sep 2023 03:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693822761; x=1725358761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LC4ZrzWPJx/GfRf3fvtUpeNi3dtEfh0pDMNct3gX1kw=;
  b=ZqBDvTldthvUihjE8RG9r7g0QhgRblKa+iC+aYQuV25AD4Y/BWH8x0rT
   FZCp7Gv8r/2+kQINbG6WvwJ4Qffnzxa3edALd/iQJDdfW9HxKuKQLj9Eu
   gQI6Y+UUW46kSpjwiyCzECcrIGV8EEW1rKp34DtO0L5c8k3YYGpgmcsYn
   /aCRoehpJegsN+g3fx7/zyVJnWK+f8+l4JAHIikQd3+g+W4sYN+Y6s0Rb
   DJ6Qt8+z3qIxc9pYKLtdczlPsLKmxRjcQXsOTcg/7D/94r83F0fnflqMP
   65J1QBaC4vKEMijbw4CgQkLZe60L1SOJhqJ54DbOIPCfeJUR23ezc0M/J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="376500568"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="376500568"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:11:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="775799725"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="775799725"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:11:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd6Y4-006OdC-2h;
        Mon, 04 Sep 2023 13:11:12 +0300
Date:   Mon, 4 Sep 2023 13:11:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH 2/2] power: supply: bq2515x: Some cleanups
Message-ID: <ZPWtQDL5f0sgRJTM@smile.fi.intel.com>
References: <20230902200518.91585-1-biju.das.jz@bp.renesas.com>
 <20230902200518.91585-3-biju.das.jz@bp.renesas.com>
 <ZPWs+xtfQUlGOaVe@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPWs+xtfQUlGOaVe@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 01:10:04PM +0300, Andy Shevchenko wrote:
> On Sat, Sep 02, 2023 at 09:05:18PM +0100, Biju Das wrote:
> > Some cleanups:
> >  * Remove trailing comma in the terminator entry for OF/ID table.
> >  * Drop a space from terminator entry for OF table.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Btw, in all similar patches you may add the reason(s) why you are doing that:
> 
> 1/ unification;
> 2/ making code robust against (theoretical) misrebases or other similar things
>    where the new entry goes _after_ the termination without compiler noticing.

I.o.w. "terminator" has to "terminate" at run-time _and_ at compile-time.

-- 
With Best Regards,
Andy Shevchenko


