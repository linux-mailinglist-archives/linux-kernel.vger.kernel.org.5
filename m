Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DCD75C495
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjGUKYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjGUKXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:23:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0952111;
        Fri, 21 Jul 2023 03:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689934968; x=1721470968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=derG0ivFUHLq35EytOjB2Wu+2bFsxhB9mi6RKe1vViA=;
  b=Qs+mz6k7frqhISqnk+j0exJdenVmRk4L5vI5LrPOjJT7iGpX6hAqbDXh
   O675LszYXzgX7xqsGotDSuKjIDIhBxrV+p8vQCzYGmgGNr5bsAgxPO3G/
   5EZ2x0+cK5Gp1hJy7W1lxo7mwjwDKRb9+uNXUew5tE2s67DOLOaH/J2qU
   zvHm9WuDLa6GFBkiME1NnaM24+871TuPxsKouIKyHdewXEO0pX0UvJmu2
   VjO4JXVNFrc9r9S9rWcaVHPCqqUdLPT+2bCGlq7igmrd38pzC4Tp4Ae0g
   OvEK5MB2W6XHv4GVAP+H9E7hnr+ueZMjoYvGEdMmGw8ElcZ+KUKduTPxW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="367027297"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="367027297"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:22:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="794917469"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="794917469"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jul 2023 03:22:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMnHP-00HQtw-2v;
        Fri, 21 Jul 2023 13:22:35 +0300
Date:   Fri, 21 Jul 2023 13:22:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kstrtox: Remove strtobool()
Message-ID: <ZLpca1bjEFP1qKnR@smile.fi.intel.com>
References: <23d2ea6b90579207e87cc1bf64fc4eed1ed9f173.1689885328.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23d2ea6b90579207e87cc1bf64fc4eed1ed9f173.1689885328.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 10:40:35PM +0200, Christophe JAILLET wrote:
> The conversion from strtobool() to kstrtobool() is completed.
> So strtobool() can now be removed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Unless I missed something, the last strtobool() calls have been removed
> from -next just 1 or 2 days ago.
> 
> So it is maybe good to wait a few days or weeks to apply this patch in
> order not to break something somewhere.
> 
> For now, see if build-bots agree with me :)

> get_maintainer.pl is of now help here, so adding just Andrew Morton, and
> Andy Shevchenko (who splitted out this file from kernel.h)

Kees Cook from recent times.

As this is about Linux Next, you need to talk to Torvalds to apply this before
v6.6-rc1.

Code wise it's good, feel free to add:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


