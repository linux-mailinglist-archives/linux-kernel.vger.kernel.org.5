Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5A178C813
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbjH2OyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbjH2OyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:54:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AA21B7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693320827; x=1724856827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PJSIDiJhgB15vSoASO3krRbwLAL+6ge2jHlCYQ+x1+s=;
  b=IKbw6AJDJmNaYfuEIbkVDem43Mir56F275LEJpyyC1qEZE1g7Z/xwNBd
   TevGgkW1x1f6wxvOXczC3PaI3yO3vC91lp4xhZTQtHJFcvyy1lr31pl/B
   evTm7oaXX7abT6V3ZbIcuw0av+zbAy6TSOTIUouA1Ri3hNUeQ+/T3idE7
   zsNWCzngd2hcF5weiyNChAQlZuSuqcwOr/lqvRcDfATB6Kaqv+o9p+TDX
   u5bIgEB8+Tq6kQyGru/epTPokPWFwVQZm9nD9HKNp38yJ+KPSRMqStB/Y
   bf+KTHvkaQsG1w5RcGxreVyneb3Hs04nUz2jnkzublGLol01ay8FjvXTi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="372798869"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="372798869"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:53:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="738739886"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="738739886"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2023 07:53:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb068-004uJy-1z;
        Tue, 29 Aug 2023 17:53:40 +0300
Date:   Tue, 29 Aug 2023 17:53:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lee Jones <lee@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] mfd: arizona-i2c: Simplify probe()
Message-ID: <ZO4GdBbXfY54hgVb@smile.fi.intel.com>
References: <20230828155617.87068-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828155617.87068-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 04:56:17PM +0100, Biju Das wrote:
> Simplify probe() by replacing device_get_match_data() and ID lookup for
> retrieving match data by i2c_get_match_data().

...

> +	type = (unsigned long)i2c_get_match_data(i2c);

uintptr_t ?

-- 
With Best Regards,
Andy Shevchenko


