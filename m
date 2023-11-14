Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C1C7EB1FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjKNOUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjKNOU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:20:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C724418A;
        Tue, 14 Nov 2023 06:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699971624; x=1731507624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N8HloDum7I1cC4eEg1gfAFdHU8xz4cl4PXvQCbmBgMA=;
  b=j8gtv/QbIyR8BNnZ1tw5Zn7VTQRPd0t8B0Y7EhKKjkjZYoKAyVVodfQn
   7YDJyUziMmgWSLeU8U1nwqKcQR8AOACs2IIfe0IrJsd+BN1JYo1gZV2H9
   Z+JjCeW4MttdHOfxVgqyrjQH8BUyFow0Ar+ydE0imJuQ/fkoIhG/yilrx
   gYCyVXeDshUJkeV+hIT45wgrSojI2McMBwA2DQkIRHUBUg6FfbamJxb1m
   yYsdzrdbiBQmyw1huPbIKbygeOpflp92f1SLYuq/yyfLyxdQSNLAvRgNe
   N4M7Y3sOux2EYOLA7HqpaTv7MHfuQaqkGRXJoxBNKbrdCLEtQHn7mEb0f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="393519409"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="393519409"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 06:20:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="830608183"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="830608183"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 06:20:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2uH4-0000000DpnY-1fIi;
        Tue, 14 Nov 2023 16:20:18 +0200
Date:   Tue, 14 Nov 2023 16:20:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "larry.lai" <larry.lai@yunjingtech.com>
Cc:     lee@kernel.org, linus.walleij@linaro.org, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com
Subject: Re: [PATCH V7 0/3] Add support control UP board CPLD/FPGA pin control
Message-ID: <ZVOCIj1oPoEcKe7L@smile.fi.intel.com>
References: <20231031015119.29756-1-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031015119.29756-1-larry.lai@yunjingtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 09:51:16AM +0800, larry.lai wrote:
> The UP board <https://up-board.org/> is the computer board for 
> Professional Makers and Industrial Applications. We want to upstream 
> the UP board 40-pin GP-bus Kernel driver for giving the users better 
> experience on the software release. (not just download from UP board 
> github)
> 
> These patches are generated from the Linux kernel mainline tag v6.0.
> 
> This is the PATCH V7 and fixed kernel test robot compiler warning and 
> addressed Lee Jones review comments.

(You have trailing white spaces in the above multi-line paragraphs.)

Sorry for the delay, but this series needs much more work before being
considered for the inclusion. I just finished commenting each patch
individually.

-- 
With Best Regards,
Andy Shevchenko


