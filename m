Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70477E2BD7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjKFSYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjKFSYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:24:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42E794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699295049; x=1730831049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iGlx7of+BqvZT5kCwEYhVAUHVoc2yC09/DNgqviWlfU=;
  b=a8LCzUqS49s366jaFSRHwlQrIWatkNFhBtNVEZQj4raoecv9l52Xnxc2
   IRPHJ11+tK5GprTOOnYJ/h2WMGwFmJKKxsc43qlL0a8ITpmmEOD57xRUl
   wb2QuuCdo/zNg5mPcpjrxdajz8m/sTNbaYAFIYRmprMdQqfmw5RjXZYIy
   aWZ70jkxcIvq3r7gKVzaZU1OrqrWNe6xDTWoooC9U16++SP0aii8t24IK
   ZmwRLMILx1wQoSs8OH+hrEZpw+4GdO5rw8gd8AoOEXupv2VFU20kUjfAD
   eyRAqShzCKiWaktbD2F/6CZS3yJMuxbJRjdzkopUfQv1Ux617spyMtvhl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="455820568"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="455820568"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 10:23:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="766043858"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="766043858"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 10:23:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r04GP-0000000Bs69-0rTT;
        Mon, 06 Nov 2023 20:23:53 +0200
Date:   Mon, 6 Nov 2023 20:23:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [alobakin:pfcp 11/19] include/linux/bitmap.h:642:17: warning:
 array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]'
Message-ID: <ZUkvOCxyiin_77qd@smile.fi.intel.com>
References: <202310170708.fJzLlgDM-lkp@intel.com>
 <bd7fe929-c6fc-42be-9d2f-3f53ec21fd10@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd7fe929-c6fc-42be-9d2f-3f53ec21fd10@intel.com>
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

On Mon, Nov 06, 2023 at 05:31:34PM +0100, Alexander Lobakin wrote:

> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202310170708.fJzLlgDM-lkp@intel.com/

> Not sure how to approach this :z It was also captured on the version you
> sent 2 weeks ago, so this could've been resolved already.

Is it in the repository already? if so, we should revert it.
Otherwise you have time to think and fix.

-- 
With Best Regards,
Andy Shevchenko


