Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6BB78C870
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbjH2PSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbjH2PRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:17:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D953194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693322266; x=1724858266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+bPeYj88gtPAEI6E/PIIKCqQBhsiIxznUBGyOV4wiTU=;
  b=V9LEg7GEdHdfQQ74hvUz9oyeK2Gk1i8LwSOPEdHEvirQ2aRC4A//su7h
   OQRv5uvMB2WW6ARNJsaYwXPK86bnYLX6gkjtvcqPcS+0TtVH7zQOilQsX
   YTjOLPKKMjw52odf38xuNkhp2jA7Vosc771dOVQ2tbE5lre3p0jnT8Hgu
   Z51MPlr7j5In/Y5/OgYuVI9NL7IYorAd8PIalyIGQibfwOOHukcLAocg8
   isN0AWGZkqQ9/Ga0Y9aEfdnFsE4+cogirMyjQyciyHX1kEsO0eyPNRQIg
   cOCs5TnhGpf39O71KdwV7pTmbLH4TrXyRbb0ei+cVLKwnE6IcjTmts98T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="365603735"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="365603735"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 08:15:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="773716704"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="773716704"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 29 Aug 2023 08:15:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb0RK-004uce-0v;
        Tue, 29 Aug 2023 18:15:34 +0300
Date:   Tue, 29 Aug 2023 18:15:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] regulator: pv880x0: Drop CONFIG_OF ifdeffery
Message-ID: <ZO4LlmaNIaIdYbwh@smile.fi.intel.com>
References: <20230828172417.113631-1-biju.das.jz@bp.renesas.com>
 <20230828172417.113631-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828172417.113631-3-biju.das.jz@bp.renesas.com>
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

On Mon, Aug 28, 2023 at 06:24:17PM +0100, Biju Das wrote:
> Get rid of ugly CONFIG_OF ifdeffery by adding mod_devicetable.h include.

Commit message needs to be improved.
Inclusion of that header doesn't allow to do what you have done.
Dropping of_match_ptr() does. And you need to explain that leaving
OF table for non-OF system is fine and doesn't waste too much memory
anyway. Look for the existing changes like this in the kernel history
(`git log --no-merges --grep ...` at your service).

-- 
With Best Regards,
Andy Shevchenko


