Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEEF79E5CF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbjIMLKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjIMLKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:10:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA7619A6;
        Wed, 13 Sep 2023 04:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694603428; x=1726139428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uqF9R+6e0mdQgOwFpYVrH+65K7xWTsBoK2ERwBn9lEo=;
  b=DqUL5wJ9hV7rl9CYxi2lVdXWWur+r4l7lxNAc8+5mzcaH6DhhN0T4ST9
   hOgqEf4J3wNBU7XseuaUQhvCld3wXjPBI/Sl4Ax7kbXYVxSHNKd8FCumP
   l0k8zI5d/yS4Eak3hY87ji5Hv6vcfxArjgUeZ7esB9NQ0iQuly/N8CMy8
   SRpenCvCsS+FKuKG4LLCeFT1QjGXk1uNIm6N+MgemBqzxDzf6gK7ruxHZ
   6PqLZqRaNdwGbeFjivYfMc9vi75SmmqTos9lE6i88WIIMhD3F4Uhem9eV
   q/W0f6AJGJTLfi/OrAtNvxFhxXHDbBiqNp1IxjKSaavW+s4/iI7jVVe3R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358899721"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="358899721"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:10:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="809639357"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="809639357"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:10:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qgNlH-008qY6-13;
        Wed, 13 Sep 2023 14:10:23 +0300
Date:   Wed, 13 Sep 2023 14:10:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v1 2/2] net: core: Sort headers alphabetically
Message-ID: <ZQGYnoHt8PAT23A4@smile.fi.intel.com>
References: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
 <20230911154534.4174265-2-andriy.shevchenko@linux.intel.com>
 <20230912152031.GI401982@kernel.org>
 <ZQCTXkZcJLvzNL4F@smile.fi.intel.com>
 <20f57b1309b6df60b08ce71f2d7711fa3d6b6b44.camel@redhat.com>
 <ZQCaMHBHp/Ha29ao@smile.fi.intel.com>
 <32a8715a63b686aa0ac19fdae22b5d605d47ae35.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32a8715a63b686aa0ac19fdae22b5d605d47ae35.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 07:25:48PM +0200, Paolo Abeni wrote:
> On Tue, 2023-09-12 at 20:04 +0300, Andy Shevchenko wrote:
> > On Tue, Sep 12, 2023 at 06:53:23PM +0200, Paolo Abeni wrote:
> > > On Tue, 2023-09-12 at 19:35 +0300, Andy Shevchenko wrote:

...

> > > Please repost the first patch standalone.
> > 
> > Why to repost, what did I miss? It's available via lore, just run
> > 
> >   b4 am -slt -P _ 20230911154534.4174265-1-andriy.shevchenko@linux.intel.com
> > 
> > to get it :-)
> 
> It's fairly better if actions (changes) on patches are taken by the
> submitter: it scales way better, and if the other path take places we
> can be easily flooded with small (but likely increasingly less smaller)
> requests that will soon prevent any other activity from being taken.
> 
> Please, repost the single patch, it would be easier to me.

Done.

-- 
With Best Regards,
Andy Shevchenko


