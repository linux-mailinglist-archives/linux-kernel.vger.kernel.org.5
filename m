Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD3B7AEF89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjIZPX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjIZPX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:23:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42C910A;
        Tue, 26 Sep 2023 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695741800; x=1727277800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IxX9oSdDKpmtGZK8qvc/vCzSVX/ryfcoY7TfJCkjJ90=;
  b=QWJm7IqEYFV1J8DIr3/5mxlFai/iW1+tblaKv4Gvbbt9qFtZEuW/ZG3h
   WDBN21z7s8suxyXYqI5OmXZ3LG8o63OB6ajbTW5jJyWuGSAXuUqUZbH54
   TsOPFpIW8d/W5J7xoducKrB6ZRNRqA822SAc6qt2T6K6uLV0p0UJN4l4i
   zDPw1KrcL7uwrrbc0z8RMr1JatGnBqVxS2yfqsO2cDvMjbsvAOTLqc6bj
   GZJZ8V65BVjj4F7G66pFaw/w78/4GFc/Kar1P20ajg6jXeMmcWQv44/5n
   685nbRNOe54x4FI3xOcOtj567gLhw1GlyULtmI3lKd84aEljAC0ygZkcb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385438462"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="385438462"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:23:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="814519207"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="814519207"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:23:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ql9u4-00000000eI6-3CZ5;
        Tue, 26 Sep 2023 18:23:12 +0300
Date:   Tue, 26 Sep 2023 18:23:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] platform/x86: intel_speed_select_if: Remove
 hardcoded map size
Message-ID: <ZRL3YAX8pl9L4ell@smile.fi.intel.com>
References: <20230925194555.966743-1-srinivas.pandruvada@linux.intel.com>
 <20230925194555.966743-4-srinivas.pandruvada@linux.intel.com>
 <ZRLZmDmIkOo0YVz6@smile.fi.intel.com>
 <9cab732f92d529d76b9e40f91ede1460320f1da4.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cab732f92d529d76b9e40f91ede1460320f1da4.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 08:04:46AM -0700, srinivas pandruvada wrote:
> On Tue, 2023-09-26 at 16:16 +0300, Andy Shevchenko wrote:
> > On Mon, Sep 25, 2023 at 12:45:55PM -0700, Srinivas Pandruvada wrote:
> > > The driver is using 256 as the size while calling devm_ioremap().
> > > The
> > > maximum offset is already part of struct isst_mmio_range. Use the
> > > maximum offset (end field of the struct) plus 4 as the map size to
> > > remove
> > > hardcoded value of 256.

...

> > > +       punit_dev->mmio_range = (struct isst_mmio_range *) ent-
> > > >driver_data;
> > > +
> > > +       punit_dev->punit_mmio = devm_ioremap(&pdev->dev, base_addr,
> > > +                                            punit_dev-
> > > >mmio_range[1].end + sizeof(u32));
> > 
> > Can we rather fix the mmio_range driver data to have end be actually
> > not the
> > offset of the last dword? (Better maybe to keep length there.)
> > 
> We can. But that has to be separate patch on top as there are other
> places this range is used.

Still you can add a third member for now and then clean up it later as it's all
in one file.

...

> > With help of
> > 
> >         struct resource r;
> >         ...
> >         r = DEFINE_RES_MEM(base_addr, mmio_range.beg +
> > mmio_range.len);
> > 
> > you can switch to devm_ioremap_resource() API.
> What is the advantage of creating a resource and then call
> devm_ioremap_resource()?

It manages resource via global resource management and also prints an error
messages in case of errors.

-- 
With Best Regards,
Andy Shevchenko


