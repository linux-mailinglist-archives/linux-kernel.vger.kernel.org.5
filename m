Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB687B7F94
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242429AbjJDMpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjJDMpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:45:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB87A6;
        Wed,  4 Oct 2023 05:45:46 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="380434375"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="380434375"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 05:45:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="751266672"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="751266672"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 05:45:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1qo1Fg-00000002lzt-0GOm;
        Wed, 04 Oct 2023 15:45:20 +0300
Date:   Wed, 4 Oct 2023 15:45:19 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 30/36] pinctrl: remove old GPIO helpers
Message-ID: <ZR1eX0rrQHj7kyuN@smile.fi.intel.com>
References: <20231003145114.21637-1-brgl@bgdev.pl>
 <20231003145114.21637-31-brgl@bgdev.pl>
 <CAHp75VdvUUw77MuuhY3Ts9L0ezOdakyppQcnikpYCu672Ghb9Q@mail.gmail.com>
 <CAMRc=MdtdS6+8TL1edRzu_=ZT3mgfRud1YEx9ZAQcYprUj+yew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdtdS6+8TL1edRzu_=ZT3mgfRud1YEx9ZAQcYprUj+yew@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 10:49:25AM +0200, Bartosz Golaszewski wrote:
> On Tue, Oct 3, 2023 at 5:21 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Oct 3, 2023 at 5:51 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

...

> > > Old variants of pinctrl GPIO helpers are no longer used. Let's remove
> > > them as well as convert all static functions in pinctrl/core.c that
> > > still deal with global GPIO numbers to using the gpio_chip + offset
> > > pairs.
> >
> > This patch does three thighs as I see it.
> >
> 
> I'd argue it just fold the code that lived in old functions into the new ones...
> 
> > First of all, it silently converts to RAII. Please, do this separately.
> 
> ... and while at it, it already switches to SBRM because why copy outdated code.

This is too big thing for "while at it".
If you care about that switch, do it beforehand.
But at bare minimum it should be a separate patch.

> > Second, it shuffles a lot of code between old and new implementations.
> > What I prefer to see is what the subject tells: only "-" (minus)
> > lines.
> > Third, it will become easier if you name the "new" functions better to
> > begin with, it will help a lot here.
> 
> I'll wait for Linus to tell me if he prefers one big squashed commit
> or a fine-grained history (I prefer the latter) before spending time
> splitting this commit.

Definitely, changing code to SBRM is out of scope of this series and should be
done in a separate patch at least.

-- 
With Best Regards,
Andy Shevchenko


