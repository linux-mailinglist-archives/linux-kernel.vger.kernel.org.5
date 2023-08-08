Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A0F774B37
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbjHHUnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjHHUmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:42:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B6F30649;
        Tue,  8 Aug 2023 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691512295; x=1723048295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3kMxtGAvDPkK4F3TpfsG8UCh09kcYntOEJTiDXbHYrs=;
  b=PXJIoTOyp0tkdAjaq7sdDUtXLR3OzHC5hKL8ygeHxVPEypDz6JRiKxKr
   psAyCD3E6FxGfw82DpAJE8fEMVPA/hAuu2t1WPvgp8ykT4BYxcvtH7jG5
   du8gkXLjop1rlS+qhHROhBuADNnLd5bv1PtHbiGNmvZP9hn2fwn/R1zjO
   8RGkX8odhDyAg9aqe5V1Kk2IOPgEbORQoMjmG6F53cCkebY8sFEXCc13G
   +YDR3JNyCFaq4/k/cbuBSri6tpqNAicZqbCOgRHB/yhQqcEt8li8ijkg4
   mflbhY4nQezcYZq8SSgH5nrfTmRZEhezVLt01GTbp0X3FBnv77ujAGiln
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401778751"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="401778751"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:09:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1062012420"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="1062012420"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2023 06:09:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTMSv-0097tU-2f;
        Tue, 08 Aug 2023 16:09:37 +0300
Date:   Tue, 8 Aug 2023 16:09:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] pinctrl: nsp-gpio:  Silence probe deferral messages
Message-ID: <ZNI+kdwRpeFLOQVq@smile.fi.intel.com>
References: <20230807213022.1862903-1-florian.fainelli@broadcom.com>
 <20230807213022.1862903-3-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807213022.1862903-3-florian.fainelli@broadcom.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 02:30:22PM -0700, Florian Fainelli wrote:
> We can have gpiochip_add_data() return -EPROBE_DEFER which will make
> us produce the "unable to add GPIO chip" message which is confusing.
> Use dev_err_probe() to silence probe deferral messages.

The same.

-- 
With Best Regards,
Andy Shevchenko


