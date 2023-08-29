Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FF978C7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbjH2Ors (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbjH2Or0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:47:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BF91B1;
        Tue, 29 Aug 2023 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693320442; x=1724856442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W2PAj4Nq9u5m/ykfQgfSOCn3lZd4raKP/twwT0UGnto=;
  b=lehfOiCsvTtsHBbAa3wbD0nU8uXTvJPcRBMaJgdCBF6DTFCwiJZejfRs
   ma1MJJU43dVQ9yz9w75hFg2s6gtVha1AM2px5FsCfqWRzH2Lrya5C7EZs
   xJho1Eq16FT4SFJKZpoSVohJcCs5vjWOAu1DPAYgI3U1Du+YclhNs5scC
   ewbQowPDbwKJ71ieH64zK9DpBGG396XVsp4kFlG9Mb/uUUUO8ErIqYvWW
   FirLE0H/gB3LbM0geHg+ldf8t49tFXctMYDmRNm050j+9F1l/eZ9woR4A
   6LrTcWIC3g9PJsgzHna4eG985foQ+tPjNZkHujryMWW6oKuInSLCwOsvA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406379438"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="406379438"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="773711117"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="773711117"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 29 Aug 2023 07:47:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qazzw-004uDw-1i;
        Tue, 29 Aug 2023 17:47:16 +0300
Date:   Tue, 29 Aug 2023 17:47:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mfd: palmas: Constify .data in OF table and
 {palmas,tps65917}_irq_chip
Message-ID: <ZO4E9MoARF3IMtvH@smile.fi.intel.com>
References: <20230828153144.75479-1-biju.das.jz@bp.renesas.com>
 <20230828153144.75479-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828153144.75479-2-biju.das.jz@bp.renesas.com>
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

On Mon, Aug 28, 2023 at 04:31:43PM +0100, Biju Das wrote:
> Constify .data in OF table and {palmas,tps65917}_irq_chip and replace
> the variable *features->features in struct palmas_driver_data and
> drop the {palmas,tps659038}_features variables and use their values
> directly in the named initialization.

> While at it, drop the inner leading commas for OF match table.

s/leading/trailing/

-- 
With Best Regards,
Andy Shevchenko


