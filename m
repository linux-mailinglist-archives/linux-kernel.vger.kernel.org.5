Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20207AD18B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjIYHWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjIYHWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:22:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B0C2;
        Mon, 25 Sep 2023 00:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695626545; x=1727162545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EX/fS3GBRqS4B+ZBKLxnCaUT2he9dlkGETXA9I0BbhI=;
  b=aJRYAZgp3UR1fjRG50XuWeK01GtSisObc7jVtyHTTaUCUbDP0/yJ1Ckr
   FJYUTylYMF1kjZpdrGcfTD8Vm6pSmGkoThzhpn0L/W5iVDZx5PtguafSc
   uG8vC5wjLk++RjyNEQYPJIRwRzKvPv0E97Wnr/91Ul07l+CSV9WbsFjBK
   O2fJHRqmC2ajiOT08UOFhQZGqZffdZ28ZJZQNh+0B0K99XJWNfyg00pXt
   qRwjnVMyqGrlXFnvphb5zjmubI0SXHD9DKuwVKR9/JzXp8MaL+d6HDXro
   YUC2iVwR4atOq21y1ha/haPZP9v2FpenYf/AvPE+z97uIaikiVAe1on3q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360571552"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="360571552"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 00:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079117832"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="1079117832"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 00:22:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qkfv9-00000000HHI-3rPn;
        Mon, 25 Sep 2023 10:22:19 +0300
Date:   Mon, 25 Sep 2023 10:22:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v2 2/2] leds: pca955x: Cleanup OF/ID table terminators
Message-ID: <ZRE1KyuHx2sv+aUH@smile.fi.intel.com>
References: <20230923171921.53503-1-biju.das.jz@bp.renesas.com>
 <20230923171921.53503-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923171921.53503-3-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 06:19:21PM +0100, Biju Das wrote:
> Some cleanups:
>  * Remove the trailing comma in the terminator entry for the OF
>    table making code robust against (theoretical) misrebases or other
>    similar things where the new entry goes _after_ the termination without
>    the compiler noticing.
>  * Drop a space from terminator entry for ID table.
> 
> While at it, move OF/ID table near to the user.

OK!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


