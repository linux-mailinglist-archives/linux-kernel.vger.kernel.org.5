Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED6077298D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjHGPny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjHGPnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:43:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F931E5A;
        Mon,  7 Aug 2023 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691423030; x=1722959030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IRXKJYW2m/j0IMeXZnJtAaORb/wabIJmS21yjRvGoUc=;
  b=dLEdyE2uQr5z5VbK87Hp8J0IiC+QD7A5Cp3b/qq24pu6mKXcXOrJ1rfF
   wx6PTlK4Sos7/unB+DXCVmgDzCwZQNvybTK+qUUgyu+0x0+OtUmwISPNx
   Io0Ic+3hMriHKEm38KP8crwfYUSDpfUD3oAUFhqKXhIFOa/gq/Jo2EfZS
   kLcJtp4XwooNT4+klwdaFAfjhlLkwd3EYfoymHFuE6mliRHHq0zkJEtTV
   TmbVvxlNiO8SlSDGxg3+29j9at+/M6su4LCGDSsTGspE5AByUU+AD78FS
   0FV2HeWHndTyUlu9BtVHspIhJF0GLMEwZ2XtE4kJkNN2gvneWIOSTDFDr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350885357"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="350885357"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 08:43:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="731019283"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="731019283"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 07 Aug 2023 08:43:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qT2OY-000K23-2L;
        Mon, 07 Aug 2023 18:43:46 +0300
Date:   Mon, 7 Aug 2023 18:43:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: pressure: bmp280: i2c: Rearrange vars in
 reverse xmas tree order
Message-ID: <ZNERMrPeftok9LF8@smile.fi.intel.com>
References: <cover.1691276610.git.ang.iglesiasg@gmail.com>
 <80c7bf32dee57a4a21e5c623b9adbc5e1175f2de.1691276610.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80c7bf32dee57a4a21e5c623b9adbc5e1175f2de.1691276610.git.ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2023 at 01:15:02AM +0200, Angel Iglesias wrote:
> Minor cleanup reordering local variable declarations following reverse
> christmas tree convention.

What about other functions there? Are all of them ordered correctly?

-- 
With Best Regards,
Andy Shevchenko


