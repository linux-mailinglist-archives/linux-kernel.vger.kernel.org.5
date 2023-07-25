Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7702D761992
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjGYNQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjGYNQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:16:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB491BF8;
        Tue, 25 Jul 2023 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690290994; x=1721826994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FzQltc/Yqt8LVzDvpBtr1I2HWq5tm4lFYF5Dmo6gkcM=;
  b=RR8dKq8UlyS9r+ciPT8bV1kgn3H5mCPJBFXd3RSorqoZTvotwCKQ65gH
   9nDnpH9TQG816jdi1BIiIt4fP64QaTTqSIckYDkTVQstBDBFBd+ZYJwo9
   XnPWvFvz8RT5tzQum6yZlhzBnQrgOtRFDlEUFRR66Ty04SfzvGcxgfusA
   LXMCHfr6ISbLeIMZqqqXUA7wlxiPemc2YE0uEGtz8bv2zEABu2Nz5+6Oo
   T5a7uQlQjXb6XDCtfTUfOaZOM0cT+0HdQz0Vz174N1P338Vkhk9tQCtdl
   /NqzKvOIP+r/+MFm7/QwzhyWah68kCYpQ8vZHBHxa8ssqozXJ9LQ8yAqR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="431520718"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="431520718"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 06:16:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="720059655"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="720059655"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 25 Jul 2023 06:16:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOHto-00B2DC-37;
        Tue, 25 Jul 2023 16:16:24 +0300
Date:   Tue, 25 Jul 2023 16:16:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/1] Documentation: core-api: Drop :export: for
 int_log.h
Message-ID: <ZL/LKPmDvfUdZWb+@smile.fi.intel.com>
References: <20230725104956.47806-1-andriy.shevchenko@linux.intel.com>
 <87a5vkb0ee.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5vkb0ee.fsf@meer.lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 07:12:25AM -0600, Jonathan Corbet wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> > ---
> > v2: added tags (Randy, Jonathan), assumed to go via ASoC tree

> So I still can't take this patch for the reasons described before.  It
> looks like Mark took the patch that added the problem, so perhaps he
> should be a recipient of this one too? 

That's what have been assumed above.

> I'll add him to the CC...

Oh, I missed Cc'ing him...

-- 
With Best Regards,
Andy Shevchenko


