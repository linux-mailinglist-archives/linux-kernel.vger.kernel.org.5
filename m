Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88EA75CCFC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjGUQCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjGUQBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:01:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7E63A91
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689955313; x=1721491313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K9rkpTqbHpDBqeauTBa56f+QOF+7Knd4P5lfvCLE4XU=;
  b=AgD/S5vS0XB/RIVVAL1HbQjb0N2qdhOXLeAqatpnydrkSPUmiwD432fm
   RQa5J/apeEVooUZGYa+s8ZJ7HmrBLENZeQTRVbSGX4vYSU3zODkoLHAOY
   Y6XSbRYNRql9PLIrhe6fgBUh5m4dYarl6Sz73VkexbQUJTiY/QNp27omU
   nik/CbRwVc+D0odnZwEcDRNlgMX0kCtWFXCrwDH5Lre0fI4TDiZoRaG26
   CFoFPcLYPfcaDzWysCoLyRftHPoN7U0dycVxwrx8FeHsx0N256RsOgNeq
   F0w8oaJeACTZJMaPeCPFbtEpOOuNHlWyPyFh5VbDjeaMOqPfp3JmHuztS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="365947538"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="365947538"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:01:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="754507156"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="754507156"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2023 09:01:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMsZU-00BWpT-0C;
        Fri, 21 Jul 2023 19:01:36 +0300
Date:   Fri, 21 Jul 2023 19:01:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v1 1/1] minmax: Fix header inclusions
Message-ID: <ZLqr39JOLQ3QhRbQ@smile.fi.intel.com>
References: <20230721133932.12679-1-andriy.shevchenko@linux.intel.com>
 <202307212350.YQFKs9v6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307212350.YQFKs9v6-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:52:46PM +0800, kernel test robot wrote:
> Hi Andy,
> 
> kernel test robot noticed the following build errors:

Oh my...
UM without this header or even a stub?!

Hmm... Which one else? Let's wait a few days to see.

>    In file included from arch/um/os-Linux/sigio.c:6:
>    In file included from include/linux/minmax.h:5:
>    In file included from include/linux/build_bug.h:5:
> >> include/linux/compiler.h:246:10: fatal error: 'asm/rwonce.h' file not found
>      246 | #include <asm/rwonce.h>
>          |          ^~~~~~~~~~~~~~

-- 
With Best Regards,
Andy Shevchenko


