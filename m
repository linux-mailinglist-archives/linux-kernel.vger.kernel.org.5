Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C94A77F3DC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349818AbjHQJti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbjHQJtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:49:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E0130FF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692265700; x=1723801700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i/th1Kc0rgUb+9AotX9/L/yDAJlzprhou054V2WEWB0=;
  b=dwZqsecGUVRwH69cNR8vIMEkU7+4LIm+F16GEt86wOWfa0NEXpqKpmXi
   VeCLcgh663084drY3gcc8tHaAdMEVkCQze9Faoz/zZHFDnzZgrjHznlzO
   QmydH7mL0mhU0tPctVOLHhyuut6bx2csidv0g/QxCqNP41/GPZ0XVPEkl
   0b4qfKpAjyYtFtls7XeaITzSpxxgf6/uLS8uMucHezRTkmD2rEApd23ya
   8Y3OFD4kxVWZq3hMSz5RfjVZFcipMZERJbw1JvhNS2Rk4tMP2yL1tZlx2
   3+tBltqUAsF18apfyqRKuOYqD+8e+Q9LLOKIJwVlaLPdwYdjlehGm+fu7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403745118"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="403745118"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 02:47:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848827098"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="848827098"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 02:47:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWZbh-005qEe-0q;
        Thu, 17 Aug 2023 12:47:57 +0300
Date:   Thu, 17 Aug 2023 12:47:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 7/8] bitmap: drop _reg_op() function
Message-ID: <ZN3szFnWIBtFwg9K@smile.fi.intel.com>
References: <20230815233628.45016-1-yury.norov@gmail.com>
 <20230815233628.45016-8-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815233628.45016-8-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 04:36:27PM -0700, Yury Norov wrote:
> Now that all _reg_op() users are switched to alternative functions,
> _reg_op() machinery is not needed anymore.

...

> - * Can set, verify and/or release a region of bits in a bitmap,
> - * depending on which combination of REG_OP_* flag bits is set.
> - *
> - * A region of a bitmap is a sequence of bits in the bitmap, of
> - * some size '1 << order' (a power of two), aligned to that same
> - * '1 << order' power of two.

Just wondering if we have some equivalent to the above doc in the
existing kernel doc of users of this.

-- 
With Best Regards,
Andy Shevchenko


