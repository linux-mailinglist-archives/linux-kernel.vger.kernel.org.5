Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D6975A9C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGTI5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjGTIge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:36:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6F62690;
        Thu, 20 Jul 2023 01:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689842192; x=1721378192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pQHREhOcPSz4Z85LUnKLuGoWvYd73M/FkXI+b/m+PDk=;
  b=JiEdVC5kdmFZnRgTztKZSMww4BOtmy6RO+TQ4ouslAdbEi2gE3pxd3tX
   L2TlF0v3fupA3BqQcdZL9CpGPi+S7mMemnp66MpgpfDl08x8woGt2E+eN
   VIk9zIlD3k6UeggLO9a0TVUFy+fBn1sGh7PmEHc6bGl23FamYsZKrysWg
   ydtTcTjzzY7gAhZ2rPvaB78/eHpcNc6cYpBLIrZ0bziJ5UB/+UmXzrOCF
   wchZJljCrIQIggESVKBt5m8E/62bNwRM5jvalZYa5mbRfu9h8tCiPsWHY
   hpTb6whAasbhnYT24R2/5CZDilYqUJa+RDMDep5nkEd8MVWKqvz2GyUoV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="397547646"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="397547646"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 01:36:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="970965180"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="970965180"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jul 2023 01:36:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMP9B-00Ghit-1e;
        Thu, 20 Jul 2023 11:36:29 +0300
Date:   Thu, 20 Jul 2023 11:36:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Armin Wolf <W_Armin@gmx.de>
Subject: Re: [RFC PATCH v1] platform/x86: wmi: Do not register driver with
 invalid GUID
Message-ID: <ZLjyDQ80QKWtKqUk@smile.fi.intel.com>
References: <20230715211604.1272227-1-pobrn@protonmail.com>
 <ZLUOxnE58wUgZXWx@smile.fi.intel.com>
 <mL0s5ZsO3eU18EzO_7zVsawf2rr7o-zsOrwBDncazQIAgRn-LRNTGw2ugm1bfRoHKWTRYmUHt8s7zjfNEESapwFZlaNj6B041x_AZ-pagoI=@protonmail.com>
 <ZLUmh0nKJdRMmhX1@smile.fi.intel.com>
 <kN5iBK5RwAEr8LXNTgb6dUk7zxuGFFtF2q_ReNezksLqaq7C4frYfo6ELswUu0wVoewy3UENAwFjjK48d2qBwf6q4is8ST28zpK6-ze_eIU=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kN5iBK5RwAEr8LXNTgb6dUk7zxuGFFtF2q_ReNezksLqaq7C4frYfo6ELswUu0wVoewy3UENAwFjjK48d2qBwf6q4is8ST28zpK6-ze_eIU=@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 07:23:37PM +0000, Barnabás Pőcze wrote:
> 2023. július 17., hétfő 13:31 keltezéssel, Andy Shevchenko írta:
> > On Mon, Jul 17, 2023 at 11:23:50AM +0000, Barnabás Pőcze wrote:
> > > 2023. július 17., hétfő 11:49 keltezéssel, Andy Shevchenko <andriy.shevchenko@linux.intel.com> írta:
> > > On Sat, Jul 15, 2023 at 09:24:16PM +0000, Barnabás Pőcze wrote:

...

> > > > Besides using wrong API (uuid_*() vs. guid_*() one), I don't
> > >
> > > As far as I can see `guid_parse()` also uses `uuid_is_valid()`, the format is the same.
> > 
> > Then add guid_is_valid() to complete the API. Perhaps with the renaming the
> > common part to something else.
> 
> But that would be the exact same function. GUIDs are UUIDs, aren't they?

Yes and no. If we want to validate the respective bit for GUID vs. UUID, they
will be different. Currently they are the same as validation is relaxed in the
kernel.

> > > > think we need to validate it here. Why not in file2alias.c?
> > > > [...]
> > >
> > > 1) that seems like a more complicated change (duplicating `uuid_is_valid()`?);
> > > 2) that will only check the GUIDs specified by `MODULE_DEVICE_TABLE()`.
> > >
> > > Arguably the second point is not that significant since most users will indeed
> > > use `MODULE_DEVICE_TABLE()`. But I think the first point has some merit. And
> > > furthermore, I think this check should be here regardless of whether file2alias.c
> > > also contains an equivalent/similar check.
> > 
> > Why do we need it? We never match against wrong GUID from ACPI, since it would
> > be very weird ACPI table.
> > [...]
> 
> The point is to catch typos in drivers' WMI ID tables.

Yes, that's what file2alias is for. We trust modules we build, right?
If you don't trust, then we have much bigger problem than this patch
tries to address.

-- 
With Best Regards,
Andy Shevchenko


