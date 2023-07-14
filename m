Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3FF753F77
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjGNQEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbjGNQEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:04:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1FB272E;
        Fri, 14 Jul 2023 09:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689350687; x=1720886687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bB40wKvZmZKP4Wn5M5OUOKQaWuB+T5oYQChHd9Q/N4I=;
  b=OFh9E24JEBS0Icx9337JWcsWoikF19+0+ObkBItFgrPZ5jeQ3RcfWrSP
   8Z/Jr0zXUewjZVNwJDtW1KW7R330zNoTZgNigUuJqJFrM/GzeyVKSDMM1
   u/CXE/f/08rN0j7YZ9dSlL62VJWocsXQ9qwsEA0jWWoVsT/wH5QPMnxwv
   JtTK4jfv7s+MJq//11bNKN/oZeQ0amKuLvyUd7j9xmA8KOZj3wd7EADWP
   zUD/h/CkNLjdNsrL69XBtLAtDkJNGa7OkoJelZTd9a2LHGV4m1cFuO/7I
   I0bs8aogu9MBGcJmKEbN5QduKfmIid7h/rdRwkHf33e/hXA/rtMbOwpPz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="350376985"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="350376985"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 09:04:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="787894352"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="787894352"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2023 09:04:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qKLHf-002iDg-1f;
        Fri, 14 Jul 2023 19:04:43 +0300
Date:   Fri, 14 Jul 2023 19:04:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/2] docs: printk-formats: Treat char as always
 unsigned
Message-ID: <ZLFyG4MtulHnJcnw@smile.fi.intel.com>
References: <20230703145839.14248-1-andriy.shevchenko@linux.intel.com>
 <20230703145839.14248-2-andriy.shevchenko@linux.intel.com>
 <ZLFrC4Ocu7DvKuco@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLFrC4Ocu7DvKuco@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 05:34:35PM +0200, Petr Mladek wrote:
> On Mon 2023-07-03 17:58:39, Andy Shevchenko wrote:

...

> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thank you for the review!

> PS: I am going to queue both patches for 6.6. They are not
>     urgent to be added in the -rc phase.

Sure, works for me.


-- 
With Best Regards,
Andy Shevchenko


