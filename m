Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D737F7A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjKXRrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKXRrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:47:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7236AD56
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700848042; x=1732384042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pHB3kGp/ZHmJhMk/4OgkdCbBjqnP3BcYZuSuXzgIY0I=;
  b=gZvUSkE9A9toaDTVACeI/SDm5xOB1wwSCvqMu1iYmlB0iRvwVGQIwR8Z
   ck5a27RYtwNZcyVp5gtiOvXHbuCghJ7NdreWx/l3D5xlmh6QaHkAITLBC
   7Y5eHvYmyrD38Zy1gLYbFiZkWhHbPkBtrj0hIH4TEzahIYMZXqlYYcr1V
   P/FB6nJb7X3nhN9ewPEEed96PHky2PIDIvM9A1C+3ZcCiQh7DMzsR5Jrz
   SbRJRlBDMDjn+vBjMxDjTGw32ZQDtOWmg6ISbNIY12slI3IbM5ijMg3X5
   kZrYW0tau1iVsFy2BzU0nErmfczxw1y43SmHr/1nbcItDBDyNtYfTqZgL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="382853373"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="382853373"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 09:47:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="761010357"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="761010357"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 09:47:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1r6aGs-0000000GnJx-160x;
        Fri, 24 Nov 2023 19:47:18 +0200
Date:   Fri, 24 Nov 2023 19:47:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     lee@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: intel-lpss: Add missing check for
 platform_get_resource
Message-ID: <ZWDhpZLCZ5xz1RKR@smile.fi.intel.com>
References: <20230609014818.28475-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609014818.28475-1-jiasheng@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 09:48:18AM +0800, Jiasheng Jiang wrote:
> Add the missing check for platform_get_resource and return error
> if it fails.

> Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")

This does not fix anything and just introduces a duplication code.
I would like this to be reverted. Should I send one?

-- 
With Best Regards,
Andy Shevchenko


