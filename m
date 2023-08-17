Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F7677F3C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349783AbjHQJq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349458AbjHQJqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:46:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13112D61
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692265577; x=1723801577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VAOxX9dZKPiZ9XHXa7j3w1DYnbZZ6q4H5oCemHizHWM=;
  b=QVjH4x9qNw0p9r6sYqyMn+80IjeaCBrmvYDJUPTcrFFphoSOgOJu3fFA
   YRvq/RZuzKk+VqJHIi7Hy/GFWqf/nBjFhBhWBZxCspzZYyzExdP1zZbTC
   tnj8by+m6r0eV515QA4Ond08GYWvQG8msJOnXBj7TBBk4LEWl76i6i6iA
   2O6OWm45/eO2psd8xfmdY1md75if6p8dfobm99NkZyX305tRlAWrY+BwX
   j7DUal7AUqD+00jQyMYiw82JHWhvORlg5wSqIHzSvBCgqVZwKmDU5SdzG
   1cTNBGcxCL6IK0sMtTArqq/mzWy4CSzh70F1T42ro9mKBullqH8SchT98
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403744908"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="403744908"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 02:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848826704"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="848826704"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 02:46:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWZZp-005m4l-1u;
        Thu, 17 Aug 2023 12:46:01 +0300
Date:   Thu, 17 Aug 2023 12:46:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 4/8] bitmap: replace _reg_op(REG_OP_ALLOC) with
 bitmap_set()
Message-ID: <ZN3sWbKpW6g45r7R@smile.fi.intel.com>
References: <20230815233628.45016-1-yury.norov@gmail.com>
 <20230815233628.45016-5-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815233628.45016-5-yury.norov@gmail.com>
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

On Tue, Aug 15, 2023 at 04:36:24PM -0700, Yury Norov wrote:
> _reg_op(REG_OP_ALLOC) duplicates bitmap_set(). Fix it.

This is not a fix.

-- 
With Best Regards,
Andy Shevchenko


