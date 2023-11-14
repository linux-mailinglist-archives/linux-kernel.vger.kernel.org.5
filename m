Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4FB7EAF80
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjKNLt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNLtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:49:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B97DD;
        Tue, 14 Nov 2023 03:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699962563; x=1731498563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ND/0G0J/4wdItD2JBTYPglEZY1/B7GIVDRvVYRYQdM=;
  b=FAPjSF56oM2dCxA5wYU2Cw9BtZ1SqY9biWqou3Y7OXfCM3FPVfoq49yt
   zHw42exewgIH7CwIVtSVv61XLKYVw1V+uHyF0Vy+VHtNu/NBA9hxl6Z2/
   /QMpSmf/j4Vo8ov2ZSMrLHCq5YAqws8tv9NHevT68/46XXEyk7yX+HNPF
   oZjboGOKzbULfYiv0tb1Dmfm0mZiFe/SFlEC5vTe8/G+UH8sqVRjx85AB
   qo+esckoeZrXijXaeywQ/yCl33rfN0qZ0vojFxv35Z9VPmXBa7mA/01Vo
   5HYF/siybXRPyxfBeDJyh5K7TdLjLfaK3vW8Kz8mmuz7wEIudZg3rr3Ga
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="390433680"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390433680"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 03:49:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="799500775"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="799500775"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 03:49:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2rum-0000000DnWv-33cC;
        Tue, 14 Nov 2023 13:49:08 +0200
Date:   Tue, 14 Nov 2023 13:49:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        mika.westerberg@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1 0/3] Use the standard _PM_OPS() export macro in Intel
 Tangier GPIO driver
Message-ID: <ZVNetJdEEuWMxl2a@smile.fi.intel.com>
References: <20231113131600.10828-1-raag.jadav@intel.com>
 <ZVJHqrj5OzoWav5Z@smile.fi.intel.com>
 <ZVL5tMZLTDKNLfP2@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVL5tMZLTDKNLfP2@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 06:38:44AM +0200, Raag Jadav wrote:
> On Mon, Nov 13, 2023 at 05:58:34PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 13, 2023 at 06:45:57PM +0530, Raag Jadav wrote:
> > > This series exports pm_ops structure from Intel Tangier GPIO driver using
> > > EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS() helper and reuses it into its users.
> > 
> > Yet you missed --base...
> 
> My understanding is that we use --base only for the patches with explicit
> in-tree dependency, which this series doesn't have any AFAIK.
> 
> Will start using it for every patch if it makes everyone happy :)

For single patches it's not so critical, only for the series as I'm using b4
to treat them as PRs, so cover letter goes to the merge commit and b4 tries
to guess the base (often wrongly).

-- 
With Best Regards,
Andy Shevchenko


