Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BC77529DC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjGMRaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjGMR37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:29:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBA62D6D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689269397; x=1720805397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5UG+IoVPbM06HhwbvcHwbFoP2KPbqFQTKZZAF5phBx4=;
  b=V1vPZ5JFImjTfn7AJQlEfGpC+S+4CTobTH/37rvO4fngbcxhF9YRZTfZ
   Ikx8Pf/VvfAJeXGHJaniIVs194LKxEaZEcKli92dMSgSVQHKep9bc9SIh
   cm7BzJDhLt0Jy+3/Im+k0+CY/46apFiwA/Aw6wM9nkkiofWaSCSQERtPN
   ECWw4uAzXDN23eFreJhGj0ZJd3IrilWosbwJ7SDigQDdEk+WU/LmHRlU9
   Mv42czE5dXmJlDBZ332q2HQ0Xs5MpqaE697xhGry/OljMp5fKL5i+E3eX
   ym6pxaDdoOLS6YbmoCbn6rbYWYXNQIlhydZzktL17lAOv1sLOmZgVCyWq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362728612"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="362728612"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 10:28:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="699333195"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="699333195"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 13 Jul 2023 10:28:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qK07T-002Rq9-17;
        Thu, 13 Jul 2023 20:28:47 +0300
Date:   Thu, 13 Jul 2023 20:28:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com
Subject: Re: [v2 1/5] lib/bitmap: add bitmap_{set,get}_value_unaligned()
Message-ID: <ZLA0TwHZOgAGCgKX@smile.fi.intel.com>
References: <20230713125706.2884502-1-glider@google.com>
 <20230713125706.2884502-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713125706.2884502-2-glider@google.com>
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

+Cc: William

On Thu, Jul 13, 2023 at 02:57:01PM +0200, Alexander Potapenko wrote:
> The two new functions allow setting/getting values of length up to
> BITS_PER_LONG bits at arbitrary position in the bitmap.

A couple of years (?) ago it was a series to achieve something like this with
better (?) code. Why not resurrect that one?

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2195426.html

-- 
With Best Regards,
Andy Shevchenko


