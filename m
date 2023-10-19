Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F5C7CF865
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345659AbjJSMJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345830AbjJSMJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:09:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7E335BD;
        Thu, 19 Oct 2023 05:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697717225; x=1729253225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cZrpDI17ZMb/Ton/XpJWiGZ39wcbVjXpretuf1XL3Y0=;
  b=FBuS/3O4hKI2dUyrTn5pPJ3cDchgTXMQ/DWXLfaK9kugYgv78FJx+Fii
   XIW3kSV47et8wWFnpfIJCYPROtRG3TbFOvmqX+AUYRg2CV34UU/CS4uiw
   Y1bnGyJ7YfmQ7XP6zbJQvlEYLxjGGpblLpynX8vnzSlg5quHqPm48e8M2
   d3pBGqgQ8hZgH/BRuzEmnGNSQQObgy6obg9Rj2SUJxi0c2YpRiswpQTJ3
   2/VTEL5mEtQVUgPoJAusSHPlU2ycvhnQZAos06l2r/kMlziFJOslmzTL9
   VMwVkkJfx1ilYlNMm1nXnu+QFTbAy/K19ECDMlZjRDvNFyAIkXctgBChh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="7786902"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="7786902"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:05:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1004211901"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="1004211901"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:05:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qtRmf-00000006r6E-12MY;
        Thu, 19 Oct 2023 15:05:49 +0300
Date:   Thu, 19 Oct 2023 15:05:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 2/6] device property: Add
 fwnode_property_match_property_string()
Message-ID: <ZTEbnIy9fWdez/Ff@smile.fi.intel.com>
References: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com>
 <20230808162800.61651-3-andriy.shevchenko@linux.intel.com>
 <20230809185944.1ae78e34@jic23-huawei>
 <ZNTlniWf8Ou9hHOT@smile.fi.intel.com>
 <20230828190101.50f70921@jic23-huawei>
 <CAJZ5v0gOXsX98jQTRSwoYmfYBfva1RHTsDaLL++m7c+kLjStVA@mail.gmail.com>
 <ZS7jyHkKJcubVxws@smile.fi.intel.com>
 <20231018203755.06cb1118@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018203755.06cb1118@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 08:37:55PM +0100, Jonathan Cameron wrote:
> On Tue, 17 Oct 2023 22:43:04 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Oct 17, 2023 at 09:19:30PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Aug 28, 2023 at 8:00 PM Jonathan Cameron <jic23@kernel.org> wrote:  

...

> > > Sorry for the delay, I've lost track of this.  
> > 
> > NP!
> > 
> > > Honestly, I have no strong opinion, but I think that this is going to
> > > reduce some code duplication which is a valid purpose, so please feel
> > > free to add
> > > 
> > > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> > > 
> > > to this patch.  
> > 
> > Thank you!
> > 
> > Jonathan, are we all set for applying this series?
> > 
> Applied, but it might end up as 6.8 material depending on exactly how
> timing turns out.  I have one pull request sent and I'm not sure I'll get
> another one in this cycle. Given I just applied some big drivers I'd like to, but
> not sure yet...

It's fine, I'm not in hurry with this and thank you!

-- 
With Best Regards,
Andy Shevchenko


