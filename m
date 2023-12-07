Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4CC808894
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379438AbjLGMzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379433AbjLGMzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:55:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F88F10D9;
        Thu,  7 Dec 2023 04:55:08 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1092427"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1092427"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 04:55:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="945023202"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="945023202"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 04:55:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rBDu9-00000002bQn-0y5W;
        Thu, 07 Dec 2023 14:55:01 +0200
Date:   Thu, 7 Dec 2023 14:55:00 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     tanzirh@google.com, Kees Cook <keescook@chromium.org>,
        oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <ZXHApFX1mXZnP5lz@smile.fi.intel.com>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <202312061429.BJ7GrHnt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312061429.BJ7GrHnt-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 03:10:46PM +0800, kernel test robot wrote:
> Hi,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 33cc938e65a98f1d29d0a18403dbbee050dcad9a]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/tanzirh-google-com/lib-string-shrink-lib-string-i-via-IWYU/20231206-050121
> base:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
> patch link:    https://lore.kernel.org/r/20231205-libstringheader-v1-1-7f9c573053a7%40gmail.com
> patch subject: [PATCH] lib/string: shrink lib/string.i via IWYU
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231206/202312061429.BJ7GrHnt-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312061429.BJ7GrHnt-lkp@intel.com/reproduce)

...

>    lib/string.c:124:49: note: in expansion of macro 'WORD_AT_A_TIME_CONSTANTS'
>      124 |         const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;

> cba8df4be3bdf1 Paul Mundt 2012-06-04 @15  #define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0x01), REPEAT_BYTE(0x80) }

REPEAT_BYTE() shouldn't be even in kernel.h to begin with!

-- 
With Best Regards,
Andy Shevchenko


