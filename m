Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A917568B7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjGQQJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjGQQJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:09:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65D91AC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689610150; x=1721146150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YY+53Xlu9otT4LWLR5OcoAlxNJ/QtG/+upDrxe/Yolg=;
  b=P65KOabzOwl4OpdSQaLCVVuqN68gevKGsBi9Wky7i80V6ub4lCWvnoZ2
   U9xfN4GBZphQWV3s23it90+V+aLhONwsIEBaPLkijR93eAg5MmnMBBfT6
   ktV/aNyNT3J0wYQL2UeLXbqaThfx9tMlEw52Fi9RTJvCjdze7sabx8FJM
   LAnfCV5mSmygzYp424bnhwGzHE/9b61mcRh2HxDlPPnwYTr+rZH4Z2N41
   Avb1oZ8b2WhL6P0ik3yQXEHNUjRDjqJaPUodiDhexU4DgdhM8tZ1KVfTR
   u3i+hRxA9zJYwvxEcwRhZYWQLlmYrZr6R24rM5AKVbP81gdJH7s09Q6TR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432142360"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432142360"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 09:05:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="847351900"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="847351900"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 17 Jul 2023 09:05:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLQjI-004Gx5-2x;
        Mon, 17 Jul 2023 19:05:44 +0300
Date:   Mon, 17 Jul 2023 19:05:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] seq_file: Replace strncpy()+nul by strscpy()
Message-ID: <ZLVm2FLCRSnlYVUC@smile.fi.intel.com>
References: <20230717093332.54236-1-andriy.shevchenko@linux.intel.com>
 <202307170826.397635AD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307170826.397635AD@keescook>
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

On Mon, Jul 17, 2023 at 08:43:55AM -0700, Kees Cook wrote:
> On Mon, Jul 17, 2023 at 12:33:32PM +0300, Andy Shevchenko wrote:

...

> I think this doesn't need to use seq_show_option_n() at all.

Quite likely. Nevertheless, it's one of the dozens (?) warnings like this.

...

> Reviewed-by: Kees Cook <keescook@chromium.org>

Thank you for the review!

I think it's you who may take it as seq_file.h seems everybody's playground.

-- 
With Best Regards,
Andy Shevchenko


