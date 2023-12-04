Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32A0803441
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjLDNQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDNQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:16:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA5FAC;
        Mon,  4 Dec 2023 05:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701695812; x=1733231812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ruNQAEGel56sXK2lguhT42sAf9ycNnOllBZQjHkiz68=;
  b=PJWi8vuAeDGxWmC51xOgTiB7Xwmd+3IsWThqlM69FemK1I7ldZaurLM3
   TARm+gcD43ls55I2Q72/39L0Yef7FHoDTwEmC66R8rNtk1vZikF7Ft/bS
   A3XqwGC7dBcvOzeDjMS3q04OXdlEcKypy47jVyioKncz6EsFnZPmy8Ksl
   40ByOlgx9BrT7+z1MUPlSMUHfwugqZoPGSXbJ82SatM8NqkPcsywc0u6V
   U18yfhxYNnMUtJ2qd+eb0vX2MxYKR7tOlZnSWt9iD5MbP+wlwr7QAlx35
   s4HpL8ELMwXkOUHplEfyvy6H5BQLNdWCBYSmaRaGuBcf7CgLKQwdvrjna
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="629373"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="629373"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:16:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="774254311"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="774254311"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:16:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rA8oZ-00000001kz7-47cN;
        Mon, 04 Dec 2023 15:16:47 +0200
Date:   Mon, 4 Dec 2023 15:16:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 02/10] gpio: wm831x: use gpiochip_dup_line_label()
Message-ID: <ZW3RPxjsNPacT9Si@smile.fi.intel.com>
References: <20231204093509.19225-1-brgl@bgdev.pl>
 <20231204093509.19225-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204093509.19225-3-brgl@bgdev.pl>
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

On Mon, Dec 04, 2023 at 10:35:01AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use the new gpiochip_dup_line_label() helper to safely retrieve the
> descriptor label.

...

>  	for (i = 0; i < chip->ngpio; i++) {
>  		int gpio = i + chip->base;
>  		int reg;
> -		const char *label, *pull, *powerdomain;
> +		const char *pull, *powerdomain;

Make it reversed xmas tree?

-- 
With Best Regards,
Andy Shevchenko


