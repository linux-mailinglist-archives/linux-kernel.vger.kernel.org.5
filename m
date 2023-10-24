Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EFA7D4E77
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjJXLBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjJXLBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:01:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD8712C;
        Tue, 24 Oct 2023 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698145267; x=1729681267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=75KjUTqZS/fnnT7oRhWogkQjn6g67+ZS64Oru9+MmVU=;
  b=OVTqXZ9pp95xjiBXRzhrbaV7HNWBCvOGuY24b7tfKXFGm1sCQWg9bzb7
   2aooeQKN3o3ImrclTd9wZ5UT80sLLYDtWENwfFscV70fbyFSlNLI4HAbT
   nG3D21rVAlmfLhx364LaluN8VtE9NE3kNT+2jSZvwmWzjMkSJAJYUkyEf
   trwLe6qbVUBLpCUiu0be35wq5gN2Cd8WwQgKMgaOwvDEjFzBOpgb8mSkE
   REW8B7YLG8o/J17L/DOLfsuz9j1+erfv7Logx0vqXWGmiyiHkHa7kYHTB
   56lykVIcR3Uud24GvGj/422LDaYNLTqSRv1X0BAb2Sq1sy6d5f/v9zp4O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="453491329"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="453491329"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="875034670"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="875034670"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:01:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qvF9f-00000008Bp9-0sdU;
        Tue, 24 Oct 2023 14:00:59 +0300
Date:   Tue, 24 Oct 2023 14:00:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, rafael@kernel.org,
        len.brown@intel.com, robert.moore@intel.com, mark.rutland@arm.com,
        will@kernel.org, linux@roeck-us.net, Jonathan.Cameron@huawei.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v3 0/6] Refine _UID references across kernel
Message-ID: <ZTej6hlCCYFRCNtl@smile.fi.intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
 <20231024093010.GF3208943@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024093010.GF3208943@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 12:30:10PM +0300, Mika Westerberg wrote:
> On Tue, Oct 24, 2023 at 11:50:12AM +0530, Raag Jadav wrote:
> > This series refines _UID references across kernel by:

...

> >  drivers/pinctrl/intel/pinctrl-intel.c |  2 +-
> 
> This pinctrl one is also fine by me so if Andy does not have objections,
> feel free to add my,

TL;DR: I had, but Rafael seems wanted your opinion. Whatever, I'm not
preventing this from happening, but I still consider that the uid check
for NULL in the helper should mimic the same logic as in
acpi_dev_hid_uid_match(). That's why I asked to drop my tags from this
series.

-- 
With Best Regards,
Andy Shevchenko


