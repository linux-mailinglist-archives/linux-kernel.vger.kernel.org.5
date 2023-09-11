Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDAE79BFD4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242570AbjIKU6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbjIKJyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:54:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E91CE6;
        Mon, 11 Sep 2023 02:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694426036; x=1725962036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SEOfbDIoCiImT7fNzulI3X+NzV6QoBIYFDXBTyvM/zw=;
  b=etAPPbPhIC9O1BrcWJ+xa6J4d0Mj35Q7AS91BdjAgezlPQSCUCkc5OuY
   +pP8242y7zgl3yw0tGhvvYUzmWhwx1LU9pxuzTMGM6aeJ2+x+hyt4kC8c
   ZsV6CC5RV/ou48WFoSI8YzowteukNUWzZKXSkUqcxrLhkB+tLAwKiGxC2
   IOPy01yGN5z0Ls6vBPxUcg3zcYfOWN3X6NFtd2/DmXQ0kygStoI01tQCM
   8Eq55twW35quOA/6iL2FMdp5KvG3ZRF9l2fPtpLbtpAjye79p7xANqUZd
   n57K5+k2a/1kwmzO0DuPFXzEbgbT8P7oUWM6rmfQiUDGxEPQb24m9fF6H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="444458013"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="444458013"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:53:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="833444760"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="833444760"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:53:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfdc6-008Hdd-0E;
        Mon, 11 Sep 2023 12:53:50 +0300
Date:   Mon, 11 Sep 2023 12:53:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linhua Xu <Linhua.xu@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        lh xu <xulh0829@gmail.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH V2 4/6] pinctrl: sprd: Add pinctrl support for UMS512
Message-ID: <ZP7jratkdqCGg35I@smile.fi.intel.com>
References: <20230908055146.18347-1-Linhua.xu@unisoc.com>
 <20230908055146.18347-5-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908055146.18347-5-Linhua.xu@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 01:51:44PM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> Add the pin control driver for UNISOC UMS512 platform.

...

> +#define	PINCTRL_REG_OFFSET		0x34

0x0034

> +#define	PINCTRL_REG_MISC_OFFSET		0x434

...

> +static const struct of_device_id sprd_pinctrl_of_match[] = {
> +	{ .compatible = "sprd,ums512-pinctrl", },

Inner comma is not needed.

> +	{ }
> +};

-- 
With Best Regards,
Andy Shevchenko


