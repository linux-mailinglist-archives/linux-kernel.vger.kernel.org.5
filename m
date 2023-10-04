Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B21E7B7FE7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242430AbjJDMzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjJDMzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:55:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CAF98;
        Wed,  4 Oct 2023 05:55:13 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="363428128"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="363428128"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 05:55:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="727986027"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="727986027"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 05:55:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1qo1PA-00000002m6Q-3nLR;
        Wed, 04 Oct 2023 15:55:08 +0300
Date:   Wed, 4 Oct 2023 15:55:08 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 00/36] pinctrl: don't use GPIOLIB global numberspace in
 helpers
Message-ID: <ZR1grD639yif7hS7@smile.fi.intel.com>
References: <20231003145114.21637-1-brgl@bgdev.pl>
 <CACRpkdY03QUkHcmyfTTfvVFbmNujW3qg5GcNJ-=8zj_zvGqDeg@mail.gmail.com>
 <CAMRc=Md7QKYqRaytw2xG8hqTmEDmZGxFfDyGZqoE96h-CvmJcw@mail.gmail.com>
 <CACRpkdZkQ8tJz=94rKGB4DcEC0z8HJHieZn5FD+-efRU-897Pw@mail.gmail.com>
 <CAHp75VfWi91WaJuoW0NWrHH9=KRjOcrwwCeiXhnBd6Wg+o2Qow@mail.gmail.com>
 <CAMRc=Mf2820qT=h9GYFyKfG9jQjbFGTgsV4Uv=D-C853hOp79g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mf2820qT=h9GYFyKfG9jQjbFGTgsV4Uv=D-C853hOp79g@mail.gmail.com>
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

On Wed, Oct 04, 2023 at 11:40:39AM +0200, Bartosz Golaszewski wrote:
> On Wed, Oct 4, 2023 at 11:36 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Oct 4, 2023 at 11:42 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Wed, Oct 4, 2023 at 10:12 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > > What is your view on Andy's and Kent's issues with the _new() name
> > > > suffix?

...

> > You can go with a compromise and name it better from the start, so at
> > least the patches that are taking care of renaming back won't be
> > needed.
> 
> What are you talking about?! The names are *FINE*. I DON'T want to
> change them. I want to keep them. The temporary renaming is there to
> make the review process easier but the end effect is that the names
> stay the same with only the signature changed.

I just replied how to leave with renamings done only in a single place
(pinctrl core). Would it work for you?

> > Another way to have three or so patches with combined efforts, but still...

-- 
With Best Regards,
Andy Shevchenko


