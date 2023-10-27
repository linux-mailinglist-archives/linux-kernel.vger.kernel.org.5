Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7067D9882
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbjJ0Mju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjJ0Mjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:39:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D757BF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698410386; x=1729946386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aHwDiflggT8QAz05/hvgP4SAkEJ7S7lNpOkSMXYalfI=;
  b=iLoUdaWKPJ1RyoG3cItpz8cgO01UzKGbywIfEeijwQaP+99Ltq/mKuxM
   4Jh2nHczLv5spFQStwa6eAX12dn+SSdQ/ZykaDdltFCcpGgKuS17cwfOc
   1LM/Z2YqrLYkhsmM2OBNDRSVSXqNbA1mrNCSJ41INAbO+581tNOGVVenL
   fc+kJOpDHqSCOBBEE2SoOBQ2CkTnDy23pmjSQkWhfAGlJIQhfpjrvC3Q3
   8y/8hAE7cKazMOSW9YJhzhj1UnOxk08rE234yeHkzWfTd8c34ZzN+J+kb
   5NS/lH9l/yveSC5ob8gg8SDrQ1JluIv+dfpMvkWEb7Ubi3g89pUS2yO0g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="387582307"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="387582307"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="903264203"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="903264203"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:37:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qwM7q-000000098v6-45IR;
        Fri, 27 Oct 2023 15:39:42 +0300
Date:   Fri, 27 Oct 2023 15:39:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     timestamp@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] hte: Use kasprintf() instead of fixed buffer
 formatting
Message-ID: <ZTuvjqYXxWPyHrVR@smile.fi.intel.com>
References: <20231010141123.3909596-1-andriy.shevchenko@linux.intel.com>
 <59939570-3779-ef90-2a72-7be32a30e368@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59939570-3779-ef90-2a72-7be32a30e368@nvidia.com>
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

On Tue, Oct 10, 2023 at 09:12:09AM -0700, Dipen Patel wrote:
> On 10/10/23 7:11 AM, Andy Shevchenko wrote:
> > Improve readability and maintainability by replacing a hardcoded string
> > allocation and formatting by the use of the kasprintf() helper.

...

> >  	hte_ts_dbgfs_init(desc->attr.name == NULL ?
> >  			  ei->line_name : desc->attr.name, ei);
> Reviewed-by: Dipen Patel <dipenp@nvidia.com>

Thanks!

Who is the maintainer of this code?
If not you, shouldn't MAINTAINERS to be updated to reflect that?

-- 
With Best Regards,
Andy Shevchenko


