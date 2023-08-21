Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C706782520
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjHUIOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjHUIOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:14:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5B8BB;
        Mon, 21 Aug 2023 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692605691; x=1724141691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tL2Lu0F0C8vD2FjMV9KVGa0oIz41dmsO5aju38Hz2iY=;
  b=FnVdaFkHyOoOgFIghuxobihJ5VNNB7bw/5voGluLOESD0AwixaOEmDGe
   Jo5kzQSDWae+WN3Mc69pOSGCNofxp5BLsk9/OB36gR4vrL1GCwtPefdP8
   SUVnx82Y5CibHTDS9ySJ5C6uwVdmrsx8p6iGDLMuEL9OOooIXwqSn1W09
   CZ30+5PfgWKQdTasJ7IDmWDuF2FwA5eIwPqCQK01g4uGhu8qjusdIylfy
   tmS3MDUAJI6+e2tJgq51EbJdmXjdXK1bjLwqEV29PeO+M+/g5MH9L3szQ
   VjjbheYvhhlg1QlF6ixJH5pHYWGUm/I7moQeuBHsf/QZeT2U7sAKLZsOZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="370963420"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="370963420"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:14:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="770858457"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="770858457"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2023 01:14:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY03i-005BVi-2j;
        Mon, 21 Aug 2023 11:14:46 +0300
Date:   Mon, 21 Aug 2023 11:14:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: core: Remove unused PORT_* definitions
Message-ID: <ZOMc9jmwxc1XNRG+@smile.fi.intel.com>
References: <20230818111229.764380-1-andriy.shevchenko@linux.intel.com>
 <2023081954-situation-massive-269b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081954-situation-massive-269b@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 11:53:36AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 18, 2023 at 02:12:29PM +0300, Andy Shevchenko wrote:

...

> I'm all for removing these defines, but are you sure they are not used
> in any userspace code?  Ususally a debian code search is good enough
> "proof" of this, did you do that?

Thank you for a pointer, haven't checked.
Do you know if they have an API so I can run it via script?


-- 
With Best Regards,
Andy Shevchenko


