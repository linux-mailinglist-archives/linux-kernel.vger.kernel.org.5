Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EAA77FB21
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353312AbjHQPr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjHQPrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:47:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD24A30D1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692287243; x=1723823243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MCSLwMZ4WasZRVsOE5qv9ujXSf/pPYVAtXBsbhfemIQ=;
  b=KbMn/XGKQJuNpjbkzxdYiR5yt4QptFKQmYg0VZ4bs7ygXxzOaSOnjEBj
   z06FbLoa9CbREqcHY+k2KP3t8uraLtyXMOGHerHPH4ure0Oheq0YsFSIB
   el+xEQOvRoiG2bsUcA8DB5yCfrj7js5p164zzkr3xnrdJQWuKoK40pd6h
   CA5SNO0ClxnfyU2b+DsJbhZvpSjre76AJrXUN36611qBxPK8sSWzlWy+c
   VNRE5i2SIN8+vdYtKwtG734rq9E4iwnlGrfS+jHY0Sb1V4+AlGTmKzPFr
   NxnF/ywx+4CJ56FYzLhzogQXuJy/DnV4lY2x65O37b3DxtIp6r5EG8TK1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="353157702"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="353157702"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="728180615"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="728180615"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 17 Aug 2023 08:47:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWfDS-000YEt-30;
        Thu, 17 Aug 2023 18:47:18 +0300
Date:   Thu, 17 Aug 2023 18:47:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 1/8] bitmap: align __reg_op() wrappers with modern
 coding style
Message-ID: <ZN5BBovuzGmlfufh@smile.fi.intel.com>
References: <20230815233628.45016-1-yury.norov@gmail.com>
 <20230815233628.45016-2-yury.norov@gmail.com>
 <ZN3q5bWbnKM9+gwg@smile.fi.intel.com>
 <ZN4tIS/aYYPUr6qv@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN4tIS/aYYPUr6qv@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 07:22:25AM -0700, Yury Norov wrote:
> On Thu, Aug 17, 2023 at 12:39:49PM +0300, Andy Shevchenko wrote:
> > On Tue, Aug 15, 2023 at 04:36:21PM -0700, Yury Norov wrote:
> > > Fix comments so that scripts/kernel-doc doesn't warn, and fix for-loop
> > > style in bitmap_find_free_region().
> > 
> > Suggested-by?
> 
> Can you send a full tag?

I thought it's easy to get... Nevertheless it's here.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Btw, there are things needs to be fixed/improved as well:
1) bitmap_pos_to_ord(): reference to @nbits instead of @bits;
2) bitmap_parse(): wrong/confusing reference to a list, while
   should be better example for under 32-bit input and over it with spaces
   and/or commas;
3) style of the descriptions of the parameters:
     *   @param :
   vs.
     * @param:  /// preferable
4) bitmap_cut(): make nbits a reference as @nbits in some cases;
5) empty line after the function summary (should be dropped),
   e.g. in bitmap_parse_user();
6) true and false can be referred )in bitmap_print_to_buf(), for example)
   as constants %true. %false (up to you).

Maybe something else... That said, the documentation should be revisited
carefully.

-- 
With Best Regards,
Andy Shevchenko


