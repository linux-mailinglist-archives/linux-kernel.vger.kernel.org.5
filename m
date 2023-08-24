Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA9E787039
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbjHXN2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241355AbjHXN2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:28:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41649E5E;
        Thu, 24 Aug 2023 06:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692883694; x=1724419694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=psEOkkGtnM49+bw9Gf/k/pN/WxjaoGc+9hfLN7vrznE=;
  b=eiIZwo0lPvdHuvMx5GOe+bnXBXtH5QQGt1NJ+nfEEp2vT1eWrj4AgKRL
   svJLN9SkZBbh0IBmJ/P5rqzuljuNHFE84b6PyWaZh94U96JUzUuUN3P1X
   bb9SYzqZg/jtN7e17YzlQN2tl264u0UVNmXPJmz5oXxsmnSBIZQkJ0k78
   +Evun4wAd/seYa6BDJY7R0iAxKJc+vDtyP9HquP9BhgkZWfTfzlkHiCDD
   iLUoQFMkeZT6SSB/C2vDRabZBJs3EVvDeQXE4I7pJg0KBpXy8YZDJiNlr
   AP4foZTW5xLmOGh8ePwH7qFa12qzOL3sfsQCQeIBbEz/b7gHWtCl2nH5k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374402855"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="374402855"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:28:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="807127211"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="807127211"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2023 06:28:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qZANZ-005Igm-0x;
        Thu, 24 Aug 2023 16:28:05 +0300
Date:   Thu, 24 Aug 2023 16:28:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org,
        quic_jhugo@quicinc.com, nipun.gupta@amd.com, tzimmermann@suse.de,
        ogabbay@kernel.org, mathieu.poirier@linaro.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, linux@zary.sk, arnd@arndb.de,
        yangyicong@hisilicon.com, benjamin.tissoires@redhat.com,
        masahiroy@kernel.org, jacek.lawrynowicz@linux.intel.com,
        geert+renesas@glider.be, devicetree@vger.kernel.org
Subject: Re: [PATCHv5 2/4] wiegand: add Wiegand bus driver
Message-ID: <ZOda5RY/2yW6Y63Q@smile.fi.intel.com>
References: <20230824111015.57765-1-m.zatovic1@gmail.com>
 <20230824111015.57765-3-m.zatovic1@gmail.com>
 <2023082420-quaking-barley-47b4@gregkh>
 <ZOdSudrhg/9u3a9N@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOdSudrhg/9u3a9N@fedora>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 02:53:13PM +0200, Martin Zaťovič wrote:
> On Thu, Aug 24, 2023 at 01:40:35PM +0200, Greg KH wrote:
> > On Thu, Aug 24, 2023 at 01:10:13PM +0200, Martin Zaťovič wrote:

...

> > > +static inline void wiegand_controller_put(void *ptr)
> > 
> > Why is this a void *?  It should be "struct wiegand_controller *"
> 
> It is a void* because it is being passed to devm_add_action_or_reset()
> and this function only accepts a pointer to a function that accepts a void*
> parameter. I am not sure if there is a way around it.

I just replied with a deeper review with the answer to this.

> > Please never use void * if at all possible.

Correct. We better to have a type checking when possible. Esp. for the exported
functions.

-- 
With Best Regards,
Andy Shevchenko


