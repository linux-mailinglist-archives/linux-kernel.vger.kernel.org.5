Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1C8772871
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjHGO7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjHGO72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:59:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C6B172A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691420347; x=1722956347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6jKYcqoZbZb+y6bFjNGXgbrH6GTB4XHCuMLza1e1NpA=;
  b=bFEpDFpdHTJZ5dX+dqdrzdObLN2nQg8R0Fso78ySkOMx4yBx49xsNzEG
   7/CHKkjG3hiu0/FBzPpFWLxgLT9Y3GIhRSOu+wcbOLSIZ3PVN2I7XqOFL
   ESklrCcAHjKhcOGVn2PnHac93hboVNmGqqamls8g4nY4CIvyr9HuqDPDk
   Ody/X5K46g5VhpK+bmR36mwXkVdMuq7b13zhNbJRZK8hQ5QV8G5dbRot6
   y+BcoDa3YACWrNKrFpbahMro3H/NCV21ZY52qO83l8mXV2RMOudHw5EGU
   EWrlp9v2GJ1SKZb+857aXFn8+HtoS7OAf5/GcelKSMcvWGZst7W5+VXEF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350872883"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="350872883"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:58:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="800960674"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="800960674"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2023 07:58:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qT1h8-00GNLO-24;
        Mon, 07 Aug 2023 17:58:54 +0300
Date:   Mon, 7 Aug 2023 17:58:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Sort headers alphabetically
Message-ID: <ZNEGrl2lzbbuelV7@smile.fi.intel.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-2-andriy.shevchenko@linux.intel.com>
 <ZNEASXq6SNS5oIu1@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNEASXq6SNS5oIu1@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 04:31:37PM +0200, Petr Mladek wrote:
> On Sat 2023-08-05 20:50:25, Andy Shevchenko wrote:
> > Sorting headers alphabetically helps locating duplicates, and
> > make it easier to figure out where to insert new headers.
> 
> I agree that includes become a mess after some time. But I am
> not persuaded that sorting them alphabetically in random source
> files help anything.
> 
> Is this part of some grand plan for the entire kernel, please?
> Is this outcome from some particular discussion?
> Will this become a well know rule checked by checkpatch.pl?
> 
> I am personally not going to reject patches because of wrongly
> sorted headers unless there is some real plan behind it.
> 
> I agree that it might look better. An inverse Christmas' tree
> also looks better. But it does not mean that it makes the life
> easier.

It does from my point of view as maintainability is increased.

> The important things are still hidden in the details
> (every single line).
> 
> From my POV, this patch would just create a mess in the git
> history and complicate backporting.
> 
> I am sorry but I will not accept this patch unless there
> is a wide consensus that this makes sense.

Your choice, of course, But I see in practice dup headers being
added, or some unrelated ones left untouched because header list
mess, and in those cases sorting can help (a bit) in my opinion.

TL;DR: I was tolerating unsorted mess (for really long header
inclusion block) up to the point when I realized how it helps
people to maintain the code.

-- 
With Best Regards,
Andy Shevchenko


