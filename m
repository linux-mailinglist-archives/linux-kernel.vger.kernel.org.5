Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B99E79147D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350851AbjIDJMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjIDJMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:12:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695DA18D;
        Mon,  4 Sep 2023 02:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693818732; x=1725354732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IxeCnOJgOsYK28vwcZ7Uz20blZbxTxTvwluc7PRE7oU=;
  b=TIIgpFGp/F6LYC8rypVgSzKDVCfI4VUNgHC01annHC6KfCae3t2JVD7+
   AsC+18qQbbskNn6hu4MSuupOu2Q8QuWr4iWeyyt2dK68/6+EETCEsSO7z
   QRm+z26YdFvSLrSYDW7zmoPcsvt1IUKFn0kg1c7itR4vlcpBxpmGZA/9m
   Fofci7SkOmq3/0+uciwfJ9YTJnnZRnIojdSH/kQEgk+L8kSOYo5wHuOYZ
   zT2NrSvoBG30g/DtSnkWFF0iROvcKjnX1sY6ybDT90fdIpnaRkhW6xqhl
   ob6gSG51IGfo2tbHwj6fB2bY8N9uA0R29PoSwdFY1fbLrHlzbjDnYuZd/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="356875018"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="356875018"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="1071524940"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="1071524940"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:12:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd5ct-006NlD-29;
        Mon, 04 Sep 2023 12:12:07 +0300
Date:   Mon, 4 Sep 2023 12:12:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: mcp23s08: Simplify probe()
Message-ID: <ZPWfZxDuKto6eopt@smile.fi.intel.com>
References: <20230902090937.32195-1-biju.das.jz@bp.renesas.com>
 <20230902090937.32195-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902090937.32195-3-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 10:09:37AM +0100, Biju Das wrote:
> Add struct mcp23s08_i2c_info and simplify probe() by replacing
> match data 'type' with 'struct mcp23s08_i2c_info'.
> 
> While at it, replace dev_err()->dev_err_probe().

'->' --> ' --> '

...

> +	info = i2c_get_match_data(client);
> +	if (!info)
> +		return dev_err_probe(dev, -EINVAL, "invalid device type (%d)\n",

> +				     info->type);

Huh?! Please, think about it...

-- 
With Best Regards,
Andy Shevchenko


