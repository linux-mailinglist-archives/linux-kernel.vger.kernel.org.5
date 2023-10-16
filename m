Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6608A7CA137
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjJPIFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPIFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:05:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9B4A1;
        Mon, 16 Oct 2023 01:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697443502; x=1728979502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9qdqyU+vozV28E2OGjCIhTdGJrIl9TyFYibwtJx8PbA=;
  b=llQEbmIqZKDllxgwrvqoiTvlFf/xVsdtdsGe1Yh80XarrH3L8wYzNfS7
   U6QUWpQWGbe2PSuvjx4ZGRbpXiSg+O8elLtroiAuh/AC22chQ1tefl/kN
   0ejJU57XrC/MLhP1NrSVjDPJc0Z4OTlJY9Det04Zo9L8N6jRWE3KmcUav
   c7tFdu8G7Q0mNtRQBR5ZCX78HTSpNkP3pTntJSs4urF7jz3vdphy6uqPd
   rzW4iNVttnDmSsZxD9SNYZmHYNrzEKncomgRVTSmFG9eUFAMzDZhfCLn2
   byJI5MWZ25upc81YFZ64EdkXba3gDtaFZUi/L+F0YMsmoGcTiMwVg+Hn8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389330801"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="389330801"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 01:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749207213"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="749207213"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 01:04:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsIQm-00000005x9U-0Gtu;
        Mon, 16 Oct 2023 10:54:28 +0300
Date:   Mon, 16 Oct 2023 10:54:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/5] Add support for BMP390 and various driver cleanups
Message-ID: <ZSzsM6vi+nqe1oae@smile.fi.intel.com>
References: <cover.1697381932.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697381932.git.ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 05:16:22PM +0200, Angel Iglesias wrote:
> Add support for the Bosch BMP390 pressure sensors and includes minor
> driver code cleanups.
> Patches 1 and 2 update I2C and SPI driver matching logic using newer
> helper functions available.
> Patch 3 fixes minor coding style incoherences.
> Patches 4 and 5 introduce support for the new BMP390 sensor allowing
> sensor families to have a list of known device IDs to improve detection
> 
> This patch series is aggregates patches from various series:
> https://lore.kernel.org/all/20230812175808.236405-1-biju.das.jz@bp.renesas.com/
> https://lore.kernel.org/all/cover.1691952005.git.ang.iglesiasg@gmail.com/
> https://lore.kernel.org/all/cover.1692805377.git.ang.iglesiasg@gmail.com/

For the patches 1-3,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


