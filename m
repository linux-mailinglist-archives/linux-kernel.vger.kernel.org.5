Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FFB7BA0F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbjJEOrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjJEOoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:44:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CE313B70;
        Thu,  5 Oct 2023 07:21:41 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="363727183"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="363727183"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 01:42:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="701588130"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="701588130"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 01:42:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1qoJwI-00000002yg3-2o0k;
        Thu, 05 Oct 2023 11:42:34 +0300
Date:   Thu, 5 Oct 2023 11:42:34 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] pinctrl: denverton: Enable platform device in the
 absence of ACPI enumeration
Message-ID: <ZR52+s1qrYTuE4IF@smile.fi.intel.com>
References: <20230926190818.931951-1-andriy.shevchenko@linux.intel.com>
 <76d1e643-9b81-4c23-8f46-73fe59913600@kernel.org>
 <CAHp75VdKF+QfSsUwVSrSEng_xY_2ZW_0t0kBuXYPPcBi3_6LxQ@mail.gmail.com>
 <cac56745-f611-48c2-bb1b-e86a3694fa59@kernel.org>
 <CAHp75VeNG3cE5XmnhPyVQmR4Ppfk7CarSahU8-5Kpgg7TwLMjg@mail.gmail.com>
 <a244d004-e354-4917-b83d-d51158ba896d@kernel.org>
 <ZR52DZDCVEV3My5T@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZR52DZDCVEV3My5T@smile.fi.intel.com>
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

On Thu, Oct 05, 2023 at 11:38:38AM +0300, Andy Shevchenko wrote:
> On Thu, Oct 05, 2023 at 09:53:51AM +0200, Krzysztof Kozlowski wrote:
> > On 04/10/2023 21:42, Andy Shevchenko wrote:
> > > On Wed, Oct 4, 2023 at 4:20 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >> On 04/10/2023 15:09, Andy Shevchenko wrote:
> > >>> On Wed, Oct 4, 2023 at 11:18 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >>>> On 26/09/2023 21:08, Andy Shevchenko wrote:

...

> > >>>>> +MODULE_ALIAS("platform:denverton-pinctrl");
> > >>>>
> > >>>> Why do you need the alias? It's the same as ID table. You most likely
> > >>>> miss MODULE_DEVICE_TABLE() or your table is just wrong.
> > >>>
> > >>> This is cargo cult from pinctrl-broxton.c. If we want to fix, we need
> > >>> to fix both.
> > >>> Care to send patches?
> > >>
> > >> I don't understand how some other file affects this. Why do you exactly
> > >> need module alias here? Which use-case does not work without it (after
> > >> adding proper MODULE_DEVICE_TABLE())?
> > > 
> > > We try to keep these drivers uniform. So, if something should be done
> > > differently, it should be done for all affected drivers.
> > > Since patch is applied, now we have two drivers to improve.
> > 
> > Awesome reason. So if you add accidentally bug to one driver, it should
> > be copied to other file as well.
> 
> I'm not sure where it's a bug, it works. The problem is implementation
> and I believe Mika and certainly me agree with your points that
> MODULE_DEVICE_TABLE() is a right way to go.

The initial implementation was done by 0c3013bbe1d8 ("pinctrl/broxton:
enable platform device in the absence of ACPI enumeration"). It was
ACKed by the driver maintainer as this one. But again, we agree that
your way is better.

-- 
With Best Regards,
Andy Shevchenko


