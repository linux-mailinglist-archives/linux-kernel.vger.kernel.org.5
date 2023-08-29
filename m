Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242E278C7FD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbjH2Ou7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbjH2Oum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:50:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5421619A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693320638; x=1724856638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zcC//sDGEtK62ZCv+cxTzMvtkT2Y1NbBbcKvp/Aggzc=;
  b=Qu019wynwktrVNr00PC/usi2v3y/ljU9WbpYMRtKvI9+IXjYc868PRd4
   iJBY7eCxYpEpoOimIv1wmWhcYfl+xFpZpGB0YMc5W/8CUUnJYI+hQGP22
   5UycLu+/Ap6uwhK0KQNcnZOHU9SMcJf+wLxCF5RvFU7H9j60GVaiH2F8d
   +y4Fq6fYtibCY5vJPOREFfw0HzH8xppp6gRzWhapIdmurg2NUgBqEwLEp
   n+apqZVrE4Jf9jc2WfgRYAeUZKBRvxGNVog9IbW3QTrHfWCF165rM1653
   2CB+pBQU4tcqBxQ5FePVXPf3ITqIWM6lIKj943Lz3hO4gTImMqcuuio1z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406380154"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="406380154"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:50:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="985368758"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="985368758"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 29 Aug 2023 07:50:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb039-004uGp-2H;
        Tue, 29 Aug 2023 17:50:35 +0300
Date:   Tue, 29 Aug 2023 17:50:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: max8998: Simplify probe() and drop
 max8998_i2c_get_driver_data()
Message-ID: <ZO4Fu2SI5I37ivBz@smile.fi.intel.com>
References: <20230828160657.94785-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828160657.94785-1-biju.das.jz@bp.renesas.com>
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

On Mon, Aug 28, 2023 at 05:06:57PM +0100, Biju Das wrote:
> Simplify probe() by using i2c_get_match_data() instead of
> max8998_i2c_get_driver_data() for retrieving match data from
> OF/ID tables.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


