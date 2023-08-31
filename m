Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65E478F5FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 01:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345752AbjHaXGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 19:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245147AbjHaXGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 19:06:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C607F110
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 16:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693523201; x=1725059201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2ea0lJkRuMoP0odfIkXP4wXqV/Iz+oodlnnNBf1+14g=;
  b=W0qzJtNLcOmJnpaIe4cQCb1JWJl1vLT2LbwPtJvjRLM3q17PfXHRiLot
   yEPFOkuZTfTkDsK/EZKbcU0tSCgQqVcqhH4Kfj6PITzjb/+DEaSuuUKDf
   6DTrrkBpyquuL8AtY9fPKvVoelPo0B01mfsxHZXVJkXKITgsiteip3NLL
   vHdJzv/zAHTpAtr0451L+zoc+EGCNohk8XLkrW8uTYi/Da+iatljc8/nK
   B4c/p3yzU4vVa1hRVhLz9H3Cc25EsZNyXoI1aQMUJyovSOxwUmY6tCQtT
   GwN/ordwA8/SfYL89TxCzpskg4tBaLVsNEVe/xBfza5Jt+srCnpDLsg4C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="355585496"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="355585496"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 16:06:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="742907475"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="742907475"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 16:06:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbqkH-005WbB-1y;
        Fri, 01 Sep 2023 02:06:37 +0300
Date:   Fri, 1 Sep 2023 02:06:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mfd: max8998: Simplify probe() and drop
 max8998_i2c_get_driver_data()
Message-ID: <ZPEc/S2GiJM/S3kF@smile.fi.intel.com>
References: <20230831184309.67507-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831184309.67507-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 07:43:09PM +0100, Biju Das wrote:
> Simplify probe() by using i2c_get_match_data() instead of
> max8998_i2c_get_driver_data() for retrieving match data from
> OF/ID tables.

Haven't I given you a tag for some of them? Please, double check and pay
respect to the reviewer in case the tag is missing.

-- 
With Best Regards,
Andy Shevchenko


