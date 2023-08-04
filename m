Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CBB7709B7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjHDUcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjHDUcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:32:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF264ED3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691181124; x=1722717124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t5iZxzWJ77jyknlbwewqXxpRaUFyHhslImuVj5UImbY=;
  b=SjFKITtRRtclcuj3qBCRy/wXx1ZoCdZULEPrlpXddujTzRzyhx0xq2Ya
   1ylBzrdNes4uhr7xcAIaKSl+H6IXiTkNjzeRk4VR5Jgtdt4sWklmrcX5H
   BCfkJtzB0XufM6luhAcsXSZZIfQyv+a+Z2ZJjFV2V6/nA9xq5N8IgEVaN
   smAJjrD858kXfwDQYdgP4CzSD7pcc/OLxMwrk245KqORnI5lDWDi4jhax
   8JiNH/cbfknKAA/iIyAbvidz3J50wKL9BxFFZYgaEYyZcj3I7wC4hWhBu
   rdseyQUbSp7JW3SFbdmULQsDgF6z9ARRkUMSOE34nZ6jhMkiMyJ3ObSBw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="373895261"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="373895261"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 13:32:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="759701472"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="759701472"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2023 13:32:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qS1So-006vh4-20;
        Fri, 04 Aug 2023 23:31:58 +0300
Date:   Fri, 4 Aug 2023 23:31:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 3/4] lib/vsprintf: Remove implied inclusions
Message-ID: <ZM1gPnmGPcheMWj7@smile.fi.intel.com>
References: <20230804082619.61833-1-andriy.shevchenko@linux.intel.com>
 <20230804082619.61833-4-andriy.shevchenko@linux.intel.com>
 <33e128e8-9330-c73e-4c55-e56cbc87450a@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33e128e8-9330-c73e-4c55-e56cbc87450a@rasmusvillemoes.dk>
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

On Fri, Aug 04, 2023 at 11:36:15AM +0200, Rasmus Villemoes wrote:
> On 04/08/2023 10.26, Andy Shevchenko wrote:
> > Remove inclusions that are implied and guaranteed to be provided by others:
> > 
> >   compiler.h	by types.h
> >   string.hi	by string_helpers.h
> 
> What? No. That's not what we want. Each .c and each .h file should
> include the headers that declare the stuff they're using.

99.99% of kernel if not more doesn't follow this rule pedantically.
We have to have a compromise between what is guaranteed and what is not.

For example, I'm pretty sure the types.h will always include compiler*.h.

> So if string_helpers.h magically stops referring to anything from string.h,
> one should be allowed to stop including string.h from string_helpers.h.

That's how agreements work. We may agree to guarantee such inclusion or
not. The kernel headers as of today is a complete mess (refer to the
Ingo's 2k+ patch series). But still, some order / agreement is good to have.

> Sure, those two may forever be so intertwined that it never happens, but
> one really can't maintain some matrix of "X always includes Y so if you
> include X you don't have to include Y" in one's head.

Somebody should do that at some point, otherwise it becomes even more mess.

If you want your way, iwyu should be part of the kernel build. And be prepared
for dozens of headers to be added to the every single C file in the kernel.

-- 
With Best Regards,
Andy Shevchenko


