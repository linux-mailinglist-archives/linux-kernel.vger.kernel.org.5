Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AD47EA0BF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjKMP6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKMP6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:58:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65D910DA;
        Mon, 13 Nov 2023 07:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699891127; x=1731427127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N7kzXyIt0QpnYXS9pgj96jxoxq8wbs0NMfKL/kdARyc=;
  b=llTF/xRO7O7Ms0+N+EOg3tneafedQT5ZP31M2UofVtYKre/m/exStbht
   BbW1CxuC2BcTv7o4V3/VzrNaJhHsNtW9SbuPiFmuBdnGYDcYUGLAfV650
   SDPvVzILSzdWLXvn+a1U+8typ9CpN578fefP8THZnjBlgBXDHQSo3Cq0Z
   I6TTd2fSltfdi2QKGT+IXfLImo4ZKoqBCSR2Bydfzs0Q/Q7KR2QGnYxub
   WXFJs1UuP0rZZKPxVKlOTlD54149Rz8/JL2sLz1bJAUrnbgKMvDojrMst
   NowhlB+3wTPxTfLIxYk8q4Jd6JOaUfBNZUSZEfqcjtIGs8lalnK1FRwoA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="12010577"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="12010577"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 07:58:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="908081388"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="908081388"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 07:58:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2ZKd-0000000DbDj-05eK;
        Mon, 13 Nov 2023 17:58:35 +0200
Date:   Mon, 13 Nov 2023 17:58:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        mika.westerberg@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1 0/3] Use the standard _PM_OPS() export macro in Intel
 Tangier GPIO driver
Message-ID: <ZVJHqrj5OzoWav5Z@smile.fi.intel.com>
References: <20231113131600.10828-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113131600.10828-1-raag.jadav@intel.com>
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

On Mon, Nov 13, 2023 at 06:45:57PM +0530, Raag Jadav wrote:
> This series exports pm_ops structure from Intel Tangier GPIO driver using
> EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS() helper and reuses it into its users.

Yet you missed --base...

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


