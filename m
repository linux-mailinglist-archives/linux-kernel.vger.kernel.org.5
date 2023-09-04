Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA4679159F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbjIDKTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIDKTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:19:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65428BD;
        Mon,  4 Sep 2023 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693822744; x=1725358744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gkDnMwjA7l490OUxijQvV0jTzYpNi8dtbxJiRZHOVFw=;
  b=JXrbKtz8guDuKbv1mbBEoDJHKpS2JDOFz5fMfkm6SDGIUYAg5OzssVxW
   qNK0+5qFpATlnPPhiPMm+Bl13j5cV+4AzOl1gJhr7x/jPNkzgIv/5Ig1z
   jLvPTlMaS6zZx/am3Fa+c851XpReXB05Nxbd2sFTGh72vJqjdSinyi/Ky
   uDgJXkLNIPpbPDwNQHUQ2w5/XNYQsObGi0OWfexIUbL52UbehAYauyuRZ
   TDEZMnHqu4V+JE5st45ZAU7q8DPq26PmPNzTZiBrZvIPN93JuIePlxEN0
   hPxx1arYvOU2Sctz8hVFc7Elh/DIR/1Gvjfm7KxX+07kwx823ETHPXV9k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="376500346"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="376500346"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:10:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="1071545125"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="1071545125"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:10:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd6Wy-006ObZ-0H;
        Mon, 04 Sep 2023 13:10:04 +0300
Date:   Mon, 4 Sep 2023 13:10:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH 2/2] power: supply: bq2515x: Some cleanups
Message-ID: <ZPWs+xtfQUlGOaVe@smile.fi.intel.com>
References: <20230902200518.91585-1-biju.das.jz@bp.renesas.com>
 <20230902200518.91585-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902200518.91585-3-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 09:05:18PM +0100, Biju Das wrote:
> Some cleanups:
>  * Remove trailing comma in the terminator entry for OF/ID table.
>  * Drop a space from terminator entry for OF table.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Btw, in all similar patches you may add the reason(s) why you are doing that:

1/ unification;
2/ making code robust against (theoretical) misrebases or other similar things
   where the new entry goes _after_ the termination without compiler noticing.

-- 
With Best Regards,
Andy Shevchenko


