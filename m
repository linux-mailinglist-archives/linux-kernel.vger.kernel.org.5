Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95811757F60
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjGROXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGROXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:23:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACBC123;
        Tue, 18 Jul 2023 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689690215; x=1721226215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hYCr8FDXxRjThtXOv2d9yz4QI6g518XqEPlLA9Ia2Sc=;
  b=FAaB8Jdjq7ZAZmLsg/pvMLlhjr1toacQQUWX2phYe8vYg+UVHbRHUHdM
   yKMuI/5M1Wv6u99u8U2VyPxTFScRujNvRW0OMq7H2qIxEtjgw8BFGF/Bt
   6qWuTAZk1/1AyU4B4mPpDXhddWr1QAwyAGoasr8iSDhE7R2my/PD/zdXA
   mJmCxSN9cPHWXHiaAazbEhuI35z7ZaCIOZjSqwZQW46hvru4CRzBh3sfN
   OykdP13OeoNK/LDv4qUdZPBEcEpxHnf6Bu8Y8geWPEh2aDa7T4S+7pJN4
   u56BtByWOa5ArqDtVf9DYUz4iEYlsVlBvxacEwJXjoZkOx9Zt7iOJgsv1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="369773478"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="369773478"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 07:23:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="847713172"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="847713172"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 18 Jul 2023 07:23:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLlbu-00GxaK-0l;
        Tue, 18 Jul 2023 17:23:30 +0300
Date:   Tue, 18 Jul 2023 17:23:30 +0300
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
Subject: Re: [PATCH 3/3] platform/x86: Move all simatic ipc drivers to the
 subdirectory siemens
Message-ID: <ZLagYgJT4cz4jZ5r@smile.fi.intel.com>
References: <20230718105213.1275-1-henning.schild@siemens.com>
 <20230718105213.1275-4-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718105213.1275-4-henning.schild@siemens.com>
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

On Tue, Jul 18, 2023 at 12:52:13PM +0200, Henning Schild wrote:
> Users without a Siemens Simatic IPC will not care about any of these
> drivers. Users who do care can enable the submenu and all drivers behind
> it will be enabled.

...

>  # Siemens Simatic Industrial PCs
> +obj-$(CONFIG_X86_PLATFORM_DRIVERS_SIEMENS)		+= siemens/

Do you need conditional here? We have stumbled over similar for entire intel
subfolder, it might affect the rest as well when you don't expect it.

obj-y		+= siemens/

?

-- 
With Best Regards,
Andy Shevchenko


