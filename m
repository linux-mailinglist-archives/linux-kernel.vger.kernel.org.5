Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9853E7524DF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjGMOQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjGMOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:15:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221043A85;
        Thu, 13 Jul 2023 07:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689257720; x=1720793720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t6/CWbos/88643w3iuRqAiJYN+TLmHJLjYSn3gBi4eg=;
  b=a8pqdw3JDPJMlhyK6l0Igr8Aos006Cq7giuu52WnY2ZGi/V94SooImKM
   1fCFUBH1YMWa7A9D8Bc4aoQ80lvkYKI7JzclVoZyEY0XMjWkBL+4pIcKJ
   x4zvociAeqEPFd5Xx5rVitjoMnDeQNYYDJADj/y3LC1pN7nHZL3/P+LP5
   goP/GvT5B6WlrTtk3V0HTZolRry9HAkyBgn9BqPUqT0jX7u8s7s3xB2qS
   9qyG1BOSZpkfN2S9HfZjhh2MyCJ+c2l+jYOL48TZVKm02rxMU3uTditTF
   fei1sHixozj2oUC2j8G1v6M5Uyj1J/u2R/Zv2307wO5vRhEQgVtSsa0vJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345513060"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="345513060"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 07:15:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="725315229"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="725315229"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jul 2023 07:15:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qJx6B-002PjM-3C;
        Thu, 13 Jul 2023 17:15:15 +0300
Date:   Thu, 13 Jul 2023 17:15:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>
Subject: Re: Closing down the wireless trees for a summer break?
Message-ID: <ZLAG85HEMH0MeW1G@smile.fi.intel.com>
References: <87y1kncuh4.fsf@kernel.org>
 <ZK7Yzd0VvblA3ONU@smile.fi.intel.com>
 <87wmz43xy4.fsf@kernel.org>
 <d1f9ca04bb055dc07f2a7f9f07f774e08913cf00.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1f9ca04bb055dc07f2a7f9f07f774e08913cf00.camel@sipsolutions.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 01:05:45PM +0200, Johannes Berg wrote:
> On Thu, 2023-07-13 at 13:30 +0300, Kalle Valo wrote:
> > Andy Shevchenko <andriy.shevchenko@intel.com> writes:
> > > On Tue, Jun 13, 2023 at 05:22:47PM +0300, Kalle Valo wrote:

...

> > > > [1] https://phb-crystal-ball.sipsolutions.net/
> > > 
> > > How could one use the shut down site?
> > 
> > What do you mean? At least from Finland it Works for me:
> 
> That did in fact not work yesterday for some time as I was doing some
> maintenance :)

Good to know!

-- 
With Best Regards,
Andy Shevchenko


