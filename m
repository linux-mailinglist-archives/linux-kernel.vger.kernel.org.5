Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388167A4CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjIRPki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRPkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:40:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AF5272A;
        Mon, 18 Sep 2023 08:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695051627; x=1726587627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UJy+Gr8DwxN6Yt79AOixDnkfqZv5y9oXSAuQ2/xs+a4=;
  b=fHsmKqPjcf6ZIhdHGgLkY5QxY12iXb/ZzZ9Rd7y/FahX0o+nAHZCDmYi
   Yj+iDsV/duUeSJr8vDId7cGADF6DRVeK86+3voByUTXMPAH2r6txXF2gX
   TKm8MtSprom4KxKDwO1mCU1igH6xvcHhu9hlAzVanDYHIyf/lJx3nrQYm
   cGCQrlN1PhX5W+h/uk57n9euzlnU0s5rlDTUybnwFr5eOr+vJNfbaRCpO
   1Lg7D1eu13SgqrD1YWLZU2mfNj63P4VmeOn6x7Dxcq6EEUNfPMlVMrxdd
   VH7/iwn4FKSv3I5luyAPr6WUNOMGlyE3lrz7fvZcUmS9WKfCDryFe7X0P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="376969087"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="376969087"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:50:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="889062962"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="889062962"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:49:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qiEdd-00000009Lhi-1iQG;
        Mon, 18 Sep 2023 16:50:09 +0300
Date:   Mon, 18 Sep 2023 16:50:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Pearson <mpearson-lenovo@squebb.ca>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 1/2] platform/x86: think-lmi: Replace kstrdup() +
 strreplace() with kstrdup_and_replace()
Message-ID: <ZQhVkb9XYvjd7GlJ@smile.fi.intel.com>
References: <20230913092701.440959-1-andriy.shevchenko@linux.intel.com>
 <77bde3cf-ca94-1cdb-53d8-39df22f8c551@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77bde3cf-ca94-1cdb-53d8-39df22f8c551@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 02:30:28PM +0200, Hans de Goede wrote:
> On 9/13/23 11:27, Andy Shevchenko wrote:
> > Replace open coded functionalify of kstrdup_and_replace() with a call.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thank you for the patches, but this one does not apply
> cleanly.

`git am -C1 ...` works for me.

> Can you please rebase the series on top of my latest review-hans branch ?

But fine, no problem, I'm about to send a v2,

-- 
With Best Regards,
Andy Shevchenko


