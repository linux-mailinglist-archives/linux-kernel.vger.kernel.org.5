Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8A67CF8A1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345484AbjJSMV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjJSMV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:21:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84658CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697718084; x=1729254084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ncUbsRiztzN7102zxWecLH6p+ntw3u7TveZwYYupNR4=;
  b=ZfsslIk4DGvY5kmAYayKoJEZwkBCioZU3WYm2pc8kyCw5FaFuQ6qat1L
   WTCUu7Oh2sDGhYpUaMKFggSowXkuxZXpbQBOcf7uvVhgUtH89/KTJchav
   di6spt1/gcLm/HCLKIUrRkcRJgo+aCoC47i1I88KxBLJw6bOL5vcegEl/
   GDgVoUZsHcgtrVMKWOcYwBmW69CPbZx7QOfrdFBOvhzT7GkKIkGHMnAc6
   UmrXxMEU4tQLwmAHxgUPPZTpJDmuCfmSWdPHoxzwf7XbH+8BLQ3YXAB/F
   Jk1lGoH5/Ej0/dXs95pecmBrD4UW74y53xW+1WDt1N+ZiVKPk7h9Xz6ej
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="371299090"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="371299090"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:21:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="930588081"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="930588081"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:21:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qtS1a-00000006rHQ-2uXD;
        Thu, 19 Oct 2023 15:21:14 +0300
Date:   Thu, 19 Oct 2023 15:21:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, pmladek@suse.com,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] lib/vsprintf: Remove redundant code
Message-ID: <ZTEfOiP3wO56rrRq@smile.fi.intel.com>
References: <20231018064817.86721-1-jiapeng.chong@linux.alibaba.com>
 <f89a00c8-2ea2-4ef1-909e-2eaf7bc17cf9@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f89a00c8-2ea2-4ef1-909e-2eaf7bc17cf9@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 01:51:45PM +0200, Rasmus Villemoes wrote:
> On 18/10/2023 08.48, Jiapeng Chong wrote:

...

>  Or may reveal that the current code is buggy.

...and hopefully didn't become a part of any ABIs...

-- 
With Best Regards,
Andy Shevchenko


