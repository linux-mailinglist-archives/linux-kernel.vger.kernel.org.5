Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9960B7BA480
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbjJEQGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237610AbjJEQEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D49B3D1E;
        Thu,  5 Oct 2023 07:28:42 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="449939152"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="449939152"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 01:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="842305045"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="842305045"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 01:38:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1qoJsU-00000002ydG-0uwr;
        Thu, 05 Oct 2023 11:38:38 +0300
Date:   Thu, 5 Oct 2023 11:38:37 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] pinctrl: denverton: Enable platform device in the
 absence of ACPI enumeration
Message-ID: <ZR52DZDCVEV3My5T@smile.fi.intel.com>
References: <20230926190818.931951-1-andriy.shevchenko@linux.intel.com>
 <76d1e643-9b81-4c23-8f46-73fe59913600@kernel.org>
 <CAHp75VdKF+QfSsUwVSrSEng_xY_2ZW_0t0kBuXYPPcBi3_6LxQ@mail.gmail.com>
 <cac56745-f611-48c2-bb1b-e86a3694fa59@kernel.org>
 <CAHp75VeNG3cE5XmnhPyVQmR4Ppfk7CarSahU8-5Kpgg7TwLMjg@mail.gmail.com>
 <a244d004-e354-4917-b83d-d51158ba896d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a244d004-e354-4917-b83d-d51158ba896d@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 09:53:51AM +0200, Krzysztof Kozlowski wrote:
> On 04/10/2023 21:42, Andy Shevchenko wrote:
> > On Wed, Oct 4, 2023 at 4:20 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> On 04/10/2023 15:09, Andy Shevchenko wrote:
> >>> On Wed, Oct 4, 2023 at 11:18 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>>> On 26/09/2023 21:08, Andy Shevchenko wrote:

...

> >>>>> +MODULE_ALIAS("platform:denverton-pinctrl");
> >>>>
> >>>> Why do you need the alias? It's the same as ID table. You most likely
> >>>> miss MODULE_DEVICE_TABLE() or your table is just wrong.
> >>>
> >>> This is cargo cult from pinctrl-broxton.c. If we want to fix, we need
> >>> to fix both.
> >>> Care to send patches?
> >>
> >> I don't understand how some other file affects this. Why do you exactly
> >> need module alias here? Which use-case does not work without it (after
> >> adding proper MODULE_DEVICE_TABLE())?
> > 
> > We try to keep these drivers uniform. So, if something should be done
> > differently, it should be done for all affected drivers.
> > Since patch is applied, now we have two drivers to improve.
> 
> Awesome reason. So if you add accidentally bug to one driver, it should
> be copied to other file as well.

I'm not sure where it's a bug, it works. The problem is implementation
and I believe Mika and certainly me agree with your points that
MODULE_DEVICE_TABLE() is a right way to go.

-- 
With Best Regards,
Andy Shevchenko


