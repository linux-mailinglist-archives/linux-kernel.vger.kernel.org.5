Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EA3752169
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjGMMlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjGMMlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:41:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5C32689;
        Thu, 13 Jul 2023 05:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689252073; x=1720788073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=719nGNaqp2z062TRFXHa8IQYLeAfHCSr2qHTTczVNeU=;
  b=YCktluaXtzQDQ+I2In62uJCgJmR9qfP+8Yz5ygAOZ0E0luKqd+A2Xvvj
   gEfnHl1J4DdAFFywhoOalROosHK0576YrSgVi6dgUYuSck8/puLiTdANo
   A+yje+UGdWwCKYWDxj3nbQrbVby9U9ENZuzNwcCHywn/UEvQUF3NoJF0c
   hsERU7Ul+JqyhvjQLGczkIQH+8XHB1/Gn34rgLn++qKviD/fW8BGbvZKh
   4hYcD5faVY8iuduqKQYIP9TVaat+hoe5q2heBy45TModgfGtnKz1aQ6sT
   XJONQE2Rgg3FyoEFHP79jF5ynwSw3WGfSo6GoZW0LNBgYVnb8/swT83xc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="431320394"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="431320394"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 05:41:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="895987146"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="895987146"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2023 05:41:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJvd7-002OgD-0G;
        Thu, 13 Jul 2023 15:41:09 +0300
Date:   Thu, 13 Jul 2023 15:41:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <ZK/w5LFanElxZazG@smile.fi.intel.com>
References: <20230713121627.17990c86@canb.auug.org.au>
 <ZK/ruOD4QFPQ3Q5q@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK/ruOD4QFPQ3Q5q@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 03:19:04PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 13, 2023 at 12:16:27PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the sound-asoc tree, today's linux-next build (htmldocs)
> > produced this warning:
> > 
> > include/linux/int_log.h:1: warning: no structured comments found
> > 
> > Introduced by commit
> > 
> >   f97fa3dcb2db ("lib/math: Move dvb_math.c into lib/math/int_log.c")
> 
> Can you elaborate a bit, please?
> 
> Seems to me to be a false positive, or unveils a bug somewhere else.

Ah, now I understand. There is a header file that has descriptions but
EXPORT_SYMBOL. We have to drop keyword export from the index.

Thank you for the report, I'll cook the patch ASAP.

-- 
With Best Regards,
Andy Shevchenko


