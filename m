Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3BD78C7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbjH2Ovb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbjH2OvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:51:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A524CE1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693320664; x=1724856664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RQ28NKoayiwCnTpcUm+OcpRMal63nFByHboDhO/nMaY=;
  b=DtlXG0YMXLxVEGnZPYi7WvsMAszwMreTkb3XT/r2VJBWzyuzfg9bG/ar
   JO0XRk/n8/Hftm+3ITZT3qjEs0h9Pvaj5OxGzq/RGqh4xXauJfK/a74k+
   MLp+RK2rX0D8OL7oLyPUO89/GKoxp6y6bMzFIQ9DP8w9GhuvVml+6Tk2o
   H6r5xSgQLwzXpUaTHSKetGs/VTjBNkpxRBjaLyQgtB90Yu5xy++jVj/uS
   Onmh1SDPalFbol/08ZH5BZSTKBl2BEFofsNwXXd01slC0EH569yK8EgiI
   y4qEzpspKJx2Xm4a505wta0r6YEV8vfRDp6VYnAHOaif2xRwgW9gQ/aza
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406380256"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="406380256"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="773712408"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="773712408"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 29 Aug 2023 07:51:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb03Z-004uH9-1Y;
        Tue, 29 Aug 2023 17:51:01 +0300
Date:   Tue, 29 Aug 2023 17:51:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: max8997: Simplify probe() and drop
 max8997_i2c_get_driver_data()
Message-ID: <ZO4F1XiMIRGvCyTn@smile.fi.intel.com>
References: <20230828160224.92037-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828160224.92037-1-biju.das.jz@bp.renesas.com>
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

On Mon, Aug 28, 2023 at 05:02:24PM +0100, Biju Das wrote:
> Simplify probe() by using i2c_get_match_data() instead of
> max8997_i2c_get_driver_data() for retrieving match data from
> OF/ID tables.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


