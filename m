Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E0F78C86B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbjH2PQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237249AbjH2PQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:16:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109E21BF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693322181; x=1724858181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dj/X19mt/INKNFcTCT0DezDM5sIxT3sXw/vlFP3g85w=;
  b=iBS0IghZ33vU88TPXrPBKAkNkg7ERhiMBP3BemKNu6nmGB26xBdBJP+n
   rFzj1fv2GWJYneq5UblDJihKTOePmlaiR2o2EorZk40eYPzHfLrQlHI/A
   /ykh2d5aXlcda7tTR3YqT7qnhVtIf2KW0iVd8PpzSMgF0sPLoYxqiYxxN
   0orIrm/Ym4h7ZSIpMsTMavfUGly2W6GfoVDDrGyHKPDeskVvVc3e4HzuU
   z3ZoTAOIPJUHnsHf/MGT50afK6RiWK3dBg8G1/GPB5tsxK0kHBYb6gGXm
   gX0yD3FsYeKOhAsFWpYAtDrV8QUYfh5ZjvOFpq9Msg7aO9C8eQPpQt6XH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="374291577"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="374291577"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 08:11:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="1069497598"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="1069497598"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2023 08:11:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb0NU-004uZa-17;
        Tue, 29 Aug 2023 18:11:36 +0300
Date:   Tue, 29 Aug 2023 18:11:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] regulator: pv880x0: Simplify probe()
Message-ID: <ZO4KqF+gnJDlWvRB@smile.fi.intel.com>
References: <20230828172417.113631-1-biju.das.jz@bp.renesas.com>
 <20230828172417.113631-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828172417.113631-2-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 06:24:16PM +0100, Biju Das wrote:
> Replace pv88080_types->pv88080_compatible_regmap in OF/ID tables and
> simplify the probe() by replacing of_match_node() and ID lookup for
> retrieving match data by i2c_get_match_data(). After this there is
> no user of enum pv88080_types. So drop it.
> 
> While at it, remove trailing comma in the terminator entry for OF/ID
> tables.

...

> +#ifdef CONFIG_OF

Do you still need this? (Perhaps in a separate patch to remove?)

...

> +static const struct of_device_id pv88080_dt_ids[] = {
> +	{ .compatible = "pvs,pv88080",    .data = &pv88080_aa_regs },
> +	{ .compatible = "pvs,pv88080-aa", .data = &pv88080_aa_regs  },

One space too many.

> +	{ .compatible = "pvs,pv88080-ba", .data = &pv88080_ba_regs },
> +	{}
> +};

-- 
With Best Regards,
Andy Shevchenko


