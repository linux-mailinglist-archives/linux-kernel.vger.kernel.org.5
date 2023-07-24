Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F4875ED82
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjGXI1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjGXI1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:27:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD3BE41;
        Mon, 24 Jul 2023 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690187228; x=1721723228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XfAnXp06ahd9oqfPq8Rmm1uh1da4hVuJSMjpEUX/V4M=;
  b=DvDKMedH3oniUgoicHFYhSv7pWDGhKSSaGqWDSozUuw/MR30+TLKwxTF
   BUksB437C9VJGVz7rehrwWT2W8SvQjTrLtYXQpXET3ULygKce9goi/jLm
   0FDpqLW4qqkK09bh107N4z+RibaidEWiiYWmfd7EXHmbrbZJIs2h7APdd
   2CH0TmAB14T5nPh9ccZcMR1ZPO6+/gItiAcrL3YAQi5RuuXZ6De/M8z23
   Xw1OUGuHK8hmg7JQZgQiVFSuTpOfz0CetnEbhUY3RpOCG+qW1Ef1QAgU8
   mfo5Qp8X92bQhnD2y2NXfXl2rJ1WCo/Nv/yR3MxsYKEstbWaqy5ivgM3R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="367406183"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="367406183"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 01:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="728829554"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="728829554"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jul 2023 01:27:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNquA-004NHN-2V;
        Mon, 24 Jul 2023 11:26:58 +0300
Date:   Mon, 24 Jul 2023 11:26:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <ZL410jAw2ksuBx56@smile.fi.intel.com>
References: <20230713121627.17990c86@canb.auug.org.au>
 <ZK/ruOD4QFPQ3Q5q@smile.fi.intel.com>
 <ZK/w5LFanElxZazG@smile.fi.intel.com>
 <ZLES/6iNcmR7H+f7@smile.fi.intel.com>
 <20230724135858.3c1abb01@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724135858.3c1abb01@canb.auug.org.au>
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

On Mon, Jul 24, 2023 at 01:58:58PM +1000, Stephen Rothwell wrote:
> On Fri, 14 Jul 2023 12:18:55 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Jul 13, 2023 at 03:41:09PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jul 13, 2023 at 03:19:04PM +0300, Andy Shevchenko wrote:  
> > > > On Thu, Jul 13, 2023 at 12:16:27PM +1000, Stephen Rothwell wrote:  
> > > > > 
> > > > > After merging the sound-asoc tree, today's linux-next build (htmldocs)
> > > > > produced this warning:
> > > > > 
> > > > > include/linux/int_log.h:1: warning: no structured comments found
> > > > > 
> > > > > Introduced by commit
> > > > > 
> > > > >   f97fa3dcb2db ("lib/math: Move dvb_math.c into lib/math/int_log.c")  
> > > > 
> > > > Can you elaborate a bit, please?
> > > > 
> > > > Seems to me to be a false positive, or unveils a bug somewhere else.  
> > > 
> > > Ah, now I understand. There is a header file that has descriptions but
> > > EXPORT_SYMBOL. We have to drop keyword export from the index.
> > > 
> > > Thank you for the report, I'll cook the patch ASAP.  
> > 
> > The 20230713165320.14199-1-andriy.shevchenko@linux.intel.com had been sent.
> 
> But not yet applied by anyone :-(

Since the culprit went via ASoC tree, I think that tree is the best for the fix.
Mark, can you apply that, please?

-- 
With Best Regards,
Andy Shevchenko


