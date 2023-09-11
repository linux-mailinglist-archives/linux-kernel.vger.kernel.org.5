Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460DC79BC0C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbjIKVOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbjIKKPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:15:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4256E5F;
        Mon, 11 Sep 2023 03:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694427314; x=1725963314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MVY1RCA+Y6jHOKSik1rPFvNz857POHLvrx8p+7Ur7ao=;
  b=AVlReW0MCpg9k0qw3TN/c+YAABjy4ysXKq1plWxaK6VfjZM34rW4vfiJ
   VG9I6qAr/KBY5YagdMff/ES05p1DPNe6PqFAVxeXOb7xVhPpqDao1uG00
   3fMc7xmVoY1W/CmtSy2ch8TtnUugvjlfpFXLk77GNiJbyfla1+FTm7A/n
   DZboe8njupLW6YOdWVMpb3Q5FuJalnEzDItT+BVx+4rXSv2NGUpUn96wp
   GoHtE6N6fDeN1Cmw0CgcUv7L3QimSu8DWl7y3HLVfxS+GHSpJphQiBtzE
   FBkIUHSIZiYOMXGjB89x2EZctkwdFAzluDKBZEq3liB6wMU+3MV9krB/q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="376958369"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="376958369"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:15:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="886466175"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="886466175"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:14:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfdwk-008Hv0-0D;
        Mon, 11 Sep 2023 13:15:10 +0300
Date:   Mon, 11 Sep 2023 13:15:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH 1/2] power: supply: bq24257_charger: Make chip type and
 name in sync
Message-ID: <ZP7ored2UfXcFUvz@smile.fi.intel.com>
References: <20230902193331.83672-1-biju.das.jz@bp.renesas.com>
 <20230902193331.83672-2-biju.das.jz@bp.renesas.com>
 <ZPWsdjlFvUzeFy45@smile.fi.intel.com>
 <OS0PR01MB592285B86C29C3C1A992C09986F3A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB592285B86C29C3C1A992C09986F3A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 07:10:06AM +0000, Biju Das wrote:
> Hi Andy Shevchenko,
> > On Sat, Sep 02, 2023 at 08:33:30PM +0100, Biju Das wrote:

...

> > > -	if (ACPI_HANDLE(dev)) {
> > > -		acpi_id = acpi_match_device(dev->driver->acpi_match_table,
> > > -					    &client->dev);
> > > -		if (!acpi_id) {
> > > -			dev_err(dev, "Failed to match ACPI device\n");
> > > -			return -ENODEV;
> > > -		}
> > > -		bq->chip = (enum bq2425x_chip)acpi_id->driver_data;
> > > -	} else {
> > > -		bq->chip = (enum bq2425x_chip)id->driver_data;
> > > -	}
> > 
> > Do we still need acpi.h after this change?
> 
> Yes, it is still needed as it is using 
> ACPI_PTR.

Can we, please, drop ACPI_PTR() as it's more harmful than useful (same way as
you dropped the ifdeffery for OF cases in other patches)?

-- 
With Best Regards,
Andy Shevchenko


