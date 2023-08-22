Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D627841DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbjHVNUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbjHVNUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:20:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF01CDF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692710429; x=1724246429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iaeGlBbY4YmUG0GxgSWZvioiIduG7Z/j6HALi97hkFg=;
  b=i74Cczm/OKI1ngSnLTsOEo13rY/apyiQe4cpJWAUUac+tV+8h4qxNXLw
   4Rv7PB6h5FI1PtCDnNMWWycjHaSEhWhCHUmHjUN4xTqwzF1ZLLyf0+tqj
   dJk748UDm18sCTOgJR0sN5ad7Tf2ctJrHd0DWTgLGlXbADbIKyne/Qpzm
   VseSJYioyDkWc0CqezwXXtCGHkY3cr1EptsAXAQwukzYxCEk0W8Af/OWl
   zgUUHmiS9yXvRj3WNJ612q887nLGbus4BPVnscCPKJeveabTJQyPmybb2
   kgoAxX3f6Lcop0zU5yaySyZDWeWRETKuP32miywcJjZ4d1TTe5uRAAPfv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="354213728"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="354213728"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 06:20:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="859919532"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="859919532"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 22 Aug 2023 06:20:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYRIu-00BuxZ-32;
        Tue, 22 Aug 2023 16:20:16 +0300
Date:   Tue, 22 Aug 2023 16:20:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/1] serial: core: Remove unused PORT_* definitions
Message-ID: <ZOS2EOiXOn1tjKAS@smile.fi.intel.com>
References: <20230821083857.1065282-1-andriy.shevchenko@linux.intel.com>
 <2023082210-clasp-guru-0456@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023082210-clasp-guru-0456@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 02:59:37PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Aug 21, 2023 at 11:38:57AM +0300, Andy Shevchenko wrote:
> > For the last couple of years Linux kernel got rid of a few architectures
> > and many platforms. Hence some PORT_* definitions in the serial_core.h
> > become unused and redundant. Remove them for good.
> > 
> > Removed IDs are checked for users against Debian Code Search engine.
> > Hence safe to remove as there are no consumers found (only providers).
> > 
> > While at it, add a note about 0-13, that are defined in the other file.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v2: tested via DCS (Greg), dropped 1 change due to that, added a note for 0-13
> >  include/uapi/linux/serial_core.h | 43 +++-----------------------------
> >  1 file changed, 3 insertions(+), 40 deletions(-)
> 
> You forgot to cc linux-serial@vger :)

Oh, that's because I cooked this patch against v6.5-rcX, where X < 7, and hence
the 238500e2d67c ("MAINTAINERS: Merge TTY layer and serial drivers") is absent.

> I'll take this now, thanks for cleaning this up.  Hopefully we can
> resist the urge to add new ids here.

Thank you!

I want to compress the list based on DCS research, it seems feasible and may
shrink a lot of memory at run-time for the port structure. Let me check that.

-- 
With Best Regards,
Andy Shevchenko


