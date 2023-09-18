Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF097A4E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjIRQGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjIRQGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:06:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6AF59E9;
        Mon, 18 Sep 2023 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695053122; x=1726589122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=36ZoeI4JATTxUu58/EmbUXilx1kaoL3X8sS0u1tY6A4=;
  b=g3yQIehzK+AafYEJNffd72OUxtt6qub0iczzpKaqqFAraH0SnHo65gac
   7U5y72ReymMzWN72uRsMf+gvMH5cwDVxwXEsP74u9Qwx35kPPhc7y2dhx
   5GAl0baIexIJWmVVzNGNIQlDuKbom9V5B8KDTHGAzZMVMClTk17wUcXeM
   tOq0AeRo/FhyJhqHGp28qw8T2D8kf1oXYKhrZ2hUTCUM/TM8nMaipSA7A
   4+23tcMfEfS39fL4LWWJcQU7yTkCgSTJu+xx8nn+Qe+fm7e0QZ08Ib47E
   MrZy1Kt1u6s7sqUwuKIDOncK29nsviU+Y5XmL4bmmqV+Vp6mpc4phHZIg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="382420464"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="382420464"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 07:38:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="836049612"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="836049612"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 07:38:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qiFOi-0000000AvwP-2iIj;
        Mon, 18 Sep 2023 17:38:48 +0300
Date:   Mon, 18 Sep 2023 17:38:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, Joe Perches <joe@perches.com>
Cc:     Mark Pearson <mpearson-lenovo@squebb.ca>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: think-lmi: Add bulk save feature
Message-ID: <ZQhg+Hcv4QHGJ3+s@smile.fi.intel.com>
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

> >> +/* There are a limit on the number of WMI operations you can do if you use
> >> + * the default implementation of saving on every set. This is due to a
> >> + * limitation in EFI variable space used.
> >> + * Have a 'bulk save' mode where you can manually trigger the save, and can
> >> + * therefore set unlimited variables - for users that need it.
> >> + */
> > 
> > /*
> >  * This is wrong multi-line comment style. This one
> >  * is used solely in net subsystem.
> >  */
> 
> Good catch, Mark can you fix this one too please ?
> 
> Also I thought that checkpatch.pl used to catch this ?

I don't think it recognizes "net style is only for net related files".

-- 
With Best Regards,
Andy Shevchenko


