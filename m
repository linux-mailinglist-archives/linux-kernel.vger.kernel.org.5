Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8877528F4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbjGMQmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjGMQmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:42:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BD530DA;
        Thu, 13 Jul 2023 09:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689266547; x=1720802547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lPo5Yd9r9keG0po6v1x79UiBwVWcR0uuoRZOH8HjT7E=;
  b=QLUONWm57sK3DH3EK3GSQzReo+9FobZ4iYEbqkXeHDzWXnPSRCJ9odtG
   L4oi6/lU4A3GFj5DedEDw/m+R85hmZ5CuNlm+xhELw32JTIhwH/hJP1xG
   PlotvmehQnLYuwRBv00Dxz4/euie7RD0yLiCm2vkPaAuyEbpZssRzv7IL
   xMLTwVgPqBBmJ6QshQGliMunyhjqzlUQ9+TBNcpUAOLwyVqK/2v3ATv+Y
   OBdgoSt/6406Iid2mQGl/GlJWfqFdC5G12Cydd6LxBMwcg20JoOxVYVBC
   ljKa6Ul99luiBn6uYQhHxBKuZCwo1i72eIXtXmdPh+g6yeM0LVhLg4ziz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429013586"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="429013586"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 09:42:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="672334689"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="672334689"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 13 Jul 2023 09:42:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJzOQ-002RKT-1U;
        Thu, 13 Jul 2023 19:42:14 +0300
Date:   Thu, 13 Jul 2023 19:42:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] platform/x86/intel/tpmi: Add debugfs interface
Message-ID: <ZLApZqPhOpKGNyxI@smile.fi.intel.com>
References: <20230711220949.71881-1-srinivas.pandruvada@linux.intel.com>
 <20230711220949.71881-3-srinivas.pandruvada@linux.intel.com>
 <ZK7DNdlUvUZ5deho@smile.fi.intel.com>
 <befd890f0252f0cec193d3bea379c2e23e62e824.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <befd890f0252f0cec193d3bea379c2e23e62e824.camel@linux.intel.com>
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

On Wed, Jul 12, 2023 at 04:06:50PM -0700, srinivas pandruvada wrote:
> On Wed, 2023-07-12 at 18:13 +0300, Andy Shevchenko wrote:
> > On Tue, Jul 11, 2023 at 03:09:48PM -0700, Srinivas Pandruvada wrote:

...

> > >  struct intel_tpmi_pm_feature {
> > >         struct intel_tpmi_pfs_entry pfs_header;
> > >         unsigned int vsec_offset;
> > > +       struct intel_vsec_device *vsec_dev;
> > 
> > Hmm... I don't know the layout of pfs_header, but this may be 4 bytes
> > less
> > if you move it upper.
> The pfs_header is packed with size of 64 bit. So size will not change.

So, it will be a gap of 4 bytes due to alignment, no?

> > >  };

...

> > > +       for (i = 0; i < tpmi_info->feature_count; ++i) {
> > 
> > Why preincrement?
> Does it matter for a "for" loop increment?

Stylewise. Preincrement raises a flag to the reader "what the heck is special
here that we need preincrement". If not required, I would use postincrement.

-- 
With Best Regards,
Andy Shevchenko


