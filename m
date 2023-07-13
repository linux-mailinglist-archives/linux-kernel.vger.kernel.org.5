Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE97752912
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjGMQtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbjGMQtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:49:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E277130F2;
        Thu, 13 Jul 2023 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689266936; x=1720802936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=59+LYzhy+0HnTxIOhHyvr1lUJNvrJlPI3qg9viatPhw=;
  b=RsSn98qNzo36YDz8LB9gE/UYTT+FNCd8p1PdHEz3NhgigiWapiBGy9jw
   XjIh9jECFZVM5pyuPgBhtqoytUGm5YZJUe7eF3Jh1ZsP3DzAlPXdXmKL6
   AXltNhTjtY6cqRwneDaSI70OzVYUgISWvp6gOeQfCDnK6VbbB8o02yEnm
   7JsqSroTBPbL+WJnqbeGoUM5+YyDtMfc3qnHlNlyQny4crYxRh5Qmal7b
   jdCpTOVd+utwYDnFBAxjeXXH56aCLmXWWEA+ddc/vM7YNywYh5AbE+eyc
   d9cI+ykItg9m5gK6ra5UfYFlqp5F7AMfGnYnxGCXxrZIazFcboAG43sxX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="365286096"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="365286096"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 09:48:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="787520642"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="787520642"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jul 2023 09:48:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJzUr-002RPD-1P;
        Thu, 13 Jul 2023 19:48:53 +0300
Date:   Thu, 13 Jul 2023 19:48:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] TPMI control and debugfs support
Message-ID: <ZLAq9YnaQ5XPsiZG@smile.fi.intel.com>
References: <20230712225950.171326-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712225950.171326-1-srinivas.pandruvada@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 03:59:47PM -0700, Srinivas Pandruvada wrote:
> The first patch provides interface to read feature status. This is
> generic patch to be used by other feature drivers.
> 
> The second patch add support for debugfs. Debugfs also display
> feature status using the first patch

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

A couple of nit-picks in the individual comments.

> Srinivas Pandruvada (3):
>   platform/x86/intel/tpmi: Read feature control status
>   platform/x86/intel/tpmi: Add debugfs interface
>   doc: TPMI: Add debugfs documentation
> 
>  Documentation/ABI/testing/debugfs-tpmi |  31 ++
>  MAINTAINERS                            |   1 +
>  drivers/platform/x86/intel/tpmi.c      | 399 ++++++++++++++++++++++++-
>  include/linux/intel_tpmi.h             |   2 +
>  4 files changed, 426 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/ABI/testing/debugfs-tpmi
> 
> -- 
> 2.40.1
> 

-- 
With Best Regards,
Andy Shevchenko


