Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9817B03D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjI0MTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjI0MTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:19:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F399FC;
        Wed, 27 Sep 2023 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695817156; x=1727353156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQlnGg2+PmM8LyPFXpD+spP8XXKe98dRUKKao682eSU=;
  b=S+8wmEnbjrd1A0iNKPgZNekJQMD8adLtbA3zAdy/SY0pdYSO/1sRvXWD
   VQEX7JMvPsKob5yO2YsZgFgRcALV5YEbLaIgOJnbrO0OVoqXHEKSKBbfH
   FnxFCPttR7i+cylteB9TYQ+dG1SLfTgwoiL8KsaRf+9Sk41tWaQOsdkU1
   XLwvtdfvxDRfN7kzQ8qmCsS+nBufFMzzpfXovb+Vg6OLqhLyRFMkt0+gq
   KKgZmpVfYKWQZ0mSvEmnraRkNjlbu6fTytA7w/1zm/ps8Ubc4X8gPw/Fd
   wpvaB802+ubFADi935gmcGvKcDwKCOF+epStrcWJ19Hl1HPEVSo6e0Ipo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381711346"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="381711346"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 05:19:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752551892"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="752551892"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 05:19:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qlTVX-00000000sex-1N2v;
        Wed, 27 Sep 2023 15:19:11 +0300
Date:   Wed, 27 Sep 2023 15:19:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] pinctrl: denverton: Enable platform device in the
 absence of ACPI enumeration
Message-ID: <ZRQdvrdm4UtDs86x@smile.fi.intel.com>
References: <20230926190818.931951-1-andriy.shevchenko@linux.intel.com>
 <20230927074355.GZ3208943@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927074355.GZ3208943@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:43:55AM +0300, Mika Westerberg wrote:
> On Tue, Sep 26, 2023 at 10:08:18PM +0300, Andy Shevchenko wrote:
> > This is to cater the need for non-ACPI system whereby
> > a platform device has to be created in order to bind
> > with the Denverton pinctrl platform driver.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


