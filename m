Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93947CC46A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343833AbjJQNRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbjJQNRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:17:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11441FE1;
        Tue, 17 Oct 2023 06:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697548604; x=1729084604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/om8BPxyrRHxaMya3yQt03tcUalRD5u1e+/Rx1v1hy0=;
  b=SMc8nNLOFmRdViqrDSh1aEdSDWQjb/uxQ72Plt8NMwpsvZFaZj+MYxwN
   LynAumyJ5fKw5LG/RKIKYwfDHoSEMFW3KXvRIyBLi65KkvRV5vWBrrziF
   PvfAmRCxALXz+lQxeKcwxtdEaHyPTv81d/XtOeGZppp2eF5zeU0Y3s4t8
   T/n1axjaez7zxtWx7jx4wEIM6QHYOMkRWbkISJy+lmzNhnPEzyBYk/51B
   s+eUGZbxpXEejmPBiBGESwryll71gxMipKG5MVmbqYKrzEQ+O6+JAD+HJ
   n5zUmQS/8aRUNtFxfcVtlGDW1AzMc6xPyaU/OCaSWYHsqjnO79njA0dKz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="472002828"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="472002828"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 06:16:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="756114751"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="756114751"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 06:16:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsjw6-00000006IQR-095h;
        Tue, 17 Oct 2023 16:16:38 +0300
Date:   Tue, 17 Oct 2023 16:16:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 54/73] pinctrl: intel: drop the wrappers around
 pinctrl_gpio_direction_input()
Message-ID: <ZS6JNXWPkDW+aoYs@smile.fi.intel.com>
References: <20231017120431.68847-1-brgl@bgdev.pl>
 <20231017120431.68847-55-brgl@bgdev.pl>
 <ZS6BAkfFeA+6GYfz@smile.fi.intel.com>
 <CACMJSesgT-a8krB8gvf0gJ-C+p6s1TdRcE6W_42CxR9bDvrGHg@mail.gmail.com>
 <ZS6CGcRPNzkCdnoD@smile.fi.intel.com>
 <CAMRc=MdbYN+ropwecPbTptV7KEt-0NdWOHn1Uq_2dgWcPv-D=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdbYN+ropwecPbTptV7KEt-0NdWOHn1Uq_2dgWcPv-D=A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 02:55:07PM +0200, Bartosz Golaszewski wrote:
> On Tue, Oct 17, 2023 at 2:46 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Oct 17, 2023 at 02:44:25PM +0200, Bartosz Golaszewski wrote:
> > > On Tue, 17 Oct 2023 at 14:41, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Tue, Oct 17, 2023 at 02:04:12PM +0200, Bartosz Golaszewski wrote:
> > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > >
> > > > > pinctrl_gpio_direction_input() now has the same signature as the
> > > > > wrappers around it so we can drop them.
> > > >
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > >
> > > > Now, for the sake of symmetry can you add (at least to the all
> > > > Intel drivers you modified in this series) the following:
> > >
> > > Good idea but this is v6.8 material, I don't want to extend this
> > > series anymore at this point.
> >
> > Then let's postpone at least Intel and Cypress patches after v6.8-rc1 is out.
> 
> But then we'd have to postpone the renaming and we'd be stuck with
> both variants in the tree. This is suboptimal. We'd also have this
> huge series spanning two subsystems for 3 months during the v6.8
> release cycle in the tree causing conflicts and other issues.

I don't see how this is related. What I'm talking is only related to dropping
the wrappers in the drivers _after_ whatever you do with generic APIs.

> I'd prefer to merge this during the v6.7 merge window and then we can
> keep on improving it without affecting both trees. Linus will be
> taking those subsequent patches as usual.
> 
> Linus, what do you think?

-- 
With Best Regards,
Andy Shevchenko


