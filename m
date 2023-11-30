Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57497FF8F3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjK3SAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjK3SAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:00:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AEA103;
        Thu, 30 Nov 2023 10:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701367220; x=1732903220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0/A5/goMjTlKWOCgMDBXlspOvINKnyhEr5/eCD6JmJc=;
  b=PAT0Ss+cPFNYCzpO1PYWF5/7iDnzNgEQ8MCmQXcurt80q6Az4ZDjNami
   6ndGHe6GCaz1/pLJtDd8aioqgsQXivwjsacPLMenKK86FLVp6spVF075y
   YEGSO7gGD/k7H5ZP25tyBO59TUUukrMnKIEKN3IitICo93U/Jy5j+ot6o
   PPt9MkshQo0hj32yD4hJRymJrkI51kJW0nc4B3ZJSnMgd2WeY7vxZnm1s
   eAydCZuiUcK9tKXJteVdIPAjIaBeOX0zrSkB9oEGh8hm/XUZ8MZpz5eWv
   tn5KtrrvUze5QJMhRkUEuKtthEmK+LNReR+7KfIhmZ5aHssLs0CsaL93Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="378391949"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="378391949"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 10:00:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="745722742"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="745722742"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 10:00:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8lKh-00000000m4P-3ZXT;
        Thu, 30 Nov 2023 20:00:15 +0200
Date:   Thu, 30 Nov 2023 20:00:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 01/10] gpiolib: provide gpiochip_dup_line_label()
Message-ID: <ZWjNr6ae4VPTbuvP@smile.fi.intel.com>
References: <20231130134630.18198-1-brgl@bgdev.pl>
 <20231130134630.18198-2-brgl@bgdev.pl>
 <ZWi34tkzNsvkCQqi@smile.fi.intel.com>
 <CAMRc=McLyT9h=VGPwserUgwmXOtNx4k2Za7j8VEwAqu7ChXZzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McLyT9h=VGPwserUgwmXOtNx4k2Za7j8VEwAqu7ChXZzQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 06:48:06PM +0100, Bartosz Golaszewski wrote:
> On Thu, Nov 30, 2023 at 5:27 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Nov 30, 2023 at 02:46:21PM +0100, Bartosz Golaszewski wrote:

...

> > > +     char *cpy;
> >
> > So, why not naming it fully, i.e. "copy"?
> >
> 
> Ekhm... let me quote the BigPinguin :)
> 
> --
> 
> C is a Spartan language, and your naming conventions should follow suit.
> Unlike Modula-2 and Pascal programmers, C programmers do not use cute
> names like ThisVariableIsATemporaryCounter. A C programmer would call that
> variable ``tmp``, which is much easier to write, and not the least more
> difficult to understand.

In contrary the cpy is more difficult to understand.

`git grep -lw cpy` vs. `git grep -lw copy` suggests that my variant
is preferable (even excluding tools/ and Documentation/).

-- 
With Best Regards,
Andy Shevchenko


