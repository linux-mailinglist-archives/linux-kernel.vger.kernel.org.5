Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F26B757F54
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjGROVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGROVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:21:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551A9B5;
        Tue, 18 Jul 2023 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689690085; x=1721226085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0861blgBMRAfvbFAlkcqEo4YjVxrPm0OzISkjLVjP7o=;
  b=eTVO0sYqjKyrre8ayf5rBQBbVJG/EU3QVnD/Jq/T8D1ve0qnKugWULcc
   ccCOQP++TcHHZIeGFmk07BDAZilHjaXgybPOEVrHgcFjTbwNpFoArVMZD
   CIIFjq0d2CMLBvzgPqNH+kQgAG2GRo1AugsPYifj7eDU1nWdRUOf2RoAR
   lUPmhE2EspOSPpvnE+yWAGwqXlBqkD1DjCnIKcGeUNpio4DiLcIG6M4vV
   3twpzIUCNT0Ac+tmyytGFb4x/XQPo9ohXi/KEr0yHvygcRwPooVL1s3Ka
   2LGJAty+j8VW1tWerpE/mlWxUAfgYSoQReRMrYmNekxLBSzua/PChI61H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432398328"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="432398328"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 07:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="717607969"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="717607969"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 18 Jul 2023 07:20:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLlZJ-00Grxd-0L;
        Tue, 18 Jul 2023 17:20:49 +0300
Date:   Tue, 18 Jul 2023 17:20:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Lee Jones <lee@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Mark Gross <markgross@kernel.org>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH 1/3] watchdog: make Siemens Simatic watchdog driver
 default on platform
Message-ID: <ZLafwOPrw+puH+rF@smile.fi.intel.com>
References: <20230718105213.1275-1-henning.schild@siemens.com>
 <20230718105213.1275-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718105213.1275-2-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 12:52:11PM +0200, Henning Schild wrote:
> If a user did choose to enable Siemens Simatic platform support they
> likely want that driver to be enabled without having to flip more config
> switches. So we make the watchdog driver config switch default to the
> platform driver switches value.

A nit-pick below.

...

>  config SIEMENS_SIMATIC_IPC_WDT
>  	tristate "Siemens Simatic IPC Watchdog"
>  	depends on SIEMENS_SIMATIC_IPC

> +	default SIEMENS_SIMATIC_IPC

It's more natural to group tristate and default, vs. depends and select.

>  	select WATCHDOG_CORE
>  	select P2SB

-- 
With Best Regards,
Andy Shevchenko


