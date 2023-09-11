Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8008879ACAD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354009AbjIKVwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbjIKKFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:05:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85003E68;
        Mon, 11 Sep 2023 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694426726; x=1725962726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=00fLvhiMtv2ZiGvbKRwC5xfsj2n/I3VRQoCUrYTyoPk=;
  b=jl2GuVQ0iTI0oRz0MkQVdaxATSUIUcHK+EK6YhVdHvcJgr9/D9jaWFjr
   A0ptRbNEC0ApBO+JtBVMiFnMSCCOsTOZTdk5UD+iQDxVvje4Lqpz5pB08
   rbtxdHxQWRuoF1DydnelJ+U8SGeQgSrVK5TlZKQNAvEsOZdiVitA0n+9N
   BCZ7zruRf/ZgTd/SQDmUs9JWYzlhegseMge/UkDSffachRH+IbnEiEuQH
   rA314T4LTrq4x7K8//h2yN56JKIA85KdDhjqiT+YNGNkrS8mFamlnHS9R
   oItCnMlJ7jzIoTx5ZmUSpt/lEp46bwjfGZUqYm3xLfnbb5S7XemKSouiq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="363065949"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="363065949"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:05:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="866884962"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="866884962"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:05:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfdn9-008HnB-00;
        Mon, 11 Sep 2023 13:05:15 +0300
Date:   Mon, 11 Sep 2023 13:05:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH 11/21] platform: x86: android-tablets: don't access
 GPIOLIB private members
Message-ID: <ZP7mWk/jx3FZjMih@smile.fi.intel.com>
References: <20230905185309.131295-1-brgl@bgdev.pl>
 <20230905185309.131295-12-brgl@bgdev.pl>
 <8f51b4a8-bb9c-4918-61a8-4ab402da1ed0@redhat.com>
 <CAMRc=Mfmp3Nd5jwNWr=kc8RFO-arFDwEvLxj5Qu9_1OOXR2gHQ@mail.gmail.com>
 <173bdafa-08da-7473-6711-61131986eb3c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <173bdafa-08da-7473-6711-61131986eb3c@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 04:17:53PM +0200, Hans de Goede wrote:
> On 9/6/23 16:27, Bartosz Golaszewski wrote:
> > On Wed, Sep 6, 2023 at 3:01 PM Hans de Goede <hdegoede@redhat.com> wrote:

...

> > This makes sense! Maybe we'd need a good-old board file setting up all
> > non-described devices using the driver model?
> 
> Right, this is pretty much exactly what the x86-android-tablets
> code does. Except that it does it for a bunch of boards in a single
> .ko / driver. There is a lot of commonality between these boards,
> so this allows sharing most of the code.
> 
> The driver uses DMI matching, with the match's driver_data pointing
> to a description of which devices to instantiate and then the shared
> code takes care of instantiating those.
> 
> About 90% of the data / code is __init or __initdata so both
> the code to instantiate the devices as well as the per board
> data is free-ed after module_init() has run.

...which is nicely looked and isolated hack (or quirk if you prefer)
that I like! Thanks, Hans, for maintaining that!

-- 
With Best Regards,
Andy Shevchenko


