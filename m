Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98681777B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjHJOsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjHJOsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:48:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B38A2106;
        Thu, 10 Aug 2023 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691678921; x=1723214921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XK5sa90zsGSSN9wGkHZ/mNjWAnNcdml9adYZrQUo6a0=;
  b=QpdCoJlEyE9pMh+gS9BWYcVQn/gqjZVrNBGkp6PmP/zBy5pkIogej8A6
   Kw8gG1u+3iG1ULcqR0EptK1Qf9cgt14DW+FcTPLgr7D0OmzfvIdCxAWt2
   5IiqiQGkyGJ2iZJmGvp4DDZDipX1GImaPoBJMv2XQFaeo7ktC9AlTTEqc
   bVTzNqdhX/a8z1mLal27nC2Mfqps5l/kfmKg3NA4hT212iT4yo8OVk/qL
   YLXVMusCEesbXt8yO1Zu/GtAQ420NvOZMH0/xwJdjQtiLaIq51gB+J4y9
   paTXzjydmNJRJvupGJ8tOMZwXZFjisqdbgPnfG2E2dXlQcC2m4DItWbnF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="374191982"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="374191982"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 07:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="682146600"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="682146600"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 10 Aug 2023 07:48:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU6xp-005VjK-19;
        Thu, 10 Aug 2023 17:48:37 +0300
Date:   Thu, 10 Aug 2023 17:48:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH RFC] Introduce uniptr_t as a generic "universal" pointer
Message-ID: <ZNT4xQ40gt+Vg4hs@smile.fi.intel.com>
References: <87edkce118.wl-tiwai@suse.de>
 <20230809143801.GA693@lst.de>
 <CAHk-=wiyWOaPtOJ1PTdERswXV9m7W_UkPV-HE0kbpr48mbnrEA@mail.gmail.com>
 <87wmy4ciap.wl-tiwai@suse.de>
 <CAHk-=wh-mUL6mp4chAc6E_UjwpPLyCPRCJK+iB4ZMD2BqjwGHA@mail.gmail.com>
 <87o7jgccm9.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7jgccm9.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 08:08:30PM +0200, Takashi Iwai wrote:
> On Wed, 09 Aug 2023 19:01:50 +0200,
> Linus Torvalds wrote:
> > On Wed, 9 Aug 2023 at 09:05, Takashi Iwai <tiwai@suse.de> wrote:

...

> > Please? At least look into it.
> 
> All sounds convincing, I'll take a look tomorrow.  Thanks!

Nice discussion happened while I was sleeping / busy with some personal stuff.
Thank you, Linus, for all insights, it's educational.

-- 
With Best Regards,
Andy Shevchenko


