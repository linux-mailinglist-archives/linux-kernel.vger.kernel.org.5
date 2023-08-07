Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1A9772876
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjHGPAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjHGPAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:00:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEBA9F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691420411; x=1722956411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aiPJPEq0T6L9AyetiOa3BfDQ5zox6rdHDOUrfreuhUI=;
  b=K/QJFRfhAP5vRKyQtwwDl5kvHkysV5o0/uD+jM8FNdUODT853cw//rjT
   VZfqHaw6h7W09wngi2t8WVDGvY6ueegJbap8wsnTxyIssxBYf8lnHw4wB
   F3Myj8Fy8QwkPWpD1KdPI4p1DtGV9oGsmNk5A2/y0hFmFn6veeYQIzVMt
   LPKlWaE7iws130RMnyhey4nU6XP62+XKQ6YQkEFkW4Dice4kw0nB21bM5
   Pq29UVTybWNl9ZK5LLm/q7M7ntW6zPf5EW4Ya8MnIo9evSiRnBBFtVXF1
   egiNgQmdkS7h3LcirS790xlsX51pwPT8tucnN2UcU/TVAXgWvuyXI6vz2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360651463"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="360651463"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 08:00:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="760526738"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="760526738"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 07 Aug 2023 08:00:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qT1iI-00GPvH-0W;
        Mon, 07 Aug 2023 18:00:06 +0300
Date:   Mon, 7 Aug 2023 18:00:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Sort headers alphabetically
Message-ID: <ZNEG9YbSny86bxmZ@smile.fi.intel.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-2-andriy.shevchenko@linux.intel.com>
 <ZNEASXq6SNS5oIu1@alley>
 <20230807145302.GD907732@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807145302.GD907732@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:53:02PM +0900, Sergey Senozhatsky wrote:
> On (23/08/07 16:31), Petr Mladek wrote:
> > 
> > I am sorry but I will not accept this patch unless there
> > is a wide consensus that this makes sense.
> 
> I completely agree with Petr.
> 
> I found it a little bit hard to be enthusiastic about
> this patch in particular and _probably_ about this series
> in general, sorry Andy.

What to do with _headers_ that include kernel.h for no reason other than
sprintf.h (as an example)? Your suggestion, please?

-- 
With Best Regards,
Andy Shevchenko


