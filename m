Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4F677BC6D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjHNPH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjHNPHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:07:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E25BE73;
        Mon, 14 Aug 2023 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692025656; x=1723561656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m7VkgTENnrlD2O4sqRAqdaUpGqIfQ0V7pFH0Vax2dS0=;
  b=iNTCttGFJpJ8/R64nijLUW79+8Xd3LhNAO74UOyzzK2aRuLCXZcvq1mW
   kSInYRt1A5I6TZbi8n2eRXWSb9iin65ehXMY/DlTacOCzSv5rdEmfnZGQ
   3uXXF45WHowYrNBZHsmjihIeCd2Ge5745dEjzj+xK74Jmb1aw2fFTCEqh
   5+bRaDzyOdh6amjzMlQmsjT+9K3lCy5B8q4u/Qi/ex4WrgjZ3Rdu6AgS3
   KruW3BvppjM7v1Tgwss4MhEszUrNDpco0r8YsdyOmf9TJ0MExjKHLj+ru
   +ONLubD/BhE3h8I5upj42xvP2xOxwQ3IxBUkIV035NLbsp4W9OECTIUf0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="362209038"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="362209038"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 08:06:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="733478599"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="733478599"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 14 Aug 2023 08:06:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVZ95-009vp6-01;
        Mon, 14 Aug 2023 18:06:15 +0300
Date:   Mon, 14 Aug 2023 18:06:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        bleung@chromium.org
Subject: Re: [PATCH 4/4] usb: typec: intel_pmc_mux: Configure Displayport
 Alternate mode 2.1
Message-ID: <ZNpC5nEthmG9C7n/@smile.fi.intel.com>
References: <20230811210735.159529-1-utkarsh.h.patel@intel.com>
 <20230811210735.159529-5-utkarsh.h.patel@intel.com>
 <e9d83459-623e-34e1-ce9d-eb0b83ea170f@omp.ru>
 <ZNo+1LRMfcjFEMu5@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNo+1LRMfcjFEMu5@smile.fi.intel.com>
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

On Mon, Aug 14, 2023 at 05:48:52PM +0300, Andy Shevchenko wrote:
> On Sat, Aug 12, 2023 at 12:47:43PM +0300, Sergey Shtylyov wrote:
> > On 8/12/23 12:07 AM, Utkarsh Patel wrote:
> > 
> > > Mux agent driver can configure cable details such as cable type and
> > > cable speed received as a part of displayport configuration to support
> > > Displayport Alternate mode 2.1.
> > > 
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > 
> >    Hm, I think the R-b tags should follow your signoff...
> 
> They following historical order.
> So, before this patch appears upstream, it had collected Rb tags.

Note, Submitting Patches only defines the order rules to SoB tag, for Rb there
is no such rule:

 "Both Tested-by and Reviewed-by tags, once received on mailing list from
 tester or reviewer, should be added by author to the applicable patches when
 sending next versions."

> > > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

-- 
With Best Regards,
Andy Shevchenko


