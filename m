Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF0175294B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjGMRDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjGMRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:03:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12DC2700;
        Thu, 13 Jul 2023 10:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689267810; x=1720803810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XU4CSxnU4cVeY82reTW8Q0CzJu4o7aUuNfQXk1GU5gA=;
  b=kdt+w2WSZ9URNRZKiwcdMCUoXv2eOxc8pNpKAmtluDKj0wq0eiXOhSR5
   jULYpG8hjv8TAdwjdzXrA5z7G6NCeSmUL0X3GpQIlt/JH7jxyEJY+Undf
   i9ciZlwY2Zv35NQb+Jz96J2LgVmWVCPskST6G/gjaP7fxInE8G5Ggktuv
   OSRCWt5gxmGr6txLWC4LYoS2hw/Af2fqIc/G08bTN1VNYEAvOZR/aaEEd
   e30rbRRvaGpse9Z/mFd3toIaYwtrRiJduNDVMYG7IfWnFS60oFXG/x5nn
   DO2VVCVcpx86PyFjf/4SLcA8hmXFbISBfM0Z+PKdj0CUCFmZ3UHzi+bi9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345571759"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="345571759"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 10:01:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="896093125"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="896093125"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2023 10:01:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJzh4-002RXp-0i;
        Thu, 13 Jul 2023 20:01:30 +0300
Date:   Thu, 13 Jul 2023 20:01:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        "xingtong . wu" <xingtong.wu@siemens.com>
Subject: Re: [PATCH v2 0/2] leds: simatic-ipc-leds-gpio: add new model BX-21A
Message-ID: <ZLAt6RDjqyWhN/NU@smile.fi.intel.com>
References: <20230713115639.16419-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713115639.16419-1-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 01:56:37PM +0200, Henning Schild wrote:
> change since v1:
> - split into two patches to separate leds from platform code and ease
>   merging
> 
> These are rather simple patches adding LED support for yet another Simatic
> IPC model.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Henning Schild (2):
>   platform/x86: simatic-ipc: add another model BX-21A
>   leds: simatic-ipc-leds-gpio: add Elkhart Lake version
> 
>  drivers/leds/simple/Kconfig                   | 13 +++++
>  drivers/leds/simple/Makefile                  |  1 +
>  .../leds/simple/simatic-ipc-leds-gpio-core.c  |  4 ++
>  .../simatic-ipc-leds-gpio-elkhartlake.c       | 57 +++++++++++++++++++
>  drivers/platform/x86/simatic-ipc.c            |  3 +
>  .../platform_data/x86/simatic-ipc-base.h      |  3 +-
>  include/linux/platform_data/x86/simatic-ipc.h |  3 +-
>  7 files changed, 82 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c
> 
> -- 
> 2.41.0
> 

-- 
With Best Regards,
Andy Shevchenko


