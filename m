Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0425A782559
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjHUIYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjHUIYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:24:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AEF98;
        Mon, 21 Aug 2023 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692606288; x=1724142288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p2Ait7dim8Mm8p4a+uh34/YcLbSXgij1fLB8TjrgqPk=;
  b=kAWpM9REUnbitS03AiwqIqa37uwvbqQsm+bMMVlSKMPg1vuxIohNnolp
   GZjC0E+O7FP3Y4JA1qZi6RDJLRMgAE9JTTjIJWBGZ66i81rNTMS05VRNl
   ZXP8w2AxtMThDrhEf3C+y69q+qCUvEZhnIudp+cWFv8qTY4bPQpMTYVSJ
   v3ImKPYIhCPpf/HwF2O2slTfqoTz2qyleLL048VdFTMSF+ErQITWpoamU
   5SHn7hs9RdtcjubFcI3Gy2KIooODvr5okUr6InlgR4Ha05SdKjp5uu+Bd
   89f1u7I2dWlLj6HM2k1kG7lph/1kkzTay3LVu5uiu1zo1SzXYvrKFQ0vG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="376282187"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="376282187"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:24:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="685579168"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="685579168"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2023 01:24:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY0DK-005WTI-15;
        Mon, 21 Aug 2023 11:24:42 +0300
Date:   Mon, 21 Aug 2023 11:24:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: core: Remove unused PORT_* definitions
Message-ID: <ZOMfSorbfxIYMwkJ@smile.fi.intel.com>
References: <20230818111229.764380-1-andriy.shevchenko@linux.intel.com>
 <ZOMe2NIMp+a8ShsX@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOMe2NIMp+a8ShsX@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 11:22:49AM +0300, Andy Shevchenko wrote:
> On Fri, Aug 18, 2023 at 02:12:29PM +0300, Andy Shevchenko wrote:
> > For the last couple of years Linux kernel got rid of a few architectures
> > and many platforms. Hence some PORT_* definitions in the serial_core.h
> > become unused and redundant. Remove them for good.
> 
> Below are results via Debian Code Search.
> 
> Note, I excluded Linux kernel itself from the "user" and Hurd, which seems
> to have Linux kernel v2.6 which is _provider_ of the definition(s).

...

> > -#define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
> 
> ifdeffed, safe to remove.

Actually on the second thought, this can bring a collision in case someone adds
another ID with the same value.

I'll issue the v2 with this line left untouched.

-- 
With Best Regards,
Andy Shevchenko


