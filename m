Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538227A4DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjIRQBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIRQBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:01:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A071721;
        Mon, 18 Sep 2023 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695052617; x=1726588617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zIzeB2BdT2vjYKtzNJ2hkECCW7d4ci7KzVMVss7VAyM=;
  b=J+ovU/s9kqYrZGIE1v+QMOUe/fuXR/L+YkfbaXyYOjeIi5jTTlgjTtwM
   Z1Og0YDaYQv1QAKbxs/ajAKC8nf8UJpBZZhsw4quR48xwVKnc5NehJ07L
   ihMErDUW2hx1JPhyRgUvtlLDkwznsm4nP92XWeIW42Ohnf1YqI0fHTkI2
   cLLF0lIgknP5wxStGSGFzIS87rgCJKaj47gMMCUmCY5Z4/giobFK+qvGl
   pv+prBImAa65msx/IRjKpE9l4Y+OiYvCQl75gKnXwFuAWCTRRoAa8hHSk
   cPneKiuRApXyhWjbtuslf/SOxaKWm2/osO3RsrvhUWKEcHR7cbAIfQyM0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="466020665"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="466020665"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 07:40:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="1076611132"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="1076611132"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 07:39:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qiFPp-0000000AyGm-0Mzp;
        Mon, 18 Sep 2023 17:39:57 +0300
Date:   Mon, 18 Sep 2023 17:39:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Pearson <mpearson-lenovo@squebb.ca>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: think-lmi: Add bulk save feature
Message-ID: <ZQhhPJsQapKkY39v@smile.fi.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20230906121328.50437-1-mpearson-lenovo@squebb.ca>
 <ZQhXZkBHviGOEl-x@smile.fi.intel.com>
 <878da778-e183-6ef5-61ce-3a3d059f1a1e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878da778-e183-6ef5-61ce-3a3d059f1a1e@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 04:07:53PM +0200, Hans de Goede wrote:
> On 9/18/23 15:57, Andy Shevchenko wrote:
> > On Wed, Sep 06, 2023 at 08:13:14AM -0400, Mark Pearson wrote:

...

> >> +static const char * const save_mode_strings[] = {
> >> +	[TLMI_SAVE_SINGLE] = "single",
> >> +	[TLMI_SAVE_BULK] = "bulk",
> >> +	[TLMI_SAVE_SAVE] = "save"
> > 
> > Missing comma.
> 
> Fixing this retro-actively is not really useful, if we
> ever need an extra entry we can deal with the churn then.

I agree, but this is to give a comprehensive review as long as I went through
the entire change.

> >> +};

-- 
With Best Regards,
Andy Shevchenko


