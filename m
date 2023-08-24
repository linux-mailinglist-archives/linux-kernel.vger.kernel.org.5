Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5285B7870C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbjHXNqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241551AbjHXNpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:45:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C057F1BFE;
        Thu, 24 Aug 2023 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692884724; x=1724420724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FvrR39L3h/2sbt9YpJg7MCD3hE7al/LF2L/DbIn6iFE=;
  b=WY7fAfDgEIfB5HAGvuxnA8XX0+mEHRXXbhaOpAuGGVQFjO70XftoVGC+
   lwbe8f2S139faEZ2WvnVfCFjwhCjH/JN6Ywn3rZkVoOB3+xEICeJO5mhb
   nZ+c+xkWvVp+Jn3bsnwaQkI3Hi2RFmApyqTbnFMB46WKyIb4bjnlvCmeZ
   852ZhCnHGXf9yE/8+GuqbHMyloBuhQUCQrAS7Z4m9rJj/1ehDbe77uzgl
   th43Iu06NESFGQoigbHhb+IEL/qoShIBIGtoqyNj4rc7KpOLfSIMVcWLR
   8ZgnlwaR/KDoE83sqCWscP1ZVHVwzVBIeFzkIywiaY5B/SB78r3J1uAGU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="460799383"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="460799383"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="713978309"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="713978309"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2023 06:44:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qZAdA-005r4n-2a;
        Thu, 24 Aug 2023 16:44:12 +0300
Date:   Thu, 24 Aug 2023 16:44:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        quic_jhugo@quicinc.com, nipun.gupta@amd.com, tzimmermann@suse.de,
        ogabbay@kernel.org, mathieu.poirier@linaro.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, linux@zary.sk, arnd@arndb.de,
        yangyicong@hisilicon.com, benjamin.tissoires@redhat.com,
        masahiroy@kernel.org, jacek.lawrynowicz@linux.intel.com,
        geert+renesas@glider.be, devicetree@vger.kernel.org
Subject: Re: [PATCHv5 4/4] wiegand: add Wiegand GPIO bitbanged controller
 driver
Message-ID: <ZOderInKSX/vPpAl@smile.fi.intel.com>
References: <20230824111015.57765-1-m.zatovic1@gmail.com>
 <20230824111015.57765-5-m.zatovic1@gmail.com>
 <ZOdciyyM4/BYxXL9@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOdciyyM4/BYxXL9@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 04:35:08PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 24, 2023 at 01:10:15PM +0200, Martin Zaťovič wrote:

...

> > +Date:		August 2023
> 
> Unrealistic. Use https://hansen.beer/~dave/phb/ to define Date and
> KernelVersion fields.

Hint: should be for v6.7 at least.

-- 
With Best Regards,
Andy Shevchenko


