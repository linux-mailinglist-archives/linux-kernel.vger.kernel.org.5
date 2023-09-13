Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D864579E696
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbjIMLXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240021AbjIMLXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:23:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CC51BF4;
        Wed, 13 Sep 2023 04:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694604224; x=1726140224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I7bITU+K1NCbCKoMgKk3hug0+GMsUnqln9LoM5Xw9I4=;
  b=XQPlpCS2qOfE0pa9uAonqt6xRQSrz29qe847Us8miCHch2YgSk+4VnvJ
   xob6j9wiSwN2hwgLX8XRMbRPNhIGYiw/7dembL9zSCCtW/KVLj3NFwG37
   kwtWOU0VgdedMZWo/Z4SdBugiUfbwUz0ZV3LtVtuYb8dhF4UDkkxOgPn9
   4BBsBrMxlvYBJXlJJzM3T/y3WIbR5fTwTo0vZHtouE/41ExHg9XY581U4
   lfR/EM1bIRB/S97oTc5Vqq+01Pe6DNYqohIiOBMHaZzpFrp1OHcfqfnxp
   KyxG0ueAO+M6fWhMvmve2foXcWLAEq1yEk19zwXNUotUF3WfPLnao33L6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="382436407"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="382436407"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:23:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="867756628"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="867756628"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:23:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qgNy7-008qj8-13;
        Wed, 13 Sep 2023 14:23:39 +0300
Date:   Wed, 13 Sep 2023 14:23:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH 1/2] power: supply: bq24257_charger: Make chip type and
 name in sync
Message-ID: <ZQGbu+67CLVlb58P@smile.fi.intel.com>
References: <20230902193331.83672-1-biju.das.jz@bp.renesas.com>
 <20230902193331.83672-2-biju.das.jz@bp.renesas.com>
 <ZPWsdjlFvUzeFy45@smile.fi.intel.com>
 <OS0PR01MB592285B86C29C3C1A992C09986F3A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZP7ored2UfXcFUvz@smile.fi.intel.com>
 <20230912214925.uukw4lxnopzswqz2@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912214925.uukw4lxnopzswqz2@mercury.elektranox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:49:25PM +0200, Sebastian Reichel wrote:
> On Mon, Sep 11, 2023 at 01:15:09PM +0300, Andy Shevchenko wrote:
> > On Sun, Sep 10, 2023 at 07:10:06AM +0000, Biju Das wrote:
> > > Hi Andy Shevchenko,
> > > > On Sat, Sep 02, 2023 at 08:33:30PM +0100, Biju Das wrote:

...

> > > > Do we still need acpi.h after this change?
> > > 
> > > Yes, it is still needed as it is using 
> > > ACPI_PTR.
> > 
> > Can we, please, drop ACPI_PTR() as it's more harmful than useful (same way as
> > you dropped the ifdeffery for OF cases in other patches)?
> 
> I will go ahead and merge this series, ACPI_PTR() and
> of_match_ptr() should be removed in a separate cleanup patch.

Sure, that's exactly what I expects to happen.

-- 
With Best Regards,
Andy Shevchenko


