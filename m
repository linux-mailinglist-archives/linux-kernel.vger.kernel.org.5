Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A576D7A4E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjIRQIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjIRQH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:07:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360AA4C01;
        Mon, 18 Sep 2023 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695053156; x=1726589156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zfxh6xGoJ87Sh7tABUQTQr3Sju0eUbicnGbi8Y0sZAM=;
  b=NhVq+IrBigxeAl+8P/zohqPN8r26guu/hUyO16Xsf5t/L1PU+q/Ft6i/
   2HiCfAEHyH01FsITBzxNiPZvSB+mdy4ghnpN88lwgSmQNrKHVKD0FPXog
   N0qGNK2WPbxBh1lcbwVHn8hBuZBP9Qce7Q7O5sCPCZBpF9jGQITwRO+Pn
   t0Dgj773yd0wqsDxLe9JILN1cjBsNHiFVRkOG5RT5hUOXrJL8SPGMxqhG
   Lnj0pZwJPUEEimpbooETvs4O2f9wjirG+0tVSrDFBLbGuMvLiGU/QaOCH
   CxsClrTcMCVl6uaxnPDGZ+cIdZkKT/KmsXugBTmxzVKqzQSsMyaN7QGzo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="443735192"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="443735192"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 07:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="811365257"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="811365257"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 07:00:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qiEnK-00000009fzT-0gvO;
        Mon, 18 Sep 2023 17:00:10 +0300
Date:   Mon, 18 Sep 2023 17:00:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>,
        Joe Perches <joe@perches.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: think-lmi: Add bulk save feature
Message-ID: <ZQhX6Ynz-cl1gkNu@smile.fi.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20230906121328.50437-1-mpearson-lenovo@squebb.ca>
 <ZQhXZkBHviGOEl-x@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQhXZkBHviGOEl-x@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 04:57:58PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 06, 2023 at 08:13:14AM -0400, Mark Pearson wrote:

...

> > +Date:		August 2023
> > +KernelVersion:	6.5
> 
> This is obviously incorrect (outdated) information.

Joe, does checkpatch have a hook to test that (using phb-crystal-ball data)?

-- 
With Best Regards,
Andy Shevchenko


