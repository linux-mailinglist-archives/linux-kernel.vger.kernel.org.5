Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2965A78C869
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbjH2PPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbjH2PPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:15:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF6DB5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693322132; x=1724858132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oIC4RwFeSOKo07zWbQaQErpFWbvvLbrtdeOJ2hsfByY=;
  b=LV57ekd+iFR5ClM8TKxA3BRmOfzaTQ3d9/ArhCmHsf7YZNd8YuBN6cRD
   zX/SiNhX3qZg+4L8o+BpIpfCt2fvkNwpnn2XoyZDRDZxQJMbrn77iJ/9s
   UaRvLJ0exN4yyJh+rusRWAcjV2w3bzYod7GQPiImci5WUj+jaOPj8M3eR
   fRsAyS+9Sz71ATTcULorY0vN0RHhN9DQj61G33UIVicg7iB7cPOBOcH14
   y8x9tXaoqSjCO0imkfHxbwwyOD/4VR4aN8PxYNF2sGpKyZoVciqohtfyW
   RelsDJO3dwz8aW6hKUg2C70lJW/sMmG5PxA56FlPjYB4xrexTcZ2gNtkJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="378113388"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="378113388"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 08:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="732239206"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="732239206"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2023 08:12:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb0Nz-004uZx-1Q;
        Tue, 29 Aug 2023 18:12:07 +0300
Date:   Tue, 29 Aug 2023 18:12:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] regulator: pv880x0: Simplify probe()
Message-ID: <ZO4KxysqxRGxTk2r@smile.fi.intel.com>
References: <20230828172417.113631-1-biju.das.jz@bp.renesas.com>
 <20230828172417.113631-2-biju.das.jz@bp.renesas.com>
 <ZO4KqF+gnJDlWvRB@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO4KqF+gnJDlWvRB@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 06:11:36PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 28, 2023 at 06:24:16PM +0100, Biju Das wrote:

...

> > +#ifdef CONFIG_OF
> 
> Do you still need this? (Perhaps in a separate patch to remove?)

Ah, it's a second in the series!

-- 
With Best Regards,
Andy Shevchenko


