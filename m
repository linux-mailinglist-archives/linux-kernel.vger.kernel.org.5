Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C41780CED4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343827AbjLKOvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjLKOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:51:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51132C3;
        Mon, 11 Dec 2023 06:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702306298; x=1733842298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S4r5MsVEd6B9dKPsibk/pAws6JbVMEJF4Gv4k+MoSxk=;
  b=YzdSwmuXC+nevRWd7FrF30SP2OLjxh4um5coC9WqBZRGb076V6UiixyM
   v0U1xIT2uyV8lm2uscmNNfYwiEnn71Ed58fW3RUqFdHwLqHoDOoP+VRmP
   0k1eFEqQdN5cbKrXnT5VeSAFowJDCdBKSU5a7uinersJ7ze9t70a7sYre
   dGP4mt0UwnSS4JlPv7jYk5EsB7ENPb4Hov/Ija2y1YDehdyeLEIVoTgAL
   Okok1A7llDk0NLSC0nPRC5Oj/9srmJLIOK1vrLfWcA3mI7HyoAVESoTDN
   VdWXBgWWRmmcdiHfuELqkVJ4R/kRXztjYQ76NjO++Kv/Pbuk4sAhxsSf8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1494711"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1494711"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 06:51:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="722830518"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="722830518"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 06:51:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rChd6-000000052cn-0qYw;
        Mon, 11 Dec 2023 16:51:32 +0200
Date:   Mon, 11 Dec 2023 16:51:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the pinctrl-intel tree with the
 gpio-brgl tree
Message-ID: <ZXch86yIH1pPwHC-@smile.fi.intel.com>
References: <20231211145056.23fbfd7d@canb.auug.org.au>
 <CACMJSetGz1fCnqS_HPTLyV8dOWOUtO07-bZKKXu3=3Lk2PGdyw@mail.gmail.com>
 <ZXcRMTFitYohcFfS@smile.fi.intel.com>
 <CACMJSeun5bCUwkVZPXpc5mKqyj_XztUHTXafuz5Psc_8LCKkuA@mail.gmail.com>
 <ZXchRJoxvn8I-6-L@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXchRJoxvn8I-6-L@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 04:48:36PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 11, 2023 at 03:04:09PM +0100, Bartosz Golaszewski wrote:
> > On Mon, 11 Dec 2023 at 14:40, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Dec 11, 2023 at 09:15:30AM +0100, Bartosz Golaszewski wrote:
> > > > On Mon, 11 Dec 2023 at 04:51, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > > > Today's linux-next merge of the pinctrl-intel tree got a conflict in:
> > > > >
> > > > >   drivers/pinctrl/intel/pinctrl-baytrail.c
> > > > >
> > > > > between commit:
> > > > >
> > > > >   c73505c8a001 ("pinctrl: baytrail: use gpiochip_dup_line_label()")
> > > > >
> > > > > from the gpio-brgl tree and commit:
> > > > >
> > > > >   6191e49de389 ("pinctrl: baytrail: Simplify code with cleanup helpers")
> > > > >
> > > > > from the pinctrl-intel tree.

...

> > > > Andy, please pull the following into your baytrail tree:
> > > > https://lore.kernel.org/lkml/20231208083650.25015-1-brgl@bgdev.pl/
> > >
> > > I can do it, but why?
> > 
> > You were the one who asked me to put these commits into an immutable
> > branch in the first place to avoid conflicts with the baytrail branch.
> > :)
> 
> True with the caveat like (citing by memory): "I see no conflicts with
> the code that needs this PR to be pulled, but just in case."
> 
> So, thank you for PR, but there is nothing pending in my tree that requires
> this PR to be pulled.
> 
> So, when I send the PR to Linus W. (presumably end of this week) it will be
> solved on his level, I believe.

Btw, Torvalds states that 1) conflicts are okay and even good to have
(shows that you don't sneak the last-minute modified code into the PR)
and 2) the any merge should be justified (like real dependency), the
conflict is not a dependency. Maybe that's what was unclear when I asked
you for PR...

> > > Conflicts is a normal practice during kernel development. And I believe this
> > > particular one will be solved by Linus W.
> > >
> > > Stephen, resolution looks correct to me, thank you.

-- 
With Best Regards,
Andy Shevchenko


