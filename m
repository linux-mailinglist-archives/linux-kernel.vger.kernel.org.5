Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74245752110
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjGMMTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbjGMMTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:19:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B8826B5;
        Thu, 13 Jul 2023 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689250749; x=1720786749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yWZlIGF86AoSbSeZCQ313Q5kPpd7c+4YEC9Hig1jsYk=;
  b=RSftoQOnHSvYD+GamHoWI6eR7I2kAHl25mv/MHfAI4uRIhNCF/nkXbn5
   Y8bBnc31KQpfSLYmvZJB5hE48GIOi+hZi/cZkp3ZqzB2WL0bBkW+MmjPI
   5QJiwGZ3YYHss279i0OktP7zdrYQrgn27AeEqE4TY2NGTddk3XQX4WQfB
   dC3yoX+pa1UjunGBxwsl+B59AdOpN4vDdBwV9CQaveQCLjB/raUfn2WKj
   IQVS8AG+bDg4TGz6PuHds/D0hFyKUNgP0q0WmSDE9xq3sPTHAzdji8U4D
   Pgno5dynnQC9h7Y1ghaIQx6TGD8UJFeEuw/2LiLRjDCetnX7FueBiewjl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="364034721"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="364034721"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 05:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="751611057"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="751611057"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 13 Jul 2023 05:19:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJvHk-002OS7-2A;
        Thu, 13 Jul 2023 15:19:04 +0300
Date:   Thu, 13 Jul 2023 15:19:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <ZK/ruOD4QFPQ3Q5q@smile.fi.intel.com>
References: <20230713121627.17990c86@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713121627.17990c86@canb.auug.org.au>
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

On Thu, Jul 13, 2023 at 12:16:27PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the sound-asoc tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> include/linux/int_log.h:1: warning: no structured comments found
> 
> Introduced by commit
> 
>   f97fa3dcb2db ("lib/math: Move dvb_math.c into lib/math/int_log.c")

Can you elaborate a bit, please?

Seems to me to be a false positive, or unveils a bug somewhere else.

-- 
With Best Regards,
Andy Shevchenko


