Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C3775619C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjGQLb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQLbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:31:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB00E4C;
        Mon, 17 Jul 2023 04:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689593483; x=1721129483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=82UncTm9OqK/V73oyIZJZpBg0Z7m+Dt/9BliUolJBdE=;
  b=CVAzrMOxUZC37qneaAvS2BzQZFmCh7aqHz9aalKm0AyFmRrM3tjDYz8f
   Sz+oXu3HdHDjcYUyO3Ka0IOGlniQawUpR8pEeReck+ayPccfKttVHoy2U
   pGJQE/Ce4kfXXdolDGBB4n68LJiMoG+CTVgsp6MeSJXYkUDyXxa+GRWr3
   QKC/g5BaE9cuzQGy9G9tRYdJ4B7GKq5PvyM3U1wfXktHb/LzF+PiSCJ1c
   CxaccSE26voKU2/Hanx0AdPVhNvMAlJOTjJqQT4yRY8lPXE0jSH2CEFjD
   r4My/rtGRqVQmfqbeE1lGvjsjmE9HDal/MKfVqZlgRayZ9CbNtUJrVBaB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="396734258"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="396734258"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 04:31:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="969854928"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="969854928"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2023 04:31:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLMRk-00BqAG-0n;
        Mon, 17 Jul 2023 14:31:20 +0300
Date:   Mon, 17 Jul 2023 14:31:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Armin Wolf <W_Armin@gmx.de>
Subject: Re: [RFC PATCH v1] platform/x86: wmi: Do not register driver with
 invalid GUID
Message-ID: <ZLUmh0nKJdRMmhX1@smile.fi.intel.com>
References: <20230715211604.1272227-1-pobrn@protonmail.com>
 <ZLUOxnE58wUgZXWx@smile.fi.intel.com>
 <mL0s5ZsO3eU18EzO_7zVsawf2rr7o-zsOrwBDncazQIAgRn-LRNTGw2ugm1bfRoHKWTRYmUHt8s7zjfNEESapwFZlaNj6B041x_AZ-pagoI=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mL0s5ZsO3eU18EzO_7zVsawf2rr7o-zsOrwBDncazQIAgRn-LRNTGw2ugm1bfRoHKWTRYmUHt8s7zjfNEESapwFZlaNj6B041x_AZ-pagoI=@protonmail.com>
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

On Mon, Jul 17, 2023 at 11:23:50AM +0000, Barnabás Pőcze wrote:
> 2023. július 17., hétfő 11:49 keltezéssel, Andy Shevchenko <andriy.shevchenko@linux.intel.com> írta:
> On Sat, Jul 15, 2023 at 09:24:16PM +0000, Barnabás Pőcze wrote:
> > > Since a WMI driver's ID table contains strings it is relatively
> > > easy to make mistakes. At the moment, there is no feedback
> > > if any of the specified GUIDs are invalid (since
> > > 028e6e204ace1f080cfeacd72c50397eb8ae8883).
> > >
> > > So check if the GUIDs in the driver's ID table are valid,
> > > print all invalid ones, and refuse to register the driver
> > > if any of the GUIDs are invalid.
> > 
> > Besides using wrong API (uuid_*() vs. guid_*() one), I don't
> 
> As far as I can see `guid_parse()` also uses `uuid_is_valid()`, the format is the same.

Then add guid_is_valid() to complete the API. Perhaps with the renaming the
common part to something else.

> > think we need to validate it here. Why not in file2alias.c?
> > [...]
> 
> 1) that seems like a more complicated change (duplicating `uuid_is_valid()`?);
> 2) that will only check the GUIDs specified by `MODULE_DEVICE_TABLE()`.
> 
> Arguably the second point is not that significant since most users will indeed
> use `MODULE_DEVICE_TABLE()`. But I think the first point has some merit. And
> furthermore, I think this check should be here regardless of whether file2alias.c
> also contains an equivalent/similar check.

Why do we need it? We never match against wrong GUID from ACPI, since it would
be very weird ACPI table.

For file2alias what we would need is to split uuid.c in the kernel to something
like uuid.c and libuuid.c where the latter will be used as a C module in both
kernel and user space (i.o.w. to be compiled twice and linked accordingly).

-- 
With Best Regards,
Andy Shevchenko


