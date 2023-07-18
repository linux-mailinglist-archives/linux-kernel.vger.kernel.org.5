Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86026757F28
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjGROOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjGROOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:14:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187F0186
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689689678; x=1721225678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m0GJdSP7yKkTbtOyQJVW5Qno/NOUwW244XkoiiUkviA=;
  b=czlH/znhMiuBy0RkoR+fPDx0SOeSosidjMDZmmOmvMvW+DDCHBi90qRB
   NRjh3fXagNULk4tdJkG9ZSq1yjSp0ODQ7BHZOwOzXzeedcmA03KP33cRl
   BnE03GEwiefigh7zoOiOybLHhQqD051gCbrdsrKXt3avMhsh0k5tUq9iz
   bD9ZCaDVeEbjVsfJtArVtMPIjs1V8QGk8mD5IAceDbep7+tQFjzgdMmiL
   4BRb5vY0wBlEAjP8S6J3od+K6pfwOAo7RW9p4gR0PzsUG+sAQQhgjdzaJ
   9IiV2Q+5HU6ZjvwithC3qtVoAm8I8ao0dmwn15YO9phsF8XeHlLD2DpdB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="429976875"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="429976875"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 07:13:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="1054299206"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="1054299206"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jul 2023 07:13:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLlRm-00Gb33-0m;
        Tue, 18 Jul 2023 17:13:02 +0300
Date:   Tue, 18 Jul 2023 17:13:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v3 5/5] arm64: mte: add compression support to mteswap.c
Message-ID: <ZLad7sFvQ3rEDN5o@smile.fi.intel.com>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-6-glider@google.com>
 <ZLVH6t25HD+HhCka@smile.fi.intel.com>
 <CAG_fn=Xvb9_K+vTLERVnNOSYMmn9+vt7SOMe_TJTAc=B0UtRKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=Xvb9_K+vTLERVnNOSYMmn9+vt7SOMe_TJTAc=B0UtRKQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 12:48:00PM +0200, Alexander Potapenko wrote:

...

> > > +void _mte_free_saved_tags(void *storage)
> > > +{
> > > +     unsigned long handle = xa_to_value(storage);
> > > +     int size;
> > > +
> > > +     if (!handle)
> > > +             return;
> >
> > Perhaps
> >
> >         unsigned long handle;
> >
> >         handle = xa_to_value(storage);
> >         if (!handle)
> >                 return;
> 
> I don't have a strong preference and am happy to change this, but, out
> of curiosity, why do you think it is better?
> This pattern (calling (even non-)trivial functions when declaring
> variables) is widely used across the kernel.
> Or is it just for consistency with how `handle` is used in the rest of the file?

Ah, it's pure maintenance and error prone approach in case some code is sneezed
in between.

Imagine that you have


	foo = bar(x);
	...many lines that by some reason don't make one page on the screen...
	if (!foo)
		...do something...

Now if by unsuccessful rebase or by non-experienced developer we got

	foo = bar(x);
	...part 1 of many lines that by some reason don't make one page on the screen...
	baz(foo);
	...part 2 of many lines that by some reason don't make one page on the screen...
	if (!foo)
		...do something...

the compiler will eliminate the check — you got your mine on the nice minefield!

> > > +}

-- 
With Best Regards,
Andy Shevchenko


