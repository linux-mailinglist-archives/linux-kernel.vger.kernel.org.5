Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81924797418
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345381AbjIGPf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344126AbjIGPc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:32:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12641BFD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:32:00 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="362409823"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="362409823"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="832186693"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="832186693"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:07:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qeFfL-007KGR-3D;
        Thu, 07 Sep 2023 17:07:27 +0300
Date:   Thu, 7 Sep 2023 17:07:27 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] devres: rename the first parameter of
 devm_add_action_or_reset()
Message-ID: <ZPnZHzOli8w0Lqwr@smile.fi.intel.com>
References: <20230907110305.2096052-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907110305.2096052-1-masahiroy@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 08:03:05PM +0900, Masahiro Yamada wrote:
> Fix a possible mistake in commit 410e7088e971 ("devres: Pass unique name
> of the resource to devm_add_action_or_reset()").
> 
> The first parameter of devm_add_action_or_reset() is the associated
> device. The name 'release' is confusing because it is often used for
> dr_release_t in the devres context.
> 
> Rename it to 'dev'. No functional change intended.

...

> -#define devm_add_action_or_reset(release, action, data) \
> -	__devm_add_action_or_reset(release, action, data, #action)
> +#define devm_add_action_or_reset(dev, action, data) \
> +	__devm_add_action_or_reset(dev, action, data, #action)

What about devm_add_action() and Co?

-- 
With Best Regards,
Andy Shevchenko


