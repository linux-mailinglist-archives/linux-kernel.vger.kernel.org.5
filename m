Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C6D78C7E5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbjH2Oqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbjH2Oqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:46:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C741A6;
        Tue, 29 Aug 2023 07:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693320391; x=1724856391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QIr6BJEeXYWl1/G59Qm0C6xyhTPqQoRk2a4GFtsPX54=;
  b=nyG07AVHA8SuwmCeimOGM1L7XYEbckkH7/e4c+aMseQdWYVL2KznGCGs
   VGlfaDQIaAhtPpVkhbePABjkTF2Xu0JTGfz1d/IBd3rRhBmYAUXMU6NPi
   PNyHIUywsWvJ6xaQ8V1jS8guZIyk4Q6dxUxzFWR6XnXoFjfwNLn9QFCB4
   58xc8EJydjTzDoxHFLKhvMjI9mUqxkGeZ610VRvB4TZtgUatneQ5TDBAL
   JAYioyA6OFU3NdxN3JbhfwHjkdW4t0UGtJI/kKElvez96F08Bgs9G+vDz
   4cu5jMzCOk2z19vUSt17PaJFfKbr6StcXgvHO9iL8tOcIQWjv9eSy1PBd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406379118"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="406379118"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="985368160"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="985368160"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 29 Aug 2023 07:46:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qazz7-004uDP-14;
        Tue, 29 Aug 2023 17:46:25 +0300
Date:   Tue, 29 Aug 2023 17:46:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: palmas: Make similar OF and ID table
Message-ID: <ZO4EwAgDU0yefC/t@smile.fi.intel.com>
References: <20230828153144.75479-1-biju.das.jz@bp.renesas.com>
 <20230828153144.75479-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828153144.75479-3-biju.das.jz@bp.renesas.com>
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

On Mon, Aug 28, 2023 at 04:31:44PM +0100, Biju Das wrote:
> Make similar OF and ID table to extend support for ID match using
> i2c_match_data(). Currently it works only for OF match tables as the
> driver_data is wrong for ID match.

...

> While at it, drop the inner leading commas for ID  table.

Are you sure?

------------------v
> -	{ "palmas", },
> -	{ "twl6035", },
> -	{ "twl6037", },
> -	{ "tps65913", },
> +	{ "palmas", (kernel_ulong_t)&palmas_data },
> +	{ "twl6035", (kernel_ulong_t)&palmas_data },
> +	{ "twl6037", (kernel_ulong_t)&palmas_data },
> +	{ "tps65913", (kernel_ulong_t)&palmas_data },

-- 
With Best Regards,
Andy Shevchenko


