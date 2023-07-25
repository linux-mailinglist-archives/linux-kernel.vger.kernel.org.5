Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20371761C12
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjGYOmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjGYOml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:42:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446BCE51;
        Tue, 25 Jul 2023 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690296160; x=1721832160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BxmoiYkf/4mBJrfAXlvBlg7ie0alDwfIBXTfXdM8EWk=;
  b=Cu0zBkyvFFmftAtn0ufshPbqpHzYgrQSgEWHp7eZSx5bol5HWtERfvcX
   BFd2Dwigf/b0QBhxQkyw9OEHnQDXVbFFJxJqKAxWbCTelDi2l94uDhvy+
   PNyxP8668O2L4C49VtiS/xxNEwDx9BOdWDxExPKBasldRuDCM2cY75ACc
   IO5LSYXdsgToQDnfaY2vZb+KGJzdlgfcRsWd01N/rtX2c2nLAZggXDAdU
   rYRNz0sIg9e8tN/+OWZvQN2xcEbPjpTLNX6ZdwLPkegd6HJ/eLbmktcGG
   7kS5vJ7e3jS2wepSe7zbynN5v7XFhJXOk3FMtuz6Uu8xxJ+JX54W4BSU0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="357747050"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="357747050"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 07:41:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="869498358"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2023 07:40:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOJDa-00DymC-2A;
        Tue, 25 Jul 2023 17:40:54 +0300
Date:   Tue, 25 Jul 2023 17:40:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/1] Documentation: core-api: Drop :export: for
 int_log.h
Message-ID: <ZL/e9oguxJ8+nht/@smile.fi.intel.com>
References: <20230725104956.47806-1-andriy.shevchenko@linux.intel.com>
 <87a5vkb0ee.fsf@meer.lwn.net>
 <b761d010-ef21-4be6-b6c3-678498b7fa71@sirena.org.uk>
 <ZL/W5rc043oPLfMV@smile.fi.intel.com>
 <29369f0b-732d-4d20-9afa-0918dba0f512@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29369f0b-732d-4d20-9afa-0918dba0f512@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 03:27:58PM +0100, Mark Brown wrote:
> On Tue, Jul 25, 2023 at 05:06:30PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 25, 2023 at 02:46:33PM +0100, Mark Brown wrote:
> 
> > > Is this the same patch I applied yesterday or a different one?
> 
> > Hmm...
> > I do not see anything like this patch in your current ASoC for-next
> > (nor in for-6.6). Did I look into wrong branch?
> 
> There was some random patch you just sent me the message ID for in the
> replies to something from Stephen which I'm fairly sure I queued,
> perhaps it was a different thing or git thought it was a noop when it
> was applied?

The first version is here [1].
Then it was a discussion about Linux Next build issues [2].

In the discussion I mentioned:

  The 20230713165320.14199-1-andriy.shevchenko@linux.intel.com had been sent.

which is exactly what [1] is.

I have no idea how it can be a noop, but the patch is missing as far
as I can tell.

This thread is v2 of what was in [1].

[1]: https://lore.kernel.org/linux-doc/20230713165320.14199-1-andriy.shevchenko@linux.intel.com/
[2]: https://lore.kernel.org/linux-next/20230713121627.17990c86@canb.auug.org.au/T/#u


-- 
With Best Regards,
Andy Shevchenko


